import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState()=> _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  final GlobalKey globalKey = GlobalKey();
  String qrdata = "";
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code Generator"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            RepaintBoundary(
              key: globalKey,
              child: Container(
                  color: Colors.white,
                  child: Center(
                    child: qrdata.isEmpty
                        ? Text(
                          "Ingrese un dato para Generar Codigo Qr",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                            ),
                          ) :
                    QrImageView(
                    data: qrdata,
                    version: QrVersions.auto,
                    size: 200,
                  )

                  )
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Ingrese texto",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value){
                  setState(() {
                    qrdata = value;
                  });
                },
              ),
            )
          ]),
      ),
    );
  }
}