import 'dart:typed_data';
import 'package:http/http.dart' as http;

Future<String?> getResponse({required Uri uri}) async {
  try {
    final response = await http.get(uri, headers: {"Accept": "*/*"});

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch HTML: ${response.statusCode}");
    }

    return response.body;
  } catch (e) {
    throw Exception(e);
  }
}

Future<Uint8List?> getImageBytes({required Uri uri}) async {
  try {
    final response = await http.get(uri, headers: {"Accept": "*/*"});

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch image: ${response.statusCode}");
    }

    return response.bodyBytes;
  } catch (e) {
    throw Exception(e);
  }
}
