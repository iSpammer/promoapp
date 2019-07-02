import 'package:flutter/material.dart';
import 'package:promoapp/styles/theme.dart';
import 'package:promoapp/pages/AddData.dart';
import 'package:promoapp/widgets/CollapsingNavigationDrawer.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as HTTP;
import 'package:promoapp/widgets/ItemList.dart';

final duration = const Duration(milliseconds: 300);

class HomePage extends StatefulWidget {
  final username;
  HomePage({@required this.username});
  static String id = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  @override
  GlobalKey _fabKey = GlobalKey();

  bool _fabVisible = true;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
//    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  dispose() {
    super.dispose();
//    routeObserver.unsubscribe(this);
  }

  @override
  didPopNext() {
    // Show back the FAB on transition back ended
    Timer(duration, () {
      setState(() => _fabVisible = true);
    });
  }

  Widget _buildFAB(context, {key}) => FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.pink,
        key: key,
        onPressed: () => _onFabTap(context),
        child: Icon(Icons.search),
      );

  _onFabTap(BuildContext context) {
    // Hide the FAB on transition start
    setState(() => _fabVisible = false);

    final RenderBox fabRenderBox = _fabKey.currentContext.findRenderObject();
    final fabSize = fabRenderBox.size;
    final fabOffset = fabRenderBox.localToGlobal(Offset.zero);

    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: duration,
      pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
          AddData(),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation, Widget child) =>
          _buildTransition(child, animation, fabSize, fabOffset),
    ));
  }

  Widget _buildTransition(
    Widget page,
    Animation<double> animation,
    Size fabSize,
    Offset fabOffset,
  ) {
    if (animation.value == 1) return page;

    final borderTween = BorderRadiusTween(
      begin: BorderRadius.circular(fabSize.width / 2),
      end: BorderRadius.circular(0.0),
    );
    final sizeTween = SizeTween(
      begin: fabSize,
      end: MediaQuery.of(context).size,
    );
    final offsetTween = Tween<Offset>(
      begin: fabOffset,
      end: Offset.zero,
    );

    final easeInAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeIn,
    );
    final easeAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    );

    final radius = borderTween.evaluate(easeInAnimation);
    final offset = offsetTween.evaluate(animation);
    final size = sizeTween.evaluate(easeInAnimation);

    final transitionFab = Opacity(
      opacity: 1 - easeAnimation.value,
      child: _buildFAB(context),
    );

    Widget positionedClippedChild(Widget child) => Positioned(
        width: size.width,
        height: size.height,
        left: offset.dx,
        top: offset.dy,
        child: ClipRRect(
          borderRadius: radius,
          child: child,
        ));

    return Stack(
      children: [
        positionedClippedChild(page),
        positionedClippedChild(transitionFab),
      ],
    );
  }

  Future<List> _getData() async {
    final response = await HTTP.get("http://10.0.2.2/SQL_TEST/read_data.php");
    return json.decode(response.body);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDrawerBackgroundColor,
        centerTitle: true,
        title: const Text('Promo App Admin'),
      ),
      floatingActionButton: Visibility(
        visible: _fabVisible,
        child: _buildFAB(context, key: _fabKey),
      ),
      body: Stack(
        children: <Widget>[
          FutureBuilder<List>(
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? new ItemList(
                      list: snapshot.data,
                    )
                  : new Center(
                      child: CircularProgressIndicator(),
                    );
            },
            future: _getData(),
          ),
          CollapsingNavigationDrawer(),
        ],
      ),
    );
  }
}
