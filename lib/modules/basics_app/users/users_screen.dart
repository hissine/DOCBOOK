import 'package:flutter/material.dart';
import 'package:ramdan_proj/models/user/user_model.dart';



class UsersScreen extends StatelessWidget {
   UsersScreen({Key? key}) : super(key: key);
  List<UsersModel> users=[
    UsersModel(
        id: 1,
        name: 'Hussein',
        phone:'+201285340330',
    ),
    UsersModel(
      id: 2,
      name: 'Ahmed',
      phone:'+201201527463',
    ),
    UsersModel(
      id: 3,
      name: 'Khalil',
      phone:'+201220580239',
    ),
    UsersModel(
      id: 4,
      name: 'Abdulaziz',
      phone:'+201211206890',
    ),
    UsersModel(
      id: 5,
      name: 'Emad',
      phone:'+201203707658',
    ),
    UsersModel(
      id: 6,
      name: 'Reda',
      phone:'+201285340330',
    ),
    UsersModel(
      id: 1,
      name: 'Hussein',
      phone:'+201285340330',
    ),
    UsersModel(
      id: 2,
      name: 'Ahmed',
      phone:'+201201527463',
    ),
    UsersModel(
      id: 3,
      name: 'Khalil',
      phone:'+201220580239',
    ),
    UsersModel(
      id: 4,
      name: 'Abdulaziz',
      phone:'+201211206890',
    ),
    UsersModel(
      id: 5,
      name: 'Emad',
      phone:'+201203707658',
    ),
    UsersModel(
      id: 6,
      name: 'Reda',
      phone:'+201285340330',
    ),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Users',
        ),
      ),
      body: ListView.separated(
          itemBuilder:(context,index)=> BuildUserItem(users[index]),
          separatorBuilder:(context,index)=>Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 20.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          itemCount:users.length,),

    );
  }

  Widget BuildUserItem(UsersModel user)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.blue,
          child: Text(
            '${user.id}',
            style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              user.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              user.phone,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
