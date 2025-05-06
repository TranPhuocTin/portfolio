import 'package:flutter/material.dart';
import 'package:portfolio/constants/app_colors.dart';
import 'package:portfolio/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: AppColors.secondaryColor,
          secondary: AppColors.secondaryColor,
          background: AppColors.backgroundColor,
          surface: AppColors.cardColor,
        ),
        scaffoldBackgroundColor: AppColors.backgroundColor,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: AppColors.textColor,
              displayColor: AppColors.textColor,
            ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
