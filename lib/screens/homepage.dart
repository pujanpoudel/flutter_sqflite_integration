import 'package:flutter/material.dart';
import 'package:sqlite_demo/services/database_service.dart';
import 'package:sqlite_demo/widgets/tile_widget.dart';

import '../models/user_model.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final DatabaseService _databaseService = DatabaseService.instance;

  String? _userId = null;
  String? _firstName = null;
  String? _lastName = null;
  String? _age = null;
  String? _gender = null;
  String? _mail = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      floatingActionButton: _addUserButton(),
      body:
          // TileWidget()
          _usersList(),
    );
  }

  Widget _addUserButton() {
    return FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => SingleChildScrollView(
                    child: AlertDialog(
                      title: Text("Add user"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                              onChanged: (value) {
                                setState(() {
                                  _userId = value;
                                });
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "User Id")),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                _firstName = value;
                              });
                            },
                            decoration: InputDecoration(
                                // contentPadding: EdgeInsets.all(20),
                                border: OutlineInputBorder(),
                                hintText: "First Name"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                              onChanged: (value) {
                                setState(() {
                                  _lastName = value;
                                });
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Last Name")),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  _age = value;
                                });
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Age")),
                          SizedBox(
                            height: 5,
                          ),
                          // Radio(
                          //     value: _gender,
                          //     groupValue: null,
                          //     onChanged: (value) {
                          //       setState(() {
                          //         _gender = value;
                          //       });
                          //     }),
                          TextField(
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Gender(Male or Female)")),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                              onChanged: (value) {
                                setState(() {
                                  _mail = value;
                                });
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Mail")),
                          MaterialButton(
                            textTheme: ButtonTextTheme.accent,
                            onPressed: () {
                              try {
                                _databaseService.addUser(_userId!, _firstName!,
                                    _lastName!, _age!, _gender!, _mail!);
                                setState(() {});
                                Navigator.pop(context);
                              } catch (e) {
                                print("object");
                                // TODO
                              }
                            },
                            color: Colors.purple.shade100,
                            child: Text(
                              "Add",
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
        },
        child: const Icon(Icons.add));
  }

  Widget _usersList() {
    return FutureBuilder(
        future: _databaseService.getUser(),
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                User user = snapshot.data![index];
                return ListTile(
                  title: Text(user.firstName),
                );
              });
        });
  }
}
