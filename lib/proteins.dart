
import 'proteins_platform_interface.dart';

class Proteins {
  Future<String?> getPlatformVersion() {
    return ProteinsPlatform.instance.getPlatformVersion();
  }
}
