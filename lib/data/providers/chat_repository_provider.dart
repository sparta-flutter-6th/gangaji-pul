import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/data/providers/chat_data_source_provider.dart';
import 'package:gangaji_pul/data/repository/chat_repository_impl.dart';
import 'package:gangaji_pul/domain/repository/chat_repository.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) => ChatRepositoryImpl(ref.watch(chatDataSourceProvider)));
