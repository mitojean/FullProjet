// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:v_chat_sdk_core/src/utils/regex.dart';
import 'package:v_chat_sdk_core/src/widgets/auto_direction.dart';

///use this widget to make sure that the text is parsed correctly
class VTextParserWidget extends StatefulWidget {
  final Function(String email)? onEmailPress;
  final Function(String userId)? onMentionPress;
  final Function(String phone)? onPhonePress;
  final Function(String link)? onLinkPress;
  final bool enableTabs;
  final Widget arrowUp;
  final Widget arrowDown;
  final String text;
  final bool isOneLine;
  final TextStyle? textStyle;
  final TextStyle? emailTextStyle;
  final TextStyle? phoneTextStyle;
  final TextStyle? mentionTextStyle;

  const VTextParserWidget({
    super.key,
    this.onEmailPress,
    this.onMentionPress,
    this.onPhonePress,
    this.onLinkPress,
    this.enableTabs = false,
    this.isOneLine = false,
    required this.text,
    this.textStyle,
    this.arrowUp = const Icon(
      Icons.keyboard_arrow_up_rounded,
    ),
    this.arrowDown = const Icon(
      Icons.keyboard_arrow_down,
    ),
    this.emailTextStyle,
    this.phoneTextStyle,
    this.mentionTextStyle,
  });

  @override
  State<VTextParserWidget> createState() => _VTextParserWidgetState();
}

class _VTextParserWidgetState extends State<VTextParserWidget> {
  late String firstHalf;
  late String secondHalf;
  int maxWords = 400;
  bool isShowMoreEnabled = false;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > maxWords) {
      firstHalf = widget.text.substring(0, maxWords);
      secondHalf = widget.text.substring(maxWords, widget.text.length);
      isShowMoreEnabled = true;
    } else {
      firstHalf = widget.text;
      secondHalf = "";
      isShowMoreEnabled = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    const blueTheme = TextStyle(
      // color: Colors.blue,
      decoration: TextDecoration.underline,
      fontWeight: FontWeight.w400,
    );
    if (widget.isOneLine) {
      return _renderText(
        blueTheme: blueTheme,
        maxLine: 1,
        text: firstHalf,
      );
    }
    if (secondHalf.isEmpty) {
      return _renderText(
        blueTheme: blueTheme,
        text: firstHalf,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _renderText(
          blueTheme: blueTheme,
          text: isShowMoreEnabled ? "$firstHalf ..." : widget.text,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isShowMoreEnabled = !isShowMoreEnabled;
            });
          },
          child: isShowMoreEnabled ? widget.arrowDown : widget.arrowUp,
        ),
      ],
    );
  }

  Widget _renderText({
    required TextStyle blueTheme,
    required String text,
    int? maxLine,
  }) {
    return IgnorePointer(
      ignoring: !widget.enableTabs,
      child: AutoDirection(
        text: text,
        child: ParsedText(
          text: text,
          maxLines: maxLine,
          style: widget.textStyle,
          regexOptions: const RegexOptions(multiLine: true, dotAll: true),
          textWidthBasis: TextWidthBasis.longestLine,
          parse: [
            MatchText(
              pattern: r"\[(@[^:]+):([^\]]+)\]",
              style: blueTheme,
              renderText: ({
                required String str,
                required String pattern,
              }) {
                final map = <String, String>{};
                final match = vMentionRegExp.firstMatch(str);
                map['display'] = match!.group(1)!;
                return map;
              },
              onTap: (url) {
                final match = vMentionRegExp.firstMatch(url)!;
                final userId = match.group(2);
                if (widget.onMentionPress != null && userId != null) {
                  widget.onMentionPress!(userId);
                }
              },
            ),
            if (widget.onEmailPress != null)
              MatchText(
                pattern: regexEmail,
                style: blueTheme,
                onTap: (url) {
                  widget.onEmailPress?.call(url);
                },
              ),
            if (widget.onPhonePress != null)
              MatchText(
                type: ParsedType.PHONE,
                style: blueTheme,
                onTap: (url) {
                  widget.onPhonePress!(url);
                },
              ),
            if (widget.onLinkPress != null)
              MatchText(
                pattern: regexLink,
                style: blueTheme,
                onTap: (url) {
                  final protocolIdentifierRegex = RegExp(
                    r'^((http|ftp|https):\/\/)',
                    caseSensitive: false,
                  );
                  if (!url.startsWith(protocolIdentifierRegex)) {
                    url = 'https://$url';
                  }
                  widget.onLinkPress?.call(url);
                },
              ),
          ],
        ),
      ),
    );
  }
}
