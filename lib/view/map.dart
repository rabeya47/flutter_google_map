import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  final Completer<GoogleMapController> _controller = Completer();


  static const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(23.81735, 90.37050),
      zoom: 19
   );

  final List<Marker> _markers = const <Marker>[
    Marker(
        markerId:MarkerId('1'),
        position: LatLng(23.81735, 90.37050),
        infoWindow: InfoWindow(
          title: 'The title of the marker'
        )
    )
  ];


  Future<Position> getUserCurrentLocation() async{
    await Geolocator.requestPermission().then((value) {

    }).onError((error, stackTrace){
      print("Error" + error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('Google Map '),
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          getUserCurrentLocation().then((value){
            print('my current location');
            print(value.latitude.toString()+" "+ value.longitude.toString());
          });
        },
        child: Icon(Icons.local_activity),
      ),
    );
  }
}
