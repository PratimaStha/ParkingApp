// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_parking/pages/payment.dart';

class selectslot extends StatefulWidget {
  final String? parkingName;
  final String? locationName;
  const selectslot({
    Key? key,
    this.parkingName,
    this.locationName,
  }) : super(key: key);

  @override
  State<selectslot> createState() => _selectslotState();
}

class _selectslotState extends State<selectslot> {
  List<String> selectedSlotIndex = <String>[];
  var countseatleft = 3 * 4;
  //var countSeatCenter = 4 * 10;
  var countseatright = 3 * 4;
  var listSeatLeft = [];
  //var listSeatCenter = [];
  var listSeatRight = [];

  @override
  void initState() {
    initseatvaluetolist(
      isListSeatLeft: true,
      //isListSeatCenter: false,
      isListSeatRight: false,
      count: countseatleft,
      side: "l",
      startingIndex: 0,
    );
    // initseatvaluetolist(
    //     isListSeatLeft: false,
    //     //isListSeatCenter: true,
    //     isListSeatRight: false,
    //     //count: countSeatCenter,
    //     side: "c");
    initseatvaluetolist(
      isListSeatLeft: false,
      //isListSeatCenter: false,
      isListSeatRight: true,
      count: countseatright,
      side: "r",
      startingIndex: 12,
    );
    setVisiblitySeat();
    super.initState();
  }

  initseatvaluetolist({
    bool isListSeatLeft = true,
    bool isListSeatRight = true,
    //bool isListSeatCenter = true,
    int count = 0,
    String? side,
    int startingIndex = 0,
  }) {
    Map<String, dynamic> objectdata;
    for (int i = startingIndex; i < count + startingIndex; i++) {
      objectdata = {
        "id": "${i + 1}",
        "isBooked": false,
        "isAvailable": true,
        "isSelected": false,
        "isVisible": true,
      };
      setState(() {
        if (isListSeatLeft) {
          listSeatLeft.add(objectdata);
        }
        // else if (isListSeatCenter) {
        //   listSeatCenter.add(objectdata);
        // }
        else {
          listSeatRight.add(objectdata);
        }
      });
    }
    debugPrint(listSeatLeft.toString());
    //debugPrint(listSeatCenter.toString());
    debugPrint(listSeatRight.toString());
  }

  setVisiblitySeat() {
    setState(() {
      listSeatLeft[1]["isVisible"] = false; // left column index 0
      listSeatLeft[4]["isVisible"] = false; // left column index 1
      listSeatLeft[7]["isVisible"] = false;
      listSeatLeft[10]["isVisible"] = false; // left column index 0
      listSeatRight[1]["isVisible"] = false; // right column index 1
      listSeatRight[4]["isVisible"] = false; // right column index 2
      listSeatRight[7]["isVisible"] = false;
      listSeatRight[10]["isVisible"] = false;
      //listSeatCenter[4]["isVisible"] = false; // right column index 5
    });
    //this function to set where's the position of the seat that should be invisible
  }

  setSelectedToBooked() {
    for (var seat in listSeatLeft) {
      if (seat["isSelected"]) {
        setState(() {
          seat["isBooked"] = true;
        });
      }
    }
    // listSeatCenter.forEach((seat) {
    //   if (seat["isSelected"]) {
    //     setState(() {
    //       seat["isBooked"] = true;
    //     });
    //   }
    // });

    for (var seat in listSeatRight) {
      if (seat["isSelected"]) {
        setState(() {
          seat["isBooked"] = true;
        });
      }
    }
    //this function to loop every side of seat, from selected to booked, u also can this function to send to u'r serves side
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.parkingName?.toUpperCase() ?? "",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          elevation: 0.5,
        ),
        // backgroundColor: Colors.black12,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: Row(children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.red,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                        "Booked",
                      ),
                    ),
                  ])),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.green,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: const Text(
                            "Selected",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: const Text(
                            "Available",
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
                // width: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: const Text(
                      "Slot for Car",
                      style: TextStyle(
                        color: Color.fromARGB(255, 138, 10, 1),
                        fontSize: 15,
                        // fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: const Text(
                      "Slot for bike/Scooter",
                      style: TextStyle(
                        color: Color.fromARGB(255, 138, 10, 1),
                        fontSize: 15,
                        //  fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
                // width: 150,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widgetSeat(listSeatLeft, false),
                    widgetSeat(listSeatRight, false),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Selected Slots",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    runSpacing: 4,
                    spacing: 4,
                    children: List.generate(
                      selectedSlotIndex.length,
                      (index) => FittedBox(
                        child: Text(
                          "${selectedSlotIndex[index]}, ",
                        ),
                      ),
                    ).toList(),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Number of selected slots",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    selectedSlotIndex.length.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Amount",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "NPR. ${selectedSlotIndex.length * 10}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff8B0000),
                ), // background
                // onPrimary: Colors.yellow,
                onPressed: selectedSlotIndex.isEmpty
                    ? null
                    : () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return Parking(
                                parkingName: widget.parkingName,
                                locationName: widget.locationName,
                                slot: selectedSlotIndex,
                                totalAmount: selectedSlotIndex.length * 10,
                              );
                            },
                          ),
                        );
                        //    setSelectedToBooked();
                        // Parking();
                      },
                child: const Text(
                  "Buy Slots",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // int num = 0;
  Widget widgetSeat(List dataSeat, bool isCenter) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3.93,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isCenter ? 4 : 2,
          childAspectRatio: isCenter ? 1 : 1,
          crossAxisSpacing: 35,
        ),
        itemCount: dataSeat.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                dataSeat[index]["isSelected"] = !dataSeat[index]["isSelected"];
                if (selectedSlotIndex.contains(dataSeat[index]["id"])) {
                  selectedSlotIndex.remove(dataSeat[index]["id"]);
                } else {
                  selectedSlotIndex.add(dataSeat[index]["id"]);
                }
              });
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              height: 20,
              decoration: BoxDecoration(
                color: dataSeat[index]["isBooked"]
                    ? Colors.red
                    : dataSeat[index]["isSelected"]
                        ? Colors.green
                        : Colors.white,
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  dataSeat[index]["id"],
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
