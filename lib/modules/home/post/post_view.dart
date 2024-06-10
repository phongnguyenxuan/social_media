import 'package:blog/common/widget/custom_icons/custom_icons_icons.dart';
import 'package:blog/core/constants/env.dart';
import 'package:blog/core/themes/color.dart';
import 'package:blog/models/post_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PostView extends StatefulWidget {
  final PostModel postData;
  const PostView({super.key, required this.postData});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(width: 2, color: AppColors.postBorderColor),
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // color: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                //avatar
                InkWell(
                  onTap: () {},
                  child: ClipOval(
                    child: Container(
                        width: 40,
                        height: 40,
                        color: AppColors.greyColor2,
                        child: CachedNetworkImage(
                            imageUrl: widget.postData.author?.avatar ??
                                AppKey.DEFAULT_AVATAR)),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                //name
                Text(widget.postData.author?.name ?? ""),
                const Spacer(),
                IconButton(
                  splashRadius: 15,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz_rounded,
                    size: 30,
                    color: AppColors.iconColor,
                  ),
                ),
              ],
            ),
          ),
          Markdown(
            data: widget.postData.content ?? "",
            physics: const NeverScrollableScrollPhysics(),
            softLineBreak: true,
            shrinkWrap: true,
          ),
          bottomWidget()
        ],
      ),
    );
  }

  Container bottomWidget() {
    return Container(
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            splashRadius: 20,
            icon: const Icon(
              CustomIcons.heart_outline,
              color: AppColors.greyColor2,
              size: 20,
            ),
          ),
          IconButton(
            onPressed: () {},
            splashRadius: 20,
            icon: const Icon(
              CustomIcons.comment_dots,
              color: AppColors.greyColor2,
              size: 20,
            ),
          ),
          IconButton(
            onPressed: () {},
            splashRadius: 20,
            icon: const Icon(
              CustomIcons.bookmark,
              color: AppColors.greyColor2,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
