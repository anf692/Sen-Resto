import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sen_restau/acceuil1.dart';
import 'package:sen_restau/connexion.dart';
import 'package:sen_restau/provider/AuthProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return MaterialApp(
          home: authProvider.token == null ? AccueilPage() : Connexion(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
