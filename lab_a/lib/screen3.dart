import 'package:flutter/material.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.business, size: 80, color: Colors.green),
          SizedBox(height: 16),
          Text('Business Screen', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
