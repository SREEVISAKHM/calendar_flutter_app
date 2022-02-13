import 'package:calendar_flutter_app/view/detail_view/details_screen.dart';
import 'package:calendar_flutter_app/view/home/screen/home_view.dart';

import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext context)> appRoutes() => {
      HomeView.route: (_) => const HomeView(),
    };

RouteFactory onAppGenerateRoute() => (settings) {
      if (settings.name == DetailScreen.route) {
        final arg = settings.arguments! as DetailScreen;
        return MaterialPageRoute(builder: (context) {
          return DetailScreen(
            eventController: arg.eventController,
            date: arg.date,
            events: arg.events,
            index: arg.index,
          );
        });
      }
    };
