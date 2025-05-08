import 'dart:io';
import 'dart:html' as html;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';

class FileHelper {
  /// Open file from assets
  static Future<void> openAssetFile(String assetPath, String fileName) async {
    try {
      if (kIsWeb) {
        // Solution for web - use HTML to download
        _downloadFileWeb(assetPath, fileName);
      } else {
        // Solution for mobile
        await _openFileNative(assetPath, fileName);
      }
    } catch (e) {
      throw 'Error opening file: $e';
    }
  }
  
  /// Download file on web
  static void _downloadFileWeb(String url, String fileName) {
    // Create an anchor element to download file
    final anchor = html.AnchorElement(
      href: url,
    )
      ..setAttribute('download', fileName)
      ..style.display = 'none';
    
    // Add to body, click and remove
    html.document.body?.append(anchor);
    anchor.click();
    anchor.remove();
  }
  
  /// Open file on mobile platforms
  static Future<void> _openFileNative(String assetPath, String fileName) async {
    // Read file from assets
    final ByteData data = await rootBundle.load(assetPath);
    
    // Get temporary directory path
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;
    
    // Create temporary file
    final File tempFile = File('$tempPath/$fileName');
    
    // Write data to temporary file
    await tempFile.writeAsBytes(
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      flush: true,
    );
    
    // Open file
    final result = await OpenFile.open(tempFile.path);
    
    if (result.type != ResultType.done) {
      throw 'Cannot open file: ${result.message}';
    }
  }
} 