import 'package:flutter/material.dart';

class TypeScreen extends StatelessWidget {
  const TypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(runtimeType.toString()),
    );
  }
}
