import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../View/Modal/modal.dart';
import '../../ViewModel/PostScreen/PostScreen.dart'; // ViewModel をインポート
import '../../ViewModel/Modal/modal.dart';

class PostScreen extends ConsumerWidget {
  final String initialText; // 編集用の初期テキスト
  final DateTime? initialDate; // 初期日付
  final int? index;
  //プロバイダーを読み込む

  const PostScreen({
    Key? key,
    required this.initialText,
    this.initialDate,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(postScreenProvider.notifier);
    final state = ref.watch(postScreenProvider);
    final postScreenViewModel = ref.read(postScreenProvider.notifier);

    print('initialText涙: $initialText');
    print('initialDate: $initialDate');
    // 初期値を設定
    if (!state.forceResetDone &&
        !state.isInitialTextApplied &&
        initialText != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        viewModel.textController.text = initialText!;
        viewModel.updateIsInitialTextApplied(true);
      });
    }
    //printの値をログに出力
    print("PostScreen received index $index ");

    final formattedDate = initialDate != null
        ? "${initialDate!.year}/${initialDate!.month.toString().padLeft(2, '0')}/${initialDate!.day.toString().padLeft(2, '0')}"
        : "";

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 52.0, // ステータスバーのスペースを確保
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 戻るボタン
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.black),
                  onPressed: () {
                    if (state.isTextEmpty) {
                      Navigator.pop(context);
                    } else {
                      _showDiscardChangesDialog(context, ref);
                    }
                  },
                ),
                // ストックボタン
                TextButton(
                  onPressed: state.isTextEmpty
                      ? null
                      : () {
                          final textToSave = state.text;
                          final now = DateTime.now();
                          FocusScope.of(context).unfocus();
                          Navigator.pop(context, {
                            'text': textToSave,
                            'date': now,
                            'index': index,
                          });
                        },
                  style: TextButton.styleFrom(
                    backgroundColor: state.isTextEmpty
                        ? Colors.grey
                        : const Color(0xFF52C2CD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1000),
                    ),
                  ),
                  child: const Text(
                    'ストックする',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  thickness: 1,
                  color: Color(0xFF9E9E9E),
                ),
                if (formattedDate.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      " 編集済み・$formattedDate",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextField(
                      controller: viewModel.textController,
                      autofocus: true,
                      maxLines: null,
                      minLines: 1,
                      decoration: const InputDecoration(
                        hintText: '気づいたことを入力しましょう',
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      //onChangedを利用してテキストをViewModelに渡す
                      onChanged: (text) {
                        viewModel.updateText(text);
                        //resetState
                        // postScreenViewModel.resetState();
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDiscardChangesDialog(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(postScreenProvider.notifier);
    final modalViewModel = ref.read(modalProvider.notifier);

    // モーダルの状態を設定
    modalViewModel.configureDialog(
      title: '変更を破棄しますか？',
      description: 'このまま破棄すると編集した内容が全て失われます。',
      primaryButtonText: '破棄する',
      primaryButtonAction: () async {
        final viewModel = ref.read(postScreenProvider.notifier);
        // 非同期で状態をリセット
        await Future.delayed(Duration.zero, () {
          viewModel.resetState();
        });
        Navigator.of(context).pop(); // モーダルを閉じる
        Navigator.of(context).pop(); // 編集画面を閉じる
      },
      secondaryButtonText: '編集を続ける',
      secondaryButtonAction: () {
        Navigator.of(context).pop(); // モーダルを閉じる
      },
      isReversed: true,
    );

    // モーダルを表示
    showDialog(
      context: context,
      builder: (_) => const CustomModalDialog(),
    );
  }
}
