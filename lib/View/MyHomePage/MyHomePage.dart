import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 日付フォーマット用
import '../PostScreen/PostScreen.dart'; // 編集画面用
import '../Modal/modal.dart'; // カスタムモーダルダイアログ用
import '../../ViewModel/MyHomePage/MyHomePage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../ViewModel/PostScreen/PostScreen.dart';
import '../../ViewModel/Modal/modal.dart';
import '../../Model/firestore/firestore_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //ViewModelのstateを監視
    final myHomeState = ref.watch(myHomeProvider);
    final viewModel = ref.read(myHomeProvider.notifier);
    final savedItems = myHomeState.savedItems;
    final postScreenViewModel = ref.read(postScreenProvider.notifier);
    final FirestoreService firestoreService = FirestoreService();

    return Scaffold(
        body: Stack(
          children: [
            // 背景画像

            Stack(
              children: [
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
                Positioned(
                  top: 59, // ストックの文字の上部を設定
                  left: 22, // 左に22px分の余白を追加
                  child: Container(
                    height: 28.0,
                    child: Row(
                      children: [
                        //写真(画像を配置)
                        Image.asset(
                          'assets/stockr_icon.png',
                          width: 40.0, //幅を40pxに設定
                          height: 40.0,
                        ),

                        SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          'ストック',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w900, // w700よりさらに太い
                            fontSize: 20,
                            height: 1.4, // ラインハイトの調整(28px/20px = 1.4)
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //ここに底辺に配置するPositionedを追加
              ],
            ),
//中身(リストor空の時のUI)
            Column(
              children: [
                const SizedBox(height: 59), //ストックの文字の上部を設定

                Padding(
                  padding: const EdgeInsets.only(left: 22.0), //左に22px分の余白を追加

                  child: Container(
                    height: 28.0,
                  ),
                ),

                // _savedItemsが空のときは指画像や説明を表示
                if (savedItems.isEmpty) ...[
                  const SizedBox(
                    height: 35.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7.5), //左右の余白を設定
                    child: Container(
                      height: 319, //指定された高さに変更
                      decoration: BoxDecoration(
                        color: Colors.white, //背景色を白に設定
                        borderRadius: BorderRadius.circular(8.0), //角の丸みを設定
                        border: Border.all(
                          color: Color(0xFFEAECEF), //ボーダーの色を設定
                          width: 1, //ボーダーの幅を設定
                        ),
                      ),

                      child: Column(
                        children: [
                          SizedBox(
                            width: 227,
                            height: 227,
                            child: Image.asset(
                              'assets/stockr_finger.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            child: Text(
                              "気づきをストック",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: const Text(
                              "日々の仕事・生活で考えたことや、\n忘れずにおきたいと思った気づきを貯めていきましょう。",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else ...[
                  SizedBox(
                    height: 52.0,
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0.0),
                      shrinkWrap: true,
                      itemCount: savedItems.length,
                      itemBuilder: (context, index) {
                        final item = savedItems[index];
                        final text = item.text;
                        final date = item.createdAt;

                        return Container(
                          child: GestureDetector(
                            onTap: () async {
                              print('text: $text');
                              print('date: $date');
                              print('index :$index');
                              //モーダルを開く前にforceResetDoneをfalseにリセット
                              postScreenViewModel.resetForceResetDone();

                              // 編集画面に遷移（アニメーションを追加）
                              final updatedItem = await showModalBottomSheet<
                                  Map<String, dynamic>>(
                                context: context,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.0)),
                                ),
                                builder: (context) {
                                  return DraggableScrollableSheet(
                                    initialChildSize: 1.0, // 初期表示の高さを全画面に設定
                                    minChildSize: 1.0, // 最小高さを全画面に設定
                                    maxChildSize: 1.0, // 最大高さを全画面に設定
                                    expand: false,
                                    builder: (context, scrollController) {
                                      return SingleChildScrollView(
                                        controller: scrollController,
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .height),
                                          child: PostScreen(
                                            initialText: text, // 現在のテキストを渡す
                                            initialDate: date, // 現在の日付を渡す
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );

                              // 編集結果が返ってきた場合、リストを更新
                              if (updatedItem != null &&
                                  updatedItem is Map<String, dynamic>) {
                                final text = updatedItem['text'];
                                final createdAt = updatedItem['date'];
                                //Firestoreで該当のデータを更新
                                await viewModel.updateStock(
                                    index, text, createdAt);
                                //PostScreenの状態をリセット
                                postScreenViewModel.resetState();
                              } else {
                                //編集画面でキャンセルを押した場合、PostScreenの状態をリセット
                                postScreenViewModel.resetState();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Card(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        // color: Colors.red,
                                        padding: const EdgeInsets.all(2.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // テキスト表示
                                            if (text != null)
                                              Text(
                                                text,
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            Container(
                                                color: Colors.red,
                                                child: const SizedBox(
                                                    height: 10.0)),
                                            // 日付表示 (nullチェック)
                                            if (date != null)
                                              Container(
                                                height: 24,
                                                // color: Colors.blue,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween, //左右に配置
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .end, //下寄せに配置
                                                  children: [
                                                    Text(
                                                      '保存日: ${DateFormat('yyyy-MM-dd HH:mm').format(date)}',
                                                      style: const TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    //黒ぽちボタンを右下に配置

                                                    GestureDetector(
                                                      onTap: () {
                                                        _showDeleteConfirmationDialog(
                                                            context,
                                                            index,
                                                            viewModel,
                                                            ref);
                                                      },
                                                      child: const Icon(
                                                        Icons.more_horiz,
                                                        color: Colors.black,
                                                        size: 20, // アイコンのサイズ
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // ),
                ]
              ],
            ),
            //step4のやつ
            // Positioned(
            //   bottom: 0,
            //   left: 0,
            //   right: 0,
            //   child: Container(
            //     color: Colors.white,
            //     padding: const EdgeInsets.all(16.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         // 左側のボタン
            //         Container(
            //           width: 150,
            //           height: 50,
            //           decoration: BoxDecoration(
            //             color: Colors.blue,
            //             borderRadius: BorderRadius.circular(8.0),
            //           ),
            //           child: Center(
            //             child: Text(
            //               'ボタン1',
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 16,
            //               ),
            //             ),
            //           ),
            //         ),
            //         // 右側のボタン
            //         Container(
            //           width: 150,
            //           height: 50,
            //           decoration: BoxDecoration(
            //             color: Colors.green,
            //             borderRadius: BorderRadius.circular(8.0),
            //           ),
            //           child: Center(
            //             child: Text(
            //               'ボタン2',
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 16,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
        floatingActionButton: Container(
          width: 58.69, //幅を58.69に設定
          height: 58.69, //高さを58.69に設定
          decoration: BoxDecoration(
            color: Color(0xFF52C2CD), //背景色を設定
            borderRadius: BorderRadius.circular(29.35), //円形に近い角丸を設定
          ),

          child: FloatingActionButton(
            backgroundColor: Colors.transparent, // 背景を透明に
            elevation: 0, // 影をなくす
            onPressed: () async {
              //モーダルシートを表示
              final result = await showModalBottomSheet<Map<String, dynamic>>(
                context: context,
                isScrollControlled: true, // 全画面に近いモーダル表示を可能にする
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.0)), // 上部を角丸
                ),
                builder: (context) {
                  return DraggableScrollableSheet(
                    initialChildSize: 1.0, // 初期の高さを全画面に設定
                    minChildSize: 1.0, // 最小高さを全画面に設定
                    maxChildSize: 1.0, // 最大高さを全画面に設定
                    expand: false, // 下に引き下げられないようにする
                    builder: (context, scrollController) {
                      return SingleChildScrollView(
                        controller: scrollController,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context)
                                .size
                                .height, // 最大高さを画面サイズに設定
                          ),
                          child: PostScreen(
                            initialText: '', // 編集用の初期テキストを空に設定
                          ),
                        ),
                      );
                    },
                  );
                },
              );
              // モーダルが閉じた後に状態をリセット
              postScreenViewModel.resetState();

              if (result != null && result is Map<String, dynamic>) {
                final text = result['text'];
                final createdAt = result['date'] as DateTime;

                firestoreService.addStock("hogehoge", text, createdAt);
              }
            },
            child: const Icon(
              Icons.add,
              size: 41.92, //アイコンのサイズを設定
              color: Colors.white, //アイコンの色を白に設定
            ),
          ),
        ));
  }
}

//削除確認ダイアログのメソッド
void _showDeleteConfirmationDialog(
  BuildContext context,
  int index,
  MyHomeViewModel viewModel,
  WidgetRef ref,
) {
  final modalViewModel = ref.read(modalProvider.notifier);
  // ViewModelを取得して状態を設定

  modalViewModel.configureDialog(
    title: '選択したストックを削除しますか？',
    description: '削除したストックは復元できません。',
    primaryButtonText: '削除',
    primaryButtonAction: () async {
      await viewModel.deleteStock(index);
      Navigator.of(context).pop(); // モーダルを閉じる
    },
    secondaryButtonText: 'キャンセル',
    secondaryButtonAction: () {
      Navigator.of(context).pop(); // モーダルを閉じる
    },
    isReversed: false, // ボタン配置を逆にしない
  );

  // モーダルを表示
  showDialog(
    context: context,
    builder: (_) => const CustomModalDialog(),
  );
}
