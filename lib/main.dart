import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = true;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '403',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,

      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(
              isDarkMode: _isDarkMode,
              onToggleTheme: _toggleTheme,
            ),
        '/signup': (context) => SignUpScreen(
              isDarkMode: _isDarkMode,
              onToggleTheme: _toggleTheme,
            ),
        '/home': (context) => HomeScreen(
              isDarkMode: _isDarkMode,
              onToggleTheme: _toggleTheme,
            ),
      },
    );
  }
}
