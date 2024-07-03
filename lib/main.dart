import 'package:flutter/material.dart';
import 'services/weather_service.dart';
import 'models/weather_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
}
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  Weather? _weather;
  final TextEditingController _controller = TextEditingController();

  Future<void> _search() async {
    final weather = await _weatherService.fetchWeather(_controller.text);
    setState(() {
      _weather = weather;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter city',
              ),
              onSubmitted: (_) => _search(),
            ),
            SizedBox(height: 20),
            if (_weather != null)
              Column(
                children: [
                  Text(
                    _weather!.cityName,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${_weather!.temperature} °C',
                    style: TextStyle(fontSize: 32),
                  ),
                  Text(
                    _weather!.description,
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _search,
        child: Icon(Icons.search),
      ),
    );
  }
}
