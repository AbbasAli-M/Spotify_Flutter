import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_flutter/data/models/auth/create_user_req.dart';
import 'package:spotify_flutter/data/models/auth/signin_user_req.dart';

import '../../../core/config/constants/app_urls.dart';
import '../../../domain/entities/auth/user.dart';
import '../../../domain/entities/song/song.dart';
import '../../models/auth/user.dart';
import '../../models/song/song.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserReq createUserReq);

  Future<Either> signin(SigninUserReq signinUserReq);

  Future<Either> getUser();

}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signinUserReq.email, password: signinUserReq.password);

      return const Right('Signin was Successful');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if(e.code== 'Invalid Email') {
        message = 'No user found for that email';
      } else if(e.code == 'Invalid Credentials'){
        message = 'Wrong password provided for that user';
      }
      return left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserReq.email, password: createUserReq.password);

      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid)
      .set(
        {
          'name' : createUserReq.fullName,
          'email' : data.user?.email,
        }
      );

      return const Right('Signup was Successful');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if(e.code== 'weak-password') {
        message = 'The Password provided is very weak';
      } else if(e.code == 'email-already-in-use'){
        message = 'An account already exists with that email';
      }
      return left(message);
    }
  }

  @override
  Future<Either> getUser() async{
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseFirestore.collection('Users').doc(
          firebaseAuth.currentUser?.uid
      ).get();

      UserModel userModel = UserModel.fromJson(user.data() !);
      userModel.imageURL = firebaseAuth.currentUser?.photoURL ?? AppUrls.defaultImage;
      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);
    } catch (e) {
      return const Left('An error occurred');
    }
  }

}
