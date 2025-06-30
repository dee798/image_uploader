import 'dart:io';
import 'package:http/http.dart' as http;

class UploadService {
  static Future<void> upload(File file) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://httpbin.org/post'),
    );
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    final response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Upload failed');
    }
  }
}