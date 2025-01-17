import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 日付フォーマット用
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore
import 'PostScreen.dart'; // 編集画面用
import 'modal.dart'; // カスタムモーダルダイアログ用
import 'firestore_service.dart'; // Firestoreのサービスクラス

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List<Map<String, dynamic>> _savedItems = []; // テキストと日時を保持するリスト
  final FirestoreService _firestoreService = FirestoreService();
  final String userId = 'hogehoge'; // 固定値、もしくはログインユーザーIDを指定

  @override
  void initState() {
    super.initState();
    print(_savedItems);
    _fetchStocksFromFirestore(); //Firestoreからデータを取得
  }

  List<Stock> _savedItems = [];

  Widget build(BuildContext context) {
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
                        Text(
                          'ストック',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w900, // w700よりさらに太い
                            fontSize: 20,
                            height: 28 / 20, // ラインハイトの調整(28px/20px = 1.4)
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

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
                if (_savedItems.isEmpty) ...[
                  SizedBox(
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
                            child: Text(
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
                  // Container(
                  //   padding: const EdgeInsets.all(0.0), //上部分の余白を設定
                  //   // color: Colors.pink,
                  //   child:
                  // _savedItemsが1つ以上あるときは、その数だけカードを表示
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0.0),
                      shrinkWrap: true,
                      itemCount: _savedItems.length,
                      itemBuilder: (context, index) {
                        final item = _savedItems[index];
                        final text = item.text;
                        final date = item.createdAt;

                        return Container(
                          child: GestureDetector(
                            onTap: () async {
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
                                final String? documentId =
                                    _savedItems[index].id;

                                if (documentId == null) {
                                  print("エラー: ドキュメントIDがnullのため更新できません");
                                  return;
                                }

                                try {
                                  await _firestoreService.updateStock(
                                    userId,
                                    documentId,
                                    updatedItem['text'],
                                    updatedItem['date'],
                                  );
                                  setState(() {
                                    _savedItems[index] = Stock(
                                      id: documentId,
                                      text: updatedItem['text'],
                                      createdAt: updatedItem['date'],
                                    );
                                  });
                                } catch (e) {
                                  print('エラーが発生しました');
                                }
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
                                                            context, index);
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

              if (result != null && result is Map<String, dynamic>) {
                final text = result['text'];
                final createdAt = result['date'] as DateTime;

                // Firestoreにデータを追加
                print("Firestoreにデータを追加します");
                await _addStockToFirestore(text, createdAt);
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

  //削除確認ダイアログのメソッド
  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomModalDialog(
          title: '選択したストックを削除しますか？',
          description: '削除したストックは復元できません。',
          primaryButtonText: '削除',
          primaryButtonAction: () async {
            try {
              final documentId = _savedItems[index].id;
              if (documentId != null) {
                await _firestoreService.deleteStock(userId, documentId);
                setState(() {
                  _savedItems.removeAt(index);
                });
                Navigator.of(context).pop(); // モーダルを閉じる
              } else {
                print('エラー: ドキュメントIDが見つかりません');
              }
            } catch (e) {
              print('エラーが発生しました: $e');
            }
          },

          secondaryButtonText: 'キャンセル',
          secondaryButtonAction: () {
            Navigator.of(context).pop(); // モーダルを閉じる
          },
          isReversed: false, // ボタン配置を逆にする
        );
      },
    );
  }

  Future<void> _fetchStocksFromFirestore() async {
    try {
      final fetchedStocks = await _firestoreService.fetchStocks(userId);
      setState(() {
        _savedItems = fetchedStocks;
      });
      print("Firestoreからデータを取得しました: $_savedItems");
    } catch (e) {
      print('エラーが発生しました: $e');
    }
  }

  Future<void> _addStockToFirestore(String text, DateTime createdAt) async {
    try {
      // Firestoreにデータを追加してIDを取得
      final String documentId =
          await _firestoreService.addStock(userId, text, createdAt);

      // ローカルリストに新しいストックを追加
      setState(() {
        _savedItems.add(
          Stock(
            id: documentId, // 取得したドキュメントIDを設定
            text: text,
            createdAt: createdAt,
          ),
        );
      });

      print("Firestoreにデータを追加し、ローカルリストを更新しました: $documentId");
    } catch (e) {
      print('エラーが発生しました: $e');
    }
  }
}
