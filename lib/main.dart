import 'package:ecommerce/models/hive_cartmodel.dart';
import 'package:ecommerce/screens/google_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart';
import 'models/hive_model.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();
  Hive.registerAdapter(HiveModelAdapter());
  Hive.registerAdapter(HiveCartmodelAdapter());
  await Hive.openBox<HiveModel>('wishlist');
  await Hive.openBox<HiveCartmodel>('cart');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopista',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: GooglePage(),
    );
  }
}
