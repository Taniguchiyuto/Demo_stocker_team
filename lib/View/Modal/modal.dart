import 'package:flutter/material.dart';

class CustomModalDialog extends StatelessWidget {
  final String title;
  final String description;
  final String primaryButtonText;
  final VoidCallback primaryButtonAction;
  final String? secondaryButtonText;
  final VoidCallback? secondaryButtonAction;
  final bool isReversed; // ボタン配置を逆にするプロパティを追加

  const CustomModalDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.primaryButtonText,
    required this.primaryButtonAction,
    this.secondaryButtonText,
    this.secondaryButtonAction,
    this.isReversed = false, // デフォルト値はfalse
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30.0),
              // 説明
              Text(
                description,
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
                children: isReversed
                    ? _buildReversedButtons() // ボタンを逆配置
                    : _buildNormalButtons(), // 通常配置
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 通常のボタン配置
  List<Widget> _buildNormalButtons() {
    return [
      // 副ボタン
      if (secondaryButtonText != null && secondaryButtonAction != null)
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
            onPressed: secondaryButtonAction,
            child: Text(
              secondaryButtonText!,
              style: const TextStyle(
                fontSize: 14.87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      if (secondaryButtonText != null) const SizedBox(width: 16.0),
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
          onPressed: primaryButtonAction,
          child: Text(
            primaryButtonText,
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
  List<Widget> _buildReversedButtons() {
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
          onPressed: primaryButtonAction,
          child: Text(
            primaryButtonText,
            style: const TextStyle(
              fontSize: 14.87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      const SizedBox(width: 16.0),
      // 副ボタン
      if (secondaryButtonText != null && secondaryButtonAction != null)
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
            onPressed: secondaryButtonAction,
            child: Text(
              secondaryButtonText!,
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
