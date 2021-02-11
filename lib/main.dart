import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shufflechat/models/UserData.dart';
import 'package:shufflechat/services/authProvider.dart';
import 'package:shufflechat/services/dbProvider.dart';
import 'package:shufflechat/ui/shuffleScreen.dart';
import 'ui/login.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  runApp(
    Phoenix(
      child: EasyLocalization(
        supportedLocales: [
          Locale('en'),
          Locale('de'),
        ],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: MultiProvider(
          providers: [
            Provider<AuthProvider>(
                create: (_) => AuthProvider(FirebaseAuth.instance)),
            Provider<DatabaseProvider>(
                create: (_) => DatabaseProvider(
                    FirebaseFirestore.instance,
                    FirebaseStorage.instance,
                    FirebaseAuth.instance.currentUser.uid)),
            Provider<UserData>(create: (_) => UserData()),
            // FutureProvider<UserData>(
            //   initialData: UserData(),
            //   create: (_) => DatabaseProvider(
            //           FirebaseFirestore.instance, FirebaseStorage.instance, FirebaseAuth.instance.currentUser.uid)
            //       .getUserData(FirebaseAuth.instance.currentUser.uid),
            // ),
            StreamProvider(
                create: (context) => context.read<AuthProvider>().authState),
            StreamProvider(
                create: (context) =>
                    context.read<DatabaseProvider>().userDataStream),
          ],
          child: Main(),
        ),
      ),
    ),
  );
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primaryColor: const Color(0xffff9600),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Shuffle Chat',
      home: Authenticate(),
    );
  }
}

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return ShuffleScreen();
    }

    return Login();
  }
}
