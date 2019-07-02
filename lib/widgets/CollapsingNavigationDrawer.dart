import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:promoapp/model/NavigationModel.dart';
import 'package:promoapp/styles/theme.dart';
import 'package:promoapp/widgets/CollapsingListTitle.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  @override
  _CollapsingNavigationDrawerState createState() =>
      _CollapsingNavigationDrawerState();
}

class _CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
    with SingleTickerProviderStateMixin {
  bool _isCollapsed = true;
  AnimationController animationController;
  Animation<double> widthAnimation;
  double _minwidth = 70;
  double _maxwidth = 220;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 300),
    );
    widthAnimation = Tween<double>(
      begin: _maxwidth,
      end: _minwidth,
    ).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, widget) => getWidget(context, widget),
    );
  }

  Widget getWidget(context, widget) {
    return Material(
      elevation: 50,
      child: Container(
        width: widthAnimation.value,
        color: kDrawerBackgroundColor,
        child: Column(
          children: <Widget>[
            CollapsingListTitle(
              onTap: () {},
              minwidth: _minwidth,
              maxwidth: _maxwidth,
              title: "Ossama Akram",
              icon: Icons.person,
              animationController: animationController,
            ),
            Divider(
              height: 40,
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, counter) {
                  return Divider(
                    height: 12,
                  );
                },
                itemBuilder: (context, counter) => CollapsingListTitle(
                      onTap: () {
                        setState(() {
//                          selectedIndex = counter;
                        });
                      },
                      isSelected: selectedIndex == counter,
                      minwidth: _minwidth,
                      maxwidth: _maxwidth,
                      title: navigationItems[counter].title,
                      icon: navigationItems[counter].icon,
                      animationController: animationController,
                    ),
                itemCount: navigationItems.length,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _isCollapsed = !_isCollapsed;
                  _isCollapsed
                      ? animationController.forward()
                      : animationController.reverse();
                });
              },
              child: AnimatedIcon(
                icon: AnimatedIcons.close_menu,
                progress: animationController,
                color: Colors.white,
                size: 50.0,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}
