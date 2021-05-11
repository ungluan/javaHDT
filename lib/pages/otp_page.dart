// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class OTPPage extends StatefulWidget {
//   @override
//   _OTPPageState createState() => _OTPPageState();
// }
//
// class _OTPPageState extends State<OTPPage> {
//   String smsCode = "";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(40),
//         child: AppBar(
//           title: Row(
//             children: [
//               Icon(
//                 Icons.arrow_back,
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Text('Verify OTP'),
//             ],
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Container(
//           margin: EdgeInsets.symmetric(
//             vertical: 16,
//             horizontal: 10,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Expanded(
//                 child: Column(
//                   children: [
//                     Container(
//                       child: GestureDetector(
//                         onTap: () {},
//                         child: Row(
//                           children: [
//                             _buildBox(smsCode.length > 0 ? smsCode[0] : ''),
//                             _buildBox(smsCode.length > 1 ? smsCode[1] : ''),
//                             _buildBox(smsCode.length > 2 ? smsCode[2] : ''),
//                             _buildBox(smsCode.length > 3 ? smsCode[3] : ''),
//                             _buildBox(smsCode.length > 4 ? smsCode[4] : ''),
//                             _buildBox(smsCode.length > 5 ? smsCode[5] : ''),
//                           ],
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         width: double.infinity,
//                         padding:
//                             EdgeInsets.symmetric(vertical: 16, horizontal: 10),
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).primaryColor,
//                           borderRadius: BorderRadius.circular(16),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey,
//                               offset: Offset(0, 4),
//                               blurRadius: 6.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Verify',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Row(
//                       children: [
//                         _buildNumber(1),
//                         _buildNumber(2),
//                         _buildNumber(3),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         _buildNumber(4),
//                         _buildNumber(5),
//                         _buildNumber(6),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         _buildNumber(7),
//                         _buildNumber(8),
//                         _buildNumber(9),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         _buildEmptySpace(),
//                         _buildNumber(0),
//                         _buildBackSpace(),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBox(String number) {
//     return Container(
//       margin: EdgeInsets.only(right: 10, top: 10, bottom: 20),
//       // padding: EdgeInsets.only(),
//       width: 50,
//       height: 50,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(width: 2, color: Colors.grey),
//       ),
//       child: Center(
//         child: Text(
//           number,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 30,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNumber(int number) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             if (smsCode.length < 6) smsCode += number.toString();
//           });
//         },
//         child: Container(
//           margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(color: Colors.white,
//               // borderRadius: BorderRadius.all(
//               //   Radius.circular(15),
//               // ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey,
//                   offset: Offset(0, 2),
//                   blurRadius: 6,
//                 ),
//               ]),
//           child: Center(
//             child: Text(
//               number.toString(),
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF1F1F1F),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBackSpace() {
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             if (smsCode.length > 0)
//               smsCode = smsCode.substring(0, smsCode.length - 1);
//           });
//         },
//         child: Container(
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             // borderRadius: BorderRadius.all(Radius.circular(15)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey,
//                 offset: Offset(0,2),
//                 blurRadius: 6.0,
//               ),
//             ]
//           ),
//           child: Center(
//             child: Icon(
//               Icons.backspace,
//               size: 28,
//               color: Color(0xFF1F1F1F),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmptySpace() {
//     return Expanded(
//       child: Container(),
//     );
//   }
// }
