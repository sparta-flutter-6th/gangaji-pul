import 'package:flutter/material.dart';

class RankingProfile extends StatelessWidget {
  const RankingProfile({super.key, required this.ranking, required this.userName, required this.value});

  final int ranking;
  final String userName;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              width: _getSizebyRanking(ranking),
              height: _getSizebyRanking(ranking),
              decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
            ),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(color: _getMedalColorbyRanking(ranking), shape: BoxShape.circle),
              child: Center(child: Text(ranking.toString(), style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
            ),
          ],
        ),
        Padding(padding: const EdgeInsets.all(8.0), child: Text(userName, style: TextStyle(color: Colors.white, fontSize: 20))),
        Container(
          decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Text(value.toString(), style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ],
    );
  }

  Color _getMedalColorbyRanking(int ranking) {
    switch (ranking) {
      case 1:
        return Color(0xFFFFD700);
      case 2:
        return Color(0xFFC0C0C0);
      case 3:
        return Color(0xFFCD7F32);
      default:
        return Colors.white;
    }
  }

  double? _getSizebyRanking(int ranking) {
    switch (ranking) {
      case 1:
        return 90;
      case 2:
      case 3:
      default:
        return 70;
    }
  }
}
