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
  static _ScaffoldEventLayerState? _currentState;

  @override
  void initState() {
    //print('XXX ScaffoldEventLayer.${this.hashCode} initialized');
    if (_currentState == null || _currentState != this) {
      if (_currentState == null) {
        _ScaffoldEventLayerState._attachToEvents();
      }
      //print('XXX ScaffoldEventLayer _currentState changed');
      _currentState = this;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.scaffold;
  }

  @override
  void deactivate() {
    //print('XXX ScaffoldEventLayer.${this.hashCode} deactivated');
    super.deactivate();
  }

  @override
  void dispose() {
    //print('XXX ScaffoldEventLayer.${this.hashCode} disposed');
    super.dispose();
  }

  static void _attachToEvents() {
    final events = Inject().get<EventBus>();
    //print('XXX ScaffoldEventLayer._attachToEvents() invoked');

    events.on<ErrorAppEvent>().listen((event) {
      SnackBars.error(_currentState!.context, message: event.message);
    });

    events.on<SuccessAppEvent>().listen((event) {
      SnackBars.success(_currentState!.context, message: event.message);
    });

    events.on<InfoAppEvent>().listen((event) {
      SnackBars.info(_currentState!.context, message: event.message);
    });

    events.on<WarningAppEvent>().listen((event) {
      SnackBars.warning(_currentState!.context, message: event.message);
    });

    events.on<ActionEvent>().listen((event) {
      EventSnackBars.action(_currentState!.context, event: event);
    });
  }
}
