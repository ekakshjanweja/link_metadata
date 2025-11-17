import "dart:typed_data";

/// Represents metadata extracted from a web link.
///
/// Contains information such as title, description, site name, and images
/// extracted from Open Graph tags and other meta tags.
class LinkData {
  final String url;
  final String? title;
  final String? description;
  final String? siteName;
  final Uint8List? ogImage;
  final Uint8List? favicon;

  /// Creates a new [LinkData] instance.
  ///
  /// [url] is required and represents the URL of the link.
  /// All other parameters are optional and may be null if not found.
  LinkData({
    required this.url,
    this.title,
    this.description,
    this.siteName,
    this.ogImage,
    this.favicon,
  });
}
