import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/data/providers/post_repository_provider.dart';
import 'package:gangaji_pul/domain/entity/post_view_entity.dart';

class HomePageViewModel extends Notifier<List<PostViewEntity>> {
  @override
  List<PostViewEntity> build() => [];

  Future<void> fetchPost() async {
    log("fetchPost on Viewmodel");
    final newPost = await ref.read(postRepositoryProvider).getPost();
    state = [...state, newPost];
  }
}

final homePageViewModel = NotifierProvider<HomePageViewModel, List<PostViewEntity>>(() => HomePageViewModel());
