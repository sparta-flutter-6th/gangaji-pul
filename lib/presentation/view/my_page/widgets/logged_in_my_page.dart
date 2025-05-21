import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/presentation/providers/auth_state_provider.dart';
import 'package:gangaji_pul/presentation/view/_widgets/load_profile_image.dart';
import 'package:gangaji_pul/presentation/view_model/user_view_model.dart';

class LoggedInMyPage extends ConsumerWidget {
  const LoggedInMyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userStreamProvider);
    final userService = ref.read(userServiceProvider);

    return userAsync.when(
      data: (user) {
        if (user == null) {
          return const Center(child: Text('사용자 정보를 불러올 수 없습니다.'));
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
          child: Column(
            children: [
              // 테스트용 로그아웃 버튼
              IconButton(
                onPressed: () => userService.signOut(),
                icon: const Icon(Icons.delete),
              ),
              Row(
                children: [
                  LoadProfileImage(uid: user.uid, size: 100),
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
                      Icon(Icons.pets, size: 30, color: Color(0XFF332121)),
                      Text(
                        '${user.postCount}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      Icon(Icons.favorite, size: 30, color: Colors.red),
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
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) {
        userService.signOut();
        return Center(child: Text('에러 발생: $error'));
      },
    );
  }
}
