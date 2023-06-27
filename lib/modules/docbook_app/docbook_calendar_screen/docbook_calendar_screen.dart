import 'package:flutter/material.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_calendar_screen/upcoming_screen.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';

class DocBookCalendarScreen extends StatelessWidget {
 const DocBookCalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:40,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 15),
              child:Center(
                child: Text(
                  "My Appointment",
                  style: TextStyle(
                    fontSize: 28,
                      color: defColor,
                      fontWeight: FontWeight.bold,
                ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index)=>UpComingSchedule(),
                  separatorBuilder: (context,index)=>SizedBox(
                    height: 20,
                  ),
                  itemCount: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

