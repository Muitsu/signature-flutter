import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

extension ChangeColor on SignatureController {
  SignatureController onSetPenColor(Color color) {
    return SignatureController(
      penStrokeWidth: 5,
      penColor: color,
    );
  }
}

class DrawSignature extends StatefulWidget {
  const DrawSignature({super.key});

  @override
  State<DrawSignature> createState() => _DrawSignatureState();
}

class _DrawSignatureState extends State<DrawSignature> {
  late SignatureController _controller;
  List<Color> colorOption = [Colors.black, Colors.blue, Colors.red];
  late Color selectedOption;
  @override
  void initState() {
    selectedOption = colorOption.first;
    _controller = SignatureController(
      penStrokeWidth: 5,
      penColor: selectedOption,
    );
    _controller
      ..addListener(() => debugPrint('Value changed'))
      ..onDrawEnd = () => setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draw Signature'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Signature(
                key: const Key('signature'),
                controller: _controller,
                height: size.height * .25,
                width: size.width * .8,
                backgroundColor: Colors.grey[300]!,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _controller.clear();
                      setState(() {});
                    },
                    child: const Text("Clear")),
                ElevatedButton(
                    onPressed: () {
                      _controller
                          .toPngBytes()
                          .then((bytes) => _previewSign(bytes!));
                    },
                    child: const Text("Preview")),
              ],
            ),
            const Text('Color Style'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    colorOption.length,
                    (idx) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: FilterChip(
                              selected: selectedOption == colorOption[idx],
                              onSelected: (val) {
                                _controller =
                                    _controller.onSetPenColor(colorOption[idx]);
                                setState(
                                    () => selectedOption = colorOption[idx]);
                              },
                              label: Text('Text',
                                  style: TextStyle(color: colorOption[idx]))),
                        )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _previewSign(Uint8List bytes) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Image.memory(
                bytes,
                fit: BoxFit.contain,
              ),
            ));
  }
}
