import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gangaji_pul/data/repository/comment_repository_impl.dart';
import '../../../domain/repository/comment_repository.dart';

final commentRepositoryProvider = Provider<CommentRepository>((ref) => CommentRepositoryImpl(FirebaseFirestore.instance));
