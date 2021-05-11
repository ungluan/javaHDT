import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Repository {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String verificationId ="";
  String code ="";

  Future<void> verifyPhoneNumber({
    @required String phoneNumber,
    @required onVerificationCompleted,
    @required onVerificationFailed,
    @required onCodeSent,
    @required onCodeAutoRetrievalTimeOut,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onVerificationCompleted,
      verificationFailed: onVerificationFailed,
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeOut,
    );
  }

  Future<UserCredential> signInWithCredential(
      PhoneAuthCredential phoneAuthCredential) async {
      final user = await _firebaseAuth.signInWithCredential(phoneAuthCredential);
      this.verificationId = user.user.uid;
      return user;
  }

  Future<UserCredential> verifyWithSmsCode({
    @required String smsCode,
    @required String verificationId,
  }) async {
    this.verificationId = verificationId;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    return await signInWithCredential(credential);
  }
}
