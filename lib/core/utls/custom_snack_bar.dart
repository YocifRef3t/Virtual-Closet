import 'package:flutter/material.dart';

class ShowCustomSnackBar {
  final BuildContext context;
  ShowCustomSnackBar(this.context);

  void warning({required String message}) {
    ScaffoldMessenger.of(context).clearSnackBars();

    SnackBar snackBar = SnackBar(
      backgroundColor: Colors.yellow.shade900.withOpacity(0.8),
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      showCloseIcon: true,
      closeIconColor: Colors.white,
      dismissDirection: DismissDirection.endToStart,
      content: Row(
        children: [
          const Icon(Icons.warning, color: Colors.white),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void failure({required String message}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    SnackBar snackBar = SnackBar(
      backgroundColor: Colors.red.shade700.withOpacity(0.8),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      showCloseIcon: true,
      closeIconColor: Colors.white,
      dismissDirection: DismissDirection.endToStart,
      content: Row(
        children: [
          const Icon(Icons.warning, color: Colors.white),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void done({required String message}) {
    ScaffoldMessenger.of(context).clearSnackBars();

    SnackBar snackBar = SnackBar(
      backgroundColor: Colors.green.shade900.withOpacity(0.8),
      elevation: 5,
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      showCloseIcon: true,
      closeIconColor: Colors.white,
      dismissDirection: DismissDirection.endToStart,
      content: Row(
        children: [
          const Icon(Icons.done_all, color: Colors.white),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
