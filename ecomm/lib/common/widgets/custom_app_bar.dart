import 'package:ecomm/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? child;
  const CustomAppBar({
    Key? key,
    this.child
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
  
  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _CustomAppBarState extends State<CustomAppBar> {
  
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container( // gambiarra para colocar um gradiente
        decoration: const BoxDecoration(
          gradient: GlobalVariables.appBarGradient
        ),
      ),
      title: widget.child,
    );
  }
}