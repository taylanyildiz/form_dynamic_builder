import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/core/widgets/widgets.dart';

class FormAppBar extends StatelessWidget {
  const FormAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 200,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: BlurCard(
          color: Colors.transparent,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ),
            ),
          ),
        ),
        title: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 150.0,
              child: SvgPicture.asset(

                // fit: BoxFit.cover,
                "assets/svgs/videntium_logo.svg",
              ),
            ),
            const Positioned(
              right: 150.0,
              child: Text(
                "Form Builder",
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
