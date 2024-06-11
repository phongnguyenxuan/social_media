// ignore_for_file: constant_identifier_names

import 'package:blog/core/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

enum ShimmerType { LIST, DEFAULT, CUSTOM, POST }

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget(
      {super.key,
      this.width,
      this.height,
      this.itemCount,
      required this.type,
      this.child});
  final double? width;
  final double? height;
  final int? itemCount;
  final ShimmerType type;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    // if (type == ShimmerType.LIST) {
    //   return listShimmer();
    // }
    // if (type == ShimmerType.DEFAULT) {
    //   return defaultShimmer();
    // }
    if (type == ShimmerType.POST) {
      return postShimmer();
    }
    return Container();
  }

  // Widget listShimmer() {
  //   return Container(
  //     color: Colors.white,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Padding(
  //                 padding:
  //                     EdgeInsets.only(left: 16, right: 16, bottom: 12),
  //                 child: Shimmer.fromColors(
  //                     baseColor: AppColors.shimmerBaseColor,
  //                     highlightColor: AppColors.shimmerHighlightColor,
  //                     child: Container(
  //                       height: 10,
  //                       width: 100,
  //                       color: Colors.white,
  //                     ))),
  //             SizedBox(
  //               height: height ?? 0.25,
  //               child: ListView.builder(
  //                   physics: const BouncingScrollPhysics(),
  //                   scrollDirection: Axis.horizontal,
  //                   shrinkWrap: true,
  //                   padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //                   itemCount: 5,
  //                   itemBuilder: (BuildContext context, int index) {
  //                     return defaultShimmer();
  //                   }),
  //             ),
  //             SizedBox(
  //               height: 30,
  //             )
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget defaultShimmer() {
  //   return Shimmer.fromColors(
  //     baseColor: AppColors.shimmerBaseColor,
  //     highlightColor: AppColors.shimmerHighlightColor,
  //     child: Container(
  //       width: width ?? 0.44,
  //       height: height,
  //       padding: const EdgeInsets.only(bottom: 12.0),
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(6),
  //           color: AppColors.White,
  //           border: Border.all(color: AppColors.Gray17)),
  //       margin: EdgeInsets.only(right: 8),
  //     ),
  //   );
  // }

  Widget postShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                //avatar
                ClipOval(
                  child: Container(
                    width: 40,
                    height: 40,
                    color: AppColors.greyColor2,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 100,
                      height: 5,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 60,
                      height: 5,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              children: [
                Container(
                  width: 50,
                  height: 10,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 25,
                ),
                Container(
                  width: 50,
                  height: 10,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 25,
                ),
                Container(
                  width: 50,
                  height: 10,
                  color: Colors.white,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
