import 'package:flutter/material.dart';
import 'modal.dart';

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
    //日付フォーマット
    final formattedDate = widget.initialDate != null
        ? "${widget.initialDate!.year}/${widget.initialDate!.month.toString().padLeft(2, '0')}/${widget.initialDate!.day.toString().padLeft(2, '0')}"
        : "";
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 52.0, // ステータスバーのスペースを確保
              left: 16.0, // 左の余白
              right: 16.0, // 右の余白
              bottom: 16.0, // ヘッダー下の余白
            ),
            decoration: const BoxDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 左右に要素を配置
              children: [
                // 左側の戻るボタン
                Padding(
                  padding: const EdgeInsets.only(top: 8.0), // トップの余白
                  child: SizedBox(
                    width: 24, // 幅:24px
                    height: 24, // 高さ:24px
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () {
                        if (_isTextEmpty) {
                          Navigator.pop(context);
                        } else {
                          _showDiscardChangesDialog(context); // 変更破棄の確認ダイアログを表示
                        }
                      },
                    ),
                  ),
                ),
                // 右側のストックボタン
                Padding(
                  padding: const EdgeInsets.only(top: 8.0), // トップの余白
                  child: SizedBox(
                    width: 128, // 幅:128px
                    height: 36, // 高さ:36px
                    child: TextButton(
                      onPressed: _isTextEmpty
                          ? null
                          : () {
                              final textToSave = _textController.text;
                              final now = DateTime.now(); // 現在の日付と時刻を取得
                              FocusScope.of(context).unfocus(); // キーボードを閉じる
                              Navigator.pop(context, {
                                'text': textToSave,
                                'date': now,
                              }); // テキストと日付を Map として渡す
                            },
                      style: TextButton.styleFrom(
                        backgroundColor: _isTextEmpty
                            ? Colors.grey // textが空のときの色
                            : const Color(0xFF52C2CD), // textが空でないときの色
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1000), // ボタンの丸み
                        ),
                      ),
                      child: const Text(
                        'ストックする',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16, // フォントサイズを16に設定
                          fontWeight: FontWeight.bold, // 太字
                          fontFamily: 'NotoSansJP', // フォントファミリー（必要に応じて設定）
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
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
                    autofocus: true, //自動的にフォーカスを設定
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
        ],
      ),
    );
  }

  void _showDiscardChangesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomModalDialog(
          title: '変更を破棄しますか？',
          description: 'このまま破棄すると編集した内容が全て失われます。',
          primaryButtonText: '破棄する',
          primaryButtonAction: () {
            Navigator.of(context).pop(); // モーダルを閉じる
            Navigator.of(context).pop(); // 編集画面を閉じる
          },
          secondaryButtonText: '編集を続ける',
          secondaryButtonAction: () {
            Navigator.of(context).pop(); // モーダルを閉じる
          },
          isReversed: true, // ボタン配置を逆にする
        );
      },
    );
  }
}
