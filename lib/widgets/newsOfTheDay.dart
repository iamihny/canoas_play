// ignore_for_file: missing_required_param

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'image_container.dart';

class NewsOfTheDay extends StatefulWidget {
  const NewsOfTheDay({Key key}) : super(key: key);

  @override
  State<NewsOfTheDay> createState() => _NewsOfTheDay();
}

class _NewsOfTheDay extends State<NewsOfTheDay> {
  int _current = 0;
  final CarouselController _controller = CarouselController();


  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('noticias').orderBy('titulo').limit(5).snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.hasError){
            return Text('Error: ${snapshot.error}');
          } 


          switch (snapshot.connectionState){
            case ConnectionState.waiting:
              const LinearProgressIndicator();
              break;
            default: 
              return 
              Column(
                children: [
                  CarouselSlider.builder(
                      itemCount: snapshot.data.docs.length,
                      carouselController: _controller,
                      options: CarouselOptions(
                          height: 200,
                          aspectRatio: 16/9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 2),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          onPageChanged: (index, reason) { 
                            // if (_current != index)
                            //  setState(() {
                              //      _current = index;  
                            //  }); 
                          },
                          scrollDirection: Axis.horizontal,
                      ),
                      itemBuilder: (BuildContext context, int index, int pageViewIndex) =>
                        InkWell(
                          onTap: (){
                             Navigator.pushNamed(context, '/articles/'+snapshot.data.docs[index]['url']);
                          },
                          child: ImageContainer(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  height: 100,
                                  imageUrl: snapshot.data.docs[index]['imageUrl'],
                                  child: Card(
                                    // ignore: sort_child_properties_last
                                    child: Text(snapshot.data.docs[index]['titulo'],  
                                               style: Theme.of(context)
                                                          .textTheme
                                                          .headlineSmall
                                                          .copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
                                    color: Colors.transparent,
                                  ),
                                ), 
                             

                        ),
                       
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(snapshot.data.docs.length, (index) => 
                        GestureDetector(
                          onTap: () => _controller.animateToPage(index),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Colors.black)//(Theme.of(context).brightness == Brightness.dark
                                       // ? Colors.white
                                      //  : Colors.black)
                                    .withOpacity(0.4)),
                          ),
                       )                      
                      ).toList(),
                    )

                        /*
                        GestureDetector(
                          onTap: () => _controller.animateToPage(1),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(_current == 1 ? 0.9 : 0.4)),
                          ),
                       )
                    */
                    /*
                    ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) { 
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(index),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(_current == index ? 0.9 : 0.4)),
                          ),
                        );                        

                      }
                    )      */          

                ],
              );
      
          }          

          return Container(
            child: const Text(''),
          );                  
      }

    );

  }


}