import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/app_colors.dart';
import '../../../../data/core/api_constants.dart';
import '../../../widgets/custom_text.dart';

class CarouselItem extends StatelessWidget {
  final String avatar;
  final String title;
  final List<int> genre;
  final void Function() onTap;
  final void Function() onTapList;

  const CarouselItem({
    super.key,
    required this.avatar,
    required this.title,
    required this.genre,
    required this.onTap,
    required this.onTapList,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Stack(
        children: <Widget>[
          CachedNetworkImage(
            width: 100.w,
            imageUrl: '${ApiConstants.baseImageUrl}$avatar',
            fit: BoxFit.cover,
          ),
          Container(
            width: 100.w,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.2),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: const [0.04, 0.6])),
          ),
          Positioned(
            bottom: 2.h,
            left: 4.w,
            child: SizedBox(
              width: 80.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: title,
                    size: 16,
                    textalign: TextAlign.left,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  CustomText(
                    headline: false,
                    title: _generateGenre(genre),
                    size: 10,
                    textalign: TextAlign.left,
                    color: Colors.grey.shade100,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 23.w,
                          height: 4.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.green,
                            ),
                            onPressed: onTap,
                            child: const CustomText(
                              size: 8,
                              title: '+ Details',
                              color: Colors.white,
                            ),
                          )),
                      SizedBox(
                        width: 3.w,
                      ),
                      SizedBox(
                        width: 23.w,
                        height: 4.h,
                        child: OutlinedButton(
                          onPressed: onTapList,
                          child: const CustomText(
                            size: 8,
                            title: '+ List',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _generateGenre(List<int> genre) {
    String genrelist = '';
    for (int element in genre) {
      genrelist += _convertGenreIdtoString(element);
    }
    return genrelist;
  }

  String _convertGenreIdtoString(int id) {
    switch (id) {
      case 28:
        return 'Action, ';
      case 12:
        return 'Adventure, ';
      case 16:
        return 'Animation, ';
      case 80:
        return 'Crime, ';
      case 18:
        return 'Drama, ';
      case 99:
        return 'Documentary, ';
      case 9648:
        return 'Mystery, ';
      case 878:
        return 'Science Fiction, ';
      case 35:
        return 'Comedy, ';
      case 10751:
        return 'Family, ';
      case 36:
        return 'History, ';
      case 27:
        return 'Horror, ';
      case 10749:
        return 'Romance, ';
      case 53:
        return 'Thriller, ';
      default:
        return 'Others, ';
    }
  }
}
