import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/presentation/providers/post_like_view_model_provider.dart';

class PostLikeButton extends ConsumerStatefulWidget {
  const PostLikeButton({super.key, required this.postId});
  final String postId;

  @override
  ConsumerState<PostLikeButton> createState() => _PostLikeButtonState();
}

class _PostLikeButtonState extends ConsumerState<PostLikeButton> {
  late bool _isLike;

  @override
  void initState() {
    super.initState();

    final likeMap = ref.read(postLikeViewModelProvider);
    _isLike = likeMap[widget.postId] ?? false;

    if (!likeMap.containsKey(widget.postId)) {
      ref
          .read(postLikeViewModelProvider.notifier)
          .fetchLikeStatus(widget.postId);
    }
  }

  @override
  Widget build(BuildContext context) {
    _isLike = ref.watch(postLikeViewModelProvider)[widget.postId] ?? _isLike;

    return GestureDetector(
      onTap: () async {
        await ref
            .read(postLikeViewModelProvider.notifier)
            .toggleLike(widget.postId);
        setState(() {
          _isLike = !_isLike;
        });
      },
      child: Icon(
        _isLike ? Icons.favorite : Icons.favorite_border,
        size: 50,
        color: _isLike ? Colors.red : Colors.white,
      ),
    );
  }
}
