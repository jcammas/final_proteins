// ignore_for_file: avoid_print, unused_local_variable, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
// import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:proteins_example/utils/palette.dart';
// import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:proteins/controller/scenekit_plugin_controller_interface.dart';
import 'package:flutter_native_screenshot/flutter_native_screenshot.dart';
// import 'package:permission_handler/permission_handler.dart';

class ScenekitPage extends StatefulWidget {
  final String name;
  const ScenekitPage({
    Key? key,
    required this.name,
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
  late Widget? _imgHolder;
  bool isAvailable = false;

  Future<void> openProtein(String text) async {
    if (text.isNotEmpty) {
      var failed = true;
      try {
        var url =
            Uri.parse('https://files.rcsb.org/ligands/view/${text}_ideal.pdb');
        http.Response response = await http.get(url);
        if (response.statusCode == 200 && response.body.isNotEmpty) {
          setState(() {
            isAvailable = true;
          });

          return;
        } else {
          failed = true;
        }
      } catch (e) {
        failed = true;
      }
      if (failed) {
        Widget closeButton = TextButton(
            child: const Text("Fermer"),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            });
        AlertDialog alert = AlertDialog(
            title: const Text("Impossible de charger le ligand"),
            content: const Text(
                "Vérifier votre connexion à internet. Il est aussi possible que le ligand n'existe pas."),
            actions: [
              closeButton,
            ]);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            });
      }
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _doTakeScreenshot() async {
    try {
      String? path = await FlutterNativeScreenshot.takeScreenshot();
      debugPrint('Screenshot taken, path: $path');
      if (path == null || path.isEmpty) {
        _showSnackBar('Error taking the screenshot :(');
        return;
      } // if error
      _showSnackBar(
          'Ce screenshot a été sauvegardé dans vos photos, vous pouvez le partager !');
      File imgFile = File(path);
      _imgHolder = Image.file(imgFile);
      setState(() {});
    } catch (e) {
      print("non mais ça va pas la tête ????");
    }
  }

  @override
  void initState() {
    // fetch3D(widget.name);
    openProtein(widget.name);
    super.initState();
    _imgHolder = const Center(
      child: Icon(Icons.image),
    );

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
                    color: Color(0xFF292D39),
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
                                    size: 30, color: Colors.white),
                                SizedBox(
                                  width: screenWidth * 0.02,
                                ),
                                Text(
                                  "atom type".toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
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
                                    width: 0,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Row(
                                  children: <Widget>[
                                    const Icon(Icons.circle),
                                    SizedBox(
                                      width: screenWidth * 0.05,
                                    ),
                                    const Text(
                                      "Hydrogen",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color(0xfff8f8f8),
                                    width: 0,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Row(
                                  children: [
                                    const Icon(Icons.circle,
                                        color: Colors.black),
                                    SizedBox(
                                      width: screenWidth * 0.05,
                                    ),
                                    const Text(
                                      "Carbon",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color(0xfff8f8f8),
                                    width: 0,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Color.fromARGB(255, 21, 5, 255),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.05,
                                    ),
                                    const Text(
                                      "Nitrogen",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 21, 5, 255),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color(0xfff8f8f8),
                                    width: 0,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.05,
                                    ),
                                    const Text(
                                      "Oxygen",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color(0xfff8f8f8),
                                    width: 0,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.05,
                                    ),
                                    const Text(
                                      "Fluorine",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color(0xfff8f8f8),
                                    width: 0,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.05,
                                    ),
                                    const Text(
                                      "Chlorine",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color(0xfff8f8f8),
                                    width: 0,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Color.fromARGB(255, 62, 8, 72),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.05,
                                    ),
                                    const Text(
                                      "Iodine",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 62, 8, 72),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color(0xfff8f8f8),
                                    width: 0,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Color.fromARGB(255, 47, 11, 9),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.05,
                                    ),
                                    const Text(
                                      "Bromine",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 47, 11, 9),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color(0xfff8f8f8),
                                    width: 0,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Colors.cyan,
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.05,
                                    ),
                                    const Flexible(
                                      child: Text(
                                        "Noble gases (He, Ne, Ar, Kr, Xe)",
                                        style: TextStyle(
                                          color: Colors.cyan,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color(0xfff8f8f8),
                                    width: 0,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Colors.orange,
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.05,
                                    ),
                                    const Text(
                                      "Phosphorus",
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color(0xfff8f8f8),
                                    width: 0,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Row(
                                  children: [
                                    const Icon(Icons.circle,
                                        color: Colors.yellow),
                                    SizedBox(
                                      width: screenWidth * 0.05,
                                    ),
                                    const Text(
                                      "Sulfur",
                                      style: TextStyle(
                                        color: Colors.yellow,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color(0xfff8f8f8),
                                    width: 0,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Color.fromARGB(237, 217, 212, 171),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.05,
                                    ),
                                    const Text(
                                      "Boron",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(237, 217, 212, 171),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color(0xfff8f8f8),
                                    width: 0,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Colors.purple,
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.05,
                                    ),
                                    const Flexible(
                                      child: Text(
                                        "Alkali metals (Li, Na, K, Rb, Cs, Fr)",
                                        style: TextStyle(
                                          color: Colors.purple,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color(0xfff8f8f8),
                                    width: 0,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Color.fromARGB(255, 10, 66, 12),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.05,
                                    ),
                                    const Flexible(
                                      child: Text(
                                        "Alkaline earth metals (Be, Mg, Ca, Sr, Ba, Ra",
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 10, 66, 12),
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color(0xfff8f8f8),
                                    width: 0,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.05,
                                    ),
                                    const Text(
                                      "Titanium",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color(0xfff8f8f8),
                                    width: 0,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Color.fromARGB(184, 186, 112, 0),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.05,
                                    ),
                                    const Text(
                                      "Iron",
                                      style: TextStyle(
                                        color: Color.fromARGB(184, 186, 112, 0),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color(0xfff8f8f8),
                                    width: 0,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Colors.pink,
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.05,
                                    ),
                                    const Text(
                                      "Other elements",
                                      style: TextStyle(
                                        color: Colors.pink,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
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
        title: Text(widget.name),
      ),
      body: isLoad == false
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : SizedBox(
              child: customViewOpen == 0
                  ? Center(
                      child: Image(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        image: Svg(
                          'https://cdn.rcsb.org/images/ccd/labeled/${widget.name[0]}/${widget.name}.svg',
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
                                  onScenekitViewCreated: onScenekitViewCreated,
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
                  : Center(
                      child: SizedBox(
                        width: screenWidth,
                        height: screenHeight * 0.5,
                        child: RawGestureDetector(
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
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          isAvailable
              ? FloatingActionButton(
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
                  //backgroundColor: Colors.black,
                  child: Icon(() {
                    if (customViewOpen == 1) {
                      return Icons.switch_right;
                    }
                    return Icons.switch_left;
                  }()),
                )
              : SizedBox(),
          const SizedBox(height: 20),
          FloatingActionButton(
            onPressed: () async {
              _doTakeScreenshot();
            },
            heroTag: null,
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
