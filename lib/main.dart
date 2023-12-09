import 'package:flutter/material.dart';
import 'package:intial_proj1/pages/calculator_page.dart';
import 'package:intial_proj1/pages/greeting_page.dart';
import 'package:intial_proj1/pages/notes_page.dart';
import 'package:intial_proj1/pages/weather_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => GreetingsPage(),
        '/home': (context) => MyHomePage(
          title: 'Home',
        ),
        '/calculator': (context) => Calculator(),
        '/weather': (context) => WeatherPage(),
        '/notes': (context) => NotesPage(),

      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //This function created Tool cards on homepage
  Widget ToolCard(String text, String route){
    return Container(
      height: 200,
      child: Card(
        margin: EdgeInsets.all(20),
        child: InkWell(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, route);
          },
          child: Center(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Text(text, style: TextStyle(fontSize: 20, color: Colors.deepPurple),),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.spaceBetween,
          children: [

            ToolCard("Calculator", "/calculator"),
            ToolCard("Weather", "/weather"),
            ToolCard("Notes", "/notes"),
          ]),
    );
  }
}
