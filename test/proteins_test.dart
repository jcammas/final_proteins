import 'package:flutter_test/flutter_test.dart';
import 'package:proteins/proteins.dart';
import 'package:proteins/proteins_platform_interface.dart';
import 'package:proteins/proteins_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockProteinsPlatform 
    with MockPlatformInterfaceMixin
    implements ProteinsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ProteinsPlatform initialPlatform = ProteinsPlatform.instance;

  test('$MethodChannelProteins is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelProteins>());
  });

  test('getPlatformVersion', () async {
    Proteins proteinsPlugin = Proteins();
    MockProteinsPlatform fakePlatform = MockProteinsPlatform();
    ProteinsPlatform.instance = fakePlatform;
  
    expect(await proteinsPlugin.getPlatformVersion(), '42');
  });
}
