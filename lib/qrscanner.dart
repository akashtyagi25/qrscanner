

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcode_scanner/resultscreen.dart';
 const bgColor=Color(0xfffafafa);

class Qrscanner extends StatefulWidget {
  const Qrscanner({super.key});

  @override
  State<Qrscanner> createState() => _QrscannerState();
}

class _QrscannerState extends State<Qrscanner> {
 bool isScancompleted=false;
 bool isFlashon=false;
 bool isFrontcamera=false;
 MobileScannerController controller=MobileScannerController();

void closeScreen(){
  isScancompleted=false;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      backgroundColor: bgColor,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            setState(() {
              isFlashon=!isFlashon;
            });
           controller.toggleTorch();
          }, icon: Icon(Icons.flash_on,color: isFlashon? Colors.blue : Colors.grey,)),
          
          IconButton(onPressed: (){
               setState(() {
              isFrontcamera=!isFrontcamera;
            });
           controller.switchCamera();

          }, icon: Icon(Icons.camera_front,color: isFrontcamera? Colors.blue: Colors.grey,))
        ],
        title: const Text("qrscanner",style: TextStyle(fontSize: 20),),
      centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const Expanded (
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("qr code scanning",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,),),
                  SizedBox(height: 10,),
                  Text("automatic scanning",style: TextStyle(color: Colors.black54,fontSize: 18),)
                ], 
              ),
              ),
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 300,
                      height: 300,
         
                      child: MobileScanner(
                                      controller: controller,
                                      onDetect: (barcode) {
                        if(!isScancompleted){
                          String code=barcode.barcodes.isNotEmpty ? barcode.barcodes.first.rawValue ?? '---' : '---';
                          isScancompleted=true;
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Resultscreen(
                      
                            closeScreen: closeScreen,
                            code: code,
                          )
                          )
                          );
                        }
                      
                                      },
                                      
                                     ),
                    ),
                  ),
  
                ],
              )
              ),
            Expanded(
              child: Container(
             alignment: Alignment.center,
            child:   const Text("take it easy.make it easy",style: TextStyle(color: Colors.black54,fontSize: 16),)
                )),
          ],
        ),
      ),
    );
  }
}