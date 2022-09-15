import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 's_model.dart';

final myUserId = FirebaseAuth.instance.currentUser.uid;

class SleepHour extends StatefulWidget {
  const SleepHour({Key key}) : super(key: key);

  @override
  State<SleepHour> createState() => _SleepHourState();
}

class _SleepHourState extends State<SleepHour> {
  Stream<QuerySnapshot<Map<String, dynamic>>> firebase = FirebaseFirestore
      .instance
      .collection("SleepHour")
      .where("userId", isEqualTo: myUserId)
      .orderBy('timestamp', descending: true)
      .snapshots();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: CircularProgressIndicator())
        : StreamBuilder(
            stream: firebase,
            // ignore: missing_return
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.docs.length > 0) {
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        SleepModel bModel =
                            SleepModel.fromJson(snapshot.data.docs[index]);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0),
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columns: <DataColumn>[
                                      DataColumn(
                                        label: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              'Total Sleep',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '(Hr)',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const DataColumn(
                                        label: Text(
                                          'Date',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      const DataColumn(
                                        label: Text(
                                          'Status',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ],
                                    rows: <DataRow>[
                                      DataRow(
                                        cells: <DataCell>[
                                          DataCell(Text(
                                              bModel.sleepHour.toString())),
                                          DataCell(Text(DateFormat.yMEd()
                                              .format(bModel.date.toDate()))),
                                          DataCell(bModel.status.toString() ==
                                                  'Normal'
                                              ? Text(
                                                  bModel.status.toString(),
                                                  style: const TextStyle(
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : Text(
                                                  bModel.status.toString(),
                                                  style: const TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                          ],
                        );
                      });
                } else {
                  return const Center(
                    child: Text('No Records Found'),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            });
  }
}
