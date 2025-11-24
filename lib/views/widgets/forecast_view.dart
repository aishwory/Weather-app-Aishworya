import 'package:flutter/material.dart';
import '../../models/weather_model.dart';
import '../../services/weather_service.dart';

class ForecastView extends StatelessWidget {
  final List<DailyForecast> dailyForecasts;
  final WeatherService weatherService = WeatherService();

  ForecastView({super.key, required this.dailyForecasts});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.grey[700]! : Colors.grey[200]!),
      ),
      child: Column(
        children: dailyForecasts.map((forecast) => _buildForecastItem(forecast, isDark)).toList(),
      ),
    );
  }

  Widget _buildForecastItem(DailyForecast forecast, bool isDark) {
    final date = DateTime.parse(forecast.date);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 60,
            child: Text(
              _getDayName(date),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              weatherService.getWeatherDescription(forecast.weatherCode),
              style: TextStyle(
                color: isDark ? Colors.white70 : Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
          Text(
            '${forecast.maxTemp.toStringAsFixed(0)}°',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  String _getDayName(DateTime date) {
    if (date.day == DateTime.now().day) return 'Today';
    return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday - 1];
  }
}