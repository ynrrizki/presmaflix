import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:presmaflix/config/themes.dart';

class VerifPage extends StatefulWidget {
  const VerifPage({Key? key}) : super(key: key);

  @override
  State<VerifPage> createState() => _VerifPageState();
}

class _VerifPageState extends State<VerifPage> {
  bool isAlreadySend = false;
  late Timer timer;
  Timer? cooldown;
  late Duration alreadySendTimer;
  late String formattedTimer;

  @override
  void initState() {
    super.initState();
    startTimer(); // Memulai timer saat halaman dimuat
    checkEmailVerified();
  }

  @override
  void dispose() {
    timer.cancel();
    cooldown?.cancel();
    super.dispose();
  }

  void startTimer() {
    alreadySendTimer = const Duration(seconds: 30);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateFormattedTimer();
      checkEmailVerified();
    });
  }

  void updateFormattedTimer() {
    setState(() {
      alreadySendTimer -= const Duration(seconds: 1);
      if (alreadySendTimer <= Duration.zero && !isAlreadySend) {
        formattedTimer = '00:00';
      } else {
        formattedTimer = DateFormat("mm:ss").format(
          DateTime.fromMillisecondsSinceEpoch(alreadySendTimer.inMilliseconds),
        );
      }
    });
  }

  void checkEmailVerified() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
      if (user.emailVerified) {
        // ignore: use_build_context_synchronously
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
        // formattedTimer = DateFormat("mm:ss").format(Duration.zero);
      });
      sendAgainCooldown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Verifikasi Email',
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
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
                  formattedTimer,
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
                  disabledBackgroundColor: Colors.redAccent[100],
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('Kirim Ulang Email'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                onPressed: () {
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
                    borderRadius: BorderRadius.circular(5),
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
  }
}
