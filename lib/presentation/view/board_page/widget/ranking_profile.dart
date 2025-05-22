import 'package:flutter/material.dart';
import 'package:gangaji_pul/domain/entity/rank_entity.dart';

class RankingProfile extends StatelessWidget {
  final ({String title, List<RankEntity>? rankEntries}) entry;

  const RankingProfile({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final title = entry.title;
    final rankEntries = entry.rankEntries;

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Padding(padding: const EdgeInsets.all(8.0), child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),

          if (rankEntries == null)
            const Padding(padding: EdgeInsets.symmetric(vertical: 40), child: CircularProgressIndicator())
          else if (rankEntries.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Text("아직 순위 정산 중입니다.\n조금만 더 화이팅해주세요!", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18)),
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children:
                  rankEntries.asMap().entries.map((entry) {
                    final index = entry.key;
                    final rankEntry = entry.value;
                    return _rankProfile(index + 1, rankEntry);
                  }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _rankProfile(int ranking, RankEntity entry) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              width: _getSizeByRanking(ranking),
              height: _getSizeByRanking(ranking),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child:
                  _isProfileImageUrlValid(entry.user.profileImageUrl)
                      ? Image.network(entry.user.profileImageUrl, fit: BoxFit.cover)
                      : const Icon(Icons.person),
            ),

            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(color: _getMedalColorByRanking(ranking), shape: BoxShape.circle),
              child: Center(child: Text(ranking.toString(), style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
            ),
          ],
        ),
        Padding(padding: const EdgeInsets.all(8.0), child: Text(entry.user.name, style: const TextStyle(color: Colors.white, fontSize: 20))),
        Container(
          decoration: BoxDecoration(color: Colors.black.withAlpha(50), borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(entry.value.toString(), style: const TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ],
    );
  }

  Color _getMedalColorByRanking(int ranking) {
    switch (ranking) {
      case 1:
        return const Color(0xFFFFD700);
      case 2:
        return const Color(0xFFC0C0C0);
      case 3:
        return const Color(0xFFCD7F32);
      default:
        return Colors.white;
    }
  }

  double _getSizeByRanking(int ranking) {
    switch (ranking) {
      case 1:
        return 90;
      case 2:
        return 80;
      case 3:
        return 70;
      default:
        return 70;
    }
  }

  bool _isProfileImageUrlValid(String? imageUrl) {
    return imageUrl != null && imageUrl.isNotEmpty;
  }
}
