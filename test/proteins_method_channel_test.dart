import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proteins/proteins_method_channel.dart';

void main() {
  MethodChannelProteins platform = MethodChannelProteins();
  const MethodChannel channel = MethodChannel('proteins');

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
    expect(await platform.getPlatformVersion(), '42');
  });
}
