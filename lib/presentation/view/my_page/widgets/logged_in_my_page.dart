import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/presentation/providers/auth_state_provider.dart';
import 'package:gangaji_pul/presentation/view_model/user_view_model.dart';

class LoggedInMyPage extends ConsumerWidget {
  const LoggedInMyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userViewModelProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
      child: Column(
        children: [
          // 테스트용 로그아웃
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final userService = ref.read(userServiceProvider);
              return IconButton(
                onPressed: () {
                  userService.signOut();
                },
                icon: Icon(Icons.delete),
              );
            },
          ),
          Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0XFF7C5C42),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(Icons.camera_alt, size: 50, color: Colors.grey),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            user!.name,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        // 이메일에서 아이디만 추출
                        (user.email).split('@')[0],
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Icon(Icons.pets, size: 30, color: Color(0XFF332121)),
                  Text('0', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  Icon(Icons.favorite, size: 30, color: Colors.red),
                  Text('0', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 300,
            child: Image.asset('assets/image/grass.png', fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
