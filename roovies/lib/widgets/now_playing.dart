import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:roovies/helpers/dummy_data.dart';

class NowPlaying extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.5;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: PageIndicatorContainer(
        indicatorSelectorColor: Theme.of(context).accentColor,
        shape: IndicatorShape.circle(size: 5),
        padding: EdgeInsets.all(5),
        length: 5,
        child: PageView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                  height: height,
                  width: width,
                  child: Image.network(
                    DummyData.nowPlaying[index]['poster_url'],
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor.withOpacity(0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [0, 0.9]),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  top: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.play_circle_outline,
                      color: Theme.of(context).accentColor,
                      size: 50,
                    ),
                    onPressed: () {},
                  ),
                ),
                Positioned(
                  bottom: 50,
                  left: 10,
                  child: Container(
                    width: width * 0.5,
                    child: Text(
                      DummyData.nowPlaying[index]['movie_name'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
