import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_authientication_phone/pages/login_page.dart';
import 'package:learn_authientication_phone/repositories/repository.dart';

import 'blocs/phone_auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Repository _repository = Repository();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.yellow,
      ),
      home: BlocProvider<PhoneAuthBloc>(
        create: (context) => PhoneAuthBloc(repository: _repository,),
        child: LoginPage(repository: _repository,),
      ),
    );
  }
}