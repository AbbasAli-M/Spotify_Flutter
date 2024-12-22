import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_flutter/common/helpers/is_dark_mode.dart';
import 'package:spotify_flutter/core/config/assets/app_images.dart';
import 'package:spotify_flutter/core/config/theme/app_colors.dart';
import 'package:spotify_flutter/presentation/home/widgets/news_songs.dart';
import 'package:spotify_flutter/presentation/home/widgets/play_list.dart';
import 'package:spotify_flutter/presentation/profile/pages/profile.dart';

import '../../../common/widgets/appbar/appbar.dart';
import '../../../core/config/assets/app_vectors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        hideBack: true,
        action: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> const ProfilePage()));
          },
          icon: const Icon(Icons.person),
        ),
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _homeArtistCard(),
          _tabs(),
          SizedBox(
            height: 260,
            child: TabBarView(
              controller: _tabController,
              children: [
                const NewsSongs(),
                Container(),
                Container(),
                Container(),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const PlayList()
        ],
      )),
    );
  }

  Widget _homeArtistCard() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Container(
          height: 188,
          child: Stack(children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(AppVectors.homeArtistCard)),
            Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(AppImages.homeArtist)),
          ]),
        ),
      ),
    );
  }

  Widget _tabs() {
    return TabBar(
        controller: _tabController,
        labelColor: context.isDarkMode ? Colors.white : Colors.black,
        isScrollable: true,
        indicatorColor: AppColors.primary,
        padding: const EdgeInsets.only(left: 0, right: 20, top: 40, bottom: 20),
        tabs: const [
          Text(
            "News",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Text(
            "Videos",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Text(
            "Artist",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Text(
            "Podcasts",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          )
        ]);
  }
}
