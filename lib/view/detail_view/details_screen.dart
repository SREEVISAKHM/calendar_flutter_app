// ignore_for_file: must_be_immutable, avoid_print

import 'package:calendar_flutter_app/utils/colors.dart';
import 'package:calendar_flutter_app/utils/styles.dart';
import 'package:calendar_flutter_app/view/home/model/event.dart';
import 'package:calendar_view/calendar_view.dart';

import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class DetailScreen extends StatefulWidget {
  static const String route = '/detail_view';
  final EventController<Event> eventController;
  final List<CalendarEventData> events;
  final DateTime date;
  int index;
  DetailScreen(
      {Key? key,
      required this.date,
      required this.events,
      required this.index,
      required this.eventController})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final EdgeInsetsGeometry padding = const EdgeInsets.all(8.0);

  late Map<String, HighlightedWord> words;
  @override
  void initState() {
    super.initState();
    words = {
      "hi": HighlightedWord(
        onTap: () {
          print('hii');
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("hi"),
                  content: const Text("way of greeting"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"),
                    )
                  ],
                );
              });
        },
        textStyle: tss12BRed,
      ),
      "he": HighlightedWord(
        onTap: () {
          print('hii');
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("he"),
                  content: const Text(
                      "used to refer to a man, boy, or male animal previously mentioned or easily identified."),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"),
                    )
                  ],
                );
              });
        },
        textStyle: tss12BRed,
      ),
      "He": HighlightedWord(
        onTap: () {
          print('hii');
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("he"),
                  content: const Text(
                      "used to refer to a man, boy, or male animal previously mentioned or easily identified."),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"),
                    )
                  ],
                );
              });
        },
        textStyle: tss12BRed,
      ),
      "HE": HighlightedWord(
        onTap: () {
          print('hii');
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("he"),
                  content: const Text(
                      "used to refer to a man, boy, or male animal previously mentioned or easily identified."),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"),
                    )
                  ],
                );
              });
        },
        textStyle: tss12BRed,
      ),
      "hE": HighlightedWord(
        onTap: () {
          print('hii');
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("he"),
                  content: const Text(
                      "used to refer to a man, boy, or male animal previously mentioned or easily identified."),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"),
                    )
                  ],
                );
              });
        },
        textStyle: tss12BRed,
      ),
    };
  }

  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: colorGrey,
          ),
        ),
        backgroundColor: colorWhite,
        centerTitle: true,
        title: Text(
          'Event Details',
          style: tss12Black,
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            color: colorBlack,
            borderRadius: BorderRadius.circular(10.w),
            border: Border.all(color: colorGrey)),
        child: PageView.builder(
            itemCount: widget.events.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  height(10.h),
                  Text(
                    DateFormat.yMMMMEEEEd().format(widget.eventController
                        .getEventsOnDay(
                            widget.eventController.events[widget.index].date)[0]
                        .date),
                    style: tss12White,
                  ),
                  height(5.h),
                  Container(
                    height: 10.h,
                    width: 90.w,
                    decoration: BoxDecoration(
                      color: colorGrey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (widget.index > 0) {
                                widget.index--;
                              }
                              print(widget.index);
                            });
                          },
                          child: SizedBox(
                            height: 10.h,
                            width: 20.w,
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: colorGrey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            child: Center(
                              child: Text(
                                widget.eventController
                                    .getEventsOnDay(widget.eventController
                                        .events[widget.index].date)[0]
                                    .title
                                    .toUpperCase(),
                                style:
                                    DateFormat.yMEd().format(DateTime.now()) ==
                                            DateFormat.yMEd().format(widget
                                                .eventController
                                                .events[widget.index]
                                                .date)
                                        ? tss12BBlue
                                        : tss12BWhite,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (widget.index < widget.events.length) {
                                widget.index++;
                              }
                              print(widget.index);
                            });
                          },
                          child: SizedBox(
                            height: 10.h,
                            width: 20.w,
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: colorGrey,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  height(5.h),
                  Container(
                    height: 50.h,
                    width: 90.w,
                    decoration: BoxDecoration(
                      color: colorGrey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    child: TextHighlight(
                      words: words,
                      matchCase: true,
                      text: widget
                          .eventController.events[widget.index].description,
                      textStyle: DateFormat.yMEd().format(DateTime.now()) ==
                              DateFormat.yMEd().format(widget
                                  .eventController.events[widget.index].date)
                          ? tss12BBlue
                          : tss12BWhite,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget height(double height) {
    return SizedBox(
      height: height,
    );
  }
}
