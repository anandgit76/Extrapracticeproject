import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class UploadUI extends StatefulWidget {
  const UploadUI({super.key});

  @override
  State<UploadUI> createState() => _UploadUIState();
}

class _UploadUIState extends State<UploadUI> {
  File? galleryFile;
  final picker = ImagePicker();
  void removePicture() {
    setState(() {
      galleryFile = null;
    });
  }
  @override
  Widget build(BuildContext context) {
    Future getImage(
        ImageSource img,
        ) async {
      final pickedFile = await picker.pickImage(source: img);
      XFile? xfilePick = pickedFile;
      setState(() {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Nothing is Selected")));
        }
      });
    }
    void pickercall({
      required BuildContext context,
    }) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.photo_library_outlined),
                    title: const Text("Photo Gallery"),
                    onTap: () {
                      getImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text("Camera"),
                    onTap: () {
                      getImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.do_not_disturb_alt),
                    title: const Text("Remove Profile Picture"),
                    onTap: () {
                      removePicture();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
        },
      );
    }
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(FontAwesomeIcons.arrowLeftLong),
        ),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            SizedBox(
              height: size.height / 4.8,
              width: size.width,
              child:  Stack(
                children: [
                  Positioned(
                    top: 27,
                    left: 30,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: const AssetImage("assets/stack1.png"),
                      child: galleryFile == null
                          ? const Center(
                        child: Text(
                          '',
                          style: TextStyle(fontSize: 13),
                        ),
                      )
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(
                          galleryFile!,
                          fit: BoxFit.cover,
                          width:
                          MediaQuery.of(context).size.width / 3,
                          height:
                          MediaQuery.of(context).size.width / 3,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 110,
                    left: 120,
                    child: GestureDetector(onTap: () {
                      pickercall(context: context);
                    },
                      child: const CircleAvatar(
                        backgroundImage: AssetImage("assets/Add.png"),
                        radius: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 190),
              child: Column(
                children: [
                  Text("Here we go !",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Text("Please provide us your\nprofile photo",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: size.height / 15,
        width: size.width / 1.1,
        child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.blue,
          onPressed: () {
            if (galleryFile != null) {
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Please select an image first"),
              ));
            }
          },
          child: const Text(
            'Upload',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
      ),
    );
  }
}