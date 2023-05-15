import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 3;
  final reasonList = ['설비 고장', '팁 교체', '조작 실수'];
  List<String> selectedReason = [];
  List<String> timeList = ['10', '20', '30', '40'];
  List<String> selectedTime = [];

  addReason() {
    selectedReason.add('설비 고장');
    selectedTime.add('10');
  }

  @override
  void initState() {
    for (int i = 0; i < count; i++) {
      addReason();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Center(
            child: Column(
              children: List.generate(
                count,
                (index) {
                  return buildContent(
                    context,
                    setState,
                    index,
                    index == count - 1 ? 1 : 0,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Padding buildContent(
      BuildContext context, StateSetter setState, int index, int isFinal) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    buildDropdown(selectedReason, reasonList, index, setState),
                    SizedBox(width: 10),
                    buildDropdown(selectedTime, timeList, index, setState),
                  ],
                ),
              ),
            ),
            if (isFinal == 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () {
                    setState(
                      () {
                        addReason();
                        count++;
                      },
                    );
                  },
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    alignment: Alignment.center,
                    child: const Text('add'),
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  alignment: Alignment.center,
                  child: const Text('delete'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildDropdown(
    List<String> dropDownValue,
    List<String> list,
    int index,
    StateSetter setState,
  ) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            value: dropDownValue[index],
            items: list.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                dropDownValue[index] = value as String;
              });
            },
          ),
        ),
      ),
    );
  }
}
