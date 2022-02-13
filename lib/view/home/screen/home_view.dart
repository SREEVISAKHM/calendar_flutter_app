// ignore_for_file: avoid_print

import 'package:calendar_flutter_app/utils/colors.dart';
import 'package:calendar_flutter_app/utils/styles.dart';
import 'package:calendar_flutter_app/view/detail_view/details_screen.dart';
import 'package:calendar_flutter_app/view/home/model/event.dart';
import 'package:calendar_flutter_app/view/home/model/event_list.dart';
import 'package:calendar_flutter_app/view/home/widgets/add_event.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';

class HomeView extends StatefulWidget {
  static const String route = '/home_view';
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final DateTime _selectedDate = DateTime.now();
  final GlobalKey<MonthViewState> _calendarKey = GlobalKey();
  final EventController<Event> _eventController = EventController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorWhite,
        title: Text(
          'calendar',
          style: tss18Black,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                _calendarKey.currentState!.jumpToMonth(DateTime.now());
              },
              icon: const Icon(
                Icons.calendar_today,
                color: colorBlack,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 91.7.w,
                height: 60.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colorGrey,
                    width: 0.1.w,
                  ),
                  borderRadius: BorderRadius.circular(5.w),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5.w),
                      bottomRight: Radius.circular(5.w)),
                  child: MonthView(
                    key: _calendarKey,
                    width: 91.4.w,
                    borderSize: 0.1.w,
                    controller: _eventController..addAll(events),
                    initialMonth: _selectedDate,
                    minMonth: DateTime(2020),
                    maxMonth: DateTime(2050),

                    onPageChange: (date, pageIndex) =>
                        print("$date, $pageIndex"),
                    onCellTap: (events, date) {
                      int index = _eventController.events
                          .indexWhere((element) => element.date == date);
                      if (index < 0) {
                        index++;
                      }
                      print(index);
                      print(date);
                      Navigator.pushNamed(context, DetailScreen.route,
                          arguments: DetailScreen(
                            eventController: _eventController,
                            date: date,
                            events: events,
                            index: index,
                          ));
                      // Implement callback when user taps on a cell.
                      // print(events);
                    },
                    // This callback will only work if cellBuilder is null.
                    onEventTap: (event, date) {},
                    // to provide custom UI for month cells.
                    cellBuilder: (date, events, isToday, isInMonth) {
                      // Return your widget to display as month cell.
                      return Container(
                        color: colorWhite,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5.0,
                            ),
                            CircleAvatar(
                              radius: 11,
                              backgroundColor:
                                  date.month == DateTime.now().month &&
                                          date.day == DateTime.now().day
                                      ? colorBlue
                                      : Colors.transparent,
                              child: Text(
                                "${date.day}",
                                style: TextStyle(
                                  color: date.day == DateTime.now().day &&
                                          date.month == DateTime.now().month
                                      ? colorWhite
                                      : date.month == DateTime.now().month
                                          ? colorBlack
                                          : colorBlue.withOpacity(0.4),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            if (events.isNotEmpty)
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 5.0),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(
                                        events.length,
                                        (index) => GestureDetector(
                                          onTap: () => {print(events)},
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: events[index].color,
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 2.0, horizontal: 3.0),
                                            padding: const EdgeInsets.all(2.0),
                                            alignment: Alignment.center,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    events[index].title,
                                                    overflow: TextOverflow.clip,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color: events[index]
                                                          .color
                                                          .accent,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                    headerBuilder: (date) => Container(
                      height: 7.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.w),
                            topRight: Radius.circular(5.w)),
                        color: Colors.white,
                        border: Border.all(
                          color: colorGrey,
                          width: 0.1.w,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                _calendarKey.currentState!.previousPage();
                              },
                              child: SizedBox(
                                width: 20.w,
                                height: 15.h,
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: colorGrey,
                                ),
                              ),
                            ),
                            const VerticalDivider(
                              color: colorGrey,
                            ),
                            SizedBox(
                              width: 40.w,
                              child: Center(
                                child: Text(
                                  '${DateFormat.d().format(date)} ${DateFormat.MMMM().format(date)} ${DateFormat.y().format(date)}',
                                  style: tss12Black,
                                ),
                              ),
                            ),
                            VerticalDivider(
                              color: colorGrey,
                              width: 0.w,
                            ),
                            InkWell(
                              onTap: () {
                                _calendarKey.currentState!.nextPage();
                              },
                              child: SizedBox(
                                width: 20.w,
                                height: 15.h,
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: colorGrey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            height(4.h),
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => AddEvent(
                          eventController: _eventController,
                        ));
              },
              child: Text(
                'Add event',
                style: tss12White,
              ),
            ),
          ],
        ),
      ),
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
