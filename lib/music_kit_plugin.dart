
import 'music_kit_plugin_platform_interface.dart';

class MusicKitPlugin {
  Future<String?> getPlatformVersion() {
    return MusicKitPluginPlatform.instance.getPlatformVersion();
  }

  Future<String?> requestPermission() {
    return MusicKitPluginPlatform.instance.requestPermission();
  }

  Future<String?> getUserToken(String deviceToken) {
    return MusicKitPluginPlatform.instance.getUserToken(deviceToken);
  }
}
