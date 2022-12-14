import 'package:qualipro_flutter/Utils/shared_preference.dart';

import '../Services/licence_service.dart';

class AppConstants {
  static const String BASE_URL_TEST =
      "https://saph-formation.herokuapp.com/api";
  static const String PATICIPANT_URL = "$BASE_URL_TEST/participants";

  //static const String BASE_URL = "https://10.0.2.2:7019/api";
  /* Future<void> getUrlFromLicenceTable() async {
    final licenceTable = LicenceService().readLicenceInfo();
    licenceTable.forEach((data){
      static const String BASE_URL = "http://46.105.28.126/QualiproMobileB/api";
    });
  } */
  static String BASE_URL = SharedPreference.getWebServiceKey().toString();
  // static const String BASE_URL = "http://46.105.28.126/QualiproMobileB/api";
  //static const String ACTION_URL = "$BASE_URL/Action";
  static String AUTHENTICATION_URL =
      "${SharedPreference.getWebServiceKey().toString()}/api/Authentification";
  static String ACTION_URL =
      "${SharedPreference.getWebServiceKey().toString()}/api/Action";
  static String SOUS_ACTION_URL =
      "${SharedPreference.getWebServiceKey().toString()}/api/SousAction";
  static String SITE_URL =
      "${SharedPreference.getWebServiceKey().toString()}/api/Site";
  static String PROCESSUS_URL =
      "${SharedPreference.getWebServiceKey().toString()}/api/Processus";
  static String DIRECTION_URL =
      "${SharedPreference.getWebServiceKey().toString()}/api/Direction";
  static String SERVICE_URL =
      "${SharedPreference.getWebServiceKey().toString()}/api/Service";
  static String EMPLOYE_URL =
      "${SharedPreference.getWebServiceKey().toString()}/api/Employe";
  static String AUDIT_URL =
      "${SharedPreference.getWebServiceKey().toString()}/api/Audit";
  static String ACTIVITY_URL =
      "${SharedPreference.getWebServiceKey().toString()}/api/Domaine";
  static String GRAVITE_URL =
      "${SharedPreference.getWebServiceKey().toString()}/api/Gravite";
  static String PARAMETRE_SOCIETE_URL =
      "${SharedPreference.getWebServiceKey().toString()}/api/ParametreSociete";
  static String GESTION_ACCES_URL =
      "${SharedPreference.getWebServiceKey().toString()}/api/GestionAcces";
  static String UPLOAD_URL =
      "${SharedPreference.getWebServiceKey().toString()}/api/Upload";
  static String PNC_URL =
      "${SharedPreference.getWebServiceKey().toString()}/api/PNC";
  static String REUNION_URL =
      "${SharedPreference.getWebServiceKey().toString()}/api/Reunion";
  static String DOCUMENTATION_URL =
      "${SharedPreference.getWebServiceKey().toString()}/api/Documentation";
  static String INCIDENT_ENVIRONNEMENT_URL =
      "${SharedPreference.getWebServiceKey().toString()}/api/IncidentEnvironnementale";
  static String INCIDENT_SECURETE_URL =
      "${SharedPreference.getWebServiceKey().toString()}/api/IncidentSecurite";
  static String VISITE_SECURETE_URL =
      "${SharedPreference.getWebServiceKey().toString()}/api/VisiteSecurite";
}
