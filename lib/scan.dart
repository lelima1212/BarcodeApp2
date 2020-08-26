import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class ScanScreen extends StatefulWidget{
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barCode = "";
  List <String> barcodelist = new List();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Code Scanner'),
        centerTitle: true,
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(Icons.scanner, size: 40,),
            SizedBox(width: 10,),
            Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: RaisedButton(
                        color: Colors.purple,
                        textColor: Colors.white,
                        splashColor: Colors.blueGrey,
                        onPressed: scan,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.scanner, size: 40,),
                              SizedBox(width: 10,),
                              Column(
                                children: <Widget>[
                                  Text('Camera Scan',
                                    style: TextStyle(fontSize: 20.0),),
                                  SizedBox(height: 2,),
                                  Text("Click here for camera scan")
                                ],
                              )
                            ]
                        )
                    )
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(barCode, textAlign: TextAlign.center,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Future scan() async{
    try{
      String barcode = await BarcodeScanner.scan();
      setState(() {
        this.barCode = barcode;
        this.barcodelist.add(barcode);
      });
    } on PlatformException catch(e) {
      if (e.code == BarcodeScanner.CameraAccessDenied){
        setState(() {
          this.barCode = "Camera permission not granted";
        });
      } else {
        setState(() {
          this.barCode = "Unknown error: $e";
        });
      }
    } on FormatException{
      setState(() {
        this.barCode = 'null (User returned using the "back" button before scanning anything, Result)';
      });
    } catch (e){
      setState(() {
        this.barCode = 'Unknown error: $e';
      });
    }
  }
}