import 'package:flutter/material.dart';

class PostInfoColumn extends StatelessWidget {
  const PostInfoColumn({super.key, required this.id, required this.dateTime, required this.content, required this.hashTag});
  final String id;
  final String dateTime;
  final String content;
  final List<String> hashTag;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(id, style: TextStyle(color: Colors.white, fontSize: 30)),
            SizedBox(width: 10),
            Text(dateTime, style: TextStyle(color: Colors.white, fontSize: 15)),
          ],
        ),
        Text(content, style: TextStyle(color: Colors.white, fontSize: 25)),
        Text(hashTag.map((e) => '#$e').join(), style: TextStyle(color: Colors.white, fontSize: 18)),
      ],
    );
  }
}
