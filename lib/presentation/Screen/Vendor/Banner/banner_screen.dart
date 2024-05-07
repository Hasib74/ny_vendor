import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:single_vendor_admin/data/repository/remote/DataSource/URL.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Banner/add_banner.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Banner/controller/banner_controller.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Banner/model/banner_model.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppLoading.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';
import 'package:single_vendor_admin/presentation/utils/AppSpaces.dart';
import 'package:getwidget/getwidget.dart';

class BannerScreen extends StatefulWidget {
  BannerScreen({Key? key}) : super(key: key);

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BannerController.to.getBanner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.orange,
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              context: context,
              elevation: 10,
              builder: (_) {
                return AddBanner();
              });
        },
        child: Icon(Icons.add),
      ),
      body: Stack(
        children: [Positioned.fill(child: _banner()), _loading()],
      ),
    );
  }

  Align _loading() {
    return Align(
      alignment: Alignment.center,
      child: Obx(() {
        return BannerController.to.isLoading.value ? AppLoading() : Container();
      }),
    );
  }

  Obx _banner() {
    return Obx(() {
      BannerModel? _bannerModel = BannerController.to.bannerModel.value;

      return ListView.separated(
          padding: EdgeInsets.all(10),
          itemBuilder: (context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          URL.host_url + _bannerModel.response![index].image! ??
                              "",
                        ))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GFButton(
                          color: Colors.white,
                          text: "Update",
                          onPressed: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return AddBanner(
                                    bannerModel: _bannerModel.response![index],
                                  );
                                });
                          },
                          textColor: AppColors.orange,
                        ),
                        AppSpaces.spaces_width_10,
                        GFButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text(
                                        "Are you sure you want to delete this banner?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("No")),
                                      TextButton(
                                          onPressed: () {
                                            BannerController.to.deleteBanner(
                                                _bannerModel
                                                    .response![index].id!);
                                            Navigator.pop(context);
                                          },
                                          child: Text("Yes")),
                                    ],
                                  );
                                });
                          },
                          text: "Delete",
                          color: Colors.white,
                          textColor: AppColors.red,
                        ),
                        AppSpaces.spaces_width_10,
                      ],
                    ),
                    Spacer(),
                    Text(
                      _bannerModel.response![index].name!,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, int index) {
            return AppSpaces.spaces_height_10;
          },
          itemCount: _bannerModel.response?.length ?? 0);
    });
  }
}
