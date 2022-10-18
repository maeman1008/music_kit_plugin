
import 'music_kit_plugin_platform_interface.dart';

class MusicKitPlugin {
  Future<String?> getPlatformVersion() {
    return MusicKitPluginPlatform.instance.getPlatformVersion();
  }
}
