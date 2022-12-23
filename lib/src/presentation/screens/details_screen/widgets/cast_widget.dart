import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../../blocs/movie_cast/movie_cast_bloc.dart';
import '../../../../constants/assets_constants.dart';
import '../../../../data/core/api_constants.dart';
import '../../../widgets/custom_text.dart';

class CastWidget extends StatelessWidget {
  const CastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCastBloc, MovieCastState>(
      builder: (context, state) {
        if (state is MovieCastSuccess) {
          return SizedBox(
            height: 25.h,
            child: ListView.builder(
              itemCount: state.cast.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(vertical: 15),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: AspectRatio(
                    aspectRatio: 2 / 3,
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: FadeInImage.memoryNetwork(
                              placeholderErrorBuilder:
                                  (context, error, stackTrace) {
                                return Image.asset(AssetsConstants.placeholder,
                                    fit: BoxFit.cover);
                              },
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  AssetsConstants.placeholder,
                                  fit: BoxFit.cover,
                                );
                              },
                              placeholder: kTransparentImage,
                              image:
                                  '${ApiConstants.baseImageUrl}${state.cast[index].img}',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomText(
                          title: state.cast[index].name,
                          size: 8,
                        )
                      ],
                    ),
                  ),
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
