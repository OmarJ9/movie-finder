import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_finder/src/utils/services/database_service.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/app_route.dart';
import '../../../../data/core/api_constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';

class FavoriteCard extends StatelessWidget {
  final String img, title, overview;
  final int id;
  const FavoriteCard(
      {required this.img,
      required this.title,
      required this.overview,
      required this.id,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 10,
      margin: EdgeInsets.symmetric(
        vertical: 1.h,
        horizontal: 3.w,
      ),
      child: AspectRatio(
        aspectRatio: 2.8 / 1.6,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: '${ApiConstants.baseImageUrl}$img',
              imageBuilder: (context, imageProvider) {
                return Container(
                  width: 30.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      )),
                );
              },
              placeholder: (context, url) {
                return Container(
                  width: 30.w,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      )),
                );
              },
              errorWidget: (context, url, error) {
                return Container(
                    width: 30.w,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        )),
                    child: const Icon(FontAwesomeIcons.circleExclamation));
              },
            ),
            SizedBox(
              width: 4.w,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 10, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: title,
                      maxlines: 1,
                      textalign: TextAlign.left,
                      size: 10,
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Expanded(
                      child: RichText(
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: 'Overview : ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Colors.amber,
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w900,
                                  ),
                              children: [
                                TextSpan(
                                    text: overview,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontSize: 8.sp,
                                        ))
                              ])),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 3.h,
                          width: 21.w,
                          child: CustomButton(
                            func: () {
                              context.push(AppRoute.details, extra: id);
                            },
                            title: '+ Details',
                            fontsize: 8,
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        SizedBox(
                          height: 3.h,
                          width: 21.w,
                          child: CustomButton(
                            color: Colors.red,
                            func: () {
                              DataBaseService().deleteMovie(id);
                            },
                            title: 'Remove',
                            fontsize: 8,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
