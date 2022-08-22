import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/global_widgets/screen_template.dart';
import 'package:gold_health/apps/pages/dashboard/widgets/button_gradient.dart';
import 'package:readmore/readmore.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../routes/route_name.dart';
import '../../template/misc/colors.dart';
import 'workout_screen.dart';

class WorkoutDetail2Screen extends StatefulWidget {
  const WorkoutDetail2Screen({Key? key}) : super(key: key);

  @override
  State<WorkoutDetail2Screen> createState() => _WorkoutDetail2ScreenState();
}

//test url: https://www.youtube.com/watch?v=OsP2oNXOL1E

class _WorkoutDetail2ScreenState extends State<WorkoutDetail2Screen> {
  late YoutubePlayerController _controller;
  // late Future<void> _initializeVideoPlayerFuture;
  late String exerciseName;
  late String level;
  late String caloriesBurn;
  late String description;
  late Map<String, String> instructions;
  List<Row> listInstructions = [];
  late Map<String, String> repetitions;
  List<Row> listRepetitionsChoice = [];

  @override
  void initState() {
    super.initState();
    exerciseName = 'Barca 4 - 0 Real';
    level = 'Easy';
    caloriesBurn = '390 Calories Burn';
    description =
        'A jumping jack, also known as a star jump and called a side-straddle hop in the US military, is a physical jumping exercise performed by jumping to a position with the legs spread wide Read More...';
    instructions = {
      'Spread Your Arms':
          'To make the gestures feel more relaxed, stretch your arms as you start this movement. No bending of hands.',
      'Rest at The Toe':
          'The basis of this movement is jumping. Now, what needs to be considered is that you have to use the tips of your feet',
      'Adjust Foot Movement':
          'Jumping Jack is not just an ordinary jump. But, you also have to pay close attention to leg movements.',
      'Clapping Both Hands':
          'This cannot be taken lightly. You see, without realizing it, the clapping of your hands helps you to keep your rhythm while doing the Jumping Jack',
    };
    repetitions = {
      '30': '450',
      '35': '480',
      '40': '500',
      '45': '520',
      '50': '500',
    };

    _controller = YoutubePlayerController(
      initialVideoId: 'OsP2oNXOL1E',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    // _initializeVideoPlayerFuture = _controller.initialize();
    // _controller.setLooping(true);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    repetitions.forEach((key, value) {
      listRepetitionsChoice.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 15, child: Image.asset('assets/images/fire.png')),
            const SizedBox(width: 10),
            Text(
              '${repetitions[key] as String} Calories Burn',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
            const SizedBox(width: 10),
            RichText(
              text: TextSpan(
                text: key,
                style: const TextStyle(
                  fontFamily: 'Sen',
                  fontSize: 25,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(
                    text: '  times',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });

    instructions.forEach((key, value) {
      listInstructions.add(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 30,
            child: Text(
              listInstructions.length + 1 < 10
                  ? '0${listInstructions.length + 1}'
                  : '${listInstructions.length + 1}',
              style: const TextStyle(
                  fontFamily: 'Sen',
                  fontSize: 16.5,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 213, 170, 220),
                    width: 1,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.purple[100]!,
                        const Color.fromARGB(255, 215, 185, 221),
                        const Color.fromARGB(255, 213, 170, 220),
                      ],
                    ),
                  ),
                ),
              ),
              DottedLine(
                lineThickness: 1.5,
                lineLength: 100,
                direction: Axis.vertical,
                dashLength: 4.5,
                dashGradient: listInstructions.length != instructions.length - 1
                    ? [
                        Colors.purple[100]!,
                        const Color.fromARGB(255, 209, 159, 218)
                      ]
                    : [Colors.white, Colors.white],
              ),
            ],
          ),
          const SizedBox(width: 5),
          SizedBox(
            height: (instructions[key]!.split('').length / 10) * 8 + 20,
            width: Get.mediaQuery.size.width * 0.75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  key,
                  style: const TextStyle(
                      fontFamily: 'Sen',
                      fontSize: 16.5,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Text(
                    '${instructions[key]}',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ));
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: ScreenTemplate(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            //padding: const EdgeInsets.all(20),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryColor1,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Text(
                    'Workout Schedule',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontSize: 20),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryColor1,
                      ),
                      child: const Icon(
                        Icons.more_horiz,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15),
                height: heightDevice * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                exerciseName,
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontSize: 18),
              ),
              Text(
                '$level | $caloriesBurn',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 20),
              Text(
                'Description',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontSize: 18),
              ),
              const SizedBox(height: 10),
              ReadMoreText(
                description,
                trimLines: 3,
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Read more',
                trimExpandedText: 'Show less',
                moreStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor1,
                ),
                lessStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor1,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'How To Do It',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontSize: 18),
              ),
              const SizedBox(height: 10),
              ...listInstructions,
              const SizedBox(height: 10),
              Text(
                'Custom Repetitions',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontSize: 18),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: heightDevice * 0.2,
                child: CupertinoPicker(
                  looping: true,
                  diameterRatio: 1,
                  itemExtent: 64,
                  onSelectedItemChanged: (int value) {},
                  selectionOverlay: Container(
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          width: 1,
                          color: Colors.grey[300]!,
                        ),
                      ),
                    ),
                  ),
                  children: listRepetitionsChoice,
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
      floatingActionButton: ButtonGradient(
        height: 50,
        width: 250,
        linearGradient: LinearGradient(
          colors: [Colors.blue[200]!, Colors.blue[300]!, Colors.blue[400]!],
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WorkoutScreen()));
        },
        title: const Text(
          'Save',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}