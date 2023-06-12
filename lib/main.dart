import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:presmaflix/app/bloc/rating/rating_bloc.dart';
import 'package:presmaflix/app/bloc/watchlist/watchlist_bloc.dart';
import 'package:presmaflix/app/cubits/watchlist/watchlist_cubit.dart';
import 'package:presmaflix/app/repositories/firestore/rating/rating_repo.dart';
import 'package:presmaflix/app/repositories/firestore/watchlist/watchlist_repo.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/bloc/blocs.dart';
import 'app/cubits/cubits.dart';
import 'app/repositories/firestore/repositories.dart';
import 'package:presmaflix/config/routing/routes.dart';
import 'package:presmaflix/config/themes.dart';

Future<void> main() async {
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
        RepositoryProvider(
          create: (context) => RatingRepository(),
        ),
        RepositoryProvider(
          create: (context) => WatchlistRepository(),
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
              // context.read<AppBloc>(),
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
          BlocProvider(
            create: (context) => RatingBloc(
              ratingRepository: context.read<RatingRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SearchBloc(
              contentBloc: context.read<ContentBloc>(),
              ratingBloc: context.read<RatingBloc>(),
            )..add(LoadSearch()),
          ),
          BlocProvider(
            create: (context) => WatchlistBloc(
              watchlistRepository: context.read<WatchlistRepository>(),
            )..add(LoadWatchlists()),
          ),
          BlocProvider(
            create: (context) => WatchlistCubit(
              context.read<WatchlistRepository>(),
              context.read<WatchlistBloc>(),
            ),
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
