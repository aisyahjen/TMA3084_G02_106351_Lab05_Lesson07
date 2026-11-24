# 4.2 AI-Generated Diff

**AI Tool:** Claude
**File:** `lab_a/lib/main.dart`

## Original AI Diff

--- a/lib/main.dart
+++ b/lib/main.dart
@@ -1,4 +1,5 @@
 import 'package:flutter/material.dart';
+import 'package:provider/provider.dart';
 
 
 import 'screen1.dart';
@@ -6,6 +7,17 @@
 import 'screen3.dart';
 import 'screen4.dart';
 
+class TabModel extends ChangeNotifier {
+  int currentIndex = 0;
+
+  void selectTab(int index) {
+    currentIndex = index;
+    notifyListeners();
+  }
+}
+
+
 void main() => runApp(const MyApp());
 
 
@@ -15,6 +27,9 @@ class MyApp extends StatelessWidget {
 
   @override
   Widget build(BuildContext context) {
+    return ChangeNotifierProvider(
+      create: (_) => TabModel(),
+      child: MaterialApp(
-    return MaterialApp(
       debugShowCheckedModeBanner: false,
       theme: ThemeData(colorSchemeSeed: Colors.pink, useMaterial3: true),
       home: const BottomNavLab(),
@@ -22,17 +37,13 @@ class MyApp extends StatelessWidget {
   }
 }
 
-
-class BottomNavLab extends StatefulWidget {
+class BottomNavLab extends StatelessWidget {
   const BottomNavLab({super.key});
 
-
-  @override
-  State<BottomNavLab> createState() => _BottomNavLabState();
-}
-
-
-class _BottomNavLabState extends State<BottomNavLab> {
-  int currentIndex = 0;
-
+  @override
+  Widget build(BuildContext context) {
+    final currentIndex = context.watch<TabModel>().currentIndex;
 
   final List<Widget> screens = const [
     Screen1(),
@@ -42,9 +53,6 @@ class _BottomNavLabState extends State<BottomNavLab> {
   ];
 
 
-  @override
-  Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: const Color(0xFFFFF0F5), // Lavender blush pink
       appBar: AppBar(
@@ -65,7 +73,7 @@ class _BottomNavLabState extends State<BottomNavLab> {
         selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
         currentIndex: currentIndex,
-        onTap: (index) => setState(() => currentIndex = index),
+        onTap: (index) => context.read<TabModel>().selectTab(index),
         items: const [
           BottomNavigationBarItem(
             icon: Icon(Icons.home_rounded),
@@ -85,4 +93,5 @@ class _BottomNavLabState extends State<BottomNavLab> {
       ),
     );
   }
+  }
 }