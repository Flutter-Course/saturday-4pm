import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roovies/helpers/dummy_data.dart';
import 'package:roovies/models/person.dart';
import 'package:roovies/providers/persons_provider.dart';

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
          Person person =
              Provider.of<PersonsProvider>(context).trendingPersons[index];
          return Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Expanded(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      person.posterUrl,
                    ),
                  ),
                  flex: 8,
                ),
                Expanded(
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        person.name,
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
