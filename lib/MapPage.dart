import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'API/api.dart';
import 'package:latlong/latlong.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<Map<dynamic, dynamic>> getData() async {
    //creating a dictionary
    Map<dynamic, dynamic> myMap = {};
    dynamic latValue;
    dynamic lonValue;
    Api myResult = Api();
    dynamic myResponse = await myResult.getMethod();
    myResponse.forEach((data) {
      latValue = data['latitude'];
      lonValue = data['longitude'];
    });
    myMap["latitude"] = latValue;
    myMap["longitude"] = lonValue;
    return myMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Your Pet"),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<dynamic, dynamic>>(
          future: getData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return FlutterMap(
              options: MapOptions(
                  center: LatLng(
                      double.parse(
                        snapshot.data["latitude"],
                      ),
                      double.parse(
                        snapshot.data["longitude"],
                      )),
                  zoom: 17.0),
              layers: [
                new TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c']),
                new MarkerLayerOptions(markers: [
                  Marker(
                      width: 45.0,
                      height: 45.0,
                      point: new LatLng(
                          double.parse(
                            snapshot.data["latitude"],
                          ),
                          double.parse(
                            snapshot.data["longitude"],
                          )),
                      builder: (context) => new Container(
                            child: IconButton(
                              icon: Icon(Icons.location_on),
                              color: Colors.red,
                              iconSize: 45.0,
                              onPressed: () {
                                print('Marker Tapped');
                              },
                            ),
                          ))
                ])
              ],
            );
          }),
    );
  }
}
