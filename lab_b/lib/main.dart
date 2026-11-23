import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class Car {
  Car(this.make, this.model, this.price);
  final String make;
  final int model;
  final int price;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.pink, useMaterial3: true),
      home: const CarTablePage(),
    );
  }
}

class CarTablePage extends StatefulWidget {
  const CarTablePage({super.key});

  @override
  State<CarTablePage> createState() => _CarTablePageState();
}

class _CarTablePageState extends State<CarTablePage> {
  final List<Car> cars = [
    Car('Honda', 2021, 35000),
    Car('Toyota', 2011, 6000),
    Car('BMW', 2010, 9000),
  ];

  int? sortColumnIndex;
  bool sortAscending = true;

  void sortBy(
    int columnIndex,
    bool ascending,
    int Function(Car a, Car b) compare,
  ) {
    setState(() {
      cars.sort((a, b) => ascending ? compare(a, b) : compare(b, a));
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F8),
      appBar: AppBar(
        title: const Text(
          'DataTable Sorting',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pink.shade400,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.pink.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: DataTable(
              sortColumnIndex: sortColumnIndex,
              sortAscending: sortAscending,
              border: TableBorder.all(color: Colors.pink.shade200),
              headingRowColor: WidgetStateProperty.all<Color>(
                Colors.pink.shade100,
              ),
              headingTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade900,
                fontSize: 15,
              ),
              columns: [
                DataColumn(
                  label: const Text('Car Make'),
                  onSort: (i, asc) =>
                      sortBy(i, asc, (a, b) => a.make.compareTo(b.make)),
                ),
                DataColumn(
                  label: const Text('Model'),
                  numeric: true,
                  onSort: (i, asc) =>
                      sortBy(i, asc, (a, b) => a.model.compareTo(b.model)),
                ),
                DataColumn(
                  label: const Text('Price'),
                  numeric: true,
                  onSort: (i, asc) =>
                      sortBy(i, asc, (a, b) => a.price.compareTo(b.price)),
                ),
              ],
              rows: [
                for (int index = 0; index < cars.length; index++)
                  DataRow(
                    color: WidgetStateProperty.all<Color>(
                      index.isEven ? Colors.white : const Color(0xFFFFF0F5),
                    ),
                    cells: [
                      DataCell(
                        Text(
                          cars[index].make,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.pink.shade800,
                          ),
                        ),
                      ),
                      DataCell(Text('${cars[index].model}')),
                      DataCell(Text('${cars[index].price}')),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
