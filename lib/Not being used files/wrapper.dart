// THIS FILE IS CURRENTLY NOT BEING USED ANYWHERE

import 'package:first_proj/pages/HomePageTabs.dart';
import 'package:first_proj/pages/authenticate.dart';
import 'package:first_proj/util/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return HomePageTabs();
    }
  }
}