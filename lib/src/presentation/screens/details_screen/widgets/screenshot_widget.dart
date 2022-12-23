import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../blocs/movie_images/movie_images_bloc.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/assets_constants.dart';
import '../../../../data/core/api_constants.dart';

class ScreenshotWidget extends StatelessWidget {
  const ScreenshotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieImagesBloc, MovieImagesState>(
      builder: (context, state) {
        if (state is MovieImagesSuccess) {
          return SizedBox(
            height: 25.h,
            child: ListView.builder(
              itemCount: state.images.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(vertical: 15),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: AspectRatio(
                      aspectRatio: 4 / 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage.memoryNetwork(
                          placeholderErrorBuilder:
                              (context, error, stackTrace) {
                            return Image.asset(AssetsConstants.placeholder,
                                fit: BoxFit.cover);
                          },
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade300,
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.circleExclamation,
                                  color: AppColors.deepbleu,
                                  size: 20.sp,
                                ),
                              ),
                            );
                          },
                          placeholder: kTransparentImage,
                          image:
                              '${ApiConstants.baseImageUrl}${state.images[index]['file_path']}',
                          fit: BoxFit.cover,
                        ),
                      )),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
