import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final String actors;
  final String posters;
  const DetailPage(
      {super.key,
      required this.title,
      required this.actors,
      required this.posters});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text('Actors'),
            Text(widget.actors),
            const SizedBox(
              height: 20,
            ),
            Container(
                width: 300,
                child: widget.posters == ''
                    ? const Icon(Icons.error)
                    : Image.network(widget.posters)),
            // Text(widget.posters)
          ],
        ),
      ),
    );
  }
}
