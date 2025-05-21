import 'package:flutter/material.dart';
import 'package:gangaji_pul/const/color_const.dart';
import 'package:gangaji_pul/presentation/view/board_page/widget/chat_input.dart';
import 'package:gangaji_pul/presentation/view/board_page/widget/chat_list.dart';
import 'package:gangaji_pul/presentation/view/board_page/widget/ranking_board.dart';

class BoardPage extends StatelessWidget {
  const BoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(backgroundColor: accentGreenColor, title: const Text('커뮤니티', style: TextStyle(color: Colors.white))),
      body: Column(children: [RankingBoard(), _buildNotice(), const SizedBox(height: 12), ChatList(), ChatInput()]),
    );
  }

  Widget _buildNotice() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color.fromARGB(255, 226, 227, 228)),
      child: const Row(
        children: [Icon(Icons.warning_amber_rounded, color: Colors.orange), SizedBox(width: 8), Expanded(child: Text("글 작성시 커뮤니티 운영정책을 지켜주세요!"))],
      ),
    );
  }
}
