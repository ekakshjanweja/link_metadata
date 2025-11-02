class OgParser {
  final String html;

  OgParser(this.html);

  String? get title {
    return extractMetaContent(
      attributeKey: 'property',
      attributeValue: 'og:title',
    );
  }

  String? get desc {
    return extractMetaContent(
          attributeKey: 'property',
          attributeValue: 'og:description',
        ) ??
        extractMetaContent(attributeKey: 'name', attributeValue: 'description');
  }

  String? get image {
    return extractMetaContent(
      attributeKey: 'property',
      attributeValue: 'og:image',
    );
  }

  String? get siteName {
    return extractMetaContent(
      attributeKey: 'property',
      attributeValue: 'og:site_name',
    );
  }

  String? extractMetaContent({
    required String attributeKey,
    required String attributeValue,
  }) {
    final escapedValue = RegExp.escape(attributeValue);

    final forward = RegExp(
      '<meta\\b[^>]*\\b'
      '$attributeKey'
      '=[\'"]'
      '$escapedValue'
      '[\'"][^>]*\\bcontent=[\'"]([^\'"]+)[\'"][^>]*>',
      caseSensitive: false,
    );

    final m1 = forward.firstMatch(html);
    if (m1 != null) return m1.group(1);

    final reverse = RegExp(
      '<meta\\b[^>]*\\bcontent=[\'"]([^\'"]+)[\'"][^>]*\\b'
      '$attributeKey'
      '=[\'"]'
      '$escapedValue'
      '[\'"][^>]*>',
      caseSensitive: false,
    );

    return reverse.firstMatch(html)?.group(1);
  }

  String? get favicon {
    return extractMetaContent(
      attributeKey: 'property',
      attributeValue: 'og:favicon',
    );
  }
}
