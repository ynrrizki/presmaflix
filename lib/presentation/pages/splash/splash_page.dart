import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:presmaflix/app/bloc/app/app_bloc.dart';
// import 'package:prima_studio/ui/widgets/prima_studio.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.ease,
  );

  @override
  void initState() {
    Timer(
      const Duration(milliseconds: 1800),
      () {
        nextPage(context);
        // User? user = FirebaseAuth.instance.currentUser;
        // if (user != null) {
        //   log(user.uid);
        //   Navigator.of(context)
        //       .pushNamedAndRemoveUntil('/home', (route) => false);
        // } else {
        //   Navigator.of(context).pushNamedAndRemoveUntil(
        //     '/login',
        //     (route) => false,
        //   );
        // }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> nextPage(context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
      if (!user.emailVerified) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/verif', (route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      }
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login',
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // listenWhen: (previous, current) => previous.authUser != current.authUser,
    // listener: (context, state) => print('Splash screen Auth Listener!'),
    return FadeTransition(
      opacity: _animation,
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Presmaflix',
                style: GoogleFonts.montserrat(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
