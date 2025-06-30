import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_uploader/widgets/widget.dart';
import '../controllers/upload_controller.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UploadController>();

    return Scaffold(
      backgroundColor: Colors.white,
     appBar: AppBar(
       toolbarHeight: 80,
       backgroundColor: Colors.white,
       title: Row(
         children: [
           Chip(
             padding: EdgeInsets.all(8),
             backgroundColor: Colors.white,
               label: text1('Uploader status', 15, Colors.black)),
           Spacer(),
           InkWell(
             onTap: controller.pickImage,
             child: Chip(
               side: BorderSide.none,
               backgroundColor: Color(0xFF43E6D4),
               label: Row(
                 children: [
                   text1('Pick image', 15, Colors.black),
                   SizedBox(width: 5),
                   Icon(Icons.image_outlined,color: Colors.red,)
                 ],
               ),
             ),
           ),
         ],
       ),
     ),
      body: Obx(() => images()),
    );
  }
}