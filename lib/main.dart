import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/weather_controller.dart';
import 'views/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherController(),
      child: MaterialApp(
        title: 'My Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Bookman Old Style',
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Bookman Old Style',
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Color(0xFF121212),
        ),
        themeMode: ThemeMode.system,
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}