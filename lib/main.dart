// ignore_for_file: avoid_unnecessary_containers, unnecessary_const

import 'package:flutter/material.dart';

void main() {
  runApp(
    Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(color: Colors.blueGrey),
          child: const Center(
            child: Text("Hello", textDirection: TextDirection.ltr),
          ),
        ),
      ),
    )
  );
}
