import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presmaflix/app/cubits/signup/signup_cubit.dart';
import 'package:presmaflix/app/helpers/functions.dart';
import 'package:presmaflix/app/helpers/text_input_validator.dart';
import 'package:presmaflix/config/themes.dart';
import 'package:presmaflix/ui/widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    // TextEditingController nameController = TextEditingController(text: '');
    // TextEditingController emailController = TextEditingController(text: '');
    // TextEditingController passwordController = TextEditingController(text: '');

    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state.status == SignupStatus.submitting) {
          if (formKey.currentState!.validate()) {
            loading(context);
          }
        } else if (state.status == SignupStatus.success) {
          loading(context, isLoading: false);
          Navigator.of(context).pop();
        } else if (state.status == SignupStatus.error) {
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
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            'Register',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 17,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          shadowColor: Colors.grey,
          elevation: 0.5,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 85),
                      const SizedBox(height: 35),
                      _FullNameInput(),
                      const SizedBox(height: 20),
                      _EmailInput(),
                      const SizedBox(height: 20),
                      _PasswordInput(),
                      const SizedBox(height: 50),
                      _SignupButton(formKey: formKey),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _SignupButton extends StatelessWidget {
  _SignupButton({required this.formKey});
  GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            context
                .read<SignupCubit>()
                .signUpFormSubmitted(formKey.currentState!.validate());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
          ),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text('Register'),
            ),
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class _FullNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextFieldWidget(
          label: const Text('Nama Lengkap'),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (fullName) {
            context.read<SignupCubit>().nameChanged(fullName);
          },
          validator: TextInputValidator.validateFullName,
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFieldWidget(
          label: const Text('Email'),
          onChanged: (email) {
            context.read<SignupCubit>().emailChanged(email);
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: TextInputValidator.validateEmail,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFieldWidget(
          label: const Text('Password'),
          obscureText: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: TextInputValidator.validatePassword,
          onChanged: (password) {
            context.read<SignupCubit>().passwordChanged(password);
          },
        );
      },
    );
  }
}
