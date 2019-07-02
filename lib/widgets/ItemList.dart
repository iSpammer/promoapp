import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:promoapp/pages/Detail.dart';

class ItemList extends StatelessWidget {
  final List list;

  ItemList({@required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (BuildContext context) => new Detail(
                            index: i,
                            list: list,
                          ),
                    ),
                  ),
              child: Card(
                child: new ListTile(
                  title: Text("${list[i]['item_name']}"),
                  leading: Icon(Icons.widgets),
                  subtitle: Text("Stock: ${list[i]['stock']}"),
                ),
              ),
            ),
          );
        });
  }
}
