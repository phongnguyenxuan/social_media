import 'package:blog/core/constants/env.dart';
import 'package:blog/core/themes/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

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
                            imageUrl: AppKey.DEFAULT_AVATAR)),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                //name
                Text("user name"),
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
          )
        ],
      ),
    );
  }
}