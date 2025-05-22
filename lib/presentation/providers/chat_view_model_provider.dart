import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/domain/entity/chat_entity.dart';
import 'package:gangaji_pul/presentation/view_model/chat_view_model.dart';

final chatViewModelProvider = StreamNotifierProvider<ChatViewModel, List<Chat>>(ChatViewModel.new);
