import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }

  List<Person> data = Person.all();
}

class _HomePage extends State<HomePage> {
  edit(BuildContext context, Person person) async {
    return showDialog(
        context: context,
        builder: (context) {
          GlobalKey<FormState> _key = GlobalKey<FormState>();
          TextEditingController nameController =
              TextEditingController(text: person.name);
          TextEditingController ageController =
              TextEditingController(text: person.age.toString());
          bool male = person.male;
          return StatefulBuilder(builder: (context, changeState) {
            return AlertDialog(
              actions: [
                TextButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        person.name = nameController.text;
                        person.age = int.parse(ageController.text);
                        person.male = male;
                        Navigator.of(context).pop(person);
                      }
                    },
                    child: const Text("确认")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(person);
                    },
                    child: const Text("取消"))
              ],
              title: const Text('编辑个人信息'),
              content: SizedBox(
                width: 50,
                child: Form(
                  key: _key,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.length == 0) {
                            return "用户名不能为空";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(hintText: "用户名"),
                      ),
                      TextFormField(
                        controller: ageController,
                        validator: (value) {
                          if (null == int.tryParse(value!)) {
                            return "年龄必须是合法的整数";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(hintText: "年龄"),
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: DropdownButton(
                          hint: const Text('性别'),
                          value: male,
                          items: const [
                            DropdownMenuItem<bool>(
                              value: true,
                              child: Text('男'),
                            ),
                            DropdownMenuItem<bool>(
                              value: false,
                              child: Text('女'),
                            )
                          ],
                          onChanged: (bool? value) {
                            if (value != null) {
                              changeState(() {
                                male = value;
                              });
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: 400,
      child: SingleChildScrollView(
        child: DataTable(
          columns: const [
            DataColumn(label: Text("ID")),
            DataColumn(label: Text("名字")),
            DataColumn(label: Text("年龄")),
            DataColumn(label: Text("性别")),
            DataColumn(label: Text("编辑")),
            DataColumn(label: Text("删除"))
          ],
          rows: widget.data
              .map((e) => DataRow(
                      cells: [
                    DataCell(Text(e.id.toString())),
                    DataCell(Text(e.name)),
                    DataCell(Container(
                      width: 100,
                      decoration: e.age > 90
                          ? const BoxDecoration(color: Colors.red)
                          : null,
                      child: Center(child: Text(e.age.toString())),
                    )),
                    DataCell(e.male ? const Text("男性") : const Text("女性")),
                    DataCell(IconButton(
                        onPressed: () async {
                          Person p = await edit(context, e);
                          setState(() {
                            for (var i = 0; i > widget.data.length; i++) {
                              if (widget.data[i].id == p.id) {
                                widget.data[i] = p;
                                break;
                              }
                            }
                          });
                        },
                        icon: const Icon(Icons.edit))),
                    DataCell(IconButton(
                        onPressed: () {
                          setState(() {
                            widget.data = widget.data
                                .where((element) => element.id != e.id)
                                .toList();
                          });
                        },
                        icon: const Icon(Icons.delete)))
                  ].toList()))
              .toList(),
        ),
      ),
    );
  }
}

class Person {
  int id = 0;
  String name = "";
  int age = 0;
  bool male = false;
  Person(
      {required this.id,
      required this.male,
      required this.name,
      required this.age});
  static List<Person> all() {
    List<Person> list = [];
    for (var i = 0; i < 20; i++) {
      var fake = Faker();
      list.add(Person(
          male: random.integer(120) % 2 == 0,
          name: fake.person.name(),
          id: i,
          age: random.integer(120, min: 15)));
    }
    return list;
  }
}
