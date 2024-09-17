INSERT INTO DDWH02_DM_MA.TFCT_FISI_PART_NBR_WITH_ISIR TRG (FISI_CD_PLANT_CD, FISI_ID_FISI, FISI_ID_TIME_SNAPSHOT, FISI_ID_MTRL_PART_NBR, FISI_CD_PART_NBR, FISI_ID_TIME_FIRST_NXT_REQ_DT, FISI_DT_FIRST_NXT_REQ_DT, FISI_CD_PROD_ORD, FISI_CD_EFF_ORD, FISI_CD_SERIE, FISI_FL_PLANNED_ORDER_FL, FISI_FL_PAST_ORD_FL, FISI_ID_ISIR_ISIR, FISI_CD_ISIR, FISI_DT_ISIR_VALID_STR_DT, FISI_DT_ISIR_VALID_END_DT, FISI_ID_VEND_VENDOR, FISI_CD_VENDOR_CD, FISI_FL_VENDOR_ACTIVE, FISI_CD_REVISION_LEVEL, FISI_CD_PURCH_ORD_NBR, FISI_CD_PURCH_ORD_LN, FISI_CD_SEQ_ID, FISI_ID_TIME_REQ_DLVR_DT, FISI_CD_FIRST_PROD_ORD, FISI_CD_FIRST_EFF_ORD, FISI_DT_FIRST_CONFIRM_DT, FISI_CD_FIRST_SERIE, FISI_ID_ISIR_FIRST_ISIR, FISI_CD_FIRST_ISIR, FISI_ID_VEND_FIRST_VENDOR_CD, FISI_CD_FIRST_VENDOR_CD, FISI_CD_FIRST_REVISION_LEVEL, FISI_ID_BATCH_ID, FISI_CD_SOURCE_SYSTEM, FISI_DT_INS_ROW, FISI_DT_UPD_ROW, FISI_CD_OPERATOR_CODE)
SELECT QRY.FISI_CD_PLANT_CD,
       DDWH02_DM_MA.SEQ_FISI_TFCT01.NEXTVAL,
       QRY.FISI_ID_TIME_SNAPSHOT,
       QRY.FISI_ID_MTRL_PART_NBR,
       QRY.FISI_CD_PART_NBR,
       QRY.FISI_ID_TIME_FIRST_NXT_REQ_DT,
       QRY.FISI_DT_FIRST_NXT_REQ_DT,
       QRY.FISI_CD_PROD_ORD,
       QRY.FISI_CD_EFF_ORD,
       QRY.FISI_CD_SERIE,
       QRY.FISI_FL_PLANNED_ORDER_FL,
       QRY.FISI_FL_PAST_ORD,
       QRY.FISI_ID_ISIR_ISIR,
       QRY.FISI_CD_ISIR,
       QRY.FISI_DT_ISIR_VALID_STR_DT,
       QRY.FISI_DT_ISIR_VALID_END_DT,
       QRY.FISI_ID_VEND_VENDOR,
       QRY.FISI_CD_VENDOR_CD,
       QRY.FISI_FL_VENDOR_ACTIVE,
       QRY.FISI_CD_REVISION_LEVEL,
       QRY.FISI_CD_PURCH_ORD_NBR,
       QRY.FISI_CD_PURCH_ORD_LN,
       QRY.FISI_CD_SEQ_ID,
       QRY.FISI_ID_TIME_REQ_DLVR_DT,
       QRY.FISI_CD_FIRST_PROD_ORD,
       QRY.FISI_CD_FIRST_EFF_ORD,
       QRY.FISI_DT_FIRST_CONFIRM_DT,
       QRY.FISI_CD_FIRST_SERIE,
       QRY.FISI_ID_ISIR_FIRST_ISIR,
       QRY.FISI_ID_ISIR_FIRST_ISIR,
       QRY.FISI_ID_VEND_FIRST_VENDOR_CD,
       QRY.FISI_CD_FIRST_VENDOR_CD,
       QRY.FISI_CD_FIRST_REVISION_LEVEL,
       QRY.FISI_ID_BATCH_ID,
       QRY.FISI_CD_SOURCE_SYSTEM,
       SYSDATE,
       SYSDATE,
       'ETL'
FROM
  (SELECT FISI_CD_PLANT_CD,
          NULL FISI_ID_FISI,
               NVL (TO_NUMBER (TO_CHAR (TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'), 'J')), -2) AS FISI_ID_TIME_SNAPSHOT,
               FISI_ID_MTRL_PART_NBR,
               FISI_CD_PART_NBR,
               FISI_ID_TIME_FIRST_NXT_REQ_DT,
               FISI_DT_FIRST_NXT_REQ_DT,
               FISI_CD_PROD_ORD,
               FISI_CD_EFF_ORD,
               FISI_CD_SERIE,
               FISI_FL_PLANNED_ORDER_FL,
               FISI_FL_PAST_ORD,
               FISI_ID_ISIR_ISIR,
               FISI_CD_ISIR,
               FISI_DT_ISIR_VALID_STR_DT,
               FISI_DT_ISIR_VALID_END_DT,
               FISI_ID_VEND_VENDOR,
               FISI_CD_VENDOR_CD,
               FISI_FL_VENDOR_ACTIVE,
               FISI_CD_REVISION_LEVEL,
               FISI_CD_PURCH_ORD_NBR,
               FISI_CD_PURCH_ORD_LN,
               FISI_CD_SEQ_ID,
               FISI_ID_TIME_REQ_DLVR_DT,
               FISI_CD_FIRST_PROD_ORD,
               FISI_CD_FIRST_EFF_ORD,
               FISI_DT_FIRST_CONFIRM_DT,
               FISI_CD_FIRST_SERIE,
               FISI_ID_ISIR_FIRST_ISIR,
               FISI_CD_FIRST_ISIR_CD,
               FISI_ID_VEND_FIRST_VENDOR_CD,
               FISI_CD_FIRST_VENDOR_CD,
               FISI_CD_FIRST_REVISION_LEVEL,
               NVL (P_ELT_ID_BATCH, N_ELT_ID_JOB_LOG) AS FISI_ID_BATCH_ID,
               FISI_CD_SOURCE_SYSTEM
   FROM
     (SELECT ACTUAL_ISIR.ISIR_CD_PLANT_CD AS FISI_CD_PLANT_CD,
             ACTUAL_ISIR.ISIR_ID_MAMD_PART_NBR AS FISI_ID_MTRL_PART_NBR,
             ACTUAL_ISIR.ISIR_CD_PART_NBR AS FISI_CD_PART_NBR,
             NVL (COMPONENT_USE.ACTUAL_FLD_ID_REQ_DATE, -2) AS FISI_ID_TIME_FIRST_NXT_REQ_DT,
             COMPONENT_USE.ACTUAL_FLD_REQ_DATE AS FISI_DT_FIRST_NXT_REQ_DT,
             COMPONENT_USE.ACTUAL_FLD_ORDER AS FISI_CD_PROD_ORD,
             COMPONENT_USE.ACTUAL_FLD_EFF_ORDER AS FISI_CD_EFF_ORD,
             COMPONENT_USE.ACTUAL_FLD_SERIE AS FISI_CD_SERIE,
             COMPONENT_USE.ACTUAL_FLD_TYPE_ORDER AS FISI_FL_PLANNED_ORDER_FL,
             FLD_FL_PAST_ORD AS FISI_FL_PAST_ORD,
             ACTUAL_ISIR.ISIR_ID_ICMD_ISIR_CD AS FISI_ID_ISIR_ISIR,
             ACTUAL_ISIR.ISIR_CD_ISIR_CD AS FISI_CD_ISIR,
             ACTUAL_ISIR.ISIR_DT_VALID_STR_DT AS FISI_DT_ISIR_VALID_STR_DT,
             ACTUAL_ISIR.ISIR_DT_VALID_END_DT AS FISI_DT_ISIR_VALID_END_DT,
             ACTUAL_ISIR.ISIR_ID_VEND_SUPPL_CD AS FISI_ID_VEND_VENDOR,
             ACTUAL_ISIR.ISIR_CD_SUPPL_CD AS FISI_CD_VENDOR_CD,
             (CASE
                  WHEN TM_MASP_MAT_SUPP_REL.MASP_PERC IS NULL
                       OR TM_MASP_MAT_SUPP_REL.MASP_PERC = 0 THEN 0
                  ELSE 1
              END) AS FISI_FL_VENDOR_ACTIVE,
             ACTUAL_ISIR.ISIR_CD_REVISION_LEVEL AS FISI_CD_REVISION_LEVEL,
             PURCHASING_PART_NBR.SCLN_CD_PURCH_ORD_NBR AS FISI_CD_PURCH_ORD_NBR,
             PURCHASING_PART_NBR.SCLN_CD_PURCH_ORD_LN AS FISI_CD_PURCH_ORD_LN,
             PURCHASING_PART_NBR.SCLN_CD_SEQ_ID AS FISI_CD_SEQ_ID,
             TO_NUMBER (TO_CHAR (PURCHASING_PART_NBR.SCLN_DT_REQ_DLVR_DT, 'J')) AS FISI_ID_TIME_REQ_DLVR_DT,
             COMPONENT_USE.FIRST_FLD_ORDER AS FISI_CD_FIRST_PROD_ORD,
             COMPONENT_USE.FIRST_FLD_EFF_ORDER AS FISI_CD_FIRST_EFF_ORD,
             COMPONENT_USE.FIRST_FLD_REQ_DATE AS FISI_DT_FIRST_CONFIRM_DT,
             COMPONENT_USE.FIRST_FLD_SERIE AS FISI_CD_FIRST_SERIE,
             MIN (FIRST_ISIR.ISIR_ID_ISIR_MASTER) KEEP (DENSE_RANK FIRST
                                                        ORDER BY FIRST_ISIR.ISIR_ID_ISIR_MASTER) OVER (PARTITION BY FIRST_ISIR.ISIR_CD_PART_NBR) AS FISI_MIN_ISIR_ID_ISIR_MASTER,
                                                                                                      FIRST_ISIR.ISIR_ID_ISIR_MASTER AS FISI_ISIR_ID_ISIR_MASTER,
                                                                                                      FIRST_ISIR.ISIR_ID_ICMD_ISIR_CD AS FISI_ID_ISIR_FIRST_ISIR,
                                                                                                      FIRST_ISIR.ISIR_CD_ISIR_CD AS FISI_CD_FIRST_ISIR_CD,
                                                                                                      FIRST_ISIR.ISIR_ID_VEND_SUPPL_CD AS FISI_ID_VEND_FIRST_VENDOR_CD,
                                                                                                      FIRST_ISIR.ISIR_CD_SUPPL_CD AS FISI_CD_FIRST_VENDOR_CD,
                                                                                                      FIRST_ISIR.ISIR_CD_REVISION_LEVEL AS FISI_CD_FIRST_REVISION_LEVEL,
                                                                                                      ACTUAL_ISIR.ISIR_CD_SOURCE_SYSTEM AS FISI_CD_SOURCE_SYSTEM
      FROM
        (SELECT FIRST_FLD_PLANT,
                FIRST_FLD_ID_REQ_DATE,
                FIRST_FLD_REQ_DATE,
                FIRST_FLD_ORDER,
                FIRST_FLD_EFF_ORDER,
                FIRST_FLD_SERIE,
                FIRST_FLD_TYPE_ORDER,
                FIRST_FLD_ID_MAMD_COMP,
                FIRST_FLD_CD_COMP,
                FIRST_FLD_ID_COMP,
                FIRST_FLD_SOURCE_SYSTEM,
                (CASE
                     WHEN NEXT_FLD_ID_REQ_DATE IS NULL THEN LAST_FLD_PLANT
                     ELSE NEXT_FLD_PLANT
                 END) AS ACTUAL_FLD_PLANT,
                (CASE
                     WHEN NEXT_FLD_ID_REQ_DATE IS NULL THEN LAST_FLD_ID_REQ_DATE
                     ELSE NEXT_FLD_ID_REQ_DATE
                 END) AS ACTUAL_FLD_ID_REQ_DATE,
                (CASE
                     WHEN NEXT_FLD_ID_REQ_DATE IS NULL THEN LAST_FLD_REQ_DATE
                     ELSE NEXT_FLD_REQ_DATE
                 END) AS ACTUAL_FLD_REQ_DATE,
                (CASE
                     WHEN NEXT_FLD_ID_REQ_DATE IS NULL THEN LAST_FLD_ORDER
                     ELSE NEXT_FLD_ORDER
                 END) AS ACTUAL_FLD_ORDER,
                (CASE
                     WHEN NEXT_FLD_ID_REQ_DATE IS NULL THEN LAST_FLD_EFF_ORDER
                     ELSE NEXT_FLD_EFF_ORDER
                 END) AS ACTUAL_FLD_EFF_ORDER,
                (CASE
                     WHEN NEXT_FLD_ID_REQ_DATE IS NULL THEN LAST_FLD_SERIE
                     ELSE NEXT_FLD_SERIE
                 END) AS ACTUAL_FLD_SERIE,
                (CASE
                     WHEN NEXT_FLD_ID_REQ_DATE IS NULL THEN LAST_FLD_TYPE_ORDER
                     ELSE NEXT_FLD_TYPE_ORDER
                 END) AS ACTUAL_FLD_TYPE_ORDER,
                (CASE
                     WHEN NEXT_FLD_ID_REQ_DATE IS NULL THEN LAST_FLD_ID_MAMD_COMP
                     ELSE NEXT_FLD_ID_MAMD_COMP
                 END) AS ACTUAL_FLD_ID_MAMD_COMP,
                (CASE
                     WHEN NEXT_FLD_ID_REQ_DATE IS NULL THEN LAST_FLD_CD_COMP
                     ELSE NEXT_FLD_CD_COMP
                 END) AS ACTUAL_FLD_CD_COMP,
                (CASE
                     WHEN NEXT_FLD_ID_REQ_DATE IS NULL THEN LAST_FLD_ID_COMP
                     ELSE NEXT_FLD_ID_COMP
                 END) AS ACTUAL_FLD_ID_COMP,
                (CASE
                     WHEN NEXT_FLD_ID_REQ_DATE IS NULL THEN LAST_FLD_SOURCE_SYSTEM
                     ELSE NEXT_FLD_SOURCE_SYSTEM
                 END) AS ACTUAL_FLD_SOURCE_SYSTEM,
                (CASE
                     WHEN NEXT_FLD_ID_REQ_DATE IS NULL THEN 1
                     ELSE 0
                 END) AS FLD_FL_PAST_ORD
         FROM
           (SELECT FIRST_FLD_PLANT,
                   FIRST_FLD_ID_REQ_DATE,
                   FIRST_FLD_REQ_DATE,
                   FIRST_FLD_ORDER,
                   FIRST_FLD_EFF_ORDER,
                   FIRST_FLD_SERIE,
                   FIRST_FLD_TYPE_ORDER,
                   FIRST_FLD_ID_MAMD_COMP,
                   FIRST_FLD_CD_COMP,
                   FIRST_FLD_ID_COMP,
                   FIRST_FLD_SOURCE_SYSTEM,
                   LAST_FLD_PLANT,
                   LAST_FLD_ID_REQ_DATE,
                   LAST_FLD_REQ_DATE,
                   LAST_FLD_ORDER,
                   LAST_FLD_EFF_ORDER,
                   LAST_FLD_SERIE,
                   LAST_FLD_TYPE_ORDER,
                   LAST_FLD_ID_MAMD_COMP,
                   LAST_FLD_CD_COMP,
                   LAST_FLD_ID_COMP,
                   LAST_FLD_SOURCE_SYSTEM,
                   NEXT_FLD_PLANT,
                   NEXT_FLD_ID_REQ_DATE,
                   NEXT_FLD_REQ_DATE,
                   NEXT_FLD_ORDER,
                   NEXT_FLD_EFF_ORDER,
                   NEXT_FLD_SERIE,
                   NEXT_FLD_TYPE_ORDER,
                   NEXT_FLD_ID_MAMD_COMP,
                   NEXT_FLD_CD_COMP,
                   NEXT_FLD_ID_COMP,
                   NEXT_FLD_SOURCE_SYSTEM
            FROM
              (SELECT FIRST_FLD_PLANT,
                      FIRST_FLD_ID_REQ_DATE,
                      FIRST_FLD_REQ_DATE,
                      FIRST_FLD_ORDER,
                      FIRST_FLD_EFF_ORDER,
                      FIRST_FLD_SERIE,
                      FIRST_FLD_TYPE_ORDER,
                      FIRST_FLD_ID_MAMD_COMP,
                      FIRST_FLD_CD_COMP,
                      FIRST_FLD_ID_COMP,
                      FIRST_FLD_SOURCE_SYSTEM,
                      LAST_FLD_PLANT,
                      LAST_FLD_ID_REQ_DATE,
                      LAST_FLD_REQ_DATE,
                      LAST_FLD_ORDER,
                      LAST_FLD_EFF_ORDER,
                      LAST_FLD_SERIE,
                      LAST_FLD_TYPE_ORDER,
                      LAST_FLD_ID_MAMD_COMP,
                      LAST_FLD_CD_COMP,
                      LAST_FLD_ID_COMP,
                      LAST_FLD_SOURCE_SYSTEM
               FROM
                 (SELECT FIRST_FLD_PLANT,
                         TO_NUMBER (TO_CHAR (FIRST_FLD_REQ_DATE, 'J')) AS FIRST_FLD_ID_REQ_DATE,
                         FIRST_FLD_REQ_DATE,
                         FIRST_FLD_ORDER,
                         FIRST_FLD_EFF_ORDER,
                         FIRST_FLD_SERIE,
                         FIRST_FLD_TYPE_ORDER,
                         FIRST_FLD_ID_MAMD_COMP,
                         FIRST_FLD_CD_COMP,
                         FIRST_FLD_ID_COMP,
                         FIRST_FLD_SOURCE_SYSTEM,
                         ROW_NUMBER () OVER (PARTITION BY FIRST_FLD_ID_MAMD_COMP
                                             ORDER BY FIRST_FLD_REQ_DATE ASC) AS FIRST_COMP_OCC
                  FROM
                    (SELECT PROR_CD_PLANT_CD AS FIRST_FLD_PLANT,
                            PROP_DT_SCHED_STR_OP_DT AS FIRST_FLD_REQ_DATE,
                            PROP_CD_PROD_ORD AS FIRST_FLD_ORDER,
                            PROP_CD_EFF_ORD AS FIRST_FLD_EFF_ORDER,
                            PROR_CD_SERIE AS FIRST_FLD_SERIE,
                            '0' AS FIRST_FLD_TYPE_ORDER,
                            PRCO_ID_MAMD_COMP AS FIRST_FLD_ID_MAMD_COMP,
                            PRCO_CD_COMP AS FIRST_FLD_CD_COMP,
                            PRCO_ID_MAMD_COMP AS FIRST_FLD_ID_COMP,
                            PROR_CD_SOURCE_SYSTEM AS FIRST_FLD_SOURCE_SYSTEM
                     FROM DDWH01_DW_MA.TT_PROR_PROD_ORD,
                          DDWH01_DW_MA.TD_PROP_PROD_ORD_OP,
                          DDWH01_DW_MA.TD_PRCO_PROD_ORD_COMP
                     WHERE PROR_CD_PLANT_CD = P_ELT_CD_PLANT
                       AND PROP_CD_PLANT_CD = PROR_CD_PLANT_CD
                       AND PRCO_CD_PLANT_CD = PROP_CD_PLANT_CD
                       AND PROP_ID_PROR_PROD_ORD = PROR_ID_PROD_ORD
                       AND PRCO_ID_PROP_PROD_ORD_OP = PROP_ID_PROD_ORD_OP
                       AND PROP_DT_SCHED_STR_OP_DT <= TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD')
                       AND PRCO_FL_COMP_CAT = 'L'
                       AND PROR_FL_LOGICAL_STATUS = '1'
                       AND PROP_FL_LOGICAL_STATUS = '1'
                       AND PRCO_FL_LOGICAL_STATUS = '1'
                       AND PROR_FL_CLOSE_MARK = '1'
                       AND PROP_FL_CLOSE_MARK = '1' )) FIRST ,
                 (SELECT LAST_FLD_PLANT,
                         LAST_FLD_ID_REQ_DATE,
                         LAST_FLD_REQ_DATE,
                         LAST_FLD_ORDER,
                         LAST_FLD_EFF_ORDER,
                         LAST_FLD_SERIE,
                         LAST_FLD_TYPE_ORDER,
                         LAST_FLD_ID_MAMD_COMP,
                         LAST_FLD_CD_COMP,
                         LAST_FLD_ID_COMP,
                         LAST_COMP_OCC,
                         LAST_FLD_SOURCE_SYSTEM
                  FROM
                    (SELECT LAST_FLD_PLANT,
                            LAST_FLD_ID_REQ_DATE,
                            LAST_FLD_REQ_DATE,
                            LAST_FLD_ORDER,
                            LAST_FLD_EFF_ORDER,
                            LAST_FLD_SERIE,
                            LAST_FLD_TYPE_ORDER,
                            LAST_FLD_ID_MAMD_COMP,
                            LAST_FLD_CD_COMP,
                            LAST_FLD_ID_COMP,
                            LAST_COMP_OCC,
                            LAST_FLD_SOURCE_SYSTEM,
                            MIN (LAST_COMP_OCC) OVER (PARTITION BY LAST_FLD_ID_MAMD_COMP) MIN_LAST_COMP_OCC
                     FROM
                       (SELECT LAST_FLD_PLANT,
                               TO_NUMBER (TO_CHAR (LAST_FLD_REQ_DATE, 'J')) AS LAST_FLD_ID_REQ_DATE,
                               LAST_FLD_REQ_DATE,
                               LAST_FLD_ORDER,
                               LAST_FLD_EFF_ORDER,
                               LAST_FLD_SERIE,
                               LAST_FLD_TYPE_ORDER,
                               LAST_FLD_ID_MAMD_COMP,
                               LAST_FLD_CD_COMP,
                               LAST_FLD_ID_COMP,
                               LAST_FLD_SOURCE_SYSTEM,
                               ROW_NUMBER () OVER (PARTITION BY LAST_FLD_ID_MAMD_COMP
                                                   ORDER BY LAST_FLD_REQ_DATE DESC) AS LAST_COMP_OCC
                        FROM
                          (SELECT PROR_CD_PLANT_CD AS LAST_FLD_PLANT,
                                  PROP_DT_SCHED_STR_OP_DT AS LAST_FLD_REQ_DATE,
                                  PROP_CD_PROD_ORD AS LAST_FLD_ORDER,
                                  PROP_CD_EFF_ORD AS LAST_FLD_EFF_ORDER,
                                  PROR_CD_SERIE AS LAST_FLD_SERIE,
                                  '0' AS LAST_FLD_TYPE_ORDER,
                                  PRCO_ID_MAMD_COMP AS LAST_FLD_ID_MAMD_COMP,
                                  PRCO_CD_COMP AS LAST_FLD_CD_COMP,
                                  PRCO_ID_MAMD_COMP AS LAST_FLD_ID_COMP,
                                  PROR_CD_SOURCE_SYSTEM AS LAST_FLD_SOURCE_SYSTEM
                           FROM DDWH01_DW_MA.TT_PROR_PROD_ORD,
                                DDWH01_DW_MA.TD_PROP_PROD_ORD_OP,
                                DDWH01_DW_MA.TD_PRCO_PROD_ORD_COMP
                           WHERE PROR_CD_PLANT_CD = P_ELT_CD_PLANT
                             AND PROP_CD_PLANT_CD = PROR_CD_PLANT_CD
                             AND PRCO_CD_PLANT_CD = PROP_CD_PLANT_CD
                             AND PROP_ID_PROR_PROD_ORD = PROR_ID_PROD_ORD
                             AND PRCO_ID_PROP_PROD_ORD_OP = PROP_ID_PROD_ORD_OP
                             AND PROP_DT_SCHED_STR_OP_DT BETWEEN (ADD_MONTHS (TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'), -12)) AND (TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'))
                             AND PRCO_FL_COMP_CAT = 'L'
                             AND PROR_FL_LOGICAL_STATUS = '1'
                             AND PROP_FL_LOGICAL_STATUS = '1'
                             AND PRCO_FL_LOGICAL_STATUS = '1'
                             AND PROR_FL_CLOSE_MARK = '1'
                             AND PROP_FL_CLOSE_MARK = '1' )))
                  WHERE LAST_COMP_OCC = MIN_LAST_COMP_OCC ) LAST
               WHERE 1 = 1
                 AND FIRST.FIRST_FLD_CD_COMP = LAST.LAST_FLD_CD_COMP (+)
                 AND FIRST_COMP_OCC = 1 ) PAST
            FULL OUTER JOIN
              (SELECT NEXT_FLD_PLANT,
                      NEXT_FLD_ID_REQ_DATE,
                      NEXT_FLD_REQ_DATE,
                      NEXT_FLD_ORDER,
                      NEXT_FLD_EFF_ORDER,
                      NEXT_FLD_SERIE,
                      NEXT_FLD_TYPE_ORDER,
                      NEXT_FLD_ID_MAMD_COMP,
                      NEXT_FLD_CD_COMP,
                      NEXT_FLD_ID_COMP,
                      NEXT_FLD_SOURCE_SYSTEM
               FROM
                 (SELECT NEXT_FLD_PLANT,
                         TO_NUMBER (TO_CHAR (NEXT_FLD_REQ_DATE, 'J')) AS NEXT_FLD_ID_REQ_DATE,
                         NEXT_FLD_REQ_DATE,
                         NEXT_FLD_ORDER,
                         NEXT_FLD_EFF_ORDER,
                         NEXT_FLD_SERIE,
                         NEXT_FLD_TYPE_ORDER,
                         NEXT_FLD_ID_MAMD_COMP,
                         NEXT_FLD_CD_COMP,
                         NEXT_FLD_ID_COMP,
                         NEXT_FLD_SOURCE_SYSTEM,
                         ROW_NUMBER () OVER (PARTITION BY NEXT_FLD_ID_MAMD_COMP
                                             ORDER BY NEXT_FLD_REQ_DATE ASC , NEXT_FLD_TYPE_ORDER ASC) AS NEXT_COMP_OCC
                  FROM
                    (SELECT PROR_CD_PLANT_CD AS NEXT_FLD_PLANT,
                            PROP_DT_SCHED_STR_OP_DT AS NEXT_FLD_REQ_DATE,
                            PROP_CD_PROD_ORD AS NEXT_FLD_ORDER,
                            PROP_CD_EFF_ORD AS NEXT_FLD_EFF_ORDER,
                            PROR_CD_SERIE AS NEXT_FLD_SERIE,
                            '0' AS NEXT_FLD_TYPE_ORDER,
                            PRCO_ID_MAMD_COMP AS NEXT_FLD_ID_MAMD_COMP,
                            PRCO_CD_COMP AS NEXT_FLD_CD_COMP,
                            PRCO_ID_MAMD_COMP AS NEXT_FLD_ID_COMP,
                            PROR_CD_SOURCE_SYSTEM AS NEXT_FLD_SOURCE_SYSTEM
                     FROM DDWH01_DW_MA.TT_PROR_PROD_ORD,
                          DDWH01_DW_MA.TD_PROP_PROD_ORD_OP,
                          DDWH01_DW_MA.TD_PRCO_PROD_ORD_COMP
                     WHERE PROR_CD_PLANT_CD = P_ELT_CD_PLANT
                       AND PROP_CD_PLANT_CD = PROR_CD_PLANT_CD
                       AND PRCO_CD_PLANT_CD = PROP_CD_PLANT_CD
                       AND PROP_ID_PROR_PROD_ORD = PROR_ID_PROD_ORD
                       AND PRCO_ID_PROP_PROD_ORD_OP = PROP_ID_PROD_ORD_OP
                       AND PROP_DT_SCHED_STR_OP_DT > TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD')
                       AND PRCO_FL_COMP_CAT = 'L'
                       AND PROR_FL_LOGICAL_STATUS = '1'
                       AND PROP_FL_LOGICAL_STATUS = '1'
                       AND PRCO_FL_LOGICAL_STATUS = '1'
                       AND PROR_FL_CLOSE_MARK = '0'
                       AND PROP_FL_CLOSE_MARK = '0'
                     UNION ALL SELECT PLOR_CD_PLANT_CD AS NEXT_FLD_PLANT,
                                      PLOP_DT_STR_PLN_OP_DT AS NEXT_FLD_REQ_DATE,
                                      ' ' AS NEXT_FLD_ORDER,
                                      PLOP_CD_ORD_ID AS NEXT_FLD_EFF_ORDER,
                                      PLOR_CD_SERIE AS NEXT_FLD_SERIE,
                                      '1' AS NEXT_FLD_TYPE_ORDER,
                                      PLCO_ID_MAMD_COMP AS NEXT_FLD_ID_MAMD_COMP,
                                      PLCO_CD_COMP AS NEXT_FLD_CD_COMP,
                                      PLCO_ID_MAMD_COMP AS NEXT_FLD_ID_COMP,
                                      PLOR_CD_SOURCE_SYSTEM AS NEXT_FLD_SOURCE_SYSTEM
                     FROM DDWH01_DW_MA.TT_PLOR_PLND_ORD,
                          DDWH01_DW_MA.TD_PLOP_PLND_ORD_OP,
                          DDWH01_DW_MA.TD_PLCO_PLND_ORD_COMP
                     WHERE PLOR_CD_PLANT_CD = P_ELT_CD_PLANT
                       AND PLOP_CD_PLANT_CD = PLOR_CD_PLANT_CD
                       AND PLCO_CD_PLANT_CD = PLOP_CD_PLANT_CD
                       AND PLOP_ID_PLOR_PLND_ORD = PLOR_ID_PLND_ORD
                       AND PLCO_ID_PLOP_PLND_ORD_OP = PLOP_ID_PLND_ORD_OP
                       AND PLOP_DT_STR_PLN_OP_DT > TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD')
                       AND PLCO_FL_COMP_CAT = 'L' ))
               WHERE NEXT_COMP_OCC = 1 ) FUTURE ON FUTURE.NEXT_FLD_CD_COMP = PAST.FIRST_FLD_CD_COMP)) COMPONENT_USE,

        (SELECT *
         FROM DDWH01_DW_MA.TM_ISIR_ISIR_MASTER
         WHERE ISIR_CD_PLANT_CD = P_ELT_CD_PLANT
           AND TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') BETWEEN ISIR_DT_VALID_STR_DT AND ISIR_DT_VALID_END_DT ) ACTUAL_ISIR,

        (SELECT *
         FROM DDWH01_DW_MA.TM_ISIR_ISIR_MASTER
         WHERE ISIR_CD_PLANT_CD = P_ELT_CD_PLANT ) FIRST_ISIR,

        (SELECT MASP_CD_PART_NBR,
                MASP_CD_SUPPL_CD,
                MAX (MASP_NR_QUOTE_PERC) MASP_PERC
         FROM DDWH01_DW_MA.TM_MASP_MAT_SUPP_REL
         WHERE MASP_CD_PLANT_CD = P_ELT_CD_PLANT
           AND MASP_FL_LOGICAL_DELETION = '0'
         GROUP BY MASP_CD_PART_NBR,
                  MASP_CD_SUPPL_CD) TM_MASP_MAT_SUPP_REL,

        (SELECT ROW_NUMBER () OVER (PARTITION BY POLN_CD_PART_NBR
                                    ORDER BY SCLN_DT_REQ_DLVR_DT,
                                             SCLN_CD_PURCH_ORD_NBR,
                                             SCLN_CD_PURCH_ORD_LN,
                                             SCLN_CD_SEQ_ID) AS PURCHASING_ROW_NUM,
                                   SCLN_CD_PURCH_ORD_NBR,
                                   SCLN_CD_PURCH_ORD_LN,
                                   POLN_CD_PART_NBR,
                                   SCLN_CD_SEQ_ID,
                                   SCLN_DT_REQ_DLVR_DT,
                                   TO_NUMBER (TO_CHAR (SCLN_DT_REQ_DLVR_DT, 'J')) AS SCLN_DT_REQ_DLVR_DT_J
         FROM DDWH01_DW_MA.TT_PORD_PURCH_ORD,
              DDWH01_DW_MA.TD_POLN_PURCH_ORD_LN,
              DDWH01_DW_MA.TD_SCLN_SCHED_LN
         WHERE PORD_CD_PLANT_CD = P_ELT_CD_PLANT
           AND POLN_CD_PLANT_CD = PORD_CD_PLANT_CD
           AND SCLN_CD_PLANT_CD = POLN_CD_PLANT_CD
           AND POLN_ID_PORD_PURCH_ORD = PORD_ID_PURCH_ORD
           AND SCLN_ID_POLN_PURCH_ORD = POLN_ID_PURCH_ORD_LN
           AND SCLN_FL_CLOSE_MARK = 0
           AND PORD_FL_LOGICAL_STATUS = '1'
           AND POLN_FL_LOGICAL_STATUS = '1'
           AND SCLN_FL_LOGICAL_STATUS = '1' ) PURCHASING_PART_NBR
      WHERE 1 = 1
        AND COMPONENT_USE.ACTUAL_FLD_CD_COMP (+) = ACTUAL_ISIR.ISIR_CD_PART_NBR
        AND ACTUAL_ISIR.ISIR_CD_PART_NBR = TM_MASP_MAT_SUPP_REL.MASP_CD_PART_NBR (+)
        AND ACTUAL_ISIR.ISIR_CD_SUPPL_CD = TM_MASP_MAT_SUPP_REL.MASP_CD_SUPPL_CD (+)
        AND PURCHASING_PART_NBR.PURCHASING_ROW_NUM (+) = 1
        AND PURCHASING_PART_NBR.POLN_CD_PART_NBR (+) = COMPONENT_USE.FIRST_FLD_CD_COMP
        AND COMPONENT_USE.FIRST_FLD_CD_COMP = FIRST_ISIR.ISIR_CD_PART_NBR (+)
        AND COMPONENT_USE.FIRST_FLD_REQ_DATE BETWEEN FIRST_ISIR.ISIR_DT_VALID_STR_DT (+) AND FIRST_ISIR.ISIR_DT_VALID_END_DT (+) )
   WHERE 1 = 1
     AND (FISI_ISIR_ID_ISIR_MASTER IS NULL
          OR (FISI_ISIR_ID_ISIR_MASTER IS NOT NULL
              AND FISI_ISIR_ID_ISIR_MASTER = FISI_MIN_ISIR_ID_ISIR_MASTER)) ) QRY