// ignore_for_file: library_private_types_in_public_api

import 'package:blog/core/themes/color.dart';
import 'package:blog/core/themes/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ReadMoreText extends StatefulWidget {
  final String text;
  final int initialCharacterLimit;

  const ReadMoreText({
    super.key,
    required this.text,
    this.initialCharacterLimit = 100,
  });

  @override
  _ReadMoreTextState createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  late String firstPart;
  late String remainingPart;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > widget.initialCharacterLimit) {
      firstPart =
          "${widget.text.substring(0, widget.initialCharacterLimit)}...";
      remainingPart = widget.text.substring(widget.initialCharacterLimit);
    } else {
      firstPart = widget.text;
      remainingPart = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MarkdownBody(
          data: isExpanded ? widget.text : firstPart,
          selectable: false,
          softLineBreak: true,
          styleSheet: MarkdownStyleSheet(
            p: AppTextStyle.robotoregular
                .copyWith(fontSize: 16, color: Colors.black87),
            h1: AppTextStyle.robotoregular
                .copyWith(fontSize: 24, color: Colors.black87),
            h2: AppTextStyle.robotoregular
                .copyWith(fontSize: 22, color: Colors.black87),
            h3: AppTextStyle.robotoregular
                .copyWith(fontSize: 20, color: Colors.black87),
            h4: AppTextStyle.robotoregular
                .copyWith(fontSize: 18, color: Colors.black87),
            h5: AppTextStyle.robotoregular
                .copyWith(fontSize: 16, color: Colors.black87),
            h6: AppTextStyle.robotoregular
                .copyWith(fontSize: 14, color: Colors.black87),
            // code: TextStyle(
            //     color: Colors.purple, fontFamily: 'Courier', fontSize: 14),
            codeblockPadding: const EdgeInsets.all(8),
            codeblockDecoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        if (!isExpanded && remainingPart.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: InkWell(
              onTap: () {
                setState(() {
                  isExpanded = true;
                });
              },
              child: Text(
                "Read more",
                style: AppTextStyle.robotoregular.copyWith(
                  fontSize: 16,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
