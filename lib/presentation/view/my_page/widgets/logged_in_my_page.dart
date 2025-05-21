import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/const/color_const.dart';
import 'package:gangaji_pul/presentation/providers/auth_state_provider.dart';
import 'package:gangaji_pul/presentation/view/_widgets/load_profile_image.dart';
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
          backgroundColor: Color(0xFFEAE3C0),
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
                  // 임시용 로그아웃
                  authService.signOut();
                },
                icon: Icon(Icons.settings, color: Colors.grey[700]),
              ),
              const SizedBox(width: 4),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    LoadProfileImage(user: user, size: 100),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
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
                            Text(
                              user.email.split('@')[0],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Tooltip(
                          message: '게시글 수',
                          child: Icon(
                            Icons.pets,
                            size: 30,
                            color: Color(0XFF332121),
                          ),
                        ),
                        Text(
                          '${user.postCount}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        Tooltip(
                          message: '좋아요 수',
                          child: Icon(
                            Icons.favorite,
                            size: 30,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          '${user.likeCount}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: Image.asset(
                    'assets/images/grass.png',
                    fit: BoxFit.cover,
                  ),
                ),
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
