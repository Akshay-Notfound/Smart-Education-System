import 'package:flutter/material.dart';
import 'package:smart_education_system/widgets/firebase_test_widget.dart';

class FirebaseTestScreen extends StatelessWidget {
  const FirebaseTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Test'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: FirebaseTestWidget(),
      ),
    );
  }
}