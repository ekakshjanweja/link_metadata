# link_metadata

A Flutter package for extracting Open Graph metadata, images, and favicons from URLs.

## Features

- Extract Open Graph tags (title, description, site name, image)
- Proxy support for flutter web

## Installation

```yaml
dependencies:
  link_metadata: ^0.0.1
```

## Usage

```dart
import 'package:link_metadata/link_metadata.dart';

final analyzer = LinkAnalyzer();
final linkData = await analyzer.parseUrl('https://example.com');

print('Title: ${linkData?.title}');
print('Description: ${linkData?.description}');
// linkData.ogImage and linkData.favicon are Uint8List bytes
```

**With proxy [for flutter web]:**

```dart
final analyzer = LinkAnalyzer(
  proxyUri: Uri.parse('https://your-proxy.com/fetch?url='),
);
```

> **Note:** If you use a proxy, it should accept a query parameter called `url` containing the original link you want to analyze. The proxy should return the HTML content of that link.

**Custom HTML fetching:**

```dart
final linkData = await analyzer.parseUrl(
  'https://example.com',
  getHtmlResponse: (uri) async => await customFetch(uri),
);
```

**Custom image bytes fetching:**

```dart
final linkData = await analyzer.parseUrl(
  'https://example.com',
  getImageBytesResponse: (uri) async => await customImageFetch(uri),
);
```

**Both custom HTML and image fetching:**

```dart
final linkData = await analyzer.parseUrl(
  'https://example.com',
  getHtmlResponse: (uri) async => await customFetch(uri),
  getImageBytesResponse: (uri) async => await customImageFetch(uri),
);
```
