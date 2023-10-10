-- $BEGIN

-- Update the Concept datatypes, concept_name and concept_id based on given locale
UPDATE mamba_dim_concept_metadata md
    INNER JOIN mamba_dim_concept c
    ON md.concept_uuid = c.uuid
    INNER JOIN mamba_dim_concept_name cn
    ON c.concept_id = cn.concept_id
SET md.concept_datatype = c.datatype,
    md.concept_id       = c.concept_id,
    md.concept_name     = cn.name
WHERE md.id > 0
  AND cn.locale = md.concepts_locale
  AND IF(cn.locale_preferred = 1, cn.locale_preferred = 1, cn.concept_name_type = 'FULLY_SPECIFIED');

-- Use locale preferred or Fully specified name

-- Update to True if this field is an obs answer to an obs Question
UPDATE mamba_dim_concept_metadata md
    INNER JOIN mamba_dim_concept_answer ca
    ON md.concept_id = ca.answer_concept
SET md.concept_answer_obs = 1
WHERE md.id > 0 AND
        md.concept_id IN (SELECT DISTINCT ca.concept_id
                          FROM  mamba_dim_concept_answer ca);

-- Update to for multiple selects/dropdowns/options this field is an obs answer to an obs Question
UPDATE mamba_dim_concept_metadata md
SET md.concept_answer_obs = 1
WHERE md.id > 0 and concept_datatype = 'N/A';

-- Update row number
UPDATE mamba_dim_concept_metadata md
    INNER JOIN (SELECT id,
                       ROW_NUMBER() OVER (PARTITION BY flat_table_name,concept_id ORDER BY id ASC) num
                FROM mamba_dim_concept_metadata) m
    ON md.id = m.id
SET md.row_num = num
WHERE md.id > 0;

-- $END
