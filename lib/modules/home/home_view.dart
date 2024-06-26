import 'package:blog/common/widget/custom_icons/custom_icons_icons.dart';
import 'package:blog/common/widget/custom_refresh/custom_refresher.dart';
import 'package:blog/common/widget/shimmer/shimmer_widget.dart';
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

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  final logic = Get.find<HomeLogic>();
  final state = Get.find<HomeLogic>().state;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightBackground,
        body: Obx(
          () => CustomSmartRefresher(
            controller: state.refreshController.value,
            enablePullDown: true,
            enablePullUp: true,
            scrollController: state.homeScrollCtrl.value,
            onLoading: logic.loadMore,
            onRefresh: () => logic.pullToRefresh(),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  backgroundColor: AppColors.lightBackground,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  floating: true,
                  snap: true,
                  flexibleSpace: CustomAppBar(
                      onTapLogo: () {
                        if (state.homeScrollCtrl.value.offset != 0.0) {
                          state.homeScrollCtrl.value.animateTo(
                            0.0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn,
                          );
                        } else {
                          logic.pullToRefresh();
                        }
                      },
                      type: AppbarType.logo),
                  toolbarHeight: kToolbarHeight + 20,
                ),
                SliverToBoxAdapter(
                  child: IgnorePointer(
                      ignoring: state.isLoadingData.value,
                      child: addPostHeader()),
                ),
                SliverToBoxAdapter(
                  child: storyWidget(),
                ),
                SliverToBoxAdapter(
                  child: listPostWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listPostWidget() {
    if (state.listNewFeeds.isEmpty) {
      return ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
                border: Border(
              top: BorderSide(width: 2, color: AppColors.postBorderColor),
            )),
            child: const ShimmerWidget(
              type: ShimmerType.POST,
            ),
          );
        },
      );
    }
    return ListView.builder(
      itemCount: state.listNewFeeds.length,
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        return PostView(
          key: ObjectKey(state.listNewFeeds[index].sId),
          postData: state.listNewFeeds[index],
        );
      },
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
                    color: AppColors.greyColor2,
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
      margin: const EdgeInsets.only(top: 10, bottom: 20),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          // avatar
          ShimmerWidget(
            type: ShimmerType.DEFAULT,
            enabled: state.isLoadingData.value,
            child: ClipOval(
              child: Container(
                width: 45,
                height: 45,
                decoration: const BoxDecoration(color: AppColors.greyColor2),
                child: CachedNetworkImage(
                  imageUrl: state.userLogin.value?.avatar ??
                      AppKey.PLACE_HOLDER_IMAGE,
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
          ),
          const SizedBox(
            width: 10,
          ),
          // Text input
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                logic.pushToCreatePost(type: "normal");
              },
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
            onPressed: () {
              logic.pushToCreatePost(type: "image");
            },
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

  @override
  bool get wantKeepAlive => true;
}
