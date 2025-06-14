// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
//
// enum AnimationTrigger {
//   onPageLoad,
//   onActionTrigger,
// }
//
// class AnimationInfo {
//   AnimationInfo({
//     required this.trigger,
//     required this.effects,
//     this.loop = false,
//     this.reverse = false,
//     this.applyInitialState = true,
//   });
//
//   final AnimationTrigger trigger;
//   final List<Effect<dynamic>> effects;
//   final bool applyInitialState;
//   final bool loop;
//   final bool reverse;
//   late Adapter adapter;
//   late AnimationController controller;
// }
//
// void createAnimation(AnimationInfo animation, TickerProvider vsync) {
//   final newController = AnimationController(vsync: vsync);
//   animation.controller = newController;
//   animation.adapter = Adapter()..init(newController);
// }
//
// void setupAnimations(Iterable<AnimationInfo> animations, TickerProvider vsync) {
//   for (var animation in animations) {
//     createAnimation(animation, vsync);
//   }
// }
//
// extension AnimatedWidgetExtension on Widget {
//   Widget animateOnPageLoad(AnimationInfo animationInfo) => Animate(
//       controller:
//           animationInfo.applyInitialState ? null : animationInfo.controller,
//       adapter: animationInfo.applyInitialState ? null : animationInfo.adapter,
//       effects: animationInfo.effects,
//       child: this,
//       onPlay: (controller) => animationInfo.loop
//           ? controller.repeat(reverse: animationInfo.reverse)
//           : null,
//       onComplete: (controller) => !animationInfo.loop && animationInfo.reverse
//           ? controller.reverse()
//           : null);
//
//   Widget animateOnActionTrigger(
//     AnimationInfo animationInfo, {
//     bool hasBeenTriggered = false,
//   }) =>
//       hasBeenTriggered || animationInfo.applyInitialState
//           ? Animate(
//               controller: animationInfo.controller,
//               adapter: animationInfo.adapter,
//               effects: animationInfo.effects,
//               child: this)
//           : this;
// }
//
// class TiltEffect extends Effect<Offset> {
//   const TiltEffect({
//     Duration? delay,
//     Duration? duration,
//     Curve? curve,
//     Offset? begin,
//     Offset? end,
//   }) : super(
//           delay: delay,
//           duration: duration,
//           curve: curve,
//           begin: begin ?? const Offset(0.0, 0.0),
//           end: end ?? const Offset(0.0, 0.0),
//         );
//
//   @override
//   Widget build(
//     BuildContext context,
//     Widget child,
//     AnimationController controller,
//     EffectEntry entry,
//   ) {
//     Animation<Offset> animation = buildAnimation(controller, entry);
//     return getOptimizedBuilder<Offset>(
//       animation: animation,
//       builder: (_, __) => Transform(
//         transform: Matrix4.identity()
//           ..setEntry(3, 2, 0.001)
//           ..rotateX(animation.value.dx)
//           ..rotateY(animation.value.dy),
//         alignment: Alignment.center,
//         child: child,
//       ),
//     );
//   }
// }
