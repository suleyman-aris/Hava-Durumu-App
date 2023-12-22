import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

import 'location.dart';

const apiKey = "d3b297dea0ca217c9862404f98614311";

class WeatherDisplayData{
  Icon weatherIcon;
  AssetImage? weatherImage;

  WeatherDisplayData({required this.weatherIcon, this.weatherImage});

}


class WeatherData{
  WeatherData({required this.locationData});

  LocationHelper locationData;
  double curretTemperature = 0.0;
  int currentCondition = 0;
  String city = "";

  Future<void> getCurrentTemperature() async{
    Response response = await get(Uri.parse("https://history.openweathermap.org/data/2.5/history/city?lat=${locationData.latitude}&lon=${locationData.longitude}&type=hour&start={start}&end={end}&appid=${apiKey}&unit=metric"));

    if(response.statusCode == 200){
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try{
        curretTemperature = currentWeather['main']['temo'];
        currentCondition = currentWeather['weather'][0]['id'];
        city = currentWeather['name'];
      }
      catch(e){
        print(e);
      }
    }
    else{
      print("Api den değer gelimiyor");
    }
  }

  WeatherDisplayData getWeatherDisplayData(){
    if(currentCondition < 600){
      return WeatherDisplayData(
      weatherIcon: Icon(
        FontAwesomeIcons.cloud,
        size: 75.0,
        color: Colors.white,
      ),
    weatherImage: AssetImage('assets/bulutlu.png'));
    }
    else{
      var now = new DateTime.now();
      if(now.hour >= 19){
        return WeatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.moon,
              size: 75.0,
              color: Colors.white,
            ),
            weatherImage: AssetImage('assets/gece.png'));
      }
      else{
        return WeatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.sun,
              size: 75.0,
              color: Colors.white,
            ),
            weatherImage: AssetImage('assets/.png'));
      }
    }

  }
}