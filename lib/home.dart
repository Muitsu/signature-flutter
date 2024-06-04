import 'package:flutter/material.dart';
import 'package:signature_test/draw_signature.dart';
import 'package:signature_test/type_signature.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            button('Draw Signature',
                onPressed: () => go(const DrawSignature())),
            button('Type Signature',
                onPressed: () => go(const TypeSignature())),
            button('Upload Signature', onPressed: () => go(const Scaffold())),
          ],
        ),
      ),
    );
  }

  Widget button(String data, {required void Function()? onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(onPressed: onPressed, child: Text(data)),
    );
  }

  go(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }
}
