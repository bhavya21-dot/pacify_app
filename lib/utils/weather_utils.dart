import 'package:pacify_app/constants.dart';

String capitalize(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

String getWeatherIcon(String iconCode) {
  // OpenWeatherMap icon codes mapping to emojis
  switch (iconCode) {
    case '01d': return '☀️';
    case '01n': return '🌙'; 
    case '02d': return '🌤️';
    case '02n': return '☁️'; 
    case '03d': case '03n': return '☁️'; 
    case '04d': case '04n': return '☁️'; 
    case '09d': case '09n': return '🌧️';
    case '10d': case '10n': return '☔'; 
    case '11d': case '11n': return '⛈️';
    case '13d': case '13n': return '❄️';
    case '50d': case '50n': return '🌫️';
    default: return '❓';
  }
}

String getTimeOfDayCategory(int currentTimeUnix, int sunriseUnix, int sunsetUnix) {
  DateTime currentTime = DateTime.fromMillisecondsSinceEpoch(currentTimeUnix * 1000, isUtc: true);
  DateTime sunrise = DateTime.fromMillisecondsSinceEpoch(sunriseUnix * 1000, isUtc: true);
  DateTime sunset = DateTime.fromMillisecondsSinceEpoch(sunsetUnix * 1000, isUtc: true);

  final Duration dawnDuskBuffer = Duration(hours: 1);

  if (currentTime.isAfter(sunrise.subtract(dawnDuskBuffer)) &&
      currentTime.isBefore(sunrise.add(dawnDuskBuffer))) {
    return 'dawn';
  } else if (currentTime.isAfter(sunset.subtract(dawnDuskBuffer)) &&
      currentTime.isBefore(sunset.add(dawnDuskBuffer))) {
    return 'dusk';
  } else if (currentTime.isAfter(sunrise) && currentTime.isBefore(sunset)) {
    return 'day';
  } else {
    return 'night';
  }
}

String getWeatherConditionKey(String weatherMain) {
  if (weatherMain.contains('rain') || weatherMain.contains('drizzle')) {
    return 'rainy';
  } else if (weatherMain.contains('clear')) {
    return 'sunny';
  } else if (weatherMain.contains('cloud')) {
    return 'cloudy';
  } else if (weatherMain.contains('wind')) {
    return 'windy';
  } else if (weatherMain.contains('snow')) {
    return 'snowy';
  } else if (weatherMain.contains('fog') ||
      weatherMain.contains('mist') ||
      weatherMain.contains('haze')) {
    return 'foggy';
  } else if (weatherMain.contains('thunderstorm')) {
    return 'thunderstorm';
  } else {
    return 'default';
  }
}

String getSoundscapeDisplayName(String weatherCondition, String timeOfDayCategory) {
  String baseName = soundscapeDisplayNames[weatherCondition] ?? soundscapeDisplayNames['default']!;

  if (timeOfDayCategory == 'night') {
    return '$baseName (Night)';
  } else if (timeOfDayCategory == 'dawn') {
    return '$baseName (Dawn)';
  } else if (timeOfDayCategory == 'dusk') {
    return '$baseName (Dusk)';
  }
  return '$baseName (Day)';
}