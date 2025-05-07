import 'package:flutter/material.dart';
import 'dart:math' as math;

class PatternPainter extends CustomPainter {
  final bool smallSize;
  
  PatternPainter({this.smallSize = false});
  
  @override
  void paint(Canvas canvas, Size size) {
    // Vẽ các đường trang trí và hoa văn lên background
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;
    
    // Vẽ lưới mỏng với khoảng cách phù hợp kích thước
    _drawGrid(canvas, size, smallSize ? 20 : 30, paint);
    
    // Vẽ một số đường trang trí
    _drawDecorationLines(canvas, size, paint);
  }
  
  void _drawGrid(Canvas canvas, Size size, double spacing, Paint paint) {
    // Vẽ lưới ngang
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
    
    // Vẽ lưới dọc
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
  }
  
  void _drawDecorationLines(Canvas canvas, Size size, Paint paint) {
    // Vẽ đường chéo
    canvas.drawLine(
      Offset(0, 0),
      Offset(size.width, size.height),
      paint..strokeWidth = 0.8,
    );
    
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(0, size.height),
      paint..strokeWidth = 0.8,
    );
    
    // Vẽ một số hình trang trí
    final decorPaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..style = PaintingStyle.fill;
      
    final circleSizeFactor = smallSize ? 0.6 : 1.0;
    final rectSizeFactor = smallSize ? 0.6 : 1.0;
    
    // Vẽ hình tròn ở các góc
    canvas.drawCircle(
      Offset(size.width * 0.1, size.height * 0.1),
      20 * circleSizeFactor,
      decorPaint,
    );
    
    canvas.drawCircle(
      Offset(size.width * 0.9, size.height * 0.1),
      30 * circleSizeFactor,
      decorPaint,
    );
    
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.8),
      25 * circleSizeFactor,
      decorPaint,
    );
    
    // Vẽ một số hình chữ nhật
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.2, 
        size.height * 0.7, 
        40 * rectSizeFactor, 
        40 * rectSizeFactor
      ),
      decorPaint,
    );
    
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.6, 
        size.height * 0.3, 
        30 * rectSizeFactor, 
        30 * rectSizeFactor
      ),
      decorPaint,
    );
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
} 