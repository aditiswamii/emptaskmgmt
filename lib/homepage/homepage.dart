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
  var filtershort;
  var data;
  var filterdata;
  var snackBar;
  var projectdata;
  var currentmnthdata;
  var currentweekdata;
  var currenttaskdata;
  var taskdata;
  bool dateclick=false;
  int filterid=0;
  List<String> filterenum = ["Month", "Week", "Today"];
  // List<String> filterename = ["TW", "NW", "Today", ""];
  List<int> filterenumid = [1, 2, 3, 4];

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
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        dateclick=true;
        currentDate = pickedDate;
      });
    }
// Text("${strDigits(currentDate.day)}-${strDigits(currentDate.month)}-${strDigits(currentDate.year)}"),
//
  }

  showmessage(BuildContext context, String text) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      content: Container(
          child: Text(
            text,
            style: const TextStyle(color: Colors.black, fontSize: 18),
            textAlign: TextAlign.center,
          )),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"))
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
    getEmployee();
   // getcurrentmonth("8");
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

  void getEmployee() async {
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
        // var venam = jsonDecode(datacoun!)[0]['emp_name'].toString();
        // var venamid = jsonDecode(datacoun!)[0]['id'].toString();
       log(jsonDecode(datacoun!).toString());
        log(jsonDecode(datacoun!)['data'][0]['departmentdata']['department_name'].toString());
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
  void getcurrentmonth(String empid) async {
    log("getcurrentmnthapi");
    http.Response response =
    await http.get(Uri.parse('${StringConstants.BASE_URL}getEmployeeCurrentMonthTask/$empid'));
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      currentmnthdata = response.body;
      if (jsonResponse['status'] == 200) {
        setState(() {
          currentmnthdata = response.body;

          jsonDecode(currentmnthdata!);
        });

        log(jsonDecode(currentmnthdata!).toString());
        log(jsonDecode(currentmnthdata!)['data'][0]['id'].toString());
        log(jsonDecode(currentmnthdata!)['data'][0]['sub_task_id'].toString());
        log(jsonDecode(currentmnthdata!)['data'][0]['employee_id'].toString());
        log(jsonDecode(currentmnthdata!)['data'][0]['description'].toString());
        log(jsonDecode(currentmnthdata!)['data'][0]['state'].toString());
        log(jsonDecode(currentmnthdata!)['data'][0]['created_at'].toString());
        log(jsonDecode(currentmnthdata!)['data'][0]['updated_at'].toString());
        log(jsonDecode(currentmnthdata!)['data'][0]['star_date'].toString());
        log(jsonDecode(currentmnthdata!)['data'][0]['end_date'].toString());
      } else {
        setState(() {
          currentmnthdata = response.body;

          jsonDecode(currentmnthdata!);
        });
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message'],textAlign: TextAlign.center,),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
  }
  void getcurrentweek(String empid) async {
    log("getcurrentweekapi");
    http.Response response =
    await http.get(Uri.parse('${StringConstants.BASE_URL}getEmployeeCurrentWeekTask/$empid'));
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      currentweekdata = response.body;
      if (jsonResponse['status'] == 200) {
        setState(() {
          currentweekdata = response.body;

          jsonDecode(currentweekdata!);
        });

        log(jsonDecode(currentweekdata!).toString());
        log(jsonDecode(currentweekdata!)['data'][0]['id'].toString());
        log(jsonDecode(currentweekdata!)['data'][0]['sub_task_id'].toString());
        log(jsonDecode(currentweekdata!)['data'][0]['employee_id'].toString());
        log(jsonDecode(currentweekdata!)['data'][0]['description'].toString());
        log(jsonDecode(currentweekdata!)['data'][0]['state'].toString());
        log(jsonDecode(currentweekdata!)['data'][0]['created_at'].toString());
        log(jsonDecode(currentweekdata!)['data'][0]['updated_at'].toString());
        log(jsonDecode(currentweekdata!)['data'][0]['star_date'].toString());
        log(jsonDecode(currentweekdata!)['data'][0]['end_date'].toString());
      } else {
        setState(() {
          currentweekdata = response.body;

          jsonDecode(currentweekdata!);
        });
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message'],textAlign: TextAlign.center,),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
  }
  void getcurrenttask(String empid) async {
    log("getcurrenttaskapi");
    http.Response response =
    await http.get(Uri.parse('${StringConstants.BASE_URL}getEmployeeTodayTask/$empid'));
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      currenttaskdata = response.body;
      if (jsonResponse['status'] == 200) {
        setState(() {
          currenttaskdata = response.body;

          jsonDecode(currenttaskdata!);
        });

        log(jsonDecode(currenttaskdata!).toString());
        log(jsonDecode(currenttaskdata!)['data'][0]['id'].toString());
        log(jsonDecode(currenttaskdata!)['data'][0]['sub_task_id'].toString());
        log(jsonDecode(currenttaskdata!)['data'][0]['employee_id'].toString());
        log(jsonDecode(currenttaskdata!)['data'][0]['description'].toString());
        log(jsonDecode(currenttaskdata!)['data'][0]['state'].toString());
        log(jsonDecode(currenttaskdata!)['data'][0]['created_at'].toString());
        log(jsonDecode(currenttaskdata!)['data'][0]['updated_at'].toString());
        log(jsonDecode(currenttaskdata!)['data'][0]['star_date'].toString());
        log(jsonDecode(currenttaskdata!)['data'][0]['end_date'].toString());
      } else {
        setState(() {
          currenttaskdata = response.body;

          jsonDecode(currenttaskdata!);
        });
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message'],textAlign: TextAlign.center,),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
  }
  void gettask(String empid) async {
    log("gettaskapi");
    http.Response response =
    await http.get(Uri.parse('${StringConstants.BASE_URL}getTask/$empid'));
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      taskdata = response.body;
      if (jsonResponse['status'] == 200) {
        setState(() {
          taskdata = response.body;

          jsonDecode(taskdata!);
        });

        log(jsonDecode(taskdata!).toString());
        log(jsonDecode(taskdata!)['data'][0]['id'].toString());
        log(jsonDecode(taskdata!)['data'][0]['project_id'].toString());
        log(jsonDecode(taskdata!)['data'][0]['task_name'].toString());
        log(jsonDecode(taskdata!)['data'][0]['description'].toString());
        log(jsonDecode(taskdata!)['data'][0]['project_name'].toString());
        log(jsonDecode(taskdata!)['data'][0]['project']['id'].toString());
        log(jsonDecode(taskdata!)['data'][0]['project']['project_name'].toString());
        log(jsonDecode(taskdata!)['data'][0]['project']['description'].toString());
        log(jsonDecode(taskdata!)['data'][0]['project']['state'].toString());
        log(jsonDecode(taskdata!)['data'][0]['project']['created_at'].toString());
        log(jsonDecode(taskdata!)['data'][0]['project']['updated_at'].toString());
      } else {
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message'],textAlign: TextAlign.center,),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
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
          toolbarHeight: 50,
          backgroundColor: Colors.teal,
          title: const Text("Employee Task\nManagement",style: TextStyle(fontSize: 18),),
          actions: [
            GestureDetector(
              onTap: () {},
              child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  height: 28,
                  width: 28,
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
                padding: const EdgeInsets.all(8),
                color:Color(0xFFeeeeee),
                // alignment: Alignment.topCenter,
                height: 50,
                child:  Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width ,
                      // margin: EdgeInsets.all(10),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          stafflist(context),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black12, borderRadius: BorderRadius.circular(5)),
                            child: GestureDetector(
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
                                                      filterid = filterenumid[index];
                                                      //filtershort=filterename[index];
                                                      if(staffid!=null){
                                                        if(filterid==0){
                                                          getcurrentmonth(
                                                              "$staffid");
                                                        }else if(filterid==1){
                                                          getcurrentweek(
                                                              "$staffid");
                                                        }else if(filterid==2){
                                                          getcurrenttask("$staffid");
                                                        }
                                                      }
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
                                  width: (MediaQuery.of(context).size.width - 20) *1/ 4,
                                  child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: filtername==null
                                            ? const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("Month",
                                              style:
                                              TextStyle(color: Colors.black, fontSize: 14)),
                                        )
                                            : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(filtername.toString(),
                                              style: const TextStyle(
                                                  color: Colors.black, fontSize: 12)),
                                        ),
                                      ),
                                      // const Icon(
                                      //   Icons.arrow_drop_down_outlined,
                                      //   size: 22,
                                      // )
                                    ],
                                  ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
            if(filterid==0)
              table(context,currentmnthdata),

            if(filterid==1)
              table(context,currentweekdata),

            if(filterid==3)
              table(context,currenttaskdata),

          // if(filterid==0)
          //     currentmnth(),
          //
          //  if(filterid==1)
          //  currentweek(),
          //
          //   if(filterid==3)
          //     currenttask()



            // Container(
            //   alignment: Alignment(0,100),
            //   margin: const EdgeInsets.fromLTRB(10, 100, 10, 10),
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.vertical,
            //     child: datatable(context),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget stafflist(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
       // height: 50,
        width: ((MediaQuery.of(context).size.width - 20) * 3/4)-10,
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
                      itemCount: jsonDecode(datacoun!)['data']!.length,
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
                                        jsonDecode(datacoun!)['data'][index]['emp_name']
                                            .toString();
                                    staffid = jsonDecode(datacoun!)['data'][index]['id']
                                        .toString();
                                    if(filterid==0) {
                                      getcurrentmonth("$staffid");
                                    }else if(filterid==1){
                                      getcurrentweek("$staffid");
                                    }
                                    if (kDebugMode) {
                                      print(staffid);
                                    }
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text(
                                  "${jsonDecode(datacoun!)['data'][index]['emp_name']}\n(${jsonDecode(datacoun!)['data'][index]['department_name']})"
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


  Widget currentmnth(){
    return currentmnthdata==null?Container(

      margin:  const EdgeInsets.fromLTRB(10, 100, 10, 10)
    ):jsonDecode(currentmnthdata!)['data']==null?Container(
    ): Container(
        // alignment: Alignment(0,100),
         margin:  const EdgeInsets.fromLTRB(10, 100, 10, 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[

            Container(
              child: ListView.builder(
                  physics:
                  const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: jsonDecode(currentmnthdata!)['data']!.length,
                  itemBuilder: (BuildContext context,
                      int index) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            //borderRadius: BorderRadius.circular(5)),
                            height: 52,
                            child: Row(

                              children: [
                                Column(
                                  children: [
                                    Container(width: 100,  height: 50,  padding: const EdgeInsets.all(8),

                                        child: const Center(child: Text("Date",style: TextStyle(color: Colors.white),))),
                                  ],
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                ),
                                Column(
                                  children: [
                                    Container(width: 150,  height: 50,  padding: const EdgeInsets.all(8),
                                        child: const Center(child: Text("Task",style: TextStyle(color: Colors.white)))),
                                  ],
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                ),
                                // Column(
                                //   children: [
                                //     Container(width: 100,  height: 50,  padding: const EdgeInsets.all(8),
                                //         child: const Center(child: Text("Time",style: TextStyle(color: Colors.white)))),
                                //
                                //   ],
                                // ),
                                const VerticalDivider(
                                  color: Colors.black,
                                ),
                                Column(
                                  children: [
                                    Container(width: 100,
                                        height: 50,
                                        padding: const EdgeInsets.all(8),
                                        child: const Center(child: Text("Status",style: TextStyle(color: Colors.white)))),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(

                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: Row(

                              children: [
                                Column(
                                  children: [

                                    Container(width: 100,  padding: const EdgeInsets.all(8),
                                        child: Text("${jsonDecode(currentmnthdata!)['data'][index]['star_date'].toString()}\n-\n${jsonDecode(currentmnthdata!)['data'][index]['end_date'].toString()}")),

                                  ],
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                ),
                                Column(
                                  children: [

                                    Container(width: 150,  padding: const EdgeInsets.all(8),
                                        child: Text(jsonDecode(currentmnthdata!)['data'][index]['description'].toString())),
                                  ],
                                ),
                                // const VerticalDivider(
                                //   color: Colors.black,
                                // ),
                                // Column(
                                //   children: [
                                //
                                //     Container(width: 100,  padding: const EdgeInsets.all(8),
                                //         child: Text("${jsonDecode(currentmnthdata!)['data'][index]['star_date'].toString()}\n-\n${jsonDecode(currentmnthdata!)['data'][index]['end_date'].toString()}")),
                                //
                                //   ],
                                // ),
                                const VerticalDivider(
                                  color: Colors.black,
                                ),
                                Column(
                                  children: [

                                    Container(width: 100,  padding: const EdgeInsets.all(8),
                                        child: Text(jsonDecode(currentmnthdata!)['data'][index]['state'].toString())),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget currentweek(){
    return currentweekdata==null?Container(

        margin:  const EdgeInsets.fromLTRB(10, 100, 10, 10)
    ):jsonDecode(currentweekdata!)['data']==null?Container(
    ): Container(
      // alignment: Alignment(0,100),
      margin:  const EdgeInsets.fromLTRB(10, 100, 10, 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[

            Container(
              child: ListView.builder(
                  physics:
                  const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: jsonDecode(currentweekdata!)['data']!.length,
                  itemBuilder: (BuildContext context,
                      int index) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            //borderRadius: BorderRadius.circular(5)),
                            height: 52,
                            child: Row(

                              children: [
                                Column(
                                  children: [
                                    Container(width: 100,  height: 50,  padding: const EdgeInsets.all(8),

                                        child: const Center(child: Text("Date",style: TextStyle(color: Colors.white),))),
                                  ],
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                ),
                                Column(
                                  children: [
                                    Container(width: 150,  height: 50,  padding: const EdgeInsets.all(8),
                                        child: const Center(child: Text("Task",style: TextStyle(color: Colors.white)))),
                                  ],
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                ),
                                // Column(
                                //   children: [
                                //     Container(width: 100,  height: 50,  padding: const EdgeInsets.all(8),
                                //         child: const Center(child: Text("Time",style: TextStyle(color: Colors.white)))),
                                //
                                //   ],
                                // ),
                                const VerticalDivider(
                                  color: Colors.black,
                                ),
                                Column(
                                  children: [
                                    Container(width: 100,
                                        height: 50,
                                        padding: const EdgeInsets.all(8),
                                        child: const Center(child: Text("Status",style: TextStyle(color: Colors.white)))),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(

                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: Row(

                              children: [
                                Column(
                                  children: [

                                    Container(width: 100,  padding: const EdgeInsets.all(8),
                                        child: Text("${jsonDecode(currentweekdata!)['data'][index]['star_date'].toString()}\n-\n${jsonDecode(currentmnthdata!)['data'][index]['end_date'].toString()}")),

                                  ],
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                ),
                                Column(
                                  children: [

                                    Container(width: 150,  padding: const EdgeInsets.all(8),
                                        child: Text(jsonDecode(currentweekdata!)['data'][index]['description'].toString())),
                                  ],
                                ),
                                // const VerticalDivider(
                                //   color: Colors.black,
                                // ),
                                // Column(
                                //   children: [
                                //
                                //     Container(width: 100,  padding: const EdgeInsets.all(8),
                                //         child: Text("${jsonDecode(currentweekdata!)['data'][index]['star_date'].toString()}\n-\n${jsonDecode(currentmnthdata!)['data'][index]['end_date'].toString()}")),
                                //
                                //   ],
                                // ),
                                const VerticalDivider(
                                  color: Colors.black,
                                ),
                                Column(
                                  children: [

                                    Container(width: 100,  padding: const EdgeInsets.all(8),
                                        child: Text(jsonDecode(currentweekdata!)['data'][index]['state'].toString())),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget currenttask(){
    return currenttaskdata==null?Container(

        margin:  const EdgeInsets.fromLTRB(10, 100, 10, 10)
    ):jsonDecode(currenttaskdata!)['data']==null?Container(
    ): Container(
      // alignment: Alignment(0,100),
      margin:  const EdgeInsets.fromLTRB(10, 100, 10, 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[

            ListView.builder(
                physics:
                const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: jsonDecode(currenttaskdata!)['data']!.length,
                itemBuilder: (BuildContext context,
                    int index) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          //borderRadius: BorderRadius.circular(5)),
                          height: 52,
                          child: Row(

                            children: [
                              Column(
                                children: [
                                  Container(width: 100,  height: 50,  padding: const EdgeInsets.all(8),

                                      child: const Center(child: Text("Date",style: TextStyle(color: Colors.white),))),
                                ],
                              ),
                              const VerticalDivider(
                                color: Colors.black,
                              ),
                              Column(
                                children: [
                                  Container(width: 150,  height: 50,  padding: const EdgeInsets.all(8),
                                      child: const Center(child: Text("Task",style: TextStyle(color: Colors.white)))),
                                ],
                              ),
                              // const VerticalDivider(
                              //   color: Colors.black,
                              // ),
                              // Column(
                              //   children: [
                              //     Container(width: 100,  height: 50,  padding: const EdgeInsets.all(8),
                              //         child: const Center(child: Text("Time",style: TextStyle(color: Colors.white)))),
                              //
                              //   ],
                              // ),
                              const VerticalDivider(
                                color: Colors.black,
                              ),
                              Column(
                                children: [
                                  Container(width: 100,
                                      height: 50,
                                      padding: const EdgeInsets.all(8),
                                      child: const Center(child: Text("Status",style: TextStyle(color: Colors.white)))),
                                ],
                              ),

                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(

                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Row(

                            children: [
                              Column(
                                children: [

                                  Container(width: 100,  padding: const EdgeInsets.all(8),
                                      child: Text("${jsonDecode(currenttaskdata!)['data'][index]['star_date'].toString()}\n-\n${jsonDecode(currentmnthdata!)['data'][index]['end_date'].toString()}")),

                                ],
                              ),
                              const VerticalDivider(
                                color: Colors.black,
                              ),
                              Column(
                                children: [

                                  Container(width: 150,  padding: const EdgeInsets.all(8),
                                      child: Text(jsonDecode(currenttaskdata!)['data'][index]['description'].toString())),
                                ],
                              ),
                              // const VerticalDivider(
                              //   color: Colors.black,
                              // ),
                              // Column(
                              //   children: [
                              //
                              //     Container(width: 100,  padding: const EdgeInsets.all(8),
                              //         child: Text("${jsonDecode(currenttaskdata!)['data'][index]['star_date'].toString()}\n-\n${jsonDecode(currentmnthdata!)['data'][index]['end_date'].toString()}")),
                              //
                              //   ],
                              // ),
                              const VerticalDivider(
                                color: Colors.black,
                              ),
                              Column(
                                children: [

                                  Container(width: 100,  padding: const EdgeInsets.all(8),
                                      child: Text(jsonDecode(currenttaskdata!)['data'][index]['state'].toString())),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
            ),

          ],
        ),
      ),
    );
  }
  List newtable=[].toList(growable: true);
Widget datatable(BuildContext context,data1) {
  if(data1!=null) {
    if (jsonDecode(data1!)['data'] != null) {
      newtable = List.from(jsonDecode(data1!)['data']);
    }
  }
  return data1==null?Container():jsonDecode(data1!)['data']==null?Container():
  Container(
    margin:  const EdgeInsets.fromLTRB(10, 100, 10, 10),
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: 400,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.teal),
               dataTextStyle: TextStyle(color: Colors.black,fontSize: 14),
                  columnSpacing: 30.0,
                dataRowHeight: 200,
                border: TableBorder.all(color: Colors.black),
                columns: [
                  DataColumn(
                      label: Center(
                          child: Text(
                    'Date',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ))),
                  DataColumn(
                      label: Center(
                          child: Text('Task',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)))),
                  // DataColumn(
                  //     label: Center(
                  //         child: Text('Time',
                  //             style:
                  //                 TextStyle(color: Colors.white, fontSize: 18)))),
                  DataColumn(
                      label: Center(
                          child: Text('Status',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)))),
                        ],
                rows:
                newtable // Loops through dataColumnText, each iteration assigning the value to element
                        .map(
                          ((element) => DataRow(
                                cells: <DataCell>[
                                   //Extracting from Map element the value
                                  DataCell(Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${element["star_date"]!}",
                                        style:
                                            const TextStyle(color: Colors.black)),
                                  )),
                                  DataCell(Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Wrap(

                                      children: [
                                        // Text("${element["description"]!}${element["description"]!}",
                                        //     style:
                                        //         const TextStyle(color: Colors.black)),
                                        Text("${element["description"]!}",
                                            style:
                                            const TextStyle(color: Colors.black)),
                                      ],
                                    ),
                                  )),
                                  // DataCell(Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Text("${element["star_date"]!} - ${element["end_date"]!}",
                                  //       style:
                                  //           const TextStyle(color: Colors.black)),
                                  // )),
                                  DataCell(Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(element["state"]!,
                                        style:
                                            const TextStyle(color: Colors.black)),
                                  )),

                                ],
                              )),
                        )
                        .toList(),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
Widget table(BuildContext context,data1){
  if(data1!=null) {
    if (jsonDecode(data1!)['data'] != null) {
        newtable = List.from(jsonDecode(data1!)['data']);
    }else{

        newtable=[];

    }
  }else{


  }
  return data1==null?Container(
   ):newtable.isEmpty?Container():
  Container(
    margin:  const EdgeInsets.fromLTRB(10, 50, 10, 10),
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: 400,
                child: Column(
                  children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.teal,
                              border: Border.all(color: Colors.black)
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             children: [
                               Container(
                                   width: 98,
                                 child: Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Center(
                                      child: Text(
                                        'Date',
                                        style: TextStyle(color: Colors.white, fontSize: 18),
                                      )),
                                 ),
                               ),
                              Container(
                                width: 148,
                                decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(color: Colors.black),  left: BorderSide(color: Colors.black)
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text(
                                        'Task',
                                        style: TextStyle(color: Colors.white, fontSize: 18),
                                      )),
                                ),
                              ),
                              Container(

                                width: 98,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text(
                                        'Status',
                                        style: TextStyle(color: Colors.white, fontSize: 18),
                                      )),
                                ),
                              )]
                          ),
                        ),


                    newtable.isEmpty?Container(): ListView.builder(
  physics:
  const ClampingScrollPhysics(),
  shrinkWrap: true,
  itemCount: newtable.length,
  itemBuilder: (BuildContext context,
  int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            right: BorderSide(color: Colors.black),  left: BorderSide(color: Colors.black),
          bottom: BorderSide(color: Colors.black),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
           Container(
             width: 98,

             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Center(
                 child: Text("${newtable[index]["star_date"]!}",
                     style:
                     const TextStyle(color: Colors.black)),
               ),
             ),
           ),
            Container(
              width: 148,
              decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Colors.black),right: BorderSide(color: Colors.black),
                  ),

              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text("${newtable[index]["description"]!}",
                      style:
                      const TextStyle(color: Colors.black)),
                ),
              ),
            ),

            Container(
              width: 98,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(newtable[index]["state"]!,
                      style:
                      const TextStyle(color: Colors.black)),
                ),
              ),
            ),
          ],
      ),
    );
  }
  )
                      ],
                    ),



                )

              ),
      ]
            ),
          ),


  );
}
}


// Widget filtertime(BuildContext context) {
//   return Container(
//       margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           const Text(
//             "From",
//             style: TextStyle(fontSize: 18, color: Colors.black),
//           ),
//           SizedBox(
//             width: 100,
//             child: TextFormField(
//               controller: fromcontroller,
//               onChanged: (value) {},
//               maxLength: 7,
//             ),
//           ),
//           const Text(
//             "To",
//             style: TextStyle(fontSize: 18, color: Colors.black),
//           ),
//           SizedBox(
//             width: 100,
//             child: TextFormField(
//               controller: tocontroller,
//               onChanged: (value) {},
//               maxLength: 7,
//             ),
//           ),
//           GestureDetector(
//             onTap: () {},
//             child: Align(
//                 alignment: Alignment.centerRight,
//                 child: Container(
//                     width: 24,
//                     height: 24,
//                     padding: const EdgeInsets.all(2),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border.all(
//                           color: Colors.grey,
//                         ),
//                         borderRadius: BorderRadius.circular(5)),
//                     child: Image.asset(
//                       "assets/images/filter.png",
//                       height: 30,
//                       color: Colors.grey,
//                     ))),
//           ),
//         ],
//       ));
// }

