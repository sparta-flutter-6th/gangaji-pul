import 'package:flutter/material.dart';
import 'package:gangaji_pul/presentation/view/home_page/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // 2초 후 자동으로 HomePage로 이동
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 배경 이미지
          Image.asset('assets/images/background.png', fit: BoxFit.cover),
          // 중앙 텍스트 + 개풀 이미지
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'gaepull',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF688F4E),
                    shadows: [Shadow(blurRadius: 4, color: Colors.black54)],
                  ),
                ),

                Image.asset(
                  'assets/images/gaepull.png',
                  width: 180,
                  height: 180,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
