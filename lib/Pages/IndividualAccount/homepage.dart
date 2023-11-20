import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../widgets/RecentlyAdded.dart';
import 'package:final_project/widgets/featured.dart';
import 'package:final_project/widgets/MostRated.dart';
import 'package:final_project/Pages/IndividualAccount/Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePage createState() => _MyHomePage();
}

TextEditingController searchbar = TextEditingController();

class _MyHomePage extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 238, 240, 235),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search_rounded,
                size: 30,
              ),
              color: const Color.fromARGB(255, 229, 143, 101),
            ),
          )
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 238, 240, 235),
      drawer: const DrawerPage(),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  'Let\'s',
                  style: TextStyle(
                      fontSize: 35,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )),
            const Padding(
                padding: EdgeInsets.fromLTRB(21, 5, 0, 0),
                child: Text(
                  'Explore',
                  style: TextStyle(
                      letterSpacing: 2,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: Material(
                  borderRadius: BorderRadius.circular(15),
                  elevation: 3,
                  child: CarouselSlider(
                      items: [
                        Container(
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://firebasestorage.googleapis.com/v0/b/final-project-c6df8.appspot.com/o/images%2F20230620_113124.jpg?alt=media&token=5b549204-0733-4441-9a69-f2dd362c3657")),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "https://firebasestorage.googleapis.com/v0/b/final-project-c6df8.appspot.com/o/images%2F20230620_113434.jpg?alt=media&token=310f5776-9a40-446f-b634-177a184272e4"))),
                        ),
                        Container(
                          margin: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "https://firebasestorage.googleapis.com/v0/b/final-project-c6df8.appspot.com/o/images%2F20230620_113615.jpg?alt=media&token=7a824fc5-29f1-44ad-90b9-6079ee467302"))),
                        ),
                      ],
                      options: CarouselOptions(
                        height: 170.0,
                        aspectRatio: 16 / 9,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayCurve: Curves.bounceOut,
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        viewportFraction: 1,
                      )),
                )),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    child: Text(
                      'Recently Added',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Color.fromARGB(255, 66, 106, 90),
                    size: 35,
                  ),
                  iconSize: 40,
                )
              ],
            ),
            //   RecentlyAdded(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    child: Text(
                      'Most Rated',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Color.fromARGB(255, 66, 106, 90),
                    size: 35,
                  ),
                  iconSize: 40,
                )
              ],
            ),
            MostRated(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    child: Text(
                      'Featured',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Color.fromARGB(255, 66, 106, 90),
                    size: 35,
                  ),
                  iconSize: 40,
                )
              ],
            ),
            featured()
          ],
        ),
      ),
    );
  }
}
