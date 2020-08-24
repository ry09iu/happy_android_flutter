import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  var _list = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
        elevation: 0,
      ),
      body: Center(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _list.add(_list.length + 1);
            });
          },
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${_list[index]}'),
              );
            },
            itemExtent: 50,
            itemCount: _list.length,
          ),
        ),
      ),
    );
  }
}
