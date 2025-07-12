import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

import 'package:pacify_app/constants.dart';
import 'package:pacify_app/models/soundscape_data.dart';
import 'package:pacify_app/services/weather_services.dart';
import 'package:pacify_app/utils/audio_player_manager.dart';
import 'package:pacify_app/utils/weather_utils.dart';
import 'package:pacify_app/widgets/info_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SoundscapeData _soundscapeData = SoundscapeData.loading();
  final WeatherService _weatherService = WeatherService();
  final AudioPlayerManager _audioPlayerManager = AudioPlayerManager();

  @override
  void initState() {
    super.initState();
    _generateSoundscape();
  }

  @override
  void dispose() {
    _audioPlayerManager.dispose();
    super.dispose();
  }

  Future<void> _generateSoundscape() async {
    setState(() {
      _soundscapeData = SoundscapeData.loading();
    });

    try {
      final random = Random();
      String selectedCity = locations[random.nextInt(locations.length)];

      final weatherData = await _weatherService.fetchWeather(selectedCity);

      String weatherMain = weatherData['weather'][0]['main'].toLowerCase();
      String weatherDescription =
          weatherData['weather'][0]['description'].toLowerCase();
      String iconCode = weatherData['weather'][0]['icon'];

      int sunrise = weatherData['sys']['sunrise'];
      int sunset = weatherData['sys']['sunset'];
      int currentTime = weatherData['dt'];

      String timeOfDayCategory =
          getTimeOfDayCategory(currentTime, sunrise, sunset);
      String weatherCondition = getWeatherConditionKey(weatherMain);

      String key = '${weatherCondition}_$timeOfDayCategory';
      String audioPath = soundscapeAudioPaths[key] ?? soundscapeAudioPaths['default']!;
      String soundscapeName =
          getSoundscapeDisplayName(weatherCondition, timeOfDayCategory);

      await _audioPlayerManager.playAudio(audioPath);

      setState(() {
        _soundscapeData = SoundscapeData(
          locationName: selectedCity,
          weatherDescription: '${capitalize(weatherDescription)} in $selectedCity',
          weatherIcon: getWeatherIcon(iconCode),
          soundscapeName: soundscapeName,
          audioFilePath: audioPath,
        );
      });
    } catch (e) {
      setState(() {
        _soundscapeData = SoundscapeData.error();
      });
      print('Error generating soundscape: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pacify'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey, Colors.black87],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Location and Weather Display
              InfoCard(
                children: [
                  Text(
                    _soundscapeData.locationName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _soundscapeData.weatherIcon,
                    style: const TextStyle(fontSize: 60),
                  ),
                  Text(
                    _soundscapeData.weatherDescription,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              
              InfoCard(
                children: [
                  const Text(
                    'Current Soundscape:',
                    style: TextStyle(fontSize: 16, color: Colors.white54),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _soundscapeData.soundscapeName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder<PlayerState>(
                    valueListenable: _audioPlayerManager.playerStateNotifier,
                    builder: (context, playerState, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              playerState == PlayerState.playing
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_filled,
                              size: 60,
                              color: Colors.lightBlueAccent,
                            ),
                            onPressed: _audioPlayerManager.togglePlayPause,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: _generateSoundscape,
                icon: const Icon(Icons.travel_explore, size: 30),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    'Discover New Soundscape',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}