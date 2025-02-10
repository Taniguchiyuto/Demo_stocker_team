import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart'; // 必要に応じてインポート
import '../../Model/firestore/firestore_model.dart';

class HomeScreen2 extends ConsumerWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestoreService = ref.read(StocksReposi);

    return Scaffold(
      body: Stack(
        children: [
          // 背景画像
          Container(
            width: double.infinity,
            height: 160,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/stockr_image.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // タイトル
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 66, left: 22),
              child: SizedBox(
                height: 28.0,
                child: Row(
                  children: const [
                    Text(
                      'レポート',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // メイン部分
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 111, left: 9, right: 9),
              child: Container(
                // color: Colors.white,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color(0xFFCAD5D6), // 枠線の色
                    width: 1.0, // 枠線の太さ（1px）
                  ),
                  borderRadius: BorderRadius.circular(8), // 角丸を8pxにする
                ),
                height: 331,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 32,
                      left: 51,
                      right: 51,
                      bottom: 32,
                    ),

                    color: Colors.white, // 外側のContainerの色

                    height: 256,
                    width: 256,
                    child: StreamBuilder<int>(
                      stream: firestoreService.streamstockScore(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return const Text('エラーが発生しました');
                        } else if (!snapshot.hasData) {
                          return const Text('データがありません');
                        } else {
                          final score = snapshot.data!;
                          const maxScore = 300;
                          // 円グラフで利用するため 0.0 ～ 1.0 に正規化
                          final progress = score / maxScore;
                          final clampedProgress =
                              progress > 1.0 ? 1.0 : progress;

                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              // --- 円グラフ（背景） ---
                              SizedBox(
                                width: 400,
                                height: 400,
                                child: CircularProgressIndicator(
                                  // 確定版(Determinate)のために 0.0～1.0 の値を渡す
                                  value: clampedProgress,
                                  strokeWidth: 16,
                                  backgroundColor: Color(0xFFEAEEEF),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    Color(0xFF52C2CD),
                                  ),
                                ),
                              ),
                              // --- テキストを円の上に重ねる ---
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'ストックスコア',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '$score',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 80,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '$score / $maxScore',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
