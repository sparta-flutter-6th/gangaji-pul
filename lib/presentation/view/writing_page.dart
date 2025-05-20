import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/presentation/view_model/yolo_view_model.dart';
import 'package:gangaji_pul/presentation/view_model/post_submission_view_model.dart';

class WritingPage extends ConsumerStatefulWidget {
  const WritingPage({super.key});

  @override
  ConsumerState<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends ConsumerState<WritingPage> {
  final YoloViewModel yolo = YoloViewModel();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  List<String> _tags = [];

  @override
  void initState() {
    super.initState();
    yolo.init();
  }

  Future<void> handlePickImage() async {
    setState(() {
      yolo.isLoading = true;
    });

    final isValid = await yolo.pickAndValidateImage();

    setState(() {
      yolo.isLoading = false;
    });

    if (!isValid) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text("강아지 사진을 업로드해주세요🐾🐾", style: TextStyle(fontSize: 15)),
          content: Text("(사람 사진을 업로드할 수 없습니다)"),
        ),
      );
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final postSubmission = ref.read(postSubmissionViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('오늘의 산책 기록'),
        backgroundColor: const Color(0xFFEAE3C0),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFEAE3C0),
          child: Column(
            children: [
              GestureDetector(
                onTap: handlePickImage,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 220,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromRGBO(0, 0, 0, 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: yolo.selectedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                yolo.selectedImage!,
                                width: double.infinity,
                                height: 220,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                                  SizedBox(height: 12),
                                  Text(
                                    '사진 선택하기',
                                    style: TextStyle(fontSize: 16, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    if (yolo.isLoading)
                      const CircularProgressIndicator(color: Colors.brown),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('태그', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _tagController,
                      onChanged: (text) {
                        setState(() {
                          _tags = text
                              .split(RegExp(r'\s+'))
                              .where((tag) => tag.isNotEmpty)
                              .toList();
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '공백으로 구분해서 태그를 입력하세요',
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text('내용입력', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _contentController,
                      maxLines: 10,
                      maxLength: 200,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '오늘의 이야기를 입력하세요',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          color: const Color(0xFFF4F1E9),
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: yolo.isImageValid
                ? () async {
                    final content = _contentController.text.trim();

                    try {
                      await postSubmission.createPost(
                        content: content,
                        tags: _tags,
                        imageFile: yolo.selectedImage!,
                      );

                      if (context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("업로드 완료!")),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("업로드 실패 😢")),
                      );
                    }
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B6B4F),
              disabledBackgroundColor: Colors.grey[400],
            ),
            child: const Text(
              '등록하기',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}
