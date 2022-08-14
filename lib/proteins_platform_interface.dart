import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'proteins_method_channel.dart';

abstract class ProteinsPlatform extends PlatformInterface {
  /// Constructs a ProteinsPlatform.
  ProteinsPlatform() : super(token: _token);

  static final Object _token = Object();

  static ProteinsPlatform _instance = MethodChannelProteins();

  /// The default instance of [ProteinsPlatform] to use.
  ///
  /// Defaults to [MethodChannelProteins].
  static ProteinsPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ProteinsPlatform] when
  /// they register themselves.
  static set instance(ProteinsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
