import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/data/providers/post_like_repository_provider.dart';

class PostLikeViewModel extends Notifier<Map<String, bool>> {
  late String? uid;
  @override
  Map<String, bool> build() {
    uid = FirebaseAuth.instance.currentUser?.uid;
    return {};
  }

  Future<void> fetchLikeStatus(String postId) async {
    log("fetchLikeStatus on Viewmodel");
    if (uid == null) {
      return;
    }
    final isLiked = await ref.read(postLikeRepositoryProvider).isPostLikedByUser(postId, uid!);
    state = {...state, postId: isLiked};
  }

  Future<void> toggleLike(String postId) async {
    log("toggleLike on Viewmodel");
    if (uid == null) {
      return;
    }
    final currentLike = state[postId] ?? false;
    if (currentLike) {
      ref.read(postLikeRepositoryProvider).unlikePost(postId, uid!);
    } else {
      ref.read(postLikeRepositoryProvider).likePost(postId, uid!);
    }

    state = {...state, postId: !currentLike};
  }
}
