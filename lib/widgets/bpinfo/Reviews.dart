import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  double? Rating;
  double? sumRating;
  List<num> listRating = [];
  TextEditingController comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RatingBar.builder(
        initialRating: 1,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          Rating = rating;
          print(Rating);
        },
      ),
    );
  }

/*  void rateCalculator() {
    for (var i = 0; i < listRating; i++) {
      sumRating += listRating[i];
    }

    var averageRate = (sumRating! / listRating.length);
  }*/
}
