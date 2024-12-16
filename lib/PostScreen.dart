import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post Screen Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PostScreen(), // 最初にPostScreenを直接表示
    );
  }
}

class PostScreen extends StatefulWidget {
  final String? initialText; //編集用の初期テキスト
  final DateTime? initialDate; //初期日付
  const PostScreen({
    Key? key,
    this.initialText,
    this.initialDate,
  }) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // キーボード制御用のFocusNode

  bool get _isTextEmpty => _textController.text.isEmpty;

  @override
  void initState() {
    super.initState();
    //'widget.initialText'を使用してコントローラーに初期値を設定
    _textController.text = widget.initialText ?? "";

    // 画面が描画された直後にキーボードを開く処理を追加
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });

    _textController.addListener(() {
      setState(() {}); // 入力変更時に再描画
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose(); // FocusNodeを解放
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //日付フォーマットです
    final formattedDate = widget.initialDate != null
        ? "${widget.initialDate!.year}/${widget.initialDate!.month.toString().padLeft(2, '0')}/${widget.initialDate!.day.toString().padLeft(2, '0')}"
        : "";
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(68), //AppBarの高さを指定
        child: Stack(
          children: [
            AppBar(
              title: const Text(''),
              leading: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, top: 23.0), //// Left: 20px, Top: 23px
                child: SizedBox(
                  width: 24, //幅:24px,
                  height: 24, //高さ24px
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () {
                      if (_isTextEmpty) {
                        Navigator.pop(context);
                      } else {
                        _showDiscardChangesDialog(context);
                      }
                    },
                  ),
                ),
              ),
              actions: [
                //ストックボタン
                Padding(
                  padding: const EdgeInsets.only(
                      right: 20.0, top: 16.0), //右に20pxの余白を追加
                  child: SizedBox(
                    width: 128, //幅を128pxに設定
                    height: 36, //高さを36pxに設定
                    child: TextButton(
                      onPressed: _isTextEmpty
                          ? null
                          : () {
                              final textToSave = _textController.text;
                              final now = DateTime.now(); //現在の日付と時刻を取得
                              FocusScope.of(context).unfocus(); //キーボード閉じる
                              Navigator.pop(context, {
                                'text': textToSave,
                                'date': now,
                              }); //テキストと日付をMapとして前のページに渡す
                            },
                      style: TextButton.styleFrom(
                        backgroundColor: _isTextEmpty
                            ? Colors.grey //textが空の時の色
                            : const Color(
                                0xFF52C2CD), //textが空でない時の色8skin-Cyan/500)
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1000), //角の丸み
                        ),
                      ),
                      child: const Text('ストックする',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16, //フォントサイズを16に設定
                            fontWeight: FontWeight.bold, //フォントの太さを太字に設定
                            fontFamily: 'NotoSansJP', //フォントファミリーを設定(必要に応じて)
                            letterSpacing: 0.5,
                          )

                          //ボタン文字の色を設定
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // キーボードのスペースを考慮
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //日付表示のレイアウト

            const Divider(
              thickness: 1, //棒の太さ
              color: Color(0xFF9E9E9E), // 線の色をグレーに設定
            ),
            //日付がある場合のみ表示
            if (formattedDate.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      " 編集済み・$formattedDate", //日付を表示,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: TextField(
                controller: _textController,
                focusNode: _focusNode, // キーボードのフォーカスを設定
                maxLines: null, // 入力行数を制限なしにする
                minLines: 1, // 最初は1行からスタート
                decoration: const InputDecoration(
                  hintText: '気づいたことを入力しましょう',
                  hintStyle: TextStyle(
                    color: Colors.grey, //ヒントテキストの色をグレーに設定
                  ),
                  border: InputBorder.none, // 枠線を非表示にする
                ),
                style: TextStyle(
                  fontSize: 18, // テキストのサイズを調整
                  color: Colors.black, // テキストの色を調整
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDiscardChangesDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.grey[300], //背景色を#374142に設定
      barrierDismissible: true, //モーダルをタップして閉じることを許可
      builder: (BuildContext context) {
        return Dialog(
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 7.5), //左右の余白を設定

            child: Container(
                width: MediaQuery.of(context).size.width, //幅を設定
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
                        mainAxisSize: MainAxisSize.min, // 必要な高さだけ確保
                        crossAxisAlignment:
                            CrossAxisAlignment.stretch, //横幅いっぱいに広げる
                        children: [
                          //タイトル
                          SizedBox(
                            height: 23.0,
                            child: Text(
                              '変更を破棄しますか？',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            //ボタン
                          ),
                          const SizedBox(height: 30.0),
                          //説明
                          Text(
                            'このまま破棄すると編集した内容が全て失われます',
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
                              //編集を続けるボタン
                              Expanded(
                                child: SizedBox(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: const Color(0xFFF87951),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.44),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop(); // モーダルを閉じる
                                      Navigator.of(context)
                                          .pop(); // HomeScreenに戻る
                                    },
                                    child: const Text(
                                      '破棄する',
                                      style: TextStyle(
                                        fontSize: 14.87,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 16.0),
                              //破棄するボタン
                              Expanded(
                                child: SizedBox(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.grey,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.44),
                                      ),
                                      side: const BorderSide(
                                        color: Color(0xFFA4B6B8),
                                        width: 0.93,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop(); // モーダルを閉じる
                                    },
                                    child: const Text(
                                      '編集を続ける',
                                      style: TextStyle(
                                        fontSize: 14.87,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ]))));
      },
    );
  }
}
