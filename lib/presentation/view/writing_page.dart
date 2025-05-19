import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WritingPage extends StatefulWidget {
  const WritingPage({super.key});

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  File? selectedImage;
  bool isImageValid = false; // AI 필터 통과 여부

  // 나중에 ViewModel로 분리 가능
  Future<void> pickAndValidateImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final image = File(picked.path);

    // 임시 분석 결과 (나중에 실제 API 연결)
    final result = await mockAnalyzeImage(image);

    final isDog = result['dog'] ?? false;
    final isGrass = result['grass'] ?? false;
    final isPerson = result['person'] ?? false;

    if (isDog && isGrass && !isPerson) {
      setState(() {
        selectedImage = image;
        isImageValid = true;
      });
    } else {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text("사진 조건 불충족"),
              content: const Text("강아지와 잔디가 있어야 하며, 사람이 나오면 안 됩니다."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("확인"),
                ),
              ],
            ),
      );
    }
  }

  Future<Map<String, bool>> mockAnalyzeImage(File image) async {
    await Future.delayed(const Duration(seconds: 1));
    return {'dog': true, 'grass': true, 'person': false};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('오늘의 산책 기록'),
        backgroundColor: Color(0xFFEAE3C0),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFEAE3C0),
          child: Column(
            children: [
              // 사진 영역
              GestureDetector(
                // onTap: () async {
                //   await pickAndValidateImage();
                // },
                onTap: () async {
                  final picker = ImagePicker();
                  final picked = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (picked == null) return;

                  final image = File(picked.path);
                  final result = await mockAnalyzeImage(image);

                  final isDog = result['dog'] ?? false;
                  final isGrass = result['grass'] ?? false;
                  final isPerson = result['person'] ?? false;

                  if (isDog && isGrass && !isPerson) {
                    setState(() {
                      selectedImage = image;
                      isImageValid = true;
                    });
                  } else {
                    setState(() {
                      isImageValid = false;
                    });
                    showDialog(
                      context: context,
                      builder:
                          (_) => AlertDialog(
                            title: const Text("사진 조건 불충족"),
                            content: const Text(
                              "강아지와 잔디가 있어야 하며, 사람은 나오면 안 됩니다.",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("확인"),
                              ),
                            ],
                          ),
                    );
                  }
                },

                child: Container(
                  height: 220,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child:
                      selectedImage != null
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              selectedImage!,
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
              ),

              // 입력 영역
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('태그', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '#태그를 입력해주세요',
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Text('내용입력', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 12),
                    TextField(
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
      //고정 버튼
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          color: Color(0xFFF4F1E9),
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed:
                isImageValid
                    ? () {
                      // 저장 로직
                    }
                    : null, // 조건 미충족 시 비활성화
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF8B6B4F),
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
