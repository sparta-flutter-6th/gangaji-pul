import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gangaji_pul/service/auth/sign_in_with_google.dart';

class GuestMyPage extends StatelessWidget {
  const GuestMyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFEAE3C0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.scale(
                scale: 0.7,
                child: Image.asset('assets/image/dog.png'),
              ),
              Text(
                '반려가족들과 소통하고, 우리만의 공간을 만들어보세요',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () async {
                  final userCredential = await signInWithGoogle();

                  if (userCredential != null) {
                    log("로그인 성공: ${userCredential.user?.displayName}");
                    // 로그인 성공 시 화면 전환이나 상태 업데이트 등
                  } else {
                    log("로그인 취소 또는 실패");
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Color(0XFF7C5C42),
                  foregroundColor: Color(0XFFEAE3C0),
                  minimumSize: Size.fromHeight(50),
                ),
                child: Text('로그인', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
