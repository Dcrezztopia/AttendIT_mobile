// api_config.dart
import 'dart:io';

// String baseUrl = Platform.isAndroid
//     ? 'http://10.0.2.2:8000/api'
//     : 'http://127.0.0.1:8000/api';

const String baseUrl =
    'http://192.168.1.123:4563/api'; //sesuaikan dengan jaringan yang sama antara hp dan laptop -> ip4 address
const String storageUrl = 'http://192.168.1.123:4563/storage';

String getImageUrl(String? path) {
  if (path == null) return '';
  return '$storageUrl${path.replaceFirst('/storage', '')}';
}
