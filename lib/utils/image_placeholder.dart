import 'package:flutter/material.dart';
import 'package:portfolio/constants/app_colors.dart';

class ImagePlaceholder {
  static Widget buildProjectImage(String imagePath, String title) {
    // Kiểm tra nếu là Roomily logo để xử lý đặc biệt
    if (imagePath.contains('roomily_logo')) {
      return Container(
        color: Colors.white,
        child: Transform.scale(
          scale: 1.3, // Phóng to hình ảnh 130%
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
      );
    }
    
    // Xử lý đặc biệt cho Exam Guard logo
    if (imagePath.contains('exam_guard_logo')) {
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Transform.scale(
          scale: 0.8, // Thu nhỏ hình ảnh xuống 80%
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
      );
    }
    
    // Các hình ảnh khác vẫn dùng code cũ
    return Image.asset(
      imagePath,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: AppColors.cardColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.broken_image,
                  size: 64,
                  color: AppColors.secondaryColor.withOpacity(0.7),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.textColor.withOpacity(0.7),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  static AssetImage getPlaceholderImage() {
    // This is a dummy asset image that will display error but won't crash the app
    return const AssetImage('assets/images/placeholder.jpg');
  }
} 