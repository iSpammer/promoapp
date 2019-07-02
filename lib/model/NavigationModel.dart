import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NavigationModel {
  String title;
  IconData icon;

  NavigationModel({this.title, this.icon});
}

List<NavigationModel> navigationItems = [
  NavigationModel(title: 'Dashboard', icon: Icons.bubble_chart),
  NavigationModel(title: 'CRUD Promos', icon: Icons.gradient),
  NavigationModel(title: 'Manage Users', icon: Icons.supervised_user_circle),
  NavigationModel(title: 'Account', icon: Icons.account_circle),
  NavigationModel(title: 'Settings', icon: Icons.settings),
  NavigationModel(title: 'Logout', icon: Icons.exit_to_app),
];
