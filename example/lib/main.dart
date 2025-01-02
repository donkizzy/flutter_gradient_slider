import 'package:flutter/material.dart';
import 'package:flutter_gradient_slider/flutter_gradient_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  RangeValues selectedValues = const RangeValues(0.25, 0.75);
  double sliderValue = 0.5;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientSlider(
                value: sliderValue,
                max: 100,
                min: 0,
                gradientColors: const [Colors.red, Colors.blue],
                overlayColor: Colors.white,
                inactiveTrackColor: Colors.grey.withOpacity(0.8),
                onChanged: (value) {
                  setState(() {
                    sliderValue = value;
                  });
                },
              ),
              GradientRangeSelector(
                min: 0.0,
                max: 1.0,
                values: selectedValues,
                gradientColors: const [Colors.red, Colors.blue],
                overlayColor: Colors.white,
                inactiveTrackColor: Colors.grey.withOpacity(0.8),
                trackHeight: 30,
                onChanged: (values) {
                setState(() {
                  selectedValues = values;
                });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


