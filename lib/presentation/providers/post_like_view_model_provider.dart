import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/presentation/view_model/post_like_view_model.dart';

final postLikeViewModelProvider = NotifierProvider<PostLikeViewModel, Map<String, bool>>(() => PostLikeViewModel());
