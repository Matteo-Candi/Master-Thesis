MERGE INTO ddwh01_dw.TM_DESC_DESCRIPTION TARGET
          USING (
                 SELECT
                    'MAKT'                   DESC_CD_TABLE
                    ,'Material'              DESC_CD_TABLE_DESC
                    ,MATNR                   DESC_CD_CODE
                    ,SPRAS                   DESC_CD_LANGUAGE
                    ,1                       DESC_CD_POSITION
                    ,MAKTX                   DESC_CD_DESCRIPTION1
                    ,MAKTG                   DESC_CD_DESCRIPTION2
                    ,NULL                    DESC_CD_DETAIL1
                    ,NULL                    DESC_CD_DETAIL2
                    ,NULL                    DESC_CD_DETAIL3 
                    ,'WW GPP'                DESC_CD_SOURCE_SYSTEM 
                 FROM     ddwh00_sa.TS_MAKT0001_WW_GPP SA
                 UNION ALL
                 SELECT
                    'EQKT'                              DESC_CD_TABLE
                    ,'Equipment'                        DESC_CD_TABLE_DESC
                    ,EQUNR                              DESC_CD_CODE
                    ,SPRAS                              DESC_CD_LANGUAGE
                    ,1                                  DESC_CD_POSITION
                    ,EQKTX                              DESC_CD_DESCRIPTION1
                    ,EQKTU                              DESC_CD_DESCRIPTION2
                    ,KZLTX                              DESC_CD_DETAIL1
                    ,TXASP                              DESC_CD_DETAIL2
                    ,TO_CHAR(TEXTCHANGEDDATETIME)       DESC_CD_DETAIL3
                    ,'WW GPP'                           DESC_CD_SOURCE_SYSTEM
                  FROM     ddwh00_sa.TS_EQKT0001_WW_GPP SA2
                  UNION ALL
                  SELECT
                    'T005T'                     DESC_CD_TABLE
                    ,'Country'                  DESC_CD_TABLE_DESC
                    ,LAND1                      DESC_CD_CODE
                    ,SPRAS                      DESC_CD_LANGUAGE
                    ,1                        DESC_CD_POSITION
                    ,LANDX                      DESC_CD_DESCRIPTION1
                    ,LANDX50                    DESC_CD_DESCRIPTION2
                    ,PRQ_SPREGT                 DESC_CD_DETAIL1
                    ,NATIO                      DESC_CD_DETAIL2
                    ,NATIO50                    DESC_CD_DETAIL3
                    ,'WW GPP'                DESC_CD_SOURCE_SYSTEM
                  FROM     ddwh00_sa.TS_T0050002_WW_GPP SA3
                  UNION ALL
                  SELECT
                    'T023T'                      DESC_CD_TABLE
                    ,'Commodity'                 DESC_CD_TABLE_DESC
                    ,MATKL                       DESC_CD_CODE
                    ,SPRAS                       DESC_CD_LANGUAGE
                    ,1                         DESC_CD_POSITION
                    ,WGBEZ                       DESC_CD_DESCRIPTION1
                    ,WGBEZ60                     DESC_CD_DESCRIPTION2
                    ,NULL                        DESC_CD_DETAIL1
                    ,NULL                        DESC_CD_DETAIL2
                    ,NULL                        DESC_CD_DETAIL3
                    ,'WW GPP'                DESC_CD_SOURCE_SYSTEM
                  FROM     ddwh00_sa.TS_T0230002_WW_GPP SA4
                  UNION ALL
                  SELECT
                      'T052U'                       DESC_CD_TABLE
                      ,'Payment Condition'          DESC_CD_TABLE_DESC
                      ,CONCAT(ZTERM, NVL(ZTAGG, -1))    DESC_CD_CODE
                      ,SPRAS                        DESC_CD_LANGUAGE
                      ,1                            DESC_CD_POSITION
                      ,TEXT1                        DESC_CD_DESCRIPTION1
                      ,NULL                         DESC_CD_DESCRIPTION2
                      ,NULL                         DESC_CD_DETAIL1
                      ,NULL                         DESC_CD_DETAIL2
                      ,NULL                         DESC_CD_DETAIL3
                      ,'WW GPP'                DESC_CD_SOURCE_SYSTEM
                  FROM     ddwh00_sa.TS_T0520002_WW_GPP SA5
                  UNION ALL
                  SELECT
                      'TINCT'                     DESC_CD_TABLE
                      ,'Incoterms'                DESC_CD_TABLE_DESC
                      ,INCO1                      DESC_CD_CODE
                      ,SPRAS                      DESC_CD_LANGUAGE
                      ,1                          DESC_CD_POSITION
                      ,BEZEI                      DESC_CD_DESCRIPTION1
                      ,NULL                       DESC_CD_DESCRIPTION2
                      ,NULL                       DESC_CD_DETAIL1
                      ,NULL                       DESC_CD_DETAIL2
                      ,NULL                       DESC_CD_DETAIL3
                      ,'WW GPP'                DESC_CD_SOURCE_SYSTEM
                  FROM     ddwh00_sa.TS_TINC0002_WW_GPP SA6  
                  UNION ALL
                  SELECT
                    'SWOR'                        DESC_CD_TABLE
                    ,'Hierarchy Material Group'   DESC_CD_TABLE_DESC
                    ,TO_CHAR(CLINT)               DESC_CD_CODE
                    ,SPRAS                        DESC_CD_LANGUAGE
                    ,KLPOS                        DESC_CD_POSITION
                    ,KSCHL                        DESC_CD_DESCRIPTION1
                    ,KSCHG                        DESC_CD_DESCRIPTION2
                    ,NULL                         DESC_CD_DETAIL1
                    ,NULL                         DESC_CD_DETAIL2
                    ,NULL                         DESC_CD_DETAIL3
                    ,'WW GPP'                DESC_CD_SOURCE_SYSTEM
                  FROM     ddwh00_sa.TS_SWOR00001_WW_GPP SA7 
                 MINUS
                 SELECT
                     DESC_CD_TABLE
                    ,DESC_CD_TABLE_DESC
                    ,DESC_CD_CODE
                    ,DESC_CD_LANGUAGE
                    ,DESC_CD_POSITION
                    ,DESC_CD_DESCRIPTION1
                    ,DESC_CD_DESCRIPTION2
                    ,DESC_CD_DETAIL1
                    ,DESC_CD_DETAIL2
                    ,DESC_CD_DETAIL3
                    ,DESC_CD_SOURCE_SYSTEM
                 FROM     ddwh01_dw.TM_DESC_DESCRIPTION DW
                ) SA
                ON (
                              TARGET.DESC_CD_TABLE                  = SA.DESC_CD_TABLE
                          AND TARGET.DESC_CD_CODE         = SA.DESC_CD_CODE
                          AND TARGET.DESC_CD_LANGUAGE               = SA.DESC_CD_LANGUAGE
                          AND NVL(TARGET.DESC_CD_POSITION, -1)      = NVL(SA.DESC_CD_POSITION, -1)
                   )
              WHEN MATCHED THEN UPDATE
              SET
                            TARGET.DESC_CD_DESCRIPTION1                                     = SA.DESC_CD_DESCRIPTION1
                          , TARGET.DESC_CD_DESCRIPTION2                                     = SA.DESC_CD_DESCRIPTION2
                          , TARGET.DESC_CD_DETAIL1                                          = SA.DESC_CD_DETAIL1
                          , TARGET.DESC_CD_DETAIL2                                          = SA.DESC_CD_DETAIL2
                          , TARGET.DESC_CD_DETAIL3                                          = SA.DESC_CD_DETAIL3
                          , TARGET.DESC_DT_LAST_MODIFY                                      = SYSDATE
                          , TARGET.DESC_ID_BATCH_LAST_MODIFY                                = NVL(p_ELT_ID_BATCH, n_ELT_ID_JOB_LOG)
              WHEN NOT MATCHED THEN INSERT
              (
                            DESC_ID_TABLE
                          , DESC_CD_TABLE
                          , DESC_CD_TABLE_DESC 
                          , DESC_CD_CODE 
                          , DESC_CD_LANGUAGE
                          , DESC_CD_POSITION
                          , DESC_CD_DESCRIPTION1
                          , DESC_CD_DESCRIPTION2
                          , DESC_CD_DETAIL1
                          , DESC_CD_DETAIL2
                          , DESC_CD_DETAIL3
                          , DESC_CD_SOURCE_SYSTEM
                          , DESC_DT_INSERT
                          , DESC_DT_LAST_MODIFY
                          , DESC_ID_BATCH_ID
                          , DESC_ID_BATCH_LAST_MODIFY
                          , DESC_DT_START_VALIDITY
                          , DESC_DT_END_VALIDITY
                   )
            VALUES (
                            DDWH01_DW.SEQ_TM_DESC.NEXTVAL                     -- DESC_ID_TABLE
                          , SA.DESC_CD_TABLE
                          , SA.DESC_CD_TABLE_DESC
                          , SA.DESC_CD_CODE
                          , SA.DESC_CD_LANGUAGE
                          , SA.DESC_CD_POSITION
                          , SA.DESC_CD_DESCRIPTION1
                          , SA.DESC_CD_DESCRIPTION2
                          , SA.DESC_CD_DETAIL1
                          , SA.DESC_CD_DETAIL2
                          , SA.DESC_CD_DETAIL3
                          , SA.DESC_CD_SOURCE_SYSTEM
                          , SYSDATE                                            -- DESC_DT_INSERT
                          , SYSDATE                                            -- DESC_DT_LAST_MODIFY
                          , NVL(p_ELT_ID_BATCH, n_ELT_ID_JOB_LOG)              -- DESC_ID_BATCH_ID
                          , NVL(p_ELT_ID_BATCH, n_ELT_ID_JOB_LOG)              -- DESC_ID_BATCH_LAST_MODIFY
                          , TO_DATE('01/01/1900', 'DD/MM/YYYY')                -- DESC_DT_START_VALIDITY
                          , TO_DATE('31/12/9999', 'DD/MM/YYYY')                -- DESC_DT_END_VALIDITY
                  );