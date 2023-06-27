import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/layout/docbook_app/cubit/cubit.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_home_screen/doctor_section.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_home_screen/scan_screen.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_search_screen/docbook_search_screen.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/cubit.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/states.dart';
import 'package:ramdan_proj/shared/components/components.dart';
import 'package:ramdan_proj/shared/components/constants.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';

import '../../../layout/docbook_app/cubit/states.dart';

class DocBookHomeScreen extends StatelessWidget {
  DocBookHomeScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  List symptoms = [
    'Heart',
    'Respiratory',
    'Bones',
    'Brain',
    'Scan Centers',
    'Pediatrics',
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocLoginCubit,DocLoginStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 350,
                  child: Stack(
                    children: [
                      Image(
                        image: const AssetImage('assets/images/home.png'),
                        color: Colors.grey.withOpacity(0.9),
                        colorBlendMode: BlendMode.modulate,
                        height: 285,
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      ),
                      Container(
                        height: 200,
                        padding: const EdgeInsets.only(top: 40, left: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Find ',
                                  style: TextStyle(
                                    color: Colors.lightBlue.shade900,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  'your desired',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),

                              ],
                            ),
                            const Text(
                              'doctors',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 92,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                          ),
                          width: double.infinity,
                          child: defaultFormField(
                            controller: searchController,
                            onTap: (){
                              navigateTo(context, SearchScreen());
                            },
                            type: TextInputType.text,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'search is not working';
                              }
                              return null;
                            },
                            label: 'Search',
                            prefix: Icons.search,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 142,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                          ),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            elevation: 8,
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(
                                18,
                              ),
                              width: 330,
                              height: 190,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          child: Column(
                                            children: [
                                              const Image(
                                                image: AssetImage(
                                                  'assets/images/heart.png',
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  'Heart',
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    color: Colors.lightBlue.shade900,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          onTap: (){
                                            navigateTo(context, SearchScreen());
                                          },
                                        ),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        child: Column(
                                          children: [
                                            const Image(
                                                image: AssetImage(
                                                    'assets/images/lung.png')),
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                'Respiratory',
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Colors.lightBlue.shade900,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        onTap: (){
                                          navigateTo(context, SearchScreen());
                                        },
                                      ),
                                      const Spacer(),
                                      Expanded(
                                        child: InkWell(
                                          child: Column(
                                            children: [
                                              const Image(
                                                image: AssetImage(
                                                  'assets/images/bones.png',
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  'Bones',
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    color:
                                                    Colors.lightBlue.shade900,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          onTap: (){
                                            navigateTo(context, SearchScreen());
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          child: Column(
                                            children: [
                                              const Image(
                                                image: AssetImage(
                                                  'assets/images/brain.png',
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  'Brain',
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color:
                                                      Colors.lightBlue.shade900),
                                                ),
                                              ),
                                            ],
                                          ),
                                          onTap: (){
                                            navigateTo(context, SearchScreen());
                                          },
                                        ),
                                      ),
                                      const Spacer(),
                                      Expanded(
                                        child: InkWell(
                                          child: Column(
                                            children: [
                                              const Image(
                                                image: AssetImage(
                                                    'assets/images/scan.png'),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  'Scan',
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color:
                                                      Colors.lightBlue.shade900),
                                                ),
                                              ),
                                            ],
                                          ),
                                          onTap: (){
                                            navigateTo(context, const ScanScreen());
                                          },
                                        ),
                                      ),
                                      const Spacer(),
                                      Expanded(
                                        child: InkWell(
                                          child: Column(
                                            children: [
                                              const Image(
                                                  image: AssetImage(
                                                      'assets/images/babies.png')),
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  'Pediarics',
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color:
                                                      Colors.lightBlue.shade900),
                                                ),
                                              ),
                                            ],
                                          ),
                                          onTap: (){
                                            navigateTo(context, SearchScreen());
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    'Top Doctors',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: defColor,
                    ),
                  ),
                ),
                const DoctorsSection(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0,left: 10,right: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        const Image(
                          image: AssetImage('assets/images/lastco.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 25,
                              left: 12
                          ),
                          child: Text(
                            'DOCBOOK',
                            style: TextStyle(
                                color: defColor,
                                fontSize: 20
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 250,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 60,
                              left: 10,
                            ),
                            child: Text(
                              'With over 1000 verified reviews, patients are able to search, compare and book the best doctor in just 1 minute',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

