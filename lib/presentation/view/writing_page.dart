import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/const/color_const.dart';
import 'package:gangaji_pul/domain/entity/user_model.dart';
import 'package:gangaji_pul/presentation/common/custom_snackbar.dart';
import 'package:gangaji_pul/presentation/view_model/yolo_view_model.dart';
import 'package:gangaji_pul/presentation/view_model/post_submission_view_model.dart';
import 'package:gangaji_pul/presentation/view_model/user_view_model.dart';

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
    setState(() => yolo.isLoading = true);
    final isValid = await yolo.pickAndValidateImage();
    setState(() => yolo.isLoading = false);

    if (!isValid) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(title: Text("강아지 사진을 업로드해주세요🐾🐾", style: TextStyle(fontSize: 15)), content: Text("(사람 사진을 업로드할 수 없습니다)")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final postSubmission = ref.read(postSubmissionViewModelProvider);
    final rawUser = ref.watch(userStreamProvider).asData?.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('오늘의 산책 기록', style: TextStyle(fontSize: 17)),
        backgroundColor: backgroundColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
            color: backgroundColor,
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
                        child:
                            yolo.selectedImage != null
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
                      if (yolo.isLoading)
                        const CircularProgressIndicator(
                          color: normalBrownColor,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.pets,
                            size: 18,
                            color: normalBrownColor,
                          ),
                          SizedBox(width: 5),
                          Text('태그', style: TextStyle(fontSize: 14)),
                          SizedBox(width: 6),
                        ],
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _tagController,
                        onChanged: (text) {
                          setState(() {
                            _tags =
                                text
                                    .split(RegExp(r'\s+'))
                                    .where((tag) => tag.isNotEmpty)
                                    .toList();
                          });
                        },
                        style: const TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                          hintText: '공백으로 구분해서 태그를 입력하세요',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: accentGreenColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                      Row(
                        children: const [
                          Icon(
                            Icons.pets,
                            size: 18,
                            color: normalBrownColor,
                          ),
                          SizedBox(width: 5),
                          Text('내용입력', style: TextStyle(fontSize: 14)),
                          SizedBox(width: 6),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _contentController,
                        maxLines: 10,
                        maxLength: 200,
                        style: const TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                          hintText: '오늘의 이야기를 입력하세요',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: accentGreenColor,
                              width: 2,
                            ),
                          ),
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
      ),
      bottomNavigationBar: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            onPressed:
                yolo.isImageValid
                    ? () async {
                      final content = _contentController.text.trim();

                      try {
                        await postSubmission.createPost(content: content, tags: _tags, imageFile: yolo.selectedImage!, user: rawUser!);

                        if (context.mounted) {
                          Navigator.pop(context);
                          showCustomSnackBar(context, '업로드 완료!');
                        }
                      } catch (e) {
                        showCustomSnackBar(context, '업로드 실패 😢');
                      }
                    }
                    : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: normalBrownColor,
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
