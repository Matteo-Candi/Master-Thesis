MERGE INTO ddwh01_dw.TD_KONH_CONDITIONS_HEADER_GPP TARGET
          USING (
                 SELECT
                            KNUMH                                                             KONH_CD_CONDITION_RECORD_NBR
                          , ERNAM                                                             KONH_CD_OBJ_CREATED_BY
                          , ERDAT                                                             KONH_DT_CREATED_ON
                          , KVEWE                                                             KONH_CD_TABLE_USAGE
                          , KOTABNR                                                           KONH_NR_CONDITION_TABLE
                          , KAPPL                                                             KONH_CD_APPLICATION
                          , KSCHL                                                             KONH_CD_CONDITION_TYPE
                          , VAKEY                                                             KONH_CD_VARIABLE_KEY
                          , DATAB                                                             KONH_DT_VALID_FROM_DT
                          , DATBI                                                             KONH_DT_VALID_TO_DT
                          , KOSRT                                                             KONH_CD_SEARCH_TERM
                          , KZUST                                                             KONH_CD_RESPONSIBILITY
                          , KNUMA_PI                                                          KONH_CD_PROMOTION_1
                          , KNUMA_AG                                                          KONH_CD_SALES_DEAL
                          , KNUMA_SQ                                                          KONH_CD_SALES_QUOTE
                          , KNUMA_SD                                                          KONH_CD_STANDARD_AGREEMENT
                          , AKTNR                                                             KONH_CD_PROMOTION_2
                          , KNUMA_BO                                                          KONH_CD_AGREEMENT
                          , LICNO                                                             KONH_CD_TAX_EXEMP_LICENSE_NO
                          , LICDT                                                             KONH_DT_LICENSE_GRANTED
                          , CCNUM                                                             KONH_CD_CONDITION_CONTRACT
                          , EXTERNAL_GUID                                                     KONH_CD_EXTERNAL_GUID
                          , REFERENCE                                                         KONH_NR_REFERENCE
                 FROM     ddwh00_sa.TS_KONH0001_WW_GPP SA
                 MINUS
                 SELECT
                            KONH_CD_CONDITION_RECORD_NBR
                          , KONH_CD_OBJ_CREATED_BY
                          , KONH_DT_CREATED_ON
                          , KONH_CD_TABLE_USAGE
                          , KONH_NR_CONDITION_TABLE
                          , KONH_CD_APPLICATION
                          , KONH_CD_CONDITION_TYPE
                          , KONH_CD_VARIABLE_KEY
                          , KONH_DT_VALID_FROM_DT
                          , KONH_DT_VALID_TO_DT
                          , KONH_CD_SEARCH_TERM
                          , KONH_CD_RESPONSIBILITY
                          , KONH_CD_PROMOTION_1
                          , KONH_CD_SALES_DEAL
                          , KONH_CD_SALES_QUOTE
                          , KONH_CD_STANDARD_AGREEMENT
                          , KONH_CD_PROMOTION_2
                          , KONH_CD_AGREEMENT
                          , KONH_CD_TAX_EXEMP_LICENSE_NO
                          , KONH_DT_LICENSE_GRANTED
                          , KONH_CD_CONDITION_CONTRACT
                          , KONH_CD_EXTERNAL_GUID
                          , KONH_NR_REFERENCE
                 FROM     ddwh01_dw.TD_KONH_CONDITIONS_HEADER_GPP DW
                ) SA
                ON (
                              TARGET.KONH_CD_CONDITION_RECORD_NBR               = SA.KONH_CD_CONDITION_RECORD_NBR
                   )
              WHEN MATCHED THEN UPDATE
              SET
                            TARGET.KONH_CD_OBJ_CREATED_BY                                   = SA.KONH_CD_OBJ_CREATED_BY
                          , TARGET.KONH_DT_CREATED_ON                                       = SA.KONH_DT_CREATED_ON
                          , TARGET.KONH_CD_TABLE_USAGE                                      = SA.KONH_CD_TABLE_USAGE
                          , TARGET.KONH_NR_CONDITION_TABLE                                  = SA.KONH_NR_CONDITION_TABLE
                          , TARGET.KONH_CD_APPLICATION                                      = SA.KONH_CD_APPLICATION
                          , TARGET.KONH_CD_CONDITION_TYPE                                   = SA.KONH_CD_CONDITION_TYPE
                          , TARGET.KONH_CD_VARIABLE_KEY                                     = SA.KONH_CD_VARIABLE_KEY
                          , TARGET.KONH_DT_VALID_FROM_DT                                    = SA.KONH_DT_VALID_FROM_DT
                          , TARGET.KONH_DT_VALID_TO_DT                                      = SA.KONH_DT_VALID_TO_DT
                          , TARGET.KONH_CD_SEARCH_TERM                                      = SA.KONH_CD_SEARCH_TERM
                          , TARGET.KONH_CD_RESPONSIBILITY                                   = SA.KONH_CD_RESPONSIBILITY
                          , TARGET.KONH_CD_PROMOTION_1                                      = SA.KONH_CD_PROMOTION_1
                          , TARGET.KONH_CD_SALES_DEAL                                       = SA.KONH_CD_SALES_DEAL
                          , TARGET.KONH_CD_SALES_QUOTE                                      = SA.KONH_CD_SALES_QUOTE
                          , TARGET.KONH_CD_STANDARD_AGREEMENT                               = SA.KONH_CD_STANDARD_AGREEMENT
                          , TARGET.KONH_CD_PROMOTION_2                                      = SA.KONH_CD_PROMOTION_2
                          , TARGET.KONH_CD_AGREEMENT                                        = SA.KONH_CD_AGREEMENT
                          , TARGET.KONH_CD_TAX_EXEMP_LICENSE_NO                             = SA.KONH_CD_TAX_EXEMP_LICENSE_NO
                          , TARGET.KONH_DT_LICENSE_GRANTED                                  = SA.KONH_DT_LICENSE_GRANTED
                          , TARGET.KONH_CD_CONDITION_CONTRACT                               = SA.KONH_CD_CONDITION_CONTRACT
                          , TARGET.KONH_CD_EXTERNAL_GUID                                    = SA.KONH_CD_EXTERNAL_GUID
                          , TARGET.KONH_NR_REFERENCE                                        = SA.KONH_NR_REFERENCE
                          , TARGET.KONH_DT_LAST_MODIFY                                      = SYSDATE
                          , TARGET.KONH_ID_BATCH_LAST_MODIFY                                = NVL(p_ELT_ID_BATCH, n_ELT_ID_JOB_LOG)
              WHEN NOT MATCHED THEN INSERT
              (
                            KONH_ID_CONDITIONS_HEADER_GPP
                          , KONH_CD_CONDITION_RECORD_NBR
                          , KONH_CD_OBJ_CREATED_BY
                          , KONH_DT_CREATED_ON
                          , KONH_CD_TABLE_USAGE
                          , KONH_NR_CONDITION_TABLE
                          , KONH_CD_APPLICATION
                          , KONH_CD_CONDITION_TYPE
                          , KONH_CD_VARIABLE_KEY
                          , KONH_DT_VALID_FROM_DT
                          , KONH_DT_VALID_TO_DT
                          , KONH_CD_SEARCH_TERM
                          , KONH_CD_RESPONSIBILITY
                          , KONH_CD_PROMOTION_1
                          , KONH_CD_SALES_DEAL
                          , KONH_CD_SALES_QUOTE
                          , KONH_CD_STANDARD_AGREEMENT
                          , KONH_CD_PROMOTION_2
                          , KONH_CD_AGREEMENT
                          , KONH_CD_TAX_EXEMP_LICENSE_NO
                          , KONH_DT_LICENSE_GRANTED
                          , KONH_CD_CONDITION_CONTRACT
                          , KONH_CD_EXTERNAL_GUID
                          , KONH_NR_REFERENCE
                          , KONH_DT_INSERT
                          , KONH_DT_LAST_MODIFY
                          , KONH_ID_BATCH_ID
                          , KONH_ID_BATCH_LAST_MODIFY
                          , KONH_DT_START_VALIDITY
                          , KONH_DT_END_VALIDITY
                   )
            VALUES (
                          DDWH01_DW.SEQ_TD_KONH.NEXTVAL                     -- KONH_ID_CONDITIONS_HEADER_GPP
                          , SA.KONH_CD_CONDITION_RECORD_NBR
                          , SA.KONH_CD_OBJ_CREATED_BY
                          , SA.KONH_DT_CREATED_ON
                          , SA.KONH_CD_TABLE_USAGE
                          , SA.KONH_NR_CONDITION_TABLE
                          , SA.KONH_CD_APPLICATION
                          , SA.KONH_CD_CONDITION_TYPE
                          , SA.KONH_CD_VARIABLE_KEY
                          , SA.KONH_DT_VALID_FROM_DT
                          , SA.KONH_DT_VALID_TO_DT
                          , SA.KONH_CD_SEARCH_TERM
                          , SA.KONH_CD_RESPONSIBILITY
                          , SA.KONH_CD_PROMOTION_1
                          , SA.KONH_CD_SALES_DEAL
                          , SA.KONH_CD_SALES_QUOTE
                          , SA.KONH_CD_STANDARD_AGREEMENT
                          , SA.KONH_CD_PROMOTION_2
                          , SA.KONH_CD_AGREEMENT
                          , SA.KONH_CD_TAX_EXEMP_LICENSE_NO
                          , SA.KONH_DT_LICENSE_GRANTED
                          , SA.KONH_CD_CONDITION_CONTRACT
                          , SA.KONH_CD_EXTERNAL_GUID
                          , SA.KONH_NR_REFERENCE
                          , SYSDATE                                            -- KONH_DT_INSERT
                          , SYSDATE                                            -- KONH_DT_LAST_MODIFY
                          , NVL(p_ELT_ID_BATCH, n_ELT_ID_JOB_LOG)              -- KONH_ID_BATCH_ID
                          , NVL(p_ELT_ID_BATCH, n_ELT_ID_JOB_LOG)              -- KONH_ID_BATCH_LAST_MODIFY
                          , TO_DATE('01/01/1900', 'DD/MM/YYYY')                -- KONH_DT_START_VALIDITY
                          , TO_DATE('31/12/9999', 'DD/MM/YYYY')                -- KONH_DT_END_VALIDITY
                  );