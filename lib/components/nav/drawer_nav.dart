import 'package:ahorra_gas/color/color_app.dart';
import 'package:flutter/material.dart';

class DrawerNav extends StatelessWidget {
  const DrawerNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: ColorApp.principalColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 150),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _createDrawerItem(
                icon: Icons.home,
                text: 'Inicio',
                onTap: () {},
              ),
              _createDrawerItem(
                icon: Icons.settings,
                text: 'Configuración',
                onTap: () {},
              ),
              _createDrawerItem(
                icon: Icons.account_circle,
                text: 'Perfil',
                onTap: () {},
              ),
              _createDrawerItem(
                icon: Icons.logout,
                text: 'Cerrar sesión',
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(top: 120),
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "lib/assets/img/logo.png",
                    width: 200,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _createDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: ListTile(
        leading: Icon(icon, color: ColorApp.colorButton, size: 30),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: ColorApp.letterColor,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
