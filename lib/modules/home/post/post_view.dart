import 'package:blog/common/widget/custom_icons/custom_icons_icons.dart';
import 'package:blog/core/constants/env.dart';
import 'package:blog/core/themes/color.dart';
import 'package:blog/core/themes/textstyle.dart';
import 'package:blog/models/post_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/custom_readmore_text.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostView extends StatefulWidget {
  final PostModel postData;
  const PostView({super.key, required this.postData});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  PostModel postModel = PostModel();

  @override
  void initState() {
    postModel = widget.postData;
    super.initState();
  }

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
                            imageUrl: postModel.author?.avatar ??
                                AppKey.DEFAULT_AVATAR)),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                //name
                RichText(
                  text: TextSpan(
                      text: postModel.author?.name ?? "",
                      style: AppTextStyle.headerStyle.copyWith(
                        fontSize: 15,
                        color: AppColors.darkBackground,
                      ),
                      children: [
                        TextSpan(
                          text: postModel.author?.nickName == null
                              ? ""
                              : " @${postModel.author?.nickName}",
                          style: AppTextStyle.nunito.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: AppColors.iconColor.withOpacity(0.85),
                          ),
                        ),
                        TextSpan(
                          text: "\n${timeago.format(
                            DateTime.parse(postModel.createdAt ?? ""),
                            allowFromNow: true,
                          )}",
                          style: AppTextStyle.header2Style.copyWith(
                              color: AppColors.greyColor2.withOpacity(0.85),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ]),
                ),
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
          ReadMoreText(
            text: postModel.content ?? "",
            initialCharacterLimit: 500,
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
          //LIKE
          Row(
            children: [
              IconButton(
                onPressed: () {},
                splashRadius: 20,
                icon: Icon(
                  postModel.isLiked!
                      ? CustomIcons.heart_soild
                      : CustomIcons.heart_outline,
                  color: postModel.isLiked!
                      ? AppColors.likeColor
                      : AppColors.greyColor2,
                  size: 20,
                ),
              ),
              Text(
                (postModel.likeCount ?? 0).toString(),
                style: AppTextStyle.nunito
                    .copyWith(color: AppColors.iconColor, fontSize: 12),
              )
            ],
          ),
          const SizedBox(
            width: 25,
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
          const SizedBox(
            width: 25,
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
