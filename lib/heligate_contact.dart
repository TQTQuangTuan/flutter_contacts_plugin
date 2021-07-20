
import 'dart:async';

import 'package:flutter/services.dart';

class HeligateContact {
  static const MethodChannel _channel =
  const MethodChannel('heligate_contact');

  static Future<String> getAContact() async {
    final String contact = await _channel.invokeMethod('getAContact');
    return contact;
  }
}
