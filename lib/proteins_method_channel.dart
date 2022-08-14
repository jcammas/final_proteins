import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'proteins_platform_interface.dart';

/// An implementation of [ProteinsPlatform] that uses method channels.
class MethodChannelProteins extends ProteinsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('proteins');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
