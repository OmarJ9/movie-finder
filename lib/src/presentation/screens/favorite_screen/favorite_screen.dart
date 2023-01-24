import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_finder/src/constants/assets_constants.dart';
import 'package:movie_finder/src/data/models/favorite_movie_model.dart';
import 'package:movie_finder/src/presentation/screens/favorite_screen/widgets/favorite_card.dart';
import 'package:movie_finder/src/presentation/screens/screen_layout/screen_layout.dart';
import 'package:movie_finder/src/utils/services/database_service.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/custom_text.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
        child: StreamBuilder(
      stream: DataBaseService().moviestream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data as List<FavoriteMocvie>;
          if (data.isEmpty) {
            return SizedBox(
              height: 80.h,
              child: LottieBuilder.asset(
                AssetsConstants.emptyboxlottie,
                height: 50.h,
              ),
            );
          } else {
            return SizedBox(
              height: 80.h,
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  FavoriteMocvie mocvie = data[index];
                  return FavoriteCard(
                      img: mocvie.posterPath,
                      title: mocvie.title,
                      overview: mocvie.overview,
                      id: mocvie.movieID);
                },
              ),
            );
          }
        } else {
          return SizedBox(
            height: 70.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(title: "Something Went Wrong !!"),
                SizedBox(
                  height: 2.h,
                ),
                LottieBuilder.asset(
                  AssetsConstants.errorlottie,
                  height: 50.h,
                ),
              ],
            ),
          );
        }
      },
    ));
  }
}
