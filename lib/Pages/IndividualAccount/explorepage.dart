import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 100 + 150,
              width: 400,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Card(
                elevation: 5,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://firebasestorage.googleapis.com/v0/b/final-project-c6df8.appspot.com/o/images%2F20230620_113124.jpg?alt=media&token=5b549204-0733-4441-9a69-f2dd362c3657")),
                  ),
                  alignment: Alignment.bottomLeft,
                  child: const Text("Yet in Bahir Dar"),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
