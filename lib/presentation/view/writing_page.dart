import 'package:flutter/material.dart';

class WritingPage extends StatelessWidget {
  const WritingPage({super.key});

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
                onTap: () {
                  // 나중에 사진 선택 로직 추가 예정
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
                  child: const Center(
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
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF8B6B4F)),
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
