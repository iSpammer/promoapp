import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as HTTP;
import 'package:promoapp/styles/theme.dart';

class UpdateDB extends StatefulWidget {
  final List list;
  final int index;

  UpdateDB({@required this.list, @required this.index});

  @override
  _UpdateDBState createState() => _UpdateDBState();
}

class _UpdateDBState extends State<UpdateDB> {
  TextEditingController controllerCode;
  TextEditingController controllerName;
  TextEditingController controllerPrice;
  TextEditingController controllerStock;

  @override
  void initState() {
    controllerCode =
        new TextEditingController(text: widget.list[widget.index]["item_code"]);
    controllerName =
        new TextEditingController(text: widget.list[widget.index]["item_name"]);
    controllerPrice =
        new TextEditingController(text: widget.list[widget.index]["price"]);
    controllerStock =
        new TextEditingController(text: widget.list[widget.index]["stock"]);
    super.initState();
  }

  void updateDB() {
    var url = "http://10.0.2.2/SQL_TEST/update_data.php";
    HTTP.post(
      url,
      body: {
        "id": widget.list[widget.index]['id'],
        "itemcode": controllerCode.text,
        "itemname": controllerName.text,
        "price": controllerPrice.text,
        "stock": controllerStock.text
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDrawerBackgroundColor,
        title: Text("Update Element"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                TextField(
                  controller: controllerCode,
                  decoration: InputDecoration(
                    hintText: "Item Code",
                    labelText: "Item Code",
                  ),
                ),
                TextField(
                  controller: controllerName,
                  decoration: InputDecoration(
                    hintText: "Item Name",
                    labelText: "Item Name",
                  ),
                ),
                TextField(
                  controller: controllerPrice,
                  decoration: InputDecoration(
                    hintText: "Discount Rate",
                    labelText: "Discount Rate",
                  ),
                ),
                TextField(
                  controller: controllerStock,
                  decoration: InputDecoration(
                    hintText: "Stock",
                    labelText: "Stock",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                ),
                RaisedButton(
                  child: Text("UPDATE DB"),
                  color: Colors.green,
                  onPressed: () {
                    updateDB();
                    Navigator.popUntil(context,
                        ModalRoute.withName(Navigator.defaultRouteName));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
