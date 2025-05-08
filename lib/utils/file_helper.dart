import 'dart:io';
import 'dart:html' as html;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';

class FileHelper {
  /// Mở file từ assets
  static Future<void> openAssetFile(String assetPath, String fileName) async {
    try {
      if (kIsWeb) {
        // Giải pháp cho web - sử dụng HTML để tải xuống
        _downloadFileWeb(assetPath, fileName);
      } else {
        // Giải pháp cho mobile
        await _openFileNative(assetPath, fileName);
      }
    } catch (e) {
      throw 'Lỗi khi mở file: $e';
    }
  }
  
  /// Tải file trên web
  static void _downloadFileWeb(String url, String fileName) {
    // Tạo một anchor element để tải file
    final anchor = html.AnchorElement(
      href: url,
    )
      ..setAttribute('download', fileName)
      ..style.display = 'none';
    
    // Thêm vào body, click và xóa
    html.document.body?.append(anchor);
    anchor.click();
    anchor.remove();
  }
  
  /// Mở file trên nền tảng mobile
  static Future<void> _openFileNative(String assetPath, String fileName) async {
    // Đọc file từ assets
    final ByteData data = await rootBundle.load(assetPath);
    
    // Lấy đường dẫn thư mục tạm
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;
    
    // Tạo file tạm
    final File tempFile = File('$tempPath/$fileName');
    
    // Ghi dữ liệu vào file tạm
    await tempFile.writeAsBytes(
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      flush: true,
    );
    
    // Mở file
    final result = await OpenFile.open(tempFile.path);
    
    if (result.type != ResultType.done) {
      throw 'Không thể mở file: ${result.message}';
    }
  }
} 