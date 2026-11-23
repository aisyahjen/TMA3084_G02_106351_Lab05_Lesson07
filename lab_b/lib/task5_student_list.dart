import 'package:flutter/material.dart';

class Task5StudentListScreen extends StatefulWidget {
  const Task5StudentListScreen({super.key});

  @override
  State<Task5StudentListScreen> createState() => _Task5StudentListScreenState();
}

class _Task5StudentListScreenState extends State<Task5StudentListScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Student> _students = const [
    Student(name: 'Aisha Bello', matricNumber: 'STU001', cgpa: 3.72),
    Student(name: 'David Chen', matricNumber: 'STU002', cgpa: 3.28),
    Student(name: 'Fatima Yusuf', matricNumber: 'STU003', cgpa: 3.91),
    Student(name: 'James Okafor', matricNumber: 'STU004', cgpa: 3.45),
    Student(name: 'Maya Singh', matricNumber: 'STU005', cgpa: 3.58),
  ];

  String _searchQuery = '';
  bool _filterHighCgpa = false;

  List<Student> get _visibleStudents {
    final query = _searchQuery.toLowerCase();

    return _students.where((student) {
      final matchesSearch =
          student.name.toLowerCase().contains(query) ||
          student.matricNumber.toLowerCase().contains(query) ||
          student.cgpa.toStringAsFixed(2).contains(query);

      final matchesCgpa = !_filterHighCgpa || student.cgpa >= 3.50;
      return matchesSearch && matchesCgpa;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final students = _visibleStudents;

    return Scaffold(
      appBar: AppBar(title: const Text('Student List')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search students',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                suffixIcon: _searchQuery.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      ),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  setState(() => _filterHighCgpa = !_filterHighCgpa);
                },
                icon: Icon(
                  _filterHighCgpa ? Icons.check_circle : Icons.filter_list,
                ),
                label: Text(
                  _filterHighCgpa
                      ? 'Showing CGPA >= 3.50'
                      : 'Filter: CGPA >= 3.50',
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: students.isEmpty
                  ? const Center(child: Text('No students found.'))
                  : ListView.separated(
                      itemCount: students.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final student = students[index];
                        return ListTile(
                          leading: CircleAvatar(child: Text(student.name[0])),
                          title: Text(student.name),
                          subtitle: Text('Matric: ${student.matricNumber}'),
                          trailing: Text(
                            student.cgpa.toStringAsFixed(2),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class Student {
  const Student({
    required this.name,
    required this.matricNumber,
    required this.cgpa,
  });

  final String name;
  final String matricNumber;
  final double cgpa;
}
