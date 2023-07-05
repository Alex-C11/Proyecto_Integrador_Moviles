
import 'dart:ffi';

import 'package:asistencia_app/ui/escuela/escuela_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/AppTheme.dart';

class QRCodeWidget extends StatefulWidget {
  const QRCodeWidget({super.key});

  @override
  State<QRCodeWidget> createState() => _QRCodeWidgetState();
}

class _QRCodeWidgetState extends State<QRCodeWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: "qr");
  QRViewController? controller;
  String result = "";

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Qr Code Scanner"),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              )),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "Scan Result: $result",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainEscuela()),
                      );
                    },
                    child: Text("Volver"),
                  ),
                  IconButton(
                      icon: Icon(Icons.task),
                      color: AppTheme.themeData.colorScheme.primary,
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title:
                                Text("Mensaje de confirmacion"),
                                content: Text("Desea Registrase?"),
                                actions: [
                                  FloatingActionButton(
                                    child: const Text('CANCEL'),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop('Failure');
                                    },
                                  ),
                                  FloatingActionButton(
                                      child: const Text('ACCEPT'),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop('Success');
                                      })
                                ],
                              );
                        });
                      }),
                ],
              ))
        ],
      ),
    );
  }
}