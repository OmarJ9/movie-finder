import 'package:flutter/material.dart';
import 'package:movie_finder/src/presentation/screens/home_screen/widgets/shimmer_listview.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: 100.w,
            height: 30.h,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade400,
              child: Container(
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 2.w,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                const ShimmerListView(),
                SizedBox(
                  height: 2.h,
                ),
                const ShimmerListView(),
                SizedBox(
                  height: 2.h,
                ),
                const ShimmerListView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
