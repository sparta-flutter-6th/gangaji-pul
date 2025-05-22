import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/const/color_const.dart';
import 'package:gangaji_pul/presentation/providers/auth_state_provider.dart';
import 'package:gangaji_pul/presentation/view/_widgets/load_profile_image.dart';
import 'package:gangaji_pul/presentation/view/my_page/widgets/grass_board.dart';
import 'package:gangaji_pul/presentation/view/_widgets/walk_alarm_card.dart';
import 'package:gangaji_pul/presentation/view_model/user_view_model.dart';

class LoggedInMyPage extends ConsumerWidget {
  const LoggedInMyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userStreamProvider);
    final authService = ref.read(authServiceProvider);

    return userAsync.when(
      data: (user) {
        if (user == null) {
          authService.signOut();
          return const Center(child: Text('사용자 정보를 불러올 수 없습니다.'));
        }

        return Scaffold(
          backgroundColor: const Color(0xFFEAE3C0),
          appBar: AppBar(
            backgroundColor: accentGreenColor,
            centerTitle: true,
            title: const Text('마이페이지', style: TextStyle(color: Colors.white)),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications, color: Colors.yellow[700]),
              ),
              IconButton(
                onPressed: () {
                  authService.signOut(); // 임시 로그아웃
                },
                icon: Icon(Icons.settings, color: Colors.grey[700]),
              ),
              const SizedBox(width: 4),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LoadProfileImage(user: user, size: 120),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            user.email.split('@')[0],
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Column(
                                children: [
                                  const Tooltip(
                                    message: '게시글 수',
                                    child: Icon(
                                      Icons.pets,
                                      size: 30,
                                      color: Color(0xFF332121),
                                    ),
                                  ),
                                  Text(
                                    '${user.postCount}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20),
                              Column(
                                children: [
                                  const Tooltip(
                                    message: '좋아요 수',
                                    child: Icon(
                                      Icons.favorite,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Text(
                                    '${user.likeCount}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                GrassBoard(user: user),
                const SizedBox(height: 10),
                Text(
                  '🔔산책 알림',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 10),
                const WalkAlarmSelector(),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) {
        authService.signOut();
        return Center(child: Text('에러 발생: $error'));
      },
    );
  }
}
