import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(runtimeType.toString()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/type');
        },
      ),
    );
  }
}
