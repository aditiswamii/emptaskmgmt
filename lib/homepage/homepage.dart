import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../utils/stringconstant.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController fromcontroller = TextEditingController();
  TextEditingController tocontroller = TextEditingController();
  String staffname = "";
  var staffid;
  var datacoun;
  var filtername;
  var data;
  var filterdata;
  var snackBar;
  var projectdata;
  bool dateclick=false;
  List<String> filterenum = ["This week", "Next week", "Today", "Tomorrow"];
  DateTime currentDate = DateTime.now();
  // final now = DateTime.now();
  // final today = DateTime(now.year, now.month, now.day);
  // final yesterday = DateTime(now.year, now.month, now.day - 1);
  // final tomorrow = DateTime(now.year, now.month, now.day + 1);
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        dateclick=true;
        currentDate = pickedDate;
      });
// Text("${strDigits(currentDate.day)}-${strDigits(currentDate.month)}-${strDigits(currentDate.year)}"),
//
  }

  showmessage(BuildContext context, String text) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      content: Container(
          child: Text(
            "${text}",
            style: TextStyle(color: Colors.black, fontSize: 18),
            textAlign: TextAlign.center,
          )),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK"))
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    getCountry();
    //userdata();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final List<Map<String, String>> listOfColumns = [
    {"Date": "1 july", "Task": "1", "Number": "1"},
    {"Date": "2 july", "Task": "2", "Number": "2"},
    {"Date": "3 july", "Task": "1", "Number": "1"},
    {"Date": "4 july", "Task": "2", "Number": "2"},
    {"Date": "5 july", "Task": "1", "Number": "1"},
    {"Date": "6 july", "Task": "2", "Number": "2"},
    {"Date": "7 july", "Task": "1", "Number": "1"},
    {"Date": "8 july", "Task": "2", "Number": "2"},
    {"Date": "9 july", "Task": "1", "Number": "1"},
    {"Date": "10 july", "Task": "2", "Number": "2"},
    {"Date": "11 july", "Task": "1", "Number": "1"},
    {"Date": "12 july", "Task": "2", "Number": "2"},
    {"Date": "13 july", "Task": "1", "Number": "1"},
    {"Date": "14 july", "Task": "2", "Number": "2"},
    {"Date": "15 july", "Task": "1", "Number": "1"},
    {"Date": "16 july", "Task": "2", "Number": "2"},
    {"Date": "17 july", "Task": "1", "Number": "1"},
    {"Date": "18 july", "Task": "2", "Number": "2"},
    {"Date": "19 july", "Task": "1", "Number": "1"},
    {"Date": "20 july", "Task": "2", "Number": "2"},
    {"Date": "21 july", "Task": "1", "Number": "1"},
    {"Date": "22 july", "Task": "2", "Number": "2"},
    {"Date": "23 july", "Task": "3", "Number": "3"},
    {"Date": "24 july", "Task": "2", "Number": "2"},
    {"Date": "25 july", "Task": "1", "Number": "1"},
    {"Date": "26 july", "Task": "2", "Number": "2"},
    {"Date": "27 july", "Task": "1", "Number": "1"},
    {"Date": "28 july", "Task": "2", "Number": "2"},
    {"Date": "29 july", "Task": "1", "Number": "1"},
    {"Date": "30 july", "Task": "2", "Number": "2"}
  ];

  void getCountry() async {
    http.Response response =
    await http.get(Uri.parse('${StringConstants.BASE_URL}getEmployee'));
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      datacoun = response.body;
      if (jsonResponse['status'] == 200) {
        setState(() {
          datacoun = response.body;

          jsonDecode(datacoun!);
        });
        //getState(GetStateResponse);
        var venam = jsonDecode(datacoun!)[0]['emp_name'].toString();
        var venamid = jsonDecode(datacoun!)[0]['id'].toString();
        if (kDebugMode) {
          print(venam);
        }

        if (kDebugMode) {
          print(venamid);
        }
        log(jsonDecode(datacoun!)[0]['department']['department_name'].toString());
      } else {}
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
  }
  void getProject() async {
    http.Response response =
    await http.get(Uri.parse('${StringConstants.BASE_URL}getProjects'));
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      projectdata = response.body;
      if (jsonResponse['status'] == 200) {
        setState(() {
          projectdata = response.body;

          jsonDecode(projectdata!);
        });
        log(jsonDecode(projectdata!).toString());
        log(jsonDecode(projectdata!)[0]['project_name'].toString());
        log(jsonDecode(projectdata!)[0]['id'].toString());
        log(jsonDecode(projectdata!)[0]['description'].toString());
        log(jsonDecode(projectdata!)[0]['state'].toString());
      } else {}
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
  }
  filterapi(String userid) async {
    // showLoaderDialog(context);
    http.Response response =
    await http.post(Uri.parse("${StringConstants.BASE_URL}dashboard"), body: {
      'user_id': userid.toString(),
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      // Navigator.pop(context);
      if (jsonResponse['status'] == 200) {
        data = response.body;
        filterdata = jsonResponse; //get all the data from json string superheros
        setState(() {
          filterdata = jsonResponse;
        });
        onsuccess(filterdata);
        print(filterdata.length);
        print(filterdata.toString());


      } else {
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      // Navigator.pop(context);
      if (kDebugMode) {
        print(response.statusCode);
      }
    }

  }
  onsuccess(filterdata){

  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.teal,
          title: const Text("Employee Task\nManagement",style: TextStyle(fontSize: 22),),
          actions: [
            GestureDetector(
              onTap: () {},
              child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.centerRight,
                  child: Center(
                      child: Image.asset(
                    "assets/images/menu.png",
                    height: 28,
                    color: Colors.white,
                  ))),
            ),
          ],
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.all(8),
                color: Colors.teal.shade100,
                // alignment: Alignment.topCenter,
                height: 100,
                child:  Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width ,
                      // margin: EdgeInsets.all(10),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: (MediaQuery.of(context).size.width - 20)/7,
                              child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Staff",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ))),
                          stafflist(context),
                          GestureDetector(
                            onTap: () {
                              AlertDialog errorDialog = AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0)), //this right here
                                title: Container(
                                  // height: MediaQuery.of(context).size.height-300,
                                  width: 100,
                                  padding: const EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  child: ListView.builder(
                                      physics: const ClampingScrollPhysics(
                                          parent: BouncingScrollPhysics()),
                                      shrinkWrap: true,
                                      itemCount: filterenum.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            Container(
                                              //height: 50,
                                              padding: const EdgeInsets.all(4),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    filtername = filterenum[index];
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Text(
                                                  filterenum[index],
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                            const Divider(
                                              color: Colors.black12,
                                            )
                                          ],
                                        );
                                      }),
                                ),
                              );
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) => errorDialog);
                            },
                            child: SizedBox(
                                width: (MediaQuery.of(context).size.width - 20) *2/ 7,
                                child: Center(
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: Text("Filter",style: TextStyle(fontSize: 18),)),
                                          Container(
                                              width: 24,
                                              height: 24,
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  color: Colors.teal.shade100,
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5)),
                                              child: Image.asset(
                                                "assets/images/filter.png",
                                                height: 30,
                                                color: Colors.grey,
                                              )),


                                        ],
                                      ),
                                  ),
                                )),
                          ),
                          GestureDetector(
                            onTap: (){
                              //       if(staffid!=null){
                              //
                              //       }else{
                              //         snackBar = SnackBar(
                              //           content: Text("Please select staff"),
                              //         );
                              //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              //       }
                            },
                            child: Container(
                              width: (MediaQuery.of(context).size.width - 20) / 7,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                      color: Colors.teal.shade100,
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(5)),

                                  child: Center(
                                    child: Image.asset(
                                      "assets/images/right_arrow.png",height: 20,width: 20,

                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    // Container(
                    //   //width: (MediaQuery.of(context).size.width - 20) / 6,
                    //   alignment: Alignment.centerRight,
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       primary: Colors.white,
                    //       onPrimary: Colors.white,
                    //       elevation: 3,
                    //       alignment: Alignment.center,
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(30.0)),
                    //       fixedSize: const Size(100, 30),
                    //       //////// HERE
                    //     ),
                    //     onPressed: () {
                    //       if(staffid!=null){
                    //
                    //       }else{
                    //         snackBar = SnackBar(
                    //           content: Text("Please select staff"),
                    //         );
                    //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    //       }
                    //
                    //       // _presenter.login(emailController.text.toString(),
                    //       //     passwordController.text.toString());
                    //     },
                    //     child: const Text(
                    //       "Search",
                    //       style: TextStyle(color: Colors.teal,
                    //           fontSize: 16),
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    // ),

                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment(0,100),
              margin: const EdgeInsets.fromLTRB(10, 100, 10, 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: datatable(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget stafflist(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        height: 50,
        width: (MediaQuery.of(context).size.width - 20) * 3 / 7,
        alignment: Alignment.centerLeft,
        //color: Colors.white,
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(5)),
        // margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),

        child: GestureDetector(
          onTap: () {
            AlertDialog errorDialog = AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              contentPadding: const EdgeInsets.all(5), //this right here
              title: SingleChildScrollView(
                // height: 300,
                // width: 100,
                // alignment: Alignment.center,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 300,
                  width: MediaQuery.of(context).size.width - 20,
                  child: ListView.builder(
                      physics: const ClampingScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      shrinkWrap: true,
                      itemCount: jsonDecode(datacoun!).length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              //height: 50,
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.all(4),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    staffname =
                                        jsonDecode(datacoun!)[index]['emp_name']
                                            .toString();
                                    staffid = jsonDecode(datacoun!)[index]['id']
                                        .toString();

                                    if (kDebugMode) {
                                      print(staffid);
                                    }
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text(
                                  "${jsonDecode(datacoun!)[index]['emp_name']}\n(${jsonDecode(datacoun!)[index]['department_name']})"
                                      ,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black,),textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ),
            );
            showDialog(
                context: context,
                builder: (BuildContext context) => errorDialog);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: staffname.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Select Staff",
                            style:
                                TextStyle(color: Colors.black, fontSize: 14)),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(staffname.toString(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14)),
                      ),
              ),
              const Icon(
                Icons.arrow_drop_down_outlined,
                size: 22,
              )
            ],
          ),
        ));
  }

  Widget filtertime(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "From",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(
              width: 100,
              child: TextFormField(
                controller: fromcontroller,
                onChanged: (value) {},
                maxLength: 7,
              ),
            ),
            const Text(
              "To",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(
              width: 100,
              child: TextFormField(
                controller: tocontroller,
                onChanged: (value) {},
                maxLength: 7,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      width: 24,
                      height: 24,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Image.asset(
                        "assets/images/filter.png",
                        height: 30,
                        color: Colors.grey,
                      ))),
            ),
          ],
        ));
  }

  Widget datatable(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateProperty.all(Colors.teal),
              columns: [
                const DataColumn(
                    label: Center(
                        child: Text(
                  'Date',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ))),
                const DataColumn(
                    label: Center(
                        child: Text('Monday',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)))),
                const DataColumn(
                    label: Center(
                        child: Text('Tuesday',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)))),
                const DataColumn(
                    label: Center(
                        child: Text('Wednesday',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)))),
                const DataColumn(
                    label: Center(
                        child: Text('Thrusday',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)))),
                const DataColumn(
                    label: Center(
                        child: Text('Friday',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)))),
                const DataColumn(
                    label: Center(
                        child: Text('Saturday',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)))),
              ],
              rows:
                  listOfColumns // Loops through dataColumnText, each iteration assigning the value to element
                      .map(
                        ((element) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text(
                                  element["Date"]!,
                                  style: const TextStyle(color: Colors.black),
                                )), //Extracting from Map element the value
                                DataCell(Text(element["Task"]!,
                                    style:
                                        const TextStyle(color: Colors.black))),
                                DataCell(Text(element["Number"]!,
                                    style:
                                        const TextStyle(color: Colors.black))),
                                DataCell(Text(element["Number"]!,
                                    style:
                                        const TextStyle(color: Colors.black))),
                                DataCell(Text(element["Number"]!,
                                    style:
                                        const TextStyle(color: Colors.black))),
                                DataCell(Text(element["Number"]!,
                                    style:
                                        const TextStyle(color: Colors.black))),
                                DataCell(Text(element["Number"]!,
                                    style:
                                        const TextStyle(color: Colors.black))),
                              ],
                            )),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
