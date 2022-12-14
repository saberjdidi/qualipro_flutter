class DBTable {
  static const String DB_Name = 'qualipro.db';
  static const String licence_info = "LicenceInfo";
  static const String mobile_licence = "MobileLicence";
  static const String user = "User";
  static const String domaine_affectation = "DomaineAffectation";
  static const String site = "Site";
  static const String processus = "Processus";
  static const String processus_employe = "ProcessusEmploye";
  static const String product = "Product";
  static const String resp_cloture = "RespCloture";
  static const String direction = "Direction";
  static const String employe = "Employe";
  static const String activity = "Activity";
  static const String service = "Service";
  static const String gravite = "Gravite";
  static const String priorite = "Priorite";
  static const String action = "Action";
  static const String action_sync = "ActionSync";
  static const String type_action = "TypeAction";
  static const String source_action = "SourceAction";
  static const String type_cause_action = "TypeCauseAction";
  static const String type_cause_action_a_rattacher =
      "TypeCauseActionARattacher";
  static const String audit_action = "AuditAction";
  static const String sous_action = "SousAction";
  static const String champ_obligatoire_action = "ChampObligatoireAction";
  static const String champ_obligatoire_pnc = "ChampObligatoirePNC";
  static const String champ_obligatoire_incident_env =
      "ChampObligatoireIncidentEnv";
  static const String champ_obligatoire_incident_securite =
      "ChampObligatoireIncidentSecurite";
  static const String champ_cache = "ChampCache";
  static const String fournisseur = "Fournisseur";
  static const String client = "Client";
  static const String type_pnc = "TypePNC";
  static const String gravite_pnc = "GravitePNC";
  static const String source_pnc = "SourcePNC";
  static const String atelier_pnc = "AtelierPNC";
  static const String pnc = "PNC";
  static const String product_pnc = "ProductPNC";
  static const String type_product_pnc = "TypeProductPNC";
  static const String type_cause_pnc = "TypeCausePNC";
  static const String type_cause_a_rattacher_pnc = "TypeCauseARattacherPNC";
  static const String reunion = "Reunion";
  static const String participant_reunion = "ParticipantReunion";
  static const String type_reunion = "TypeReunion";
  static const String type_reunion_matricule = "TypeReunionMatricule";
  static const String action_reunion_rattacher = "ActionReunionRattacher";
  static const String documentation = "Documentation";
  static const String type_document = "TypeDocument";
  static const String incident_environnement = "IncidentEnvironnement";
  static const String type_cause_incident_env = "TypeCauseIncidentEnv";
  static const String type_cause_incident_env_rattacher =
      "TypeCauseIncidentEnvRattacher";
  static const String type_consequence_incident_env =
      "TypeConsequenceIncidentEnv";
  static const String type_consequence_incident_env_rattacher =
      "TypeConsequenceIncidentEnvRattacher";
  static const String action_inc_env_rattacher = "ActionIncEnvRattacher";
  static const String action_inc_sec_rattacher = "ActionIncSecRattacher";
  static const String category_incident_env = "CategoryIncidentEnv";
  static const String type_incident_env = "TypeIncidentEnv";
  static const String lieu_incident_env = "LieuIncidentEnv";
  static const String source_incident_env = "SourceIncidentEnv";
  static const String cout_estime_incident_env = "CoutEstimeIncidentEnv";
  static const String gravite_incident_env = "GraviteIncidentEnv";
  static const String secteur_incident_env = "SecteurIncidentEnv";
  static const String incident_securite = "IncidentSecurite";
  static const String poste_travail = "PosteTravail";
  static const String type_incident_securite = "TypeIncidentSecurite";
  static const String category_incident_securite = "CategoryIncidentSecurite";
  static const String cause_typique_incident_securite =
      "CauseTypiqueIncidentSecurite";
  static const String cause_typique_incident_securite_rattacher =
      "CauseTypiqueIncidentSecuriteRattacher";
  static const String type_cause_incident_securite =
      "TypeCauseIncidentSecurite";
  static const String type_cause_incident_securite_rattacher =
      "TypeCauseIncidentSecuriteRattacher";
  static const String type_consequence_incident_securite =
      "TypeConsequenceIncidentSecurite";
  static const String type_consequence_incident_securite_rattacher =
      "TypeConsequenceIncidentSecuriteRattacher";
  static const String site_lesion_incident_securite =
      "SiteLesionIncidentSecurite";
  static const String site_lesion_incident_securite_rattacher =
      "SiteLesionIncidentSecuriteRattacher";
  static const String gravite_incident_securite = "GraviteIncidentSecurite";
  static const String secteur_incident_securite = "SecteurIncidentSecurite";
  static const String cout_estime_incident_securite =
      "CoutEstimeIncidentSecurite";
  static const String evenement_declencheur_incident_securite =
      "EvenementDeclencheurIncidentSecurite";
  static const String visite_securite = "VisiteSecurite";
  static const String check_list = "CheckList";
  static const String check_list_vs_rattacher = "CheckListVSRattacher";
  static const String action_visite_securite_rattacher =
      "ActionVisiteSecuriteRattacher";
  static const String taux_checklist_vs = "TauxCheckListVS";
  static const String unite_visite_securite = "UniteVisiteSecurite";
  static const String zone_visite_securite = "ZoneVisiteSecurite";
  static const String site_visite_securite = "SiteVisiteSecurite";
  static const String equipe_visite_securite = "EquipeVisiteSecurite";
  static const String equipe_visite_securite_employe =
      "EquipeVisiteSecuriteEmploye";
  static const String equipe_visite_securite_offline =
      "EquipeVisiteSecuriteOffline";
  static const String audit = "Audit";
  static const String champ_audit = "ChampAudit";
  static const String champ_audit_constat = "ChampAuditConstat";
  static const String auditeur_interne = "AuditeurInterne";
  static const String auditeur_interne_a_rattacher =
      "AuditeurInterneARattacher";
  static const String auditeurs_externe = "AuditeursExterne";
  static const String auditeur_externe_rattacher = "AuditeurExterneRattacher";
  static const String employe_habilite_audit = "EmployeHabiliteAudit";
  static const String type_audit = "TypeAudit";
  static const String gravite_audit = "GraviteAudit";
  static const String type_constat_audit = "TypeConstatAudit";
  static const String constat_audit = "ConstatAudit";
  static const String checklist_audit = "CheckListAudit";
  static const String critere_checklist_audit = "CritereCheckListAudit";
  static const String upload_image_inc_env = "UploadImageIncEnv";
  static const String upload_image_inc_sec = "UploadImageIncSec";
  static const String upload_image_pnc = "UploadImagePNC";
  static const String upload_image_visite_sec = "UploadImageVisiteSec";

  //agenda
  static const String action_realisation = "ActionRealisation";
  static const String action_suivi = "ActionSuivi";
  static const String action_suite_audit = "ActionSuiteAudit";
  static const String pnc_valider = "PNCVAlider";
  static const String pnc_investigation_effectuer = "PNCInvestigationEffectuer";
  static const String pnc_investigation_approuver = "PNCInvestigationApprouver";
  static const String pnc_decision = "PNCDecision";
  static const String pnc_traiter = "PNCTraiter";
  static const String pnc_decision_validation = "PNCDecisionValidation";
  static const String pnc_corriger = "PNCCorriger";
  static const String pnc_suivre = "PNCSuivre";
  static const String pnc_approbation_finale = "PNCApprobationFinale";
  static const String reunion_informer = "ReunionInformer";
  static const String reunion_planifier = "ReunionPlanifier";
  static const String incident_env_decision_traitement =
      "IncidentEnvDecisionTraitement";
  static const String incident_env_a_traiter = "IncidentEnvATraiter";
  static const String incident_env_a_cloturer = "IncidentEnvACloturer";
  static const String incident_securite_decision_traitement =
      "IncidenSecuriteDecisionTraitement";
  static const String incident_securite_a_traiter = "IncidentSecuriteATraiter";
  static const String incident_securite_a_cloturer =
      "IncidentSecuriteACloturer";
  static const String audit_audite = "AuditAudite";
  static const String audit_auditeur = "AuditAuditeur";
  static const String rapport_audit_valider = "RapportAuditValider";

  static const String task = "Task";
  static const String task_sync = "TaskSync";
}
