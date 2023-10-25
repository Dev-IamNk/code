import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:model1/pages/admin_panel.dart';
import 'package:model1/pages/admin_signup.dart';
import 'package:model1/pages/home.dart';
import 'package:model1/pages/info.dart';
import 'package:model1/pages/login.dart';
import 'package:model1/pages/signup.dart';
import 'package:model1/routes/name_cons.dart';




class MyPageRoutes{



  GoRouter router =GoRouter(routes: [
    GoRoute(path: "/info/:name",name: MyAppConstants.infoRouteName,
    pageBuilder: (context,state)=>MaterialPage(child: info(clgName: state.pathParameters['name']!,))
    ),
    GoRoute(path: '/',name: MyAppConstants.homeRouteName,
        pageBuilder: (context,state)=>MaterialPage(child: home())
    ),
    GoRoute(path: "/admin_panel",name: MyAppConstants.adminPanelRouteName,
        pageBuilder: (context,state)=>MaterialPage(child: adminpanel())
    ),
    GoRoute(path: "/admin_signup",name: MyAppConstants.adminSignupRouteName,
        pageBuilder: (context,state)=>MaterialPage(child: adminSign())
    ),
    GoRoute(path: "/login",name:MyAppConstants.loginRouteName,
        pageBuilder: (context,state)=>MaterialPage(child: login())
    ),
    GoRoute(path: '/signup',name: MyAppConstants.signupRouteName,
    pageBuilder: (context,state)=>MaterialPage(child: signuup())),

  ]);
}