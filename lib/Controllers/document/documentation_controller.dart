import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qualipro_flutter/Models/documentation/type_document_model.dart';
import 'package:qualipro_flutter/Services/document/documentation_service.dart';
import 'package:qualipro_flutter/Services/document/local_documentation_service.dart';
import '../../Models/begin_licence_model.dart';
import '../../Models/documentation/documentation_model.dart';
import '../../Models/licence_end_model.dart';
import '../../Services/licence_service.dart';
import '../../Services/login_service.dart';
import '../../Utils/http_response.dart';
import '../../Utils/shared_preference.dart';
import '../../Utils/snack_bar.dart';
import '../../Views/licence/licence_page.dart';

class DocumentationController extends GetxController {
  var listDocument = List<DocumentationModel>.empty(growable: true).obs;
  var filterDocument = List<DocumentationModel>.empty(growable: true);
  var isDataProcessing = false.obs;
  LocalDocumentationService localDocumentationService =
      LocalDocumentationService();
  final matricule = SharedPreference.getMatricule();
  //search
  TextEditingController searchLibelle = TextEditingController();
  TextEditingController searchCode = TextEditingController();
  var searchType = ''.obs;
  String searchTypeOffline = '';
  TypeDocumentModel? typeDocumentModel = null;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    searchLibelle.text = '';
    searchCode.text = '';
    searchType.value = '';
    searchTypeOffline = '';
    getDocument();
    checkLicence();
    //checkConnectivity();
  }

  //check if licence end
  BeginLicenceModel? licenceDevice;
  LicenceEndModel? licenceEndModel;
  var isLicenceEnd = 0.obs;
  final deviceId = SharedPreference.getDeviceIdKey();
  checkLicence() async {
    var connection = await Connectivity().checkConnectivity();
    if (connection == ConnectivityResult.none) {
      licenceDevice = await LicenceService().getBeginLicence();
      String? device_id = licenceDevice?.DeviceId;
      licenceEndModel = await LicenceService().getIsLicenceEnd(device_id);
      if (licenceEndModel?.retour == 0) {
        debugPrint('licence of device : $device_id');
      } else {
        Get.snackbar("Licence ${SharedPreference.getLicenceKey().toString()}",
            'licence_expired'.tr,
            colorText: Colors.lightBlue, snackPosition: SnackPosition.BOTTOM);
        SharedPreference.clearSharedPreference();
        Get.off(LicencePage());
      }
    } else if (connection == ConnectivityResult.wifi ||
        connection == ConnectivityResult.mobile) {
      await LoginService().isLicenceEndService({
        "deviceid": deviceId.toString(),
      }).then((responseLicenceEnd) async {
        debugPrint('responseLicenceEnd : ${responseLicenceEnd['retour']}');
        if (responseLicenceEnd['retour'] == 0) {
          debugPrint('licence of device : ${deviceId.toString()}');
        } else {
          ShowSnackBar.snackBar(
              "Licence ${SharedPreference.getLicenceKey().toString()}",
              'licence_expired'.tr,
              Colors.lightBlueAccent);
          SharedPreference.clearSharedPreference();
          Get.off(LicencePage());
        }
      }, onError: (error) {
        HttpResponse.StatusCode(error.toString());
        //ShowSnackBar.snackBar("Error Licence End", error.toString(), Colors.red);
      });
    }
  }

  Future<void> checkConnectivity() async {
    var connection = await Connectivity().checkConnectivity();
    if (connection == ConnectivityResult.none) {
      Get.snackbar("No Connection", "Mode Offline",
          colorText: Colors.blue, snackPosition: SnackPosition.BOTTOM);
    } else if (connection == ConnectivityResult.wifi ||
        connection == ConnectivityResult.mobile) {
      Get.snackbar("Internet Connection", "Mode Online",
          colorText: Colors.blue, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void getDocument() async {
    try {
      isDataProcessing.value = true;
      var connection = await Connectivity().checkConnectivity();
      if (connection == ConnectivityResult.none) {
        //Get.snackbar("No Connection", "Mode Offline", colorText: Colors.blue, snackPosition: SnackPosition.TOP);
        //get local data
        var response = await localDocumentationService.readDocumentation();
        response.forEach((data) {
          var model = DocumentationModel();
          model.online = data['online'];
          model.cdi = data['cdi'];
          model.libelle = data['libelle'];
          model.indice = data['indice'];
          model.typeDI = data['typeDI'];
          model.fichierLien = data['fichierLien'];
          model.motifMAJ = data['motifMAJ'];
          model.fl = data['fl'];
          model.dateRevis = data['dateRevis'];
          model.suffixe = data['suffixe'];
          model.favoris = data['favoris'];
          model.favorisEtat = data['favorisEtat'];
          model.mail = data['mail'];
          model.dateCreat = data['dateCreat'];
          model.dateRevue = data['dateRevue'];
          model.dateprochRevue = data['dateprochRevue'];
          model.superv = data['superv'];
          model.sitesuperv = data['sitesuperv'];
          model.important = data['important'];
          model.issuperviseur = data['issuperviseur'];
          listDocument.add(model);
          listDocument.forEach((element) {
            print('element document ${element.cdi} - ${element.libelle}');
          });
        });
      } else if (connection == ConnectivityResult.wifi ||
          connection == ConnectivityResult.mobile) {
        //rest api
        await DocumentationService().getDocument(matricule).then(
            (response) async {
          //isDataProcessing(false);
          response.forEach((data) async {
            //print('get documentation : ${data} ');
            var model = DocumentationModel();
            model.online = 1;
            model.cdi = data['cdi'];
            model.libelle = data['libelle'];
            model.indice = data['indice'];
            model.typeDI = data['typeDI'];
            model.fichierLien = data['fichierLien'];
            model.motifMAJ = data['motifMAJ'];
            model.fl = data['fl'];
            model.dateRevis = data['dateRevis'];
            model.suffixe = data['suffixe'];
            model.favoris = data['favoris'];
            model.favorisEtat = data['favoris_etat'];
            model.mail = data['mail'];
            model.mailBoolean = data['mail_boolean'];
            model.dateCreat = data['date_creat'];
            if (model.dateCreat == null) {
              model.dateCreat = "";
            }
            model.dateRevue = data['dateRevue'];
            model.dateprochRevue = data['dateprochRevue'];
            model.nbrVers = data['nbr_vers'];
            model.superv = data['superv'];
            model.sitesuperv = data['sitesuperv'];
            if (model.sitesuperv == null) {
              model.sitesuperv = "";
            }
            model.important = data['important'];
            model.issuperviseur = data['issuperviseur'];
            model.documentPlus0 = data['document_plus0'];
            model.documentPlus1 = data['document_plus1'];
            listDocument.add(model);
            listDocument.forEach((element) {
              //print('element document ${element.cdi} - ${element.libelle}');
            });
          });
        }, onError: (error) {
          isDataProcessing.value = false;
          HttpResponse.StatusCode(error.toString());
        });
      }
    } catch (exception) {
      isDataProcessing.value = false;
      ShowSnackBar.snackBar("Exception", exception.toString(), Colors.red);
      print('Exception : ${exception.toString()}');
    } finally {
      isDataProcessing.value = false;
    }
  }

  void searchDocument() async {
    try {
      isDataProcessing.value = true;
      var connection = await Connectivity().checkConnectivity();
      if (connection == ConnectivityResult.none) {
        if (kDebugMode) {
          print('search libelle : ${searchLibelle.text}');
          print('search code : ${searchCode.text}');
          print('search type : ${searchTypeOffline}');
        }
        //Get.snackbar("No Connection", "Mode Offline", colorText: Colors.blue, snackPosition: SnackPosition.TOP);
        //get local data
        var response = await localDocumentationService.searchDocumentation(
            searchCode.text, searchLibelle.text, searchTypeOffline);
        response.forEach((data) {
          var model = DocumentationModel();
          model.online = data['online'];
          model.cdi = data['cdi'];
          model.libelle = data['libelle'];
          model.indice = data['indice'];
          model.typeDI = data['typeDI'];
          model.fichierLien = data['fichierLien'];
          model.motifMAJ = data['motifMAJ'];
          model.fl = data['fl'];
          model.dateRevis = data['dateRevis'];
          model.suffixe = data['suffixe'];
          model.favoris = data['favoris'];
          model.favorisEtat = data['favorisEtat'];
          model.mail = data['mail'];
          model.dateCreat = data['dateCreat'];
          model.dateRevue = data['dateRevue'];
          model.dateprochRevue = data['dateprochRevue'];
          model.superv = data['superv'];
          model.sitesuperv = data['sitesuperv'];
          model.important = data['important'];
          model.issuperviseur = data['issuperviseur'];
          listDocument.add(model);

          searchLibelle.clear();
          searchCode.clear();
        });
      } else if (connection == ConnectivityResult.wifi ||
          connection == ConnectivityResult.mobile) {
        if (kDebugMode) {
          print('search libelle : ${searchLibelle.text}');
          print('search code : ${searchCode.text}');
          print('search type : ${searchType.value}');
        }
        /* var URL = '${AppConstants.DOCUMENTATION_URL}/getListeDocument?mat=${matricule}'.obs;
        if(searchLibelle.text != '' && searchCode.text != ''){
          URL.value = '${AppConstants.DOCUMENTATION_URL}/getListeDocument?mat=${matricule}&libelle=${searchLibelle.text}&Code=${searchCode.text}';
         }
        else if(searchCode.text != ''){
          URL.value = '${AppConstants.DOCUMENTATION_URL}/getListeDocument?mat=${matricule}&Code=${searchCode.text}';
        }
        else if(searchLibelle.text != ''){
          URL.value = '${AppConstants.DOCUMENTATION_URL}/getListeDocument?mat=${matricule}&libelle=${searchLibelle.text}';
        }
        else if(searchLibelle.text == '' && searchCode.text == ''){
          URL.value = '${AppConstants.DOCUMENTATION_URL}/getListeDocument?mat=${matricule}';
        } */

        //rest api
        await DocumentationService()
            .searchDocument(matricule, searchCode.text, searchLibelle.text,
                searchType.value)
            .then((response) async {
          //isDataProcessing(false);
          response.forEach((data) async {
            //print('get documentation : ${data} ');
            var model = DocumentationModel();
            model.online = 1;
            model.cdi = data['cdi'];
            model.libelle = data['libelle'];
            model.indice = data['indice'];
            model.typeDI = data['typeDI'];
            model.fichierLien = data['fichierLien'];
            model.motifMAJ = data['motifMAJ'];
            model.fl = data['fl'];
            model.dateRevis = data['dateRevis'];
            model.suffixe = data['suffixe'];
            model.favoris = data['favoris'];
            model.favorisEtat = data['favoris_etat'];
            model.mail = data['mail'];
            model.mailBoolean = data['mail_boolean'];
            model.dateCreat = data['date_creat'];
            if (model.dateCreat == null) {
              model.dateCreat = "";
            }
            model.dateRevue = data['dateRevue'];
            model.dateprochRevue = data['dateprochRevue'];
            model.nbrVers = data['nbr_vers'];
            model.superv = data['superv'];
            model.sitesuperv = data['sitesuperv'];
            if (model.sitesuperv == null) {
              model.sitesuperv = "";
            }
            model.important = data['important'];
            model.issuperviseur = data['issuperviseur'];
            model.documentPlus0 = data['document_plus0'];
            model.documentPlus1 = data['document_plus1'];
            listDocument.add(model);

            searchLibelle.clear();
            searchCode.clear();
          });
        }, onError: (error) {
          isDataProcessing.value = false;
          HttpResponse.StatusCode(error.toString());
        });
      }
    } catch (exception) {
      isDataProcessing.value = false;
      ShowSnackBar.snackBar("Exception", exception.toString(), Colors.red);
      print('Exception : ${exception.toString()}');
    } finally {
      isDataProcessing.value = false;
    }
  }

  //synchronization
  Future syncDocumentationToWebService() async {
    try {
      isDataProcessing(true);
      var connection = await Connectivity().checkConnectivity();
      if (connection == ConnectivityResult.none) {
        Get.snackbar("No Connection", 'cannot_synchronize_data'.tr,
            colorText: Colors.blue, snackPosition: SnackPosition.TOP);
      } else if (connection == ConnectivityResult.wifi ||
          connection == ConnectivityResult.mobile) {
        //save data in db local
        await DocumentationService().getDocument(matricule).then((resp) async {
          //delete table
          await localDocumentationService.deleteTableDocumentation();
          resp.forEach((data) async {
            var model = DocumentationModel();
            model.online = 1;
            model.cdi = data['cdi'];
            model.libelle = data['libelle'];
            model.indice = data['indice'];
            model.typeDI = data['typeDI'];
            model.fichierLien = data['fichierLien'];
            model.motifMAJ = data['motifMAJ'];
            model.fl = data['fl'];
            model.dateRevis = data['dateRevis'];
            model.suffixe = data['suffixe'];
            model.favoris = data['favoris'];
            model.favorisEtat = data['favoris_etat'];
            model.mail = data['mail'];
            model.dateCreat = data['date_creat'];
            if (model.dateCreat == null) {
              model.dateCreat = "";
            }
            model.dateRevue = data['dateRevue'];
            model.dateprochRevue = data['dateprochRevue'];
            model.superv = data['superv'];
            model.sitesuperv = data['sitesuperv'];
            if (model.sitesuperv == null) {
              model.sitesuperv = "";
            }
            model.important = data['important'];
            model.issuperviseur = data['issuperviseur'];

            //save data
            await localDocumentationService.saveDocumentation(model);
            print(
                'Inserting data in table Documentation : ${model.cdi} - ${model.libelle}');
          });
        }, onError: (error) {
          isDataProcessing(false);
          HttpResponse.StatusCode(error.toString());
          // ShowSnackBar.snackBar("Error", err.toString(), Colors.red);
        });
      }
    } catch (exception) {
      isDataProcessing(false);
      ShowSnackBar.snackBar("Exception", exception.toString(), Colors.red);
    } finally {
      isDataProcessing(false);
    }
  }
}
