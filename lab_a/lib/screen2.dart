import 'package:flutter/material.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.alarm, size: 80, color: Colors.orange),
          SizedBox(height: 16),
          Text('Alarm Screen', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
