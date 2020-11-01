import 'package:flutter/material.dart';
import 'package:roovies/helpers/dummy_data.dart';

class PersonsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemExtent: 150,
        itemCount: DummyData.nowPlaying.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Expanded(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      DummyData.nowPlaying[index]['poster_url'],
                    ),
                  ),
                  flex: 8,
                ),
                Expanded(
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        DummyData.nowPlaying[index]['movie_name'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  flex: 2,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
