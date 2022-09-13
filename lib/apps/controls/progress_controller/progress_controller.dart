import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constrains.dart';
import '../../../services/auth_service.dart';
import '../../data/models/progress.dart';

class ProgressC extends GetxController {
  final Rx<List<Progres>> _listProgress = Rx<List<Progres>>([]);
  final RxList<File?> _listImage = [null, null, null, null].obs;
  final RxInt onFocus = 0.obs;

  List<File?> get listImage => _listImage.value;
  List<Progres> get listProgress => _listProgress.value;
  List<Map<String, dynamic>> basicListImage = [
    {
      'title': 'Front',
      'image': 'assets/images/front.png',
      'index': 0,
    },
    {
      'title': 'Left',
      'image': 'assets/images/front.png',
      'index': 1,
    },
    {
      'title': 'Back',
      'image': 'assets/images/front.png',
      'index': 2,
    },
    {
      'title': 'Right',
      'image': 'assets/images/front.png',
      'index': 3,
    }
  ];
  Future<String> uploadImageToStorage(Uint8List file, String child) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('progress')
        .child(AuthService.instance.currentUser!.uid)
        .child(child);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String dowloadUrl = await snap.ref.getDownloadURL();
    return dowloadUrl;
  }

  Future pickImageGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      _listImage.value[onFocus.value] = imageTemp;
      update();
    } catch (e) {
      //ignore: avoid_print
      print('Failed to pick image: $e');
    }
  }

  Future pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      _listImage.value[onFocus.value] = imageTemp;
      update();
    } catch (e) {
      //ignore: avoid_print
      print('Failed to pick image: $e');
      rethrow;
    }
  }

  Future<void> fetchAllProgress() async {
    try {
      _listProgress.bindStream(
        firestore
            .collection('users')
            .doc(AuthService.instance.currentUser!.uid)
            .collection('progress')
            .snapshots()
            .map(
          (event) {
            List<Progres> result = [];
            for (var item in event.docs) {
              result.add(Progres.fromSnap(item));
            }
            return result;
          },
        ),
      );
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchAllProgress();
  }
}
