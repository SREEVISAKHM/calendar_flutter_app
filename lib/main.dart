import 'package:calendar_flutter_app/utils/routes.dart';
import 'package:calendar_flutter_app/view/home/screen/home_view.dart';
import 'package:calendar_view/calendar_view.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return CalendarControllerProvider(
        controller: EventController(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: onAppGenerateRoute(),
          routes: appRoutes(),
          initialRoute: HomeView.route,
        ),
      );
    });
  }
}
