import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_application_1/models/detailed_planet.dart';

Future<DetailedPlanet> fetchDetailedPlanet() async {
  print("hello from dave");
  final response = await http
      .get(Uri.parse('https://neonfish.net/mars_api.json'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("API response received!");
    print(jsonDecode(response.body));
    return DetailedPlanet.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class MarsScreen extends StatefulWidget {
  @override
  _MarsScreenState createState() => _MarsScreenState();
}

class _MarsScreenState extends State<MarsScreen> {
  late Future<DetailedPlanet> futureDetailedPlanet;
  final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
  bool showDistanceToSun = false;

  @override
  void initState() {
    super.initState();
    futureDetailedPlanet = fetchDetailedPlanet();
  }

  void toggleDistance() {
    setState(() {
      showDistanceToSun = !showDistanceToSun;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<DetailedPlanet>(
        future: futureDetailedPlanet,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  snapshot.data!.name,
                  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0)
                ),
                Image(
                  image: NetworkImage(snapshot.data!.imagePath)
                ),
                ElevatedButton(
                  style: style,
                  onPressed: toggleDistance,
                  child: const Text('Toggle'),
                ),
                Visibility(
                  visible: showDistanceToSun,
                  child: Text('Distance to Sun: ${snapshot.data!.distanceToSun} km'),
                ),
                Visibility(
                  visible: !showDistanceToSun,
                  child: Text('Distance to Earth: ${snapshot.data!.distanceToEarth} km')
                )
              ],
            );
          }
          return const CircularProgressIndicator();
        },
      )
    );
  }
}