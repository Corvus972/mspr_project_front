import 'package:flutter/material.dart';
import 'package:mspr_project/search/search.dart';

class HomePage extends StatefulWidget {
  final List<String> list = List.generate(10, (index) => "Text $index");

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search(widget.list));
            },
            icon: Icon(Icons.search),
          )
        ],
        centerTitle: true,
        title: Text(''),
      ),
      body: Center(
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          itemCount: widget.list.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(
              widget.list[index],
            ),
          ),
        ),
      ),
    );
  }
}
