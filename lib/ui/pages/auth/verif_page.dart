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
  Timer? cooldown;
  late Duration alreadySendTimer;
  late String formattedTimer;

  @override
  void initState() {
    super.initState();
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
      formattedTimer = DateFormat("mm:ss").format(
        DateTime.fromMillisecondsSinceEpoch(alreadySendTimer.inMilliseconds),
      );
    });
  }

  void checkEmailVerified() {
    final User user = FirebaseAuth.instance.currentUser!;
    user.reload();
    if (user.emailVerified) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (route) => false,
      );
    } else {
      startTimer();
      sendVerification();
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
              child: Text(formattedTimer),
            ),
        ],
      ),
    );
  }
}
