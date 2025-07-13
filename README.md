Pacify App

🍃 Your Personalized Soundscape Companion
Pacify App is a Flutter application designed to bring tranquility to your day by generating unique soundscapes based on real-time weather conditions and time of day for a randomly selected global city. Whether it's the gentle patter of rain on a cloudy night or the distant hum of a city on a sunny day, Pacify creates an ambient audio experience tailored to the current atmospheric vibes.

✨ Features
Dynamic Soundscape Generation: Automatically selects a city and generates a corresponding soundscape based on its current weather and time of day.

Real-time Weather Integration: Fetches live weather data (main condition, description, icon, sunrise/sunset times) using the OpenWeatherMap API.

Intuitive UI: A clean and calming user interface to display location, weather details, and the current soundscape.

Audio Playback: Plays ambient sound files using the audioplayers library, with loop functionality.

Secure API Key Handling: Utilizes flutter_dotenv to manage API keys securely, preventing hardcoding and accidental exposure.

🚀 Technologies Used
Flutter: Cross-platform UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.

Dart: Programming language for Flutter.

OpenWeatherMap API: For fetching real-time weather data.

http package: For making network requests.

geocoding package: For converting city names to geographical coordinates.

audioplayers package: For playing local audio assets.

flutter_dotenv package: For managing environment variables (e.g., API keys).

🛠️ Setup and Local Development
Follow these steps to get a local copy of Pacify App up and running on your machine.

Prerequisites
Flutter SDK installed (Installation Guide)

Git installed

Node.js and npm (for gh-pages deployment, if you choose to use it)

1. Clone the Repository
git clone https://github.com/YourGitHubUsername/pacify_app.git
cd pacify_app

(Replace YourGitHubUsername with your actual GitHub username)

2. Install Dependencies
flutter pub get

3. Configure API Key (Crucial!)
The app uses the OpenWeatherMap API. You'll need to obtain your own API key and configure it:

Get an API Key: Sign up at OpenWeatherMap to get your free API key.

Create .env file: In the root directory of your pacify_app project (the same level as pubspec.yaml), create a new file named .env.

Add your key: Open the .env file and add your API key like this:

WEATHER_API_KEY=YOUR_ACTUAL_OPENWEATHERMAP_API_KEY

Replace YOUR_ACTUAL_OPENWEATHERMAP_API_KEY with the key you obtained.

Ensure .env is ignored: Verify that .env is listed in your .gitignore file to prevent it from being committed to version control.

4. Add Audio Assets
The app plays ambient soundscapes from local audio files.

Create folder: In the root of your pacify_app project, create a new folder: assets/audio/.

Place audio files: Obtain .mp3 files for the soundscapes (e.g., gentle_rain.mp3, distant_city_hum.mp3, rustling_leaves.mp3, windy_day.mp3, snowy_forest.mp3) and place them inside the assets/audio/ folder.

Note: Ensure the filenames match those specified in lib/constants.dart.

You might need to find royalty-free audio or create your own.

5. Run the Application
flutter run
