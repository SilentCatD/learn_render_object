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
    return CustomColumn(
      alignment: CustomColumnAlignment.center,
      children: const [
        CustomExpanded(
          flex: 2,
        ),
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
        CustomBox(
          color: Colors.red,
          flex: 3,
        ),
      ],
    );
  }
}
