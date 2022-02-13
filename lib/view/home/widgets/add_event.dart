import 'package:calendar_flutter_app/utils/colors.dart';
import 'package:calendar_flutter_app/utils/styles.dart';
import 'package:calendar_flutter_app/view/home/model/event.dart';
import 'package:calendar_flutter_app/view/home/model/event_list.dart';
import 'package:calendar_view/calendar_view.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class AddEvent extends StatefulWidget {
  final EventController<Event> eventController;
  const AddEvent({Key? key, required this.eventController}) : super(key: key);

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  DateTime _selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          initialDatePickerMode: DatePickerMode.day,
          firstDate: DateTime(2015),
          lastDate: DateTime(2101));
      if (picked != null) {
        setState(() {
          _selectedDate = picked;
        });
      }
    }

    return AlertDialog(
      title: const Center(child: Text('Add Event')),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Text(
                    'Select Date',
                    style: tss12White,
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(colorBlack)),
                ),
                width(4.w),
                Text(DateFormat.yMd().format(_selectedDate),
                    style: tss12BBlack),
              ],
            ),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                  labelText: 'Title', border: OutlineInputBorder()),
              onSubmitted: (value) {},
            ),
            height(2.h),
            SizedBox(
              height: 50.h,
              child: TextField(
                maxLines: 50.h.toInt(),
                controller: descriptionController,
                decoration: const InputDecoration(
                    labelText: 'Description', border: OutlineInputBorder()),
                onChanged: (value) {
                  // _eventController.addEvent(
                  //   Event(
                  //     title: value,
                  //     color: colorBlue,
                  //   ),
                  // );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: tss12White,
              ),
            ),
            width(1.w),
            ElevatedButton(
              onPressed: () async {
                // events.add(CalendarEventData(
                //     description: descriptionController.text,
                //     title: titleController.text,
                //     date: _selectedDate));
                widget.eventController.add(
                  CalendarEventData(
                      color: colorBlack,
                      description: descriptionController.text,
                      title: titleController.text,
                      date: _selectedDate),
                );

                Navigator.pop(context);
                // SharedPreferences sp = await SharedPreferences.getInstance();

                print(events);
                // print(widget.eventController.events);
              },
              child: Text(
                'Add ',
                style: tss12White,
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget height(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget width(double width) {
    return SizedBox(
      width: width,
    );
  }
}
