import 'package:flutter/material.dart';
import 'package:flutter_tape_measure/TapeMeasure.dart';

//12.07.23
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
          child: SizedBox(
            width: 300,
            height: 100,
            child: TapeMeasureWidget(
                value: 47.0,
                min: 40.0,
                max: 100.0,
                step: 1.0,
                unit: 'cm',
                onChanged: (double value) {
                  print("new value:$value");
                }),
          ),
        ));
  }
}
