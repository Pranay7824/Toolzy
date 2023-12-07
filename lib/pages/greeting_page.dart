import "package:flutter/material.dart";
import 'package:carousel_slider/carousel_slider.dart';

class GreetingsPage extends StatefulWidget {
  const GreetingsPage({super.key});

  @override
  State<GreetingsPage> createState() => _GreetingsPageState();
}

class _GreetingsPageState extends State<GreetingsPage> {
  final List<String> greetings = [
    'assets/images/currency_calculator.png',
    'assets/images/calculator.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome to Toolzy", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
          CarouselSlider(
            items: greetings.map((greeting) {
              return Container(
                // margin: EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    // padding: EdgeInsets.all(20),
                    color: Colors.blue,
                    child: Image.asset(
                      greeting,
                      fit: BoxFit.fill,
                      width: 500,
                    ),
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height*85/100,
              enlargeFactor: 1.5,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 2),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              pauseAutoPlayOnTouch: true,
              aspectRatio: 2,
            ),
          ),
        ],
      ),
    );
  }
}
