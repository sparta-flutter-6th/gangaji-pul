import 'package:flutter/material.dart';

class LoggedInMyPage extends StatelessWidget {
  const LoggedInMyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFEAE3C0),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0XFF7C5C42),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(Icons.camera_alt, size: 50, color: Colors.grey),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'name',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'email',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Icon(Icons.pets, size: 30, color: Color(0XFF332121)),
                    Text('0', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    Icon(Icons.favorite, size: 30, color: Colors.red),
                    Text('0', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image.asset('assets/image/grass.png', fit: BoxFit.cover),
            ),
          ],
        ),
      ),
    );
  }
}
