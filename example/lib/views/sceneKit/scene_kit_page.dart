// import 'package:flutter/cupertino.dart';
// ignore_for_file: avoid_print, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proteins_example/utils/palette.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:proteins/controller/scenekit_plugin_controller_interface.dart';
// import 'package:proteins_example/utils/config_theme.dart';

class ScenekitPage extends StatefulWidget {
  final String? name;
  const ScenekitPage({
    Key? key,
    this.name,
  }) : super(key: key);

  static const String routename = '/sceneKit';

  @override
  State<ScenekitPage> createState() => _ScenekitPageState();
}

class _ScenekitPageState extends State<ScenekitPage>
    with WidgetsBindingObserver {
  late ScenekitController scenekitController;
  GlobalKey previewContainer = GlobalKey();
  int originalSize = 800;
  int customViewOpen = 0;
  bool isLoad = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 1),
        () => setState(() {
              isLoad = true;
            }));
  }

  @override
  void dispose() {
    // scenekitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    _infosAtoms(context) {
      double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;
      showModalBottomSheet(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return Container(
                color: Colors.transparent,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                const Icon(Icons.science_sharp,
                                    size: 30, color: Color(0XFF434343)),
                                SizedBox(
                                  width: screenWidth * 0.02,
                                ),
                                Text(
                                  "atom type".toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0XFF434343)),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                margin: const EdgeInsets.only(top: 5, right: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 2,
                                        color: const Color(0XFFDDDDDD))),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.005,
                                        bottom: screenHeight * 0.005,
                                        left: screenWidth * 0.02,
                                        right: screenWidth * 0.00),
                                    child: Icon(Icons.arrow_back_ios,
                                        color: const Color(0xFF434343),
                                        size: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .fontSize),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: <Widget>[
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color(0xfff8f8f8),
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  "un peu de texte",
                                  style: TextStyle(
                                    color: Color(0XFF434343),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ).whenComplete(() => setState(() {}));
    }

    ;

    // void onInfosView(ScenekitController scenekitController) async {
    //   this.scenekitController = scenekitController;
    //   final version = await scenekitController.getPlatformVersion();

    //   await scenekitController.createInfos(name: 'TOOTOTOTTOOTOTO');
    // }

    void onScenekitViewCreated(ScenekitController scenekitController) async {
      this.scenekitController = scenekitController;
      final version = await scenekitController.getPlatformVersion();

      await scenekitController.createAtoms(
          initialScale: 12, backgroundColor: 0xFF292D39, name: widget.name);
    }

    return Scaffold(
      backgroundColor: createMaterialColor(const Color(0xFF292D39)),
      appBar: AppBar(
        backgroundColor: createMaterialColor(const Color(0xFF292D39)),
        automaticallyImplyLeading: true,
        title: const Text('Fluttery Gelatine'),
      ),
      body: isLoad == false
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : RepaintBoundary(
              key: previewContainer,
              child: SizedBox(
                child: customViewOpen == 0
                    ? Center(
                        child: Image(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          image: Svg(
                            'https://cdn.rcsb.org/images/ccd/labeled/${widget.name![0]}/${widget.name}.svg',
                            source: SvgSource.network,
                          ),
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 1,
                                  width: 1,
                                  child: ScenekitView(
                                    isAllowedToInteract: true,
                                    onScenekitViewCreated:
                                        onScenekitViewCreated,
                                  ),
                                ),
                                Center(
                                  child: AlertDialog(
                                    title: const Text('⚠️'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const <Widget>[
                                        Text(
                                          "Cette protéine n'est pas disponible 😢",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    : RawGestureDetector(
                        gestures: {
                          AllowMultipleGestureRecognizer:
                              GestureRecognizerFactoryWithHandlers<
                                  AllowMultipleGestureRecognizer>(
                            () => AllowMultipleGestureRecognizer(),
                            (AllowMultipleGestureRecognizer instance) {
                              instance.onTap = () => _infosAtoms(context);
                            },
                          )
                        },
                        child: ScenekitView(
                          isAllowedToInteract: true,
                          onScenekitViewCreated: onScenekitViewCreated,
                        ),
                      ),
              ),
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                if (customViewOpen == 0) {
                  customViewOpen = 1;
                } else {
                  customViewOpen = 0;
                }
              });
            },
            heroTag: null,
            backgroundColor: Colors.white,
            child: Icon(() {
              if (customViewOpen == 1) {
                return Icons.switch_right;
              }
              return Icons.switch_left;
            }()),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            onPressed: () {
              ShareFilesAndScreenshotWidgets().shareScreenshot(
                previewContainer,
                originalSize,
                widget.name!,
                "${widget.name}.png",
                "image/png",
                text: "Coucou, tu veux voir ma protéine ${widget.name} ?",
              );
            },
            heroTag: null,
            backgroundColor: Colors.white,
            child: const Icon(Icons.share_outlined),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class AllowMultipleGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
