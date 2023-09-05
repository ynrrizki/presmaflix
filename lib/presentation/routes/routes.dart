import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:presmaflix/presentation/bloc/app/app_bloc.dart';
import 'package:presmaflix/presentation/pages/menu/more/account/account_page.dart';
import 'package:presmaflix/presentation/pages/menu/more/change_language/change_language_page.dart';
import 'package:presmaflix/presentation/pages/menu/more/notification/notif_page.dart';
import 'package:presmaflix/presentation/routes/argument/arguments.dart';
import 'package:presmaflix/presentation/pages/pages.dart';

class AppRouter {
  AppStatus state;

  set appStatus(AppStatus appStatus) => state = appStatus;
  set appState(AppState appState) => state = appState.status;
  AppRouter({this.state = AppStatus.unauthenticated});
  Route onRoute(RouteSettings settings) {
    log('Route: ${settings.name}', name: 'AppRouter');
    log('user: $state', name: 'AppRouter');

    switch (settings.name) {
      case "/":
        return CupertinoPageRoute(
          builder: (context) => const SplashPage(),
        );
      case "/login":
        return CupertinoPageRoute(
          builder: (context) => const LoginPage(),
        );
      case "/register":
        return CupertinoPageRoute(
          builder: (context) => const RegisterPage(),
        );
      case "/home":
        return CupertinoPageRoute(
          builder: (context) => const Navigate(),
        );
      case "/watchlist":
        return CupertinoPageRoute(
          builder: (context) => const BottomNavigation(index: 2),
        );
      case "/verif":
        return CupertinoPageRoute(
          builder: (context) => const VerifPage(),
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
          fullscreenDialog: true,
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
      case "/notif":
        return CupertinoPageRoute(
          builder: (context) => const NotifPage(),
        );
      case "/account":
        return CupertinoPageRoute(
          builder: (context) => const AccountPage(),
        );
      case "/change-language":
        return CupertinoPageRoute(
          builder: (context) => const ChangeLanguagePage(),
        );
      default:
        return _errorRoute();
    }

    // switch (state) {
    //   case AppStatus.authenticated:
    //     return _authenticatedRoute(settings);
    //   case AppStatus.unauthenticated:
    //     return _unauthenticatedRoute(settings);
    // }
  }

  // Route _unauthenticatedRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case "/":
  //       return CupertinoPageRoute(
  //         builder: (context) => const SplashPage(),
  //       );
  //     case "/login":
  //       return CupertinoPageRoute(
  //         builder: (context) => const LoginPage(),
  //       );
  //     case "/register":
  //       return CupertinoPageRoute(
  //         builder: (context) => const RegisterPage(),
  //       );
  //     default:
  //       return _errorRoute();
  //   }
  // }

  // Route _authenticatedRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case "/":
  //       return CupertinoPageRoute(
  //         builder: (context) => const SplashPage(),
  //       );
  //     case "/home":
  //       return CupertinoPageRoute(
  //         builder: (context) => const BottomNavigation(),
  //       );
  //     case "/verif":
  //       return CupertinoPageRoute(
  //         builder: (context) => const VerifPage(),
  //       );
  //     case "/content-detail":
  //       final args = settings.arguments as ContentDetailArguments;
  //       return CupertinoPageRoute(
  //         builder: (context) => ContentDetailPage(
  //           content: args.content,
  //         ),
  //       );
  //     case "/content-all":
  //       final args = settings.arguments as ContentAllArguments;
  //       return CupertinoPageRoute(
  //         builder: (context) => ContentAllPage(
  //           title: args.title,
  //           contents: args.contents,
  //         ),
  //       );
  //     case "/content-video":
  //       final args = settings.arguments as ContentVideoArguments;
  //       return CupertinoPageRoute(
  //         builder: (context) => ContentVideoPage(
  //           video: args.video,
  //         ),
  //       );
  //     case "/search":
  //       return CupertinoPageRoute(
  //         fullscreenDialog: true,
  //         builder: (context) => const SearchPage(),
  //       );
  //     case "/more":
  //       return CupertinoPageRoute(
  //         builder: (context) => const MorePage(),
  //       );
  //     default:
  //       return _errorRoute();
  //   }
  // }

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