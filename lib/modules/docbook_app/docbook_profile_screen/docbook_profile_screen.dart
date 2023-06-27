import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_calendar_screen/docbook_calendar_screen.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_profile_screen/changepassword_screen.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_profile_screen/settings_screen.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/cubit.dart';
import 'package:ramdan_proj/modules/docbook_app/login/cubit/states.dart';
import 'package:ramdan_proj/shared/components/components.dart';
import 'package:ramdan_proj/shared/components/constants.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';

class DocBookProfileScreen extends StatelessWidget {
  const DocBookProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocLoginCubit,DocLoginStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = DocLoginCubit.get(context);
        final model = DocLoginCubit.get(context).userModel;
        cubit.nameController.text=model?.userName??'not Found';
        cubit.allergiesController.text=model?.allergies??'not Found';
        cubit.heightController.text=model?.height??'not Found';
        cubit.weightController.text=model?.weight??'not Found';
        cubit.bloodController.text=model?.blood??'not Found';
        cubit.martialController.text=model?.maritalStatus??'not Found';
        cubit.ageController.text=model?.birthDate??'not Found';
        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConditionalBuilder(
              condition: true ,
              builder: (BuildContext context) {
                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 1.75,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: defColor,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: AssetImage(
                                      'assets/images/husan.png',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  cubit.nameController.text,
                                  style:const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                const Spacer(),
                                PopupMenuButton(
                                  child:const Icon(
                                    Icons.more_vert_rounded,
                                    color: Colors.white,
                                  ),
                                  onSelected: (value) {
                                    if(value == 0){
                                      navigateTo(context, const SettingsDocScreen());
                                    }else if(value == 1){
                                      navigateTo(context, const ChangePasswordScreen());
                                    }else if(value==2){
                                      signOut(context);
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: 0,
                                      child: Text('Edit Profile'),

                                    ),
                                    const PopupMenuItem(
                                      value: 1,
                                      child: Text('Change Password'),
                                    ),
                                    const PopupMenuItem(
                                      value:2,
                                      child: Text('Log out'),

                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 210,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'Age',
                                                    style: TextStyle(
                                                      color: defColor,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  const Image(
                                                    image: AssetImage(
                                                        'assets/images/age.png'
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(cubit.ageController.text),
                                            ],
                                          ),
                                          Container(
                                            color: Colors.grey,
                                            height: 1,
                                            width: double.infinity,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'Allergies',
                                                    style: TextStyle(
                                                      color: defColor,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  const Image(
                                                    image: AssetImage(
                                                      'assets/images/allergies.png',
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                cubit.allergiesController.text,
                                              ),
                                            ],
                                          ),
                                          Container(
                                            color: Colors.grey,
                                            height: 1,
                                            width: double.infinity,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'Weight',
                                                    style: TextStyle(
                                                      color: defColor,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  const Image(
                                                    image: AssetImage(
                                                      'assets/images/weight.png',
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '${cubit.weightController.text} Kg',
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey,
                                      height: double.infinity,
                                      width: 1,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'Blood',
                                                    style: TextStyle(
                                                      color: defColor,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  const Image(
                                                    image: AssetImage(
                                                      'assets/images/blood.png',
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text('  ${cubit.bloodController.text}'),
                                            ],
                                          ),
                                          Container(
                                            color: Colors.grey,
                                            height: 1,
                                            width: double.infinity,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'Status',
                                                    style: TextStyle(
                                                      color: defColor,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  const Image(
                                                    image: AssetImage(
                                                      'assets/images/status.png',
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                ' ${cubit.martialController.text}',
                                              ),
                                            ],
                                          ),
                                          Container(
                                            color: Colors.grey,
                                            height: 1,
                                            width: double.infinity,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'Height',
                                                    style: TextStyle(
                                                      color: defColor,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  const Image(
                                                    image: AssetImage(
                                                      'assets/images/height.png',
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                ' ${cubit.heightController.text} cm',
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: defColor,
                                blurRadius: 1,
                                spreadRadius: 1,
                              ),
                            ]),
                        child: Row(
                          children: [
                            Text(
                              ' Notes',
                              style: TextStyle(
                                color: defColor,
                                fontSize: 22,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: defColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: defColor,
                                blurRadius: 1,
                                spreadRadius: 1,
                              ),
                            ]),
                        child: Row(
                          children: [
                            Text(
                              ' Appointments',
                              style: TextStyle(
                                color: defColor,
                                fontSize: 22,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                navigateTo(context, const DocBookCalendarScreen());
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: defColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: defColor,
                                blurRadius: 1,
                                spreadRadius: 1,
                              ),
                            ]),
                        child: Row(
                          children: [
                            Text(
                              ' Current Medication',
                              style: TextStyle(
                                color: defColor,
                                fontSize: 22,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: defColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                );
              }, fallback: (BuildContext context) {
                return const Center(
                  child:CircularProgressIndicator() ,
                );
            },

            ),
          ),
        );
      },
    );
  }
}
