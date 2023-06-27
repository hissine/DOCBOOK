import 'package:flutter/material.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_home_screen/confirm_booking.dart';
import 'package:ramdan_proj/shared/components/components.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../shared/styles/colors.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}
class _BookingPageState extends State<BookingPage> {
  CalendarFormat _format=CalendarFormat.month;
  DateTime _focusDay=DateTime.now();
  DateTime _currentDay=DateTime.now();
  int? _currentIndex;
  bool _isWeekend=false;
  bool _dateSelected=false;
  bool _timeSelected=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Appointment',style: TextStyle(
          color: defColor,
        ),
        ),
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: defColor,
            ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: defColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: _tableCalendar(),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                ),
                Text(
                  ' Choose times',
                  style: TextStyle(
                    color: defColor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          _isWeekend ? SliverToBoxAdapter() : SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index){
              return InkWell(
                splashColor: Colors.transparent,
                onTap: (){
                  setState(() {
                    _currentIndex=index;
                    _timeSelected=true;
                  });
                },
                child:Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _currentIndex == index? Colors.white:Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    color: _currentIndex==index?defColor:null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 9}:00 ${index+9>11?"PM":"AM"}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _currentIndex==index?Colors.white:null,
                    ),
                  ),
                ) ,
              );
            },
              childCount: 8,
            ),
            gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.5,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical:20,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary:defColor,
                ),
                  onPressed: _timeSelected && _dateSelected? (){
                    navigateTo(context, ConfirmBooking());
                  } : null ,
                  child: Text('Make Appointment'),
              ),
            ),
          )
        ],

      )
    );
  }

  Widget _tableCalendar(){
    return TableCalendar(
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2023,12,31),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 46,
      availableCalendarFormats: const{
        CalendarFormat.month:'Month',
      },
      calendarStyle: const CalendarStyle(
        defaultTextStyle: TextStyle(
          color: Colors.white,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.blueGrey,
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: const HeaderStyle(
        leftChevronIcon: Icon(
          Icons.arrow_left,color: Colors.white,
        ),
        rightChevronIcon: Icon(
          Icons.arrow_right,color: Colors.white,
        ),
        titleCentered: true,
        titleTextStyle: TextStyle(
            color: Colors.white
        ),
      ),
      daysOfWeekStyle:const DaysOfWeekStyle(
        weekdayStyle: TextStyle(
            color: Colors.white
        ),
      ),
      onFormatChanged: (format){
        setState(() {
          _format=format;
        });
      },
      onDaySelected:((selectedDay,focusedDay){
        setState(() {
          _currentDay=selectedDay;
          _focusDay=focusedDay;
          _dateSelected=true;
          if(selectedDay.weekday==5||selectedDay.weekday==6){
            _isWeekend=true;
            _timeSelected=false;
            _currentIndex=null;
          }else{
            _isWeekend=false;
          }
        });
      }),
    );
  }
}


