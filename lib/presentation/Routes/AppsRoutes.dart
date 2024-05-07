import 'package:single_vendor_admin/core/map/Screen/PickCurrentLocation/PickCurrentLocation.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/AccountRecovery/AccountRecovery.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/OTP/OtpScreen.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/OTP/PhoneAuthentication.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/SignUp/user_sign_up.dart';

import 'package:single_vendor_admin/presentation/Screen/Authentication/SignUp/AccountFor.dart';
import 'package:single_vendor_admin/presentation/Screen/HomePage/HomePage.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/LogIn/login_page.dart';
import 'package:single_vendor_admin/presentation/Screen/Authentication/LogIn/social_log_in.dart';
import 'package:single_vendor_admin/presentation/Screen/SplashScreen/SplashScreen.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/AddAddress/AddAddress.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/AddOffer/ProviderServiceOffer.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/AddProductType/AddProductType.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/AddProducts/product_list.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/AddProducts/add_product_dialog.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/CredentialInformation/CredentialInformation.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/HelpAndSupport/HelpAndSupport.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/HomePage/VendorHomePage.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Order/CookingItems/cooking_items.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Order/OrderReportMenuScreen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:single_vendor_admin/presentation/Screen/Vendor/Order/Ready%20To%20Delivery/ready_to_delivery_screen.dart';

import '../Screen/Vendor/NewOrder/NewOrderScreen.dart';
import '../Screen/Vendor/NewOrder/OrderDetails/OrderDetailsScreen.dart';
import '../Screen/Vendor/OrderDetails/order_details_screen.dart';

class AppRoutes {
  static String INITIAL = "/";
  static String HOME = "/home";
  static String LOG_IN = "/logIn";
  static String SIGN_UP = "/sign_up";
  static String AUTHENTICATION_PAGE = "/authentication";

  static String PHONE_NUMBER_AUTH = "/phoneNumberAuth";
  static String OTP_SCREEN = "/otpScreen";
  static String VENDOR_SIGN_UP = "/vendor_sign_up";
  static String ACCOUNTRECOVERY = "/account_recovery";
  static String ADD_PRODUCT = "/addProducts";
  static String VENDOR_HOME_PAGE = "/vendor_home_page";
  static String ADD_PRODUCT_TYPE = "/addProductType";
  static String ADD_ADDRESS = "/addAddress";
  static String CREDENTIAL_INFORMATION = "/credentialInformation";
  static String NEWORDER = "/new-order";
  static String ADD_OFFER = "/add_offer";
  static String HELP_AND_SUPPORT = "/add_offer";
  static String ORDER_REPORT_MENU = '/order_report_menu';
  static String NEW_ORDER_DETAILS = "/new_order_details";
  static String PICK_UP_CURRENT_LOCATION = "/pick_up_current_location";
  static String ADD_PRODUCT_DIALOG = "/add_product_dialog";
  static String COOKING_ITEMS = "/cooking_items";

  static String READY_TO_DELIVERY = "/ready_to_delivery";

  static String ORDER_DETAILS_PRODUCT_LIST = "/order_detais_product_list";

  static List<GetPage> AppRoutesList() {
    return [
      GetPage(name: INITIAL, page: () => SplashScreen()),
      GetPage(name: HOME, page: () => HomePage()),
      GetPage(name: LOG_IN, page: () => LoginPage()),
      GetPage(name: SIGN_UP, page: () => SignupForm()),
      GetPage(name: AUTHENTICATION_PAGE, page: () => AuthenticationPage()),
      GetPage(name: PHONE_NUMBER_AUTH, page: () => PhoneAuthentication()),
      GetPage(name: ACCOUNTRECOVERY, page: () => AccountRecovery()),
      GetPage(name: OTP_SCREEN, page: () => OtpScreen()),
      GetPage(name: VENDOR_SIGN_UP, page: () => VendorSignUp()),
      GetPage(name: ADD_PRODUCT, page: () => ProductList()),
      GetPage(name: VENDOR_HOME_PAGE, page: () => VendorHomePage()),
      GetPage(name: ADD_PRODUCT_TYPE, page: () => AddProductType()),
      GetPage(name: ADD_ADDRESS, page: () => AddAddress()),
      GetPage(
          name: CREDENTIAL_INFORMATION, page: () => CredentialInformation()),
      GetPage(name: NEWORDER, page: () => NewOrderScreen()),
      GetPage(name: ADD_OFFER, page: () => AddOffer()),
      GetPage(name: HELP_AND_SUPPORT, page: () => HelpAndSupport()),
      GetPage(name: ORDER_REPORT_MENU, page: () => OrderReportMenuScreen()),
      GetPage(name: NEW_ORDER_DETAILS, page: () => OrderDetailsScreen()),
      GetPage(
          name: PICK_UP_CURRENT_LOCATION,
          page: () => PickCurrentLocationScreen()),
      GetPage(name: ADD_PRODUCT_DIALOG, page: () => AddProductDialog()),
      GetPage(name: COOKING_ITEMS, page: () => CookingItemsScreen()),
      GetPage(name: READY_TO_DELIVERY, page: () => ReadyToDeliveryScreen()),
      GetPage(
          name: ORDER_DETAILS_PRODUCT_LIST,
          page: () => OrderDetailsProductListScreen()),
    ];
  }
}
