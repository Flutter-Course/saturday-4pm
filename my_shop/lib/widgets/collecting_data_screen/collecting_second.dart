import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:my_shop/widgets/misc/arrow_button.dart';

import 'collecting_data_title.dart';

class CollectingSecond extends StatefulWidget {
  final Function prevPage, submit;
  CollectingSecond(this.prevPage, this.submit);
  @override
  _CollectingSecondState createState() => _CollectingSecondState();
}

class _CollectingSecondState extends State<CollectingSecond> {
  bool loading;
  LatLng currentPosition;
  String currentAdderss;
  @override
  void initState() {
    super.initState();
    loading = true;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    currentPosition = LatLng(_locationData.latitude, _locationData.longitude);
    currentAdderss = await getAddress(currentPosition);
    setState(() {
      loading = false;
    });
  }

  Future<String> getAddress(LatLng position) async {
    final coordinates = new Coordinates(position.latitude, position.longitude);
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    final first = addresses.first;
    return first.addressLine;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              CollectingDataTitle(
                'One steo left,',
                'Pick your location so we can deliver to you.',
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: (loading)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Stack(
                        children: [
                          GoogleMap(
                            myLocationEnabled: true,
                            onCameraMove: (position) {
                              setState(() {
                                currentPosition = position.target;
                              });
                            },
                            onCameraIdle: () async {
                              currentAdderss =
                                  await getAddress(currentPosition);
                              setState(() {});
                            },
                            initialCameraPosition: CameraPosition(
                              target: currentPosition,
                              zoom: 16,
                            ),
                          ),
                          Card(
                            elevation: 20,
                            margin: EdgeInsets.fromLTRB(16, 60, 16, 0),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(currentAdderss),
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 35 / 2),
                              child: Icon(
                                Icons.place,
                                size: 35,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
          flex: 9,
        ),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ArrowButton.left(
              child: 'Back',
              onPressed: () {
                widget.prevPage();
              },
            ),
            ArrowButton.right(
              child: 'Submit',
              onPressed: () {
                widget.submit(currentPosition, currentAdderss);
              },
            ),
          ],
        ))
      ],
    );
  }
}
