import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '77c30a3ba1401753926dd7fb30896ac8';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  double latitude;
  double longitude;


  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location  = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude= location.longitude;
    NetworkHelper networkHelper = NetworkHelper('http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    var weatherData = await networkHelper.getData();
    Navigator.pop(context, MaterialPageRoute(builder: (context){
      return LocationScreen(locationWeather: weatherData,);
    } ));


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitCircle(
          color: Colors.white,
          size: 100.0,

        ),
      ),
    );
  }
}
