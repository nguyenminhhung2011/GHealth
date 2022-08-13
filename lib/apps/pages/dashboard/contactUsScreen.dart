import 'package:flutter/material.dart';
import 'package:gold_health/apps/template/misc/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../global_widgets/screenTemplate.dart';

class ContactUsScren extends StatelessWidget {
  const ContactUsScren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widthDevice = MediaQuery.of(context).size.width;
    var heightDevice = MediaQuery.of(context).size.height;
    final List<Map<String, dynamic>> listProfile = [
      {
        'name': 'Truong Huynh Duc Hoang',
        'position': 'Front End, Back End',
        'Id': '20120483',
        'facebook': 'https://www.facebook.com/truonghuynh.duchoang',
        'instagram': 'https://www.instagram.com/truonghuynhduchoang/',
        'email': 'hungnguyen.201102ak@gmail.com',
        'git': 'hoangankin2211',
        'image': 'assets/images/hoang.png'
      },
      {
        'name': 'Nguyen Minh Hung',
        'position': 'Front End, Back End',
        'Id': '20120491',
        'facebook': 'https://www.facebook.com/profile.php?id=100048245345813',
        'instagram': 'https://www.instagram.com/minhhung201102/',
        'email': 'hungnguyen.201102ak@gmail.com',
        'git': 'minhunsocute',
        'image': 'assets/images/hung.png'
      },
    ];
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: ScreenTemplate(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_ios,
                      color: Colors.black, size: 18),
                  Hero(
                    tag: 'Hero tag',
                    child: Text(
                      'Profile',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontSize: 18,
                            fontFamily: "Sen",
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: heightDevice / 5,
              width: widthDevice * 0.8,
              child: Image.asset(
                'assets/images/intro.png',
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'GOLD HEALTH',
                style: TextStyle(
                    color: AppColors.primaryColor1,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'App is made by Hung ,Hoang from VNU HCMC-University of Science (VNU HCMC-US)',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 19),
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'TEAM MEMBERS',
                style: TextStyle(
                    color: AppColors.primaryColor1,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: listProfile
                  .map(
                    (e) => Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor1.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(e['image']),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(-2, -3),
                                  blurRadius: 2,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                e['name'],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              Text(
                                e['position'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/github.png',
                                    height: 15,
                                    width: 15,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    e['git'],
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  )
                                ],
                              ),
                              const SizedBox(height: 5),
                              Container(
                                height: 30,
                                width: widthDevice - 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blue,
                                ),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final url = e['facebook'];
                                    // ignore: deprecated_member_use
                                    if (await canLaunch(url)) {
                                      // ignore: deprecated_member_use
                                      await launch(url);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      primary: Colors.transparent,
                                      shadowColor: Colors.transparent),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.facebook,
                                          color: Colors.white, size: 14),
                                      SizedBox(width: 5),
                                      Text(
                                        'Facebook',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                height: 30,
                                width: widthDevice - 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color.fromARGB(255, 238, 41, 212)
                                      .withOpacity(0.4),
                                ),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final url = e['instagram'];
                                    // ignore: deprecated_member_use
                                    if (await canLaunch(url)) {
                                      // ignore: deprecated_member_use
                                      await launch(url);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      primary: Colors.transparent,
                                      shadowColor: Colors.transparent),
                                  child: Row(
                                    children: [
                                      Image.asset('assets/images/instagram.png',
                                          height: 15, width: 15),
                                      const SizedBox(width: 5),
                                      const Text(
                                        'Instagram',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                height: 30,
                                width: widthDevice - 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final toEmail = e['email'];
                                    final subject = "Contact with us";
                                    final message = '';
                                    final url =
                                        'mailto:$toEmail?subject=${subject}&body=${Uri.encodeFull(message)}';
                                    // ignore: deprecated_member_use
                                    if (await canLaunch(url)) {
                                      // ignore: deprecated_member_use
                                      await launch(url);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      primary: Colors.transparent,
                                      shadowColor: Colors.transparent),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.mail,
                                          color: Colors.black, size: 14),
                                      SizedBox(width: 5),
                                      Text(
                                        'Mail',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
