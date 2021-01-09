import 'package:flutter/material.dart';
import 'package:location/location.dart';

class PermissionStatusWidget extends StatefulWidget {

  const PermissionStatusWidget({Key key}) : super(key: key);
  
  @override
  _PermissionStatusWidgetState createState() => _PermissionStatusWidgetState();
}

class _PermissionStatusWidgetState extends State<PermissionStatusWidget> {
  
  final Location location = Location();

  PermissionStatus _permissionGranted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Permission status: ${_permissionGranted ?? "unknown"}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 42),
              child: RaisedButton(
                child: const Text('Check'),
                onPressed: _checkPermissions,
              ),
            ),
            RaisedButton(
              child: const Text('Request'),
              onPressed: _permissionGranted == PermissionStatus.granted
                  ? null
                  : _requestPermission,
            )
          ],
        ),
      ],
    );
  }

  Future<void> _checkPermissions() async {
    final PermissionStatus permissionGrantedResult =
        await location.hasPermission();
    setState(() {
      _permissionGranted = permissionGrantedResult;
    });
  }

  Future<void> _requestPermission() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final PermissionStatus permissionRequestResult =
          await location.requestPermission();

      setState(() {
        _permissionGranted = permissionRequestResult;
      });
    }
  }
}
