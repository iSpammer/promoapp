import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:promoapp/styles/theme.dart';

class CollapsingListTitle extends StatefulWidget {
  final String title;
  final IconData icon;
  final AnimationController animationController;
  final minwidth;
  final maxwidth;
  final bool isSelected = false;
  final Function onTap;

  CollapsingListTitle(
      {@required this.minwidth,
      @required this.maxwidth,
      @required this.title,
      @required this.icon,
      @required this.animationController,
      isSelected,
      @required this.onTap});

  @override
  _CollapsingListTitleState createState() => _CollapsingListTitleState();
}

class _CollapsingListTitleState extends State<CollapsingListTitle> {
  Animation<double> _widthanimation;
  Animation<double> _sbanimation;

  @override
  void initState() {
    _widthanimation =
        Tween<double>(begin: widget.maxwidth, end: widget.minwidth)
            .animate(widget.animationController);
    _sbanimation = Tween<double>(
      begin: 10,
      end: 0,
    ).animate(widget.animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: widget.isSelected
              ? Colors.transparent.withOpacity(0.3)
              : Colors.transparent,
        ),
        width: _widthanimation.value,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          children: <Widget>[
            Icon(
              widget.icon,
              color: widget.isSelected ? kSelectedColor : kColor,
              size: 38.0,
            ),
            SizedBox(
              width: _sbanimation.value,
            ),
            (_widthanimation.value >= 220)
                ? Text(
                    widget.title,
                    style: widget.isSelected
                        ? kListTitleSelectedTextStyle
                        : kListDefaultTextStyle,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
