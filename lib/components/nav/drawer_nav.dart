import 'package:ahorra_gas/color/color_app.dart';
import 'package:flutter/material.dart';

class DrawerNav extends StatelessWidget {
  final Function(int) onItemSelected;

  const DrawerNav({super.key, required this.onItemSelected});

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
                onTap: () {
                  Navigator.pop(context); // Cierra el Drawer
                  onItemSelected(0); // Cambia al índice 0 (Inicio)
                },
              ),
              _createDrawerItem(
                icon: Icons.settings,
                text: 'Configuración',
                onTap: () {},
                isExperimental: true,
              ),
              _createDrawerItem(
                icon: Icons.account_circle,
                text: 'Perfil',
                onTap: () {},
                isExperimental: true,
              ),
              _createDrawerItem(
                icon: Icons.logout,
                text: 'Cerrar sesión',
                onTap: () {},
                isExperimental: true,
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
    bool isExperimental = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: ListTile(
        leading: Icon(icon, color: ColorApp.colorButton, size: 30),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: ColorApp.letterColor,
              ),
            ),
            if (isExperimental)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Próximamente',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
