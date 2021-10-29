library event_driven_scaffold;

import 'package:application_events/events.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:snackbars/snackbars.dart';

import 'event_snackbars.dart';

class ScaffoldEventLayer extends StatelessWidget {
  final Scaffold scaffold;
  final events = Inject().get<EventBus>();

  ScaffoldEventLayer({Key? key, required this.scaffold}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _attachToEvents(context);
    return scaffold;
  }

  void _attachToEvents(BuildContext context) {
    events.on<ErrorAppEvent>().listen((event) {
      SnackBars.error(context, message: event.message);
    });

    events.on<SuccessAppEvent>().listen((event) {
      SnackBars.success(context, message: event.message);
    });

    events.on<ActionEvent>().listen((event) {
      EventSnackBars.action(context, event: event);
    });
  }
}
