import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/workout_controller/workout_plan_controller.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/workout_detail2_screen.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ExerciseCard extends StatefulWidget {
  const ExerciseCard({
    Key? key,
    required double widthDevice,
    required this.e,
  })  : _widthDevice = widthDevice,
        super(key: key);

  final double _widthDevice;
  final Map<String, dynamic> e;

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  Uint8List? bytes;
  final _workoutPlanController = Get.find<WorkoutPlanController>();
  Future<Uint8List?> getThumbnailImage() async {
    if (_workoutPlanController.listThumbnail[widget.e['id']] != null) {
      return _workoutPlanController.listThumbnail[widget.e['id']];
    }
    try {
      final thumbnailByte = await VideoThumbnail.thumbnailData(
        video: widget.e['url'],
        imageFormat: ImageFormat.PNG,
        maxHeight: 100,
        quality: 75,
      );
      _workoutPlanController.listThumbnail[widget.e['id']] = thumbnailByte!;
      return thumbnailByte;
    } catch (e) {
      print('getThumbnailImage: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          () => WorkoutDetail2Screen(idExercise: widget.e['id']),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              Container(
                height: widget._widthDevice / 6,
                width: widget._widthDevice / 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: FutureBuilder(
                  future: getThumbnailImage(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        if (snapshot.data != null) {
                          bytes = snapshot.data as Uint8List;
                          return Hero(
                            tag: widget.e['id'],
                            child: FadeInImage(
                              image: MemoryImage(bytes!),
                              placeholder: const AssetImage(
                                  'assets/images/place_holder.png'),
                              fit: BoxFit.cover,
                              fadeOutDuration:
                                  const Duration(milliseconds: 500),
                              fadeInDuration: const Duration(milliseconds: 500),
                              placeholderFit: BoxFit.cover,
                            ),
                          );
                        }
                      }
                    }
                    return Image.asset('assets/images/place_holder.png');
                  },
                ),
              ),
              const SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(
                        _workoutPlanController
                            .exercises.value[widget.e['id']]!.exerciseName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      )),
                  Text(
                    '00:${widget.e['time']}s',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                  child: const Icon(Icons.arrow_forward_ios,
                      color: Colors.grey, size: 17),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
