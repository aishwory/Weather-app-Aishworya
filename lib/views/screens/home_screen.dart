import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/weather_controller.dart';
import '../../models/weather_model.dart';
import '../widgets/current_weather_view.dart';
import '../widgets/forecast_view.dart';
import '../widgets/weather_details_view.dart';
import '../widgets/loading_view.dart';
import '../widgets/error_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    final controller = Provider.of<WeatherController>(context, listen: false);
    controller.fetchWeather(27.7172, 85.3240);
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.yellow[200],
        body: SafeArea(
          child: Consumer<WeatherController>(
            builder: (context, controller, child) {
              if (controller.isLoading) {
                return const LoadingView();
              }

              if (controller.error != null) {
                return ErrorView(
                  error: controller.error!,
                  onRetry: _loadInitialData,
                );
              }

              if (controller.weatherData != null) {
                return _buildWeatherContent(controller.weatherData!, _isDarkMode);
              }

              return const LoadingView();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherContent(WeatherData weatherData, bool isDark) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(weatherData.location, isDark),
          CurrentWeatherView(weatherData: weatherData),
          const SizedBox(height: 20),
          WeatherDetailsView(weatherData: weatherData),
          const SizedBox(height: 20),
          _buildForecastSection(weatherData, isDark),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeader(String location, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: _toggleTheme,
            icon: Icon(
              _isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: isDark ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastSection(WeatherData weatherData, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '7-Day Forecast',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(height: 12),
          ForecastView(dailyForecasts: weatherData.dailyForecasts),
        ],
      ),
    );
  }
}