// ignore_for_file: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:proteins/controller/scenekit_plugin_controller_interface.dart';

typedef ScenekitPluginCreatedCallback = void Function(
  ScenekitController controller,
);

class ScenekitView extends StatefulWidget {
  final Function(String)? onNodeTap;

  const ScenekitView({
    Key? key,
    this.isAllowedToInteract,
    this.onNodeTap,
    required this.onScenekitViewCreated,
  }) : super(key: key);

  final bool? isAllowedToInteract;
  final ScenekitPluginCreatedCallback onScenekitViewCreated;

  @override
  State<ScenekitView> createState() => _ScenekitViewState();
}

class _ScenekitViewState extends State<ScenekitView> {
  late ScenekitController scenekitController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (DragStartDetails details) {},
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: UiKitView(
          hitTestBehavior:
              widget.isAllowedToInteract != null && widget.isAllowedToInteract!
                  ? PlatformViewHitTestBehavior.opaque
                  : PlatformViewHitTestBehavior.transparent,
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer(),
            ),
          },
          viewType: "scenekit",
          onPlatformViewCreated: (index) {
            onPlatformViewCreated(index);
          },
          creationParamsCodec: const StandardMessageCodec(),
        ),
      ),
    );
  }

  Future<void> onPlatformViewCreated(int id) async {
    scenekitController = ScenekitController.init(id: id);
    widget.onScenekitViewCreated(scenekitController);
  }
}
