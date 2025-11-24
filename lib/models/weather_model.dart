class WeatherData {
  final double currentTemperature;
  final int currentWeatherCode;
  final String currentTime;
  final int isDay;
  final List<DailyForecast> dailyForecasts;
  final String location;

  WeatherData({
    required this.currentTemperature,
    required this.currentWeatherCode,
    required this.currentTime,
    required this.isDay,
    required this.dailyForecasts,
    required this.location,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final currentWeather = json['current_weather'];
    final daily = json['daily'];
    
    final dailyForecasts = <DailyForecast>[];
    for (var i = 0; i < daily['time'].length; i++) {
      dailyForecasts.add(DailyForecast(
        date: daily['time'][i],
        maxTemp: daily['temperature_2m_max'][i],
        minTemp: daily['temperature_2m_min'][i],
        precipitation: daily['precipitation_sum'][i],
        weatherCode: daily['weathercode'][i],
      ));
    }

    return WeatherData(
      currentTemperature: currentWeather['temperature'],
      currentWeatherCode: currentWeather['weathercode'],
      currentTime: currentWeather['time'],
      isDay: currentWeather['is_day'],
      dailyForecasts: dailyForecasts,
      location: 'Kathmandu',
    );
  }
}

class DailyForecast {
  final String date;
  final double maxTemp;
  final double minTemp;
  final double precipitation;
  final int weatherCode;

  DailyForecast({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.precipitation,
    required this.weatherCode,
  });
}