import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/domain/entity/post_view_entity.dart';
import 'package:gangaji_pul/presentation/view_model/home_page_view_model.dart';

final homePageViewModel = NotifierProvider<HomePageViewModel, List<PostViewEntity>>(() => HomePageViewModel());
