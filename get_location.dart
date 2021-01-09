import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';



class GetLocationWidget extends StatefulWidget {

  const GetLocationWidget({Key key}) : super(key: key);

  @override
  _GetLocationWidgetState createState() => _GetLocationWidgetState();
}

class _GetLocationWidgetState extends State<GetLocationWidget> {

  final Location location = Location();
  
  String _error;
  
  LocationData _location;
 
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Location: ' + (_error ?? '${_location ?? "unknown"}'),
          style: Theme.of(context).textTheme.bodyText1,
          ),
        Row(

        children: <Widget>[
          RaisedButton(
            child: const Text('Get Location'),
            onPressed: _getLocation,
            )
        ],
      ),
      ],
    );
  }

  Future<void> _getLocation() async{
    setState(() {
      _error = null;
    });

    try{
       final LocationData _locationRequest = await location.getLocation();
       setState(() {
         _location = _locationRequest;
       });
    } on PlatformException catch(err){
        setState(() {
          _error = err.code;
        });
    }
  }
}