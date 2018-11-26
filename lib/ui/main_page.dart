import 'package:github_trending/core/core.dart';
import 'package:flutter/material.dart';
import 'package:github_trending/message_provider.dart';
import 'package:github_trending/assets.dart';
import 'package:github_trending/ui/bottom_bar.dart';
import 'package:github_trending/ui/app_bar.dart';
import 'package:github_trending/ui/trending/trending_page.dart';

class MainPage extends StatefulWidget {
  const MainPage();

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Widget _buildTabContent() {
    return Positioned.fill(
      child: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          TrendingPage(TrendingListType.repo),
//          Center(
//            child: Text('2'),
//          )
        ],
      ),
    );
  }

  void _tabSelected(int newIndex) {
    setState(() {
      _selectedTab = newIndex;
      _tabController.index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundImage = Image.asset(
      ImageAssets.backgroundImage,
      fit: BoxFit.cover,
    );

    final content = Scaffold(
      appBar: PreferredSize(
          child: GithubTrendingAppBar(),
          preferredSize: const Size.fromHeight(kToolbarHeight)
      ),
      body: Stack(
        children: [
          _buildTabContent(),
//          _BottomTabs(
//            selectedTab: _selectedTab,
//            onTap: _tabSelected,
//          )
        ],
      ),
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        backgroundImage,
        content,
      ],
    );
  }
}

class _BottomTabs extends StatelessWidget {
  _BottomTabs({
    @required this.selectedTab,
    @required this.onTap,
  });

  final int selectedTab;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final messages = MessageProvider.of(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: GithubTrendingBottomBar(
          currentIndex: selectedTab,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
              title: Text(messages.repo),
              icon: const Icon(Icons.code),
              backgroundColor: Theme.of(context).primaryColor,
            )
//            BottomNavigationBarItem(
//              title: Text(messages.author),
//              icon: const Icon(Icons.account_box),
//              backgroundColor: Theme.of(context).primaryColor,
//            )
          ]
      ),
    );
  }
}