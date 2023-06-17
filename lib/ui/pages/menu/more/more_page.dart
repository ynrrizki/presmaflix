import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presmaflix/app/bloc/app/app_bloc.dart';
import 'package:presmaflix/app/bloc/user/user_bloc.dart';
import 'package:presmaflix/app/cubits/logout/logout_cubit.dart';
import 'package:presmaflix/app/helpers/helpers.dart';
import 'package:presmaflix/app/models/user/user.dart';
import 'package:presmaflix/config/themes.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    log(user.toString(), name: 'More Page');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'More',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        shadowColor: Colors.grey,
        elevation: 0.5,
      ),
      body: BlocConsumer<LogoutCubit, LogoutState>(
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
          return Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    _AccountCard(user: user),
                    Card(
                      color: Colors.black,
                      shadowColor: Colors.grey,
                      elevation: 0.2,
                      child: ListTile(
                        leading: const Icon(Icons.search_outlined),
                        title: const Text('Search'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () => Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pushNamed('/search'),
                      ),
                    ),
                    Card(
                      color: Colors.black,
                      shadowColor: Colors.grey,
                      elevation: 0.2,
                      child: ListTile(
                        leading:
                            const Icon(Icons.notifications_active_outlined),
                        title: const Text('Notifications'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {},
                      ),
                    ),
                    Card(
                      color: Colors.black,
                      shadowColor: Colors.grey,
                      elevation: 0.2,
                      child: ListTile(
                        leading: const Icon(Icons.settings_outlined),
                        title: const Text('Settings'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                _LogoutButton(),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class _AccountCard extends StatelessWidget {
  const _AccountCard({
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      bloc: context.read<UserBloc>()..add(LoadUserById(id: user.id)),
      builder: (context, state) {
        if (state is UserByIdLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderOnForeground: false,
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                onTap: () {},
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: CachedNetworkImageProvider(
                    state.user.avatar ??
                        'https://ui-avatars.com/api/?name=${state.user.name}',
                    scale: 2,
                  ),
                ),
                title: Text('${state.user.name}'),
                subtitle: Text('${state.user.email}'),
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderOnForeground: false,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              onTap: () {},
              title: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: () {
          context.read<LogoutCubit>().logOut();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          padding: const EdgeInsets.symmetric(vertical: 15),
          minimumSize: const Size(double.infinity, 25),
        ),
        child: const Text('Logout'),
      ),
    );
  }
}
