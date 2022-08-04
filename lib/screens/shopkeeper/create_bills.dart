import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';

class Create_bill extends StatefulWidget {
  @override
  State<Create_bill> createState() => _Create_billState();
}

class _Create_billState extends State<Create_bill> {
  bool isdate = false;

  String? selectedDate;
  bool _isVisible = true;
  Future<void> _showDatePicker() async {
    final DateTime? datePicked = await showRoundedDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1920, 8),
        lastDate: DateTime(2101));

    setState(() {
      selectedDate = "${DateFormat("yyyy-MM-dd").format(datePicked!)}  ";
      isdate = !isdate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[900],
        title: const Text(
          'New Khata',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'Click Customer Picture',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CircleAvatar(
                radius: 50,
                child: Icon(Icons.camera_alt_outlined),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  children: const [
                    Text(
                      'Customer Name',
                      style: TextStyle(
                        color: Color(0xff7e7b84),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                //                      height: 60,
                padding: const EdgeInsets.only(
                  top: 5,
                ),
                child: TextFormField(
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      //                              suffixIcon: Image.asset('assets/upload_patient_doc_btn.png'),
                      hintText: 'Customer Name',
                      hintStyle: const TextStyle(
                        color: Color(0xff9890b8),
                        fontWeight: FontWeight.w600,
                      ),
                      isDense: true,
                      //                              fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      )),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  children: const [
                    Text(
                      'Customer Mobile No.',
                      style: TextStyle(
                        color: Color(0xff7e7b84),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                //                      height: 60,
                padding: const EdgeInsets.only(
                  top: 5,
                ),
                child: TextFormField(
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      //                              suffixIcon: Image.asset('assets/upload_patient_doc_btn.png'),
                      hintText: 'Customer Mobile No.',
                      hintStyle: const TextStyle(
                        color: Color(0xff9890b8),
                        fontWeight: FontWeight.w600,
                      ),
                      isDense: true,
                      //                              fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      )),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  children: const [
                    Text(
                      'Customer Address',
                      style: TextStyle(
                        color: Color(0xff7e7b84),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                //                      height: 60,
                padding: const EdgeInsets.only(
                  top: 5,
                ),
                child: TextFormField(
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      //                              suffixIcon: Image.asset('assets/upload_patient_doc_btn.png'),
                      hintText: 'Customer Address',
                      hintStyle: const TextStyle(
                        color: Color(0xff9890b8),
                        fontWeight: FontWeight.w600,
                      ),
                      isDense: true,
                      //                              fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      )),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  children: const [
                    Text(
                      'Transaction Date',
                      style: TextStyle(
                        color: Color(0xff7e7b84),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    _showDatePicker();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        " ${selectedDate ?? "Transaction Date"}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: isdate == false
                              ? Color(0xff9890b8)
                              : Colors.black,
                        ),
                      ),
                      const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  children: const [
                    Text(
                      'Due Date',
                      style: TextStyle(
                        color: Color(0xff7e7b84),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    _showDatePicker();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        " ${selectedDate ?? "Due Date"}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: isdate == false
                              ? Color(0xff9890b8)
                              : Colors.black,
                        ),
                      ),
                      const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  children: const [
                    Text(
                      'Amount',
                      style: TextStyle(
                        color: Color(0xff7e7b84),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                //                      height: 60,
                padding: const EdgeInsets.only(
                  top: 5,
                ),
                child: TextFormField(
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      //                              suffixIcon: Image.asset('assets/upload_patient_doc_btn.png'),
                      hintText: 'Amount',
                      hintStyle: const TextStyle(
                        color: Color(0xff9890b8),
                        fontWeight: FontWeight.w600,
                      ),
                      isDense: true,
                      //                              fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      )),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  children: const [
                    Text(
                      'Enter Detail',
                      style: TextStyle(
                        color: Color(0xff7e7b84),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                //                      height: 60,
                padding: const EdgeInsets.only(
                  top: 5,
                ),
                child: TextFormField(
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      //                              suffixIcon: Image.asset('assets/upload_patient_doc_btn.png'),
                      hintText: 'Enter Detail',
                      hintStyle: const TextStyle(
                        color: Color(0xff9890b8),
                        fontWeight: FontWeight.w600,
                      ),
                      isDense: true,
                      //                              fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      )),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: _isVisible ? Colors.green : Colors.white,
                          border: Border.all(
                            color: Colors.green,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            'Payable',
                            style: TextStyle(
                              color:
                                  _isVisible ? Colors.white : Colors.green[400],
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            'Receivable',
                            style: TextStyle(
                              color: Colors.green[400],
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: _isVisible,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.green,
                      ),
                      Text(
                        'Click Picture of the Bill',
                        style: TextStyle(
                          color: Colors.green[400],
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Enter'),
                    onPressed: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => Seller_Home()));
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
