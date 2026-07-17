import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/theme_cubit.dart';
import 'cubits/auth_cubit.dart';
import 'cubits/auth_state.dart';
import 'cubits/product_cubit.dart';
import 'services/product_service.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => ProductCubit(ProductService())),
      ],
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            navigatorKey.currentState?.pushReplacementNamed('/home');
          } else if (state is AuthInitial) {
            navigatorKey.currentState?.pushNamedAndRemoveUntil(
              '/login',
              (route) => false,
            );
          }
        },
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              navigatorKey: navigatorKey,
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
              themeMode: themeMode,
              initialRoute: '/login',
              routes: {
                '/login': (context) => const LoginScreen(),
                '/signup': (context) => const SignUpScreen(),
                '/home': (context) => const HomeScreen(),
              },
            );
          },
        ),
      ),
    );
  }
}
