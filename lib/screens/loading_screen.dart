import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hava_durumu_app/screens/main_screen.dart';
import 'package:hava_durumu_app/utils/location.dart';
import 'package:hava_durumu_app/utils/weather.dart';
import 'package:source_span/source_span.dart';

class Loading_Screen extends StatefulWidget {
  const Loading_Screen({super.key});

  @override
  State<Loading_Screen> createState() => _Loading_ScreenState();
}

class _Loading_ScreenState extends State<Loading_Screen> {
  LocationHelper locationData = LocationHelper();
  Future<void> getLocationData() async{
    locationData = LocationHelper();
    await locationData.getCurrentLocation();

    if(locationData.latitude == null || locationData.longitude == null){
      print("konum bilgileri gelmiyour");
    }
    else{
      print("latitude: " + locationData.latitude.toString());
      print("longitude: " + locationData.longitude.toString());
    }
  }

  void getWeatherData() async{
    await getLocationData();

    WeatherData weatherData = WeatherData(locationData: (locationData));
    await weatherData.getCurrentTemperature();

    if(weatherData.curretTemperature == null||weatherData.currentCondition == null){
      print("API den sıcaklık veya konuk bilgisi dönmüyor");
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return MainScreen(weatherData: weatherData,);
    }));
  }


  @override
  void initState(){
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple,Colors.blue]
          ),
        ),
        child: Center(
          child: SpinKitFadingCircle(
            color: Colors.white,
            size: 150.0,
            duration: Duration(microseconds: 1200),
          ),
        )
      ),
    );
  }
}