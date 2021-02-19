import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  DrawerTile(this.icon, this.text, this.controller, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          controller.jumpToPage(page);
          Navigator.of(context).pop();
        },
        child: Container(
          height: 60,
          child: Row(
            children: [
              Icon(icon,
                  size: 30,
                  color: controller.page.round() == page
                      ? Theme.of(context).primaryColor
                      : Colors.grey[700]),
              SizedBox(width: 32),
              Text(
                text,
                style: TextStyle(
                    fontSize: 16,
                    color: controller.page.round() == page
                        ? Theme.of(context).primaryColor
                        : Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}