import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/AppColors.dart';
import '../utils/AppSpaces.dart';

typedef Function? SearchText(String searchText);

class AppSearchWidget extends StatefulWidget {
  //const VendorOfferSearch({Key? key}) : super(key: key);

  SearchText searchText;

  VoidCallback? closeBtnOnClick;

  TextEditingController? searchTextController;

  AppSearchWidget(
      { required this.searchText, this.closeBtnOnClick, this.searchTextController});

  @override
  State<AppSearchWidget> createState() => _AppSearchWidgetState();
}

class _AppSearchWidgetState extends State<AppSearchWidget> {
  FocusNode _focusNode = new FocusNode();

  String _searchText = '';

  TextEditingController _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.searchTextController.isBlank!) {
      setState(() {
        _searchText = "";
        _searchTextController.text = "";
        _focusNode.canRequestFocus = false;
      });
    }
    return Container(
      margin: EdgeInsets.all(10),
      height: 40,
      width: Get.size.width,
      decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 1,
              blurRadius: 1,
            )
          ],
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.searchTextController ?? _searchTextController,
              focusNode: _focusNode,
              onChanged: (value) {
                widget.searchText!(value);
                setState(() {
                  _searchText = value;
                });
              },
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  counterText: '',
                  hintText: "Search...",
                  contentPadding:
                      EdgeInsets.only(left: 20, bottom: 9, top: 0, right: 15),
                  focusColor: Colors.black),
              cursorColor: Colors.black,
              maxLength: 20,
              maxLines: 1,
            ),
          ),
          _searchText.length > 0
              ? InkWell(
                  onTap: () {
                    widget.closeBtnOnClick!();
                    setState(() {
                      _searchText = "";
                      _searchTextController.text = "";
                      _focusNode.canRequestFocus = false;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(Icons.close),
                      AppSpaces.spaces_width_5,
                      AppSpaces.spaces_width_5,
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
