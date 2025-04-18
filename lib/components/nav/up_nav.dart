import 'package:ahorra_gas/color/color_app.dart';
import 'package:flutter/material.dart';

class UpNav extends StatelessWidget implements PreferredSizeWidget {
  const UpNav({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: ColorApp.principalColor,
      foregroundColor: ColorApp.letterColor,
      elevation: 0,
      leading: Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(top: 20.0), 
            child: Align(
              alignment: Alignment.bottomCenter, 
              child: IconButton(
                icon: const Icon(Icons.menu),
                iconSize: 30,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80); 
}