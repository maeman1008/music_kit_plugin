import 'package:flutter_test/flutter_test.dart';
import 'package:music_kit_plugin/music_kit_plugin.dart';
import 'package:music_kit_plugin/music_kit_plugin_platform_interface.dart';
import 'package:music_kit_plugin/music_kit_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMusicKitPluginPlatform
    with MockPlatformInterfaceMixin
    implements MusicKitPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MusicKitPluginPlatform initialPlatform = MusicKitPluginPlatform.instance;

  test('$MethodChannelMusicKitPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMusicKitPlugin>());
  });

  test('getPlatformVersion', () async {
    MusicKitPlugin musicKitPlugin = MusicKitPlugin();
    MockMusicKitPluginPlatform fakePlatform = MockMusicKitPluginPlatform();
    MusicKitPluginPlatform.instance = fakePlatform;

    expect(await musicKitPlugin.getPlatformVersion(), '42');
  });
}
