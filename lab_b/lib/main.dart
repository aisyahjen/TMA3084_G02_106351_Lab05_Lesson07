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
      title: 'Sortable Car Table',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CarTablePage(),
    );
  }
}

class Car {
  const Car({required this.make, required this.model, required this.price});

  final String make;
  final String model;
  final double price;
}

class CarTablePage extends StatefulWidget {
  const CarTablePage({super.key});

  @override
  State<CarTablePage> createState() => _CarTablePageState();
}

class _CarTablePageState extends State<CarTablePage> {
  final List<Car> _cars = [
    const Car(make: 'Toyota', model: 'Corolla', price: 22000),
    const Car(make: 'Honda', model: 'Civic', price: 25000),
    const Car(make: 'Ford', model: 'Mustang', price: 42000),
    const Car(make: 'Tesla', model: 'Model 3', price: 39000),
    const Car(make: 'BMW', model: '3 Series', price: 45000),
  ];

  int? _sortColumnIndex;
  bool _sortAscending = true;

  void _sortCars(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;

      _cars.sort((first, second) {
        int comparison;

        if (columnIndex == 0) {
          comparison = first.make.compareTo(second.make);
        } else if (columnIndex == 1) {
          comparison = first.model.compareTo(second.model);
        } else {
          comparison = first.price.compareTo(second.price);
        }

        return ascending ? comparison : -comparison;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Prices'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            columns: [
              DataColumn(label: const Text('Car Make'), onSort: _sortCars),
              DataColumn(label: const Text('Model'), onSort: _sortCars),
              DataColumn(
                label: const Text('Price'),
                numeric: true,
                onSort: _sortCars,
              ),
            ],
            rows: _cars.map((car) {
              return DataRow(
                cells: [
                  DataCell(Text(car.make)),
                  DataCell(Text(car.model)),
                  DataCell(Text('\$${car.price.toStringAsFixed(2)}')),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
