import 'package:equatable/equatable.dart';

abstract class PhoneAuthState extends Equatable{}

class PhoneAuthStateInitialize extends PhoneAuthState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class PhoneAuthStateLoading extends PhoneAuthState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class PhoneAuthStateError extends PhoneAuthState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class PhoneNumberAuthVerifyStateSuccess extends PhoneAuthState{
  final String verificationId ;

  PhoneNumberAuthVerifyStateSuccess({this.verificationId});

  @override
  // TODO: implement props
  List<Object> get props => [verificationId];
}
class PhoneNumberAuthVerifyStateFailure extends PhoneAuthState{
  final String message;

  PhoneNumberAuthVerifyStateFailure({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
class PhoneCodeAuthVerifyStateSuccess extends PhoneAuthState{
  final String uid ;

  PhoneCodeAuthVerifyStateSuccess({this.uid});
  @override
  // TODO: implement props
  List<Object> get props => [uid];
}
class PhoneCodeAuthVerifyStateFailure extends PhoneAuthState{

  final String message ;
  final String verificationId;

  PhoneCodeAuthVerifyStateFailure({this.message, this.verificationId});

  @override
  // TODO: implement props
  List<Object> get props => [message, verificationId];
}
class PhoneCodeAuthSendCodeStateSuccess extends PhoneAuthState{
  final String uid;

  PhoneCodeAuthSendCodeStateSuccess({this.uid});
  @override
  // TODO: implement props
  List<Object> get props => [uid];
}
class PhoneCodeAuthRetrievalTimeoutComplete extends PhoneAuthState{
  final verificationId ;

  PhoneCodeAuthRetrievalTimeoutComplete({this.verificationId});

  @override
  // TODO: implement props
  List<Object> get props => [verificationId];
}
class PhoneCodeChangeState extends PhoneAuthState{
  final String code ;
  final String verificationId;

  PhoneCodeChangeState({this.code, this.verificationId});
  @override
  // TODO: implement props
  List<Object> get props => [code, verificationId];
}