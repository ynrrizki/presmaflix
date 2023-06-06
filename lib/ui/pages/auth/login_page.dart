import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presmaflix/app/cubits/auth/auth_cubit.dart';
import 'package:presmaflix/config/themes.dart';
import 'package:presmaflix/ui/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController(
      text: '',
    );
    final TextEditingController passwordController = TextEditingController(
      text: '',
    );
    final formKey = GlobalKey<FormState>();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 85),
                  Text(
                    'Selamat Datang!',
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
                  TextFieldWidget(
                    controller: emailController,
                    label: const Text('Email'),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                              .hasMatch(value)) {
                        return "Enter correct email";
                      } else {
                        return emailController.text;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    controller: passwordController,
                    label: const Text('Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "must enter your password";
                      } else {
                        return passwordController.text;
                      }
                    },
                  ),
                  const SizedBox(height: 50),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/menu',
                          (route) => false,
                        );
                      } else if (state is AuthFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red[200],
                            content: Text(state.error),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              const snackBar =
                                  SnackBar(content: Text('Submitting form'));
                              scaffoldKey.currentState!
                                  .showBottomSheet((context) => snackBar);
                            }
                            context.read<AuthCubit>().signIn(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                          ),
                          child: const Center(
                              child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Text('Login'),
                          )),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {
                          // context.read<AuthCubit>().signIn(
                          //       email: emailController.text,
                          //       password: passwordController.text,
                          //     );
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/home',
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                        ),
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text('Login'),
                        )),
                      );
                    },
                  ),
                  const SizedBox(height: 35),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/menu',
                        (route) => false,
                      );
                    },
                    listenWhen: (previous, current) {
                      if (current is AuthGoogleSuccess) {
                        return true;
                      } else {
                        return false;
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          context.read<AuthCubit>().signInWithGoogle();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: kPrimaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Text('Sign In with Google'),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/auth-regis');
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
