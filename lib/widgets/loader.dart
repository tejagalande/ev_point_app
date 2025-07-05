import 'package:flutter/material.dart';
import 'dart:math';


class CustomCircularLoader extends StatefulWidget {
  @override
  _CustomCircularLoaderState createState() => _CustomCircularLoaderState();
}

class _CustomCircularLoaderState extends State<CustomCircularLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // final List<double> sizes = [24, 20, 18, 16, 14, 12, 10, 8];
  final List<double> sizes = [8, 10, 12, 14, 16, 18, 20];
  final double radius = 30;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Offset _getOffset(double angle, double radius) {
    return Offset(radius * cos(angle), radius * sin(angle));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [Colors.greenAccent, Colors.green],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: Transform.rotate(
                  angle: _controller.value * 2 * pi,
                  child: SizedBox(
                    width: 2 * radius + 22,
                    height: 2 * radius + 22,
                    child: Stack(
                      alignment: Alignment.center,
                      children: List.generate(sizes.length, (index) {
                        double angle = (1.7 * pi / sizes.length) * index;
                        Offset offset = _getOffset(angle, radius);
                        return Positioned(
                          left: radius + offset.dx,
                          top: radius + offset.dy,
                          child: Container(
                            width: sizes[index],
                            height: sizes[index],
                            
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white, // solid base color
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// class _CustomCircularLoaderState extends State<CustomCircularLoader>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   final List<double> sizes = [24, 20, 18, 16, 14, 12, 10, 8];
//   final double radius = 40;

//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//     )..repeat();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Offset _getOffset(double angle, double radius) {
//     return Offset(radius * cos(angle), radius * sin(angle));
//   }

//   @override
//   Widget build(BuildContext context) {
//     double size = 2 * radius + sizes.first;

//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (_, __) {
//         return ShaderMask(
//           shaderCallback: (Rect bounds) {
//             return LinearGradient(
//               colors: [Colors.greenAccent, Colors.green],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ).createShader(bounds);
//           },
//           blendMode: BlendMode.srcIn,
//           child: Transform.rotate(
//             angle: _controller.value * 2 * pi,
//             child: SizedBox(
//               width: size,
//               height: size,
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: List.generate(sizes.length, (index) {
//                   double angle = (2 * pi / sizes.length) * index;
//                   Offset offset = _getOffset(angle, radius);
//                   return Positioned(
//                     left: radius + offset.dx,
//                     top: radius + offset.dy,
//                     child: Container(
//                       width: sizes[index],
//                       height: sizes[index],
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white, // solid base color
//                       ),
//                     ),
//                   );
//                 }),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
