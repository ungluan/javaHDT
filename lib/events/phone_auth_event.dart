import 'package:equatable/equatable.dart';

abstract class PhoneAuthEvent extends Equatable {}

class PhoneNumberAuthEventVerified extends PhoneAuthEvent{
  final String phoneNumber ;

  PhoneNumberAuthEventVerified({this.phoneNumber});
  @override
  // TODO: implement props
  List<Object> get props => [phoneNumber];

}
class PhoneCodeAuthEventVerified extends PhoneAuthEvent{
  final String verificationId ;
  final String smsCode;

  PhoneCodeAuthEventVerified({this.verificationId, this.smsCode});

  @override
  // TODO: implement props
  List<Object> get props => [smsCode, verificationId];
}
class PhoneCodeAuthEventSent extends PhoneAuthEvent{
  final String verificationId;
  final int token;

  PhoneCodeAuthEventSent({this.verificationId, this.token});

  @override
  // TODO: implement props
  List<Object> get props => [verificationId, token];
}
class PhoneCodeAuthEventRetrievalTimeout extends PhoneAuthEvent{

  final String verificationId;
  PhoneCodeAuthEventRetrievalTimeout({this.verificationId});
  @override
  // TODO: implement props
  List<Object> get props => [verificationId];
}
class PhoneAuthVerificationEventFailed extends PhoneAuthEvent{
  final String message ;

  PhoneAuthVerificationEventFailed({this.message});
  @override
  // TODO: implement props
  List<Object> get props => [message];
}
class PhoneAuthVerificationEventCompleted extends PhoneAuthEvent{
  final String uid;

  PhoneAuthVerificationEventCompleted({this.uid});
  @override
  // TODO: implement props
  List<Object> get props => [uid];

}
class PhoneCodeChangedEvent extends PhoneAuthEvent{
  final String code ;
  final String verificationId;
  PhoneCodeChangedEvent({this.code, this.verificationId});

  @override
  // TODO: implement props
  List<Object> get props => [code, verificationId];

}