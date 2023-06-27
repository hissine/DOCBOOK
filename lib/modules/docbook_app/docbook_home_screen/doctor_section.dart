import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_chat_screen/docbook_chat_screen.dart';
import 'package:ramdan_proj/shared/components/components.dart';

import '../../../shared/styles/colors.dart';
import 'doctor_page.dart';

class DoctorsSection extends StatelessWidget {
  const DoctorsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(
            left: 10,
            top: 10,
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  navigateTo(
                    context,
                    const DoctorScreen(),
                  );
                },
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      const Image(
                        image: AssetImage(
                          'assets/images/man.png',
                        ),
                        height: 230,
                        width: 220,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: 200,
                        height: 90,
                        decoration:
                            BoxDecoration(
                                color: Colors.white.withOpacity(0.8)
                            ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12,bottom: 12,right: 10,top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Dr Zahraa Magdy',
                                      style:
                                          TextStyle(color: defColor, fontSize: 14),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: (){
                                        navigateTo(context, ChatScreen());
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: defColor,
                                          shape: BoxShape.circle
                                        ),
                                        child: Icon(
                                          Ionicons.chatbubble_ellipses_outline,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Expanded(
                                child:  Text(
                                  "Obstetrician & Gynaecologist",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                    shadows: [
                                      Shadow(blurRadius: 2)
                                    ],
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                    shadows: [
                                      Shadow(blurRadius: 2)
                                    ],
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                    shadows: [
                                      Shadow(blurRadius: 2)
                                    ],
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                    shadows: [
                                      Shadow(blurRadius: 2)
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '4.7',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        itemCount: 4,
      ),
    );
  }
}
