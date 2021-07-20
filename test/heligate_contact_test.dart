import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:heligate_contact/heligate_contact.dart';

void main() {
  const MethodChannel channel = MethodChannel('heligate_contact');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await HeligateContact.getAContact(), '42');
  });
}
