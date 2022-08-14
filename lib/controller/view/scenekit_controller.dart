// ignore_for_file: unused_import, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import "dart:typed_data";
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proteins/controller/model/scenekit_widget_model.dart';

class ScenekitController {
  bool isTap = false;
  ScenekitController.init({required this.id}) {
    _channel = MethodChannel('scenekit_$id');
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "widget_tap":
          {
            // final key = call.arguments;
            // print(key);
            // _callTapCallback();
            createInfos(name: "TOOTOTOOTTOOTTOTOTOO");
            isTap = true;
            break;
          }
      }
      return;
    });
    _channel.invokeMethod<void>('init', {
      "showStatistics": false,
    });
    // _channel.invokeMethod<void>('handle_tap', {DisplayAtomsInfos()});
  }

  late MethodChannel _channel;
  final int id;
  late List<ScenekitWidgetModel> widgetModels;

  Future<String?> getPlatformVersion() async {
    final version = await _channel.invokeMethod<String>('checkConfiguration');
    return version;
  }

  Future<void> createInfos({
    String? name,
  }) async {
    Widget displayInfo =
        Text(name!, style: TextStyle(fontSize: 150, color: Colors.red));
  }

  Future<void> createAtoms({
    double? initialScale,
    int? backgroundColor,
    String? name,
  }) async {
    await _channel.invokeMethod(
      "create_atoms",
      {
        "initialScale": initialScale,
        if (backgroundColor != null) "backgroundColor": backgroundColor.toInt(),
        "name": name,
      },
    );
  }

  void _callTapCallback() {
    // final widgetModel = widgetModels.firstWhereOrNull(
    //   (element) => element.key == key,
    // );

    // widgetModel?.onWidgetTap?.call();
  }
}
