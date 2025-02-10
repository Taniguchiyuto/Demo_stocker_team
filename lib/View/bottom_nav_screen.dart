import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './MyHomePage/MyHomePage.dart';
import './DashboardScreen/DashboadScreen.dart';
import '../ViewModel/bottom_nav_view_model.dart';

class BottomNavScreen extends ConsumerWidget {
  const BottomNavScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavProvider);
    //各タブに対応する画面のリスト
    final pages = <Widget>[
      const HomeScreen(),
      const HomeScreen2(),
    ];
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: Container(
          // padding: const EdgeInsets.only(bottom: 35.0),
//色を白にしたい
          color: Colors.white,
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              ref.read(bottomNavProvider.notifier).setIndex(index);
            },
            selectedItemColor: Color(0xFF52C2CD),
            selectedLabelStyle:
                const TextStyle(fontFamily: 'Roboto', fontSize: 9),
            unselectedLabelStyle:
                const TextStyle(fontFamily: 'Roboto', fontSize: 9),
            items: [
              BottomNavigationBarItem(
                icon: currentIndex == 0
                    ? SvgPicture.asset(
                        'assets/stockr_home.svg',
                        width: 28,
                        height: 28,
                        color: Color(0xFF52C2CD), // 選択されたアイコンの色
                      )
                    : SvgPicture.asset(
                        'assets/stockr_home.svg',
                        width: 28,
                        height: 28,
                      ),
                label: 'ストック',
              ),
              BottomNavigationBarItem(
                icon: currentIndex == 1
                    ? SvgPicture.asset(
                        'assets/stockr_memo.svg',
                        width: 28,
                        height: 28,
                        color: Color(0xFF52C2CD), // 選択されたアイコンの色
                      )
                    : SvgPicture.asset(
                        'assets/stockr_memo.svg',
                        width: 28,
                        height: 28,
                      ),
                label: 'レポート',
              ),
            ],
          )),
    );
  }
}
