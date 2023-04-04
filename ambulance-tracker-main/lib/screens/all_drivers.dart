import 'dart:convert';
import 'dart:developer';

import 'package:ambulance_tracker/models/user.dart';
import 'package:ambulance_tracker/services/apis.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'new_driver_page.dart';
import 'package:ambulance_tracker/services/drivers.dart';

class ShowDrivers extends StatefulWidget {
  const ShowDrivers({Key? key}) : super(key: key);

  @override
  _ShowDriversState createState() => _ShowDriversState();
}

class _ShowDriversState extends State<ShowDrivers> {
  List<Users> _list = [];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("All drivers"),
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          bottom: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.location_on),
            ),
            Tab(
              text: "Available",
            ),
            Tab(text: "Working"),
            Tab(text: "Offline"),
          ]),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.person_add_alt_1,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewDriversCode()),
                    )),
          ],
        ),
        body: TabBarView(children: [
          Column(),
          SingleChildScrollView(
            child: StreamBuilder(
              stream: apis.getallavailableusers(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                final data = snapshot.data?.docs;
                _list =
                    data?.map((e) => Users.fromJson(e.data())).toList() ?? [];
                return ListView.builder(
                    itemCount: _list.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return driverCard(
                          _list[index].name,
                          Color.fromRGBO(250, 152, 152, 1),
                          "Available",
                          _list[index].regId);
                    });
              },
            ),
          ),
          SingleChildScrollView(
            child: StreamBuilder(
              stream: apis.getworkingusers(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                final data = snapshot.data?.docs;
                _list =
                    data?.map((e) => Users.fromJson(e.data())).toList() ?? [];

                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _list.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return driverCard(
                          _list[index].name,
                          Color.fromRGBO(250, 152, 152, 1),
                          "Available",
                          _list[index].regId);
                    });
              },
            ),
          ),
          SingleChildScrollView(
            child: StreamBuilder(
              stream: apis.getofflineusers(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                final data = snapshot.data?.docs;
                _list =
                    data?.map((e) => Users.fromJson(e.data())).toList() ?? [];

                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _list.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return driverCard(
                          _list[index].name,
                          Color.fromRGBO(250, 152, 152, 1),
                          "Busy",
                          _list[index].regId);
                    });
              },
            ),
          ),
        ]),
      ),
    );
  }

  Widget driverCard(String name, Color col, String status, String regId) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
          width: MediaQuery.of(context).size.width - 50,
          height: MediaQuery.of(context).size.height / 6,
          child: Card(
            child: Column(children: [
              Row(
                children: [
                  // Image.network(
                  //  "https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/1024px-User-avatar.svg.png")
                ],
              ),
              Text(name),
              Text(regId),
              Text(status)
            ]),
            color: col,
          )),
    );
  }

  // sortDrivers() {
  //   List<List<Widget>> lst = [];
  //   List<Users> _list = [];

  //   List<Widget> available = [];
  //   List<Widget> offline = [];
  //   List<Widget> working = [];

  //   StreamBuilder(
  //     stream: apis.getallusers(),
  //     builder: (context,
  //         AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
  //       final data = snapshot.data?.docs;
  //       _list = data?.map((e) => Users.fromJson(e.data())).toList() ?? [];
  //       for (var e in _list) {
  //         log(' $_list'.toString());
  //         if (e.isFree && !e.isAvailable) {
  //           offline.add(driverCard(e.name, Color.fromRGBO(217, 250, 195, 1),
  //               "Available", e.regId));
  //         } else if (e.isFree) {
  //           available.add(driverCard(e.name, Color.fromRGBO(217, 250, 195, 1),
  //               "Available", e.regId));
  //         } else if (!e.isFree || !e.isAvailable) {
  //           working.add(driverCard(
  //               e.name, Color.fromRGBO(250, 152, 152, 1), "Busy", e.regId));
  //         }
  //         lst.add(available);
  //         lst.add(offline);
  //         lst.add(working);
  //       }
  //       return driverCard(_list[0].name, Color.fromRGBO(250, 152, 152, 1),
  //           "Busy", _list[0].regId);
  //     },
  //   );
  // }
    ff(Stream<QuerySnapshot<Map<String, dynamic>>> callingfun, String status) {
    StreamBuilder(
      stream: callingfun,
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        final data = snapshot.data?.docs;
        _list = data?.map((e) => Users.fromJson(e.data())).toList() ?? [];

        return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _list.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return driverCard(_list[index].name,
                  Color.fromRGBO(250, 152, 152, 1), status, _list[index].regId);
            });
      },
    );
  }
}
