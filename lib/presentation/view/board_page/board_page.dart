import 'package:flutter/material.dart';

class BoardPage extends StatelessWidget {
  const BoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF131C36),
        title: const Text('수익랭킹', style: TextStyle(color: Colors.white)),
        actions: [IconButton(icon: const Icon(Icons.more_horiz, color: Colors.white), onPressed: () {})],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('25/05/19 기준', style: TextStyle(color: Colors.white.withOpacity(0.7))),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildRankingCard(),
          const SizedBox(height: 20),
          _buildRealtimeTalkHeader(),
          const SizedBox(height: 12),
          _buildCommentInput(),
          const SizedBox(height: 10),
          _buildNotice(),
          const SizedBox(height: 20),
          _buildCommentCard(),
        ],
      ),
    );
  }

  Widget _buildRankingCard() {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFF131C36), borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Text("수익률", style: TextStyle(color: Colors.white)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(12)),
                child: const Text("1", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 8),
              const CircleAvatar(radius: 20, backgroundImage: AssetImage('assets/avatar.png')),
              const SizedBox(width: 8),
              const Text("pigbong", style: TextStyle(color: Colors.white)),
              const Spacer(),
              const Text("204.33%", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ...List.generate(
                6,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: CircleAvatar(radius: 12, backgroundImage: AssetImage('assets/avatar.png')),
                ),
              ),
              const Spacer(),
              const Text("865명 수익중", style: TextStyle(color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRealtimeTalkHeader() {
    return const Text("실시간 톡 3,734개", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget _buildCommentInput() {
    return TextField(
      decoration: InputDecoration(
        hintText: "의견을 남겨보세요",
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildNotice() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFEFF2F5), borderRadius: BorderRadius.circular(8)),
      child: const Row(
        children: [Icon(Icons.warning_amber_rounded, color: Colors.orange), SizedBox(width: 8), Expanded(child: Text("글 작성시 커뮤니티 운영정책을 지켜주세요!"))],
      ),
    );
  }

  Widget _buildCommentCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 16, backgroundImage: AssetImage('assets/avatar.png')),
              const SizedBox(width: 8),
              const Text("자연엄개미", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              const Text("주주", style: TextStyle(color: Colors.orange)),
              const Spacer(),
              const Text("-5.09%", style: TextStyle(color: Colors.red)),
            ],
          ),
          const SizedBox(height: 8),
          const Text("아 저번주까진 좋았잖아 우리 왜 또 떨어지는데 나 언제 풀으라고...ㅠㅠ"),
          const SizedBox(height: 4),
          Text("1일 전", style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
        ],
      ),
    );
  }
}
