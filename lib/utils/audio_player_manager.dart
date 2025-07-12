import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart'; 

class AudioPlayerManager {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final ValueNotifier<PlayerState> playerStateNotifier =
      ValueNotifier(PlayerState.stopped);

  String _currentAudioFilePath = ''; 

  AudioPlayerManager() {
    _audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
      playerStateNotifier.value = s;
    });
  }

  Future<void> playAudio(String assetPath) async {
    print('Attempting to load asset: $assetPath');
    if (assetPath.isEmpty) return;
    _currentAudioFilePath = assetPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(assetPath), volume: 0.7); 
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  Future<void> togglePlayPause() async {
    if (playerStateNotifier.value == PlayerState.playing) {
      await _audioPlayer.pause();
    } else if (playerStateNotifier.value == PlayerState.paused) {
      await _audioPlayer.resume();
    } else if (playerStateNotifier.value == PlayerState.stopped) {
      // If stopped, play the last track again
      if (_currentAudioFilePath.isNotEmpty) {
        await _audioPlayer.play(AssetSource(_currentAudioFilePath), volume: 0.7);
        await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      }
    }
  }


  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }

  void dispose() {
    _audioPlayer.dispose();
    playerStateNotifier.dispose();
  }
}