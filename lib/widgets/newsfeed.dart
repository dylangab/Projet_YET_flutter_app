import 'package:flutter/material.dart';
import 'package:final_project/widgets/RecentlyAdded.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({super.key});

  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  int selectedindex = 0;
  final List<String> list = ['Recently Added', 'Most Rated', 'Interestes'];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedindex = index;

                     RecentlyAdded();
                  });
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    list[index],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: index == selectedindex
                            ? Colors.red
                            : Colors.black45),
                  ),
                ))));
  }
}
