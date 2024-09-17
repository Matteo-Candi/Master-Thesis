MERGE INTO DDWH02_DM_MA.TFCT_NECO_NESTING_CONSUMPTION TRG USING
  (SELECT NECO_CD_PLANT_CD,
          NECO_ID_PROC_LOT_RAW_MAT,
          NVL (NECO_ID_TIME_PROC_LOT_STR_DT, -2) AS NECO_ID_TIME_PROC_LOT_STR_DT,
          NVL (NECO_ID_TIME_PROC_LOT_END_DT, -2) AS NECO_ID_TIME_PROC_LOT_END_DT,
          NECO_ID_PLST_ACT_WCTR_CD,
          NECO_CD_ACT_WCTR_CD,
          NECO_CD_PROC_LOT,
          NECO_ID_MTRL_ACT_COMP,
          NECO_CD_ACT_COMP,
          NECO_QT_ACT_USAGE_QTY,
          NECO_CD_OP,
          NECO_ID_MTRL_PLND_COMP,
          NECO_CD_PLND_COMP,
          NECO_ID_MTRL_PART_NBR,
          NECO_CD_PART_NBR,
          NECO_QT_QTY_OK,
          NECO_QT_QTY_NOK,
          NECO_ID_PLST_WCTR_CD,
          NECO_CD_WCTR_CD,
          NECO_CD_PROD_ORD,
          NECO_QT_PLND_RAW_MATERIAL,
          NECO_QT_PLND_BASE_QTY,
          NECO_QT_PLND_UNIT_CONSUM,
          NECO_QT_PLND_UNIT_CONSUM * (NECO_QT_QTY_OK + NECO_QT_QTY_NOK) AS NECO_QT_PLND_TOTAL_CONSUM,
          (NECO_QT_PLND_UNIT_CONSUM * (NECO_QT_QTY_OK + NECO_QT_QTY_NOK) - NECO_QT_ACT_USAGE_QTY) AS NECO_QT_VARIANCE,
          NVL (P_ELT_ID_BATCH, N_ELT_ID_JOB_LOG) AS NECO_ID_BATCH_ID,
          NECO_CD_SOURCE_SYSTEM
   FROM
     (SELECT NECO_CD_PLANT_CD,
             NECO_ID_PROC_LOT_RAW_MAT,
             NECO_ID_TIME_PROC_LOT_STR_DT,
             NECO_ID_TIME_PROC_LOT_END_DT,
             NECO_ID_PLST_ACT_WCTR_CD,
             PLOT_CD_ACT_WCTR_CD AS NECO_CD_ACT_WCTR_CD,
             NECO_CD_PROC_LOT,
             NECO_ID_MTRL_ACT_COMP,
             NECO_CD_ACT_COMP,
             NECO_QT_ACT_USAGE_QTY,
             NECO_CD_OP,
             NECO_ID_MTRL_PLND_COMP,
             NECO_CD_PLND_COMP,
             NECO_ID_MTRL_PART_NBR,
             NECO_CD_PART_NBR,
             NECO_QT_QTY_OK,
             NECO_QT_QTY_NOK,
             NECO_ID_PLST_WCTR_CD,
             NECO_CD_WCTR_CD,
             NECO_CD_PROD_ORD,
             PRCO_QT_QTY AS NECO_QT_PLND_RAW_MATERIAL,
             PROP_QT_BASE_QTY AS NECO_QT_PLND_BASE_QTY,
             ROUND ((PRCO_QT_QTY/PROP_QT_BASE_QTY) , 10) AS NECO_QT_PLND_UNIT_CONSUM,
             NECO_CD_SOURCE_SYSTEM
      FROM
        (SELECT TD_PLRM_PROC_LOT_RAW_MAT.PLRM_CD_PLANT_CD AS NECO_CD_PLANT_CD,
                TD_PLRM_PROC_LOT_RAW_MAT.PLRM_ID_PROC_LOT_RAW_MAT AS NECO_ID_PROC_LOT_RAW_MAT,
                NVL (TO_NUMBER (TO_CHAR (PLOT_DT_PROC_LOT_STR_DT, 'J')), -2) AS NECO_ID_TIME_PROC_LOT_STR_DT,
                NVL (TO_NUMBER (TO_CHAR (PLOT_DT_PROC_LOT_END_DT, 'J')), -2) AS NECO_ID_TIME_PROC_LOT_END_DT,
                TT_PLOT_PROC_LOT.PLOT_ID_PLMD_ACT_WCTR_CD AS NECO_ID_PLST_ACT_WCTR_CD,
                PLOT_CD_ACT_WCTR_CD,
                TD_PLRM_PROC_LOT_RAW_MAT.PLRM_CD_PROC_LOT AS NECO_CD_PROC_LOT,
                TD_PLRM_PROC_LOT_RAW_MAT.PLRM_ID_MAMD_ACT_COMP AS NECO_ID_MTRL_ACT_COMP,
                TD_PLRM_PROC_LOT_RAW_MAT.PLRM_CD_ACT_COMP AS NECO_CD_ACT_COMP_1,
                MAX (PLRM_CD_ACT_COMP) KEEP (DENSE_RANK FIRST
                                             ORDER BY PLRM_QT_ACT_USAGE_QTY DESC) OVER (PARTITION BY PLRM_CD_PLANT_CD,
                                                                                                     PLRM_ID_PLPP_PROC_LOT_PART_NBR) AS NECO_CD_ACT_COMP,
                                                                                       SUM (PLRM_QT_ACT_USAGE_QTY) OVER (PARTITION BY PLRM_CD_PLANT_CD,
                                                                                                                                      PLRM_ID_PLPP_PROC_LOT_PART_NBR) AS NECO_QT_ACT_USAGE_QTY,
                                                                                                                        TD_PLPP_PROC_LOT_PART_PROD.PLPP_CD_OP AS NECO_CD_OP,
                                                                                                                        TD_PRCO_PROD_ORD_COMP.PRCO_ID_MAMD_COMP AS NECO_ID_MTRL_PLND_COMP,
                                                                                                                        TD_PRCO_PROD_ORD_COMP.PRCO_CD_COMP AS NECO_CD_PLND_COMP_1,
                                                                                                                        MAX (PRCO_CD_COMP) KEEP (DENSE_RANK FIRST
                                                                                                                                                 ORDER BY PRCO_QT_QTY DESC) OVER (PARTITION BY PRCO_CD_PLANT_CD,
                                                                                                                                                                                               PRCO_ID_PROP_PROD_ORD_OP) AS NECO_CD_PLND_COMP,
                                                                                                                                                                                 TD_PLPP_PROC_LOT_PART_PROD.PLPP_ID_MAMD_PART_NBR AS NECO_ID_MTRL_PART_NBR,
                                                                                                                                                                                 TD_PLPP_PROC_LOT_PART_PROD.PLPP_CD_PART_NBR AS NECO_CD_PART_NBR,
                                                                                                                                                                                 TD_PLPP_PROC_LOT_PART_PROD.PLPP_QT_QTY_OK AS NECO_QT_QTY_OK,
                                                                                                                                                                                 TD_PLPP_PROC_LOT_PART_PROD.PLPP_QT_QTY_NOK AS NECO_QT_QTY_NOK,
                                                                                                                                                                                 TD_PROP_PROD_ORD_OP.PROP_ID_PLMD_WCTR_CD AS NECO_ID_PLST_WCTR_CD,
                                                                                                                                                                                 TD_PROP_PROD_ORD_OP.PROP_CD_WCTR_CD AS NECO_CD_WCTR_CD,
                                                                                                                                                                                 TD_PLRM_PROC_LOT_RAW_MAT.PLRM_CD_EFF_ORD AS NECO_CD_PROD_ORD,
                                                                                                                                                                                 PLRM_CD_OP,
                                                                                                                                                                                 PROP_QT_BASE_QTY,
                                                                                                                                                                                 SUM (PRCO_QT_QTY) OVER (PARTITION BY PRCO_CD_PLANT_CD,
                                                                                                                                                                                                                      PRCO_ID_PROP_PROD_ORD_OP) AS PRCO_QT_QTY,
                                                                                                                                                                                                        PLRM_CD_SOURCE_SYSTEM AS NECO_CD_SOURCE_SYSTEM
         FROM
           (SELECT *
            FROM DDWH01_DW_MA.TD_PLRM_PROC_LOT_RAW_MAT
            WHERE PLRM_CD_PLANT_CD = P_ELT_CD_PLANT
              AND PLRM_FL_LOGICAL_STATUS = '1' ) TD_PLRM_PROC_LOT_RAW_MAT,

           (SELECT *
            FROM DDWH01_DW_MA.TT_PLOT_PROC_LOT
            WHERE PLOT_CD_PLANT_CD = P_ELT_CD_PLANT ) TT_PLOT_PROC_LOT,

           (SELECT *
            FROM DDWH01_DW_MA.TD_PLPP_PROC_LOT_PART_PROD
            WHERE PLPP_CD_PLANT_CD =P_ELT_CD_PLANT
              AND PLPP_FL_LOGICAL_STATUS = '1' ) TD_PLPP_PROC_LOT_PART_PROD,

           (SELECT *
            FROM DDWH01_DW_MA.TD_PRCO_PROD_ORD_COMP
            WHERE PRCO_CD_PLANT_CD = P_ELT_CD_PLANT
              AND PRCO_FL_LOGICAL_STATUS = '1' ) TD_PRCO_PROD_ORD_COMP,

           (SELECT *
            FROM DDWH01_DW_MA.TT_PROR_PROD_ORD
            WHERE PROR_CD_PLANT_CD = P_ELT_CD_PLANT
              AND PROR_FL_LOGICAL_STATUS = '1'
              AND PROR_FL_CLOSE_MARK = '0' ) TT_PROR_PROD_ORD,

           (SELECT *
            FROM DDWH01_DW_MA.TD_PROP_PROD_ORD_OP
            WHERE PROP_CD_PLANT_CD = P_ELT_CD_PLANT
              AND PROP_FL_LOGICAL_STATUS = '1'
              AND PROP_FL_CLOSE_MARK = '0' ) TD_PROP_PROD_ORD_OP,

           (SELECT *
            FROM DDWH01_DW_MA.TM_PLMD_PLANT_MASTER
            WHERE PLMD_CD_PLANT_CD = P_ELT_CD_PLANT ) TM_PLMD_PLANT_MASTER,

           (SELECT *
            FROM DDWH01_DW_MA.TM_MBUD_MBU_MASTER
            WHERE MBUD_CD_PLANT_CD = P_ELT_CD_PLANT
              AND MBUD_CD_PROCESS<>'PAINTING' ) TM_MBUD_MBU_MASTER,

           (SELECT *
            FROM DDWH02_DM_MA.TW_NECK_NEST_CONSUMPTION_KEY
            WHERE NECK_CD_PLANT_CD = P_ELT_CD_PLANT ) TW_NECK_NEST_CONSUMPTION_KEY
         WHERE 1=1
           AND TW_NECK_NEST_CONSUMPTION_KEY.NECK_CD_PROC_LOT = TT_PLOT_PROC_LOT.PLOT_CD_PROC_LOT
           AND TD_PLPP_PROC_LOT_PART_PROD.PLPP_ID_PLOT_PROC_LOT=TT_PLOT_PROC_LOT.PLOT_ID_PROC_LOT
           AND TD_PLRM_PROC_LOT_RAW_MAT.PLRM_ID_PLPP_PROC_LOT_PART_NBR=TD_PLPP_PROC_LOT_PART_PROD.PLPP_ID_PROC_LOT_PART_PROD
           AND TD_PLPP_PROC_LOT_PART_PROD.PLPP_ID_PROP_PROD_ORD_OP=TD_PROP_PROD_ORD_OP.PROP_ID_PROD_ORD_OP
           AND TD_PRCO_PROD_ORD_COMP.PRCO_ID_PROP_PROD_ORD_OP = TD_PROP_PROD_ORD_OP.PROP_ID_PROD_ORD_OP
           AND TT_PROR_PROD_ORD.PROR_ID_PROD_ORD = TD_PROP_PROD_ORD_OP.PROP_ID_PROR_PROD_ORD
           AND TT_PLOT_PROC_LOT.PLOT_ID_PLMD_ACT_WCTR_CD = TM_PLMD_PLANT_MASTER.PLMD_ID_PLANT_MASTER
           AND TM_PLMD_PLANT_MASTER.PLMD_CD_DEP = TM_MBUD_MBU_MASTER.MBUD_CD_DEP_CD )
      WHERE NECO_CD_ACT_COMP_1 = NECO_CD_ACT_COMP
        AND NECO_CD_PLND_COMP_1 = NECO_CD_PLND_COMP )) QRY ON (TRG.NECO_CD_PLANT_CD = QRY.NECO_CD_PLANT_CD
                                                               AND TRG.NECO_ID_PROC_LOT_RAW_MAT = QRY.NECO_ID_PROC_LOT_RAW_MAT) WHEN MATCHED THEN
UPDATE
SET TRG.NECO_ID_TIME_PROC_LOT_STR_DT= QRY.NECO_ID_TIME_PROC_LOT_STR_DT,
    TRG.NECO_ID_TIME_PROC_LOT_END_DT= QRY.NECO_ID_TIME_PROC_LOT_END_DT,
    TRG.NECO_ID_PLST_ACT_WCTR_CD= QRY.NECO_ID_PLST_ACT_WCTR_CD,
    TRG.NECO_CD_ACT_WCTR_CD= QRY.NECO_CD_ACT_WCTR_CD,
    TRG.NECO_CD_PROC_LOT= QRY.NECO_CD_PROC_LOT,
    TRG.NECO_ID_MTRL_ACT_COMP= QRY.NECO_ID_MTRL_ACT_COMP,
    TRG.NECO_CD_ACT_COMP= QRY.NECO_CD_ACT_COMP,
    TRG.NECO_QT_ACT_USAGE_QTY= QRY.NECO_QT_ACT_USAGE_QTY,
    TRG.NECO_CD_OP= QRY.NECO_CD_OP,
    TRG.NECO_ID_MTRL_PLND_COMP= QRY.NECO_ID_MTRL_PLND_COMP,
    TRG.NECO_CD_PLND_COMP= QRY.NECO_CD_PLND_COMP,
    TRG.NECO_ID_MTRL_PART_NBR= QRY.NECO_ID_MTRL_PART_NBR,
    TRG.NECO_CD_PART_NBR= QRY.NECO_CD_PART_NBR,
    TRG.NECO_QT_QTY_OK= QRY.NECO_QT_QTY_OK,
    TRG.NECO_QT_QTY_NOK= QRY.NECO_QT_QTY_NOK,
    TRG.NECO_ID_PLST_WCTR_CD= QRY.NECO_ID_PLST_WCTR_CD,
    TRG.NECO_CD_WCTR_CD= QRY.NECO_CD_WCTR_CD,
    TRG.NECO_CD_PROD_ORD= QRY.NECO_CD_PROD_ORD,
    TRG.NECO_QT_PLND_RAW_MATERIAL= QRY.NECO_QT_PLND_RAW_MATERIAL,
    TRG.NECO_QT_PLND_BASE_QTY= QRY.NECO_QT_PLND_BASE_QTY,
    TRG.NECO_QT_PLND_UNIT_CONSUM= QRY.NECO_QT_PLND_UNIT_CONSUM,
    TRG.NECO_QT_PLND_TOTAL_CONSUM= QRY.NECO_QT_PLND_TOTAL_CONSUM,
    TRG.NECO_QT_VARIANCE= QRY.NECO_QT_VARIANCE,
    TRG.NECO_ID_BATCH_ID= QRY.NECO_ID_BATCH_ID,
    TRG.NECO_CD_SOURCE_SYSTEM= QRY.NECO_CD_SOURCE_SYSTEM,
    TRG.NECO_DT_INS_ROW= SYSDATE,
    TRG.NECO_DT_UPD_ROW= SYSDATE,
    TRG.NECO_CD_OPERATOR_CODE= 'ETL' WHEN NOT MATCHED THEN
INSERT (NECO_CD_PLANT_CD,
        NECO_ID_PROC_LOT_RAW_MAT,
        NECO_ID_TIME_PROC_LOT_STR_DT,
        NECO_ID_TIME_PROC_LOT_END_DT,
        NECO_ID_PLST_ACT_WCTR_CD,
        NECO_CD_ACT_WCTR_CD,
        NECO_CD_PROC_LOT,
        NECO_ID_MTRL_ACT_COMP,
        NECO_CD_ACT_COMP,
        NECO_QT_ACT_USAGE_QTY,
        NECO_CD_OP,
        NECO_ID_MTRL_PLND_COMP,
        NECO_CD_PLND_COMP,
        NECO_ID_MTRL_PART_NBR,
        NECO_CD_PART_NBR,
        NECO_QT_QTY_OK,
        NECO_QT_QTY_NOK,
        NECO_ID_PLST_WCTR_CD,
        NECO_CD_WCTR_CD,
        NECO_CD_PROD_ORD,
        NECO_QT_PLND_RAW_MATERIAL,
        NECO_QT_PLND_BASE_QTY,
        NECO_QT_PLND_UNIT_CONSUM,
        NECO_QT_PLND_TOTAL_CONSUM,
        NECO_QT_VARIANCE,
        NECO_ID_BATCH_ID,
        NECO_CD_SOURCE_SYSTEM,
        NECO_DT_INS_ROW,
        NECO_DT_UPD_ROW,
        NECO_CD_OPERATOR_CODE)
VALUES (QRY.NECO_CD_PLANT_CD, QRY.NECO_ID_PROC_LOT_RAW_MAT, QRY.NECO_ID_TIME_PROC_LOT_STR_DT, QRY.NECO_ID_TIME_PROC_LOT_END_DT, QRY.NECO_ID_PLST_ACT_WCTR_CD, QRY.NECO_CD_ACT_WCTR_CD, QRY.NECO_CD_PROC_LOT, QRY.NECO_ID_MTRL_ACT_COMP, QRY.NECO_CD_ACT_COMP, QRY.NECO_QT_ACT_USAGE_QTY, QRY.NECO_CD_OP, QRY.NECO_ID_MTRL_PLND_COMP, QRY.NECO_CD_PLND_COMP, QRY.NECO_ID_MTRL_PART_NBR, QRY.NECO_CD_PART_NBR, QRY.NECO_QT_QTY_OK, QRY.NECO_QT_QTY_NOK, QRY.NECO_ID_PLST_WCTR_CD, QRY.NECO_CD_WCTR_CD, QRY.NECO_CD_PROD_ORD, QRY.NECO_QT_PLND_RAW_MATERIAL, QRY.NECO_QT_PLND_BASE_QTY, QRY.NECO_QT_PLND_UNIT_CONSUM, QRY.NECO_QT_PLND_TOTAL_CONSUM, QRY.NECO_QT_VARIANCE, QRY.NECO_ID_BATCH_ID, QRY.NECO_CD_SOURCE_SYSTEM, SYSDATE, SYSDATE, 'ETL')