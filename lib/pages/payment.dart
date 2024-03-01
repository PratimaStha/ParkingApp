// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_parking/pages/khalti.dart';
import 'package:flutter_parking/pages/qr.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class Parking extends StatefulWidget {
  final int? totalAmount;
  final List<String>? slot;
  final String? parkingName;
  final String? locationName;
  const Parking({
    Key? key,
    this.totalAmount = 0,
    this.parkingName,
    this.locationName,
    this.slot,
  }) : super(key: key);

  @override
  State<Parking> createState() => _ParkingState();
}

class _ParkingState extends State<Parking> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController numberr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Payment",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  // leading: CircleAvatar(child: Text('A')),
                  title: const Text('Parking Name'),
                  subtitle: Text(widget.parkingName ?? ""),
                  // trailing: Icon(Icons.favorite_rounded),
                ),
                // Divider(height: 0),
                ListTile(
                  // leading: CircleAvatar(child: Text('B')),
                  title: const Text('Location'),
                  subtitle: Text(widget.locationName ?? ""),
                  // //    'Longer supporting text to demonstrate how the text wraps and how the leading and trailing widgets are centered vertically with the text.'),
                  // trailing: Icon(Icons.favorite_rounded),
                ),
                ListTile(
                  // leading: CircleAvatar(child: Text('B')),
                  title: const Text('Slots'),
                  subtitle: Wrap(
                    direction: Axis.horizontal,
                    runSpacing: 4,
                    spacing: 4,
                    children: List.generate(
                      widget.slot?.length ?? 0,
                      (index) => FittedBox(
                        child: Text(
                          "${widget.slot?[index]}, ",
                        ),
                      ),
                    ).toList(),
                  ),
                ),
                ListTile(
                  // leading: CircleAvatar(child: Text('B')),
                  title: const Text('Total Price'),
                  subtitle: Text(widget.totalAmount.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {});
                      },
                      controller: numberr,
                      validator: (val) {
                        if (val?.isEmpty ?? false) {
                          return "Please enter numberplate";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: "Enter number plate",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          numberr.text != ""
              ? KhaltiButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xff8B0000)),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  config: PaymentConfig(
                    amount: (widget.totalAmount ?? 0) * 100,
                    productIdentity: numberr.text,
                    productName: 'Parking',
                  ),
                  preferences: const [
                    PaymentPreference.khalti,
                    PaymentPreference.eBanking,
                  ],
                  onSuccess: (su) {
                    const successsnackBar = SnackBar(
                      content: Text("Payment successful"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(successsnackBar);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => QRPage(
                          data: numberr.text,
                        ),
                      ),
                    );
                  },
                  onFailure: (fa) {
                    const failedsnackBar = SnackBar(
                      content: Text("payment failed"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(failedsnackBar);
                  },
                  onCancel: () {
                    const cancelsnackBar = SnackBar(
                      content: Text("payment cancel"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(cancelsnackBar);
                  },
                )
              : const ElevatedButton(
                  onPressed: null,
                  child: Text("Pay"),
                ),
          // MaterialButton(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(8),
          //   ),
          //   height: 50,
          //   color: const Color(0xFF56328c),
          //   child: const Text(
          //     "Make Payment",
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   onPressed: () {
          //     if (_formKey.currentState!.validate()) {
          //       // Navigator.of(context).push(
          //       //   MaterialPageRoute(
          //       //     builder: (context) => QRPage(
          //       //       data: numberr.text,
          //       //     ),
          //       //   ),
          //       // );
          //       // KhaltiScope.of(context).pay(
          //       //   config: PaymentConfig(
          //       //       amount: (totalAmount ?? 0) * 100,
          //       //       productIdentity: numberr.text,
          //       //       productName: "Parking"),
          //       //   preferences: [PaymentPreference.khalti],
          //       //   onSuccess: (su) {
          //       //     const successsnackBar = SnackBar(
          //       //       content: Text("Payment successful"),
          //       //       backgroundColor: Colors.green,
          //       //     );
          //       //     ScaffoldMessenger.of(context).showSnackBar(successsnackBar);
          //       //     Navigator.of(context).push(
          //       //       MaterialPageRoute(
          //       //         builder: (context) => QRPage(
          //       //           data: su.productIdentity,
          //       //         ),
          //       //       ),
          //       //     );
          //       //   },
          //       //   onFailure: (fa) {
          //       //     const failedsnackBar = SnackBar(
          //       //       content: Text("payment failed"),
          //       //     );
          //       //     ScaffoldMessenger.of(context).showSnackBar(failedsnackBar);
          //       //   },
          //       //   onCancel: () {
          //       //     const cancelsnackBar = SnackBar(
          //       //       content: Text("payment cancel"),
          //       //       backgroundColor: Colors.red,
          //       //     );
          //       //     ScaffoldMessenger.of(context).showSnackBar(cancelsnackBar);
          //       //   },
          //       // );
          //     } else {
          //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //         content: Text("Please fill all the fields"),
          //         backgroundColor: Colors.orange,
          //       ));
          //     }
          //   },
          // ),
          const SizedBox(
            height: 20,
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.black,
          //     ), // background

          //     onPressed: () {
          //       Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) {
          //           return Khalti();
          //         },
          //       ));
          //     },
          //     child: const Text(
          //       "Payment through khalti",
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   ),
          // ),
        ],
      ),
      // SizedBox(height: 10),

      // SizedBox(
      //   height: 10
      // ),
    );
  }
}
