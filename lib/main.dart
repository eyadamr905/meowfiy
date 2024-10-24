import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:music_fl/views/home.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meow',
      theme: ThemeData(
        fontFamily: "regular",
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: const Home(), // Set Home as the initial screen
      initialRoute: '/',  // You can define your initial route here
      getPages: [
        GetPage(name: '/', page: () => const Home()),
        // Add other pages/routes here for navigation if needed
        // GetPage(name: '/another', page: () => AnotherScreen()),
      ],
    );
  }
}
