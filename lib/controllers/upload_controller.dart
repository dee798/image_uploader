import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../model/upload_image.dart';
import '../service/upload_service.dart';

class UploadController extends GetxController {
  final images = <UploadImage>[].obs;
  final _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    Connectivity().onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        uploadPendingImages();
      }
    });
  }

  void pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final image = UploadImage(path: pickedFile.path, status: 'Pending');
      images.add(image);
      final result = await Connectivity().checkConnectivity();
      if (result != ConnectivityResult.none) {
        uploadImage(image);
      }
    }
  }

  void uploadImage(UploadImage image) async {
    image.status = 'Uploading';
    images.refresh();
    try {
      await UploadService.upload(File(image.path));
      image.status = 'Success';
      Fluttertoast.showToast(msg: 'Upload success');
    } catch (_) {
      image.status = 'Failed';
      Fluttertoast.showToast(msg: 'Upload failed please check your internet');
    }
    images.refresh();
  }

  void uploadPendingImages() {
    for (var image in images.where((img) => img.status == 'Pending')) {
      uploadImage(image);
    }
  }

  void retryUpload(UploadImage image) {
    uploadImage(image);
  }
}