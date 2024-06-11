import 'package:blog/common/widget/custom_icons/custom_icons_icons.dart';
import 'package:blog/common/widget/custom_refresh/custom_refresher.dart';
import 'package:blog/core/constants/env.dart';
import 'package:blog/core/themes/color.dart';
import 'package:blog/core/themes/textstyle.dart';
import 'package:blog/modules/home/home_logic.dart';
import 'package:blog/modules/home/post/post_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widget/app_bar/custom_appbar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final state = Get.find<HomeLogic>().state;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightBackground,
        body: Obx(
          () => CustomSmartRefresher(
            controller: state.refreshController.value,
            enablePullDown: true,
            enablePullUp: true,
            scrollController: state.homeScrollCtrl.value,
            child: CustomScrollView(
              controller: state.homeScrollCtrl.value,
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverAppBar(
                  backgroundColor: AppColors.lightBackground,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  floating: true,
                  snap: true,
                  flexibleSpace: CustomAppBar(type: AppbarType.logo),
                  toolbarHeight: kToolbarHeight + 20,
                ),
                SliverToBoxAdapter(
                  child: addPostHeader(),
                ),
                SliverToBoxAdapter(
                  child: storyWidget(),
                ),
                SliverToBoxAdapter(
                  child: ListView.builder(
                    controller: state.homeScrollCtrl.value,
                    itemCount: state.listNewFeeds.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      return PostView(
                        postData: state.listNewFeeds[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container storyWidget() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                ClipOval(
                  child: Container(
                    width: 60,
                    height: 60,
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(
                  width: 50,
                  child: Text(
                    "user name",
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Container addPostHeader() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          // avatar
          ClipOval(
            child: Container(
              width: 45,
              height: 45,
              decoration: const BoxDecoration(color: AppColors.greyColor2),
              child: CachedNetworkImage(
                imageUrl:
                    state.userLogin.value?.avatar ?? AppKey.DEFAULT_AVATAR,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          // Text input
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.greyColor1),
                ),
                child: Text(
                  "What's on your mind?",
                  style: AppTextStyle.robotoregular.copyWith(
                    fontSize: 16,
                    color: AppColors.darkBackground.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          ),
          // pick image
          IconButton(
            splashRadius: 20,
            onPressed: () {},
            icon: const Icon(
              CustomIcons.add_image,
              color: AppColors.greenColor,
              size: 25,
            ),
          )
        ],
      ),
    );
  }
}
