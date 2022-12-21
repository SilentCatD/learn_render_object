import 'package:flutter/material.dart';
import 'package:learn_render_object/custom_box.dart';
import 'package:learn_render_object/custom_expanded.dart';

import 'custom_column.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(body: SafeArea(child: MyHomePage())),
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
    return Container(
      color: Colors.red,
      child: CustomColumn(
        children: const [
          CustomExpanded(),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "A definitive guide to Render Object in Flutter",
              style: TextStyle(
                fontSize: 32,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "bycreativeornotcreative",
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
          CustomExpanded(),
          CustomBox(
            flex: 3,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
