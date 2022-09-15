import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howsapp/common/utils/colors.dart';
import 'package:howsapp/common/widgets/error.dart';
import 'package:howsapp/features/auth/controller/auth_controller.dart';
import 'package:howsapp/router.dart';
import 'package:howsapp/mobile_layout_screen.dart';

import 'common/widgets/loader.dart';
import 'features/landing/screens/landing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBFIq02aGpVj0QE9L3H6ycH1tRAQkDGqb0",
        authDomain: "howsapp-53637.firebaseapp.com",
        projectId: "howsapp-53637",
        storageBucket: "howsapp-53637.appspot.com",
        messagingSenderId: "415644467601",
        appId: "1:415644467601:web:b5882c48b8bb436eb8da30",
        measurementId: "G-VPEGD70H2F",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          color: appBarColor,
        ),
      ),
      onGenerateRoute: ((settings) => generateRoute(settings)),
      home: ref.watch(userDataAuthProvider).when(
            data: (user) {
              if (user == null) {
                return const LandingScreen();
              }
              return const MobileLayoutScreen();
            },
            error: (err, trace) {
              return ErrorScreen(error: err.toString());
            },
            loading: () => const Loader(),
          ),
    );
  }
}
