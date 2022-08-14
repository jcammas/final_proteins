import 'package:flutter/material.dart';

class ScenekitWidgetModel {
  final String key;

  final String? assetName;

  final VoidCallback? onWidgetTap;

  ScenekitWidgetModel({
    required this.key,
    this.assetName,
    this.onWidgetTap,
  });
}
