class URL {
  // static String base_url = "http://127.0.0.1:8000/api/";
  //static var host_url = "https://onlineordering201.com/";
  static var host_url = "https://wingsthingsandpizzas.eventsandimage.com/";

  static String base_url =
      "https://wingsthingsandpizzas.eventsandimage.com/api/";
  static String vendor_url =
      "https://wingsthingsandpizzas.eventsandimage.com/api/vendor/";

  // static String base_url = "http://127.0.0.1:8000/api/";
  static String vendor_registation = "${base_url}vendor-registration/phone";
  static String account_recovery = "${base_url}vendor/account-recovery";

  static String phone_no_verificaton = "${base_url}getphone-otpcode";
  static String phone_verfication_OTP_checking =
      "${base_url}checkphone-otpcode";
  static String userLoginAuthentication = "${base_url}vendor/login";
  static String addProductType = "${base_url}create-provider/product-type";
  static String deleteProviderProductTypes = "${base_url}delete-product-types";
  static String updateProviderProductTypes = "${base_url}update-product-type";

  static String bannerStore = "${base_url}banners/store";
  static String bannerUpdate = "${base_url}banners/update/";

  //
  static String country_list = "${base_url}get-countries";

  /// issue
  static String getProductTypes = "${base_url}productTypes";
  static String getProviderAllProductTypes =
      "${base_url}provider-product-types";

  static String getAllProviderProductTypes = "${base_url}productTypes";

  static String addNewProduct = "${base_url}create-provider/product-name";
  static String updateProduct = "${base_url}update-provider/product-name/";

  //static String getProviderAllProductNames = "${base_url}get-provider-productnames";
  static String getProviderAllProductNames = "${base_url}get/my/product/list";
  static String deleteAProduct = "${base_url}delete/product-name";
  static String updateProductStock = "${base_url}update-product/stock";
  static String addProductStock = "${base_url}update-product/stock-add";

  static String addVendorOffer = "${base_url}add-product/offer";
  static String getVendorOffer =
      "${base_url}get/my/product/offer"; // "${base_url}get-vendor-offer";
  static String udateVendorOffer = "${base_url}update-product/offer";

  //vendor
  static String vendorProfileUpdate = "${vendor_url}my-profile/update";
  static String updateVendorLocation =
      "${vendor_url}my-location/update"; // with optional id parameter

  static String vendorProfile = "${vendor_url}my-profile";

  static String changePassword = "${base_url}vendor/change-password";
  static String createBankInfo = "${base_url}create/my-bank/info";
  static String getBankInfo = "${base_url}get/my-bank/info";
  static String updateBankInfo = "${base_url}update/my-bank/info";

  //vendor order
  static String getAllNewOrder = "${base_url}vendor/order-new-orders";

  //static String vendor_order_already_accepted = "${base_url}vendor/order-already-accepted";
  static String vendor_order_already_accepted =
      "${base_url}vendor/order-already-accepted-list";
  static String getOrderDetails = "${base_url}vendor/get/order-details";
  static String getOrderProductList = "${base_url}vendor/order/product-list/";
  static String orderItemDeliveryToDeliveryman =
      "${base_url}vendor-order-status-update";

  // static String getVendorCompletedOrder = "${base_url}vendor/order-complete-status";
  static String getCompletedOrders = "${base_url}vendor/order-complete-status";
  static String getTotalOrders = "${base_url}vendor/get/all-order";
  static String getOrderPickedItem = "${base_url}vendor/order-new-orders";
  static String orderPickedOrderAccept = "${base_url}vendor/order-accept";
  static String orderProcessingDone = "${base_url}vendor/order-processing-done";
  static String orderReadyOrderList =
      "${base_url}vendor/order-ready-order-list";
  static String orderDeliveredByVendor =
      "${base_url}vendor/order-delivered-by-vendor/";

  static String banner = "${base_url}banners";

  static var updateDeviceToken = "${base_url}vendor/update-device-token";

  static String addOffer = "Add Offer";

  static var bannerDelete = "${base_url}banners/delete/";
}
