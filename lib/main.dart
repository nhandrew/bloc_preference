import 'package:bloc_preference/models/color.dart';
import 'package:bloc_preference/providers/preference_provider.dart';
import 'package:bloc_preference/widgets/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PreferenceProvider(),
      child: Consumer<PreferenceProvider>(
        builder: (context, provider, child) {
          return StreamBuilder<Brightness>(
              stream: provider.bloc.brightness,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                return StreamBuilder<ColorModel>(
                    stream: provider.bloc.primaryColor,
                    builder: (context, snapshotPrimaryColor) {
                      if (!snapshotPrimaryColor.hasData) return Container();
                      return MaterialApp(
                        title: 'Flutter Demo',
                        theme: ThemeData(
                          primaryColor: snapshotPrimaryColor.data.color,
                          brightness: snapshot.data,
                        ),
                        home: Home(),
                      );
                    });
              });
        },
      ),
    );
  }
}
