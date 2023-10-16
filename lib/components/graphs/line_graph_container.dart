import 'package:flutter/material.dart';

import '../texts/text_widgets.dart';

class LineGraphContainer extends StatelessWidget {
  const LineGraphContainer({Key? key, required this.child, required this.title})
      : super(key: key);

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: SizedBox(
        height: size.height < 500 ? size.height * 0.4 : size.height * 0.3,
        width: size.width * 0.5,
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: size.height < 500
                        ? size.height * 0.4
                        : size.height * 0.3,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(232, 232, 232, 1),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0, 6),
                          blurRadius: 4,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),

                    /// This is where table goes
                    child: child,
                  ),
                ),
              ),
              Positioned(
                top: -15,
                left: 0,
                child: Container(
                  width: 150,
                  height: 20,
                  decoration: BoxDecoration(
                    color: const Color(0xFF7E95BC),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: HeadlineText(
                        title,
                        color: Colors.white,
                        fontSizeVariant: FontSizeVariant.small,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
