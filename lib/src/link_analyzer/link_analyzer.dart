import 'dart:typed_data';
import 'package:link_metadata/src/link_analyzer/utils/utils.dart';
import 'package:link_metadata/src/link_data.dart';
import 'package:link_metadata/src/parser/og_parser.dart';

/// Analyzes web links and extracts metadata including Open Graph tags.
///
/// This class fetches HTML content from URLs and parses metadata such as
/// title, description, site name, and images.
class LinkAnalyzer {
  Uri? proxyUri;
  LinkAnalyzer({this.proxyUri});

  //NOTE: The proxy uri should take a query parameter "url" and return the html of the url

  /// Parses a URL and extracts link metadata.
  ///
  /// Fetches the HTML content from [url], parses Open Graph tags and other
  /// meta tags, and downloads associated images. Returns a [LinkData] object
  /// containing the extracted metadata, or null if parsing fails.
  ///
  /// Optional parameters [getHtmlResponse] and [getImageBytesResponse] can be
  /// provided for custom HTTP fetching logic, useful for testing or custom
  /// network handling.
  Future<LinkData?> parseUrl(
    String url, {
    Future<String?> Function(Uri uri)? getHtmlResponse,
    Future<Uint8List?> Function(Uri uri)? getImageBytesResponse,
  }) async {
    final sanitizedUrl = url.startsWith("http") ? url : "https://$url";

    final uri = proxyUri != null
        ? Uri(
            scheme: proxyUri!.scheme,
            host: proxyUri!.host,
            path: proxyUri!.path,
            queryParameters: proxyUri!.queryParameters
              ..addAll({"url": sanitizedUrl}),
          )
        : Uri.parse(sanitizedUrl);

    final html = getHtmlResponse != null
        ? await getHtmlResponse(uri)
        : await getResponse(uri: uri);

    if (html == null) {
      throw Exception("Failed to fetch HTML");
    }

    final og = OgParser(html);

    Uint8List? ogImage;

    if (og.image != null) {
      final imageUri = Uri.parse(og.image!);
      ogImage = getImageBytesResponse != null
          ? await getImageBytesResponse(imageUri)
          : await getImageBytes(uri: imageUri);
    }

    Uint8List? favicon;

    if (og.favicon != null) {
      final faviconUri = Uri.parse(og.favicon!);
      favicon = getImageBytesResponse != null
          ? await getImageBytesResponse(faviconUri)
          : await getImageBytes(uri: faviconUri);
    }

    return LinkData(
      url: url,
      title: og.title,
      description: og.desc,
      siteName: og.siteName,
      ogImage: ogImage,
      favicon: favicon,
    );
  }
}
