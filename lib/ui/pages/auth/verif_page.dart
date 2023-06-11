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
  bool isVerified = false;
  late Timer timer;
  late Duration alreadysendtimer;
  late String formatedtimer;

  @override
  void initState() {
    final isUserVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isUserVerified) {
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
    }
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
    formatedtimer = DateFormat("mm:ss").format(
        DateTime.fromMillisecondsSinceEpoch(alreadysendtimer.inMilliseconds));
    super.initState();
  }

  checkEmailVerified() {
    final isUserVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (isUserVerified) {
      timer.cancel();
      Navigator.pushNamedAndRemoveUntil(
          context, '/home', (Route<dynamic> route) => false);
    }
  }

  sendAgainCooldown() {
    setState(() {
      alreadysendtimer = const Duration(seconds: 30);
      isAlreadySend = false;
    });
  }

  sendVerification() {
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
          if (isAlreadySend)
            Center(
              child: ElevatedButton(
                onPressed: sendVerification(),
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
