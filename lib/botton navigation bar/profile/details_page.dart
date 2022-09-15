import 'package:flutter/material.dart';

import '../../constraints.dart';
import 'item.dart';

class DetailScreen extends StatelessWidget {
  final Item item;
  const DetailScreen({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: kGreenGradientColor),
        ),
        title: Text(
          item.title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 150, 150, 150),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(children: [
              Image.network(
                item.imageUrl,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                item.longText,
                style: const TextStyle(fontSize: 18, height: 2),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
