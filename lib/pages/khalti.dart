// import 'package:flutter/material.dart';
// //import 'package:flutter_parking/pages/khaltiintegrate.dart';
// import 'package:khalti_flutter/khalti_flutter.dart';

// class Khalti extends StatelessWidget {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   TextEditingController amountController = TextEditingController();
//   TextEditingController numberr = TextEditingController();

//   Khalti({super.key});
//   getAmt() {
//     return int.parse(amountController.text) * 100;
//   }

//   @override
//   // ignore: dead_code
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Khalti")),
//       body: Container(
//         padding: const EdgeInsets.all(15),
//         child: KhaltiButton(
//           config: PaymentConfig(
//             amount: 1000, // Amount should be in paisa
//             productIdentity: 'okay',
//             productName: 'Parking',
//           ),
//           preferences: const [
//             PaymentPreference.khalti,
//             PaymentPreference.eBanking,
//           ],
//           onSuccess: (su) {
//             const successsnackBar = SnackBar(
//               content: Text("Payment successful"),
//             );
//             ScaffoldMessenger.of(context).showSnackBar(successsnackBar);
//           },
//           onFailure: (fa) {
//             const failedsnackBar = SnackBar(
//               content: Text("payment failed"),
//             );
//             ScaffoldMessenger.of(context).showSnackBar(failedsnackBar);
//           },
//           onCancel: () {
//             const cancelsnackBar = SnackBar(
//               content: Text("payment cancel"),
//             );
//             ScaffoldMessenger.of(context).showSnackBar(cancelsnackBar);
//           },
//         ),
//         // child: Form(
//         //   key: _formKey,
//         //   child: ListView(
//         //     children: [
//         //       // KhaltiButton(
//         //       //   config: PaymentConfig(
//         //       //     amount: 1000, // Amount should be in paisa
//         //       //     productIdentity: 'okay',
//         //       //     productName: 'Parking',
//         //       //   ),
//         //       //   preferences: const [
//         //       //     PaymentPreference.khalti,
//         //       //     PaymentPreference.eBanking,
//         //       //   ],
//         //       //   onSuccess: (su) {
//         //       //     const successsnackBar = SnackBar(
//         //       //       content: Text("Payment successful"),
//         //       //     );
//         //       //     ScaffoldMessenger.of(context).showSnackBar(successsnackBar);
//         //       //   },
//         //       //   onFailure: (fa) {
//         //       //     const failedsnackBar = SnackBar(
//         //       //       content: Text("payment failed"),
//         //       //     );
//         //       //     ScaffoldMessenger.of(context).showSnackBar(failedsnackBar);
//         //       //   },
//         //       //   onCancel: () {
//         //       //     const cancelsnackBar = SnackBar(
//         //       //       content: Text("payment cancel"),
//         //       //     );
//         //       //     ScaffoldMessenger.of(context).showSnackBar(cancelsnackBar);
//         //       //   },
//         //       // ),
//         //       const SizedBox(height: 15),
//         //       TextFormField(
//         //         controller: numberr,
//         //         validator: (val) {
//         //           if (val?.isEmpty ?? false) {
//         //             return "Please enter numberplate";
//         //           }
//         //           return null;
//         //         },
//         //         keyboardType: TextInputType.number,
//         //         decoration: const InputDecoration(
//         //             labelText: "Enter numberplate",
//         //             enabledBorder: OutlineInputBorder(
//         //               borderSide: BorderSide(color: Colors.black),
//         //               borderRadius: BorderRadius.all(Radius.circular(8)),
//         //             ),
//         //             focusedBorder: OutlineInputBorder(
//         //               borderSide: BorderSide(color: Colors.green),
//         //               borderRadius: BorderRadius.all(Radius.circular(8)),
//         //             )),
//         //       ),
//         //       const SizedBox(height: 8),
//         //       MaterialButton(
//         //           shape: RoundedRectangleBorder(
//         //               borderRadius: BorderRadius.circular(8),
//         //               side: const BorderSide(color: Colors.red)),
//         //           height: 50,
//         //           color: const Color(0xFF56328c),
//         //           child: const Text("Make Payment"),
//         //           onPressed: () {
//         //             if (_formKey.currentState!.validate()) {
//         //               KhaltiScope.of(context).pay(
//         //                 config: PaymentConfig(
//         //                     amount: getAmt(),
//         //                     productIdentity: numberr.text,
//         //                     productName: "Parking"),
//         //                 preferences: [PaymentPreference.khalti],
//         //                 onSuccess: (su) {
//         //                   const successsnackBar = SnackBar(
//         //                     content: Text("Payment successful"),
//         //                     backgroundColor: Colors.green,
//         //                   );
//         //                   ScaffoldMessenger.of(context)
//         //                       .showSnackBar(successsnackBar);
//         //                 },
//         //                 onFailure: (fa) {
//         //                   const failedsnackBar = SnackBar(
//         //                     content: Text("payment failed"),
//         //                   );
//         //                   ScaffoldMessenger.of(context)
//         //                       .showSnackBar(failedsnackBar);
//         //                 },
//         //                 onCancel: () {
//         //                   const cancelsnackBar = SnackBar(
//         //                     content: Text("payment cancel"),
//         //                     backgroundColor: Colors.red,
//         //                   );
//         //                   ScaffoldMessenger.of(context)
//         //                       .showSnackBar(cancelsnackBar);
//         //                 },
//         //               );
//         //             } else {
//         //               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         //                 content: Text("Please fill all the fields"),
//         //                 backgroundColor: Colors.orange,
//         //               ));
//         //             }
//         //           }),
//         //     ],
//         //   ),
//         // ),
//       ),
//     );
//   }
// }
