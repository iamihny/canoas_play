
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( 
    // ignore: prefer_const_constructors
    options: FirebaseOptions(
      apiKey: "AIzaSyA87EN17AyOc5HA7Z-5VQybZXq3HDZlUFg", 
      appId: "1:188862778808:web:0b2bce5bd503a82821934d",
      messagingSenderId: "188862778808", 
      projectId: "canoasplay-f1909"
    ) 
  );

//  await FirebaseAuth.instance.signInWithEmailAndPassword(email: 'iamvihny@live.com', password: 'r4v3n4');
//  print(FirebaseAuth.instance.currentUser);  

  FluroRouter router = FluroRouter();
    router.define('/articles/:ID', handler: Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return  ArticleScreen(ID: params['ID'][0]);
    }));

    router.define('/', handler: Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return  HomeScreen();
    }));
  
  runApp( 
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CANOAS PLAY',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: HomeScreen(),
      onGenerateRoute: router.generator,
    )
  );
}


