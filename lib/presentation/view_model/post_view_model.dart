import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/data/providers/post_repository_provider.dart';
import 'package:gangaji_pul/domain/entity/post_view_entity.dart';
import 'package:gangaji_pul/service/provider/analytics_service_provider.dart';

class PostViewModel extends Notifier<List<PostViewEntity>> {
  @override
  List<PostViewEntity> build() => [];

  Future<void> fetchPost() async {
    log("fetchPost on Viewmodel");
    final newPost = await ref.read(postRepositoryProvider).getPost();
    await ref.read(analyticsServiceProvider).logApiCall("fetchPost");
    state = [...state, newPost];
  }
}
