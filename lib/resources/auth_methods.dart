import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instoo/models/user.dart' as model;
import 'package:instoo/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection("users").doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  //Sign up user

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String result = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          // ignore: unnecessary_null_comparison
          file != null) {
        // Register user using firebase Auth
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImagetoStorage('profilePics', file, false);

        model.User user = model.User(
          username: username,
          bio: bio,
          uid: cred.user!.uid,
          email: email,
          followers: [],
          following: [],
          photoUrl: photoUrl,
        );

        // Upload other user information to firestore
        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
        result = 'success';
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-email') {
        return 'El correo que ingresaste no es valido';
      }
      if (error.code == 'weak-password') {
        return 'Tu contraseña debe ser más complicada';
      }
    } catch (error) {
      result = error.toString();
    }
    return result;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String result = "Some error occurred";

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        result = "success";
      } else {
        result = "Por favor ingresa los datos requeridos en los campos";
      }
    } catch (error) {
      result = error.toString();
    }
    return result;
  }

  Future<void> signoutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}
