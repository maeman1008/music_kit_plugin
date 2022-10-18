import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'music_kit_plugin_method_channel.dart';

abstract class MusicKitPluginPlatform extends PlatformInterface {
  /// Constructs a MusicKitPluginPlatform.
  MusicKitPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static MusicKitPluginPlatform _instance = MethodChannelMusicKitPlugin();

  /// The default instance of [MusicKitPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelMusicKitPlugin].
  static MusicKitPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MusicKitPluginPlatform] when
  /// they register themselves.
  static set instance(MusicKitPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
