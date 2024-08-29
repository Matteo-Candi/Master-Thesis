 MERGE INTO ddwh01_dw.TM_HMAT_MATERIAL TARGET
          USING (
                 SELECT
                            STUFE                                                             HMAT_NR_HIERARCHY
                          , CLAS1                                                             HMAT_CD_CLAS1
                          , HSTUFE                                                            HMAT_NR_HIERARCHY_CHILD
                          , CLAS2                                                             HMAT_CD_CLAS2
                          , CLTX1                                                             HMAT_CD_CLAS1_DESC
                          , CLTX2                                                             HMAT_CD_CLAS2_DESC
                          , HENDE                                                             HMAT_CD_FLAG
                          , CLIN1                                                             HMAT_CD_FATHER_ID
                          , CLIN2                                                             HMAT_CD_CHILD_ID
                 FROM     ddwh00_sa.TS_HMAT0001_WW_GPP SA
                 MINUS
                 SELECT
                            HMAT_NR_HIERARCHY
                          , HMAT_CD_CLAS1
                          , HMAT_NR_HIERARCHY_CHILD
                          , HMAT_CD_CLAS2
                          , HMAT_CD_CLAS1_DESC
                          , HMAT_CD_CLAS2_DESC
                          , HMAT_CD_FLAG
                          , HMAT_CD_FATHER_ID
                          , HMAT_CD_CHILD_ID
                 FROM     ddwh01_dw.TM_HMAT_MATERIAL DW
                ) SA
                ON (
                              TARGET.HMAT_NR_HIERARCHY               = SA.HMAT_NR_HIERARCHY
                          AND NVL(TARGET.HMAT_CD_CLAS1, '*')               = NVL(SA.HMAT_CD_CLAS1, '*')
                          AND NVL(TARGET.HMAT_NR_HIERARCHY_CHILD, -1)               = NVL(SA.HMAT_NR_HIERARCHY_CHILD, -1)
                          AND NVL(TARGET.HMAT_CD_CLAS2, '*')               = NVL(SA.HMAT_CD_CLAS2, '*')
                          AND NVL(TARGET.HMAT_CD_FATHER_ID, -1)               = NVL(SA.HMAT_CD_FATHER_ID, -1)
                          AND NVL(TARGET.HMAT_CD_CHILD_ID, -1)               = NVL(SA.HMAT_CD_CHILD_ID, -1)

                   )
              WHEN MATCHED THEN UPDATE
              SET
                            TARGET.HMAT_CD_CLAS1_DESC                                       = SA.HMAT_CD_CLAS1_DESC
                          , TARGET.HMAT_CD_CLAS2_DESC                                       = SA.HMAT_CD_CLAS2_DESC
                          , TARGET.HMAT_CD_FLAG                                             = SA.HMAT_CD_FLAG
                          , TARGET.HMAT_DT_LAST_MODIFY                                      = SYSDATE
                          , TARGET.HMAT_ID_BATCH_LAST_MODIFY                                = NVL(p_ELT_ID_BATCH, n_ELT_ID_JOB_LOG)
              WHEN NOT MATCHED THEN INSERT
              (
                            HMAT_ID_MATERIAL_GROUP
                          , HMAT_NR_HIERARCHY
                          , HMAT_CD_CLAS1
                          , HMAT_NR_HIERARCHY_CHILD
                          , HMAT_CD_CLAS2
                          , HMAT_CD_CLAS1_DESC
                          , HMAT_CD_CLAS2_DESC
                          , HMAT_CD_FLAG
                          , HMAT_CD_FATHER_ID
                          , HMAT_CD_CHILD_ID
                          , HMAT_DT_INSERT
                          , HMAT_DT_LAST_MODIFY
                          , HMAT_ID_BATCH_ID
                          , HMAT_ID_BATCH_LAST_MODIFY
                          , HMAT_DT_START_VALIDITY
                          , HMAT_DT_END_VALIDITY
                   )
            VALUES (
                          DDWH01_DW.SEQ_TM_HMAT.NEXTVAL                     -- HMAT_ID_MATERIAL_GROUP
                          , SA.HMAT_NR_HIERARCHY
                          , SA.HMAT_CD_CLAS1
                          , SA.HMAT_NR_HIERARCHY_CHILD
                          , SA.HMAT_CD_CLAS2
                          , SA.HMAT_CD_CLAS1_DESC
                          , SA.HMAT_CD_CLAS2_DESC
                          , SA.HMAT_CD_FLAG
                          , SA.HMAT_CD_FATHER_ID
                          , SA.HMAT_CD_CHILD_ID
                          , SYSDATE                                            -- HMAT_DT_INSERT
                          , SYSDATE                                            -- HMAT_DT_LAST_MODIFY
                          , NVL(p_ELT_ID_BATCH, n_ELT_ID_JOB_LOG)              -- HMAT_ID_BATCH_ID
                          , NVL(p_ELT_ID_BATCH, n_ELT_ID_JOB_LOG)              -- HMAT_ID_BATCH_LAST_MODIFY
                          , TO_DATE('01/01/1900', 'DD/MM/YYYY')                -- HMAT_DT_START_VALIDITY
                          , TO_DATE('31/12/9999', 'DD/MM/YYYY')                -- HMAT_DT_END_VALIDITY
                  );