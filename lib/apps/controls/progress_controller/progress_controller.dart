import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../constrains.dart';
import '../../../services/auth_service.dart';
import '../../data/models/progress.dart';

class ProgressC extends GetxController {
  final Rx<List<Progres>> _listProgress = Rx<List<Progres>>([]);
  final Rx<List<File?>> _listImage = Rx<List<File?>>([]);
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
  Future<String> uploadImageToStorage(
      Uint8List file, String child, String parrent) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('progress')
        .child(AuthService.instance.currentUser!.uid)
        .child(parrent)
        .child(child);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String dowloadUrl = await snap.ref.getDownloadURL();
    return dowloadUrl;
  }

  List<File?> listImageTest = [null, null, null, null];

  Future pickImageGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      _listImage.value[onFocus.value] = imageTemp;
      update();
    } catch (e) {
      //ignore: avoid_print
      print('image test: Failed to pick image $e');
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
    }
  }

  Future<String> upProressToFirebase(DateTime datetime) async {
    try {
      List<String> list = [];
      int count = 0;
      for (var item in listImage) {
        // ignore: unnecessary_null_comparison
        if (item == null) {
          disposeAll();
          return 'Upload Image is failed';
        }
        String imagePath = await uploadImageToStorage(
            item.readAsBytesSync(),
            '${datetime.year}-${datetime.month}-${datetime.day} $count',
            DateFormat().add_MMMEd().format(datetime));
        list.add(imagePath);
        count++;
      }
      firestore
          .collection('users')
          .doc(AuthService.instance.currentUser!.uid)
          .collection('progress')
          .add(
        {
          'id': 'tempId',
          'date': datetime,
          'image': list,
        },
      );
      disposeAll();
      return 'Upload Image sucess';
    } catch (e) {
      return 'Upload Image is failed';
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

  void disposeAll() {
    _listImage.value = [null, null, null, null];
    onFocus.value = 1;
    update();
    Get.back();
  }

  @override
  void onInit() async {
    super.onInit();
    _listImage.value = [null, null, null, null];
    await fetchAllProgress();
  }
}
