import "dart:typed_data";

class LinkData {
  final String url;
  final String? title;
  final String? description;
  final String? siteName;
  final Uint8List? ogImage;
  final Uint8List? favicon;

  LinkData({
    required this.url,
    this.title,
    this.description,
    this.siteName,
    this.ogImage,
    this.favicon,
  });
}
