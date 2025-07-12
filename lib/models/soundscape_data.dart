class SoundscapeData {
  final String locationName;
  final String weatherDescription;
  final String weatherIcon;
  final String soundscapeName;
  final String audioFilePath;

  SoundscapeData({
    required this.locationName,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.soundscapeName,
    required this.audioFilePath,
  });

  // Factory constructor for initial loading state
  factory SoundscapeData.loading() {
    return SoundscapeData(
      locationName: 'Discovering...',
      weatherDescription: '',
      weatherIcon: '⏳',
      soundscapeName: 'Generating new ambiance...',
      audioFilePath: '',
    );
  }


  factory SoundscapeData.error() {
    return SoundscapeData(
      locationName: 'Error',
      weatherDescription: 'Failed to fetch soundscape.',
      weatherIcon: '⚠️',
      soundscapeName: 'Please try again.',
      audioFilePath: '', // No audio path
    );
  }
}