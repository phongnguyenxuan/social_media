import 'package:blog/common/widget/app_bar/custom_appbar.dart';
import 'package:blog/common/widget/custom_button.dart';
import 'package:blog/common/widget/custom_icons/custom_icons_icons.dart';
import 'package:blog/common/widget/multi_image_view/smart_image.dart';
import 'package:blog/common/widget/shimmer/shimmer_widget.dart';
import 'package:blog/core/constants/env.dart';
import 'package:blog/core/themes/color.dart';
import 'package:blog/core/themes/textstyle.dart';
import 'package:blog/modules/home/create_post/create_post_logic.dart';
import 'package:blog/modules/home/create_post/create_post_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widget/multi_image_view/multiple_image_view.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final bool isRegis = Get.isRegistered<CreatePostLogic>();
  late CreatePostLogic logic;
  late CreatePostState state;
  @override
  void initState() {
    super.initState();
    logic = isRegis ? Get.find<CreatePostLogic>() : Get.put(CreatePostLogic());
    state = logic.state;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: appbar(),
      bottomSheet: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.lightBackground,
            border: Border(
                top: BorderSide(color: AppColors.greyColor2.withOpacity(0.3)))),
        child: Row(
          children: [
            iconButton(
              onPressed: () {
                logic.pickImage();
              },
              color: AppColors.greenColor,
              icon: CustomIcons.picture,
            ),
            iconButton(
              onPressed: () {},
              icon: CustomIcons.gif,
              color: Colors.amber,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: state.contentController,
                maxLines: null,
                onChanged: (value) {
                  logic.validatePost(value);
                },
                decoration: InputDecoration(
                    hintText: "What's on your mind?",
                    hintStyle: AppTextStyle.nunito
                        .copyWith(color: AppColors.greyColor1, fontSize: 20),
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => state.imageFiles.isNotEmpty
                  ? Container(
                      height: 400,
                      margin: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: MultipleImageView(
                        type: ImageType.local,
                        files: state.imageFiles,
                      ),
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }

  IconButton iconButton(
      {required void Function()? onPressed,
      required IconData? icon,
      required Color color}) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: color,
      ),
    );
  }

  Container header() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          ClipOval(
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(color: AppColors.greyColor2),
              child: CachedNetworkImage(
                imageUrl: state.userModel.avatar ?? AppKey.PLACE_HOLDER_IMAGE,
                placeholder: (context, url) {
                  return ShimmerWidget(
                    type: ShimmerType.DEFAULT,
                    enabled: true,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          RichText(
              text: TextSpan(
                  text: state.userModel.name,
                  style: AppTextStyle.header2Style.copyWith(
                      fontSize: 15,
                      color: AppColors.darkBackground,
                      fontWeight: FontWeight.w700),
                  children: [
                TextSpan(
                  text: state.userModel.nickName == null
                      ? ""
                      : " @${state.userModel.nickName}",
                  style: AppTextStyle.nunito.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: AppColors.iconColor.withOpacity(0.85),
                  ),
                ),
              ]))
        ],
      ),
    );
  }

  CustomAppBar appbar() {
    return CustomAppBar(
      type: AppbarType.normal,
      centerTitle: false,
      elevation: 1,
      title: Text(
        "Create post",
        style: AppTextStyle.header2Style.copyWith(color: Colors.black),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Obx(() => CustomButton(
                onTap: !state.isValid.value
                    ? null
                    : () {
                        logic.createPost();
                      },
                radius: 20,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                buttonType: ButtonType.full,
                child: Center(
                  child: Text(
                    "POST",
                    style: AppTextStyle.nunito.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )),
        )
      ],
    );
  }
}
