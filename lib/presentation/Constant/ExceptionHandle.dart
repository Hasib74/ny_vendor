import 'package:single_vendor_admin/core/error/failures.dart';
import 'package:single_vendor_admin/presentation/Widgets/AppSnackBar.dart';

class ExceptionHandle {
  static exceptionHandle(Failure failure) {
    if (failure is ServerFailure) {
      AppSnackBar.errorSnackbar(msg: "Server Exception }");
    } else if (failure is NoConnectionFailure) {
      AppSnackBar.errorSnackbar(msg: "Please check your internet connection");
    }
  }
}
