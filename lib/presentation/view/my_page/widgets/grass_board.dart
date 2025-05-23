import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/domain/entity/user_model.dart';

class GrassBoard extends ConsumerWidget {
  const GrassBoard({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        child: GridView.builder(
          itemCount: 28,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 10,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            return SizedBox(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      'assets/images/grass.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  user.postCount > index
                      ? Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/footprint.png',
                          color: Colors.black87,
                        ),
                      )
                      : const SizedBox(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
