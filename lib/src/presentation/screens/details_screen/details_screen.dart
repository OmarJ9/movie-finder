import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/src/presentation/screens/details_screen/widgets/back_button.dart';
import 'package:movie_finder/src/presentation/screens/details_screen/widgets/cast_widget.dart';
import 'package:movie_finder/src/presentation/screens/details_screen/widgets/custom_flexible_spacebar.dart';
import 'package:movie_finder/src/presentation/screens/details_screen/widgets/screenshot_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/movie_cast/movie_cast_bloc.dart';
import '../../../blocs/movie_details/movie_details_bloc.dart';
import '../../../blocs/movie_images/movie_images_bloc.dart';
import '../../../blocs/movie_video/movie_video_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../widgets/custom_error_widget.dart';
import '../../widgets/custom_text.dart';

class DetailsScreen extends StatefulWidget {
  final int id;
  const DetailsScreen({super.key, required this.id});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    context.read<MovieDetailsBloc>().add(LoadMovieDetails(widget.id));
    context.read<MovieImagesBloc>().add(LoadMovieImages(widget.id));
    context.read<MovieCastBloc>().add(LoadMovieCast(widget.id));
    context.read<MovieVideoBloc>().add(LoadMovieVideo(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, moviestate) {
        if (moviestate is MovieDetailsLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColors.green,
          ));
        } else if (moviestate is MovieDetailsSuccess) {
          return Scaffold(
              body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                leading: const CustomBackButton(),
                flexibleSpace: CustomFlexibleSpaceBar(movie: moviestate.movie),
                expandedHeight: 65.h,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        maxLines: 15,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: 'Overview : ',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.amber,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w900,
                                  ),
                          children: [
                            TextSpan(
                              text: moviestate.movie.overview,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontSize: 10.sp,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      const CustomText(
                        title: 'Cast ',
                        size: 12,
                      ),
                      const CastWidget(),
                      const CustomText(
                        title: 'Screenshots ',
                        size: 12,
                      ),
                      const ScreenshotWidget(),
                      SizedBox(height: 2.h),
                      SizedBox(height: 5.h),
                    ],
                  ),
                ),
              ]))
            ],
          ));
        } else if (moviestate is MovieDetailsError) {
          return CustomErrorWidget(
            error: moviestate.error,
            func: () {
              context.read<MovieDetailsBloc>().add(LoadMovieDetails(widget.id));
              context.read<MovieImagesBloc>().add(LoadMovieImages(widget.id));
              context.read<MovieCastBloc>().add(LoadMovieCast(widget.id));
              context.read<MovieVideoBloc>().add(LoadMovieVideo(widget.id));
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
