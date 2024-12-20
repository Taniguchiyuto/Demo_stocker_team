import 'package:flutter/material.dart';

// 削除確認ダイアログのメソッド
void showCustomDeleteConfirmationDialog(
    BuildContext context, int index, void Function() onDelete) {
  showDialog(
    context: context,
    barrierColor: Colors.grey[300],
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 7.5),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 32.0,
              left: 20.0,
              right: 20.0,
              bottom: 20.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 23.0,
                  child: Text(
                    '選択したストックを削除しますか？',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30.0),
                Text(
                  '削除したストックは復元できません。',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                              color: Color(0xFFA4B6B8),
                              width: 0.93,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'キャンセル',
                            style: TextStyle(
                              fontSize: 14.87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: SizedBox(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xFFF87951),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.44),
                            ),
                          ),
                          onPressed: () {
                            onDelete(); // コールバックで削除処理を実行
                            Navigator.of(context).pop(); //モーダルを閉じる
                          },
                          child: const Text(
                            '削除',
                            style: TextStyle(
                              fontSize: 14.87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
