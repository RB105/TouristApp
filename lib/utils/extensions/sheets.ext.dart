/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

part of 'dialog_ext.dart';

class _OverlayState {
  static bool isShowing = false;

  static void beforeShow(BuildContext context) {
    if (isShowing) {
      Navigator.of(context, rootNavigator: true).pop();
      isShowing = false;
    }
    isShowing = true;
  }

  static void afterClose() => isShowing = false;
}

extension SheetsExt on BuildContext { /// Simple test bottom sheet
  void _beforeShow() => _OverlayState.beforeShow(this);
  void _afterClose() => _OverlayState.afterClose();

  /// Universal hide — closes any open dialog OR sheet
  void hide() {
    if (_OverlayState.isShowing) {
      Navigator.of(this, rootNavigator: true).pop();
      _OverlayState.isShowing = false;
    }
  }
  Future<void> showTestSheet() async {
    _beforeShow();
    await showModalBottomSheet(
      context: this,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const _TestSheet(),
    ).whenComplete(_afterClose);
  }
}

// ─────────────────────────────────────────────
// _TestSheet widget
// ─────────────────────────────────────────────
class _TestSheet extends StatelessWidget {
  const _TestSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          // Title
          const Text(
            "Test Bottom Sheet",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Description
          const Text(
            "This is a simple test sheet.\nIt auto-hides any open dialog or sheet before showing.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 32),

          // Close button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
              child: const Text(
                "Close",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}