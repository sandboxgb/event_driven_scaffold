library event_driven_scaffold;

import 'package:application_events/events.dart';
import 'package:flutter/material.dart';
import 'package:snackbars/snackbars.dart';

class EventSnackBars {
  static void action(BuildContext context, {required ActionEvent event}) {
    SnackBars.show(context,
        message:
            "${event.action} received from ${event.source.runtimeType}(${event.message})");
  }
}
