import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presmaflix/app/bloc/app/app_bloc.dart';
import 'package:presmaflix/app/bloc/content/content_bloc.dart';
import 'package:presmaflix/app/bloc/user/user_bloc.dart';
import 'package:presmaflix/app/bloc/video/video_bloc.dart';
import 'package:presmaflix/app/cubits/auth/auth_cubit.dart';
import 'package:presmaflix/app/cubits/bottomNavigation/bottom_navigation_cubit.dart';
import 'package:presmaflix/app/cubits/login/login_cubit.dart';
import 'package:presmaflix/app/cubits/logout/logout_cubit.dart';
import 'package:presmaflix/app/cubits/signup/signup_cubit.dart';
import 'package:presmaflix/app/repositories/firestore/auth/auth_repo.dart';
import 'package:presmaflix/app/repositories/firestore/content/content_repository.dart';
import 'package:presmaflix/app/repositories/firestore/user/user_repo.dart';
import 'package:presmaflix/app/repositories/firestore/video/video_repository.dart';
import 'package:presmaflix/bloc_observer.dart';
import 'firebase_options.dart';
import 'package:presmaflix/config/routing/routes.dart';
import 'package:presmaflix/config/themes.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider(
          create: (context) => AuthRepository(
            userRepository: context.read<UserRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => ContentRepository(),
        ),
        RepositoryProvider(
          create: (context) => VideoRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => AuthCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => LoginCubit(
              context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => LogoutCubit(
              context.read<AuthRepository>(),
              context.read<AppBloc>(),
            ),
          ),
          BlocProvider(
            create: (context) => SignupCubit(
              context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => UserBloc(
              userRepository: context.read<UserRepository>(),
            )..add(
                LoadUser(),
              ),
          ),
          BlocProvider(
            create: (context) => BottomNavigationCubit(),
          ),
          BlocProvider(
            create: (context) => ContentBloc(
              contentRepository: context.read<ContentRepository>(),
            )..add(
                LoadContents(),
              ),
          ),
          BlocProvider(
            create: (context) => VideoBloc(
              videoRepository: context.read<VideoRepository>(),
            )..add(LoadVideos()),
          ),
        ],
        child: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            final router = AppRouter();
            log(state.status.toString(), name: 'main.dart');
            if (state.status == AppStatus.authenticated) {
              log('appState: $state', name: 'main.dart');
              router.appState = state;
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Presmaflix',
                theme: PresmaflixThemes.darkTheme,
                onGenerateRoute: router.onRoute,
              );
            }
            // else if (state.status == AppStatus.unauthenticated) {
            //   log('appState: $state', name: 'main.dart');
            //   router.appState = state;
            //   return MaterialApp(
            //     debugShowCheckedModeBanner: false,
            //     title: 'Presmaflix',
            //     theme: PresmaflixThemes.darkTheme,
            //     onGenerateRoute: router.onRoute,
            //   );
            // }
            // router.appStatus =
            //     context.select((AppBloc bloc) => bloc.state.status);
            log('app status: ${router.state}', name: 'main.dart');
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Presmaflix',
              theme: PresmaflixThemes.darkTheme,
              onGenerateRoute: router.onRoute,
            );
          },
        ),
      ),
    );
  }
}
