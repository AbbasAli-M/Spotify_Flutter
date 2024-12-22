import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotify_flutter/core/config/theme/app_theme.dart';
import 'package:spotify_flutter/presentation/auth/pages/signin.dart';
import 'package:spotify_flutter/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:spotify_flutter/presentation/home/pages/home.dart';
import 'package:spotify_flutter/presentation/splash/pages/splash.dart';
import 'package:spotify_flutter/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    Platform.isAndroid
        ? Firebase.initializeApp(
            options: const FirebaseOptions(
                apiKey: 'AIzaSyADInk9i3q0B_aTz279XrM-ngjoR_bK8fM',
                appId: '1:952323330096:android:ac0ef466ca0bc88d549df5',
                messagingSenderId: '952323330096',
                projectId: 'spotifyflutter-94f0a'),
          )
        : await Firebase.initializeApp();

    print('Firebase Initialized');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => ThemeCubit())],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) {
          return MaterialApp(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: mode,
            debugShowCheckedModeBanner: false,
            home: SplashPage(),
          );
        },
      ),
    );
  }
}
