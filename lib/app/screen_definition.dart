import 'package:flutter/material.dart';

class ScreenDefinition {
  const ScreenDefinition({
    required this.id,
    required this.title,
    required this.group,
    required this.description,
    required this.builder,
  });

  final String id;
  final String title;
  final String group;
  final String description;
  final Widget Function({bool large}) builder;

  String get route => '/$id';
}
