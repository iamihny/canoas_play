import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/article_model.dart';
import '../widgets/custom_tag.dart';
import '../widgets/image_container.dart';
import 'package:flutter_html/flutter_html.dart';

class ArticleScreen extends StatelessWidget {
  final ID;

  ArticleScreen({this.ID});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('noticias').where('url', isEqualTo: this.ID).snapshots(),
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.hasError){
            return Text('Error: ${snapshot.error}');
          } 
          
          switch (snapshot.connectionState){
            case ConnectionState.waiting:
              const LinearProgressIndicator();
              break;
            default:
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true, 
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                     return Column(
                       children: [
                         ImageContainer(
                            width: double.infinity,
                            imageUrl: snapshot.data.docs[index]['imageUrl'],
                            child: Scaffold(
                              appBar: AppBar(
                                iconTheme: const IconThemeData(color: Colors.white),
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                              backgroundColor: Colors.transparent,
                              extendBodyBehindAppBar: true,
                              //body: _NewsHeadline(article: snapshot.data.docs[index]),
                            ),
                         ),
                         _NewsBody(article: snapshot.data.docs[index])
                       ],
                     );
                    /* 
                    return ImageContainer(
                      width: double.infinity,
                      imageUrl: snapshot.data.docs[index]['imageUrl'],
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        appBar: AppBar(
                          iconTheme: const IconThemeData(color: Colors.white),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        extendBodyBehindAppBar: true,
                        body: ListView(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text('TELA DA NOTICIA'+this.ID.toString()),
                            _NewsHeadline(article: snapshot.data.docs[index]),
                            _NewsBody(article: snapshot.data.docs[index])
                          ],
                        ),
                      ),
                    ); */


                  }
                            
                );
    
          }
          
          return Container(
            child: const Text(''),
          );

      }
    ); 

  }
}

class _NewsBody extends StatelessWidget {
  const _NewsBody({
    Key key,
    this.article,
  }) : super(key: key);

  final article;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              CustomTag(
                backgroundColor: Colors.black,
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundImage: NetworkImage(
                      article['imageUrl'],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    article['autor'],
                    style: Theme.of(context).textTheme.bodyMedium.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              CustomTag(
                backgroundColor: Colors.grey.shade200,
                children: [
                  const Icon(
                    Icons.timer,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '8 h',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(width: 10),
              CustomTag(
                backgroundColor: Colors.grey.shade200,
                children: [
                  const Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '800',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            article['titulo'],
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Html(
            data:article['texto'],   
            onLinkTap: (url, _, __, ___) {
               launchUrl(Uri.parse(url));
            }      
          ),
          
          /*
          Text(
            article['texto'],
            style:
                Theme.of(context).textTheme.bodyMedium.copyWith(height: 1.5),
          ),*/

          const SizedBox(height: 20),
          GridView.builder(
              shrinkWrap: true,
              itemCount: 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.25,
              ),
              itemBuilder: (context, index) {
                return ImageContainer(
                  width: MediaQuery.of(context).size.width * 0.42,
                  imageUrl: article['imageUrl'],
                  margin: const EdgeInsets.only(right: 5.0, bottom: 5.0),
                );
              })
        ],
      ),
    );
  }
}

class _NewsHeadline extends StatelessWidget {
  const _NewsHeadline({
    Key key,
    this.article,
  }) : super(key: key);

  final article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          CustomTag(
            backgroundColor: Colors.grey.withAlpha(150),
            children: [
              Text(
                'Canoas',
                style: Theme.of(context).textTheme.bodyMedium.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            article['titulo'],
            style: Theme.of(context).textTheme.headlineSmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.25,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            article['titulo'],
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
