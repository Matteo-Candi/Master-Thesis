INSERT INTO DDWH02_DM_MA.TW_MCST_MC_STOCK_QTY TRG (MCST_CD_PLANT_CD, MCST_ID_MC_STOCK_QTY, MCST_CD_PART_NBR, MCST_QT_CONS_QTY, MCST_NR_AGING_CONS_QTY, MCST_QT_INB_QTY, MCST_NR_AGING_INB_QTY, MCST_QT_QUALITY_AREA_QTY, MCST_NR_AGING_QTY_AREA_QTY, MCST_QT_DEC_QTY, MCST_NR_AGING_DEC_QTY, MCST_QT_AVAILABLE_QTY, MCST_NR_AGING_AVAILABLE_QTY, MCST_QT_EXT_QTY, MCST_NR_AGING_EXT_QTY, MCST_QT_OTHERS_QTY, MCST_NR_AGING_OTHERS_QTY, MCST_QT_WIP_LN_QTY, MCST_QT_WIP_HARD_QTY, MCST_QT_W999_QTY, MCST_QT_TOT_STOCK_QTY, MCST_QT_MOUNT_QTY, MCST_NT_MOUNT_COMP_PATH, MCST_ID_BATCH_ID, MCST_CD_SOURCE_SYSTEM, MCST_DT_INSERT_ROW, MCST_DT_UPDATE_ROW, MCST_CD_OPERATOR_CODE)
SELECT QRY.MCST_CD_PLANT_CD,
       QRY.MCST_ID_MC_STOCK_QTY,
       QRY.MCST_CD_PART_NBR,
       QRY.MCST_QT_CONS_QTY,
       QRY.MCST_NR_AGING_CONS_QTY,
       QRY.MCST_QT_INB_QTY,
       QRY.MCST_NR_AGING_INB_QTY,
       QRY.MCST_QT_QUALITY_AREA_QTY,
       QRY.MCST_NR_AGING_QTY_AREA_QTY,
       QRY.MCST_QT_DEC_QTY,
       QRY.MCST_NR_AGING_DEC_QTY,
       QRY.MCST_QT_AVAILABLE_QTY,
       QRY.MCST_NR_AGING_AVAILABLE_QTY,
       QRY.MCST_QT_EXT_QTY,
       QRY.MCST_NR_AGING_EXT_QTY,
       QRY.MCST_QT_OTHERS_QTY,
       QRY.MCST_NR_AGING_OTHERS_QTY,
       QRY.MCST_QT_WIP_LN_QTY,
       QRY.MCST_QT_WIP_HARD_QTY,
       QRY.MCST_QT_W999_QTY,
       QRY.MCST_QT_TOT_STOCK_QTY,
       QRY.MCST_QT_MOUNT_QTY,
       QRY.MCST_NT_MOUNT_COMP_PATH,
       QRY.MCST_ID_BATCH_ID,
       QRY.MCST_CD_SOURCE_SYSTEM,
       SYSDATE,
       SYSDATE,
       'ETL'
FROM
  (WITH TW_MCVE_AS AS
     (SELECT MCVE_CD_COMP,
             MAX (MCVE_CD_SERIE) KEEP (DENSE_RANK FIRST
                                       ORDER BY ABS (TRUNC (MCVE_DT_KEY_FIXED_DATE, 'MM') - TRUNC (TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'), 'MM')) , MCVE_CD_SERIE) MCVE_CD_SERIE,
                                 MAX (MCVE_CD_PROCUR_TP) KEEP (DENSE_RANK FIRST
                                                               ORDER BY ABS (TRUNC (MCVE_DT_KEY_FIXED_DATE, 'MM') - TRUNC (TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'), 'MM')) , MCVE_CD_SERIE) MCVE_CD_PROCUR_TP,
                                                         MAX (MCVE_CD_COMP_ASS_MARK) KEEP (DENSE_RANK FIRST
                                                                                           ORDER BY ABS (TRUNC (MCVE_DT_KEY_FIXED_DATE, 'MM') - TRUNC (TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'), 'MM')) , MCVE_CD_SERIE) MCVE_CD_COMP_ASS_MARK
      FROM DDWH02_DM_MA.TW_MCVE_MC_VEHICLE
      WHERE MCVE_CD_PLANT_CD = P_ELT_CD_PLANT
      GROUP BY MCVE_CD_PLANT_CD,
               MCVE_CD_COMP),
        TW_MCIR_AS AS
     (SELECT MCIR_CD_COMP,
             MAX (MCIR_DT_EXPL_DT) KEEP (DENSE_RANK FIRST
                                         ORDER BY ABS (TRUNC (MCIR_DT_EXPL_DT, 'MM') - TRUNC (TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'), 'MM'))) MCIR_DT_EXPL_DT,
                                   MAX (MCIR_CD_PROCUR_TP) KEEP (DENSE_RANK FIRST
                                                                 ORDER BY ABS (TRUNC (MCIR_DT_EXPL_DT, 'MM') - TRUNC (TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'), 'MM'))) MCIR_CD_PROCUR_TP,
                                                           MAX (MCIR_CD_COMP_ASS_MARK) KEEP (DENSE_RANK FIRST
                                                                                             ORDER BY ABS (TRUNC (MCIR_DT_EXPL_DT, 'MM') - TRUNC (TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'), 'MM'))) MCIR_CD_COMP_ASS_MARK
      FROM DDWH02_DM_MA.TW_MCIR_MC_IND_REQ MCVE_CD_COMP
      WHERE MCIR_CD_PLANT_CD = P_ELT_CD_PLANT
        AND NOT EXISTS
          (SELECT 1
           FROM TW_MCVE_AS
           WHERE MCIR_CD_COMP = MCVE_CD_COMP )
      GROUP BY MCIR_CD_PLANT_CD,
               MCIR_CD_COMP),
        TW_STOCK AS
     (SELECT STOCK.*,
             TW_MCVE_AS.MCVE_CD_SERIE AS CD_SERIE
      FROM
        (SELECT CD_PLANT,
                CD_PART_NBR,
                SUM (MCCI_QT_CONS_QTY) AS QT_CONS_QTY,
                    MAX (MCCI_NR_AGING_CONS_QTY) AS NR_AGING_CONS_QTY,
                        SUM (MCCI_QT_INB_QTY) AS QT_INB_QTY,
                            MAX (MCCI_NR_AGING_INB_QTY) AS NR_AGING_INB_QTY,
                                SUM (MCCI_QT_QUALITY_AREA_QTY) AS QT_QUALITY_AREA_QTY,
                                    MAX (MCCI_NR_AGING_QTY_AREA_QTY) AS NR_AGING_QTY_AREA_QTY,
                                        SUM (MCCI_QT_DEC_QTY) AS QT_DEC_QTY,
                                            MAX (MCCI_NR_AGING_DEC_QTY) AS NR_AGING_DEC_QTY,
                                                SUM (MCCI_QT_AVAILABLE_QTY) AS QT_AVAILABLE_QTY,
                                                    MAX (MCCI_NR_AGING_AVAILABLE_QTY) AS NR_AGING_AVAILABLE_QTY,
                                                        SUM (MCCI_QT_EXT_QTY) AS QT_EXT_QTY,
                                                            MAX (MCCI_NR_AGING_EXT_QTY) AS NR_AGING_EXT_QTY,
                                                                SUM (MCCI_QT_OTHERS_QTY) AS QT_OTHERS_QTY,
                                                                    MAX (MCCI_NR_AGING_OTHERS_QTY) AS NR_AGING_OTHERS_QTY,
                                                                        SUM (MCSI_QT_WIP_LN_QTY) AS QT_WIP_LN_QTY,
                                                                            SUM (MCSI_QT_WIP_HARD_QTY) AS QT_WIP_HARD_QTY,
                                                                                SUM (MCSI_QT_W999_QTY) AS QT_W999_QTY
         FROM
           (SELECT MCCI_CD_PLANT_CD AS CD_PLANT,
                   MCCI_CD_PART_NBR AS CD_PART_NBR,
                   MCCI_QT_CONS_QTY,
                   MCCI_QT_INB_QTY,
                   MCCI_QT_QUALITY_AREA_QTY,
                   MCCI_QT_DEC_QTY,
                   MCCI_QT_AVAILABLE_QTY,
                   MCCI_QT_EXT_QTY,
                   MCCI_QT_OTHERS_QTY,
                   MCCI_NR_AGING_CONS_QTY,
                   MCCI_NR_AGING_INB_QTY,
                   MCCI_NR_AGING_QTY_AREA_QTY,
                   MCCI_NR_AGING_DEC_QTY,
                   MCCI_NR_AGING_AVAILABLE_QTY,
                   MCCI_NR_AGING_EXT_QTY,
                   MCCI_NR_AGING_OTHERS_QTY,
                   0 AS MCSI_QT_WIP_LN_QTY,
                   0 AS MCSI_QT_WIP_HARD_QTY,
                   0 AS MCSI_QT_W999_QTY
            FROM DDWH02_DM_MA.TW_MCCI_MC_CLICK_INV
            WHERE MCCI_CD_PLANT_CD = P_ELT_CD_PLANT
            UNION ALL SELECT MCSI_CD_PLANT_CD AS CD_PLANT,
                             MCSI_CD_PART_NBR AS CD_PART_NBR,
                             0 AS MCCI_QT_CONS_QTY,
                             0 AS MCCI_QT_INB_QTY,
                             0 AS MCCI_QT_QUALITY_AREA_QTY,
                             0 AS MCCI_QT_DEC_QTY,
                             0 AS MCCI_QT_AVAILABLE_QTY,
                             0 AS MCCI_QT_EXT_QTY,
                             0 AS MCCI_QT_OTHERS_QTY,
                             0 AS MCCI_NR_AGING_CONS_QTY,
                             0 AS MCCI_NR_AGING_INB_QTY,
                             0 AS MCCI_NR_AGING_QTY_AREA_QTY,
                             0 AS MCCI_NR_AGING_DEC_QTY,
                             0 AS MCCI_NR_AGING_AVAILABLE_QTY,
                             0 AS MCCI_NR_AGING_EXT_QTY,
                             0 AS MCCI_NR_AGING_OTHERS_QTY,
                             MCSI_QT_WIP_LN_QTY,
                             MCSI_QT_WIP_HARD_QTY,
                             MCSI_QT_W999_QTY
            FROM DDWH02_DM_MA.TW_MCSI_MC_SAP_INV
            WHERE MCSI_CD_PLANT_CD = P_ELT_CD_PLANT )
         GROUP BY CD_PLANT,
                  CD_PART_NBR) STOCK,
           TW_MCVE_AS
      WHERE TW_MCVE_AS.MCVE_CD_COMP = CD_PART_NBR
        AND TW_MCVE_AS.MCVE_CD_PROCUR_TP IN ('MTS',
                                             'BUY',
                                             'SUBCONTRACTING',
                                             'MAKE OR BUY') ),
        TW_STOCK_IR AS
     (SELECT STOCK.*,
             TW_MCIR_AS.MCIR_DT_EXPL_DT AS EXPL_DT
      FROM
        (SELECT CD_PLANT,
                CD_PART_NBR,
                SUM (MCCI_QT_CONS_QTY) AS QT_CONS_QTY,
                    MAX (MCCI_NR_AGING_CONS_QTY) AS NR_AGING_CONS_QTY,
                        SUM (MCCI_QT_INB_QTY) AS QT_INB_QTY,
                            MAX (MCCI_NR_AGING_INB_QTY) AS NR_AGING_INB_QTY,
                                SUM (MCCI_QT_QUALITY_AREA_QTY) AS QT_QUALITY_AREA_QTY,
                                    MAX (MCCI_NR_AGING_QTY_AREA_QTY) AS NR_AGING_QTY_AREA_QTY,
                                        SUM (MCCI_QT_DEC_QTY) AS QT_DEC_QTY,
                                            MAX (MCCI_NR_AGING_DEC_QTY) AS NR_AGING_DEC_QTY,
                                                SUM (MCCI_QT_AVAILABLE_QTY) AS QT_AVAILABLE_QTY,
                                                    MAX (MCCI_NR_AGING_AVAILABLE_QTY) AS NR_AGING_AVAILABLE_QTY,
                                                        SUM (MCCI_QT_EXT_QTY) AS QT_EXT_QTY,
                                                            MAX (MCCI_NR_AGING_EXT_QTY) AS NR_AGING_EXT_QTY,
                                                                SUM (MCCI_QT_OTHERS_QTY) AS QT_OTHERS_QTY,
                                                                    MAX (MCCI_NR_AGING_OTHERS_QTY) AS NR_AGING_OTHERS_QTY,
                                                                        SUM (MCSI_QT_WIP_LN_QTY) AS QT_WIP_LN_QTY,
                                                                            SUM (MCSI_QT_WIP_HARD_QTY) AS QT_WIP_HARD_QTY,
                                                                                SUM (MCSI_QT_W999_QTY) AS QT_W999_QTY
         FROM
           (SELECT MCCI_CD_PLANT_CD AS CD_PLANT,
                   MCCI_CD_PART_NBR AS CD_PART_NBR,
                   MCCI_QT_CONS_QTY,
                   MCCI_QT_INB_QTY,
                   MCCI_QT_QUALITY_AREA_QTY,
                   MCCI_QT_DEC_QTY,
                   MCCI_QT_AVAILABLE_QTY,
                   MCCI_QT_EXT_QTY,
                   MCCI_QT_OTHERS_QTY,
                   MCCI_NR_AGING_CONS_QTY,
                   MCCI_NR_AGING_INB_QTY,
                   MCCI_NR_AGING_QTY_AREA_QTY,
                   MCCI_NR_AGING_DEC_QTY,
                   MCCI_NR_AGING_AVAILABLE_QTY,
                   MCCI_NR_AGING_EXT_QTY,
                   MCCI_NR_AGING_OTHERS_QTY,
                   0 AS MCSI_QT_WIP_LN_QTY,
                   0 AS MCSI_QT_WIP_HARD_QTY,
                   0 AS MCSI_QT_W999_QTY
            FROM DDWH02_DM_MA.TW_MCCI_MC_CLICK_INV
            WHERE MCCI_CD_PLANT_CD = P_ELT_CD_PLANT
            UNION ALL SELECT MCSI_CD_PLANT_CD AS CD_PLANT,
                             MCSI_CD_PART_NBR AS CD_PART_NBR,
                             0 AS MCCI_QT_CONS_QTY,
                             0 AS MCCI_QT_INB_QTY,
                             0 AS MCCI_QT_QUALITY_AREA_QTY,
                             0 AS MCCI_QT_DEC_QTY,
                             0 AS MCCI_QT_AVAILABLE_QTY,
                             0 AS MCCI_QT_EXT_QTY,
                             0 AS MCCI_QT_OTHERS_QTY,
                             0 AS MCCI_NR_AGING_CONS_QTY,
                             0 AS MCCI_NR_AGING_INB_QTY,
                             0 AS MCCI_NR_AGING_QTY_AREA_QTY,
                             0 AS MCCI_NR_AGING_DEC_QTY,
                             0 AS MCCI_NR_AGING_AVAILABLE_QTY,
                             0 AS MCCI_NR_AGING_EXT_QTY,
                             0 AS MCCI_NR_AGING_OTHERS_QTY,
                             MCSI_QT_WIP_LN_QTY,
                             MCSI_QT_WIP_HARD_QTY,
                             MCSI_QT_W999_QTY
            FROM DDWH02_DM_MA.TW_MCSI_MC_SAP_INV
            WHERE MCSI_CD_PLANT_CD = P_ELT_CD_PLANT )
         GROUP BY CD_PLANT,
                  CD_PART_NBR) STOCK,
           TW_MCIR_AS
      WHERE TW_MCIR_AS.MCIR_CD_COMP = CD_PART_NBR
        AND TW_MCIR_AS.MCIR_CD_PROCUR_TP IN ('MTS',
                                             'BUY',
                                             'SUBCONTRACTING',
                                             'MAKE OR BUY') ) SELECT MCST_CD_PLANT_CD,
                                                                     0 AS MCST_ID_MC_STOCK_QTY,
                                                                     MCST_CD_PART_NBR,
                                                                     MCST_QT_CONS_QTY,
                                                                     MCST_NR_AGING_CONS_QTY,
                                                                     MCST_QT_INB_QTY,
                                                                     MCST_NR_AGING_INB_QTY,
                                                                     MCST_QT_QUALITY_AREA_QTY,
                                                                     MCST_NR_AGING_QTY_AREA_QTY,
                                                                     MCST_QT_DEC_QTY,
                                                                     MCST_NR_AGING_DEC_QTY,
                                                                     MCST_QT_AVAILABLE_QTY,
                                                                     MCST_NR_AGING_AVAILABLE_QTY,
                                                                     MCST_QT_EXT_QTY,
                                                                     MCST_NR_AGING_EXT_QTY,
                                                                     MCST_QT_OTHERS_QTY,
                                                                     MCST_NR_AGING_OTHERS_QTY,
                                                                     MCST_QT_WIP_LN_QTY,
                                                                     MCST_QT_WIP_HARD_QTY,
                                                                     MCST_QT_W999_QTY,
                                                                     MCST_QT_TOT_STOCK_QTY,
                                                                     MCST_QT_MOUNT_QTY,
                                                                     MCST_NT_MOUNT_COMP_PATH,
                                                                     NVL (P_ELT_ID_BATCH, N_ELT_ID_JOB_LOG) AS MCST_ID_BATCH_ID,
                                                                     0 AS MCST_CD_SOURCE_SYSTEM
   FROM
     (SELECT CD_PLANT AS MCST_CD_PLANT_CD,
             CD_PART_NBR AS MCST_CD_PART_NBR,
             SUM (QT_CONS_QTY) AS MCST_QT_CONS_QTY,
                 MAX (NR_AGING_CONS_QTY) AS MCST_NR_AGING_CONS_QTY,
                     SUM (QT_INB_QTY) AS MCST_QT_INB_QTY,
                         MAX (NR_AGING_INB_QTY) AS MCST_NR_AGING_INB_QTY,
                             SUM (QT_QUALITY_AREA_QTY) AS MCST_QT_QUALITY_AREA_QTY,
                                 MAX (NR_AGING_QTY_AREA_QTY) AS MCST_NR_AGING_QTY_AREA_QTY,
                                     SUM (QT_DEC_QTY) AS MCST_QT_DEC_QTY,
                                         MAX (NR_AGING_DEC_QTY) AS MCST_NR_AGING_DEC_QTY,
                                             SUM (QT_AVAILABLE_QTY) AS MCST_QT_AVAILABLE_QTY,
                                                 MAX (NR_AGING_AVAILABLE_QTY) AS MCST_NR_AGING_AVAILABLE_QTY,
                                                     SUM (QT_EXT_QTY) AS MCST_QT_EXT_QTY,
                                                         MAX (NR_AGING_EXT_QTY) AS MCST_NR_AGING_EXT_QTY,
                                                             SUM (QT_OTHERS_QTY) AS MCST_QT_OTHERS_QTY,
                                                                 MAX (NR_AGING_OTHERS_QTY) AS MCST_NR_AGING_OTHERS_QTY,
                                                                     SUM (QT_WIP_LN_QTY) AS MCST_QT_WIP_LN_QTY,
                                                                         SUM (QT_WIP_HARD_QTY) AS MCST_QT_WIP_HARD_QTY,
                                                                             SUM (QT_W999_QTY) AS MCST_QT_W999_QTY,
                                                                                 SUM (TOT_STOCK_QTY) AS MCST_QT_TOT_STOCK_QTY,
                                                                                     SUM (QT_MOUNT_QTY) AS MCST_QT_MOUNT_QTY,
                                                                                         DDWH02_DM_MA.FUNC_STRAGG_DISTINCT (NT_MOUNT_COMP) KEEP (DENSE_RANK FIRST
                                                                                                                                                 ORDER BY TOP_MOUNT_PN_CAT) || CASE
                                                                                                                                                                                   WHEN COUNT (DISTINCT NT_MOUNT_COMP) > 10 THEN ' TOP ' ||COUNT (NT_MOUNT_COMP) KEEP (DENSE_RANK FIRST
                                                                                                                                                                                                                                                                       ORDER BY TOP_MOUNT_PN_CAT) || ' OF '||COUNT (DISTINCT NT_MOUNT_COMP)
                                                                                                                                                                               END MCST_NT_MOUNT_COMP_PATH
      FROM
        (SELECT CD_PLANT,
                CD_PART_NBR,
                NVL (QT_CONS_QTY, 0) AS QT_CONS_QTY,
                NVL (QT_INB_QTY, 0) AS QT_INB_QTY,
                NVL (QT_QUALITY_AREA_QTY, 0) AS QT_QUALITY_AREA_QTY,
                NVL (QT_DEC_QTY, 0) QT_DEC_QTY,
                NVL (QT_AVAILABLE_QTY, 0) AS QT_AVAILABLE_QTY,
                NVL (QT_EXT_QTY, 0) AS QT_EXT_QTY,
                NVL (QT_OTHERS_QTY, 0) AS QT_OTHERS_QTY,
                NVL (QT_WIP_LN_QTY, 0) AS QT_WIP_LN_QTY,
                NVL (QT_WIP_HARD_QTY, 0) AS QT_WIP_HARD_QTY,
                NVL (NR_AGING_CONS_QTY, 0) AS NR_AGING_CONS_QTY,
                NVL (NR_AGING_INB_QTY, 0) AS NR_AGING_INB_QTY,
                NVL (NR_AGING_QTY_AREA_QTY, 0) AS NR_AGING_QTY_AREA_QTY,
                NVL (NR_AGING_DEC_QTY, 0) AS NR_AGING_DEC_QTY,
                NVL (NR_AGING_AVAILABLE_QTY, 0) AS NR_AGING_AVAILABLE_QTY,
                NVL (NR_AGING_EXT_QTY, 0) AS NR_AGING_EXT_QTY,
                NVL (NR_AGING_OTHERS_QTY, 0) AS NR_AGING_OTHERS_QTY,
                NVL (QT_W999_QTY, 0) AS QT_W999_QTY,
                NVL (QT_CONS_QTY, 0) + NVL (QT_INB_QTY, 0) + NVL (QT_QUALITY_AREA_QTY, 0) + NVL (QT_DEC_QTY, 0) + NVL (QT_AVAILABLE_QTY, 0) + NVL (QT_EXT_QTY, 0) + NVL (QT_OTHERS_QTY, 0) + NVL (QT_WIP_LN_QTY, 0) + NVL (QT_WIP_HARD_QTY, 0) + NVL (QT_W999_QTY, 0) AS TOT_STOCK_QTY,
                0 AS QT_MOUNT_QTY,
                NULL AS TOP_MOUNT_PN_CAT,
                NULL NT_MOUNT_COMP
         FROM
           (SELECT CD_PLANT,
                   CD_PART_NBR,
                   QT_CONS_QTY,
                   NR_AGING_CONS_QTY,
                   QT_INB_QTY,
                   NR_AGING_INB_QTY,
                   QT_QUALITY_AREA_QTY,
                   NR_AGING_QTY_AREA_QTY,
                   QT_DEC_QTY,
                   NR_AGING_DEC_QTY,
                   QT_AVAILABLE_QTY,
                   NR_AGING_AVAILABLE_QTY,
                   QT_EXT_QTY,
                   NR_AGING_EXT_QTY,
                   QT_OTHERS_QTY,
                   NR_AGING_OTHERS_QTY,
                   QT_WIP_LN_QTY,
                   QT_WIP_HARD_QTY,
                   QT_W999_QTY
            FROM TW_STOCK
            UNION ALL SELECT CD_PLANT,
                             CD_PART_NBR,
                             QT_CONS_QTY,
                             NR_AGING_CONS_QTY,
                             QT_INB_QTY,
                             NR_AGING_INB_QTY,
                             QT_QUALITY_AREA_QTY,
                             NR_AGING_QTY_AREA_QTY,
                             QT_DEC_QTY,
                             NR_AGING_DEC_QTY,
                             QT_AVAILABLE_QTY,
                             NR_AGING_AVAILABLE_QTY,
                             QT_EXT_QTY,
                             NR_AGING_EXT_QTY,
                             QT_OTHERS_QTY,
                             NR_AGING_OTHERS_QTY,
                             QT_WIP_LN_QTY,
                             QT_WIP_HARD_QTY,
                             QT_W999_QTY
            FROM TW_STOCK_IR)
         UNION ALL SELECT CD_PLANT,
                          NVL (MCPR_CD_COMP, MCPI_CD_COMP) AS CD_PART_NBR,
                          SUM (0) , MAX (0) , SUM (0) , MAX (0) , SUM (0) , MAX (0) , SUM (0) , MAX (0) , SUM (0) , MAX (0) , SUM (0) , MAX (0) , SUM (0) , MAX (0) , SUM (0) , SUM (0) , SUM (0) , SUM (0) AS TOT_STOCK_QTY , (DECODE (MAX_MCPR_PC_CONS_QTY, 0, 0, 1) * NVL (QT_CONS_QTY, 0) + DECODE (MAX_MCPR_PC_INB_QTY, 0, 0, 1) * NVL (QT_INB_QTY, 0) + DECODE (MAX_MCPR_PC_QLTY_AREA_QTY, 0, 0, 1) * NVL (QT_QUALITY_AREA_QTY, 0) + DECODE (MAX_MCPR_PC_DEC_AREA_QTY, 0, 0, 1) * NVL (QT_DEC_QTY, 0) + DECODE (MAX_MCPR_PC_STOCK_QTY, 0, 0, 1) * NVL (QT_AVAILABLE_QTY, 0) + DECODE (MAX_MCPR_QT_EXT_QTY, 0, 0, 1) * NVL (QT_EXT_QTY, 0) + DECODE (MAX_MCPR_QT_OTHER_QTY, 0, 0, 1) * NVL (QT_OTHERS_QTY, 0) + DECODE (MAX_MCPR_PC_WIP_LN_QTY, 0, 0, 1) * NVL (QT_WIP_LN_QTY, 0) + DECODE (MAX_MCPR_PC_WIP_HARD_QTY, 0, 0, 1) * NVL (QT_WIP_HARD_QTY, 0) + DECODE (MAX_MCPR_PC_W999_QTY, 0, 0, 1) * NVL (QT_W999_QTY, 0)) * SUM (CASE
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           WHEN TW_STOCK.STOCK = 'STKVH' THEN MCPR_QT_COMP_TOT_QTY
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           WHEN TW_STOCK.STOCK = 'STKIR' THEN MCPI_QT_COMP_TOT_QTY
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       END) AS QT_MOUNT_QTY,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      CASE
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          WHEN DENSE_RANK () OVER (PARTITION BY NVL (MCPR_CD_COMP, MCPI_CD_COMP)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   ORDER BY ABS ((DECODE (MAX_MCPR_PC_CONS_QTY, 0, 0, 1) * NVL (QT_CONS_QTY, 0) + DECODE (MAX_MCPR_PC_INB_QTY, 0, 0, 1) * NVL (QT_INB_QTY, 0) + DECODE (MAX_MCPR_PC_QLTY_AREA_QTY, 0, 0, 1) * NVL (QT_QUALITY_AREA_QTY, 0) + DECODE (MAX_MCPR_PC_DEC_AREA_QTY, 0, 0, 1) * NVL (QT_DEC_QTY, 0) + DECODE (MAX_MCPR_PC_STOCK_QTY, 0, 0, 1) * NVL (QT_AVAILABLE_QTY, 0) + DECODE (MAX_MCPR_QT_EXT_QTY, 0, 0, 1) * NVL (QT_EXT_QTY, 0) + DECODE (MAX_MCPR_QT_OTHER_QTY, 0, 0, 1) * NVL (QT_OTHERS_QTY, 0) + DECODE (MAX_MCPR_PC_WIP_LN_QTY, 0, 0, 1) * NVL (QT_WIP_LN_QTY, 0) + DECODE (MAX_MCPR_PC_WIP_HARD_QTY, 0, 0, 1) * NVL (QT_WIP_HARD_QTY, 0) + DECODE (MAX_MCPR_PC_W999_QTY, 0, 0, 1) * NVL (QT_W999_QTY, 0)) * SUM (CASE
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             WHEN TW_STOCK.STOCK = 'STKVH' THEN MCPR_QT_COMP_TOT_QTY
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             WHEN TW_STOCK.STOCK = 'STKIR' THEN MCPI_QT_COMP_TOT_QTY
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         END)) , NVL (MCPR_CD_PART_NBR, MCPI_CD_PART_NBR)) <= 10 THEN 0
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ELSE 1
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      END TOP_MOUNT_PN_CAT,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      NVL (MCPR_CD_PART_NBR, MCPI_CD_PART_NBR) AS NT_MOUNT_COMP
         FROM
           (SELECT 'STKVH' STOCK,
                           CD_PLANT,
                           CD_PART_NBR,
                           QT_CONS_QTY,
                           NR_AGING_CONS_QTY,
                           QT_INB_QTY,
                           NR_AGING_INB_QTY,
                           QT_QUALITY_AREA_QTY,
                           NR_AGING_QTY_AREA_QTY,
                           QT_DEC_QTY,
                           NR_AGING_DEC_QTY,
                           QT_AVAILABLE_QTY,
                           NR_AGING_AVAILABLE_QTY,
                           QT_EXT_QTY,
                           NR_AGING_EXT_QTY,
                           QT_OTHERS_QTY,
                           NR_AGING_OTHERS_QTY,
                           QT_WIP_LN_QTY,
                           QT_WIP_HARD_QTY,
                           QT_W999_QTY,
                           CD_SERIE,
                           NULL AS EXPL_DT
            FROM TW_STOCK
            UNION ALL SELECT 'STKIR' STOCK,
                                     CD_PLANT,
                                     CD_PART_NBR,
                                     QT_CONS_QTY,
                                     NR_AGING_CONS_QTY,
                                     QT_INB_QTY,
                                     NR_AGING_INB_QTY,
                                     QT_QUALITY_AREA_QTY,
                                     NR_AGING_QTY_AREA_QTY,
                                     QT_DEC_QTY,
                                     NR_AGING_DEC_QTY,
                                     QT_AVAILABLE_QTY,
                                     NR_AGING_AVAILABLE_QTY,
                                     QT_EXT_QTY,
                                     NR_AGING_EXT_QTY,
                                     QT_OTHERS_QTY,
                                     NR_AGING_OTHERS_QTY,
                                     QT_WIP_LN_QTY,
                                     QT_WIP_HARD_QTY,
                                     QT_W999_QTY,
                                     NULL,
                                     EXPL_DT
            FROM TW_STOCK_IR) TW_STOCK ,
           (SELECT 'STKVH' MCPR_STOCK,
                           X.*
            FROM DDWH02_DM_MA.TW_MCPR_MC_PN_ROUT X
            WHERE MCPR_CD_PLANT_CD = P_ELT_CD_PLANT ) ,
           (SELECT 'STKIR' MCPI_STOCK,
                           Y.*
            FROM DDWH02_DM_MA.TW_MCPI_MC_PN_ROUT_IR Y
            WHERE MCPI_CD_PLANT_CD = P_ELT_CD_PLANT ) ,
           (SELECT NVL (MAX (MCPR_PC_CONS_QTY) , 0) AS MAX_MCPR_PC_CONS_QTY,
                   NVL (MAX (MCPR_PC_INB_QTY) , 0) AS MAX_MCPR_PC_INB_QTY,
                   NVL (MAX (MCPR_PC_QUALITY_AREA_QTY) , 0) AS MAX_MCPR_PC_QLTY_AREA_QTY,
                   NVL (MAX (MCPR_PC_DEC_AREA) , 0) AS MAX_MCPR_PC_DEC_AREA_QTY,
                   NVL (MAX (MCPR_QT_EXT_QTY) , 0) AS MAX_MCPR_QT_EXT_QTY,
                   NVL (MAX (MCPR_QT_OTHER_CLICK_QTY) , 0) AS MAX_MCPR_QT_OTHER_QTY,
                   NVL (MAX (MCPR_PC_WIP_LN_QTY) , 0) AS MAX_MCPR_PC_WIP_LN_QTY,
                   NVL (MAX (MCPR_PC_WIP_HARD_QTY) , 0) AS MAX_MCPR_PC_WIP_HARD_QTY,
                   NVL (MAX (MCPR_PC_STOCK_QTY) , 0) AS MAX_MCPR_PC_STOCK_QTY,
                   NVL (MAX (MCPR_PC_W999_QTY) , 0) AS MAX_MCPR_PC_W999_QTY
            FROM DDWH02_DM_MA.TW_MCPR_MC_ALG_RULE_PARAM PAR
            WHERE MCPR_CD_PLANT_CD = P_ELT_CD_PLANT )
         WHERE TW_STOCK.CD_PART_NBR = MCPR_CD_PART_NBR (+)
           AND TW_STOCK.CD_SERIE = MCPR_CD_SERIE (+)
           AND TW_STOCK.STOCK = MCPR_STOCK (+)
           AND TW_STOCK.CD_PART_NBR = MCPI_CD_PART_NBR (+)
           AND TW_STOCK.EXPL_DT = MCPI_DT_EXPL_DT (+)
           AND TW_STOCK.STOCK = MCPI_STOCK (+)
           AND (MCPR_CD_PART_NBR IS NOT NULL
                OR MCPI_CD_PART_NBR IS NOT NULL)
         GROUP BY CD_PLANT,
                  MCPR_CD_COMP,
                  MCPR_CD_PART_NBR,
                  MCPI_CD_COMP,
                  MCPI_CD_PART_NBR,
                  NVL (QT_CONS_QTY, 0),
                  NVL (QT_INB_QTY, 0),
                  NVL (QT_QUALITY_AREA_QTY, 0),
                  NVL (QT_DEC_QTY, 0),
                  NVL (QT_AVAILABLE_QTY, 0),
                  NVL (QT_EXT_QTY, 0),
                  NVL (QT_OTHERS_QTY, 0),
                  NVL (QT_WIP_LN_QTY, 0),
                  NVL (QT_WIP_HARD_QTY, 0),
                  NVL (QT_W999_QTY, 0),
                  MAX_MCPR_PC_CONS_QTY,
                  MAX_MCPR_PC_INB_QTY,
                  MAX_MCPR_PC_QLTY_AREA_QTY,
                  MAX_MCPR_PC_DEC_AREA_QTY,
                  MAX_MCPR_QT_EXT_QTY,
                  MAX_MCPR_QT_OTHER_QTY,
                  MAX_MCPR_PC_WIP_LN_QTY,
                  MAX_MCPR_PC_WIP_HARD_QTY,
                  MAX_MCPR_PC_STOCK_QTY,
                  MAX_MCPR_PC_W999_QTY)
      GROUP BY CD_PLANT,
               CD_PART_NBR)) QRY