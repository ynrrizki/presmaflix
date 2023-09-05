// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presmaflix/presentation/cubits/login/login_cubit.dart';
import 'package:presmaflix/utils/functions.dart';
import 'package:presmaflix/utils/text_input_validator.dart';
import 'package:presmaflix/presentation/config/themes_config.dart';
import 'package:presmaflix/presentation/widgets/widgets.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.logInWithCredentials) {
            loading(context);
          } else if (state.status == LoginStatus.signInWithGoogle) {
            loading(context);
          } else if (state.status == LoginStatus.notVerify) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/verif',
              (route) => false,
            );
          } else if (state.status == LoginStatus.verify) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (route) => false,
            );
          } else if (state.status == LoginStatus.error) {
            loading(context, isLoading: false);
            final snackBar = SnackBar(
              content: Text(
                state.info,
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
          return SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.all(15.0),
                  child: LoginForm(formKey: formKey),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 85),
              Text(
                'Selamat Datang',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 24,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Temukan Dunia Film yang Menakjubkan!',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 35),
              const SizedBox(height: 20),
              _EmailInput(),
              const SizedBox(height: 20),
              _PasswordInput(),
              const SizedBox(height: 50),
              _LoginButton(
                formKey: widget.formKey,
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        _SignInGoogleButton(),
        const SizedBox(height: 50),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/register');
                },
                child: Text(
                  'Create an account',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 17,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SignInGoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      child: ElevatedButton(
        onPressed: () {
          context.read<LoginCubit>().logInWithGoogle();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: kPrimaryColor,
          elevation: 0,
          // shape: RoundedRectangleBorder(
          //   side: BorderSide(
          //     color: kPrimaryColor,
          //   ),
          // ),
        ),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.g_mobiledata_rounded),
                Text('Sign In with Google'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _LoginButton extends StatelessWidget {
  _LoginButton({required this.formKey});
  GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      child: ElevatedButton(
        onPressed: () {
          context
              .read<LoginCubit>()
              .logInWithCredentials(formKey.currentState!.validate());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
        ),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text('Login'),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFieldWidget(
          label: const Text('Email'),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (email) {
            context.read<LoginCubit>().emailChanged(email);
          },
          validator: TextInputValidator.validateEmail,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFieldWidget(
          label: const Text('Password'),
          obscureText: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (password) {
            context.read<LoginCubit>().passwordChanged(password);
          },
          validator: TextInputValidator.validatePassword,
        );
      },
    );
  }
}