import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'music_kit_plugin_platform_interface.dart';

/// An implementation of [MusicKitPluginPlatform] that uses method channels.
class MethodChannelMusicKitPlugin extends MusicKitPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('music_kit_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> requestPermission() async {
    return await methodChannel.invokeMethod("requestPermission");
  }

  @override
  Future<String?> getUserToken(String deviceToken) async {
    return await methodChannel.invokeMethod("getUserToken", deviceToken);
  }

  @override
  Future<String?> getDefaultDeveloperToken() async {
    return await methodChannel.invokeMethod("getDefaultDeveloperToken");
  }
}
