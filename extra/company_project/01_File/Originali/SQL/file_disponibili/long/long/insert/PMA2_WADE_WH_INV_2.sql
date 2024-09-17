INSERT INTO DDWH02_DM_MA.TFCT_WADE_WH_INV TRG (WADE_CD_PLANT_CD, WADE_ID_WADE, WADE_ID_TIME_INV_DT, WADE_CD_BIN, WADE_CD_BIN_SECT, WADE_ID_BINT_BIN_TP, WADE_CD_BIN_TP, WADE_ID_BINT_CON_TP, WADE_CD_CON_TP, WADE_ID_SITE_SITE, WADE_CD_SITE, WADE_ID_MTRL_MATERIAL, WADE_CD_PART_NBR, WADE_ID_LOTP_BIN_LOC_TP, WADE_CD_BIN_LOC_TP, WADE_CD_BIN_LOC_GRP, WADE_ID_AREA_BIN_AREA, WADE_CD_BIN_AREA, WADE_ID_STAT_INV_STU, WADE_CD_INV_STU, WADE_ID_LMST_MAT_STU, WADE_CD_MAT_STU, WADE_ID_VEND_MAT_PROP, WADE_CD_MAT_PROP, WADE_ID_BLRE_BLOCKING_REAS, WADE_CD_BLOCKING_REAS, WADE_ID_VEHI_VEHICLE, WADE_CD_VEHICLE, WADE_ID_PLST_WCTR_CD, WADE_CD_WCTR_CD, WADE_CD_CONT, WADE_CD_BIN_LOC, WADE_CD_BIN_BUILDING, WADE_CD_ORD_N, WADE_CD_ORD_TP, WADE_CD_ORD_LN, WADE_CD_DLVR_NT, WADE_CD_DLVR_NT_LN, WADE_CD_SUPPL_DLVR_NT, WADE_ID_TIME_SUPPL_DLVR_NT_DT, WADE_DT_SUPPL_DLVR_NT_DT, WADE_ID_VEND_SUPPL_CD, WADE_CD_SUPPL_CD, WADE_CD_EFF_ORD, WADE_CD_OP, WADE_QT_BIN_QTY, WADE_QT_RES_QTY, WADE_QT_REFIL_QTY, WADE_NR_WD_NBR, WADE_NR_AGING_CQA, WADE_DT_CREAT_DT, WADE_DT_FIFO_DT, WADE_ID_TIME_LAST_MOV_BIN_DT, WADE_DT_LAST_MOV_BIN_DT, WADE_ID_TIME_LAST_CYCLE_DT, WADE_DT_LAST_CYCLE_DT, WADE_NR_AGING_LAST_MOV, WADE_NR_AGING_LAST_CYCLE, WADE_CD_AGING_CAT, WADE_ID_BATCH_ID, WADE_CD_SOURCE_SYSTEM, WADE_CD_OPERATOR_CODE, WADE_DT_INS_ROW, WADE_DT_UPD_ROW)
SELECT QRY.WADE_CD_PLANT_CD,
       QRY.WADE_ID_WADE,
       QRY.WADE_ID_TIME_INV_DT,
       QRY.WADE_CD_BIN,
       QRY.WADE_CD_BIN_SECT,
       QRY.WADE_ID_BINT_BIN_TP,
       QRY.WADE_CD_BIN_TP,
       QRY.WADE_ID_BINT_CON_TP,
       QRY.WADE_CD_CON_TP,
       QRY.WADE_ID_SITE_SITE,
       QRY.WADE_CD_SITE,
       QRY.WADE_ID_MTRL_MATERIAL,
       QRY.WADE_CD_PART_NBR,
       QRY.WADE_ID_LOTP_BIN_LOC_TP,
       QRY.WADE_CD_BIN_LOC_TP,
       QRY.WADE_CD_BIN_LOC_GRP,
       QRY.WADE_ID_AREA_BIN_AREA,
       QRY.WADE_CD_BIN_AREA,
       QRY.WADE_ID_STAT_INV_STU,
       QRY.WADE_CD_INV_STU,
       QRY.WADE_ID_LMST_MAT_STU,
       QRY.WADE_CD_MAT_STU,
       QRY.WADE_ID_VEND_MAT_PROP,
       QRY.WADE_CD_MAT_PROP,
       QRY.WADE_ID_BLRE_BLOCKING_REAS,
       QRY.WADE_CD_BLOCKING_REAS,
       QRY.WADE_ID_VEHI_VEHICLE,
       QRY.WADE_CD_VEHICLE,
       QRY.WADE_ID_PLST_WCTR_CD,
       QRY.WADE_CD_WCTR_CD,
       QRY.WADE_CD_CONT,
       QRY.WADE_CD_BIN_LOC,
       QRY.WADE_CD_BIN_BUILDING,
       QRY.WADE_CD_ORD_N,
       QRY.WADE_CD_ORD_TP,
       QRY.WADE_CD_ORD_LN,
       QRY.WADE_CD_DLVR_NT,
       QRY.WADE_CD_DLVR_NT_LN,
       QRY.WADE_CD_SUPPL_DLVR_NT,
       QRY.WADE_ID_TIME_SUPPL_DLVR_NT_DT,
       QRY.WADE_DT_SUPPL_DLVR_NT_DT,
       QRY.WADE_ID_VEND_SUPPL_CD,
       QRY.WADE_CD_SUPPL_CD,
       QRY.WADE_CD_EFF_ORD,
       QRY.WADE_CD_OP,
       QRY.WADE_QT_BIN_QTY,
       QRY.WADE_QT_RES_QTY,
       QRY.WADE_QT_REFIL_QTY,
       QRY.WADE_NR_WD_NBR,
       QRY.WADE_NR_AGING_CQA,
       QRY.WADE_DT_CREAT_DT,
       QRY.WADE_DT_FIFO_DT,
       QRY.WADE_ID_TIME_LAST_MOV_BIN_DT,
       QRY.WADE_DT_LAST_MOV_BIN_DT,
       QRY.WADE_ID_TIME_LAST_CYCLE_DT,
       QRY.WADE_DT_LAST_CYCLE_DT,
       QRY.WADE_NR_AGING_LAST_MOV,
       QRY.WADE_NR_AGING_LAST_CYCLE,
       QRY.WADE_CD_AGING_CAT,
       QRY.WADE_ID_BATCH_ID,
       QRY.WADE_CD_SOURCE_SYSTEM,
       'ETL',
       SYSDATE,
       SYSDATE
FROM
  (SELECT WADE_CD_PLANT_CD,
          WADE_ID_WADE,
          WADE_ID_TIME_INV_DT,
          WADE_CD_BIN,
          WADE_CD_BIN_SECT,
          WADE_ID_BINT_BIN_TP,
          WADE_CD_BIN_TP,
          WADE_ID_BINT_CON_TP,
          WADE_CD_CON_TP,
          WADE_ID_SITE_SITE,
          WADE_CD_SITE,
          WADE_ID_MTRL_MATERIAL,
          WADE_CD_PART_NBR,
          WADE_ID_LOTP_BIN_LOC_TP,
          WADE_CD_BIN_LOC_TP,
          WADE_CD_BIN_LOC_GRP,
          WADE_ID_AREA_BIN_AREA,
          WADE_CD_BIN_AREA,
          WADE_ID_STAT_INV_STU,
          WADE_CD_INV_STU,
          WADE_ID_LMST_MAT_STU,
          WADE_CD_MAT_STU,
          WADE_ID_VEND_MAT_PROP,
          WADE_CD_MAT_PROP,
          WADE_ID_BLRE_BLOCKING_REAS,
          WADE_CD_BLOCKING_REAS,
          WADE_ID_VEHI_VEHICLE,
          WADE_CD_VEHICLE,
          WADE_ID_PLST_WCTR_CD,
          WADE_CD_WCTR_CD,
          WADE_CD_CONT,
          WADE_CD_BIN_LOC,
          WADE_CD_BIN_BUILDING,
          WADE_CD_ORD_N,
          WADE_CD_ORD_TP,
          WADE_CD_ORD_LN,
          WADE_CD_DLVR_NT,
          WADE_CD_DLVR_NT_LN,
          WADE_CD_SUPPL_DLVR_NT,
          WADE_ID_TIME_SUPPL_DLVR_NT_DT,
          WADE_DT_SUPPL_DLVR_NT_DT,
          WADE_ID_VEND_SUPPL_CD,
          WADE_CD_SUPPL_CD,
          WADE_CD_EFF_ORD,
          WADE_CD_OP,
          WADE_QT_BIN_QTY,
          WADE_QT_RES_QTY,
          WADE_QT_REFIL_QTY,
          WADE_NR_WD_NBR,
          WADE_NR_AGING_CQA,
          WADE_DT_CREAT_DT,
          WADE_DT_FIFO_DT,
          WADE_ID_TIME_LAST_MOV_BIN_DT,
          WADE_DT_LAST_MOV_BIN_DT,
          WADE_ID_TIME_LAST_CYCLE_DT,
          WADE_DT_LAST_CYCLE_DT,
          CASE
              WHEN WADE_NR_AGING_LAST_MOV < 0 THEN 0
              ELSE WADE_NR_AGING_LAST_MOV
          END,
          CASE
              WHEN WADE_NR_AGING_LAST_CYCLE < 0 THEN 0
              ELSE WADE_NR_AGING_LAST_CYCLE
          END,
          CASE
              WHEN WADE_NR_AGING_LAST_MOV < 0 THEN 0
              ELSE WADE_NR_AGING_LAST_MOV
          END WADE_NR_AGING_LAST_MOV,
          CASE
              WHEN WADE_NR_AGING_LAST_CYCLE < 0 THEN 0
              ELSE WADE_NR_AGING_LAST_CYCLE
          END WADE_NR_AGING_LAST_CYCLE,
          TW_MCAC_MC_AGING_CAT.MCAC_CD_AGING_CAT AS WADE_CD_AGING_CAT,
          WADE_ID_BATCH_ID,
          WADE_CD_SOURCE_SYSTEM,
          WADE_CD_OPERATOR_CODE
   FROM
     (SELECT WADE_CD_PLANT_CD,
             WADE_ID_WADE,
             WADE_ID_TIME_INV_DT,
             WADE_CD_BIN,
             WADE_CD_BIN_SECT,
             WADE_ID_BINT_BIN_TP,
             WADE_CD_BIN_TP,
             WADE_ID_BINT_CON_TP,
             WADE_CD_CON_TP,
             WADE_ID_SITE_SITE,
             WADE_CD_SITE,
             WADE_ID_MTRL_MATERIAL,
             WADE_CD_PART_NBR,
             WADE_ID_LOTP_BIN_LOC_TP,
             WADE_CD_BIN_LOC_TP,
             WADE_CD_BIN_LOC_GRP,
             WADE_ID_AREA_BIN_AREA,
             WADE_CD_BIN_AREA,
             WADE_ID_STAT_INV_STU,
             WADE_CD_INV_STU,
             WADE_ID_LMST_MAT_STU,
             WADE_CD_MAT_STU,
             WADE_ID_VEND_MAT_PROP,
             WADE_CD_MAT_PROP,
             WADE_ID_BLRE_BLOCKING_REAS,
             WADE_CD_BLOCKING_REAS,
             WADE_ID_VEHI_VEHICLE,
             WADE_CD_VEHICLE,
             WADE_ID_PLST_WCTR_CD,
             WADE_CD_WCTR_CD,
             WADE_CD_CONT,
             WADE_CD_BIN_LOC,
             WADE_CD_BIN_BUILDING,
             WADE_CD_ORD_N,
             WADE_CD_ORD_TP,
             WADE_CD_ORD_LN,
             WADE_CD_DLVR_NT,
             WADE_CD_DLVR_NT_LN,
             WADE_CD_SUPPL_DLVR_NT,
             WADE_ID_TIME_SUPPL_DLVR_NT_DT,
             WADE_DT_SUPPL_DLVR_NT_DT,
             WADE_ID_VEND_SUPPL_CD,
             WADE_CD_SUPPL_CD,
             WADE_CD_EFF_ORD,
             WADE_CD_OP,
             WADE_QT_BIN_QTY,
             WADE_QT_RES_QTY,
             WADE_QT_REFIL_QTY,
             WADE_NR_WD_NBR,
             WADE_NR_AGING_CQA,
             WADE_DT_CREAT_DT,
             WADE_DT_FIFO_DT,
             WADE_ID_TIME_LAST_MOV_BIN_DT,
             WADE_DT_LAST_MOV_BIN_DT,
             WADE_ID_TIME_LAST_CYCLE_DT,
             WADE_DT_LAST_CYCLE_DT,
             (TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') - TRUNC (WADE_DT_LAST_MOV_BIN_DT) - DDWH01_DW_MA.PKG_CALENDAR.GETNOTWORKINGDAY (P_ELT_CD_PLANT, WADE_DT_LAST_MOV_BIN_DT, TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'))) AS WADE_NR_AGING_LAST_MOV,
             CASE
                 WHEN WADE_DT_CREAT_DT > NVL (WORKING_LAST_CYCLE_DT, TO_DATE ('19700101', 'YYYYMMDD')) THEN (TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') - TRUNC (WADE_DT_CREAT_DT) - DDWH01_DW_MA.PKG_CALENDAR.GETNOTWORKINGDAY (P_ELT_CD_PLANT, WADE_DT_CREAT_DT, TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD')))
                 ELSE (TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') - TRUNC (NVL (WORKING_LAST_CYCLE_DT, WADE_DT_CREAT_DT)) - DDWH01_DW_MA.PKG_CALENDAR.GETNOTWORKINGDAY (P_ELT_CD_PLANT, NVL (WORKING_LAST_CYCLE_DT, WADE_DT_CREAT_DT), TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD')))
             END AS WADE_NR_AGING_LAST_CYCLE,
             WADE_ID_BATCH_ID,
             WADE_CD_SOURCE_SYSTEM,
             WADE_CD_OPERATOR_CODE
      FROM
        (SELECT WADE_CD_PLANT_CD,
                WADE_ID_WADE,
                WADE_ID_TIME_INV_DT,
                WADE_CD_BIN,
                WADE_CD_BIN_SECT,
                WADE_ID_BINT_BIN_TP,
                WADE_CD_BIN_TP,
                WADE_ID_BINT_CON_TP,
                WADE_CD_CON_TP,
                WADE_ID_SITE_SITE,
                WADE_CD_SITE,
                WADE_ID_MTRL_MATERIAL,
                WADE_CD_PART_NBR,
                WADE_ID_LOTP_BIN_LOC_TP,
                WADE_CD_BIN_LOC_TP,
                WADE_CD_BIN_LOC_GRP,
                WADE_ID_AREA_BIN_AREA,
                WADE_CD_BIN_AREA,
                WADE_ID_STAT_INV_STU,
                WADE_CD_INV_STU,
                WADE_ID_LMST_MAT_STU,
                WADE_CD_MAT_STU,
                WADE_ID_VEND_MAT_PROP,
                WADE_CD_MAT_PROP,
                WADE_ID_BLRE_BLOCKING_REAS,
                WADE_CD_BLOCKING_REAS,
                WADE_ID_VEHI_VEHICLE,
                WADE_CD_VEHICLE,
                WADE_ID_PLST_WCTR_CD,
                WADE_CD_WCTR_CD,
                WADE_CD_CONT,
                WADE_CD_BIN_LOC,
                WADE_CD_BIN_BUILDING,
                WADE_CD_ORD_N,
                WADE_CD_ORD_TP,
                WADE_CD_ORD_LN,
                WADE_CD_DLVR_NT,
                WADE_CD_DLVR_NT_LN,
                WADE_CD_SUPPL_DLVR_NT,
                WADE_ID_TIME_SUPPL_DLVR_NT_DT,
                WADE_DT_SUPPL_DLVR_NT_DT,
                WADE_ID_VEND_SUPPL_CD,
                WADE_CD_SUPPL_CD,
                WADE_CD_EFF_ORD,
                WADE_CD_OP,
                WADE_QT_BIN_QTY,
                WADE_QT_RES_QTY,
                WADE_QT_REFIL_QTY,
                WADE_NR_WD_NBR,
                WADE_NR_AGING_CQA,
                WADE_DT_CREAT_DT,
                WADE_DT_FIFO_DT,
                WADE_DT_LAST_MOV_BIN_DT,
                NVL (TO_NUMBER (TO_CHAR (WADE_DT_LAST_MOV_BIN_DT, 'J')), -2) AS WADE_ID_TIME_LAST_MOV_BIN_DT,
                WADE_DT_LAST_CYCLE_DT,
                NVL (TO_NUMBER (TO_CHAR (WADE_DT_LAST_CYCLE_DT, 'J')), -2) AS WADE_ID_TIME_LAST_CYCLE_DT,
                CASE
                    WHEN WADE_DT_LAST_CYCLE_DT IS NULL
                         OR WADE_DT_LAST_CYCLE_DT < WADE_DT_LAST_MOV_BIN_DT THEN WADE_DT_LAST_MOV_BIN_DT
                    ELSE WADE_DT_LAST_CYCLE_DT
                END AS WORKING_LAST_CYCLE_DT,
                WADE_ID_BATCH_ID,
                WADE_CD_SOURCE_SYSTEM,
                WADE_CD_OPERATOR_CODE
         FROM
           (SELECT WINV_CD_PLANT_CD AS WADE_CD_PLANT_CD,
                   TH_WINV_WH_INV.WINV_ID_WH_INV AS WADE_ID_WADE,
                   TH_WINV_WH_INV.WADE_ID_TIME_INV_DT AS WADE_ID_TIME_INV_DT,
                   TH_WINV_WH_INV.WINV_CD_BIN AS WADE_CD_BIN,
                   TH_WINV_WH_INV.WINV_CD_BIN_SECT AS WADE_CD_BIN_SECT,
                   TH_WINV_WH_INV.WINV_ID_BTMD_BIN_TP AS WADE_ID_BINT_BIN_TP,
                   TH_WINV_WH_INV.WINV_CD_BIN_TP AS WADE_CD_BIN_TP,
                   TH_WINV_WH_INV.WINV_ID_BTMD_CONT_TP AS WADE_ID_BINT_CON_TP,
                   TH_WINV_WH_INV.WINV_CD_CONT_TP AS WADE_CD_CON_TP,
                   TH_WINV_WH_INV.WINV_ID_STMD_SITE AS WADE_ID_SITE_SITE,
                   TH_WINV_WH_INV.WINV_CD_SITE AS WADE_CD_SITE,
                   TH_WINV_WH_INV.WINV_ID_MAMD_PART_NBR AS WADE_ID_MTRL_MATERIAL,
                   TH_WINV_WH_INV.WINV_CD_PART_NBR AS WADE_CD_PART_NBR,
                   TH_WINV_WH_INV.WINV_ID_LTMD_BIN_LOC_TP AS WADE_ID_LOTP_BIN_LOC_TP,
                   TH_WINV_WH_INV.WINV_CD_BIN_LOC_TP AS WADE_CD_BIN_LOC_TP,
                   CASE
                       WHEN TH_WINV_WH_INV.WINV_CD_MAT_STU IN ('DISPONIBILE',
                                                               'VERIFICA')
                            AND TH_WINV_WH_INV.WINV_CD_BIN_LOC_TP NOT IN ('USC') THEN CASE
                                                                                          WHEN TH_WINV_WH_INV.WINV_CD_BIN_LOC_TP IN ('ING')
                                                                                               AND NVL (TM_STMD_SITE_MASTER.STMD_CD_SITE_INT, '00001') = '00001' THEN 'INB'
                                                                                          WHEN TH_WINV_WH_INV.WINV_CD_BIN_LOC_TP IN ('CQA')
                                                                                               AND NVL (TM_STMD_SITE_MASTER.STMD_CD_SITE_INT, '00001') = '00001' THEN 'QLTY'
                                                                                          WHEN TH_WINV_WH_INV.WINV_CD_BIN_LOC_TP IN ('TRV')
                                                                                               AND NVL (TM_STMD_SITE_MASTER.STMD_CD_SITE_INT, '00001') = '00001' THEN 'DEC'
                                                                                          WHEN TH_WINV_WH_INV.WINV_CD_BIN_LOC_TP IN ('LOG',
                                                                                                                                     'STC',
                                                                                                                                     'LIN')
                                                                                               AND NVL (TM_STMD_SITE_MASTER.STMD_CD_SITE_INT, '00001') = '00001' THEN 'STOCK'
                                                                                          WHEN NVL (TM_STMD_SITE_MASTER.STMD_CD_SITE_INT, '00001') <> '00001' THEN 'EXT'
                                                                                          WHEN TH_WINV_WH_INV.WINV_CD_BIN_LOC_TP NOT IN ('ING',
                                                                                                                                         'CQA',
                                                                                                                                         'TRV',
                                                                                                                                         'LOG',
                                                                                                                                         'STC',
                                                                                                                                         'LIN')
                                                                                               AND NVL (TM_STMD_SITE_MASTER.STMD_CD_SITE_INT, '00001') = '00001' THEN 'OTHER'
                                                                                      END
                       ELSE NULL
                   END AS WADE_CD_BIN_LOC_GRP,
                   TH_WINV_WH_INV.WINV_ID_ATMD_BIN_AREA AS WADE_ID_AREA_BIN_AREA,
                   TH_WINV_WH_INV.WINV_CD_BIN_AREA AS WADE_CD_BIN_AREA,
                   TH_WINV_WH_INV.WINV_ID_SUMD_INV_STU AS WADE_ID_STAT_INV_STU,
                   TH_WINV_WH_INV.WINV_CD_INV_STU AS WADE_CD_INV_STU,
                   TH_WINV_WH_INV.WINV_ID_MUMD_MAT_STU AS WADE_ID_LMST_MAT_STU,
                   TH_WINV_WH_INV.WINV_CD_MAT_STU AS WADE_CD_MAT_STU,
                   TH_WINV_WH_INV.WINV_ID_VEND_MAT_PROP AS WADE_ID_VEND_MAT_PROP,
                   TH_WINV_WH_INV.WINV_CD_MAT_PROP AS WADE_CD_MAT_PROP,
                   TH_WINV_WH_INV.WINV_ID_BRMD_BLOCKING_REAS AS WADE_ID_BLRE_BLOCKING_REAS,
                   TH_WINV_WH_INV.WINV_CD_BLOCKING_REAS AS WADE_CD_BLOCKING_REAS,
                   TH_WINV_WH_INV.WINV_ID_VHMD_VAN AS WADE_ID_VEHI_VEHICLE,
                   TH_WINV_WH_INV.WINV_CD_VAN AS WADE_CD_VEHICLE,
                   TH_WINV_WH_INV.WINV_ID_PLMD_WCTR_CD AS WADE_ID_PLST_WCTR_CD,
                   TH_WINV_WH_INV.WINV_CD_WCTR_CD AS WADE_CD_WCTR_CD,
                   TH_WINV_WH_INV.WINV_CD_CONT AS WADE_CD_CONT,
                   TH_WINV_WH_INV.WINV_CD_BIN_LOC AS WADE_CD_BIN_LOC,
                   TH_WINV_WH_INV.WINV_CD_BIN_BUILDING AS WADE_CD_BIN_BUILDING,
                   TH_WINV_WH_INV.WINV_CD_ORD_N AS WADE_CD_ORD_N,
                   TH_WINV_WH_INV.WINV_CD_ORD_TP AS WADE_CD_ORD_TP,
                   TH_WINV_WH_INV.WINV_CD_ORD_LN AS WADE_CD_ORD_LN,
                   TH_WINV_WH_INV.WINV_CD_DLVR_NT AS WADE_CD_DLVR_NT,
                   TH_WINV_WH_INV.WINV_CD_DLVR_NT_LN AS WADE_CD_DLVR_NT_LN,
                   TD_INDN_INB_DLVR_NT.INDN_CD_SUPPL_DLVR_NT AS WADE_CD_SUPPL_DLVR_NT,
                   NVL (TO_NUMBER (TO_CHAR (TD_INDN_INB_DLVR_NT.INDN_DT_SUPPL_DLVR_NT_DT, 'J')), -2) AS WADE_ID_TIME_SUPPL_DLVR_NT_DT,
                   TD_INDN_INB_DLVR_NT.INDN_DT_SUPPL_DLVR_NT_DT AS WADE_DT_SUPPL_DLVR_NT_DT,
                   NVL (TD_INDN_INB_DLVR_NT.INDN_ID_VEND_SUPPL_CD, -2) AS WADE_ID_VEND_SUPPL_CD,
                   TD_INDN_INB_DLVR_NT.INDN_CD_SUPPL_CD AS WADE_CD_SUPPL_CD,
                   TH_WINV_WH_INV.WINV_CD_EFF_ORD AS WADE_CD_EFF_ORD,
                   TH_WINV_WH_INV.WINV_CD_OP AS WADE_CD_OP,
                   TH_WINV_WH_INV.WINV_QT_BIN_QTY AS WADE_QT_BIN_QTY,
                   TH_WINV_WH_INV.WINV_QT_RES_QTY AS WADE_QT_RES_QTY,
                   TH_WINV_WH_INV.WINV_QT_REFIL_QTY AS WADE_QT_REFIL_QTY,
                   TH_WINV_WH_INV.WADE_NR_WD_NBR AS WADE_NR_WD_NBR,
                   TH_WINV_WH_INV.WADE_NR_AGING_CQA AS WADE_NR_AGING_CQA,
                   TH_WINV_WH_INV.WINV_DT_CREAT_DT AS WADE_DT_CREAT_DT,
                   TH_WINV_WH_INV.WINV_DT_FIFO_DT AS WADE_DT_FIFO_DT,
                   CASE
                       WHEN TD_INMO_MAT_MOVE.INMO_DT_MOV_END_EXEC_DT IS NOT NULL
                            AND TD_INMO_MAT_MOVE_NVL.INMO_DT_MOV_END_EXEC_DT IS NOT NULL THEN CASE
                                                                                                  WHEN TD_INMO_MAT_MOVE.INMO_DT_MOV_END_EXEC_DT > TD_INMO_MAT_MOVE_NVL.INMO_DT_MOV_END_EXEC_DT THEN TD_INMO_MAT_MOVE.INMO_DT_MOV_END_EXEC_DT
                                                                                                  ELSE TD_INMO_MAT_MOVE_NVL.INMO_DT_MOV_END_EXEC_DT
                                                                                              END
                       WHEN TD_INMO_MAT_MOVE.INMO_DT_MOV_END_EXEC_DT IS NOT NULL
                            AND TD_INMO_MAT_MOVE_NVL.INMO_DT_MOV_END_EXEC_DT IS NULL THEN TD_INMO_MAT_MOVE.INMO_DT_MOV_END_EXEC_DT
                       WHEN TD_INMO_MAT_MOVE.INMO_DT_MOV_END_EXEC_DT IS NULL
                            AND TD_INMO_MAT_MOVE_NVL.INMO_DT_MOV_END_EXEC_DT IS NOT NULL THEN TD_INMO_MAT_MOVE_NVL.INMO_DT_MOV_END_EXEC_DT
                       WHEN TD_INMO_MAT_MOVE.INMO_DT_MOV_END_EXEC_DT IS NULL
                            AND TD_INMO_MAT_MOVE_NVL.INMO_DT_MOV_END_EXEC_DT IS NULL THEN NULL
                   END AS WADE_DT_LAST_MOV_BIN_DT,
                   TM_LMMD_LOGISTIC_MATERIALS.LMMD_DT_LAST_CYCLE_DT AS WADE_DT_LAST_CYCLE_DT,
                   NVL (P_ELT_ID_BATCH, N_ELT_ID_JOB_LOG) AS WADE_ID_BATCH_ID,
                   TH_WINV_WH_INV.WINV_CD_SOURCE_SYSTEM AS WADE_CD_SOURCE_SYSTEM,
                   TH_WINV_WH_INV.WINV_CD_OPERATOR_CODE AS WADE_CD_OPERATOR_CODE
            FROM
              (SELECT WINV_CD_PLANT_CD,
                      WINV_ID_INDN_INB_DLVR_NT,
                      WINV_ID_WH_INV,
                      NVL (TO_NUMBER (TO_CHAR (WINV_DT_INV_DT, 'J')), -2) AS WADE_ID_TIME_INV_DT,
                      WINV_CD_BIN,
                      WINV_CD_BIN_SECT,
                      WINV_ID_BTMD_BIN_TP,
                      WINV_CD_BIN_TP,
                      WINV_ID_BTMD_CONT_TP,
                      WINV_CD_CONT_TP,
                      WINV_ID_STMD_SITE,
                      WINV_CD_SITE,
                      WINV_ID_MAMD_PART_NBR,
                      WINV_CD_PART_NBR,
                      WINV_ID_LTMD_BIN_LOC_TP,
                      WINV_CD_BIN_LOC_TP,
                      WINV_ID_ATMD_BIN_AREA,
                      WINV_CD_BIN_AREA,
                      WINV_ID_SUMD_INV_STU,
                      WINV_CD_INV_STU,
                      WINV_ID_MUMD_MAT_STU,
                      WINV_CD_MAT_STU,
                      WINV_ID_VEND_MAT_PROP,
                      WINV_CD_MAT_PROP,
                      WINV_ID_BRMD_BLOCKING_REAS,
                      WINV_CD_BLOCKING_REAS,
                      WINV_ID_VHMD_VAN,
                      WINV_CD_VAN,
                      WINV_ID_PLMD_WCTR_CD,
                      WINV_CD_WCTR_CD,
                      WINV_CD_CONT,
                      WINV_CD_BIN_LOC,
                      WINV_CD_BIN_BUILDING,
                      WINV_CD_ORD_N,
                      WINV_CD_ORD_TP,
                      WINV_CD_ORD_LN,
                      WINV_CD_DLVR_NT,
                      WINV_CD_DLVR_NT_LN,
                      WINV_CD_EFF_ORD,
                      WINV_CD_OP,
                      WINV_QT_BIN_QTY,
                      WINV_QT_RES_QTY,
                      WINV_QT_REFIL_QTY,

                 (SELECT COUNT (*)
                  FROM DDWH01_DW_MA.TM_PCAL_PLANT_CALENDAR
                  WHERE PCAL_PC_WK_DAY_PERCENT>0
                    AND PCAL_DT_DAY BETWEEN WINV_DT_CREAT_DT AND WINV_DT_INV_DT
                    AND PCAL_CD_PLANT_CD = 'BZ01' ) AS WADE_NR_WD_NBR,
                      CASE
                          WHEN WINV_CD_MAT_STU != 'VERIFICA'
                               OR WINV_CD_BIN_LOC_TP = 'CQA' THEN 0
                          WHEN MACS_DT_CHG_STU_DT IS NOT NULL
                               AND MACS_CD_MAT_STU_TO = 'VERIFICA' THEN GREATEST (0, TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') - TRUNC (MACS_DT_CHG_STU_DT) - DDWH01_DW_MA.PKG_CALENDAR.GETNOTWORKINGDAY (P_ELT_CD_PLANT, TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'), TRUNC (MACS_DT_CHG_STU_DT)))
                          WHEN MACS_DT_CHG_STU_DT IS NOT NULL
                               AND MACS_CD_MAT_STU_TO != 'VERIFICA' THEN NULL
                          ELSE GREATEST (0, TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') - TRUNC (WINV_DT_CREAT_DT) - DDWH01_DW_MA.PKG_CALENDAR.GETNOTWORKINGDAY (P_ELT_CD_PLANT, TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'), TRUNC (WINV_DT_CREAT_DT)))
                      END WADE_NR_AGING_CQA,
                      WINV_DT_CREAT_DT,
                      WINV_DT_FIFO_DT,
                      WINV_ID_BATCH_ID,
                      WINV_CD_SOURCE_SYSTEM,
                      WINV_CD_OPERATOR_CODE
               FROM DDWH01_DW_MA.TH_WINV_WH_INV,

                 (SELECT MACS_CD_BIN,
                         MACS_CD_BIN_SECT,
                         MAX (MACS_CD_MAT_STU_TO) KEEP (DENSE_RANK FIRST
                                                        ORDER BY MACS_DT_CHG_STU_DT DESC NULLS LAST) MACS_CD_MAT_STU_TO,
                                                  MAX (MACS_DT_CHG_STU_DT) KEEP (DENSE_RANK FIRST
                                                                                 ORDER BY MACS_DT_CHG_STU_DT DESC NULLS LAST) MACS_DT_CHG_STU_DT
                  FROM DDWH01_DW_MA.TH_MACS_MAT_CHNG_STU
                  WHERE MACS_CD_PLANT_CD = P_ELT_CD_PLANT
                  GROUP BY MACS_CD_BIN,
                           MACS_CD_BIN_SECT) TH_MACS_MAT_CHNG_STU
               WHERE MACS_CD_BIN (+) = WINV_CD_BIN
                 AND MACS_CD_BIN_SECT (+) = WINV_CD_BIN_SECT ) TH_WINV_WH_INV,

              (SELECT *
               FROM DDWH01_DW_MA.TD_INDN_INB_DLVR_NT
               WHERE INDN_CD_PLANT_CD = P_ELT_CD_PLANT ) TD_INDN_INB_DLVR_NT,

              (SELECT CASE
                          WHEN INMO_CD_BIN_SRC IS NULL THEN INMO_CD_BIN_DEST
                          ELSE INMO_CD_BIN_SRC
                      END AS INMO_CD_BIN,
                      CASE
                          WHEN INMO_CD_BIN_SRC IS NULL THEN INMO_CD_BIN_SECT_DEST
                          ELSE INMO_CD_BIN_SECT_SRC
                      END AS INMO_CD_BIN_SECT,
                      CASE
                          WHEN SRC.INMO_DT_MOV_END_EXEC_DT IS NULL
                               AND DEST.INMO_DT_MOV_END_EXEC_DT IS NOT NULL THEN DEST.INMO_DT_MOV_END_EXEC_DT
                          WHEN SRC.INMO_DT_MOV_END_EXEC_DT IS NOT NULL
                               AND DEST.INMO_DT_MOV_END_EXEC_DT IS NULL THEN SRC.INMO_DT_MOV_END_EXEC_DT
                          WHEN SRC.INMO_DT_MOV_END_EXEC_DT IS NOT NULL
                               AND DEST.INMO_DT_MOV_END_EXEC_DT IS NOT NULL THEN CASE
                                                                                     WHEN SRC.INMO_DT_MOV_END_EXEC_DT > DEST.INMO_DT_MOV_END_EXEC_DT THEN SRC.INMO_DT_MOV_END_EXEC_DT
                                                                                     ELSE DEST.INMO_DT_MOV_END_EXEC_DT
                                                                                 END
                      END AS INMO_DT_MOV_END_EXEC_DT
               FROM
                 (SELECT INMO_DT_MOV_END_EXEC_DT_MAX AS INMO_DT_MOV_END_EXEC_DT,
                         INMO_CD_BIN_SRC,
                         INMO_CD_BIN_SECT_SRC
                  FROM
                    (SELECT ROW_NUMBER () OVER (PARTITION BY INMO_CD_BIN_SRC,
                                                             INMO_CD_BIN_SECT_SRC
                                                ORDER BY INMO_DT_MOV_END_EXEC_DT DESC) AS INMO_ROW_NUMBER,
                                               MAX (INMO_DT_MOV_END_EXEC_DT) KEEP (DENSE_RANK LAST
                                                                                   ORDER BY INMO_DT_MOV_END_EXEC_DT) OVER (PARTITION BY INMO_CD_BIN_SRC,
                                                                                                                                        INMO_CD_BIN_SECT_SRC) AS INMO_DT_MOV_END_EXEC_DT_MAX,
                                                                                                                          INMO_DT_MOV_END_EXEC_DT,
                                                                                                                          INMO_CD_BIN_SRC,
                                                                                                                          INMO_CD_BIN_SECT_SRC
                     FROM DDWH01_DW_MA.TD_INMO_MAT_MOVE
                     WHERE INMO_CD_PLANT_CD = P_ELT_CD_PLANT
                       AND INMO_FL_LOGICAL_STATUS = '1'
                       AND INMO_CD_BIN_SRC IS NOT NULL
                       AND INMO_DT_MOV_END_EXEC_DT IS NOT NULL
                       AND INMO_CD_MOV_TP NOT IN ('MSK',
                                                  'MSU',
                                                  'EVC',
                                                  'DEL') )
                  WHERE INMO_ROW_NUMBER = 1 ) SRC
               FULL OUTER JOIN
                 (SELECT INMO_DT_MOV_END_EXEC_DT_MAX AS INMO_DT_MOV_END_EXEC_DT,
                         INMO_CD_BIN_DEST,
                         INMO_CD_BIN_SECT_DEST
                  FROM
                    (SELECT ROW_NUMBER () OVER (PARTITION BY INMO_CD_BIN_DEST,
                                                             INMO_CD_BIN_SECT_DEST
                                                ORDER BY INMO_DT_MOV_END_EXEC_DT DESC) AS INMO_ROW_NUMBER,
                                               MAX (INMO_DT_MOV_END_EXEC_DT) KEEP (DENSE_RANK LAST
                                                                                   ORDER BY INMO_DT_MOV_END_EXEC_DT) OVER (PARTITION BY INMO_CD_BIN_DEST,
                                                                                                                                        INMO_CD_BIN_SECT_DEST) AS INMO_DT_MOV_END_EXEC_DT_MAX,
                                                                                                                          INMO_DT_MOV_END_EXEC_DT,
                                                                                                                          INMO_CD_BIN_DEST,
                                                                                                                          INMO_CD_BIN_SECT_DEST
                     FROM DDWH01_DW_MA.TD_INMO_MAT_MOVE
                     WHERE INMO_CD_PLANT_CD = P_ELT_CD_PLANT
                       AND INMO_FL_LOGICAL_STATUS = '1'
                       AND INMO_CD_BIN_DEST IS NOT NULL
                       AND INMO_DT_MOV_END_EXEC_DT IS NOT NULL
                       AND INMO_CD_MOV_TP NOT IN ('MSK',
                                                  'MSU',
                                                  'EVC',
                                                  'DEL') )
                  WHERE INMO_ROW_NUMBER = 1 ) DEST ON SRC.INMO_CD_BIN_SRC = DEST.INMO_CD_BIN_DEST
               AND SRC.INMO_CD_BIN_SECT_SRC = DEST.INMO_CD_BIN_SECT_DEST) TD_INMO_MAT_MOVE,

              (SELECT CASE
                          WHEN INMO_CD_BIN_SRC IS NULL THEN INMO_CD_BIN_DEST
                          ELSE INMO_CD_BIN_SRC
                      END AS INMO_CD_BIN,
                      CASE
                          WHEN SRC.INMO_DT_MOV_END_EXEC_DT IS NULL
                               AND DEST.INMO_DT_MOV_END_EXEC_DT IS NOT NULL THEN DEST.INMO_DT_MOV_END_EXEC_DT
                          WHEN SRC.INMO_DT_MOV_END_EXEC_DT IS NOT NULL
                               AND DEST.INMO_DT_MOV_END_EXEC_DT IS NULL THEN SRC.INMO_DT_MOV_END_EXEC_DT
                          WHEN SRC.INMO_DT_MOV_END_EXEC_DT IS NOT NULL
                               AND DEST.INMO_DT_MOV_END_EXEC_DT IS NOT NULL THEN CASE
                                                                                     WHEN SRC.INMO_DT_MOV_END_EXEC_DT > DEST.INMO_DT_MOV_END_EXEC_DT THEN SRC.INMO_DT_MOV_END_EXEC_DT
                                                                                     ELSE DEST.INMO_DT_MOV_END_EXEC_DT
                                                                                 END
                      END AS INMO_DT_MOV_END_EXEC_DT
               FROM
                 (SELECT INMO_DT_MOV_END_EXEC_DT_MAX AS INMO_DT_MOV_END_EXEC_DT,
                         INMO_CD_BIN_SRC
                  FROM
                    (SELECT ROW_NUMBER () OVER (PARTITION BY INMO_CD_BIN_SRC
                                                ORDER BY INMO_DT_MOV_END_EXEC_DT DESC) AS INMO_ROW_NUMBER,
                                               MAX (INMO_DT_MOV_END_EXEC_DT) KEEP (DENSE_RANK LAST
                                                                                   ORDER BY INMO_DT_MOV_END_EXEC_DT) OVER (PARTITION BY INMO_CD_BIN_SRC) AS INMO_DT_MOV_END_EXEC_DT_MAX,
                                                                                                                          INMO_DT_MOV_END_EXEC_DT,
                                                                                                                          INMO_CD_BIN_SRC
                     FROM DDWH01_DW_MA.TD_INMO_MAT_MOVE
                     WHERE INMO_CD_PLANT_CD = P_ELT_CD_PLANT
                       AND INMO_FL_LOGICAL_STATUS = '1'
                       AND INMO_CD_BIN_SRC IS NOT NULL
                       AND INMO_CD_BIN_SECT_SRC IS NULL
                       AND INMO_DT_MOV_END_EXEC_DT IS NOT NULL
                       AND INMO_CD_MOV_TP NOT IN ('MSK',
                                                  'MSU',
                                                  'EVC',
                                                  'DEL') )
                  WHERE INMO_ROW_NUMBER = 1 ) SRC
               FULL OUTER JOIN
                 (SELECT INMO_DT_MOV_END_EXEC_DT_MAX AS INMO_DT_MOV_END_EXEC_DT,
                         INMO_CD_BIN_DEST
                  FROM
                    (SELECT ROW_NUMBER () OVER (PARTITION BY INMO_CD_BIN_DEST
                                                ORDER BY INMO_DT_MOV_END_EXEC_DT DESC) AS INMO_ROW_NUMBER,
                                               MAX (INMO_DT_MOV_END_EXEC_DT) KEEP (DENSE_RANK LAST
                                                                                   ORDER BY INMO_DT_MOV_END_EXEC_DT) OVER (PARTITION BY INMO_CD_BIN_DEST) AS INMO_DT_MOV_END_EXEC_DT_MAX,
                                                                                                                          INMO_DT_MOV_END_EXEC_DT,
                                                                                                                          INMO_CD_BIN_DEST
                     FROM DDWH01_DW_MA.TD_INMO_MAT_MOVE
                     WHERE INMO_CD_PLANT_CD = P_ELT_CD_PLANT
                       AND INMO_FL_LOGICAL_STATUS = '1'
                       AND INMO_CD_BIN_DEST IS NOT NULL
                       AND INMO_CD_BIN_SECT_DEST IS NULL
                       AND INMO_DT_MOV_END_EXEC_DT IS NOT NULL
                       AND INMO_CD_MOV_TP NOT IN ('MSK',
                                                  'MSU',
                                                  'EVC',
                                                  'DEL') )
                  WHERE INMO_ROW_NUMBER = 1 ) DEST ON SRC.INMO_CD_BIN_SRC = DEST.INMO_CD_BIN_DEST) TD_INMO_MAT_MOVE_NVL,

              (SELECT *
               FROM DDWH01_DW_MA.TM_LMMD_LOGISTIC_MATERIALS
               WHERE LMMD_CD_PLANT_CD = P_ELT_CD_PLANT ) TM_LMMD_LOGISTIC_MATERIALS,

              (SELECT *
               FROM DDWH01_DW_MA.TM_STMD_SITE_MASTER
               WHERE STMD_CD_PLANT_CD = P_ELT_CD_PLANT ) TM_STMD_SITE_MASTER
            WHERE 1=1
              AND TH_WINV_WH_INV.WINV_CD_PLANT_CD = P_ELT_CD_PLANT
              AND WADE_ID_TIME_INV_DT = TO_NUMBER (TO_CHAR (TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'), 'J'))
              AND TH_WINV_WH_INV.WINV_ID_INDN_INB_DLVR_NT = TD_INDN_INB_DLVR_NT.INDN_ID_INB_DLVR_NT (+)
              AND TH_WINV_WH_INV.WINV_CD_BIN = TD_INMO_MAT_MOVE.INMO_CD_BIN (+)
              AND TH_WINV_WH_INV.WINV_CD_BIN_SECT = TD_INMO_MAT_MOVE.INMO_CD_BIN_SECT (+)
              AND TH_WINV_WH_INV.WINV_CD_BIN = TD_INMO_MAT_MOVE_NVL.INMO_CD_BIN (+)
              AND TH_WINV_WH_INV.WINV_CD_PART_NBR = TM_LMMD_LOGISTIC_MATERIALS.LMMD_CD_PART_NBR (+)
              AND TH_WINV_WH_INV.WINV_ID_STMD_SITE = TM_STMD_SITE_MASTER.STMD_ID_SITE_MASTER (+) ))) ,
     (SELECT *
      FROM DDWH02_DM_MA.TW_MCAC_MC_AGING_CAT
      WHERE MCAC_CD_PLANT_CD = P_ELT_CD_PLANT ) TW_MCAC_MC_AGING_CAT
   WHERE 1 = 1
     AND WADE_CD_BIN_LOC_GRP = TW_MCAC_MC_AGING_CAT.MCAC_CD_LOC_GRP (+)
     AND WADE_NR_AGING_LAST_CYCLE >= TW_MCAC_MC_AGING_CAT.MCAC_NR_AG_MIN (+)
     AND WADE_NR_AGING_LAST_CYCLE <= NVL (TW_MCAC_MC_AGING_CAT.MCAC_NR_AG_MAX (+), 9999) ) QRY