/*
 * Copyright (c) 2022 Simform Solutions
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
import 'package:flutter/material.dart';

class SwipeToReply extends StatefulWidget {
  const SwipeToReply({
    super.key,
    this.onLeftSwipe,
    required this.child,
    this.replyIconColor,
    this.onRightSwipe,
    this.swipeToReplyAnimationDuration,
  });

  /// Provides callback when user swipes chat bubble from right side.
  final VoidCallback? onRightSwipe;

  /// Provides callback when user swipes chat bubble from left side.
  final VoidCallback? onLeftSwipe;

  /// Allow user to set widget which is showed while user swipes chat bubble.
  final Widget child;

  /// Allow user to change colour of reply icon which is showed while user swipes.
  final Color? replyIconColor;

  /// Allow user to set duration of animation of icon.
  final Duration? swipeToReplyAnimationDuration;

  @override
  State<SwipeToReply> createState() => _SwipeToReplyState();
}

class _SwipeToReplyState extends State<SwipeToReply>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _leftScaleAnimation;
  late Animation<double> _rightScaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimationControllers();
  }

  void _initializeAnimationControllers() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.swipeToReplyAnimationDuration ??
          const Duration(milliseconds: 250),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(curve: Curves.decelerate, parent: _controller));
    _leftScaleAnimation = _controller.drive(
      Tween<double>(begin: 0.0, end: 0.0),
    );
    _rightScaleAnimation = _controller.drive(
      Tween<double>(begin: 0.0, end: 0.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            fit: StackFit.passthrough,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Visibility(
                    visible: widget.onRightSwipe != null,
                    child: ReplyIcon(
                      scaleAnimation: _leftScaleAnimation,
                      slideAnimation: _slideAnimation,
                      replyIconColor: widget.replyIconColor,
                    ),
                  ),
                  Visibility(
                    visible: widget.onLeftSwipe != null,
                    child: ReplyIcon(
                      scaleAnimation: _rightScaleAnimation,
                      slideAnimation: _slideAnimation,
                      replyIconColor: widget.replyIconColor,
                    ),
                  ),
                ],
              ),
              SlideTransition(
                position: _slideAnimation,
                child: widget.child,
              ),
            ],
          );
        },
      ),
    );
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (widget.onRightSwipe != null && details.delta.dx > 1) {
      _runAnimation(onRight: true);
    }
    if (widget.onLeftSwipe != null && details.delta.dx < -1) {
      _runAnimation(onRight: false);
    }
  }

  void _runAnimation({required bool onRight}) {
    _slideAnimation = Tween(
      begin: const Offset(0.0, 0.0),
      end: Offset(onRight ? 0.1 : -0.1, 0.0),
    ).animate(CurvedAnimation(curve: Curves.decelerate, parent: _controller));
    if (onRight) {
      _leftScaleAnimation = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(curve: Curves.decelerate, parent: _controller));
    } else {
      _rightScaleAnimation = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(curve: Curves.decelerate, parent: _controller));
    }
    _controller.forward().whenComplete(() {
      _controller.reverse().whenComplete(() {
        if (onRight) {
          _leftScaleAnimation = _controller.drive(Tween(begin: 0.0, end: 0.0));
          if (widget.onRightSwipe != null) widget.onRightSwipe!();
        } else {
          _rightScaleAnimation = _controller.drive(Tween(begin: 0.0, end: 0.0));
          if (widget.onLeftSwipe != null) widget.onLeftSwipe!();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ReplyIcon extends StatelessWidget {
  const ReplyIcon({
    super.key,
    required this.scaleAnimation,
    required this.slideAnimation,
    this.replyIconColor,
  });

  /// Represents scale animation value of icon when user swipes for reply.
  final Animation<double> scaleAnimation;

  /// Represents slide animation value of chat bubble when user swipes for reply.
  final Animation<Offset> slideAnimation;

  /// Allow user to set color of icon which is appeared when user swipes for reply.
  final Color? replyIconColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Transform.scale(
        //   scale: scaleAnimation.value,
        //   child: CircleAvatar(
        //     radius: 14,
        //     backgroundColor:
        //     scaleAnimation.value == 1.0 ? Colors.grey : Colors.transparent,
        //     child: const Icon(
        //       Icons.reply_rounded,
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            value: scaleAnimation.value,
            backgroundColor: Colors.transparent,
            strokeWidth: 1.5,
          ),
        ),
      ],
    );
  }
}
