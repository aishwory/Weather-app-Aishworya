import 'package:flutter/material.dart';
import '../../models/weather_model.dart';

class WeatherDetailsView extends StatelessWidget {
  final WeatherData? weatherData;

  const WeatherDetailsView({super.key, this.weatherData});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildDetailItem('Wind', '19 km/h', Icons.air, isDark),
          _buildDetailItem('Rain', '24%', Icons.beach_access, isDark),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String title, String value, IconData icon, bool isDark) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 28),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            color: isDark ? Colors.white54 : Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}