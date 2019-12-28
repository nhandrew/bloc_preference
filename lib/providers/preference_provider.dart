import 'package:bloc_preference/blocs/preference_bloc.dart';
import 'package:flutter/material.dart';

class PreferenceProvider with ChangeNotifier{

  PreferenceBloc _bloc;

  PreferenceProvider(){
    _bloc = PreferenceBloc();
    _bloc.loadPreferences();
  }

  PreferenceBloc get bloc => _bloc;
  
}