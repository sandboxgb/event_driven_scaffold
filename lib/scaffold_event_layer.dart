library event_driven_scaffold;

import 'package:application_events/events.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:snackbars/snackbars.dart';

import 'event_snackbars.dart';

class ScaffoldEventLayer extends StatefulWidget {
  final Scaffold scaffold;

  ScaffoldEventLayer({Key? key, required this.scaffold}) : super(key: key);

  @override
  _ScaffoldEventLayerState createState() => _ScaffoldEventLayerState();
}

class _ScaffoldEventLayerState extends State<ScaffoldEventLayer> {
  final events = Inject().get<EventBus>();

  @override
  void didChangeDependencies() {
    _attachToEvents(context);
  }

  @override
  Widget build(BuildContext context) {
    return widget.scaffold;
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
