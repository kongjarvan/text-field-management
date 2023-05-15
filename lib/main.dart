import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final reasonList = ['설비 고장', '팁 교체', '조작 실수'];
  List<String> selectedReason = [];
  final timeList = ['10', '20', '30', '40'];
  List<String> selectedTime = [];

  void addReason() {
    selectedReason.add('설비 고장');
    selectedTime.add('10');
  }

  void deleteReason(int index) {
    List<String> newList1 = [...selectedReason];
    newList1.removeAt(index);
    selectedReason = newList1;
    print(newList1);

    List<String> newList2 = [...selectedTime];
    newList2.removeAt(index);
    selectedTime = newList2;
    print(newList2);
  }

  @override
  void initState() {
    addReason();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: List.generate(
                selectedReason.length,
                    (index) {
                  return buildContent(
                    context,
                    setState,
                    index,
                    index == selectedReason.length - 1 ? 1 : 0,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildContent(BuildContext context, StateSetter setState, int index,
      int isFinal) {
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
                    const SizedBox(width: 10),
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
                child: InkWell(
                  onTap: () {
                    setState(
                          () {
                        deleteReason(index);
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
                    child: const Text('delete'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildDropdown(List<String> dropDownValue,
      List<String> list,
      int index,
      StateSetter setState,) {
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
