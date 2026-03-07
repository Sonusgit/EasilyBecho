import 'package:easilybecho/core/extensions/size_extension.dart';
import 'package:easilybecho/core/utility/const/app_colors.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              gradient: LinearGradient(
                colors: AppColors.primaryGradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            // curve: Curves.bounceInOut,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30.radius,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 30.fontSp,
                    color: AppColors.primaryColor,
                  ),
                ),
                15.verticalH,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi Sonu 👋",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.fontSp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    4.verticalH,
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14.fontSp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// 🔹 Custom Header
          10.verticalH,

          /// 🔹 Menu Items
          _buildDrawerItem(
            icon: Icons.dashboard,
            title: "Dashboard",
            onTap: () {
              Navigator.pop(context);
            },
          ),

          _buildDrawerItem(
            icon: Icons.shopping_cart,
            title: "Orders",
            onTap: () {
              Navigator.pop(context);
            },
          ),

          _buildDrawerItem(
            icon: Icons.inventory,
            title: "Inventory",
            onTap: () {
              Navigator.pop(context);
            },
          ),

          _buildDrawerItem(
            icon: Icons.settings,
            title: "Settings",
            onTap: () {
              Navigator.pop(context);
            },
          ),

          const Spacer(),

          const Divider(),

          _buildDrawerItem(
            icon: Icons.logout,
            title: "Logout",
            color: Colors.red,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  /// 🔹 Reusable Drawer Tile
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    Color? color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.black87),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: color ?? Colors.black87,
        ),
      ),
      onTap: onTap,
    );
  }
}
