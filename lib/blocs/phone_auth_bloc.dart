import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_authientication_phone/events/phone_auth_event.dart';
import 'package:learn_authientication_phone/repositories/repository.dart';
import 'package:learn_authientication_phone/states/phone_auth_state.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  final Repository _repository;

  PhoneAuthBloc({@required Repository repository})
      : assert(repository != null),
        this._repository = repository,
        super(PhoneAuthStateInitialize());

  @override
  Stream<PhoneAuthState> mapEventToState(PhoneAuthEvent phoneAuthEvent) async* {
    if (phoneAuthEvent is PhoneNumberAuthEventVerified) {
      yield* _phoneAuthNumberVerifiedToState(phoneAuthEvent);
    } else if (phoneAuthEvent is PhoneCodeAuthEventVerified) {
      yield* _phoneAuthCodeVerifiedToState(phoneAuthEvent);
    } else if (phoneAuthEvent is PhoneCodeAuthEventSent) {
      yield PhoneNumberAuthVerifyStateSuccess(
          verificationId: phoneAuthEvent.verificationId);
    } else if (phoneAuthEvent is PhoneCodeAuthEventRetrievalTimeout) {
      yield PhoneCodeAuthRetrievalTimeoutComplete(
          verificationId: phoneAuthEvent.verificationId);
    } else if (phoneAuthEvent is PhoneAuthVerificationEventFailed) {
      yield PhoneNumberAuthVerifyStateFailure(message: phoneAuthEvent.message);
    } else if (phoneAuthEvent is PhoneAuthVerificationEventCompleted) {
      yield PhoneCodeAuthVerifyStateSuccess(uid: phoneAuthEvent.uid);
    } else if (phoneAuthEvent is PhoneCodeChangedEvent) {
      yield PhoneCodeChangeState(
        code: phoneAuthEvent.code,
        verificationId: phoneAuthEvent.verificationId,
      );
    }
  }

  Stream<PhoneAuthState> _phoneAuthNumberVerifiedToState(
      PhoneNumberAuthEventVerified phoneNumberAuthEventVerified) async* {
    try {
      yield PhoneAuthStateLoading();
      _repository.verifyPhoneNumber(
        phoneNumber: phoneNumberAuthEventVerified.phoneNumber,
        onVerificationCompleted: _onVerificationCompleted,
        onVerificationFailed: _onVerificationFailed,
        onCodeAutoRetrievalTimeOut: _onCodeAutoRetrievalTimeOut,
        onCodeSent: _onCodeSent,
      );
    } catch (e) {
      yield PhoneNumberAuthVerifyStateFailure(message: e.toString());
    }
  }

  Stream<PhoneAuthState> _phoneAuthCodeVerifiedToState(
      PhoneCodeAuthEventVerified phoneCodeAuthEventVerified) async* {
    try {
      yield PhoneAuthStateLoading();
      final userCredential = await _repository.verifyWithSmsCode(
        smsCode: phoneCodeAuthEventVerified.smsCode,
        verificationId: phoneCodeAuthEventVerified.verificationId,
      );
      yield PhoneCodeAuthVerifyStateSuccess(uid: userCredential.user.uid);
    } catch (e) {
      yield PhoneCodeAuthVerifyStateFailure(
        message: e.toString(),
        verificationId: phoneCodeAuthEventVerified.verificationId,
      );
    }
  }

  void _onVerificationCompleted(PhoneAuthCredential credential) async {
    final userCredential = await _repository.signInWithCredential(credential);
    if (userCredential != null) {
      add(PhoneAuthVerificationEventCompleted(uid: userCredential.user.uid));
    }
  }

  void _onVerificationFailed(FirebaseAuthException e) {
    add(PhoneAuthVerificationEventFailed(message: e.message));
  }

  void _onCodeSent(String verificationId, int resendToken) {
    add(PhoneCodeAuthEventSent(
      verificationId: verificationId,
      token: resendToken,
    ));
  }
  //0333 774 844
  void _onCodeAutoRetrievalTimeOut(String verificationId) {
    add(PhoneCodeAuthEventRetrievalTimeout(verificationId: verificationId));
  }
}
