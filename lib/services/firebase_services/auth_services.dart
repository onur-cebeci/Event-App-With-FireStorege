// ignore_for_file: use_build_context_synchronously, avoid_print, unused_local_variable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kartek_demo/controllers/login_screen_controllers/auth_controller.dart';
import 'package:kartek_demo/models/user_models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthServices {
  //
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  //
  Future<bool> firebaseRegister(
      {required String email,
      required String password,
      required BuildContext context}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => pref.setString('email', email))
          .then((value) =>
              FirebaseFirestore.instance.collection('users').doc(email).set({
                "name": "",
                "surname": "",
                "birthDay": "",
                "mail": email,
                "city": "",
                "phone": "",
                "img": "",
                "address": "",
                "isAdmin": false,
              }));

      await pref.setBool("isActive", true);
      return true;
    } catch (e) {
      Provider.of<AuthController>(context, listen: false)
          .setCatchError(e: e.toString());
      await pref.setBool("isActive", false);
      print('Error registering user: $e');
      return false;
    }
  }

  //
  Future<bool> firebaseLogin(
      {required String email,
      required String password,
      required BuildContext context}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('email', '');
    try {
      await pref.setString('email', email);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => Future.delayed(
                Duration.zero,
                () {
                  getUserData(context: context);
                },
              ));

      await pref.setBool("isActive", true);
      return true;
    } catch (e) {
      await pref.setBool("isActive", false);

      print('Giriş hatası: $e');
      return false;
    }
  }

//
  Future<void> getUserData({required BuildContext context}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString('email');

    try {
      if (email != '' && email != null) {
        Future.delayed(
          Duration.zero,
          () async {
            DocumentSnapshot userData = await FirebaseFirestore.instance
                .collection('users')
                .doc(email)
                .get();
            Future.delayed(
              Duration.zero,
              () {
                Provider.of<AuthController>(context, listen: false)
                    .setUserDatas(context: context, userData: userData);
              },
            );
          },
        );
      }
    } catch (e) {
      print("Error getUserData : $e");
    }
  }

//
  Future<bool> firebaseSignOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      await FirebaseAuth.instance.signOut();
      await pref.setString('email', '');
      await pref.setBool("isActive", false);
      return true;
    } catch (e) {
      await pref.setBool("isActive", true);
      return false;
    }
  }

//
  Future<bool> signInWithGoogle({required BuildContext context}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential authResult =
            await _auth.signInWithCredential(credential);

        await pref
            .setString('email', authResult.user!.email.toString())
            .then((value) => FirebaseFirestore.instance
                    .collection('users')
                    .doc(authResult.user!.email.toString())
                    .set({
                  "name": "",
                  "surname": "",
                  "birthDay": "",
                  "mail": authResult.user!.email.toString(),
                  "city": "",
                  "phone": "",
                  "img": "",
                  "address": "",
                  "isAdmin": false,
                }))
            .then((value) => getUserData(context: context));

        await pref.setBool("isActive", true);
        return true;
      }
    } catch (e) {
      await pref.setBool("isActive", false);
      print(e.toString());
      return false;
    }
    return false;
  }

  //
  Future<void> uploadProfilePicture(
      {required File imageFile,
      required String img,
      required BuildContext context,
      required String pickedFileName}) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageReference = storage.ref().child(img);
      UploadTask uploadTask = storageReference.putFile(imageFile);
      await getPhotoAndSaveFirestore(
              context: context, pickedFileName: pickedFileName)
          .then((value) => getUserData(context: context));
    } catch (e) {
      print('Error uploading profile picture: $e');
    }
  }
}

Future<void> getPhotoAndSaveFirestore(
    {required BuildContext context, required String pickedFileName}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  try {
    var email = pref.getString('email');
    Reference ref = FirebaseStorage.instance.ref('${email.toString()}.jpg');
    var img = await ref.getDownloadURL();
    print(' getPhotoAndSaveFirestore: $img');
    Provider.of<AuthController>(context, listen: false)
        .setUserPicturDatas(img: img)
        .then((value) => null);
  } catch (e) {
    print('Error getPhotoAndSaveFirestore: $e');
  }
}
