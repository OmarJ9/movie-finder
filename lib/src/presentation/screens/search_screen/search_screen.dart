import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_finder/src/presentation/screens/search_screen/widgets/search_card.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/search_movies/search_movie_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/assets_constants.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_textfield.dart';
import '../screen_layout/screen_layout.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomTextfield(
          hint: 'Search For A Movie ...',
          icon: FontAwesomeIcons.searchengin,
          textEditingController: _controller,
          isSufix: true,
          onsubmit: (query) {
            if (_controller.text.isNotEmpty) {
              context
                  .read<SearchMovieBloc>()
                  .add(SearchForMovieEvent(query: query));
            } else {
              context.read<SearchMovieBloc>().add(const RemoveSearchedEvent());
            }
          },
        ),
        SizedBox(
          height: 2.h,
        ),
        BlocBuilder<SearchMovieBloc, SearchMovieState>(
            builder: (context, state) {
          if (state is SearchLoadingState) {
            return SizedBox(
              height: 80.h,
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.green,
                ),
              ),
            );
          } else if (state is SearchErrorState) {
            return _buildErrorWidget(
                state.message, AssetsConstants.errorlottie);
          } else if (state is SearchSuccessState) {
            if (state.movies.isEmpty) {
              return _buildErrorWidget(
                  'No Movie Found !', AssetsConstants.emptyboxlottie);
            }
            return SizedBox(
              height: 80.h,
              child: ListView.builder(
                itemCount: state.movies.length,
                padding: const EdgeInsets.only(bottom: 30),
                itemBuilder: (context, index) {
                  return SearchCard(
                    id: state.movies[index].id,
                    img: state.movies[index].posterPath,
                    title: state.movies[index].title,
                    overview: state.movies[index].overview,
                    release: state.movies[index].releasedate,
                    vote: state.movies[index].voteAverage,
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        })
      ],
    ));
  }

  SizedBox _buildErrorWidget(String error, lottieanimation) {
    return SizedBox(
      height: 70.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(title: error),
          SizedBox(
            height: 2.h,
          ),
          LottieBuilder.asset(
            lottieanimation,
            height: 50.h,
          ),
        ],
      ),
    );
  }
}
