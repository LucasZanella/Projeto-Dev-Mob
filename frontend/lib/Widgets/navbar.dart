import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final List<IconData?> icons;
  final List<VoidCallback> actions;
  final List<Color> colors;

  const NavBar({
    super.key,
    required this.icons,
    required this.actions,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.all(20),
      height: size.width * .155,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 19, 18, 18),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: const Color(0xFF2E2E2E), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 56, 56, 56).withValues(alpha: .25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Row(
        children: [
          /// LEFT
          Expanded(
            child: icons.isNotEmpty && icons[0] != null
                ? InkWell(
                    onTap: actions[0],
                    child: Icon(
                      icons[0]!,
                      size: size.width * .08,
                      color: colors[0],
                    ),
                  )
                : const SizedBox(),
          ),

          /// CENTER
          Expanded(
            child: icons.length > 1 && icons[1] != null
                ? InkWell(
                    onTap: actions[1],
                    child: Icon(
                      icons[1]!,
                      size: size.width * .08,
                      color: colors[1],
                    ),
                  )
                : const SizedBox(),
          ),

          /// RIGHT
          Expanded(
            child: icons.length > 2 && icons[2] != null
                ? InkWell(
                    onTap: actions[2],
                    child: Icon(
                      icons[2]!,
                      size: size.width * .08,
                      color: colors[2],
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
