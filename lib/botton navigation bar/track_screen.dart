import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:steko_health_checker/constraints.dart';
import 'profile/details_page.dart';
import 'profile/item.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen({Key key}) : super(key: key);

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  bool loading = false;

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> getData() async {
    loading = true;
    await db.collection("BlogPost").get().then((querySnapshot) => {
          // ignore: avoid_function_literals_in_foreach_calls
          if (querySnapshot.docs.isNotEmpty)
            {
              // ignore: avoid_function_literals_in_foreach_calls
              querySnapshot.docs.forEach((doc) {
                setState(() {
                  _itemList.add(Item(
                      title: doc.data()['title'],
                      imageUrl: doc.data()['imageUrl'],
                      longText: doc.data()['details']));
                });
              }),
              
            },
          loading = false
        });

    
    
    
  }

  final List<Item> _itemList = [];

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(gradient: kGreenGradientColor),
              ),
              title: const Text(
                'Blog',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFF8BBC45),
              elevation: 0,
            ),
            body: _itemList.isEmpty
                ? const Center(child: Text('No Post Found'))
                : Center(
                    child: ListView.builder(
                      itemCount: _itemList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(item: _itemList[index])),
                            );
                          },
                          // child:  Container(margin: const EdgeInsets.all(20), child: Text(_itemList[index].title)));

                          child: GFCard(
                            boxFit: BoxFit.cover,
                            gradient: kGreenGradientColor,
                            titlePosition: GFPosition.start,
                            image: Image.network(_itemList[index].imageUrl),
                            showImage: true,
                            content: _itemList[index].title != null
                                ? Text(
                                    _itemList[index].title,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : const Text(
                                    "No Title",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
          );
  }
}
