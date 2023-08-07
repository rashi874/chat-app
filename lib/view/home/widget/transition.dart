import 'package:flutter/material.dart';

class SlideTransitionExample extends PageRouteBuilder {
  final Widget page;

  SlideTransitionExample({required this.page})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return page;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            const Offset begin = Offset(1.0, 0.0);
            const Offset end = Offset.zero;

            Animation<Offset> slideAnimation = Tween<Offset>(
              begin: begin,
              end: end,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves
                    .fastOutSlowIn, // Use FastOutSlowInCurve for smoother animation
              ),
            );

            return SlideTransition(
              position: slideAnimation,
              child: child,
            );
          },
        );
}
