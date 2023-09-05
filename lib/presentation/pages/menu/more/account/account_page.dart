import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presmaflix/presentation/bloc/user/user_bloc.dart';
import 'package:presmaflix/presentation/config/themes_config.dart';
import 'package:presmaflix/presentation/cubits/logout/logout_cubit.dart';
import 'package:presmaflix/utils/functions.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

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
            title: Text(
              'Atur Akun',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios_new),
            ),
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            shadowColor: Colors.grey,
            elevation: 0.5,
          ),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 25, top: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Card(
                      color: Colors.black,
                      shadowColor: Colors.grey,
                      elevation: 0.2,
                      child: ListTile(
                        visualDensity: VisualDensity.comfortable,
                        leading: const Icon(Icons.logout),
                        isThreeLine: true,
                        title: const Text('Keluar'),
                        subtitle: const Text(
                          'Yakin mau keluar? Pas balik harus masuk akun lagi, ya.',
                          style: TextStyle(fontSize: 12),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        // onTap: () => context.read<LogoutCubit>().logOut(),
                        onTap: () async => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Konfirmasi'),
                            content: const Text(
                                'Apakah Anda yakin ingin keluar dari akun ini?'),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: kPrimaryColor,
                                ),
                                child: const Text('BATAL'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: kPrimaryColor,
                                ),
                                child: const Text('OK'),
                                onPressed: () {
                                  context.read<LogoutCubit>().logOut();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.black,
                      shadowColor: Colors.grey,
                      elevation: 0.2,
                      child: ListTile(
                        visualDensity: VisualDensity.comfortable,
                        leading: const Icon(Icons.delete_outline),
                        isThreeLine: true,
                        title: const Text(
                          'Hapus Akun',
                        ),
                        subtitle: const Text(
                          'Akunmu akan dihapus secara permanen. Jadi, kamu gak bisa lagi akses riwayat tontonan dan detail lainnya dari akunmu.',
                          style: TextStyle(fontSize: 12),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () async => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Konfirmasi'),
                            content: const Text(
                                'Apakah Anda yakin ingin menghapus akun?'),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: kPrimaryColor,
                                ),
                                child: const Text('BATAL'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: kPrimaryColor,
                                ),
                                child: const Text('OK'),
                                onPressed: () {
                                  context.read<UserBloc>().add(DeleteUser());
                                  context.read<LogoutCubit>().logOut();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
