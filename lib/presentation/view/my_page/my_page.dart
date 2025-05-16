import 'package:flutter/material.dart';
import 'package:gangaji_pul/presentation/view/my_page/widgets/guest_my_page.dart';
import 'package:gangaji_pul/presentation/view/my_page/widgets/logged_in_my_page.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GuestMyPage();
  }
}
