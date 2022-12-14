import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qualipro_flutter/Views/dashboard_screen.dart';
import 'package:qualipro_flutter/Views/licence/licence_page.dart';

import '../Models/begin_licence_model.dart';
import '../Models/licence_end_model.dart';
import '../Models/user_model.dart';
import '../Services/licence_service.dart';
import '../Services/login_service.dart';
import '../Utils/http_response.dart';
import '../Utils/shared_preference.dart';
import '../Utils/snack_bar.dart';
import '../Views/home_page.dart';
import '../Views/login/onboarding_page.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  late TextEditingController usernameController, passwordController;
  var email = '';
  var password = '';
  var isDataProcessing = false.obs;
  var isPasswordHidden = true.obs;
  BeginLicenceModel? licenceDevice;
  LicenceEndModel? licenceEndModel;
  var listBeginLicenceModel = List<BeginLicenceModel>.empty(growable: true).obs;

  @override
  void onInit() async {
    super.onInit();
    usernameController = TextEditingController();
    passwordController = TextEditingController();

    licenceDevice = await LicenceService().getBeginLicence();
    String? device_id = licenceDevice?.DeviceId;
    licenceEndModel = await LicenceService().getIsLicenceEnd(device_id);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      isDataProcessing(false);
      return "${'username'.tr} ${'is_required'.tr}";
    }
    /*if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    } */
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      isDataProcessing(false);
      return "${'password'.tr} ${'is_required'.tr}";
    }
    /*if (value.length < 6) {
      return "Password must be of 6 characters";
    } */
    return null;
  }

  void checkLogin() async {
    try {
      final isValid = loginFormKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      loginFormKey.currentState!.save();
      //isDataProcessing(true);
      isDataProcessing.value = true;

      var connection = await Connectivity().checkConnectivity();
      if (connection == ConnectivityResult.none) {
        //Get.snackbar("No Connection", "Mode Offline", colorText: Colors.blue, snackPosition: SnackPosition.TOP);
        debugPrint('licence End : ${licenceEndModel?.retour}');
        if (licenceEndModel?.retour == 0) {
          var response = await LoginService().readUser();
          response.forEach((data) {
            debugPrint('login=${data['login']}, password=${data['password']}');
            if (usernameController.text.trim() == data['login'] &&
                passwordController.text.trim() == data['password']) {
              debugPrint('login success');
              Future mat =
                  SharedPreference.setMatricule(data['mat'].toString());
              Future nomprenom =
                  SharedPreference.setNomPrenom(data['nompre'].toString());
              Future language =
                  SharedPreference.setLangue(Get.deviceLocale!.languageCode);

              Get.off(HomePage());
            } else {
              Get.snackbar('warning'.tr, 'username_password_incorrect'.tr,
                  colorText: Colors.red, snackPosition: SnackPosition.BOTTOM);
            }
          });
        } else if (licenceEndModel?.retour == 1) {
          Get.snackbar("Licence expired", 'licence_expired'.tr,
              colorText: Colors.lightBlue, snackPosition: SnackPosition.BOTTOM);
          Get.off(LicencePage());
        } else {
          Get.snackbar(
              "Licence ${licenceDevice?.DeviceId}", "Verify Licence End",
              colorText: Colors.lightBlue, snackPosition: SnackPosition.BOTTOM);
          //Get.off(LicencePage());
        }
      } else if (connection == ConnectivityResult.wifi ||
          connection == ConnectivityResult.mobile) {
        //Get.snackbar("Internet Connection", "Mode Online", colorText: Colors.blue, snackPosition: SnackPosition.TOP);

        await LoginService().loginService({
          "login": usernameController.text.trim(),
          "mot_pass": passwordController.text.trim()
        }).then((resp) async {
          //debugPrint('respone : $resp');
          resp.forEach((data) async {
            var model = UserModel();
            model.mat = data['mat'];
            model.nompre = data['nompre'];
            model.supeer = data['super'];
            model.change = data['change'];
            model.bloque = data['bloque'];
            model.login = data['login'];
            model.password = passwordController.text.trim();

            //delete table user
            await LoginService().deleteTableUser();
            //save user in db local
            await LoginService().saveUser(model);
            debugPrint(
                'Inserting data in table user : ${model.nompre}, login:${model.login}, password:${model.password} ');

            await SharedPreference.setMatricule(model.mat.toString());
            await SharedPreference.setNomPrenom(model.nompre.toString());
            await SharedPreference.setLangue(Get.deviceLocale!.languageCode);
            //Get.snackbar('Login Successfully', 'Qualipro Mobile', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.lightBlue, colorText: Colors.white);
            //insert autorisation
            String? matricule = await SharedPreference.getMatricule();
            String? device_name = await SharedPreference.getDeviceNameKey();
            //insert autorisation if not exist
            await LoginService().insertAutorisationService({
              "device": device_name,
              "mat": matricule
            }).then((responseInsertAutorisation) {
              debugPrint(
                  'responseInsertAutorisation : ${responseInsertAutorisation['retour']}');
            }, onError: (errorLicenceEnd) {
              ShowSnackBar.snackBar(
                  "Error Autorisation", errorLicenceEnd.toString(), Colors.red);
            });
            //check permission
            await LoginService()
                .checkPermissionService({"mat": matricule}).then(
                    (responseCheckPermission) {
              debugPrint(
                  'responseCheckPermission : ${responseCheckPermission['autorisation']}');
              if (responseCheckPermission['autorisation'] == 1) {
                Get.off(OnBoardingPage());
              } else {
                ShowSnackBar.snackBar('Check Permission',
                    'dont_right_enter_application'.tr, Colors.lightBlueAccent);
              }
            }, onError: (errorLicenceEnd) {
              ShowSnackBar.snackBar("Error Check Permission",
                  errorLicenceEnd.toString(), Colors.red);
            });

            //Get.off(DashboardScreen());
            //Get.offAll(DashboardScreen());
          });
        }, onError: (error) {
          HttpResponse.StatusCode(error.toString());
          /* if (error.toString() == 401.toString() ||
              error.toString().contains(401.toString())) {
            ShowSnackBar.snackBar(
                'warning'.tr, 'username_password_incorrect'.tr, Colors.red);
          } else if (error.toString() == 404.toString() ||
              error.toString().contains(404.toString())) {
            ShowSnackBar.snackBar('warning'.tr, 'Not Found', Colors.red);
          } else if (error.toString() == 500.toString() ||
              error.toString().contains(500.toString())) {
            ShowSnackBar.snackBar(
                'warning'.tr, 'internal_server_error'.tr, Colors.red);
          } else if (error.toString() == 503.toString() ||
              error.toString().contains(503.toString())) {
            ShowSnackBar.snackBar(
                'warning'.tr, 'service_unavailable'.tr, Colors.red);
          } else {
            ShowSnackBar.snackBar("Error", error.toString(), Colors.red);
          } */
          isDataProcessing(false);
        });
      }
    } catch (exception) {
      isDataProcessing(false);
      ShowSnackBar.snackBar("Exception", exception.toString(), Colors.red);
    } finally {
      //isDataProcessing(false);
      isDataProcessing.value = false;
    }
  }
}
