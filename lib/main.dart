import 'package:flutter/material.dart';
import 'PostScreen.dart'; // PostScreenは同じディレクトリに配置されている前提
import 'package:intl/intl.dart'; // 日付フォーマット用

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Header Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> _savedItems = []; // テキストと日時を保持するリスト

  @override
  Widget build(BuildContext context) {
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

            Column(
              children: [
                const SizedBox(height: 59), //ストックの文字の上部を設定

                Padding(
                  padding: const EdgeInsets.only(left: 22.0), //左に22px分の余白を追加

                  child: Container(
                    // color: Colors.white,
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
                            padding: EdgeInsets.all(0.0),
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
                  Container(
                    padding: const EdgeInsets.all(0.0), //上部分の余白を設定
                    // color: Colors.pink,
                    child:
                        // _savedItemsが1つ以上あるときは、その数だけカードを表示
                        ListView.builder(
                      padding: const EdgeInsets.all(0.0),
                      shrinkWrap: true,
                      itemCount: _savedItems.length,
                      itemBuilder: (context, index) {
                        final item = _savedItems[index];
                        final text = item['text'] as String?;
                        final date = item['date'] as DateTime?;

                        return Container(
                          child: GestureDetector(
                            onTap: () async {
                              // 編集画面に遷移（アニメーションを追加）
                              final updatedItem = await Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return PostScreen(
                                      initialText: text, // 現在のテキストを渡す
                                      initialDate: date, // 現在の日付を渡す
                                    );
                                  },
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    // アニメーション: 下から上へのスライド
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0, 1), // 下から上へ開始
                                        end: Offset.zero, // 最終位置
                                      ).animate(animation),
                                      child: child,
                                    );
                                  },
                                ),
                              );

                              // 編集結果が返ってきた場合、リストを更新
                              if (updatedItem != null &&
                                  updatedItem is Map<String, dynamic>) {
                                setState(() {
                                  _savedItems[index] = updatedItem; // リストを更新
                                });
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
                                                        _showCustomDeleteConfirmationDialog(
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
              final result = await Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const PostScreen(); // 遷移先のページを指定
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 1), // 下から上へ開始
                        end: Offset.zero, // 最終位置
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
              );

              if (result != null && result is Map<String, dynamic>) {
                setState(() {
                  // 新しいアイテムをリストに追加
                  _savedItems.add(result);
                });
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
  void _showCustomDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
        context: context,
        barrierColor: Colors.grey[300],
        barrierDismissible: true, //ダイアログ外をタップして閉じる
        builder: (BuildContext context) {
          return Dialog(
              insetPadding:
                  EdgeInsets.symmetric(horizontal: 7.5), //左右の余白を7.5に設定

              child: Container(
                width: MediaQuery.of(context).size.width, //全体から左右7.5pxずつ縮めた幅
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0), //角の丸みを設定
                  color: Colors.white, //背景色を白色に設定
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 32.0,
                    left: 20.0,
                    right: 20.0,
                    bottom: 20.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, //必要な高さだけ確保
                    crossAxisAlignment: CrossAxisAlignment.stretch, //横幅いっぱいに表示
                    children: [
                      //タイトル

                      SizedBox(
                        height: 23.0,
                        child: Text(
                          '選択したストックを削除しますか？',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            // height: 23.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      //説明
                      Text(
                        '削除したストックは復元できません。',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30.0),
                      //ボタン
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //キャンセルボタン
                          Expanded(
                            child: SizedBox(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.grey,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.44),
                                  ),
                                  side: const BorderSide(
                                    color: Color(0xFFA4B6B8), //ボーダーの色
                                    width: 0.93, //ボーダーの太さ
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop(); //モーダルを閉じる
                                },
                                child: const Text('キャンセル',
                                    style: TextStyle(
                                      fontSize: 14.87, //フォントサイズ(必要に応じて調整)
                                      fontFamily:
                                          'Roboto', //フォントファミリーを設定(必要に応じて調整)
                                      fontWeight: FontWeight.bold, //太字に設定
                                    )),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          //削除ボタン
                          Expanded(
                            child: SizedBox(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      const Color(0xFFF87951), //背景色(アクセントカラー)
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(7.44), //角の丸み
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _savedItems.removeAt(index); //アイテムを削除
                                  });
                                  Navigator.of(context).pop(); //モーダルを閉じる
                                },
                                child: const Text('削除',
                                    style: TextStyle(
                                      fontSize: 14.87, //フォントサイズ(必要に応じて調整)
                                      fontFamily:
                                          'Roboto', //フォントファミリーを設定(必要に応じて調整)
                                      fontWeight: FontWeight.bold, //太字に設定
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
