// ignore_for_file: use_build_context_synchronously, avoid_print, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartek_demo/main.dart';
import 'package:kartek_demo/models/user_models/user_model.dart';
import 'package:kartek_demo/services/firebase_services/auth_services.dart';
import 'package:kartek_demo/witgets/custom_show_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';

enum AuthControllerStatus {
  loading,
  initial,
  notFound,
  error,
  completed,
  success
}

class AuthController extends ChangeNotifier {
  FirebaseAuthServices authServices = FirebaseAuthServices();

  AuthControllerStatus status = AuthControllerStatus.initial;

//
  UserModel _userModel = UserModel(
      surname: '',
      mail: '',
      birthDay: '',
      city: '',
      name: '',
      img: '',
      address: '',
      phone: '',
      isAdmin: false);

  UserModel get userModel => _userModel;

  bool _isVisible = true;

  bool get isVisible => _isVisible;
  bool _isOnline = false;

  bool get isOnline => _isOnline;

  String _catchError = "";
  String get catchError => _catchError;

//Auth Services

  Future<void> userRegister(
      {required String email,
      required String password,
      required BuildContext context}) async {
    bool isSucces = false;
    //
    isSucces = await authServices.firebaseRegister(
        email: email, password: password, context: context);
    if (isSucces) {
      CustomShowDialog.showSuccesMessage(context,
          title: 'register.succes.title',
          subtitle: 'register.succes', onPressed: () {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyApp(),
            ));
      });
    } else {
      if (_catchError ==
          "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
        CustomShowDialog.showMessage(context,
            iconData: Icons.error,
            title: 'register.error.title',
            subtitle: 'already.account');
      } else {
        CustomShowDialog.showMessage(context,
            iconData: Icons.error,
            title: 'register.error.title',
            subtitle: 'register.error');
      }
    }
    notifyListeners();
  }

//

  Future<void> userLogin(
      {required String email,
      required String password,
      required BuildContext context}) async {
    bool isSucces = false;
    //
    isSucces = await authServices.firebaseLogin(
        email: email, password: password, context: context);
    if (isSucces) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyApp(),
          ));
    } else {
      CustomShowDialog.showMessage(context,
          iconData: Icons.error,
          title: 'login.error.title',
          subtitle: 'login.error');
    }
    notifyListeners();
  }

  //
  Future<void> firebaseSignOut({required BuildContext context}) async {
    bool isSucces = false;
    isSucces = await authServices.firebaseSignOut();
    if (isSucces) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('email', '');
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      CustomShowDialog.showMessage(context,
          iconData: Icons.error, title: 'val.error.title', subtitle: 'error');
    }
    notifyListeners();
  }

  //
  Future<void> signInWithGoogle({required BuildContext context}) async {
    bool isSucces = false;
    isSucces = await authServices.signInWithGoogle(context: context);
    if (isSucces) {
      SharedPreferences pref = await SharedPreferences.getInstance();

      Navigator.pushReplacementNamed(context, '/home-screen');
    } else {
      CustomShowDialog.showMessage(context,
          iconData: Icons.error,
          title: 'login.error.title',
          subtitle: 'login.error');
    }
    notifyListeners();
  }

  //
  isUserOnline() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (pref.getBool("isActive") != null) {
      _isOnline = (pref.getBool("isActive"))!;
    } else {
      _isOnline = false;
    }

    notifyListeners();
  }

  Future<void> getUserData({required BuildContext context}) async {
    await authServices.getUserData(context: context);
    notifyListeners();
  }

  Future<void> setUserDatas(
      {required BuildContext context,
      required DocumentSnapshot<Object?> userData}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var email = pref.getString('email');
    if (email != '' && email != null) {
      _userModel = UserModel(
        name: userData['name'] ?? "",
        surname: userData['surname'] ?? "",
        mail: email,
        birthDay: userData['birthDay'] ?? "",
        city: userData['city'] ?? "",
        img: userData['img'] ?? "",
        address: userData['address'] ?? "",
        phone: userData['phone'] ?? "",
        isAdmin: userData['isAdmin'] ?? false,
      );
    } else {
      _userModel = UserModel(
          surname: '',
          mail: '',
          birthDay: '',
          city: '',
          name: '',
          img: '',
          address: '',
          phone: '',
          isAdmin: false);
    }

    notifyListeners();
  }

  Future<void> setUserPicturDatas({required String img}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.mail)
        .set({
      "name": userModel.name,
      "surname": userModel.surname,
      "mail": userModel.mail,
      "birthDay": userModel.birthDay,
      "city": userModel.city,
      "img": img,
      "address": userModel.address,
      "phone": userModel.phone,
      "isAdmin": userModel.isAdmin,
    });

    notifyListeners();
  }

  //
  Future<void> uploudpicture({required BuildContext context}) async {
    final ImagePicker _picker = ImagePicker();
    try {
      XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        var _imageFile = File(pickedFile.path);

        await authServices.uploadProfilePicture(
            context: context,
            imageFile: _imageFile,
            img: "${userModel.mail}.jpg",
            pickedFileName: pickedFile.name);
      } else {}
    } catch (e) {
      print('Error picking image: $e');
    }

    notifyListeners();
  }

//
  setVisiblity() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  setCatchError({required String e}) {
    _catchError = e;
    notifyListeners();
  }
}
