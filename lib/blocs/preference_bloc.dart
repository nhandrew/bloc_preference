import 'package:bloc_preference/models/color.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceBloc{

  final _brightness = BehaviorSubject<Brightness>();
  final _primaryColor = BehaviorSubject<ColorModel>();
  final _colors = [
    ColorModel(color: Colors.blue,index: 0.0, name: 'Blue'),
    ColorModel(color: Colors.green,index: 1.0, name: 'Green'),
    ColorModel(color: Colors.red,index: 2.0, name: 'Red'),
    ColorModel(color: Colors.white,index: 3.0, name: 'White'),
  ];

  //Getters
  Stream<Brightness> get brightness => _brightness.stream;
  Stream<ColorModel> get primaryColor => _primaryColor.stream;

  //Setters
  Function(Brightness) get changeBrightness => _brightness.sink.add;
  Function(ColorModel) get changePrimaryColor => _primaryColor.sink.add;

  indexToPrimaryColor(double index){
    return _colors.firstWhere((x) => x.index==index);
  }

  savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_brightness.value == Brightness.light){
      await prefs.setBool('dark', false);
    }  else {
      await prefs.setBool('dark', true);
    }

    await prefs.setDouble('colorIndex', _primaryColor.value.index);

  }

  loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool darkMode=prefs.get('dark');
    double colorIndex = prefs.get('colorIndex');

    if (darkMode != null){
      (darkMode == false) ? changeBrightness(Brightness.light) : changeBrightness(Brightness.dark);
    } else {
      changeBrightness(Brightness.light);
    }

    if (colorIndex != null){
      changePrimaryColor(indexToPrimaryColor(colorIndex));
    } else {
      changePrimaryColor(ColorModel(color: Colors.blue,index: 0.0, name: 'Blue'));
    }
  }

  dispose(){
    _primaryColor.close();
    _brightness.close();
  }

}