import 'package:canoas_play/widgets/breaking_news.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:canoas_play/models/article_model.dart';
import 'package:canoas_play/widgets/custom_tag.dart';
import '../widgets/NewsOfTheDay.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/image_container.dart';



class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  Future<void> initState() async {
    Uri.base.toString();

  }   


  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    Article article = Article.articles[0];

    return Scaffold(
      //bottomNavigationBar: const BottomNavBar(index: 0),
      extendBodyBehindAppBar: true,
      body: ListView(padding: EdgeInsets.zero, children: [  
         Container(
            color:Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Image.asset("assets/logoblack.jpg")   
              ],
            ),

         ),
         const SizedBox(height: 10),     
         //_NewsOfTheDay(article: article),
         NewsOfTheDay(),

        BreakingNews(),
      ]),
    );
  }
}


