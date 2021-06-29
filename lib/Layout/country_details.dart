import 'package:flutter/material.dart';

class CountryDetails extends StatelessWidget {
  CountryDetails({Key key, this.details}) : super(key: key);
  final Map<dynamic, dynamic> details;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('The Name : ',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.red,
                          fontWeight: FontWeight.bold)),
                  Text(
                    '${details['name']}',
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('The Capital : ',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.red,
                          fontWeight: FontWeight.bold)),
                  Text(
                    '${details['capital']}',
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
