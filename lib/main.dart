// ignore_for_file: avoid_unnecessary_containers, unnecessary_const, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:convert';
//import "dart:io";
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'TestApp',
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
    routes: {'/about': (BuildContext context) => const AboutPage()},
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomePage'),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Container(child: const FlutterLogo(size: 300)),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/chat.jpg")),
                ),
              ),
              const Text('Welcome to TestApp',
                  style: TextStyle(height: 2, fontSize: 30)),
              Container(
                //margin: const EdgeInsets.only(left: 52.5, right: 52.5),
                alignment: Alignment.center,
                //height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LightState()),
                        );
                      },
                      child: const Text('Go to SeeCarsPage'),
                    ),
                    const Text('  '),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutPage()),
                        );
                      },
                      child: const Text('Go to AboutPage'),
                    )
                  ],
                ),
              ),
              Container(
                //margin: const EdgeInsets.only(left: 52.5, right: 52.5),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutPage()),
                        );
                      },
                      child: const Text('Go to AboutPage'),
                    ),
                    const Text('  '),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutPage()),
                        );
                      },
                      child: const Text('Go to AboutPage'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AboutPage'),
      ),
      body: Column(
        children: [
          const FittedBox(
            child: FlutterLogo(
              size: 100,
            ),
          ),
          const Text(
              'TaxisApp is an app created to see a list of app and their drivers.'),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Go Back'),
          ),
        ],
      ),
    );
  }
}

//Creating a class user to store the data;
// class Car {
//   // ignore: unused_field
//   final ObjectKey id;
//   final String some_paper;
//   final String year;
//   final String driver_id;

//   @override
//   String toString() {
//     return 'name: $some_paper, salary: $year';
//   }

//   Car({
//     required this.id,
//     required this.some_paper,
//     required this.year,
//     required this.driver_id,
//   });
// }

class LightState extends StatefulWidget {
  const LightState({super.key});

  @override
  State<LightState> createState() => SeeCarsPage();
}

class SeeCarsPage extends State<LightState> {
  Future<List<dynamic>> getRequest() async {
    //replace your restFull API here.
    String url = "http://localhost:3000/cars/getall";
    var response = await http.get(Uri.parse(url));
    //print('res ${response.body}');
    //Creating a list to store input data;
    // List<Car> cars = [];
    // for (var singleCar in responseData) {
    //   Car car = Car(
    //       id: singleCar["_id"],
    //       some_paper: singleCar["some_paper"],
    //       year: singleCar["year"],
    //       driver_id: singleCar["driver_id"]
    //     );
    //   //Adding user to the list.
    //   cars.add(car);
    // }
    return json.decode(response.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SeeCarsPage'),
      ),
      body: Container(
        child: FutureBuilder(
          future: getRequest(),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Container(
                child: const Center(
                  child: const CircularProgressIndicator(),
                ),
              );
            } else if (!snapshot.hasData) {
              //debugPrint('snapshot ${snapshot.data}');
              return const Text('No data returned');
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (ctx, int index) => ListTile(
                  title: Text(snapshot.data[index]['some_paper']),
                  subtitle: Text(snapshot.data[index]['year']),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
