import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:roovies/helpers/dummy_data.dart';

class MoviesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4 - 48,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemExtent: 140,
        itemCount: DummyData.nowPlaying.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    DummyData.nowPlaying[index]['poster_url'],
                    fit: BoxFit.cover,
                  ),
                  flex: 7,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      DummyData.nowPlaying[index]['movie_name'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          child: Text(
                            '8.0',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        FittedBox(
                          child: RatingBar(
                            initialRating: 4,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.all(4),
                            itemBuilder: (context, index) {
                              return Icon(
                                Icons.star,
                                color: Colors.amber,
                              );
                            },
                            ignoreGestures: true,
                            onRatingUpdate: null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
