import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadProfileImage extends ConsumerWidget {
  const LoadProfileImage({super.key, required this.uid, required this.size});

  final String uid;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _loadingWidget();
        }

        if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
          return _defaultImage();
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final imageUrl = data['profileImageUrl'] as String?;

        if (imageUrl == null || imageUrl.isEmpty) {
          return _defaultImage();
        }

        return ClipOval(
          child: Image.network(
            imageUrl,
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  Widget _defaultImage() {
    return ClipOval(
      child: Image.asset(
        'assets/image/default_profile.png', // 기본 이미지 경로
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _loadingWidget() {
    return SizedBox(
      width: size,
      height: size,
      child: const CircularProgressIndicator(),
    );
  }
}
