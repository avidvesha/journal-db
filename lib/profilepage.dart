
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final userId = FirebaseAuth.instance.currentUser!.uid;

  String? nama;
  String? emails;
  String? img_url;

  File? image;
  var namaController = TextEditingController();
  var emailController = TextEditingController();
  bool isLoading = false;


  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });

    var name = await FirebaseDatabase.instance.ref().child('user').child(userId).child('profile').child('username').get();
    var email = await FirebaseDatabase.instance.ref().child('user').child(userId).child('profile').child('email').get();
    var image_profile =
    await FirebaseDatabase.instance.ref().child('user').child(userId).child('profile').child('images').get();

    setState(() {
      nama = name.value.toString();
      emails = FirebaseAuth.instance.currentUser!.email;
      img_url = image_profile.value.toString();
    });

    setState(() {
      isLoading = false;
    });
  }

  Future openCamera() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.camera);
    image = File(pickedImage!.path);
    setState(() {
      image = File(pickedImage!.path);
    });
    uploadFotoProfile();
  }

  Future openGaleri() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedImage!.path);
    });
    uploadFotoProfile();
  }

  Future uploadFotoProfile() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    String fileName = basename(image!.path);
    await FirebaseStorage.instance.ref()
        .child('profile/$userId/$fileName')
        .putFile(image!);
    var url = await FirebaseStorage.instance.ref().child(
        'profile/$userId/$fileName').getDownloadURL();
    setState(() {
      img_url = url.toString();
    });

    await FirebaseDatabase.instance.ref().child('user').child(userId).child('profile').child('images').set(img_url);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        leadingWidth: 40,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Profile",
            style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pop(context);
                },

            // onPressed: () {},
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      body: isLoading == true
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView(
        children: [
          Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  image != null
                      ? ClipOval(
                      child: Image.file(
                        image!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ))
                      : SizedBox(
                    width: 100,
                    height: 100,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(img_url ?? "https://firebasestorage.googleapis.com/v0/b/foot-fetish-9a250.appspot.com/o/defaults%2F%E2%80%94Pngtree%E2%80%94profile%20line%20black%20icon_4008141.png?alt=media&token=a2dc0daa-7b29-4eac-a014-e0985bb847ce"),
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 10),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.black, shape: BoxShape.circle),
                    child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: ((builder) => Container(
                                height: 150,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Color(0xedededed),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Foto Profil",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              openCamera();
                                              Navigator.pop(context);
                                            },
                                            child: Icon(
                                              Icons.camera,
                                              color: Colors.black,
                                            ),
                                            style:
                                            ElevatedButton.styleFrom(
                                                shape: CircleBorder(
                                                    side: BorderSide(
                                                        color: Colors
                                                            .black)),
                                                fixedSize:
                                                Size(60, 60),
                                                primary: Colors
                                                    .transparent,
                                                elevation: 0)),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              openGaleri();
                                              Navigator.pop(context);
                                            },
                                            child: Icon(
                                              Icons.photo_album,
                                              color: Colors.black,
                                            ),
                                            style:
                                            ElevatedButton.styleFrom(
                                                shape: CircleBorder(
                                                    side: BorderSide(
                                                        color: Colors
                                                            .black)),
                                                fixedSize:
                                                Size(60, 60),
                                                primary: Colors
                                                    .transparent,
                                                elevation: 0))
                                      ],
                                    )
                                  ],
                                ),
                              )));
                        },
                        icon: Icon(Icons.edit,
                            size: 13, color: Colors.white)),
                  )
                ],
              )),
          SizedBox(
            height: 50,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 350,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          Text(
                            nama ?? "Your Name",
                            style: TextStyle(fontSize: 15),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                CupertinoIcons.right_chevron,
                                size: 15,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
                Divider(
                  height: 1,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(fontSize: 15),
                    ),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.only(left: 100),
                        child: (Text(
                          emails ?? "Your Email",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.underline),
                        )),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                        },
                        icon: Icon(
                          CupertinoIcons.right_chevron,
                          size: 15,
                        ))
                  ],
                ),
                Divider(
                  height: 1,
                  thickness: 0.8,
                ),


              ],
            ),
          )
        ],
      ),
    );
  }
}