import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key, required this.isFavorite});
  final bool isFavorite;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // 좋아요 api 요청
          _isFavorite = !_isFavorite;
        });
      },
      child: _isFavorite ? Icon(Icons.favorite, size: 50, color: Colors.red) : Icon(Icons.favorite_border, size: 50, color: Colors.white),
    );
  }
}
