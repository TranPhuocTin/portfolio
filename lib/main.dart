import 'package:flutter/material.dart';
import 'package:portfolio/constants/app_colors.dart';
import 'package:portfolio/screens/home_screen.dart';
import 'package:portfolio/screens/project_detail_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:portfolio/constants/app_constants.dart';

void main() {
  // Configure to use pure URL paths instead of hash (#)
  setUrlStrategy(PathUrlStrategy());
  
  runApp(const MyApp());
}

// Configure GoRouter
final GoRouter _router = GoRouter(
  routes: [
    // Home page
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    
    // Project detail page
    GoRoute(
      path: '/project/:id',
      name: 'project-detail',
      builder: (context, state) {
        final projectId = state.pathParameters['id']!;
        final projectData = state.extra as Map<String, dynamic>?;
        
        // When navigating from home page, we've passed data via extra
        if (projectData != null) {
          return ProjectDetailScreen(project: projectData);
        }
        
        // Find project from id in the known project list
        final projectFromId = _findProjectById(projectId);
        if (projectFromId != null) {
          return ProjectDetailScreen(project: projectFromId);
        }
        
        // Return to home page if not found
        return const HomeScreen();
      },
    ),
  ],
  // Handle non-existent URLs
  errorBuilder: (context, state) => const HomeScreen(),
);

// Helper function to find project from slug
Map<String, dynamic>? _findProjectById(String id) {
  final normalizedId = id.toLowerCase();
  
  for (final project in AppConstants.projects) {
    final projectTitle = project['title'].toString().toLowerCase().replaceAll(' ', '-');
    if (projectTitle == normalizedId) {
      return project;
    }
  }
  
  return null;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
      routerConfig: _router,
    );
  }
}
