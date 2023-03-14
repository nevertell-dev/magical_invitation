// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

abstract class TimelineWidget extends StatelessWidget {
  const TimelineWidget(
    this.controller, {
    super.key,
    this.minExtent,
    this.maxExtent,
  });

  final ScrollController controller;
  final double? minExtent;
  final double? maxExtent;
}
