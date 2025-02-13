import 'package:flutter/material.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';

class CustomSnackBar {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final ScaffoldState? scaffoldState;
  final Key? key;

  CustomSnackBar(
      { this.key,
       this.scaffoldKey,
       this.scaffoldState})
      : assert(scaffoldState != null || scaffoldKey != null);

  void showErrorSnackBar(final msg) {
    showSnackBar(text: "Error: $msg", color: Colors.red[400]);
  }

  ScaffoldState? get _state {
    return scaffoldKey == null ? scaffoldState : scaffoldKey!.currentState;
  }

  void showLoadingSnackBar() {
    hideAll();
    final snackBar = SnackBar(
      key: key,
      content: Row(
        children: <Widget>[
          AppLoading(),
          SizedBox(width: 10.0),
          Text("Loading..."),
        ],
      ),
      backgroundColor: Colors.green[400],
      duration: Duration(minutes: 1),
    );
    ScaffoldMessenger.of(_state!.context).showSnackBar(snackBar);
  }

  void showSnackBar({
    required String text,
    Duration duration = const Duration(hours: 1),
    Color? color,
    bool action = true,
  }) {
    hideAll();
    final snackBar = SnackBar(
      key: key,
      content: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      backgroundColor: color ?? Colors.green[400],
      duration: duration,
      action: action
          ? SnackBarAction(
              label: "Clear",
              textColor: Colors.black,
              onPressed: () =>
                  ScaffoldMessenger.of(_state!.context).hideCurrentSnackBar())
          : null,
    );
    ScaffoldMessenger.of(_state!.context).showSnackBar(snackBar);
  }

  void hideAll() {
    //  _state?.removeCurrentSnackBar();

    ScaffoldMessenger.of(_state!.context).hideCurrentSnackBar();
  }
}
