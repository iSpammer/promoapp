import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as HTTP;
import 'package:promoapp/styles/theme.dart';

import 'UpdateDB.dart';

class Detail extends StatefulWidget {
  List list;
  int index;

  Detail({@required this.index, @required this.list});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: kDrawerBackgroundColor,
        title: Text("${widget.list[widget.index]['item_name']}"),
      ),
      body: Container(
        height: 250.0,
        padding: EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Text(
                  "${widget.list[widget.index]['item_name']}",
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  "Code: ${widget.list[widget.index]['item_code']}",
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  "Discount: ${widget.list[widget.index]['price']} %",
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  "Stock: ${widget.list[widget.index]['stock']}",
                  style: TextStyle(fontSize: 20.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RaisedButton(
                      child: Text(
                        "UPDATE",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () => Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (
                                BuildContext context,
                              ) =>
                                  UpdateDB(
                                    list: widget.list,
                                    index: widget.index,
                                  ),
                            ),
                          ),
                    ),
                    RaisedButton(
                      child: Text(
                        "DELETE",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () => confirm(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content:
          Text("Confirm deletion of ${widget.list[widget.index]['item_name']}"),
      actions: <Widget>[
        RaisedButton(
          child: Text(
            "CANCEL",
            style: TextStyle(color: Colors.green),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        RaisedButton(
          child: Text(
            "DELETE",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            deleteData();
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ],
    );
    showDialog(context: context, child: alertDialog);
  }

  void deleteData() {
    var url = "http://10.0.2.2/SQL_TEST/delete_data.php";
    HTTP.post(
      url,
      body: {
        "id": widget.list[widget.index]['id'],
      },
    );
  }
}
