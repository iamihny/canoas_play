
import 'package:canoas_play/router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutterzilla_fixed_grid/flutterzilla_fixed_grid.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/article_model.dart';
import '../screens/article_screen.dart';
import 'image_container.dart';

class BreakingNews extends StatelessWidget {

  BreakingNews({key});
  
  @override
  Widget build(BuildContext context) {
    final articles = Article.articles;

  @override
    void initState() {
      //super.initState();   
    }  

    return Padding(
      padding: const EdgeInsets.fromLTRB(100,20,100,20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Breaking News',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              //Text('More', style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
          const SizedBox(height: 20),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('noticias').orderBy('titulo').snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
                  if (snapshot.hasError){
                    return Text('Error: ${snapshot.error}');
                  } 

                  switch (snapshot.connectionState){
                    case ConnectionState.waiting:
                      const LinearProgressIndicator();
                      break;
                    default:
                    
                      return Center(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true, 
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {                       
                             // print(snapshot.data.docs[index].documentID);
                             // print(snapshot.data.docs[index]['titulo']);
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Container(
                                        width: MediaQuery.of(context).size.width * 0.5,
                                      // margin: const EdgeInsets.only(right: 4),
                                        child: InkWell(                                        
                                          onTap: () {
                                            Navigator.pushNamed(context, '/articles/'+snapshot.data.docs[index]['url']);
                                            /*
                                            Navigator.pushNamed(
                                              context,
                                              ArticleScreen.routeName,
                                              arguments: articles[index],
                                            );*/ 
                                          },
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ImageContainer(
                                                width: MediaQuery.of(context).size.width * 0.5,
                                                height: 300,
                                                imageUrl: snapshot.data.docs[index]['imageUrl'],
                                                //child: Image.network(snapshot.data.docs[index]['imageUrl']),  
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                snapshot.data.docs[index]['titulo'],
                                                maxLines: 2,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    .copyWith(
                                                        fontWeight: FontWeight.bold, height: 1.5),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                  '8 hours ago',
                                                  style: Theme.of(context).textTheme.bodySmall),
                                              const SizedBox(height: 5),
                                              // ignore: prefer_interpolation_to_compose_strings
                                              Text('by '+snapshot.data.docs[index]['autor'],
                                                  style: Theme.of(context).textTheme.bodySmall),
                                              const SizedBox(height: 20),    
                                            ],
                                          ),
                                        ),
                                      ),
                                  ),

                                ],

                              );                              

                            }                          
                          ),
                    ); 
                  }                    

                  return Container(
                    child: const Text(''),
                  );
            }
          ),

        ],
      ),
    );
  }


}


