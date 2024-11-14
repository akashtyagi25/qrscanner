import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode_scanner/qrscanner.dart';

class Resultscreen extends StatelessWidget {
  const Resultscreen({super.key,required this.closeScreen,required this.code});
  final String code;
  final Function() closeScreen;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
       appBar: AppBar(
        leading: IconButton(onPressed: (){
          closeScreen();
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios_new,color: Colors.black87,)),
        title: const Text("qrscanner",style: TextStyle(fontSize: 17),),
      centerTitle: true,
      ),
      body:  Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              //show qr code
              QrImageView(data: code,size: 150,version: QrVersions.auto,),





              const Text("output result",style: TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.bold),),
            const  SizedBox(height: 10,),
              Text(code,textAlign: TextAlign.center,style: TextStyle(color: Colors.black54,fontSize: 16),),
            const  SizedBox(height: 10,),
              SizedBox(
                width: MediaQuery.of(context).size.width-100,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: (){
                    Clipboard.setData(ClipboardData(text: code));
                  }, child:const Text(
                   "copy",style: TextStyle(color: Colors.white,fontSize: 16),
                )),
              )
          ],
        ),
      ),
    );
  }
}