const String openWeatherMapApiKey = '2e56a10a3bda97c2d01acca56a442301';
// Remember to replace 'YOUR_OPENWEATHERMAP_API_KEY' with your actual key!

const List<String> locations = [
  'Tokyo', 'Paris', 'Rio de Janeiro', 'Cairo', 'Sydney', 'Reykjavik',
  'Amazon Rainforest', 'Sahara Desert', 'Mount Everest', 'New York',
  'London', 'Rome', 'Cape Town', 'Mumbai', 'Dubai', 'Kyoto',
  'Buenos Aires', 'Berlin', 'Moscow', 'Toronto', 'Helsinki', 'Vancouver',
  'Shanghai', 'Istanbul', 'Ankleshwar' // Added a local touch!
];

// Mapping of weather and time to soundscape audio files
const Map<String, String> soundscapeAudioPaths = {
  'rainy_night': 'gentle_rain.mp3',
  'rainy_day': 'gentle_rain.mp3',
  'sunny_day': 'distant_city_hum.mp3',
  'sunny_night': 'distant_city_hum.mp3',
  'cloudy_day': 'rustling_leaves.mp3',
  'cloudy_night': 'rustling_leaves.mp3',
  'windy_day': 'windy_day.mp3',
  'windy_night': 'windy_day.mp3',
  'snowy_day': 'snowy_forest.mp3',
  'snowy_night': 'snowy_forest.mp3',
  'foggy_day': 'gentle_rain.mp3',
  'foggy_night': 'gentle_rain.mp3',
  'thunderstorm_day': 'gentle_rain.mp3',
  'thunderstorm_night': 'gentle_rain.mp3',
  'default': 'rustling_leaves.mp3', // Fallback
};

// Mapping for display names of soundscapes
const Map<String, String> soundscapeDisplayNames = {
  'rainy': 'Gentle Rain',
  'sunny': 'Distant City Hum',
  'cloudy': 'Rustling Leaves',
  'windy': 'Howling Wind',
  'snowy': 'Quiet Snowy Forest',
  'foggy': 'Misty Ambiance',
  'thunderstorm': 'Distant Thunder',
  'default': 'Peaceful Ambiance',
};