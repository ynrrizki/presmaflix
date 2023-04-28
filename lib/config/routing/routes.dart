import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:presmaflix/ui/pages/menu/bottom_navigation.dart';

class AppRouter {
  Route onRoute(RouteSettings settings) {
    log('Route: ${settings.name}');
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) => const BottomNavigation(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text(
            '404 Not Found',
            style: TextStyle(
              fontSize: 50,
            ),
          ),
        ),
      ),
    );
  }
}
