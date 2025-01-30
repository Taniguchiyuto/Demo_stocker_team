import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../ViewModel/Modal/modal.dart';
import '../../ViewModel/Modal/modal_state.dart';

class CustomModalDialog extends ConsumerWidget {
  const CustomModalDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modalState = ref.watch(modalProvider);
    final modalViewModel = ref.read(modalProvider.notifier);
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 7.5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // タイトル
              Text(
                modalState.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30.0),
              // 説明
              Text(
                modalState.description,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30.0),
              // ボタン
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: modalState.isReversed
                    ? _buildReversedButtons(
                        modalState, modalViewModel) // ボタンを逆配置
                    : _buildNormalButtons(modalState, modalViewModel), // 通常配置
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 通常のボタン配置
  List<Widget> _buildNormalButtons(
    ModalState modalState,
    ModalViewModel modalViewModel,
  ) {
    return [
      // 副ボタン
      if (modalState.secondaryButtonText != null &&
          modalState.secondaryButtonAction != null)
        Expanded(
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
            onPressed: modalState.secondaryButtonAction,
            child: Text(
              modalState.secondaryButtonText!,
              style: const TextStyle(
                fontSize: 14.87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      if (modalState.secondaryButtonText != null) const SizedBox(width: 16.0),
      // 主ボタン
      Expanded(
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFFF87951),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.44),
            ),
          ),
          onPressed: modalState.primaryButtonAction,
          child: Text(
            modalState.primaryButtonText,
            style: const TextStyle(
              fontSize: 14.87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ];
  }

  // ボタンを逆配置
  List<Widget> _buildReversedButtons(
    ModalState modalState,
    ModalViewModel modalViewModel,
  ) {
    return [
      // 主ボタン
      Expanded(
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFFF87951),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.44),
            ),
          ),
          onPressed: modalState.primaryButtonAction,
          child: Text(
            modalState.primaryButtonText,
            style: const TextStyle(
              fontSize: 14.87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      const SizedBox(width: 16.0),
      // 副ボタン
      if (modalState.secondaryButtonText != null &&
          modalState.secondaryButtonAction != null)
        Expanded(
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
            onPressed: modalState.secondaryButtonAction,
            child: Text(
              modalState.secondaryButtonText!,
              style: const TextStyle(
                fontSize: 14.87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
    ];
  }
}
