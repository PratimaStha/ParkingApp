// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_parking/pages/signup.dart';

// import './homepage.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text("Login Page"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             const Padding(
//               padding: EdgeInsets.only(top: 60.0),
//               child: Center(
//                 child: SizedBox(
//                   width: 200,
//                   height: 150,
//                 ),
//               ),
//             ),
//             const Padding(
//               //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
//               padding: EdgeInsets.symmetric(horizontal: 15),
//               child: TextField(
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Email',
//                     hintText: 'Enter valid email id as abc@gmail.com'),
//               ),
//             ),
//             const Padding(
//               padding:
//                   EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
//               //padding: EdgeInsets.symmetric(horizontal: 15),
//               child: TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Password',
//                     hintText: 'Enter secure password'),
//               ),
//             ),
//             TextButton(
//               onPressed: () {},
//               child: const Text(
//                 'Forgot Password',
//                 style: TextStyle(
//                     color: Color.fromARGB(255, 138, 10, 1), fontSize: 15),
//               ),
//             ),
//             Container(
//               height: 50,
//               width: 250,
//               decoration: BoxDecoration(
//                   color: const Color(0xff8B0000),
//                   borderRadius: BorderRadius.circular(20)),
//               child: TextButton(
//                 //  backgroundColor: Colors.black,
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (_) => const HomePage()));
//                 },
//                 child: const Text(
//                   'Login',
//                   style: TextStyle(color: Colors.white, fontSize: 25),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 130,
//             ),
//             RichText(
//               text: TextSpan(
//                 children: [
//                   const TextSpan(
//                     text: 'New User?',
//                     style: TextStyle(fontSize: 15, color: Colors.black),
//                   ),
//                   //  recognizer: TapGestureRecognizer,
//                   // style: DefaultTextStyle.of(context).style,
//                   //  children: [
//                   TextSpan(
//                     text: 'Create Account!',
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromARGB(255, 138, 10, 1)),
//                     recognizer: TapGestureRecognizer()
//                       ..onTap = () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (_) => const Registration()));
//                       },
//                   ),
//                 ], //  TextSpan(text: ' world!'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
