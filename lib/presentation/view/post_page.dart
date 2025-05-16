import 'package:flutter/material.dart';
import 'package:gangaji_pul/presentation/view/bottom_nav_bar.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('글 작성'),

      /// 현재 페이지 입력 >> 0:홈페이지 1:게시글 작성 2:마이페이지
      bottomNavigationBar: BottomNavBar(currentIndex: 1),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
