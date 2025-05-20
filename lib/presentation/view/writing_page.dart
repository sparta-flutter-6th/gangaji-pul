import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gangaji_pul/presentation/view_model/writing_view_model.dart';

class WritingPage extends StatefulWidget {
  const WritingPage({super.key});

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  final WritingViewModel viewModel = WritingViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  Future<void> handlePickImage() async {
    setState(() {
      viewModel.isLoading = true;
    });

    final isValid = await viewModel.pickAndValidateImage();

    setState(() {
      viewModel.isLoading = false;
    });

    if (!isValid) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text("강아지 사진을 업로드해주세요🐾🐾",
        style: TextStyle(fontSize: 15),
          ),
          content: Text("(사람 사진을 업로드할 수 없습니다)"),
        ),
      );
    } else {
      setState(() {}); // 선택된 이미지 갱신
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      child: viewModel.selectedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                viewModel.selectedImage!,
                                width: double.infinity,
                                height: 220,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_a_photo,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    '사진 선택하기',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    if (viewModel.isLoading)
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
                      controller: viewModel.tagController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '#태그를 입력해주세요',
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text('내용입력', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 12),
                    TextField(
                      controller: viewModel.contentController,
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
            onPressed: viewModel.isImageValid
                ? () {
                    final tags = viewModel.tagController.text.trim();
                    final content = viewModel.contentController.text.trim();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("등록 준비 완료")),
                    );
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
