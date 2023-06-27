import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  const MessengerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          children: const [
            CircleAvatar(
              backgroundImage: NetworkImage(
              'https://avatarfiles.alphacoders.com/233/233498.jpg',
              ),
              radius: 20.0,
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
              'Chats',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: (){},
              icon: const CircleAvatar(
                radius: 15.0,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 16.0,
                ),
              ),
          ),
          IconButton(
              onPressed: (){},
              icon: const CircleAvatar(
                radius: 15.0,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 16.0,
                ),
              ),
          ),
          const SizedBox(
            width: 10.0,
          ),
        ],
        titleSpacing: 20.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(
                  7.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    15.0,
                  ),
                  color: Colors.grey[300],
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.search,
                      size: 18.0,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      'Search',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    itemBuilder:(context,index)=>BuildStoryItem(),
                    separatorBuilder: (context,index)=>const SizedBox(
                      width: 15.0,
                    ),
                    itemCount: 15,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ListView.separated(
                shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index)=>BuildChatItem(),
                  separatorBuilder: (context,index)=>const SizedBox(
                    height: 20.0,
                  ),
                  itemCount: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//1.build item
//2.build list
//3.add item to list

// ignore: non_constant_identifier_names
Widget BuildStoryItem()=> SizedBox(
  width: 60.0,
  child: Column(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: const [
          CircleAvatar(
            backgroundImage: NetworkImage(
              'https://avatarfiles.alphacoders.com/233/233498.jpg',
            ),
            radius: 30.0,
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius:8.0,
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
              bottom: 3.0,
              end: 3.0,
            ),

            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 5.0,
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 5.0,
      ),
      const Padding(
        padding:  EdgeInsetsDirectional.only(
            start: 6.0
        ),
        child: Text(
          'Hussein Abdulaziz',
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
    ],

  ),
);
// ignore: non_constant_identifier_names
Widget BuildChatItem()=>Row(
  children: [
    Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: const [
        CircleAvatar(
          backgroundImage: NetworkImage(
            'https://avatarfiles.alphacoders.com/233/233498.jpg',
          ),
          radius: 30.0,
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius:8.0,
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(
            bottom: 3.0,
            end: 3.0,
          ),

          child: CircleAvatar(
            backgroundColor: Colors.red,
            radius: 5.0,
          ),
        ),
      ],
    ),
    const SizedBox(
      width: 20
      ,),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hussein Abdulaziz',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height:5,
          ),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Hi My Name is Hussein ssssssssssssssssss',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Container(
                  height: 5.0,
                  width: 5.0,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle
                  ),
                ),
              ),
              const Text(
                '02:00 PM',
              ),
            ],
          ),
        ],
      ),
    ),
  ],
);