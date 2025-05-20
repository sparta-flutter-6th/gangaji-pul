import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationShell extends StatelessWidget {
  final Widget child;

  const BottomNavigationShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    int currentIndex = 0;
    if (location.startsWith('/mypage')) {
      currentIndex = 1;
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/mypage');
              break;
          }
        },
        backgroundColor: const Color(0xFFB1D182),
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [BottomNavigationBarItem(icon: Icon(Icons.home), label: ''), BottomNavigationBarItem(icon: Icon(Icons.person), label: '')],
      ),
    );
  }
}
