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
                      title: Text(datasnap.data[index]['word']),
                      subtitle: Text(datasnap.data[index]['defination']),
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
          showDialog(
              context: context,
              builder: (context) {
                var origincntrl = TextEditingController();
                var definationcntrl = TextEditingController();
                var wordcntrl = TextEditingController();
                var pronunciationcntrl = TextEditingController();
                var part_of_speechcntrl = TextEditingController();
                var sentencecntrl = TextEditingController();
                var multiplechoicescntrl = TextEditingController();
                var Matchwordcntrl = TextEditingController();
                var SpellingMccntrl = TextEditingController();
                var Mcq_Questioncntrl = TextEditingController();
                var Mcq_Option_Acntrl = TextEditingController();
                var Mcq_Option_Bcntrl = TextEditingController();
                var Mcq_Option_Ccntrl = TextEditingController();
                var Mcq_Option_Dcntrl = TextEditingController();
                var Mcq_CorrectAnswercntrl = TextEditingController();
                var Mw_Option_Acntrl = TextEditingController();
                var Mw_Option_Bcntrl = TextEditingController();
                var Mw_Option_Ccntrl = TextEditingController();
                var Mw_Option_Dcntrl = TextEditingController();
                var Mw_CorrectAnswercntrl = TextEditingController();
                var Mc_Option_Acntrl = TextEditingController();
                var Mc_Option_Bcntrl = TextEditingController();
                var Mc_Option_Ccntrl = TextEditingController();
                var Mc_Option_Dcntrl = TextEditingController();
                var Mc_CorrectAnswercntrl = TextEditingController();

                return Scaffold(
                  appBar: AppBar(
                      title: Text(
                    'Add a new word ',
                    style: TextStyle(color: Colors.black),
                  )),
                  backgroundColor: Colors.white,
                  body: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CupertinoTextField(
                            controller: wordcntrl,
                            placeholder: 'Word',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoTextField(
                            controller: definationcntrl,
                            placeholder: 'Meaning',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoTextField(
                            controller: pronunciationcntrl,
                            placeholder: 'pronunciation',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoTextField(
                            controller: origincntrl,
                            placeholder: 'Origin',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoTextField(
                            controller: part_of_speechcntrl,
                            placeholder: 'Part of Speech',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoTextField(
                            controller: sentencecntrl,
                            placeholder: 'Sentence',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: Colors.black,
                            height: 3,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Multiple Choice Question '),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoTextField(
                            controller: Mcq_Questioncntrl,
                            placeholder: 'Question',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoTextField(
                            controller: Mcq_Option_Acntrl,
                            placeholder: 'Option A',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoTextField(
                            controller: Mcq_Option_Bcntrl,
                            placeholder: 'Option B',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoTextField(
                            controller: Mcq_Option_Ccntrl,
                            placeholder: 'Option C',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoTextField(
                            controller: Mcq_Option_Dcntrl,
                            placeholder: 'Option D',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoTextField(
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: Mcq_CorrectAnswercntrl,
                            placeholder: 'Answer between 1 and 4',
                          ),
                          Text('e.g 1 for Option A and 4 for Option D'),
                          SizedBox(height: 10),
                          Divider(
                            color: Colors.black,
                            height: 3,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'Set Options for question , Chose the correct Spelling'),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'like sher , sheir, shar, share',
                            style: TextStyle(fontSize: 10),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoTextField(
                            controller: Mc_Option_Acntrl,
                            placeholder: 'Option A',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoTextField(
                            controller: Mc_Option_Bcntrl,
                            placeholder: 'Option B',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoTextField(
                            controller: Mc_Option_Ccntrl,
                            placeholder: 'Option C',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoTextField(
                            controller: Mc_Option_Dcntrl,
                            placeholder: 'Option D',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoTextField(
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: Mc_CorrectAnswercntrl,
                            placeholder: 'Answer between 1 and 4',
                          ),
                          Text('e.g 1 for Option A and 4 for Option D'),
                          SizedBox(height: 10),
                          Divider(
                            color: Colors.black,
                            height: 3,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'Set Options for question , what word has the folloeing defination'),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'like human , eyes, books , brain',
                            style: TextStyle(fontSize: 10),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoTextField(
                            controller: Mw_Option_Acntrl,
                            placeholder: 'Option A',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoTextField(
                            controller: Mw_Option_Bcntrl,
                            placeholder: 'Option B',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoTextField(
                            controller: Mw_Option_Ccntrl,
                            placeholder: 'Option C',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoTextField(
                            controller: Mw_Option_Dcntrl,
                            placeholder: 'Option D',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoTextField(
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: Mw_CorrectAnswercntrl,
                            placeholder: 'Answer between 1 and 4',
                          ),
                          Text('e.g 1 for Option A and 4 for Option D'),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                if (wordcntrl.text.isEmpty ||
                                    definationcntrl.text.isEmpty ||
                                    pronunciationcntrl.text.isEmpty ||
                                    origincntrl.text.isEmpty ||
                                    part_of_speechcntrl.text.isEmpty ||
                                    sentencecntrl.text.isEmpty ||
                                    Mcq_Questioncntrl.text.isEmpty ||
                                    Mcq_Option_Acntrl.text.isEmpty ||
                                    Mcq_Option_Bcntrl.text.isEmpty ||
                                    Mcq_Option_Ccntrl.text.isEmpty ||
                                    Mcq_Option_Dcntrl.text.isEmpty ||
                                    Mc_Option_Acntrl.text.isEmpty ||
                                    Mc_Option_Bcntrl.text.isEmpty ||
                                    Mc_Option_Ccntrl.text.isEmpty ||
                                    Mc_Option_Dcntrl.text.isEmpty ||
                                    Mw_Option_Acntrl.text.isEmpty ||
                                    Mw_Option_Bcntrl.text.isEmpty ||
                                    Mw_Option_Ccntrl.text.isEmpty ||
                                    Mw_Option_Dcntrl.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'All field must be filled')));
                                } else if ((1 <=
                                            int.parse(
                                                Mcq_CorrectAnswercntrl.text) &&
                                        int.parse(
                                                Mcq_CorrectAnswercntrl.text) <=
                                            3) ==
                                    false) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'OptionAnswer must be between 1 and 3')));
                                } else if ((1 <=
                                            int.parse(
                                                Mc_CorrectAnswercntrl.text) &&
                                        int.parse(Mc_CorrectAnswercntrl.text) <=
                                            3) ==
                                    false) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'OptionAnswer must be between 1 and 3')));
                                } else if ((1 <=
                                            int.parse(
                                                Mw_CorrectAnswercntrl.text) &&
                                        int.parse(Mw_CorrectAnswercntrl.text) <=
                                            3) ==
                                    false) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'OptionAnswer must be between 1 and 3')));
                                } else {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => WillPopScope(
                                            onWillPop: () =>
                                                Future.value(false),
                                            child: Center(
                                              child:
                                                  CupertinoActivityIndicator(),
                                            ),
                                          ));
                                  await _firebaseFirestore
                                      .collection('Quizs')
                                      .doc(tablel)
                                      .collection(type)
                                      .doc(wordcntrl.text)
                                      .set({
                                    'word': wordcntrl.text,
                                    'origin': origincntrl.text,
                                    'defination': definationcntrl.text,
                                    'pronunciation': pronunciationcntrl.text,
                                    'part_of_speech': part_of_speechcntrl.text,
                                    'sentence': sentencecntrl.text,
                                    'Mcq Question': Mcq_Questioncntrl.text,
                                    'Mcq Option_A': Mcq_Option_Acntrl.text,
                                    'Mcq Option_B': Mcq_Option_Bcntrl.text,
                                    'Mcq Option_C': Mcq_Option_Ccntrl.text,
                                    'Mcq Option_D': Mcq_Option_Dcntrl.text,
                                    'Mcq CorrectAnswer':
                                        Mcq_CorrectAnswercntrl.text,
                                    'Mw Option A': Mw_Option_Acntrl.text,
                                    'Mw Option B': Mw_Option_Bcntrl.text,
                                    'Mw Option C': Mw_Option_Ccntrl.text,
                                    'Mw Option D': Mw_Option_Dcntrl.text,
                                    'Mw CorrectAnswer':
                                        Mw_CorrectAnswercntrl.text,
                                    'Mc Option A': Mc_Option_Acntrl.text,
                                    'Mc Option B': Mc_Option_Bcntrl.text,
                                    'Mc Option C': Mc_Option_Ccntrl.text,
                                    'Mc Option D': Mc_Option_Dcntrl.text,
                                    'Mc CorrectAnswer':
                                        Mc_CorrectAnswercntrl.text,
                                  }).then((value) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    setState(() {});
                                  });
                                }
                              },
                              child: Text('Add this word')),
                          SizedBox(
                            height: 60,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
