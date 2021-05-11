import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_authientication_phone/blocs/phone_auth_bloc.dart';
import 'package:learn_authientication_phone/events/phone_auth_event.dart';
import 'package:learn_authientication_phone/pages/home_screen.dart';
import 'package:learn_authientication_phone/repositories/repository.dart';
import 'package:learn_authientication_phone/states/phone_auth_state.dart';

class LoginPage extends StatelessWidget {
  final Repository _repository;
  LoginPage({@required Repository repository})
      : assert(repository != null),
        this._repository = repository;

  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: _phoneAuthViewBuilder(context),
        ),
      ),
    );
  }

  Widget _phoneAuthViewBuilder(BuildContext context) {
    return BlocConsumer<PhoneAuthBloc, PhoneAuthState>(
      listener: (previous, current) {
        if (current is PhoneCodeAuthVerifyStateSuccess) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else if (current is PhoneCodeAuthVerifyStateFailure) {
          _showSnackBar(context, textValue: current.message);
        } else if (current is PhoneNumberAuthVerifyStateSuccess) {
          _showSnackBar(context,
              textValue: 'SMS code is sent to your mobile number.');
        } else if (current is PhoneNumberAuthVerifyStateFailure) {
          _showSnackBar(context, textValue: current.message);
        } else if (current is PhoneCodeAuthRetrievalTimeoutComplete) {
          _showSnackBar(context, textValue: 'Time out for auto retrieval');
        }
      },
      builder: (context, state) {
        if (state is PhoneAuthStateInitialize) {
          return _phoneNumberSubmitWidget(context);
        } else if (state is PhoneNumberAuthVerifyStateSuccess) {
          return _codeVerificationWidget(context, state.verificationId, '');
        } else if (state is PhoneNumberAuthVerifyStateFailure) {
          return _phoneNumberSubmitWidget(context);
        } else if (state is PhoneCodeAuthVerifyStateFailure) {
          return _codeVerificationWidget(context, state.verificationId, '');
        } else if (state is PhoneAuthStateLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PhoneCodeAuthRetrievalTimeoutComplete) {
          return _codeVerificationWidget(context, state.verificationId, '');
        } else if (state is PhoneCodeChangeState) {
          return _codeVerificationWidget(
              context, state.verificationId, _repository.code);
        }
        return Container(
          color: Colors.green,
        );
      },
    );
  }

  Widget _phoneNumberSubmitWidget(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.all(16),
          child: Text(
            'Phone Number',
            style: TextStyle(
              fontSize: 24,
              color: Colors.purple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 80,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Number phone',
              labelStyle: TextStyle(color: Colors.purple),
              hintText: 'Please enter your number phone',
              prefix: Container(
                margin: EdgeInsets.only(right: 8),
                child: Text('+84'),
              ),
            ),
            inputFormatters: [LengthLimitingTextInputFormatter(9)],
          ),
        ),
        GestureDetector(
          onTap: () {
            print(_phoneController.text);
            BlocProvider.of<PhoneAuthBloc>(context).add(
              PhoneNumberAuthEventVerified(
                phoneNumber: '+84' + _phoneController.text,
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.purple,
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo,
                  blurRadius: 6,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _codeVerificationWidget(
      BuildContext context, String verificationId, String code) {
    print(_repository.verificationId);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'Code Verify',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 40, left: 16),
                  child: Row(
                    children: [
                      _buildBoxCode(code.length > 0 ? code[0] : ''),
                      _buildBoxCode(code.length > 1 ? code[1] : ''),
                      _buildBoxCode(code.length > 2 ? code[2] : ''),
                      _buildBoxCode(code.length > 3 ? code[3] : ''),
                      _buildBoxCode(code.length > 4 ? code[4] : ''),
                      _buildBoxCode(code.length > 5 ? code[5] : ''),
                    ],
                  )),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  _buildNumberPad(1, context),
                  _buildNumberPad(2, context),
                  _buildNumberPad(3, context),
                ],
              ),
              Row(
                children: [
                  _buildNumberPad(4, context),
                  _buildNumberPad(5, context),
                  _buildNumberPad(6, context),
                ],
              ),
              Row(
                children: [
                  _buildNumberPad(7, context),
                  _buildNumberPad(8, context),
                  _buildNumberPad(9, context),
                ],
              ),
              Row(
                children: [
                  _buildSpace(),
                  _buildNumberPad(0, context),
                  _buildBackSpace(context)
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBoxCode(String number) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: Colors.grey.shade600),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          number,
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
    );
  }

  //0377884151
  void _showSnackBar(BuildContext context, {String textValue}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(textValue)));
  }

  Widget _buildNumberPad(int number, BuildContext context) {
    return Expanded(
      child: InkWell(
        splashColor: Colors.blueGrey,
        onTap: () {
          codeChanged(number);
          print(_repository.code);
          BlocProvider.of<PhoneAuthBloc>(context).add(
            PhoneCodeChangedEvent(
              code: _repository.code,
              verificationId: _repository.verificationId,
            ),
          );
          if (_repository.code.length == 6) {
            BlocProvider.of<PhoneAuthBloc>(context).add(
              PhoneCodeAuthEventVerified(
                verificationId: _repository.verificationId,
                smsCode: _repository.code,
              ),
            );
          }
        },
        child: Container(
          // color: Color(0xFFF0F7F3),
          margin: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Center(
            child: Text(
              number.toString(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackSpace(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          codeChanged(-1);
          print(_repository.code);
          BlocProvider.of<PhoneAuthBloc>(context).add(
            PhoneCodeChangedEvent(
              code: _repository.code,
              verificationId: _repository.verificationId,
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Center(
            child: Icon(
              Icons.backspace,
              color: Colors.black,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }

  void codeChanged(int number) {
    if (number != -1 && _repository.code.length < 6) {
      _repository.code += number.toString();
    } else if (number == -1 && _repository.code.length > 0) {
      _repository.code =
          _repository.code.substring(0, _repository.code.length - 1);
    }
  }

  Widget _buildSpace() {
    return Expanded(
      child: Container(),
    );
  }
}
