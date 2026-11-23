import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DataTable Sorting',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pinkAccent,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const CarDataTableScreen(),
    );
  }
}

class Car {
  final String make;
  final String model;
  final int price;
  final Color badgeColor;

  Car({
    required this.make,
    required this.model,
    required this.price,
    required this.badgeColor,
  });
}

class CarDataTableScreen extends StatefulWidget {
  const CarDataTableScreen({super.key});

  @override
  State<CarDataTableScreen> createState() => _CarDataTableScreenState();
}

class _CarDataTableScreenState extends State<CarDataTableScreen> {
  int? _sortColumnIndex;
  bool _sortAscending = true;

  final List<Car> _cars = [
    Car(make: 'Toyota', model: 'Vios', price: 89600, badgeColor: Colors.pink),
    Car(
      make: 'Perodua',
      model: 'Myvi',
      price: 59900,
      badgeColor: Colors.purple,
    ),
    Car(make: 'Honda', model: 'Civic', price: 131900, badgeColor: Colors.teal),
    Car(make: 'Proton', model: 'X50', price: 113300, badgeColor: Colors.orange),
    Car(make: 'Mazda', model: 'CX-5', price: 148700, badgeColor: Colors.indigo),
  ];

  void _onSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;

      _cars.sort((a, b) {
        int result;
        switch (columnIndex) {
          case 0:
            result = a.make.compareTo(b.make);
            break;
          case 1:
            result = a.model.compareTo(b.model);
            break;
          case 2:
            result = a.price.compareTo(b.price);
            break;
          default:
            result = 0;
        }
        return ascending ? result : -result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F8),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
        title: const Text(
          'DataTable Sorting',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: DataTable(
                sortColumnIndex: _sortColumnIndex,
                sortAscending: _sortAscending,
                headingRowColor: WidgetStateProperty.all(
                  const Color(0xFFFFD6E7),
                ),
                headingTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF880E4F),
                  fontSize: 15,
                ),
                columns: [
                  DataColumn(
                    label: const Text('Car Make'),
                    onSort: (columnIndex, ascending) =>
                        _onSort(columnIndex, ascending),
                  ),
                  DataColumn(
                    label: const Text('Model'),
                    onSort: (columnIndex, ascending) =>
                        _onSort(columnIndex, ascending),
                  ),
                  DataColumn(
                    label: const Text('Price (RM)'),
                    numeric: true,
                    onSort: (columnIndex, ascending) =>
                        _onSort(columnIndex, ascending),
                  ),
                ],
                rows: List.generate(_cars.length, (index) {
                  final car = _cars[index];
                  final rowColor = index.isEven
                      ? const Color(0xFFFFF9FB)
                      : const Color(0xFFF8F0FF);

                  return DataRow(
                    color: WidgetStateProperty.all(rowColor),
                    cells: [
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 6,
                              backgroundColor: car.badgeColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              car.make,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      DataCell(Text(car.model)),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: car.badgeColor.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'RM ${car.price}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: car.badgeColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
