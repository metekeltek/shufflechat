import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shufflechat/models/UserData.dart';
import 'package:shufflechat/services/authProvider.dart';
import 'package:shufflechat/services/dbProvider.dart';
import 'package:shufflechat/ui/shuffleScreen.dart';
import 'ui/login.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Phoenix(
    child: MultiProvider(
      providers: [
        Provider<AuthProvider>(
            create: (_) => AuthProvider(FirebaseAuth.instance)),
        Provider<DatabaseProvider>(
            create: (_) => DatabaseProvider(
                FirebaseFirestore.instance, FirebaseStorage.instance)),
        FutureProvider<UserData>(
          initialData: UserData(),
          create: (_) => DatabaseProvider(
                  FirebaseFirestore.instance, FirebaseStorage.instance)
              .getUserData(FirebaseAuth.instance.currentUser.uid),
        ),
        StreamProvider(
            create: (context) => context.read<AuthProvider>().authState),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.amberAccent[700],
        ),
        debugShowCheckedModeBanner: false,
        title: 'Shuffle Chat',
        home: Authenticate(),
      ),
    ),
  ));
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
