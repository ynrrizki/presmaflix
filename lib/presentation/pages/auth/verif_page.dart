import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:presmaflix/presentation/cubits/logout/logout_cubit.dart';
import 'package:presmaflix/utils/functions.dart';
import 'package:presmaflix/presentation/config/themes_config.dart';

class VerifPage extends StatefulWidget {
  const VerifPage({Key? key}) : super(key: key);

  @override
  State<VerifPage> createState() => _VerifPageState();
}

class _VerifPageState extends State<VerifPage> {
  bool isAlreadySend = false;
  Timer? timer;
  Timer? cooldown;
  Duration alreadySendTimer = const Duration(seconds: 30);
  String? formattedTimer;

  @override
  void initState() {
    super.initState();
    formattedTimer = '00:00';
    checkEmailVerified(context);
  }

  @override
  void dispose() {
    cooldown?.cancel();
    super.dispose();
  }

  void updateFormattedTimer() {
    setState(() {
      alreadySendTimer -= const Duration(seconds: 1);
      if (alreadySendTimer <= Duration.zero && !isAlreadySend) {
        timer?.cancel();
        formattedTimer = '00:00';
        alreadySendTimer = const Duration(seconds: 30);
      } else {
        formattedTimer = DateFormat("mm:ss").format(
          DateTime.fromMillisecondsSinceEpoch(alreadySendTimer.inMilliseconds),
        );
      }
    });
  }

  void checkEmailVerified(context) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
      if (user.emailVerified) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
        );
      }
    }
  }

  void sendAgainCooldown() {
    cooldown = Timer(const Duration(seconds: 30), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isAlreadySend = false;
        });
      });
    });
  }

  void sendVerification() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      user.sendEmailVerification();
      setState(() {
        isAlreadySend = true;
      });
      sendAgainCooldown();
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        updateFormattedTimer();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoutCubit, LogoutState>(
      listener: (context, state) {
        if (state.status == LogoutStatus.enter) {
          loading(context);
        } else if (state.status == LogoutStatus.success) {
          Navigator.of(
            context,
            rootNavigator: true,
          ).pushNamedAndRemoveUntil('/', (route) => false);
          log('logout nya sukes brow...');
        } else if (state.status == LogoutStatus.error) {
          final snackBar = SnackBar(
            content: Text(
              'Gagal Logout, harap coba lagi...',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            titleTextStyle: GoogleFonts.montserrat(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 17,
            ),
            title: const Text('Verifikasi Email'),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            shadowColor: Colors.grey,
            elevation: 0.5,
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'Silahkan Cek Email Anda',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 35),
                    child: Text(
                      formattedTimer ?? '00:00',
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: !isAlreadySend ? sendVerification : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      disabledBackgroundColor: Colors.grey,
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text('Kirim Email'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<LogoutCubit>().logOut();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: kPrimaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text('Batalkan Verifikasi'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
