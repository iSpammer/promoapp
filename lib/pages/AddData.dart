import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as HTTP;
import 'package:promoapp/styles/theme.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController controllerCode = new TextEditingController();
  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerPrice = new TextEditingController();
  TextEditingController controllerStock = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDrawerBackgroundColor,
        title: Text("ADD TO DB"),
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
                    hintText: "Price",
                    labelText: "Price",
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
                  child: Text("ADD"),
                  color: Colors.green,
                  onPressed: () {
                    addToDb();
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void addToDb() {
    var url = "http://10.0.2.2/SQL_TEST/add_data.php";
    HTTP.post(url, body: {
      "itemcode": controllerCode.text,
      "itemname": controllerName.text,
      "price": controllerPrice.text,
      "code": controllerStock.text,
    });
  }
}
