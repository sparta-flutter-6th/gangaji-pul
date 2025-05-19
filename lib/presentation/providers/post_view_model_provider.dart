import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/domain/entity/post_view_entity.dart';
import 'package:gangaji_pul/presentation/view_model/post_view_model.dart';

final postViewModelProvider =
    NotifierProvider<PostViewModel, List<PostViewEntity>>(
      () => PostViewModel(),
    );
