INSERT INTO DDWH02_DM_MA.TFCT_FSDT_FORESEEN_STOCKOUT_DT TRG (FSDT_CD_PLANT_CD, FSDT_ID_FSDT, FSDT_CD_PROD_ORD, FSDT_CD_EFF_ORD, FSDT_CD_OP, FSDT_ID_MTRL_PART_NBR, FSDT_CD_PART_NBR, FSDT_ID_PLST, FSDT_CD_WCTR_CD, FSDT_ID_TIME_SCHED_STR_OP_DT, FSDT_ID_MTRL_COMP, FSDT_CD_COMP, FSDT_QT_QTY, FSDT_CD_REF_TP, FSDT_CD_PURCH_ORD, FSDT_CD_PURCH_ORD_LN, FSDT_ID_VEND_SUPPL_CD, FSDT_CD_SUPPL_CD, FSDT_CD_SEQ_ID, FSDT_CD_REF_PROD_ORD, FSDT_CD_REF_EFF_ORD, FSDT_CD_REF_OP, FSDT_ID_PLST_REF_WCTR_CD, FSDT_CD_REF_WCTR_CD, FSDT_ID_TIME_REQ_DT, FSDT_QT_REQ_QTY, FSDT_QT_CUM_RCVD_QTY, FSDT_QT_SCRAP_QTY, FSDT_QT_REM_QTY, FSDT_ID_TIME_CONFIRM_DT, FSDT_ID_BATCH_ID, FSDT_CD_SOURCE_SYSTEM, FSDT_CD_OPERATOR_CODE, FSDT_DT_INS_ROW, FSDT_DT_UPD_ROW)
SELECT QRY.FSDT_CD_PLANT_CD,
       DDWH02_DM_MA.SEQ_FSDT_TFCT01.NEXTVAL,
       QRY.FSDT_CD_PROD_ORD,
       QRY.FSDT_CD_EFF_ORD,
       QRY.FSDT_CD_OP,
       QRY.FSDT_ID_MTRL_PART_NBR,
       QRY.FSDT_CD_PART_NBR,
       QRY.FSDT_ID_PLST,
       QRY.FSDT_CD_WCTR_CD,
       QRY.FSDT_ID_TIME_SCHED_STR_OP_DT,
       QRY.FSDT_ID_MTRL_COMP,
       QRY.FSDT_CD_COMP,
       QRY.FSDT_QT_QTY,
       QRY.FSDT_CD_REF_TP,
       QRY.FSDT_CD_PURCH_ORD,
       QRY.FSDT_CD_PURCH_ORD_LN,
       QRY.FSDT_ID_VEND_SUPPL_CD,
       QRY.FSDT_CD_SUPPL_CD,
       QRY.FSDT_CD_SEQ_ID,
       QRY.FSDT_CD_REF_PROD_ORD,
       QRY.FSDT_CD_REF_EFF_ORD,
       QRY.FSDT_CD_REF_OP,
       QRY.FSDT_ID_PLST_REF_WCTR_CD,
       QRY.FSDT_CD_REF_WCTR_CD,
       QRY.FSDT_ID_TIME_REQ_DT,
       QRY.FSDT_QT_REQ_QTY,
       QRY.FSDT_QT_CUM_RCVD_QTY,
       QRY.FSDT_QT_SCRAP_QTY,
       QRY.FSDT_QT_REM_QTY,
       QRY.FSDT_ID_TIME_CONFIRM_DT,
       QRY.FSDT_ID_BATCH_ID,
       QRY.FSDT_CD_SOURCE_SYSTEM,
       'ETL',
       SYSDATE,
       SYSDATE
FROM
  (WITH PRE_PRODUCTION_ORD AS
     (SELECT PROP_ID_PROD_ORD_OP,
             PROP_CD_PROD_ORD,
             PROR_CD_EFF_ORD,
             PROP_CD_OP,
             PROR_ID_MAMD_PART_NBR,
             PROR_CD_PART_NBR,
             PROP_ID_PLMD_WCTR_CD,
             PROP_CD_WCTR_CD,
             PROP_DT_SCHED_STR_OP_DT,
             TO_NUMBER (TO_CHAR (PROP_DT_SCHED_STR_OP_DT, 'J')) AS PROP_DT_SCHED_STR_OP_DT_J,
             PRCO_ID_MAMD_COMP,
             PRCO_CD_COMP,
             PRCO_QT_QTY,
             PROR_CD_PROD_ORD,
             PROR_QT_ORD_QTY
      FROM DDWH01_DW_MA.TT_PROR_PROD_ORD,
           DDWH01_DW_MA.TD_PROP_PROD_ORD_OP,
           DDWH01_DW_MA.TD_PRCO_PROD_ORD_COMP,
           DDWH01_DW_MA.TM_PLMD_PLANT_MASTER,
           DDWH01_DW_MA.TM_MBUD_MBU_MASTER
      WHERE PROR_CD_PLANT_CD = P_ELT_CD_PLANT
        AND PROP_CD_PLANT_CD = PROR_CD_PLANT_CD
        AND PRCO_CD_PLANT_CD = PROP_CD_PLANT_CD
        AND PLMD_CD_PLANT_CD = PRCO_CD_PLANT_CD
        AND MBUD_CD_PLANT_CD = PLMD_CD_PLANT_CD
        AND PROP_ID_PROR_PROD_ORD = PROR_ID_PROD_ORD
        AND PRCO_ID_PROP_PROD_ORD_OP = PROP_ID_PROD_ORD_OP
        AND PROR_FL_CLOSE_MARK = '0'
        AND PROP_FL_CLOSE_MARK = '0'
        AND PROR_FL_LOGICAL_STATUS = '1'
        AND PROP_FL_LOGICAL_STATUS = '1'
        AND PRCO_FL_LOGICAL_STATUS = '1'
        AND PROP_CD_WCTR_CD = PLMD_CD_WCTR_CD
        AND PLMD_CD_DEP = MBUD_CD_DEP_CD
        AND MBUD_CD_PROCESS = 'WELDING' ) SELECT FSDT_CD_PLANT_CD,
                                                 NULL FSDT_ID_FSDT,
                                                      FSDT_CD_PROD_ORD,
                                                      FSDT_CD_EFF_ORD,
                                                      FSDT_CD_OP,
                                                      FSDT_ID_MTRL_PART_NBR,
                                                      FSDT_CD_PART_NBR,
                                                      FSDT_ID_PLST,
                                                      FSDT_CD_WCTR_CD,
                                                      NVL (FSDT_ID_TIME_SCHED_STR_OP_DT, -2) FSDT_ID_TIME_SCHED_STR_OP_DT,
                                                      FSDT_ID_MTRL_COMP,
                                                      FSDT_CD_COMP,
                                                      FSDT_QT_QTY,
                                                      FSDT_CD_REF_TP,
                                                      FSDT_CD_PURCH_ORD,
                                                      FSDT_CD_PURCH_ORD_LN,
                                                      NVL (FSDT_ID_VEND_SUPPL_CD, -2) FSDT_ID_VEND_SUPPL_CD,
                                                      FSDT_CD_SUPPL_CD,
                                                      FSDT_CD_SEQ_ID,
                                                      FSDT_CD_REF_PROD_ORD,
                                                      FSDT_CD_REF_EFF_ORD,
                                                      FSDT_CD_REF_OP,
                                                      NVL (FSDT_ID_PLST_REF_WCTR_CD, -2) FSDT_ID_PLST_REF_WCTR_CD,
                                                      FSDT_CD_REF_WCTR_CD,
                                                      NVL (FSDT_ID_TIME_REQ_DT, -2) FSDT_ID_TIME_REQ_DT,
                                                      FSDT_QT_REQ_QTY,
                                                      FSDT_QT_CUM_RCVD_QTY,
                                                      FSDT_QT_SCRAP_QTY,
                                                      FSDT_QT_REM_QTY,
                                                      NVL (FSDT_ID_TIME_CONFIRM_DT, -2) FSDT_ID_TIME_CONFIRM_DT,
                                                      NVL (P_ELT_ID_BATCH, N_ELT_ID_JOB_LOG) AS FSDT_ID_BATCH_ID,
                                                      FSDT_CD_SOURCE_SYSTEM
   FROM
     (SELECT FSDT_CD_PLANT_CD,
             FSDT_CD_PROD_ORD,
             FSDT_CD_EFF_ORD,
             FSDT_CD_OP,
             FSDT_ID_MTRL_PART_NBR,
             FSDT_CD_PART_NBR,
             FSDT_ID_PLST,
             FSDT_CD_WCTR_CD,
             FSDT_ID_TIME_SCHED_STR_OP_DT,
             FSDT_ID_MTRL_COMP,
             FSDT_CD_COMP,
             FSDT_QT_QTY,
             (CASE
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT < PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN 'BUY'
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT > PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN 'MAKE'
                  ELSE NULL
              END) AS FSDT_CD_REF_TP,
             (CASE
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT < PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT > PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN NULL
                  ELSE NULL
              END) AS FSDT_CD_PURCH_ORD,
             (CASE
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT < PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN PURCHASING_COMP.SCLN_CD_PURCH_ORD_LN
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT > PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN NULL
                  ELSE NULL
              END) AS FSDT_CD_PURCH_ORD_LN,
             (CASE
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT < PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN PURCHASING_COMP.PORD_ID_VEND_SUPPL_CD
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT > PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN NULL
                  ELSE NULL
              END) AS FSDT_ID_VEND_SUPPL_CD,
             (CASE
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT < PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN PURCHASING_COMP.PORD_CD_SUPPL_CD
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT > PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN NULL
                  ELSE NULL
              END) AS FSDT_CD_SUPPL_CD,
             (CASE
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT < PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN PURCHASING_COMP.SCLN_CD_SEQ_ID
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT > PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN NULL
                  ELSE NULL
              END) AS FSDT_CD_SEQ_ID,
             (CASE
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT < PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN NULL
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT > PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN PRODUCING_COMP.PROR_CD_PROD_ORD
                  ELSE NULL
              END) AS FSDT_CD_REF_PROD_ORD,
             (CASE
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT < PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN NULL
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT > PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN PRODUCING_COMP.PROR_CD_EFF_ORD
                  ELSE NULL
              END) AS FSDT_CD_REF_EFF_ORD,
             (CASE
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT < PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN NULL
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT > PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN PRODUCING_COMP.PROP_CD_OP
                  ELSE NULL
              END) AS FSDT_CD_REF_OP,
             (CASE
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT < PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN NULL
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT > PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN PRODUCING_COMP.PROP_ID_PLMD_WCTR_CD
                  ELSE NULL
              END) AS FSDT_ID_PLST_REF_WCTR_CD,
             (CASE
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT < PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN NULL
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT > PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN PRODUCING_COMP.PROP_CD_WCTR_CD
                  ELSE NULL
              END) AS FSDT_CD_REF_WCTR_CD,
             (CASE
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT < PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT_J
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT > PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT_J
                  ELSE NULL
              END) AS FSDT_ID_TIME_REQ_DT,
             (CASE
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT < PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN PURCHASING_COMP.SCLN_QT_REQ_QTY
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT > PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN PRODUCING_COMP.PROR_QT_ORD_QTY
                  ELSE NULL
              END) AS FSDT_QT_REQ_QTY,
             (CASE
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT < PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN PURCHASING_COMP.SCLN_QT_CUM_RCVD_QTY
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT > PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN PRODUCING_COMP.PROP_QT_CONFIRM_QTY
                  ELSE NULL
              END) AS FSDT_QT_CUM_RCVD_QTY,
             (CASE
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT < PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN NULL
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT > PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN PRODUCING_COMP.PROP_QT_SCRAP_QTY
                  ELSE NULL
              END) AS FSDT_QT_SCRAP_QTY,
             (CASE
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT < PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN (PURCHASING_COMP.SCLN_QT_REQ_QTY - PURCHASING_COMP.SCLN_QT_CUM_RCVD_QTY)
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT > PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN (PRODUCING_COMP.PROR_QT_ORD_QTY - PRODUCING_COMP.PROP_QT_CONFIRM_QTY)
                  ELSE NULL
              END) AS FSDT_QT_REM_QTY,
             (CASE
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT < PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN PURCHASING_COMP.SCLN_DT_LAST_CONFIRM_DT_J
                  WHEN (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NULL
                        AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL)
                       OR (PURCHASING_COMP.SCLN_CD_PURCH_ORD_NBR IS NOT NULL
                           AND PRODUCING_COMP.PROR_CD_PROD_ORD IS NOT NULL
                           AND PURCHASING_COMP.SCLN_DT_REQ_DLVR_DT > PRODUCING_COMP.PROR_DT_SCHED_END_PROD_DT) THEN PRODUCING_COMP.PROP_DT_CONFIRM_DT_J
                  ELSE NULL
              END) AS FSDT_ID_TIME_CONFIRM_DT,
             FSDT_CD_SOURCE_SYSTEM
      FROM
        (SELECT TH_MSOD_MAT_STOCK_OUT_DT.MSOD_CD_PLANT_CD AS FSDT_CD_PLANT_CD,
                MAX (PRODUCTION_ORD.PROP_CD_PROD_ORD) KEEP (DENSE_RANK FIRST
                                                            ORDER BY PROP_DT_SCHED_STR_OP_DT, PROP_CD_PROD_ORD, PROP_CD_OP) AS FSDT_CD_PROD_ORD,
                    MAX (PRODUCTION_ORD.PROR_CD_EFF_ORD) KEEP (DENSE_RANK FIRST
                                                               ORDER BY PROP_DT_SCHED_STR_OP_DT, PROP_CD_PROD_ORD, PROP_CD_OP) AS FSDT_CD_EFF_ORD,
                        MAX (PRODUCTION_ORD.PROP_CD_OP) KEEP (DENSE_RANK FIRST
                                                              ORDER BY PROP_DT_SCHED_STR_OP_DT, PROP_CD_PROD_ORD, PROP_CD_OP) AS FSDT_CD_OP,
                            MAX (PRODUCTION_ORD.PROR_ID_MAMD_PART_NBR) KEEP (DENSE_RANK FIRST
                                                                             ORDER BY PROP_DT_SCHED_STR_OP_DT, PROP_CD_PROD_ORD, PROP_CD_OP) AS FSDT_ID_MTRL_PART_NBR,
                                MAX (PRODUCTION_ORD.PROR_CD_PART_NBR) KEEP (DENSE_RANK FIRST
                                                                            ORDER BY PROP_DT_SCHED_STR_OP_DT, PROP_CD_PROD_ORD, PROP_CD_OP) AS FSDT_CD_PART_NBR,
                                    MAX (PRODUCTION_ORD.PROP_ID_PLMD_WCTR_CD) KEEP (DENSE_RANK FIRST
                                                                                    ORDER BY PROP_DT_SCHED_STR_OP_DT, PROP_CD_PROD_ORD, PROP_CD_OP) AS FSDT_ID_PLST,
                                        MAX (PRODUCTION_ORD.PROP_CD_WCTR_CD) KEEP (DENSE_RANK FIRST
                                                                                   ORDER BY PROP_DT_SCHED_STR_OP_DT, PROP_CD_PROD_ORD, PROP_CD_OP) AS FSDT_CD_WCTR_CD,
                                            MAX (PRODUCTION_ORD.PROP_DT_SCHED_STR_OP_DT_J) KEEP (DENSE_RANK FIRST
                                                                                                 ORDER BY PROP_DT_SCHED_STR_OP_DT, PROP_CD_PROD_ORD, PROP_CD_OP) AS FSDT_ID_TIME_SCHED_STR_OP_DT,
                                                MAX (PRODUCTION_ORD.PRCO_ID_MAMD_COMP) KEEP (DENSE_RANK FIRST
                                                                                             ORDER BY PROP_DT_SCHED_STR_OP_DT, PROP_CD_PROD_ORD, PROP_CD_OP) AS FSDT_ID_MTRL_COMP,
                                                    MAX (PRODUCTION_ORD.PRCO_CD_COMP) KEEP (DENSE_RANK FIRST
                                                                                            ORDER BY PROP_DT_SCHED_STR_OP_DT, PROP_CD_PROD_ORD, PROP_CD_OP) AS FSDT_CD_COMP,
                                                        MAX (PRODUCTION_ORD.PRCO_QT_QTY) KEEP (DENSE_RANK FIRST
                                                                                               ORDER BY PROP_DT_SCHED_STR_OP_DT, PROP_CD_PROD_ORD, PROP_CD_OP) AS FSDT_QT_QTY,
                                                            TH_MSOD_MAT_STOCK_OUT_DT.MSOD_CD_SOURCE_SYSTEM AS FSDT_CD_SOURCE_SYSTEM
         FROM
           (SELECT MSOD_CD_PLANT_CD,
                   MSOD_ID_MAT_STOCK_OUT_DT,
                   MSOD_DT_MRP_PLAN_DT,
                   MSOD_ID_MAMD_PART_NBR,
                   MSOD_CD_PART_NBR,
                   MSOD_DT_MRP_SOD_DT,
                   MSOD_NR_REM_COV_DAYS,
                   MSOD_FL_ALREADY_SO,
                   MSOD_QT_SOQ_AT_SOD,
                   MSOD_QT_NEXT_REQ_QTY,
                   MSOD_QT_STK_QTY,
                   MSOD_ID_PROR_PROD_ORD,
                   MSOD_CD_PROD_ORD,
                   MSOD_CD_PLND_ORD,
                   MSOD_CD_SOURCE_SYSTEM
            FROM DDWH01_DW_MA.TH_MSOD_MAT_STOCK_OUT_DT
            WHERE MSOD_CD_PLANT_CD = P_ELT_CD_PLANT
              AND MSOD_DT_MRP_PLAN_DT =
                (SELECT MAX (MSOD_DT_MRP_PLAN_DT)
                 FROM DDWH01_DW_MA.TH_MSOD_MAT_STOCK_OUT_DT
                 WHERE MSOD_CD_PLANT_CD = P_ELT_CD_PLANT ) ) TH_MSOD_MAT_STOCK_OUT_DT,

           (SELECT *
            FROM PRE_PRODUCTION_ORD) PRODUCTION_ORD
         WHERE 1 = 1
           AND PRODUCTION_ORD.PRCO_CD_COMP = TH_MSOD_MAT_STOCK_OUT_DT.MSOD_CD_PART_NBR
           AND PRODUCTION_ORD.PROP_DT_SCHED_STR_OP_DT > TH_MSOD_MAT_STOCK_OUT_DT.MSOD_DT_MRP_SOD_DT
         GROUP BY TH_MSOD_MAT_STOCK_OUT_DT.MSOD_CD_PLANT_CD,
                  PRODUCTION_ORD.PRCO_CD_COMP,
                  TH_MSOD_MAT_STOCK_OUT_DT.MSOD_CD_SOURCE_SYSTEM) ,
        (SELECT (CASE
                     WHEN PRODUCING_COMP_NN_DT.PROP_CD_CTRL_KEY = 'YPP1' THEN NVL (PRODUCING_COMP_YN_DT.PROR_CD_PROD_ORD, PRODUCING_COMP_NN_DT.PROR_CD_PROD_ORD)
                     ELSE PRODUCING_COMP_NN_DT.PROR_CD_PROD_ORD
                 END) AS PROR_CD_PROD_ORD,
                (CASE
                     WHEN PRODUCING_COMP_NN_DT.PROP_CD_CTRL_KEY = 'YPP1' THEN NVL (PRODUCING_COMP_YN_DT.PROR_CD_EFF_ORD, PRODUCING_COMP_NN_DT.PROR_CD_EFF_ORD)
                     ELSE PRODUCING_COMP_NN_DT.PROR_CD_EFF_ORD
                 END) AS PROR_CD_EFF_ORD,
                (CASE
                     WHEN PRODUCING_COMP_NN_DT.PROP_CD_CTRL_KEY = 'YPP1' THEN NVL (PRODUCING_COMP_YN_DT.PROP_ID_PROR_PROD_ORD, PRODUCING_COMP_NN_DT.PROP_ID_PROR_PROD_ORD)
                     ELSE PRODUCING_COMP_NN_DT.PROP_ID_PROR_PROD_ORD
                 END) AS PROP_ID_PROR_PROD_ORD,
                (CASE
                     WHEN PRODUCING_COMP_NN_DT.PROP_CD_CTRL_KEY = 'YPP1' THEN NVL (PRODUCING_COMP_YN_DT.PROR_CD_PART_NBR, PRODUCING_COMP_NN_DT.PROR_CD_PART_NBR)
                     ELSE PRODUCING_COMP_NN_DT.PROR_CD_PART_NBR
                 END) AS PROR_CD_PART_NBR,
                (CASE
                     WHEN PRODUCING_COMP_NN_DT.PROP_CD_CTRL_KEY = 'YPP1' THEN NVL (PRODUCING_COMP_YN_DT.PROP_CD_OP, PRODUCING_COMP_NN_DT.PROP_CD_OP)
                     ELSE PRODUCING_COMP_NN_DT.PROP_CD_OP
                 END) AS PROP_CD_OP,
                (CASE
                     WHEN PRODUCING_COMP_NN_DT.PROP_CD_CTRL_KEY = 'YPP1' THEN NVL (PRODUCING_COMP_YN_DT.PROP_ID_PLMD_WCTR_CD, PRODUCING_COMP_NN_DT.PROP_ID_PLMD_WCTR_CD)
                     ELSE PRODUCING_COMP_NN_DT.PROP_ID_PLMD_WCTR_CD
                 END) AS PROP_ID_PLMD_WCTR_CD,
                (CASE
                     WHEN PRODUCING_COMP_NN_DT.PROP_CD_CTRL_KEY = 'YPP1' THEN NVL (PRODUCING_COMP_YN_DT.PROP_CD_WCTR_CD, PRODUCING_COMP_NN_DT.PROP_CD_WCTR_CD)
                     ELSE PRODUCING_COMP_NN_DT.PROP_CD_WCTR_CD
                 END) AS PROP_CD_WCTR_CD,
                (CASE
                     WHEN PRODUCING_COMP_NN_DT.PROP_CD_CTRL_KEY = 'YPP1' THEN NVL (PRODUCING_COMP_YN_DT.PROR_DT_SCHED_END_PROD_DT, PRODUCING_COMP_NN_DT.PROR_DT_SCHED_END_PROD_DT)
                     ELSE PRODUCING_COMP_NN_DT.PROR_DT_SCHED_END_PROD_DT
                 END) AS PROR_DT_SCHED_END_PROD_DT,
                (CASE
                     WHEN PRODUCING_COMP_NN_DT.PROP_CD_CTRL_KEY = 'YPP1' THEN NVL (PRODUCING_COMP_YN_DT.PROR_DT_SCHED_END_PROD_DT_J, PRODUCING_COMP_NN_DT.PROR_DT_SCHED_END_PROD_DT_J)
                     ELSE PRODUCING_COMP_NN_DT.PROR_DT_SCHED_END_PROD_DT_J
                 END) AS PROR_DT_SCHED_END_PROD_DT_J,
                (CASE
                     WHEN PRODUCING_COMP_NN_DT.PROP_CD_CTRL_KEY = 'YPP1' THEN NVL (PRODUCING_COMP_YN_DT.PROR_QT_ORD_QTY, PRODUCING_COMP_NN_DT.PROR_QT_ORD_QTY)
                     ELSE PRODUCING_COMP_NN_DT.PROR_QT_ORD_QTY
                 END) AS PROR_QT_ORD_QTY,
                (CASE
                     WHEN PRODUCING_COMP_NN_DT.PROP_CD_CTRL_KEY = 'YPP1' THEN NVL (PRODUCING_COMP_YN_DT.PROP_DT_CONFIRM_DT, PRODUCING_COMP_NN_DT.PROP_DT_CONFIRM_DT)
                     ELSE PRODUCING_COMP_NN_DT.PROP_DT_CONFIRM_DT
                 END) AS PROP_DT_CONFIRM_DT,
                (CASE
                     WHEN PRODUCING_COMP_NN_DT.PROP_CD_CTRL_KEY = 'YPP1' THEN NVL (PRODUCING_COMP_YN_DT.PROP_DT_CONFIRM_DT_J, PRODUCING_COMP_NN_DT.PROP_DT_CONFIRM_DT_J)
                     ELSE PRODUCING_COMP_NN_DT.PROP_DT_CONFIRM_DT_J
                 END) AS PROP_DT_CONFIRM_DT_J,
                (CASE
                     WHEN PRODUCING_COMP_NN_DT.PROP_CD_CTRL_KEY = 'YPP1' THEN NVL (PRODUCING_COMP_YN_DT.PROP_QT_CONFIRM_QTY, PRODUCING_COMP_NN_DT.PROP_QT_CONFIRM_QTY)
                     ELSE PRODUCING_COMP_NN_DT.PROP_QT_CONFIRM_QTY
                 END) AS PROP_QT_CONFIRM_QTY,
                (CASE
                     WHEN PRODUCING_COMP_NN_DT.PROP_CD_CTRL_KEY = 'YPP1' THEN NVL (PRODUCING_COMP_YN_DT.PROP_QT_SCRAP_QTY, PRODUCING_COMP_NN_DT.PROP_QT_SCRAP_QTY)
                     ELSE PRODUCING_COMP_NN_DT.PROP_QT_SCRAP_QTY
                 END) AS PROP_QT_SCRAP_QTY,
                (CASE
                     WHEN PRODUCING_COMP_NN_DT.PROP_CD_CTRL_KEY = 'YPP1' THEN NVL (PRODUCING_COMP_YN_DT.PROP_CD_CTRL_KEY, PRODUCING_COMP_NN_DT.PROP_CD_CTRL_KEY)
                     ELSE PRODUCING_COMP_NN_DT.PROP_CD_CTRL_KEY
                 END) AS PROP_CD_CTRL_KEY
         FROM
           (SELECT ROW_NUMBER () OVER (PARTITION BY PROR_CD_PART_NBR
                                       ORDER BY PROR_DT_SCHED_END_PROD_DT,
                                                PROR_CD_PROD_ORD,
                                                PROP_DT_CONFIRM_DT DESC , PROP_CD_OP DESC) AS PRODUCING_ROW_NUM,
                                      PROR_CD_PROD_ORD,
                                      PROR_CD_EFF_ORD,
                                      PROP_ID_PROR_PROD_ORD,
                                      PROR_CD_PART_NBR,
                                      PROP_CD_OP,
                                      PROP_ID_PLMD_WCTR_CD,
                                      PROP_CD_WCTR_CD,
                                      PROR_DT_SCHED_END_PROD_DT,
                                      TO_NUMBER (TO_CHAR (PROR_DT_SCHED_END_PROD_DT, 'J')) AS PROR_DT_SCHED_END_PROD_DT_J,
                                      PROR_QT_ORD_QTY,
                                      PROP_DT_CONFIRM_DT,
                                      TO_NUMBER (TO_CHAR (PROP_DT_CONFIRM_DT, 'J')) AS PROP_DT_CONFIRM_DT_J,
                                      PROP_QT_CONFIRM_QTY,
                                      PROP_QT_SCRAP_QTY,
                                      PROP_CD_CTRL_KEY
            FROM DDWH01_DW_MA.TT_PROR_PROD_ORD,
                 DDWH01_DW_MA.TD_PROP_PROD_ORD_OP
            WHERE PROR_CD_PLANT_CD = P_ELT_CD_PLANT
              AND PROP_CD_PLANT_CD = PROR_CD_PLANT_CD
              AND PROP_ID_PROR_PROD_ORD = PROR_ID_PROD_ORD
              AND PROR_FL_CLOSE_MARK = '0'
              AND PROP_FL_CLOSE_MARK = '0'
              AND PROR_FL_LOGICAL_STATUS = '1'
              AND PROP_FL_LOGICAL_STATUS = '1' ) PRODUCING_COMP_NN_DT,

           (SELECT ROW_NUMBER () OVER (PARTITION BY PROR_CD_PART_NBR
                                       ORDER BY PROR_DT_SCHED_END_PROD_DT,
                                                PROR_CD_PROD_ORD,
                                                PROP_CD_OP DESC) AS PRODUCING_ROW_NUM,
                                      PROR_CD_PROD_ORD,
                                      PROR_CD_EFF_ORD,
                                      PROP_ID_PROR_PROD_ORD,
                                      PROR_CD_PART_NBR,
                                      PROP_CD_OP,
                                      PROP_ID_PLMD_WCTR_CD,
                                      PROP_CD_WCTR_CD,
                                      PROR_DT_SCHED_END_PROD_DT,
                                      TO_NUMBER (TO_CHAR (PROR_DT_SCHED_END_PROD_DT, 'J')) AS PROR_DT_SCHED_END_PROD_DT_J,
                                      PROR_QT_ORD_QTY,
                                      PROP_DT_CONFIRM_DT,
                                      TO_NUMBER (TO_CHAR (PROP_DT_CONFIRM_DT, 'J')) AS PROP_DT_CONFIRM_DT_J,
                                      PROP_QT_CONFIRM_QTY,
                                      PROP_QT_SCRAP_QTY,
                                      PROP_CD_CTRL_KEY
            FROM DDWH01_DW_MA.TT_PROR_PROD_ORD,
                 DDWH01_DW_MA.TD_PROP_PROD_ORD_OP
            WHERE PROR_CD_PLANT_CD = P_ELT_CD_PLANT
              AND PROP_CD_PLANT_CD = PROR_CD_PLANT_CD
              AND PROP_ID_PROR_PROD_ORD = PROR_ID_PROD_ORD
              AND PROR_FL_CLOSE_MARK = '0'
              AND PROP_FL_CLOSE_MARK = '0'
              AND PROR_FL_LOGICAL_STATUS = '1'
              AND PROP_FL_LOGICAL_STATUS = '1'
              AND PROP_DT_CONFIRM_DT IS NULL
              AND NOT PROP_CD_CTRL_KEY = 'YPP1' ) PRODUCING_COMP_YN_DT
         WHERE 1=1
           AND PRODUCING_COMP_YN_DT.PRODUCING_ROW_NUM (+) = 1
           AND PRODUCING_COMP_NN_DT.PRODUCING_ROW_NUM (+) = 1
           AND PRODUCING_COMP_NN_DT.PROR_CD_PART_NBR = PRODUCING_COMP_YN_DT.PROR_CD_PART_NBR (+) ) PRODUCING_COMP,

        (SELECT ROW_NUMBER () OVER (PARTITION BY POLN_CD_PART_NBR
                                    ORDER BY SCLN_DT_REQ_DLVR_DT,
                                             SCLN_CD_PURCH_ORD_NBR,
                                             SCLN_CD_PURCH_ORD_LN,
                                             SCLN_CD_SEQ_ID) AS PURCHASING_ROW_NUM,
                                   SCLN_CD_PURCH_ORD_NBR,
                                   SCLN_CD_PURCH_ORD_LN,
                                   POLN_CD_PART_NBR,
                                   SCLN_CD_SEQ_ID,
                                   PORD_ID_VEND_SUPPL_CD,
                                   PORD_CD_SUPPL_CD,
                                   SCLN_DT_REQ_DLVR_DT,
                                   TO_NUMBER (TO_CHAR (SCLN_DT_REQ_DLVR_DT, 'J')) AS SCLN_DT_REQ_DLVR_DT_J,
                                   SCLN_DT_LAST_CONFIRM_DT,
                                   TO_NUMBER (TO_CHAR (SCLN_DT_LAST_CONFIRM_DT, 'J')) AS SCLN_DT_LAST_CONFIRM_DT_J,
                                   SCLN_QT_REQ_QTY,
                                   SCLN_QT_CUM_RCVD_QTY
         FROM DDWH01_DW_MA.TT_PORD_PURCH_ORD,
              DDWH01_DW_MA.TD_POLN_PURCH_ORD_LN,
              DDWH01_DW_MA.TD_SCLN_SCHED_LN
         WHERE PORD_CD_PLANT_CD = P_ELT_CD_PLANT
           AND POLN_CD_PLANT_CD = PORD_CD_PLANT_CD
           AND SCLN_CD_PLANT_CD = POLN_CD_PLANT_CD
           AND POLN_ID_PORD_PURCH_ORD = PORD_ID_PURCH_ORD
           AND SCLN_ID_POLN_PURCH_ORD = POLN_ID_PURCH_ORD_LN
           AND SCLN_FL_CLOSE_MARK = '0'
           AND PORD_FL_LOGICAL_STATUS = '1'
           AND POLN_FL_LOGICAL_STATUS = '1'
           AND SCLN_FL_LOGICAL_STATUS = '1' ) PURCHASING_COMP
      WHERE 1 = 1
        AND PURCHASING_COMP.PURCHASING_ROW_NUM (+) = 1
        AND FSDT_CD_COMP = PRODUCING_COMP.PROR_CD_PART_NBR (+)
        AND FSDT_CD_COMP = PURCHASING_COMP.POLN_CD_PART_NBR (+) )) QRY