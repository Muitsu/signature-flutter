import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screenshot/screenshot.dart';

class TypeSignature extends StatefulWidget {
  const TypeSignature({super.key});

  @override
  State<TypeSignature> createState() => _TypeSignatureState();
}

class _TypeSignatureState extends State<TypeSignature> {
  final ssCtrl = ScreenshotController();
  final signCtrl = TextEditingController();
  double gap10 = 10;
  String signature = "";
  List<TextStyle> fontOption = [
    GoogleFonts.sassyFrass(),
    GoogleFonts.mySoul(),
    GoogleFonts.qwitcherGrypen()
  ];
  late TextStyle selectedOption;
  @override
  void initState() {
    super.initState();
    selectedOption = fontOption.first;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Type Signature'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: size.height * .25,
                  width: size.width * .8,
                  color: Colors.grey[300]!,
                  child: Screenshot(
                      controller: ssCtrl,
                      child: FittedBox(
                          fit: BoxFit.fill,
                          child: Text(
                            signature,
                            style: selectedOption,
                          ))),
                ),
              ),
              SizedBox(height: gap10 + 4),
              const Text('Signature'),
              TextFormField(
                controller: signCtrl,
                onChanged: (val) => setState(() => signature = val),
              ),
              SizedBox(height: gap10 + 4),
              const Text('Font Style'),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      fontOption.length,
                      (idx) => Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: FilterChip(
                                selected: selectedOption == fontOption[idx],
                                onSelected: (val) {
                                  setState(
                                      () => selectedOption = fontOption[idx]);
                                },
                                label: Text('Text', style: fontOption[idx])),
                          )),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    ssCtrl
                        .capture(delay: const Duration(milliseconds: 10))
                        .then((bytes) async {
                      _previewSign(bytes!);
                    }).catchError((onError) {
                      debugPrint(onError);
                    });
                  },
                  child: const Text("Preview")),
            ],
          ),
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
