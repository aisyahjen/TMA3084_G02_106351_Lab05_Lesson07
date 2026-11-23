import 'package:flutter/material.dart';

class SchoolScreen extends StatelessWidget {
  const SchoolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.school, size: 80, color: Colors.purple),
          SizedBox(height: 16),
          Text('School Screen', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
