import 'dart:math';

import 'package:weather_app/Model/model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiKey = '426e7ff9ecfb1ed70777cd2a6ee94ec1';

class NetworkHelper {
  Future getData(String location) async {
    http.Response response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey'),
    );
    if (response.statusCode == 200) {
      String data = response.body;

      return WeatherAppModel.fromJson(jsonDecode(data));
    } else {
      log(response.statusCode);
    }
  }
}
