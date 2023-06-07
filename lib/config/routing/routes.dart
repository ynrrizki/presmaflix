import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:presmaflix/config/routing/argument/arguments.dart';
import 'package:presmaflix/ui/pages/pages.dart';

class AppRouter {
  Route onRoute(RouteSettings settings) {
    log('Route: ${settings.name}');

    switch (settings.name) {
      // case "/":
      //   return CupertinoPageRoute(
      //     builder: (context) => const SplashPage(),
      //   );
      // case "/login":
      //   return CupertinoPageRoute(
      //     builder: (context) => const LoginPage(),
      //   );
      case "/":
        return CupertinoPageRoute(
          builder: (context) => const BottomNavigation(),
        );
      case "/content-detail":
        final args = settings.arguments as ContentDetailArguments;
        return CupertinoPageRoute(
          builder: (context) => ContentDetailPage(
            content: args.content,
          ),
        );
      case "/content-all":
        final args = settings.arguments as ContentAllArguments;
        return CupertinoPageRoute(
          builder: (context) => ContentAllPage(
            title: args.title,
            contents: args.contents,
          ),
        );
      case "/content-video":
        final args = settings.arguments as ContentVideoArguments;
        return CupertinoPageRoute(
          builder: (context) => ContentVideoPage(
            video: args.video,
          ),
        );
      case "/search":
        return CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (context) => const SearchPage(),
        );
      case "/more":
        return CupertinoPageRoute(
          builder: (context) => const MorePage(),
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
