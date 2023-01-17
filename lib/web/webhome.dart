import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class WebHome extends StatefulWidget {
  const WebHome({super.key});

  @override
  State<WebHome> createState() => _WebHomeState();
}

class _WebHomeState extends State<WebHome> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  gettingtables() async {
    var data = await _firebaseFirestore.collection('Quizs').get();
    return data.docs;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'All Quizs',
            style: TextStyle(color: Colors.black),
          )),
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: gettingtables(),
          builder: (context, AsyncSnapshot datasnap) {
            log('${datasnap.data}');

            if (datasnap.hasData) {
              return ListView.builder(
                  itemCount: datasnap.data.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)),
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(5),
                                    topRight: Radius.circular(5))),
                          ),
                          Spacer(),
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            hoverColor: Colors.amber,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Tableview(
                                            table:
                                                '${datasnap.data[index]['EnglishTableNAme']}',
                                            type: 'EnglishTableNAme',
                                          )));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.4,
                              child: ListTile(
                                title: Text(
                                    '${datasnap.data[index]['EnglishTableNAme']}'),
                                subtitle: Text(
                                    '${datasnap.data[index]['LevelTableNAme']}'),
                              ),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            hoverColor: Colors.amber,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Tableview(
                                            table:
                                                '${datasnap.data[index]['UrduTableNAme']}',
                                            type: 'UrduTableNAme',
                                          )));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.4,
                              child: ListTile(
                                title: Text(
                                    '${datasnap.data[index]['UrduTableNAme']}'),
                                subtitle: Text(
                                    '${datasnap.data[index]['LevelTableNAme']}'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }));
            } else if (datasnap.connectionState == ConnectionState.waiting) {
              return Center(child: CupertinoActivityIndicator());
            } else {
              return Center(child: Text('No Data'));
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var engname = TextEditingController();
          var urduname = TextEditingController();
          var level = TextEditingController();
          showDialog(
              context: context,
              builder: (context) => Container(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height / 3,
                        horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Column(children: [
                      Text(
                        'Add a new table',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CupertinoTextField(
                        controller: engname,
                        placeholder: 'English Table Name',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CupertinoTextField(
                        controller: urduname,
                        placeholder: 'Urdu Table Name',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CupertinoTextField(
                        controller: level,
                        placeholder: 'Level',
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            var levelselected =
                                int.parse(level.text.toString());
                            if (engname.text.isEmpty ||
                                urduname.text.isEmpty ||
                                level.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Fill All The Fields')));
                            } else if ((1 <= levelselected &&
                                    levelselected <= 3) ==
                                false) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Level must be between 1 and 3')));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => Center(
                                        child: CupertinoActivityIndicator(),
                                      ));
                              _firebaseFirestore
                                  .collection('Quizs')
                                  .doc(engname.text)
                                  .set({
                                'EnglishTableNAme': engname.text,
                                'UrduTableNAme': urduname.text,
                                'LevelTableNAme': level.text
                              }).then((value) {
                                Navigator.pop(context);
                                setState(() {});
                              });
                            }
                          },
                          child: Text('Submit'))
                    ]),
                  ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

/// table viewe
class Tableview extends StatefulWidget {
  Tableview({this.table, this.type});
  var table, type;

  @override
  State<Tableview> createState() => _Tableview(table, type);
}

class _Tableview extends State<Tableview> {
  _Tableview(this.tablel, this.type);
  var tablel, type;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  gettingtables() async {
    var data = await _firebaseFirestore
        .collection('Quizs')
        .doc(tablel)
        .collection(type)
        .get();
    return data.docs;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            tablel,
            style: TextStyle(color: Colors.black),
          )),
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: gettingtables(),
          builder: (context, AsyncSnapshot datasnap) {
            log('${datasnap.data}');
            if (datasnap.hasData) {
              return ListView.builder(
                  itemCount: datasnap.data.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      title: Text('word'),
                      subtitle: Text('word'),
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                    );
                  }));
            } else if (datasnap.connectionState == ConnectionState.waiting) {
              return Center(child: CupertinoActivityIndicator());
            } else if (datasnap.data.toString == '[]') {
              return Center(child: Text('No Data'));
            } else {
              return Center(child: CupertinoActivityIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var engname = TextEditingController();
          var urduname = TextEditingController();
          var level = TextEditingController();
          showDialog(
              context: context,
              builder: (context) => Container(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height / 3,
                        horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Column(children: [
                      Text(
                        'Add a new table',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CupertinoTextField(
                        controller: engname,
                        placeholder: 'English Table Name',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CupertinoTextField(
                        controller: urduname,
                        placeholder: 'Urdu Table Name',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CupertinoTextField(
                        controller: level,
                        placeholder: 'Level',
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            showDialog(context: context, builder: (context)=>Scaffold(body: PageView(children: [
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(children: [
                                 CupertinoTextField(placeholder: 'Word',),
                                 CupertinoTextField(placeholder: 'Origin',),
                                 CupertinoTextField(placeholder: 'Origin',)
                                ],),
                              ),
                            ],),));
                          }, child: Text('Submit'))
                    ]),
                  ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
