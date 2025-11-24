import 'package:flutter/material.dart';
import '../../models/weather_model.dart';
import '../../services/weather_service.dart';

class CurrentWeatherView extends StatelessWidget {
  final WeatherData weatherData;
  final WeatherService weatherService = WeatherService();

  CurrentWeatherView({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final firstForecast = weatherData.dailyForecasts.first;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark 
            ? [Colors.blue[800]!, Colors.blue[600]!]
            : [Colors.lightBlue[100]!, Colors.lightBlue[50]!],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            '${weatherData.currentTemperature.toStringAsFixed(0)}°',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w300,
              color: isDark ? Colors.white : Colors.blue[900],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            weatherService.getWeatherDescription(weatherData.currentWeatherCode),
            style: TextStyle(
              fontSize: 18,
              color: isDark ? Colors.white70 : Colors.blue[800],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTempIndicator('High: ${firstForecast.maxTemp.toStringAsFixed(0)}°C', isDark),
              const SizedBox(width: 16),
              _buildTempIndicator('Low: ${firstForecast.minTemp.toStringAsFixed(0)}°C', isDark),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTempIndicator(String text, bool isDark) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: isDark ? Colors.white70 : Colors.blue[700],
        fontWeight: FontWeight.w500,
      ),
    );
  }
}