import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 10,
        itemBuilder: (context, index) {
          return _chatCard();
        },
      ),
    );
  }

  Widget _chatCard() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(width: 30, height: 30, decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle)),
                const SizedBox(width: 8),
                const Text("일송", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 8),
            const Text("날씨가 좋아서 우리 강아지가 너무 좋아하네요^^"),
            const SizedBox(height: 4),
            Text("2분 전", style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
