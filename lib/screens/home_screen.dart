import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:widget_mask/widget_mask.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? image;
  bool isImg = false;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff088178),
    ));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.dispose();
  }

  Future _pickCropImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        image = img;
      });
      debugPrint("Image Taken Successfully");
      CroppedFile? croppedImg =
          await ImageCropper().cropImage(sourcePath: img.path, uiSettings: [
        AndroidUiSettings(
          lockAspectRatio: false,
          initAspectRatio: CropAspectRatioPreset.square,
        )
      ]);
      if (croppedImg != null) {
        setState(() {
          image = XFile(croppedImg.path);
        });
        debugPrint("Cropped Successfully");
        _cropDialog();
      } else {
        debugPrint("Image Not Cropped");
      }
    } else {
      debugPrint("Image Not Selected");
    }
  }

  void _cropDialog() {
    showDialog(
        context: context,
        builder: (ctx) {
          final pHeight = MediaQuery.of(context).size.height;
          final pWidth = MediaQuery.of(context).size.width;
          final dHeight = MediaQuery.of(ctx).size.height;
          final dWidth = MediaQuery.of(ctx).size.width;
          return Dialog(
            child: Container(
              width: pWidth * 0.9,
              height: pHeight * 0.42,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                  const Text(
                    "Uploaded Image",
                    style: TextStyle(
                      fontFamily: "Lora",
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  imagePreview(dHeight: dHeight, dWidth: dWidth),
                  SizedBox(
                    height: dHeight * 0.012,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(dWidth * 0.75, dHeight * 0.05)),
                    onPressed: () {
                      setState(() {
                        isImg = true;
                        Navigator.of(ctx).pop();
                      });
                    },
                    child: const Text("Use this image"),
                  ),
                ],
              ),
            ),
          );
        });
  }

  String mask = "Original";
  Map<String, String> imgPath = {
    "frame1": "assets/pics/user_image_frame_1.png",
    "frame2": "assets/pics/user_image_frame_2.png",
    "frame3": "assets/pics/user_image_frame_3.png",
    "frame4": "assets/pics/user_image_frame_4.png",
  };
  Widget imagePreview({
    required double dHeight,
    required double dWidth,
  }) {
    return StatefulBuilder(builder: (ctx, setState) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: dHeight * 0.009),
            height: dHeight * 0.2,
            child: mask == "Original"
                ? Image.file(
                    File(image!.path),
                    fit: BoxFit.fitHeight,
                  )
                : WidgetMask(
                    blendMode: BlendMode.srcATop,
                    childSaveLayer: true,
                    mask: Image.file(
                      File(image!.path),
                      fit: BoxFit.fill,
                    ),
                    child: Image.asset(
                      imgPath[mask]!,
                      // fit: BoxFit.contain,
                    ),
                  ),
          ),
          SizedBox(
            height: dHeight * 0.009,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    mask = "Original";
                  });
                },
                child: Container(
                  width: dWidth * 0.2,
                  height: dHeight * 0.06,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Center(
                    child: Text(
                      "Original",
                      style: TextStyle(
                        fontSize: dHeight * 0.013,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    mask = "frame1";
                  });
                },
                child: Container(
                  width: dWidth * 0.13,
                  padding: EdgeInsets.symmetric(
                      vertical: dHeight * 0.005, horizontal: dWidth * 0.01),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Image.asset(
                    "assets/pics/user_image_frame_1.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    mask = "frame2";
                  });
                },
                child: Container(
                  width: dWidth * 0.13,
                  padding: EdgeInsets.symmetric(
                      vertical: dHeight * 0.005, horizontal: dWidth * 0.01),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Image.asset(
                    "assets/pics/user_image_frame_2.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    mask = "frame3";
                  });
                },
                child: Container(
                  width: dWidth * 0.13,
                  padding: EdgeInsets.symmetric(
                      vertical: dHeight * 0.005, horizontal: dWidth * 0.01),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Image.asset(
                    "assets/pics/user_image_frame_3.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    mask = "frame4";
                  });
                },
                child: Container(
                  width: dWidth * 0.13,
                  padding: EdgeInsets.symmetric(
                      vertical: dHeight * 0.005, horizontal: dWidth * 0.01),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Image.asset(
                    "assets/pics/user_image_frame_4.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              SystemNavigator.pop();
            },
            color: Colors.black.withOpacity(0.5),
          ),
          title: Text(
            "Add Image / Icon",
            style: TextStyle(
              fontFamily: "Lora",
              fontStyle: FontStyle.italic,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: pageHeight * 0.015, horizontal: pageWidth * 0.02),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)),
                height: pageHeight * 0.12,
                width: pageWidth * 0.98,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Upload Image",
                      style: TextStyle(
                          fontFamily: "Lora",
                          fontStyle: FontStyle.italic,
                          color: Colors.black.withOpacity(0.5),
                          fontSize: pageWidth * 0.03),
                    ),
                    SizedBox(
                      height: pageHeight * 0.015,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isImg = false;
                          mask = "Original";
                        });
                        _pickCropImage();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff088178),
                      ),
                      child: Text("Choose from Device"),
                    ),
                  ],
                ),
              ),
            ),
            isImg
                ? Container(
                    height: pageHeight * 0.65,
                    padding: EdgeInsets.symmetric(
                        horizontal: pageWidth * 0.05,
                        vertical: pageHeight * 0.01),
                    child: mask == "Original"
                        ? Image.file(
                            File(image!.path),
                            fit: BoxFit.fitHeight,
                          )
                        : WidgetMask(
                            blendMode: BlendMode.srcATop,
                            childSaveLayer: true,
                            mask: Image.file(
                              File(image!.path),
                              fit: BoxFit.fill,
                            ),
                            child: Image.asset(
                              imgPath[mask]!,
                              // fit: BoxFit.contain,
                            ),
                          ),
                  )
                : const SizedBox(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Made By Akash P",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )
          ],
        ),
      ),
    );
  }
}
