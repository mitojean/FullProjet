// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForwardItemWidget extends StatelessWidget {
  final bool isFroward;

  const ForwardItemWidget({
    super.key,
    required this.isFroward,
  });

  @override
  Widget build(BuildContext context) {
    if (!isFroward) return const SizedBox.shrink();
    return const Icon(
      CupertinoIcons.arrow_turn_up_right,
      color: Colors.grey,
      size: 15,
    );
    // return Padding(
    //   padding: const EdgeInsets.only(bottom: 3),
    //   child: Row(
    //     mainAxisSize: MainAxisSize.min,
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: [
    //       const Icon(
    //         Icons.forward,
    //         color: Colors.grey,
    //         size: 18,
    //       ),
    //       const SizedBox(
    //         width: 6,
    //       ),
    //       language.forwarded.cap.color(Colors.grey)
    //     ],
    //   ),
    // );
  }
}
