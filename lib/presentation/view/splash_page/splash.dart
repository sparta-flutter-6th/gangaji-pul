import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/presentation/providers/post_view_model_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    final postViewModel = ref.read(postViewModelProvider.notifier);

    await postViewModel.fetchPost();
    await postViewModel.fetchPost();

    await Future.delayed(const Duration(milliseconds: 1000));

    // if (mounted) {
    //   context.go('/home');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 배경 이미지
          Image.asset('assets/images/background.png', fit: BoxFit.cover),
          // 중앙 텍스트 + 개풀 이미지
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset('assets/images/gaepull.json', width: 180, height: 180, fit: BoxFit.fill),

                const Text(
                  '강아지풀',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF688F4E),
                    shadows: [Shadow(blurRadius: 4, color: Colors.black54)],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
