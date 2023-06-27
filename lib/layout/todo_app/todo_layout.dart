// ignore_for_file: null_check_always_fails

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ramdan_proj/shared/components/components.dart';
import 'package:ramdan_proj/shared/todo_cubit/cubit.dart';
import 'package:ramdan_proj/shared/todo_cubit/states.dart';

class HomeLayout extends StatelessWidget {

  HomeLayout({super.key});

 final titleController = TextEditingController();
 final dateController = TextEditingController();
 final timeController = TextEditingController();
 final scaffoldKey = GlobalKey<ScaffoldState>();
 final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context,AppStates state) {
          if(state is AppInsertDataBaseState) Navigator.pop(context);
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit=AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
              title: Text(cubit.titles[cubit.curIndex]),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                        title: titleController.text,
                        date: dateController.text,
                        time: timeController.text,
                    );
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(20.0),
                        child: Form(
                        key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultFormField(
                                controller: titleController,
                                type: TextInputType.text,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Title Must not be empty!';
                                  }
                                  return null;
                                },
                                label: 'Task Title',
                                prefix: Icons.title),
                            const SizedBox(
                              height: 15.0,
                            ),
                            defaultFormField(
                              controller: dateController,
                              type: TextInputType.datetime,
                              label: 'Task Date',
                              prefix: Icons.calendar_today,
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2023-04-30'),
                                ).then((value) {
                                  dateController.text =
                                      DateFormat.yMMMMd().format(value!);
                                });
                              },
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Date Must not be empty!';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            defaultFormField(
                                controller: timeController,
                                type: TextInputType.datetime,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Time Must not be empty!';
                                  }
                                  return null;
                                },
                                label: 'Task Time',
                                prefix: Icons.watch_later_outlined,
                                onTap: () {
                                  showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                      .then((value) {
                                    timeController.text =
                                        value!.format(context).toString();
                                  });
                                })
                          ],
                        ),
                      ),
                    ),
                    elevation: 20.0,
                  )
                      .closed
                      .then((value) {
                        cubit.changeBottomSheetState(
                            isShow: false,
                            icon:Icons.edit,
                        );
                  });
                  cubit.changeBottomSheetState(
                    isShow: true,
                    icon:Icons.add,
                  );
                }
              },
              child: Icon(
                cubit.fabIcon,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                /* setState(() {
                curIndex = index;
              });*/
                cubit.changeIndex(index);
              },
              currentIndex: cubit.curIndex,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_box_outlined,
                  ),
                  label: 'Done Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                  ),
                  label: 'Archived Tasks',
                ),
              ],
            ),
            body: state is AppGetDataBaseLoadingState
                ? const Center(child: CircularProgressIndicator())
                : cubit.screens[cubit.curIndex],
          );
        },
      ),
    );
  }


}
