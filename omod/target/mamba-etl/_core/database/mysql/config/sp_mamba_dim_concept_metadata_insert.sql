
      -- $BEGIN

      SET @report_data = '{"flat_report_metadata":[{
  "report_name": "HIV Care Enrolment Report",
  "flat_table_name": "ssemr_flat_encounter_hiv_care_enrolment",
  "encounter_type_uuid": "81852aee-3f10-11e4-adec-0800271c1b75",
  "concepts_locale": "en",
  "table_columns": {
    "date_first_tested_positive": "7482b976-56fe-44b0-b30f-1e957cc0cbb0"
  }
}]}';

      CALL sp_mamba_extract_report_metadata(@report_data, 'mamba_dim_concept_metadata');

      -- $END
