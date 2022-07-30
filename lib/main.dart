// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCo_W2RkkjZYEtb0IXbyHU3uce73Qj2IG8",
          authDomain: "loadsensor-96033.firebaseapp.com",
          databaseURL: "https://loadsensor-96033-default-rtdb.firebaseio.com",
          projectId: "loadsensor-96033",
          storageBucket: "loadsensor-96033.appspot.com",
          messagingSenderId: "459209190693",
          appId: "1:459209190693:web:4f9416997aa11ce8673ecc"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Test> _tests = [];
  late TestDataSource _testDataSource;

  @override
  void initState() {
    // TODO: implement initState
    // _tests = getTestData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: FutureBuilder(
          future: getTestData(),
          builder: (context, snapshot) {
            _tests = snapshot.data! as List<Test>;
            if (snapshot.hasData) _testDataSource = TestDataSource(_tests);

            log(snapshot.data.toString());
            return SfDataGrid(
              source: _testDataSource,
              columns: [
                // ignore: deprecated_member_use
                GridTextColumn(
                    columnName: 'UID',
                    label: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'UID',
                          overflow: TextOverflow.ellipsis,
                        ))),

                GridTextColumn(
                    columnName: 'PartName',
                    label: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'PartName',
                          overflow: TextOverflow.ellipsis,
                        ))),

                GridTextColumn(
                    columnName: 'Count',
                    label: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Count',
                          overflow: TextOverflow.ellipsis,
                        ))),

                GridTextColumn(
                    columnName: 'PartWeight',
                    label: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'PartWeight',
                          overflow: TextOverflow.ellipsis,
                        ))),
              ],
            );
          }),
    ));
    // TODO: implement build
  }

  Future<List<Test>> getTestData() async {
    DataSnapshot dataSnapshot =
        await FirebaseDatabase.instance.ref('Test').get();
    List<Test> fromdoc = [];
    // for (var element in (dataSnapshot.value as List<Map>)) {
    fromdoc.add(
        Test.fromMap(Map<String, dynamic>.from(dataSnapshot.value! as Map)));
    log(fromdoc.first.toString());
    fromdoc.add(
        Test.fromMap(Map<String, dynamic>.from(dataSnapshot.value! as Map)));
    // log(fromdoc.toString());
    fromdoc.add(
        Test.fromMap(Map<String, dynamic>.from(dataSnapshot.value! as Map)));
    // log(fromdoc.toString());
    fromdoc.add(
        Test.fromMap(Map<String, dynamic>.from(dataSnapshot.value! as Map)));
    // log(fromdoc.toString());
    // }
    // if (fromdoc.isNotEmpty)
    return fromdoc;
    // return [
    // Test(100, 'James', 7854757, 17644),
    // Test(10432, 'Katie', 86557, 27644),
    // Test(100, 'Oreo', 765857, 37644),
    // Test(100, 'Jam', 857123, 47644)
    // ];
  }
}

class TestDataSource extends DataGridSource {
  TestDataSource(List<Test> tests) {
    dataGridRows = tests
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'UID', value: dataGridRow.uID),
              DataGridCell<String>(
                  columnName: 'PartName', value: dataGridRow.partName),
              DataGridCell<int>(columnName: 'Count', value: dataGridRow.count),
              DataGridCell<int>(
                  columnName: 'PartWeight', value: dataGridRow.partWeight)
            ]))
        .toList();
  }
  late List<DataGridRow> dataGridRows;
  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}

class Test {
  Test(this.uID, this.partName, this.count, this.partWeight);
  int? uID;
  String? partName;
  int? count;
  int? partWeight;

  Test.fromMap(Map<String, dynamic> map) {
    uID = map["UID"];
    partName = map["Part Weight"].toString();
    count = map["Part Count"];
    partWeight = map["Weight"];
  }
}
