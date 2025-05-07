import 'package:flutter/material.dart';
import 'package:portfolio/constants/app_colors.dart';
import 'package:portfolio/screens/home_screen.dart';
import 'package:portfolio/screens/project_detail_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:portfolio/constants/app_constants.dart';

void main() {
  // Cấu hình sử dụng URL path thuần túy thay vì hash (#)
  setUrlStrategy(PathUrlStrategy());
  
  runApp(const MyApp());
}

// Cấu hình GoRouter
final GoRouter _router = GoRouter(
  routes: [
    // Trang chính
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    
    // Trang chi tiết dự án
    GoRoute(
      path: '/project/:id',
      name: 'project-detail',
      builder: (context, state) {
        final projectId = state.pathParameters['id']!;
        final projectData = state.extra as Map<String, dynamic>?;
        
        // Trường hợp điều hướng từ trang chủ, chúng ta đã chuyển data qua extra
        if (projectData != null) {
          return ProjectDetailScreen(project: projectData);
        }
        
        // Tìm project từ id trong danh sách dự án đã biết
        final projectFromId = _findProjectById(projectId);
        if (projectFromId != null) {
          return ProjectDetailScreen(project: projectFromId);
        }
        
        // Trở về trang chủ nếu không tìm thấy
        return const HomeScreen();
      },
    ),
  ],
  // Xử lý các URL không tồn tại
  errorBuilder: (context, state) => const HomeScreen(),
);

// Helper function để tìm project từ slug
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
