import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presmaflix/app/bloc/content/content_bloc.dart';
import 'package:presmaflix/app/cubits/bottomNavigation/bottom_navigation_cubit.dart';
import 'package:presmaflix/app/repositories/content/content_repository.dart';
import 'firebase_options.dart';
import 'package:presmaflix/config/routing/routes.dart';
import 'package:presmaflix/config/themes.dart';

void main() async {
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
    final router = AppRouter();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ContentRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
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
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Presmaflix',
          theme: PresmaflixThemes.darkTheme,
          onGenerateRoute: router.onRoute,
        ),
      ),
    );
  }
}
