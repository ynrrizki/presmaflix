import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class VerifPage extends StatefulWidget {
  const VerifPage({Key? key}) : super(key: key);

  @override
  State<VerifPage> createState() => _VerifPageState();
}

class _VerifPageState extends State<VerifPage> {
  bool isAlreadySend = false;
  late Timer timer;
  late Duration alreadysendtimer;
  late String formatedtimer;

  @override
  void initState() {
    alreadysendtimer = const Duration(seconds: 30);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateFormattedTimer();
      checkEmailVerified();
    });
    formatedtimer = DateFormat("mm:ss").format(
      DateTime.fromMillisecondsSinceEpoch(alreadysendtimer.inMilliseconds),
    );

    FirebaseAuth.instance.currentUser!.sendEmailVerification();
    setState(() {
      isAlreadySend = true;
    });
    sendAgainCooldown();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void updateFormattedTimer() {
    setState(() {
      alreadysendtimer -= const Duration(seconds: 1);
      formatedtimer = DateFormat("mm:ss").format(
        DateTime.fromMillisecondsSinceEpoch(alreadysendtimer.inMilliseconds),
      );
    });
  }

  void checkEmailVerified() {
    final User user = FirebaseAuth.instance.currentUser!;
    user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (Route<dynamic> route) => false,
      );
    }
  }

  void sendAgainCooldown() {
    Timer(const Duration(seconds: 30), () {
      setState(() {
        isAlreadySend = false;
      });
    });
  }

  void sendVerification() {
    FirebaseAuth.instance.currentUser!.sendEmailVerification();
    setState(() {
      isAlreadySend = true;
    });
    sendAgainCooldown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifikasi Email'),
      ),
      body: Column(
        children: [
          const Center(
            child: Text('Silahkan Cek Email Anda'),
          ),
          if (!isAlreadySend)
            Center(
              child: ElevatedButton(
                onPressed: sendVerification,
                child: const Text('Kirim Ulang Email'),
              ),
            )
          else
            Center(
              child: Text(formatedtimer),
            )
        ],
      ),
    );
  }
}
