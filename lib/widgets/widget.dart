import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/upload_controller.dart';

Widget text1(String text, double siz, [Color? color]) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize: siz,
      color: color,
      fontWeight: FontWeight.w500,
    ),
  );
}

Widget images() {
  final controller = Get.find<UploadController>();

  Color getStatusColor(String status) {
    switch (status) {
      case 'Success':
        return Colors.green;
      case 'Failed':
        return Colors.red;
      case 'Uploading':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  return ListView.builder(
    itemCount: controller.images.length,
    itemBuilder: (_, index) {
      final file = controller.images[index];
      final name = file.path.split('/').last;
      final fileSize = File(file.path).lengthSync();
      final fileDate = File(file.path).lastAccessedSync();
      return ListTile(
        title: text1(name, 14),
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.grey
            )
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child:Image.file(File(file.path), fit: BoxFit.cover,
                height: 100,
                width: 100,
              )),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text1("${(fileSize / 1024).toStringAsFixed(1)} KB · ${fileDate.toLocal()}", 12),
            text1("Status: ${file.status}", 12, getStatusColor(file.status)),
          ],
        ),
        trailing: file.status == 'Failed'
            ? IconButton(
          icon: const Icon(Icons.refresh, color: Colors.black,),
          onPressed: () => controller.retryUpload(file),
        )
            : null,
      );
    },
  );
}