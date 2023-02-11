import 'package:canoas_play/screens/article_screen.dart';
import 'package:canoas_play/screens/home_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  // ignore: prefer_final_fields
  static Handler _HomeScreen = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
           HomeScreen());

  // ignore: prefer_final_fields
  static Handler _articles = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          ArticleScreen(ID: params['ID'][0])); // this one is for one paramter passing...

  // lets create for two parameters tooo...
 // static Handler _mainHandler2 = Handler(
   //   handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
   //       LandingPage(page: params['name'][0],extra: params['extra'][0],));

  // ok its all set now .....
  // now lets have a handler for passing parameter tooo....


  static void setupRouter(){
    router.define(
      '/',
      handler: _HomeScreen,
    );
    router.define(
      '/articles/:ID',
      handler: _articles,
      transitionType: TransitionType.fadeIn,
    );
    /*
    router.define(
      '/main/:name/:extra',
      handler: _mainHandler2,
      transitionType: TransitionType.fadeIn,
    );*/
  }

}