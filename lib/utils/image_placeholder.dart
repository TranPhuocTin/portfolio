import 'package:flutter/material.dart';
import 'package:portfolio/constants/app_colors.dart';

class ImagePlaceholder {
  static Widget buildProjectImage(String imagePath, String title) {
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