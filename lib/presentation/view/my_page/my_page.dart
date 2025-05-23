import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/const/color_const.dart';
import 'package:gangaji_pul/presentation/providers/auth_state_provider.dart';
import 'package:gangaji_pul/presentation/view/my_page/widgets/guest_my_page.dart';
import 'package:gangaji_pul/presentation/view/my_page/widgets/logged_in_my_page.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final user = authState.asData?.value;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: user != null ? const LoggedInMyPage() : const GuestMyPage(),
    );
  }
}
