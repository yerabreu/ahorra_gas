import 'package:ahorra_gas/color/color_app.dart';
import 'package:flutter/material.dart';

class DrawerNav extends StatelessWidget {
  final Function(int) onItemSelected;

  const DrawerNav({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            color: ColorApp.principalColor,
            child: Padding(
              padding: EdgeInsets.only(top: constraints.maxHeight * 0.1), // Ajuste de padding según la altura
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
                    padding: EdgeInsets.only(top: constraints.maxHeight * 0.2), // Ajuste de padding
                    child: Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "lib/assets/img/logo.png",
                        width: constraints.maxWidth * 0.5, // Ajuste proporcional al tamaño de la pantalla
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
      padding: const EdgeInsets.only(bottom: 20), // Ajuste de padding para mayor separación
      child: ListTile(
        leading: Icon(
          icon, 
          color: ColorApp.colorButton, 
          size: 28, // Tamaño más pequeño de los iconos
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // El texto será más dinámico y adaptado al espacio disponible
            Expanded(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis, // Texto largo se recorta con '...'
                style: TextStyle(
                  fontSize: 16, // Ajuste de tamaño de fuente
                  fontWeight: FontWeight.w600,
                  color: ColorApp.letterColor,
                ),
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
