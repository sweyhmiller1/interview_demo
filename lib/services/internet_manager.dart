import 'dart:io';

/// [InternetManager]
/// Handles checking if we are connected to wifi
class InternetManager {
  Future<bool> get isOnline async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
