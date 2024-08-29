MERGE INTO DDWH02_DM_MA.TDIM_MTRL_MATERIAL TRG USING
  (SELECT *
   FROM
     (WITH MAMD AS
        (SELECT MAMD_CD_PLANT_CD,
                MAMD_ID_MAT_MASTER,
                LANG_CD,
                LANG_PRIORITY,
                LANG_ID,
                MAMD_ID_SPMD_SPEC_PROC_TP,
                MAMD_ID_MATM_MAT_TP,
                MAMD_ID_MRPT_MRP_TP,
                MAMD_ID_LSMD_LOT_SIZE,
                MAMD_ID_MSTU_MAT_STU,
                MAMD_ID_MGRP_MAT_GRP,
                MAMD_CD_PART_NBR,
                MAMD_CD_MAKE_OR_BUY,
                PTMD_DS_PROC_TP_DESC,
                MAMD_CD_SPEC_PROC_TP,
                MAMD_CD_MRP_CTRL_CD,
                MRPC_DS_MRP_CTRL_DESC,
                MACB_CS_TOT_MANUF_COST,
                LMMD_CD_DEF_INBOUND_AREA,
                LMMD_LD_DEF_INBOUND_AREA_DESC,
                LMMD_CD_DEF_STOCK_AREA,
                LMMD_LD_DEF_STOCK_AREA_DESC,
                MAMD_CD_MAT_TP,
                MAMD_CD_MRP_TP,
                MAMD_CD_LOT_SIZE,
                MAMD_FL_BACKFLUSHING_CD,
                MAMD_CD_UNIT_OF_MEAS,
                UNME_DS_UNIT_OF_MEASUREMENT,
                MAMD_FL_BULK_MAT,
                MAMD_FL_LOGICAL_DLT,
                MAMD_CD_ITM_FAM,
                MAMD_QT_NET_WEIGHT,
                MAMD_QT_GROSS_WEIGHT,
                MAMD_CD_UNIT_OF_MEAS_W,
                MAMD_QT_VOLUME,
                MAMD_CD_UNIT_OF_MEAS_V,
                MAMD_CD_MAT_SIZE,
                MAMD_CD_MAT_STU,
                MAMD_CD_MAT_GRP,
                MAMD_CD_UNIT_OF_MEAS_P,
                MAMD_NR_PURCH_CONV_FACTOR,
                MAMD_CD_UNIT_OF_MEAS_S,
                MAMD_NR_SALES_CONV_FACTOR,
                MAMD_FL_SECURITY_FLAG,
                MAMD_DT_LAST_UPDT_DT,
                MAMD_CD_ABC_INDIC,
                ABCI_DS_INDICATOR_DESCRIPTION,
                MAMD_FL_FLAG_ICP,
                MAMD_CD_PROD_HIERARCHY,
                MAMD_CD_TRACE_TP,
                MAMD_CD_MANUF_CD,
                MCMD_DS_MANUF_CD_DESC,
                MAMD_CD_MRP_GRP,
                MAMD_CD_ASS_MARK,
                MAMD_QT_SAFETY_STOCK,
                MAMD_QT_MAX_STOCK_LEVEL,
                MAMD_QT_MIN_LOT_SIZE,
                MAMD_QT_MAX_LOT_SIZE,
                MAMD_QT_REORD_POINT,
                MAMD_PC_SCRAP_QTY,
                MAMD_CD_ALT_NBR,
                MAMD_CD_PREFIX,
                MAMD_CD_DRW_NBR,
                MAMD_CD_SUFFIX,

           (SELECT LTCL_DS_LT_CLUSTER
            FROM DDWH02_DM_MA.TDIM_LTCL_LEADTIME_CLUSTER
            WHERE MAMD_QT_PROD_LEAD_TIME BETWEEN LTCL_NR_LT_START AND LTCL_NR_LT_END
              AND LTCL_CD_PLANT_CD = P_ELT_CD_PLANT ) LTCL_DS_LT_CLUSTER,
                MAMD_QT_PROD_LEAD_TIME,
                MAMD_QT_PLN_DLVR_TIME,
                MAMD_QT_INB_PROC_TIME,
                MAMD_CD_THICKNESS,
                MAMD_CD_GRADE_CAT,
                MAMD_CD_CNH_CD,
                MAMD_CD_PROJECT_CD,
                MAMD_FL_REVISION_LEVEL,
                MAMD_QT_FIXED_ORD_QTY,
                MAMD_CD_ACCUMUL_CD,
                MAMD_CD_ACQUIS_STORE_LOC,
                SLMD_DS_STORE_LOC_DESC,
                MAMD_CS_ACQUIS_COST,
                MAMD_CS_STOCK_COST,
                MAMD_CD_USG_ORG,
                MAMD_QT_CARR_NBR,
                MAMD_QT_BAR_HOOK,
                MAMD_NR_ACRYL_BTCP,
                MAMD_NR_ACRYL_CD,
                MAMD_CD_PAINT_PROC_COLOR,
                PPCL_DS_PAINT_PROC_COLOR_DESC,
                MAMD_CD_TOOL_TP,
                TTPM_DS_TOOL_TP_DESC,
                MAMD_CD_TOOL_WEIGHT,
                MAMD_CD_TOOL_LENGTH,
                MAMD_CD_TOOL_HEIGHT,
                MAMD_CD_TOOL_WIDTH,
                MAMD_QT_TOOL_QTY,
                MAMD_FL_TOOL_PROG_MARK,
                MAMD_CD_TOOL_SUBCTR,
                KTMD_CD_LAST_KIT_ID,
                EFMC_CD_PROGRAM,
                CASE
                    WHEN NOT (DAILY_INV.DINV_WH_QT_QTY IS NULL
                              AND DAILY_INV.DINV_LIN_QT_QTY IS NULL
                              AND MTRL_QT_ANNUAL_USAGE_SUB2.MTRL_QT_ANNUAL_USAGE2 IS NULL) THEN NVL (MTRL_QT_ANNUAL_USAGE_SUB2.MTRL_QT_ANNUAL_USAGE2, 0)
                END MAMD_QT_ANNUAL_USAGE,
                CASE
                    WHEN MTRL_QT_ANNUAL_USAGE_SUB2.MTRL_QT_ANNUAL_USAGE2 > 0 THEN '1'
                    ELSE '0'
                END MAMD_FL_ACTIVE_PART,
                MASP_FL_PART_NBR_MARKER MAMD_FL_BUY_AGRMNT_MARKER,
                MONTH_INV.MINV_WH_QT_QTY MAMD_QT_WH_MONTHLY,
                MONTH_INV.MINV_LIN_QT_QTY MAMD_QT_LIN_MONTHLY,
                CASE
                    WHEN NOT (DAILY_INV.DINV_WH_QT_QTY IS NULL
                              AND DAILY_INV.DINV_LIN_QT_QTY IS NULL
                              AND MTRL_QT_ANNUAL_USAGE_SUB2.MTRL_QT_ANNUAL_USAGE2 IS NULL) THEN NVL (DAILY_INV.DINV_WH_QT_QTY, 0)
                END MAMD_QT_WH_DAILY,
                DAILY_INV.DINV_WH_QT_BLOCKED_QTY MAMD_QT_BLOCKED_QTY,
                DAILY_INV.DINV_WH_QT_RES_QTY MAMD_QT_RES_QTY,
                DAILY_INV.DINV_WH_QT_TOT_AVAIL_QTY MAMD_QT_TOT_AVAILABLE_QTY,
                CASE
                    WHEN NOT (DAILY_INV.DINV_WH_QT_QTY IS NULL
                              AND DAILY_INV.DINV_LIN_QT_QTY IS NULL
                              AND MTRL_QT_ANNUAL_USAGE_SUB2.MTRL_QT_ANNUAL_USAGE2 IS NULL) THEN NVL (DAILY_INV.DINV_LIN_QT_QTY, 0)
                END MAMD_QT_LIN_DAILY,
                WINV_QT_TO_CQA_QTY,
                WINV_QT_CQA_QTY,
                WINV_QT_RDY_CQA_QTY,
                LMMD_DT_LAST_INV_MOV_DT,
                LMMD_DT_LAST_CYCLE_DT,
                LMMD_ID_ATMD_PREF_AREA,
                LMMD_CD_PREF_AREA,
                LMMD_FL_CONT_MARK,
                MSOD.MSOD_DT_MRP_SOD_DT MAMD_DT_MRP_SOD_DT,
                MSOD.MSOD_DT_MRP_PLAN_DT MAMD_DT_MRP_PLAN_DT,
                MSOD.MSOD_NR_REM_COV_DAYS MAMD_NR_REM_COV_DAYS,
                MSOD.MSOD_FL_ALREADY_SO MAMD_FL_ALREADY_SO,
                PLMD_ID_PLANT_MASTER,
                MSOD.MSOD_CD_STK_WCTR MSOD_CD_STK_WCTR,
                MSOD.MSOD_QT_CUM_REQ_QTY MSOD_QT_CUM_REQ_QTY,
                CASE
                    WHEN (NVL (DAILY_INV.DINV_WH_QT_QTY, 0) + NVL (DAILY_INV.DINV_LIN_QT_QTY, 0)) > 0
                         AND (NVL (DAILY_INV.DINV_WH_QT_QTY, 0) + NVL (DAILY_INV.DINV_LIN_QT_QTY, 0)) <= MTRL_QT_ANNUAL_USAGE_SUB2.MTRL_QT_ANNUAL_USAGE2 THEN 'NORMAL'
                    WHEN (NVL (DAILY_INV.DINV_WH_QT_QTY, 0) + NVL (DAILY_INV.DINV_LIN_QT_QTY, 0)) > 0
                         AND (NVL (MTRL_QT_ANNUAL_USAGE_SUB2.MTRL_QT_ANNUAL_USAGE2, 0) > 0)
                         AND (NVL (DAILY_INV.DINV_WH_QT_QTY, 0) + NVL (DAILY_INV.DINV_LIN_QT_QTY, 0)) > NVL (MTRL_QT_ANNUAL_USAGE_SUB2.MTRL_QT_ANNUAL_USAGE2, 0) THEN 'EXCESS'
                    WHEN (NVL (DAILY_INV.DINV_WH_QT_QTY, 0) + NVL (DAILY_INV.DINV_LIN_QT_QTY, 0)) > 0
                         AND (NVL (MTRL_QT_ANNUAL_USAGE_SUB2.MTRL_QT_ANNUAL_USAGE2, 0) = 0) THEN 'OBSOLETE'
                    WHEN (NVL (DAILY_INV.DINV_WH_QT_QTY, 0) + NVL (DAILY_INV.DINV_LIN_QT_QTY, 0)) < 0 THEN 'NEGATIVE'
                    WHEN (NVL (DAILY_INV.DINV_WH_QT_QTY, 0) + NVL (DAILY_INV.DINV_LIN_QT_QTY, 0)) = 0
                         AND NOT (DAILY_INV.DINV_WH_QT_QTY IS NULL
                                  AND DAILY_INV.DINV_LIN_QT_QTY IS NULL
                                  AND MTRL_QT_ANNUAL_USAGE_SUB2.MTRL_QT_ANNUAL_USAGE2 IS NULL) THEN 'NO STOCK'
                    ELSE NULL
                END MAMD_CD_STOCK_TP,
                MTRL_CD_DEP_CD.PLMD_CD_DEP,
                KTMD_CD_LAST_TRLY_POS,
                'TBD' MAMD_CD_FLOW_RACK,
                      NVL2 (SEQL.SEQL_ID_MAMD_PART_NBR, '1', '0') MAMD_FL_SEQ_LIST_MARKER,
                      MAMD_CD_SOURCE_SYSTEM
         FROM
           (SELECT *
            FROM DDWH01_DW_MA.TM_MAMD_MAT_MASTER
            WHERE MAMD_CD_PLANT_CD=P_ELT_CD_PLANT
              AND MAMD_FL_LOGICAL_DLT= '0' ) ,
           (SELECT *
            FROM DDWH01_DW_MA.TM_TTPM_TOOL_TP_MASTER
            WHERE TTPM_CD_PLANT_CD=P_ELT_CD_PLANT ) ,
           (SELECT *
            FROM DDWH01_DW_MA.TM_PTMD_PROC_TP_MASTER
            WHERE PTMD_CD_PLANT_CD=P_ELT_CD_PLANT ) ,
           (SELECT *
            FROM DDWH01_DW_MA.TM_MRPC_MRP_CONTROLLER
            WHERE MRPC_CD_PLANT_CD=P_ELT_CD_PLANT ) ,
           (SELECT *
            FROM DDWH01_DW_MA.TM_ABCI_ABC_INDICATOR
            WHERE ABCI_CD_PLANT_CD=P_ELT_CD_PLANT ) ,
           (SELECT *
            FROM DDWH01_DW_MA.TM_MCMD_MANUF_CD_MASTER
            WHERE MCMD_CD_PLANT_CD=P_ELT_CD_PLANT ) ,
           (SELECT *
            FROM DDWH01_DW_MA.TM_PPCL_PAINT_PROC_COLOR
            WHERE PPCL_CD_PLANT_CD=P_ELT_CD_PLANT ) ,
           (SELECT *
            FROM DDWH01_DW_MA.TM_MACB_MAT_COST_BREAKDOWN
            WHERE MACB_CD_PLANT_CD=P_ELT_CD_PLANT ) ,
           (SELECT LMMD_CD_PLANT_CD,
                   LMMD_ID_MAMD_PART_NBR,
                   LMMD_CD_DEF_INBOUND_AREA,
                   INB.ATMD_LD_AREA_DESC LMMD_LD_DEF_INBOUND_AREA_DESC,
                   LMMD_CD_DEF_STOCK_AREA,
                   STC.ATMD_LD_AREA_DESC LMMD_LD_DEF_STOCK_AREA_DESC,
                   LMMD_DT_LAST_INV_MOV_DT,
                   LMMD_DT_LAST_CYCLE_DT,
                   LMMD_ID_ATMD_PREF_AREA,
                   LMMD_CD_PREF_AREA,
                   LMMD_FL_CONT_MARK
            FROM DDWH01_DW_MA.TM_LMMD_LOGISTIC_MATERIALS,
                 DDWH01_DW_MA.TM_ATMD_AREA_MASTER INB,
                 DDWH01_DW_MA.TM_ATMD_AREA_MASTER STC
            WHERE LMMD_CD_PLANT_CD = P_ELT_CD_PLANT
              AND INB.ATMD_CD_PLANT_CD (+) = P_ELT_CD_PLANT
              AND STC.ATMD_CD_PLANT_CD (+) = P_ELT_CD_PLANT
              AND LMMD_ID_ATMD_DEF_INBOUND_AREA = INB.ATMD_ID_AREA_MASTER (+)
              AND LMMD_ID_ATMD_DEF_STOCK_AREA = STC.ATMD_ID_AREA_MASTER (+) ) ,
           (SELECT *
            FROM DDWH01_DW.TM_UNME_UNIT_OF_MEASUREMENT) ,
           (SELECT *
            FROM DDWH01_DW_MA.TM_SLMD_STORE_LOC_MASTER
            WHERE SLMD_CD_PLANT_CD =P_ELT_CD_PLANT ) ,
           (SELECT GREH_ID_MAMD_PART_NBR AS ID_MAT_MASTER,
                   ROUND (SUM (NVL (GREH_QT_REQ_QTY, 0))) AS MTRL_QT_ANNUAL_USAGE2
            FROM DDWH01_DW_MA.TH_GREH_GROSS_REQ_HIST
            WHERE GREH_DT_REF_DT = TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD')
              AND GREH_CD_PLANT_CD = P_ELT_CD_PLANT
              AND TRUNC (TO_DATE (GREH_NR_MTH_REQ, 'YYYYMM'), 'MM') < TRUNC (ADD_MONTHS (TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'), 13), 'MM')
            GROUP BY GREH_ID_MAMD_PART_NBR) MTRL_QT_ANNUAL_USAGE_SUB2 ,
           (SELECT MASP_CD_PLANT_CD,
                   MASP_ID_MAMD_PART_NBR,
                   DECODE (COUNT (MASP_CD_PART_NBR) , 0, '0', '1') MASP_FL_PART_NBR_MARKER
            FROM DDWH01_DW_MA.TM_MASP_MAT_SUPP_REL
            WHERE MASP_CD_PLANT_CD =P_ELT_CD_PLANT
              AND TM_MASP_MAT_SUPP_REL.MASP_FL_LOGICAL_DELETION = '0'
            GROUP BY MASP_CD_PLANT_CD,
                     MASP_ID_MAMD_PART_NBR) ,
           (SELECT SUM (CASE
                            WHEN MINV_CD_WH_TP IN ('WH',
                                                   'CON') THEN MINV_QT_QTY
                            ELSE 0
                        END) MINV_WH_QT_QTY,
                       SUM (CASE
                                WHEN MINV_CD_WH_TP = 'WIP' THEN MINV_QT_QTY
                                ELSE 0
                            END) MINV_LIN_QT_QTY,
                           MINV_CD_PLANT_CD,
                           MINV_ID_MAMD_PART_NBR
            FROM DDWH01_DW_MA.TH_MINV_MONTHLY_INV
            WHERE MINV_CD_PLANT_CD =P_ELT_CD_PLANT
              AND MINV_NR_INV_DT =
                (SELECT MAX (MINV_NR_INV_DT)
                 FROM DDWH01_DW_MA.TH_MINV_MONTHLY_INV
                 WHERE MINV_CD_PLANT_CD =P_ELT_CD_PLANT )
            GROUP BY MINV_CD_PLANT_CD,
                     MINV_ID_MAMD_PART_NBR) MONTH_INV,

           (SELECT SUM (CASE
                            WHEN DINV_CD_WH_TP IN ('WH',
                                                   'CON') THEN DINV_QT_QTY
                            ELSE 0
                        END) DINV_WH_QT_QTY,
                       SUM (CASE
                                WHEN DINV_CD_WH_TP IN ('WH',
                                                       'CON') THEN DINV_QT_BLOCKED_QTY
                                ELSE 0
                            END) DINV_WH_QT_BLOCKED_QTY,
                           SUM (CASE
                                    WHEN DINV_CD_WH_TP IN ('WH',
                                                           'CON') THEN DINV_QT_RES_QTY
                                    ELSE 0
                                END) DINV_WH_QT_RES_QTY,
                               SUM (CASE
                                        WHEN DINV_CD_WH_TP IN ('WH',
                                                               'CON') THEN DINV_QT_QTY - NVL (DINV_QT_BLOCKED_QTY, 0) - NVL (DINV_QT_RES_QTY, 0)
                                        ELSE 0
                                    END) DINV_WH_QT_TOT_AVAIL_QTY,
                                   SUM (CASE
                                            WHEN DINV_CD_WH_TP = 'WIP' THEN DINV_QT_QTY
                                            ELSE 0
                                        END) DINV_LIN_QT_QTY,
                                       DINV_CD_PLANT_CD,
                                       DINV_ID_MAMD_PART_NBR
            FROM DDWH01_DW_MA.TH_DINV_DAILY_INV
            WHERE DINV_CD_PLANT_CD =P_ELT_CD_PLANT
              AND DINV_DT_INV_DT =
                (SELECT MAX (DINV_DT_INV_DT)
                 FROM DDWH01_DW_MA.TH_DINV_DAILY_INV
                 WHERE DINV_CD_PLANT_CD =P_ELT_CD_PLANT
                   AND DINV_DT_INV_DT <= TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') )
            GROUP BY DINV_CD_PLANT_CD,
                     DINV_ID_MAMD_PART_NBR) DAILY_INV,

           (SELECT WINV_CD_PLANT_CD,
                   WINV_ID_MAMD_PART_NBR,
                   SUM (CASE
                            WHEN WINV_CD_BIN_LOC_TP <> 'CQA'
                                 AND WINV_CD_MAT_STU = 'VERIFICA' THEN WINV_QT_BIN_QTY
                            ELSE 0
                        END) WINV_QT_TO_CQA_QTY,
                       SUM (CASE
                                WHEN WINV_CD_BIN_LOC_TP = 'CQA'
                                     AND WINV_CD_MAT_STU IN ('VERIFICA',
                                                             'SOSPESO') THEN WINV_QT_BIN_QTY
                                ELSE 0
                            END) WINV_QT_CQA_QTY,
                           SUM (CASE
                                    WHEN WINV_CD_BIN_LOC_TP = 'CQA'
                                         AND WINV_CD_MAT_STU = 'DISPONIBILE' THEN WINV_QT_BIN_QTY
                                    ELSE 0
                                END) WINV_QT_RDY_CQA_QTY
            FROM DDWH01_DW_MA.TH_WINV_WH_INV
            WHERE WINV_DT_INV_DT = TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD')
              AND WINV_CD_PLANT_CD = P_ELT_CD_PLANT
              AND ((WINV_CD_BIN_LOC_TP <> 'CQA'
                    AND WINV_CD_MAT_STU = 'VERIFICA')
                   OR (WINV_CD_BIN_LOC_TP = 'CQA'
                       AND WINV_CD_MAT_STU IN ('VERIFICA',
                                               'SOSPESO'))
                   OR (WINV_CD_BIN_LOC_TP = 'CQA'
                       AND WINV_CD_MAT_STU = 'DISPONIBILE'))
            GROUP BY WINV_CD_PLANT_CD,
                     WINV_ID_MAMD_PART_NBR) WINV,

           (SELECT MSOD_FL_ALREADY_SO,
                   MSOD_NR_REM_COV_DAYS,
                   MSOD_DT_MRP_SOD_DT,
                   MSOD_DT_MRP_PLAN_DT,
                   MSOD_CD_PLANT_CD,
                   MSOD_ID_MAMD_PART_NBR,
                   MSOD_CD_STK_WCTR,
                   MSOD_QT_CUM_REQ_QTY
            FROM DDWH01_DW_MA.TH_MSOD_MAT_STOCK_OUT_DT B
            WHERE MSOD_CD_PLANT_CD =P_ELT_CD_PLANT
              AND B.MSOD_DT_MRP_PLAN_DT =
                (SELECT MAX (MSOD_DT_MRP_PLAN_DT)
                 FROM DDWH01_DW_MA.TH_MSOD_MAT_STOCK_OUT_DT A
                 WHERE A.MSOD_CD_PLANT_CD =P_ELT_CD_PLANT ) ) MSOD,

           (SELECT PLMD_ID_PLANT_MASTER,
                   PLMD_CD_WCTR_CD
            FROM DDWH01_DW_MA.TM_PLMD_PLANT_MASTER
            WHERE PLMD_CD_PLANT_CD=P_ELT_CD_PLANT ) PLST,

           (SELECT ROPN_CD_PLANT_CD,
                   ROPN_ID_MAMD_PART_NBR,
                   MAX (NVL (TM_PLMD_PLANT_MASTER.PLMD_CD_DEP, 0)) KEEP (DENSE_RANK FIRST
                                                                         ORDER BY ROOP_CD_OP DESC) PLMD_CD_DEP
            FROM
              (SELECT *
               FROM DDWH01_DW_MA.TM_PLMD_PLANT_MASTER
               WHERE PLMD_CD_PLANT_CD = P_ELT_CD_PLANT ) TM_PLMD_PLANT_MASTER,

              (SELECT *
               FROM DDWH01_DW_MA.TM_ROPN_ROUTING_PARTNBR
               WHERE ROPN_CD_PLANT_CD = P_ELT_CD_PLANT
                 AND ROPN_FL_LOGICAL_DELETION = '0' ) TM_ROPN_ROUTING_PARTNBR,

              (SELECT *
               FROM DDWH01_DW_MA.TM_ROOP_ROUTING_OP
               WHERE ROOP_CD_PLANT_CD = P_ELT_CD_PLANT
                 AND ROOP_FL_LOGICAL_STATUS = '1' ) TM_ROOP_ROUTING_OP
            WHERE TM_ROOP_ROUTING_OP.ROOP_ID_ROPN_ROUTING_PARTNBR = TM_ROPN_ROUTING_PARTNBR.ROPN_ID_ROUTING_PARTNBR
              AND TM_PLMD_PLANT_MASTER.PLMD_ID_PLANT_MASTER = TM_ROOP_ROUTING_OP.ROOP_ID_PLMD_WCTR_CD
              AND TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') BETWEEN TM_ROPN_ROUTING_PARTNBR.ROPN_DT_VALID_STR_DT AND TM_ROPN_ROUTING_PARTNBR.ROPN_DT_VALID_END_DT
              AND TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') BETWEEN TM_ROOP_ROUTING_OP.ROOP_DT_VALID_STR_DT AND TM_ROOP_ROUTING_OP.ROOP_DT_VALID_END_DT
            GROUP BY ROPN_CD_PLANT_CD,
                     ROPN_ID_MAMD_PART_NBR) MTRL_CD_DEP_CD,

           (SELECT EFOB_CD_PLANT_CD,
                   EFOB_ID_MAMD_PART_NBR_CHGD,
                   MAX (TT_EFMC_EFF_MCO.EFMC_CD_PROGRAM) KEEP (DENSE_RANK FIRST
                                                               ORDER BY EFMC_DT_VALID_STR_DT) EFMC_CD_PROGRAM
            FROM
              (SELECT *
               FROM DDWH01_DW_MA.TT_EFMC_EFF_MCO
               WHERE EFMC_CD_PLANT_CD=P_ELT_CD_PLANT
                 AND EFMC_FL_LOGICAL_STATUS = '1' ) TT_EFMC_EFF_MCO,

              (SELECT *
               FROM DDWH01_DW_MA.TD_EFOB_EFF_OBJ
               WHERE EFOB_CD_PLANT_CD=P_ELT_CD_PLANT
                 AND EFOB_FL_LOGICAL_STATUS = '1' ) TD_EFOB_EFF_OBJ
            WHERE TD_EFOB_EFF_OBJ.EFOB_ID_EFMC_MCO = TT_EFMC_EFF_MCO.EFMC_ID_EFF_MCO
              AND TD_EFOB_EFF_OBJ.EFOB_CD_OBJ_TP = '41'
            GROUP BY EFOB_CD_PLANT_CD,
                     EFOB_ID_MAMD_PART_NBR_CHGD) MCO,

           (SELECT DISTINCT SQLM_CD_PLANT_CD SEQL_CD_PLANT_CD,
                            SQLP_ID_MAMD_PART_NBR SEQL_ID_MAMD_PART_NBR
            FROM DDWH01_DW_MA.TM_SQLM_SEQ_LIST_MASTER,
                 DDWH01_DW_MA.TM_SQLP_SEQ_LIST_PART_NBR
            WHERE SQLM_CD_PLANT_CD =P_ELT_CD_PLANT
              AND SQLP_CD_PLANT_CD =P_ELT_CD_PLANT
              AND SQLM_ID_SEQ_LIST_MASTER = SQLP_ID_SQLM_SEQ_LIST_ID
              AND SQLM_CD_SEQ_LIST_TP = 'MFG'
              AND SQLM_FL_LOGICAL_STATUS = '1'
              AND SQLP_FL_LOGICAL_STATUS = '1' ) SEQL,

           (SELECT KTPN_CD_PLANT_CD,
                   KTPN_ID_MAMD_PART_NBR,
                   MAX (KTMD_CD_KIT_ID) KTMD_CD_LAST_KIT_ID,
                       MAX (KTPN_CD_TRLY_POS) KEEP (DENSE_RANK FIRST
                                                    ORDER BY KTMD_CD_KIT_ID DESC) KTMD_CD_LAST_TRLY_POS
            FROM
              (SELECT *
               FROM DDWH01_DW_MA.TM_KTMD_KIT_MASTER
               WHERE KTMD_CD_PLANT_CD = P_ELT_CD_PLANT ) KTMD,

              (SELECT *
               FROM DDWH01_DW_MA.TM_KTPN_KIT_PART_NBR_COMP
               WHERE KTPN_CD_PLANT_CD = P_ELT_CD_PLANT ) KTPN1
            WHERE KTPN_ID_KTMD_KIT_ID = KTMD_ID_KIT_MASTER (+)
            GROUP BY KTPN_CD_PLANT_CD,
                     KTPN_ID_MAMD_PART_NBR) KTPN,

           (SELECT PLANT_CD,
                   LANG_ID,
                   LANG_CD,
                   LANG_PRIORITY
            FROM
              (SELECT PLNT_CD_PLANT_CD PLANT_CD,
                      PLNT_ID_LANG_M LANG_ID,
                      PLNT_CD_LANG_M LANG_CD,
                      '3' LANG_PRIORITY
               FROM DDWH01_DW_MA.TM_PLNT_PLANT
               UNION SELECT PLNT_CD_PLANT_CD PLANT_CD,
                            PLNT_ID_LANG_P LANG_ID,
                            PLNT_CD_LANG_P LANG_CD,
                            '2' LANG_PRIORITY
               FROM DDWH01_DW_MA.TM_PLNT_PLANT
               UNION SELECT PLNT_CD_PLANT_CD PLANT_CD,
                            PLNT_ID_LANG_A LANG_ID,
                            PLNT_CD_LANG_A LANG_CD,
                            '1' LANG_PRIORITY
               FROM DDWH01_DW_MA.TM_PLNT_PLANT)) LANG
         WHERE 1=1
           AND MAMD_CD_TOOL_TP = TTPM_CD_TOOL_TP (+)
           AND MAMD_CD_PLANT_CD = TTPM_CD_PLANT_CD (+)
           AND MAMD_CD_PLANT_CD = PTMD_CD_PLANT_CD (+)
           AND MAMD_ID_PTMD_MAKE_OR_BUY = PTMD_ID_PROC_TP_MASTER (+)
           AND MAMD_ID_MRPC_MRP_CTRL_CD = MRPC_ID_MRP_CONTROLLER (+)
           AND MAMD_CD_PLANT_CD = MRPC_CD_PLANT_CD (+)
           AND MAMD_ID_ABCI_ABC_INDIC = ABCI_ID_ABC_INDICATOR (+)
           AND MAMD_CD_PLANT_CD = ABCI_CD_PLANT_CD (+)
           AND MAMD_ID_MCMD_MANUF_CD = MCMD_ID_MANUF_CD_MASTER (+)
           AND MAMD_CD_PLANT_CD = MCMD_CD_PLANT_CD (+)
           AND MAMD_ID_PPCL_PAINT_PROC_COLOR = PPCL_ID_PAINT_PROC_COLOR (+)
           AND MAMD_CD_PLANT_CD = PPCL_CD_PLANT_CD (+)
           AND MAMD_ID_MAT_MASTER = MACB_ID_MAMD_PART_NBR (+)
           AND MAMD_CD_PLANT_CD = MACB_CD_PLANT_CD (+)
           AND MAMD_ID_MAT_MASTER = LMMD_ID_MAMD_PART_NBR (+)
           AND MAMD_CD_PLANT_CD = LMMD_CD_PLANT_CD (+)
           AND MAMD_ID_UNME_UNIT_OF_MEAS = UNME_ID_UNIT_MEASUREMENT (+)
           AND MAMD_CD_PLANT_CD = SLMD_CD_PLANT_CD (+)
           AND MAMD_ID_SLMD_ACQUIS_STORE_LOC = SLMD_ID_STORE_LOC_MASTER (+)
           AND MAMD_ID_MAT_MASTER = MTRL_QT_ANNUAL_USAGE_SUB2.ID_MAT_MASTER (+)
           AND MAMD_ID_MAT_MASTER = MASP_ID_MAMD_PART_NBR (+)
           AND MAMD_CD_PLANT_CD = MONTH_INV.MINV_CD_PLANT_CD (+)
           AND MAMD_ID_MAT_MASTER = MONTH_INV.MINV_ID_MAMD_PART_NBR (+)
           AND MAMD_CD_PLANT_CD = DAILY_INV.DINV_CD_PLANT_CD (+)
           AND MAMD_ID_MAT_MASTER = DAILY_INV.DINV_ID_MAMD_PART_NBR (+)
           AND MAMD_CD_PLANT_CD = WINV.WINV_CD_PLANT_CD (+)
           AND MAMD_ID_MAT_MASTER = WINV.WINV_ID_MAMD_PART_NBR (+)
           AND MAMD_ID_MAT_MASTER = MSOD.MSOD_ID_MAMD_PART_NBR (+)
           AND MAMD_CD_PLANT_CD = MSOD.MSOD_CD_PLANT_CD (+)
           AND MSOD.MSOD_CD_STK_WCTR=PLMD_CD_WCTR_CD (+)
           AND MAMD_CD_PLANT_CD = MTRL_CD_DEP_CD.ROPN_CD_PLANT_CD (+)
           AND MAMD_ID_MAT_MASTER = MTRL_CD_DEP_CD.ROPN_ID_MAMD_PART_NBR (+)
           AND MAMD_CD_PLANT_CD = MCO.EFOB_CD_PLANT_CD (+)
           AND MAMD_ID_MAT_MASTER = MCO.EFOB_ID_MAMD_PART_NBR_CHGD (+)
           AND MAMD_CD_PLANT_CD = SEQL.SEQL_CD_PLANT_CD (+)
           AND MAMD_ID_MAT_MASTER = SEQL.SEQL_ID_MAMD_PART_NBR (+)
           AND MAMD_CD_PLANT_CD = KTPN.KTPN_CD_PLANT_CD (+)
           AND MAMD_ID_MAT_MASTER = KTPN.KTPN_ID_MAMD_PART_NBR (+)
           AND MAMD_CD_PLANT_CD = LANG.PLANT_CD (+) ) SELECT MAMD_CD_PLANT_CD,
                                                             MAMD_ID_MAT_MASTER,
                                                             LANG_CD MTRL_CD_LANGUAGE,
                                                             MAMD_CD_PART_NBR,
                                                             COALESCE (LPDS_MAMD.LPDS_DS_SHORT_DESC,
                                                                       FIRST_VALUE (LPDS_MAMD.LPDS_DS_SHORT_DESC) OVER (PARTITION BY MAMD_CD_PLANT_CD,
                                                                                                                                     MAMD_ID_MAT_MASTER
                                                                                                                        ORDER BY LANG_PRIORITY DESC) , FNAV) LPDS_DS_SHORT_DESC,
                                                                      NVL (MAMD_CD_MAKE_OR_BUY, FNAPC) MAMD_CD_MAKE_OR_BUY,
                                                                      NVL (PTMD_DS_PROC_TP_DESC, NVL2 (MAMD_CD_MAKE_OR_BUY, FNAV, FNAP)) PTMD_DS_PROC_TP_DESC,
                                                                      NVL (MAMD_CD_SPEC_PROC_TP, FNAPC) MAMD_CD_SPEC_PROC_TP,
                                                                      COALESCE (LPDS_SPMD.LPDS_DS_SHORT_DESC,
                                                                                FIRST_VALUE (LPDS_SPMD.LPDS_DS_SHORT_DESC) OVER (PARTITION BY MAMD_CD_PLANT_CD,
                                                                                                                                              MAMD_ID_SPMD_SPEC_PROC_TP
                                                                                                                                 ORDER BY LANG_PRIORITY DESC) , NVL2 (MAMD_CD_SPEC_PROC_TP, FNAV, FNAP)) LPDS_DS_SHORT_DESC2,
                                                                               NVL (MAMD_CD_MRP_CTRL_CD, FNAPC) MAMD_CD_MRP_CTRL_CD,
                                                                               NVL (MRPC_DS_MRP_CTRL_DESC, NVL2 (MAMD_CD_MRP_CTRL_CD, FNAV, FNAP)) MRPC_DS_MRP_CTRL_DESC,
                                                                               MACB_CS_TOT_MANUF_COST MTRL_CS_TMC,
                                                                               NVL (LMMD_CD_DEF_INBOUND_AREA, FNAPC) LMMD_CD_DEF_INBOUND_AREA,
                                                                               NVL (LMMD_LD_DEF_INBOUND_AREA_DESC, NVL2 (LMMD_CD_DEF_INBOUND_AREA, FNAV, FNAP)) LMMD_LD_DEF_INBOUND_AREA_DESC,
                                                                               NVL (LMMD_CD_DEF_STOCK_AREA, FNAPC) LMMD_CD_DEF_STOCK_AREA,
                                                                               NVL (LMMD_LD_DEF_STOCK_AREA_DESC, NVL2 (LMMD_CD_DEF_STOCK_AREA, FNAV, FNAP)) LMMD_LD_DEF_STOCK_AREA_DESC,
                                                                               NVL (MAMD_CD_MAT_TP, FNAPC) MAMD_CD_MAT_TP,
                                                                               COALESCE (LPDS_MATM.LPDS_DS_SHORT_DESC,
                                                                                         FIRST_VALUE (LPDS_MATM.LPDS_DS_SHORT_DESC) OVER (PARTITION BY MAMD_CD_PLANT_CD,
                                                                                                                                                       MAMD_ID_MATM_MAT_TP
                                                                                                                                          ORDER BY LANG_PRIORITY DESC) , NVL2 (MAMD_CD_MAT_TP, FNAV, FNAP)) LPDS_DS_SHORT_DESC3,
                                                                                        NVL (MAMD_CD_MRP_TP, FNAPC) MAMD_CD_MRP_TP,
                                                                                        COALESCE (LPDS_MRPT.LPDS_DS_SHORT_DESC,
                                                                                                  FIRST_VALUE (LPDS_MRPT.LPDS_DS_SHORT_DESC) OVER (PARTITION BY MAMD_CD_PLANT_CD,
                                                                                                                                                                MAMD_ID_MRPT_MRP_TP
                                                                                                                                                   ORDER BY LANG_PRIORITY DESC) , NVL2 (MAMD_CD_MRP_TP, FNAV, FNAP)) LPDS_DS_SHORT_DESC4,
                                                                                                 NVL (MAMD_CD_LOT_SIZE, FNAPC) MAMD_CD_LOT_SIZE,
                                                                                                 COALESCE (LPDS_LSMD.LPDS_DS_SHORT_DESC,
                                                                                                           FIRST_VALUE (LPDS_LSMD.LPDS_DS_SHORT_DESC) OVER (PARTITION BY MAMD_CD_PLANT_CD,
                                                                                                                                                                         MAMD_ID_LSMD_LOT_SIZE
                                                                                                                                                            ORDER BY LANG_PRIORITY DESC) , NVL2 (MAMD_CD_LOT_SIZE, FNAV, FNAP)) LPDS_DS_SHORT_DESC5,
                                                                                                          MAMD_FL_BACKFLUSHING_CD,
                                                                                                          NVL (MAMD_CD_UNIT_OF_MEAS, FNAPC) MAMD_CD_UNIT_OF_MEAS,
                                                                                                          NVL (UNME_DS_UNIT_OF_MEASUREMENT, NVL2 (MAMD_CD_UNIT_OF_MEAS, FNAV, FNAP)) UNME_DS_UNIT_OF_MEASUREMENT,
                                                                                                          MAMD_FL_BULK_MAT,
                                                                                                          MAMD_FL_LOGICAL_DLT,
                                                                                                          NVL (MAMD_CD_ITM_FAM, FNAPC) MAMD_CD_ITM_FAM,
                                                                                                          MAMD_QT_NET_WEIGHT,
                                                                                                          MAMD_QT_GROSS_WEIGHT,
                                                                                                          NVL (MAMD_CD_UNIT_OF_MEAS_W, FNAPC) MAMD_CD_UNIT_OF_MEAS_W,
                                                                                                          MAMD_QT_VOLUME,
                                                                                                          NVL (MAMD_CD_UNIT_OF_MEAS_V, FNAPC) MAMD_CD_UNIT_OF_MEAS_V,
                                                                                                          NVL (MAMD_CD_MAT_SIZE, FNAPC) MAMD_CD_MAT_SIZE,
                                                                                                          NVL (MAMD_CD_MAT_STU, FNAPC) MAMD_CD_MAT_STU,
                                                                                                          COALESCE (LPDS_MSTU.LPDS_DS_SHORT_DESC,
                                                                                                                    FIRST_VALUE (LPDS_MSTU.LPDS_DS_SHORT_DESC) OVER (PARTITION BY MAMD_CD_PLANT_CD,
                                                                                                                                                                                  MAMD_ID_MSTU_MAT_STU
                                                                                                                                                                     ORDER BY LANG_PRIORITY DESC) , NVL2 (MAMD_CD_MAT_STU, FNAV, FNAP)) MAMD_DS_MAT_STU_DESC,
                                                                                                                   NVL (MAMD_CD_MAT_GRP, FNAPC) MAMD_CD_MAT_GRP,
                                                                                                                   COALESCE (LPDS_MGRP.LPDS_DS_SHORT_DESC,
                                                                                                                             FIRST_VALUE (LPDS_MGRP.LPDS_DS_SHORT_DESC) OVER (PARTITION BY MAMD_CD_PLANT_CD,
                                                                                                                                                                                           MAMD_ID_MGRP_MAT_GRP
                                                                                                                                                                              ORDER BY LANG_PRIORITY DESC) , NVL2 (MAMD_CD_MAT_GRP, FNAV, FNAP)) MAMD_DS_MAT_GRP_DESC,
                                                                                                                            NVL (MAMD_CD_UNIT_OF_MEAS_P, FNAPC) MAMD_CD_UNIT_OF_MEAS_P,
                                                                                                                            MAMD_NR_PURCH_CONV_FACTOR,
                                                                                                                            NVL (MAMD_CD_UNIT_OF_MEAS_S, FNAPC) MAMD_CD_UNIT_OF_MEAS_S,
                                                                                                                            MAMD_NR_SALES_CONV_FACTOR,
                                                                                                                            MAMD_FL_SECURITY_FLAG,
                                                                                                                            MAMD_DT_LAST_UPDT_DT,
                                                                                                                            NVL (MAMD_CD_ABC_INDIC, FNAPC) MAMD_CD_ABC_INDIC,
                                                                                                                            NVL (ABCI_DS_INDICATOR_DESCRIPTION, NVL2 (MAMD_CD_ABC_INDIC, FNAV, FNAP)) MAMD_DS_ABC_INDIC_DESC,
                                                                                                                            MAMD_FL_FLAG_ICP,
                                                                                                                            NVL (MAMD_CD_PROD_HIERARCHY, FNAPC) MAMD_CD_PROD_HIERARCHY,
                                                                                                                            NVL (MAMD_CD_TRACE_TP, FNAPC) MAMD_CD_TRACE_TP,
                                                                                                                            NVL (MAMD_CD_MANUF_CD, FNAPC) MAMD_CD_MANUF_CD,
                                                                                                                            NVL (MCMD_DS_MANUF_CD_DESC, NVL2 (MAMD_CD_MANUF_CD, FNAV, FNAP)) MAMD_DS_MANUF_DESC,
                                                                                                                            NVL (MAMD_CD_MRP_GRP, FNAPC) MAMD_CD_MRP_GRP,
                                                                                                                            NVL (MAMD_CD_ASS_MARK, FNAPC) MAMD_CD_ASS_MARK,
                                                                                                                            MAMD_QT_SAFETY_STOCK,
                                                                                                                            MAMD_QT_MAX_STOCK_LEVEL,
                                                                                                                            MAMD_QT_MIN_LOT_SIZE,
                                                                                                                            MAMD_QT_MAX_LOT_SIZE,
                                                                                                                            MAMD_QT_REORD_POINT,
                                                                                                                            MAMD_PC_SCRAP_QTY,
                                                                                                                            NVL (MAMD_CD_ALT_NBR, FNAPC) MAMD_CD_ALT_NBR,
                                                                                                                            NVL (MAMD_CD_PREFIX, FNAPC) MAMD_CD_PREFIX,
                                                                                                                            NVL (MAMD_CD_DRW_NBR, FNAPC) MAMD_CD_DRW_NBR,
                                                                                                                            NVL (MAMD_CD_SUFFIX, FNAPC) MAMD_CD_SUFFIX,
                                                                                                                            NVL (LTCL_DS_LT_CLUSTER, FNAPC) MTRL_DS_LEAD_TIME_CLUSTER,
                                                                                                                            MAMD_QT_PROD_LEAD_TIME,
                                                                                                                            MAMD_QT_PLN_DLVR_TIME,
                                                                                                                            MAMD_QT_INB_PROC_TIME,
                                                                                                                            NVL (MAMD_CD_THICKNESS, FNAPC) MAMD_CD_THICKNESS,
                                                                                                                            NVL (MAMD_CD_GRADE_CAT, FNAPC) MAMD_CD_GRADE_CAT,
                                                                                                                            NVL (MAMD_CD_CNH_CD, FNAPC) MAMD_CD_CNH_CD,
                                                                                                                            NVL (MAMD_CD_PROJECT_CD, FNAPC) MAMD_CD_PROJECT_CD,
                                                                                                                            MAMD_FL_REVISION_LEVEL,
                                                                                                                            MAMD_QT_FIXED_ORD_QTY,
                                                                                                                            NVL (MAMD_CD_ACCUMUL_CD, FNAPC) MAMD_CD_ACCUMUL_CD,
                                                                                                                            NVL (MAMD_CD_ACQUIS_STORE_LOC, FNAPC) MAMD_CD_ACQUIS_STORE_LOC,
                                                                                                                            NVL (SLMD_DS_STORE_LOC_DESC, NVL2 (MAMD_CD_ACQUIS_STORE_LOC, FNAV, FNAP)) SLMD_DS_STORE_LOC_DESC,
                                                                                                                            MAMD_CS_ACQUIS_COST,
                                                                                                                            MAMD_CS_STOCK_COST,
                                                                                                                            NVL (MAMD_CD_USG_ORG, FNAPC) MAMD_CD_USG_ORG,
                                                                                                                            MAMD_QT_CARR_NBR,
                                                                                                                            MAMD_QT_BAR_HOOK,
                                                                                                                            MAMD_NR_ACRYL_BTCP,
                                                                                                                            MAMD_NR_ACRYL_CD,
                                                                                                                            NVL (MAMD_CD_PAINT_PROC_COLOR, FNAPC) MAMD_CD_PAINT_PROC_COLOR,
                                                                                                                            NVL (PPCL_DS_PAINT_PROC_COLOR_DESC, NVL2 (MAMD_CD_PAINT_PROC_COLOR, FNAV, FNAP)) PPCL_DS_PAINT_PROC_COLOR_DESC,
                                                                                                                            NVL (MAMD_CD_TOOL_TP, FNAPC) MAMD_CD_TOOL_TP,
                                                                                                                            NVL (TTPM_DS_TOOL_TP_DESC, NVL2 (MAMD_CD_TOOL_TP, FNAV, FNAP)) TTPM_DS_TOOL_TP_DESC,
                                                                                                                            NVL (MAMD_CD_TOOL_WEIGHT, FNAPC) MAMD_CD_TOOL_WEIGHT,
                                                                                                                            NVL (MAMD_CD_TOOL_LENGTH, FNAPC) MAMD_CD_TOOL_LENGTH,
                                                                                                                            NVL (MAMD_CD_TOOL_HEIGHT, FNAPC) MAMD_CD_TOOL_HEIGHT,
                                                                                                                            NVL (MAMD_CD_TOOL_WIDTH, FNAPC) MAMD_CD_TOOL_WIDTH,
                                                                                                                            MAMD_QT_TOOL_QTY,
                                                                                                                            MAMD_FL_TOOL_PROG_MARK,
                                                                                                                            NVL (MAMD_CD_TOOL_SUBCTR, FNAPC) MAMD_CD_TOOL_SUBCTR,
                                                                                                                            NVL (KTMD_CD_LAST_KIT_ID, FNAPC) MTRL_CD_LAST_KIT_ID,
                                                                                                                            NVL (EFMC_CD_PROGRAM, FNAPC) MTRL_CD_PROGRAM,
                                                                                                                            MAMD_QT_ANNUAL_USAGE,
                                                                                                                            MAMD_FL_ACTIVE_PART,
                                                                                                                            MAMD_FL_BUY_AGRMNT_MARKER,
                                                                                                                            MAMD_QT_WH_MONTHLY,
                                                                                                                            MAMD_QT_LIN_MONTHLY,
                                                                                                                            MAMD_QT_WH_DAILY,
                                                                                                                            MAMD_QT_BLOCKED_QTY,
                                                                                                                            MAMD_QT_RES_QTY,
                                                                                                                            MAMD_QT_TOT_AVAILABLE_QTY,
                                                                                                                            MAMD_QT_LIN_DAILY,
                                                                                                                            WINV_QT_TO_CQA_QTY,
                                                                                                                            WINV_QT_CQA_QTY,
                                                                                                                            WINV_QT_RDY_CQA_QTY,
                                                                                                                            LMMD_DT_LAST_INV_MOV_DT,
                                                                                                                            LMMD_DT_LAST_CYCLE_DT,
                                                                                                                            NVL (LMMD_ID_ATMD_PREF_AREA, -2) MAMD_ID_ATMD_PREF_AREA,
                                                                                                                            NVL (LMMD_CD_PREF_AREA, FNAPC) MAMD_CD_PREF_AREA,
                                                                                                                            LMMD_FL_CONT_MARK,
                                                                                                                            MAMD_DT_MRP_SOD_DT,
                                                                                                                            MAMD_DT_MRP_PLAN_DT,
                                                                                                                            MAMD_NR_REM_COV_DAYS,
                                                                                                                            MAMD_FL_ALREADY_SO,
                                                                                                                            PLMD_ID_PLANT_MASTER AS MTRL_ID_PLST_SOD_WCTR_CD,
                                                                                                                            MSOD_CD_STK_WCTR AS MTRL_CD_SOD_WCTR_CD,
                                                                                                                            MSOD_QT_CUM_REQ_QTY AS MTRL_QT_CUM_REQ_QTY,
                                                                                                                            NVL (MAMD_CD_STOCK_TP, FNAPC) MTRL_CD_STOCK_TP,
                                                                                                                            NVL (PLMD_CD_DEP, FNAPC) MTRL_CD_DEP_CD,
                                                                                                                            NVL (KTMD_CD_LAST_TRLY_POS, FNAPC) MTRL_CD_KIT_FIX_POS,
                                                                                                                            NVL (MAMD_CD_FLOW_RACK, FNAPC) MTRL_CD_FLOW_RACK,
                                                                                                                            MAMD_FL_SEQ_LIST_MARKER,
                                                                                                                            PLNT_CD_LANG_M AS MTRL_CD_LANG_MAIN,
                                                                                                                            PLNT_CD_LANG_P AS MTRL_CD_LANG_PLANT,
                                                                                                                            PLNT_CD_LANG_A AS MTRL_CD_LANG_ALTERNATIVE,
                                                                                                                            NVL (P_ELT_ID_BATCH, N_ELT_ID_JOB_LOG) MAMD_ID_BATCH_ID,
                                                                                                                            MAMD_CD_SOURCE_SYSTEM,
                                                                                                                            DECODE (MTRL_ID_MTRL_MATERIAL, NULL, 'I', 'U') CONTROL_FIELD,
                                                                                                                            RANK () OVER (PARTITION BY MAMD_CD_PLANT_CD,
                                                                                                                                                       MAMD_ID_MAT_MASTER,
                                                                                                                                                       MTRL_CD_LANGUAGE
                                                                                                                                          ORDER BY MAMD_DT_LAST_UPDT_DT DESC) RNK
      FROM MAMD ,
        (SELECT *
         FROM DDWH02_DM_MA.TDIM_MTRL_MATERIAL
         WHERE MTRL_CD_PLANT_CD =P_ELT_CD_PLANT ) ,
        (SELECT LPDS_NR_ID_OBJECT,
                LPDS_ID_LANG_ID_LANGUAGE,
                LPDS_DS_SHORT_DESC
         FROM DDWH01_DW_MA.TM_LPDS_PLANT_DESCRIPTIONS,
              DDWH01_DW_MA.TM_PDTY_PLANT_DESC_TYPE
         WHERE LPDS_ID_PDTY_PLANT_DESC_TP = PDTY_ID_PLANT_DESC_TP
           AND PDTY_DS_DESC_NAME = 'MAMD'
           AND LPDS_CD_PLANT_CD =P_ELT_CD_PLANT ) LPDS_MAMD,

        (SELECT LPDS_NR_ID_OBJECT,
                LPDS_ID_LANG_ID_LANGUAGE,
                LPDS_DS_SHORT_DESC
         FROM DDWH01_DW_MA.TM_LPDS_PLANT_DESCRIPTIONS,
              DDWH01_DW_MA.TM_PDTY_PLANT_DESC_TYPE
         WHERE LPDS_ID_PDTY_PLANT_DESC_TP = PDTY_ID_PLANT_DESC_TP
           AND PDTY_DS_DESC_NAME = 'SPMD'
           AND LPDS_CD_PLANT_CD =P_ELT_CD_PLANT ) LPDS_SPMD,

        (SELECT LPDS_NR_ID_OBJECT,
                LPDS_ID_LANG_ID_LANGUAGE,
                LPDS_DS_SHORT_DESC
         FROM DDWH01_DW_MA.TM_LPDS_PLANT_DESCRIPTIONS,
              DDWH01_DW_MA.TM_PDTY_PLANT_DESC_TYPE
         WHERE LPDS_ID_PDTY_PLANT_DESC_TP = PDTY_ID_PLANT_DESC_TP
           AND PDTY_DS_DESC_NAME = 'MATM'
           AND LPDS_CD_PLANT_CD =P_ELT_CD_PLANT ) LPDS_MATM,

        (SELECT LPDS_NR_ID_OBJECT,
                LPDS_ID_LANG_ID_LANGUAGE,
                LPDS_DS_SHORT_DESC
         FROM DDWH01_DW_MA.TM_LPDS_PLANT_DESCRIPTIONS,
              DDWH01_DW_MA.TM_PDTY_PLANT_DESC_TYPE
         WHERE LPDS_ID_PDTY_PLANT_DESC_TP = PDTY_ID_PLANT_DESC_TP
           AND PDTY_DS_DESC_NAME = 'MRPT'
           AND LPDS_CD_PLANT_CD =P_ELT_CD_PLANT ) LPDS_MRPT,

        (SELECT LPDS_NR_ID_OBJECT,
                LPDS_ID_LANG_ID_LANGUAGE,
                LPDS_DS_SHORT_DESC
         FROM DDWH01_DW_MA.TM_LPDS_PLANT_DESCRIPTIONS,
              DDWH01_DW_MA.TM_PDTY_PLANT_DESC_TYPE
         WHERE LPDS_ID_PDTY_PLANT_DESC_TP = PDTY_ID_PLANT_DESC_TP
           AND PDTY_DS_DESC_NAME = 'LSMD'
           AND LPDS_CD_PLANT_CD =P_ELT_CD_PLANT ) LPDS_LSMD,

        (SELECT LPDS_NR_ID_OBJECT,
                LPDS_ID_LANG_ID_LANGUAGE,
                LPDS_DS_SHORT_DESC
         FROM DDWH01_DW_MA.TM_LPDS_PLANT_DESCRIPTIONS,
              DDWH01_DW_MA.TM_PDTY_PLANT_DESC_TYPE
         WHERE LPDS_ID_PDTY_PLANT_DESC_TP = PDTY_ID_PLANT_DESC_TP
           AND PDTY_DS_DESC_NAME = 'MSTU'
           AND LPDS_CD_PLANT_CD =P_ELT_CD_PLANT ) LPDS_MSTU,

        (SELECT LPDS_NR_ID_OBJECT,
                LPDS_ID_LANG_ID_LANGUAGE,
                LPDS_DS_SHORT_DESC
         FROM DDWH01_DW_MA.TM_LPDS_PLANT_DESCRIPTIONS,
              DDWH01_DW_MA.TM_PDTY_PLANT_DESC_TYPE
         WHERE LPDS_ID_PDTY_PLANT_DESC_TP = PDTY_ID_PLANT_DESC_TP
           AND PDTY_DS_DESC_NAME = 'MGRP'
           AND LPDS_CD_PLANT_CD =P_ELT_CD_PLANT ) LPDS_MGRP ,
        (SELECT DDWH02_DM_MA.FUNC_NOT_APPLICABLE_CODE FNAPC,
                DDWH02_DM_MA.FUNC_NOT_APPLICABLE FNAP,
                DDWH02_DM_MA.FUNC_NOT_AVAILABLE FNAV
         FROM DUAL) ,
        (SELECT *
         FROM DDWH01_DW_MA.TM_PLNT_PLANT
         WHERE PLNT_CD_PLANT_CD = P_ELT_CD_PLANT ) TM_PLNT_PLANT
      WHERE 1=1
        AND MAMD_ID_MAT_MASTER = MTRL_ID_MTRL_MATERIAL (+)
        AND LANG_CD = MTRL_CD_LANGUAGE (+)
        AND LANG_ID = LPDS_MAMD.LPDS_ID_LANG_ID_LANGUAGE (+)
        AND MAMD_ID_MAT_MASTER = LPDS_MAMD.LPDS_NR_ID_OBJECT (+)
        AND LANG_ID = LPDS_SPMD.LPDS_ID_LANG_ID_LANGUAGE (+)
        AND MAMD_ID_SPMD_SPEC_PROC_TP = LPDS_SPMD.LPDS_NR_ID_OBJECT (+)
        AND LANG_ID = LPDS_MATM.LPDS_ID_LANG_ID_LANGUAGE (+)
        AND MAMD_ID_MATM_MAT_TP = LPDS_MATM.LPDS_NR_ID_OBJECT (+)
        AND LANG_ID = LPDS_MRPT.LPDS_ID_LANG_ID_LANGUAGE (+)
        AND MAMD_ID_MRPT_MRP_TP = LPDS_MRPT.LPDS_NR_ID_OBJECT (+)
        AND LANG_ID = LPDS_LSMD.LPDS_ID_LANG_ID_LANGUAGE (+)
        AND MAMD_ID_LSMD_LOT_SIZE = LPDS_LSMD.LPDS_NR_ID_OBJECT (+)
        AND LANG_ID = LPDS_MSTU.LPDS_ID_LANG_ID_LANGUAGE (+)
        AND MAMD_ID_MSTU_MAT_STU = LPDS_MSTU.LPDS_NR_ID_OBJECT (+)
        AND LANG_ID = LPDS_MGRP.LPDS_ID_LANG_ID_LANGUAGE (+)
        AND MAMD_ID_MGRP_MAT_GRP = LPDS_MGRP.LPDS_NR_ID_OBJECT (+)
        AND MAMD_CD_PLANT_CD = PLNT_CD_PLANT_CD )
   WHERE RNK = 1 ) QRY ON (TRG.MTRL_CD_PLANT_CD = QRY.MAMD_CD_PLANT_CD
                           AND TRG.MTRL_ID_MTRL_MATERIAL = QRY.MAMD_ID_MAT_MASTER
                           AND TRG.MTRL_CD_LANGUAGE = QRY.MTRL_CD_LANGUAGE) WHEN MATCHED THEN
UPDATE
SET TRG.MTRL_CD_PART_NBR= QRY.MAMD_CD_PART_NBR,
    TRG.MTRL_DS_PART_NBR_DESC= QRY.LPDS_DS_SHORT_DESC,
    TRG.MTRL_CD_PROC_TP= QRY.MAMD_CD_MAKE_OR_BUY,
    TRG.MTRL_DS_PROC_TP_DESC= QRY.PTMD_DS_PROC_TP_DESC,
    TRG.MTRL_CD_SPEC_PROC_TP= QRY.MAMD_CD_SPEC_PROC_TP,
    TRG.MTRL_DS_SPEC_PROC_TP_DESC= QRY.LPDS_DS_SHORT_DESC2,
    TRG.MTRL_CD_MRP_CTRL_CD= QRY.MAMD_CD_MRP_CTRL_CD,
    TRG.MTRL_DS_MRP_CTRL_DESC= QRY.MRPC_DS_MRP_CTRL_DESC,
    TRG.MTRL_CS_TMC= QRY.MTRL_CS_TMC,
    TRG.MTRL_CD_DEF_INBOUND_AREA= QRY.LMMD_CD_DEF_INBOUND_AREA,
    TRG.MTRL_LD_DEF_INBOUND_AREA_DESC= QRY.LMMD_LD_DEF_INBOUND_AREA_DESC,
    TRG.MTRL_DS_PROD_STRG_LOC= '',
    TRG.MTRL_CD_DEF_STOCK_AREA= QRY.LMMD_CD_DEF_STOCK_AREA,
    TRG.MTRL_LD_DEF_STOCK_AREA_DESC= QRY.LMMD_LD_DEF_STOCK_AREA_DESC,
    TRG.MTRL_CD_MAT_TP= QRY.MAMD_CD_MAT_TP,
    TRG.MTRL_DS_MAT_TP_DESC= QRY.LPDS_DS_SHORT_DESC3,
    TRG.MTRL_CD_MRP_TP= QRY.MAMD_CD_MRP_TP,
    TRG.MTRL_DS_MRP_TP_DESC= QRY.LPDS_DS_SHORT_DESC4,
    TRG.MTRL_CD_LOT_SIZE= QRY.MAMD_CD_LOT_SIZE,
    TRG.MTRL_DS_LOT_SIZE_DESC= QRY.LPDS_DS_SHORT_DESC5,
    TRG.MTRL_FL_BACKFLUSHING_MARKER= QRY.MAMD_FL_BACKFLUSHING_CD,
    TRG.MTRL_CD_UNIT_OF_MEAS= QRY.MAMD_CD_UNIT_OF_MEAS,
    TRG.MTRL_DS_UNIT_OF_MEAS_DESC= QRY.UNME_DS_UNIT_OF_MEASUREMENT,
    TRG.MTRL_FL_BULK_MAT= QRY.MAMD_FL_BULK_MAT,
    TRG.MTRL_FL_LOGICAL_DLT= QRY.MAMD_FL_LOGICAL_DLT,
    TRG.MTRL_CD_ITM_FAM= QRY.MAMD_CD_ITM_FAM,
    TRG.MTRL_QT_NET_WEIGHT= QRY.MAMD_QT_NET_WEIGHT,
    TRG.MTRL_QT_GROSS_WEIGHT= QRY.MAMD_QT_GROSS_WEIGHT,
    TRG.MTRL_CD_UNIT_OF_MEAS_W= QRY.MAMD_CD_UNIT_OF_MEAS_W,
    TRG.MTRL_QT_VOLUME= QRY.MAMD_QT_VOLUME,
    TRG.MTRL_CD_UNIT_OF_MEAS_V= QRY.MAMD_CD_UNIT_OF_MEAS_V,
    TRG.MTRL_CD_MAT_SIZE= QRY.MAMD_CD_MAT_SIZE,
    TRG.MTRL_CD_MAT_STU= QRY.MAMD_CD_MAT_STU,
    TRG.MTRL_DS_MAT_STU_DESC= QRY.MAMD_DS_MAT_STU_DESC,
    TRG.MTRL_CD_MAT_GRP= QRY.MAMD_CD_MAT_GRP,
    TRG.MTRL_DS_MAT_GRP_DESC= QRY.MAMD_DS_MAT_GRP_DESC,
    TRG.MTRL_CD_UNIT_OF_MEAS_P= QRY.MAMD_CD_UNIT_OF_MEAS_P,
    TRG.MTRL_NR_PURCH_CONV_FACTOR= QRY.MAMD_NR_PURCH_CONV_FACTOR,
    TRG.MTRL_CD_UNIT_OF_MEAS_S= QRY.MAMD_CD_UNIT_OF_MEAS_S,
    TRG.MTRL_NR_SALES_CONV_FACTOR= QRY.MAMD_NR_SALES_CONV_FACTOR,
    TRG.MTRL_FL_SECURITY_FLAG= QRY.MAMD_FL_SECURITY_FLAG,
    TRG.MTRL_DT_LAST_UPDT_DT= QRY.MAMD_DT_LAST_UPDT_DT,
    TRG.MTRL_CD_ABC_INDIC= QRY.MAMD_CD_ABC_INDIC,
    TRG.MTRL_DS_ABC_INDIC_DESC= QRY.MAMD_DS_ABC_INDIC_DESC,
    TRG.MTRL_FL_FLAG_ICP= QRY.MAMD_FL_FLAG_ICP,
    TRG.MTRL_CD_PROD_HIERARCHY= QRY.MAMD_CD_PROD_HIERARCHY,
    TRG.MTRL_CD_TRACE_TP= QRY.MAMD_CD_TRACE_TP,
    TRG.MTRL_CD_MANUF_CD= QRY.MAMD_CD_MANUF_CD,
    TRG.MTRL_DS_MANUF_DESC= QRY.MAMD_DS_MANUF_DESC,
    TRG.MTRL_CD_MRP_GRP= QRY.MAMD_CD_MRP_GRP,
    TRG.MTRL_CD_ASS_MARK= QRY.MAMD_CD_ASS_MARK,
    TRG.MTRL_QT_SAFETY_STOCK= QRY.MAMD_QT_SAFETY_STOCK,
    TRG.MTRL_QT_MAX_STOCK_LEVEL= QRY.MAMD_QT_MAX_STOCK_LEVEL,
    TRG.MTRL_QT_MIN_LOT_SIZE= QRY.MAMD_QT_MIN_LOT_SIZE,
    TRG.MTRL_QT_MAX_LOT_SIZE= QRY.MAMD_QT_MAX_LOT_SIZE,
    TRG.MTRL_QT_REORD_POINT= QRY.MAMD_QT_REORD_POINT,
    TRG.MTRL_PC_SCRAP_QTY= QRY.MAMD_PC_SCRAP_QTY,
    TRG.MTRL_CD_ALT_NBR= QRY.MAMD_CD_ALT_NBR,
    TRG.MTRL_CD_PREFIX= QRY.MAMD_CD_PREFIX,
    TRG.MTRL_CD_DRW_NBR= QRY.MAMD_CD_DRW_NBR,
    TRG.MTRL_CD_SUFFIX= QRY.MAMD_CD_SUFFIX,
    TRG.MTRL_DS_LEAD_TIME_CLUSTER= QRY.MTRL_DS_LEAD_TIME_CLUSTER,
    TRG.MTRL_QT_PROD_LEAD_TIME= QRY.MAMD_QT_PROD_LEAD_TIME,
    TRG.MTRL_QT_PLN_DLVR_TIME= QRY.MAMD_QT_PLN_DLVR_TIME,
    TRG.MTRL_QT_INB_PROC_TIME= QRY.MAMD_QT_INB_PROC_TIME,
    TRG.MTRL_CD_THICKNESS= QRY.MAMD_CD_THICKNESS,
    TRG.MTRL_CD_GRADE_CAT= QRY.MAMD_CD_GRADE_CAT,
    TRG.MTRL_CD_CNH_CD= QRY.MAMD_CD_CNH_CD,
    TRG.MTRL_CD_PROJECT_CD= QRY.MAMD_CD_PROJECT_CD,
    TRG.MTRL_FL_REVISION_LEVEL= QRY.MAMD_FL_REVISION_LEVEL,
    TRG.MTRL_QT_FIXED_ORD_QTY= QRY.MAMD_QT_FIXED_ORD_QTY,
    TRG.MTRL_CD_ACCUMUL_CD= QRY.MAMD_CD_ACCUMUL_CD,
    TRG.MTRL_CD_ACQUIS_STORE_LOC= QRY.MAMD_CD_ACQUIS_STORE_LOC,
    TRG.MTRL_DS_ACQUIS_STORE_LOC_DESC= QRY.SLMD_DS_STORE_LOC_DESC,
    TRG.MTRL_CS_ACQUIS_COST= QRY.MAMD_CS_ACQUIS_COST,
    TRG.MTRL_CS_STOCK_COST= QRY.MAMD_CS_STOCK_COST,
    TRG.MTRL_CD_USG_ORG= QRY.MAMD_CD_USG_ORG,
    TRG.MTRL_QT_CARR_NBR= QRY.MAMD_QT_CARR_NBR,
    TRG.MTRL_QT_BAR_HOOK= QRY.MAMD_QT_BAR_HOOK,
    TRG.MTRL_NR_ACRYL_BTCP= QRY.MAMD_NR_ACRYL_BTCP,
    TRG.MTRL_NR_ACRYL_CD= QRY.MAMD_NR_ACRYL_CD,
    TRG.MTRL_CD_PAINT_PROC_COLOR= QRY.MAMD_CD_PAINT_PROC_COLOR,
    TRG.MTRL_DS_PAINT_PROC_COLOR_DESC= QRY.PPCL_DS_PAINT_PROC_COLOR_DESC,
    TRG.MTRL_CD_TOOL_TP= QRY.MAMD_CD_TOOL_TP,
    TRG.MTRL_DS_TOOL_TP_DESC= QRY.TTPM_DS_TOOL_TP_DESC,
    TRG.MTRL_CD_TOOL_WEIGHT= QRY.MAMD_CD_TOOL_WEIGHT,
    TRG.MTRL_CD_TOOL_LENGTH= QRY.MAMD_CD_TOOL_LENGTH,
    TRG.MTRL_CD_TOOL_HEIGHT= QRY.MAMD_CD_TOOL_HEIGHT,
    TRG.MTRL_CD_TOOL_WIDTH= QRY.MAMD_CD_TOOL_WIDTH,
    TRG.MTRL_QT_TOOL_QTY= QRY.MAMD_QT_TOOL_QTY,
    TRG.MTRL_FL_TOOL_PROG_MARK= QRY.MAMD_FL_TOOL_PROG_MARK,
    TRG.MTRL_CD_TOOL_SUBCTR= QRY.MAMD_CD_TOOL_SUBCTR,
    TRG.MTRL_CD_LAST_KIT_ID= QRY.MTRL_CD_LAST_KIT_ID,
    TRG.MTRL_CD_PROGRAM= QRY.MTRL_CD_PROGRAM,
    TRG.MTRL_QT_ANNUAL_USAGE= QRY.MAMD_QT_ANNUAL_USAGE,
    TRG.MTRL_FL_ACTIVE_PART= QRY.MAMD_FL_ACTIVE_PART,
    TRG.MTRL_FL_BUY_AGRMNT_MARKER= QRY.MAMD_FL_BUY_AGRMNT_MARKER,
    TRG.MTRL_QT_WH_MONTHLY= QRY.MAMD_QT_WH_MONTHLY,
    TRG.MTRL_QT_LIN_MONTHLY= QRY.MAMD_QT_LIN_MONTHLY,
    TRG.MTRL_QT_WH_DAILY= QRY.MAMD_QT_WH_DAILY,
    TRG.MTRL_QT_BLOCKED_QTY= QRY.MAMD_QT_BLOCKED_QTY,
    TRG.MTRL_QT_RES_QTY= QRY.MAMD_QT_RES_QTY,
    TRG.MTRL_QT_TOT_AVAILABLE_QTY= QRY.MAMD_QT_TOT_AVAILABLE_QTY,
    TRG.MTRL_QT_LIN_DAILY= QRY.MAMD_QT_LIN_DAILY,
    TRG.MTRL_QT_TO_CQA_QTY= QRY.WINV_QT_TO_CQA_QTY,
    TRG.MTRL_QT_CQA_QTY= QRY.WINV_QT_CQA_QTY,
    TRG.MTRL_QT_RDY_CQA_QTY= QRY.WINV_QT_RDY_CQA_QTY,
    TRG.MTRL_DT_LAST_INV_MOV_DT= QRY.LMMD_DT_LAST_INV_MOV_DT,
    TRG.MTRL_DT_LAST_CYCLE_DT= QRY.LMMD_DT_LAST_CYCLE_DT,
    TRG.MTRL_ID_AREA_PREF_AREA= QRY.MAMD_ID_ATMD_PREF_AREA,
    TRG.MTRL_CD_PREF_AREA= QRY.MAMD_CD_PREF_AREA,
    TRG.MTRL_FL_CONT_MARK= QRY.LMMD_FL_CONT_MARK,
    TRG.MTRL_DT_MRP_SOD_DT= QRY.MAMD_DT_MRP_SOD_DT,
    TRG.MTRL_DT_MRP_PLAN_DT= QRY.MAMD_DT_MRP_PLAN_DT,
    TRG.MTRL_NR_REM_COV_DAYS= QRY.MAMD_NR_REM_COV_DAYS,
    TRG.MTRL_FL_ALREADY_SO= QRY.MAMD_FL_ALREADY_SO,
    TRG.MTRL_ID_PLST_SOD_WCTR_CD= QRY.MTRL_ID_PLST_SOD_WCTR_CD,
    TRG.MTRL_CD_SOD_WCTR_CD= QRY.MTRL_CD_SOD_WCTR_CD,
    TRG.MTRL_QT_CUM_REQ_QTY= QRY.MTRL_QT_CUM_REQ_QTY,
    TRG.MTRL_CD_STOCK_TP= QRY.MTRL_CD_STOCK_TP,
    TRG.MTRL_CD_DEP_CD= QRY.MTRL_CD_DEP_CD,
    TRG.MTRL_CD_KIT_FIX_POS= QRY.MTRL_CD_KIT_FIX_POS,
    TRG.MTRL_CD_FLOW_RACK= QRY.MTRL_CD_FLOW_RACK,
    TRG.MTRL_CD_LANG_MAIN= QRY.MTRL_CD_LANG_MAIN,
    TRG.MTRL_CD_LANG_PLANT= QRY.MTRL_CD_LANG_PLANT,
    TRG.MTRL_CD_LANG_ALTERNATIVE= QRY.MTRL_CD_LANG_ALTERNATIVE,
    TRG.MTRL_ID_BATCH_ID= QRY.MAMD_ID_BATCH_ID,
    TRG.MTRL_CD_SOURCE_SYSTEM= QRY.MAMD_CD_SOURCE_SYSTEM,
    TRG.MTRL_CD_OPERATOR_CODE= 'ETL',
    TRG.MTRL_DT_UPD_ROW= SYSDATE WHEN NOT MATCHED THEN
INSERT (MTRL_CD_PLANT_CD,
        MTRL_ID_MTRL_MATERIAL,
        MTRL_CD_LANGUAGE,
        MTRL_CD_PART_NBR,
        MTRL_DS_PART_NBR_DESC,
        MTRL_CD_PROC_TP,
        MTRL_DS_PROC_TP_DESC,
        MTRL_CD_SPEC_PROC_TP,
        MTRL_DS_SPEC_PROC_TP_DESC,
        MTRL_CD_MRP_CTRL_CD,
        MTRL_DS_MRP_CTRL_DESC,
        MTRL_CS_TMC,
        MTRL_CD_DEF_INBOUND_AREA,
        MTRL_LD_DEF_INBOUND_AREA_DESC,
        MTRL_CD_DEF_STOCK_AREA,
        MTRL_LD_DEF_STOCK_AREA_DESC,
        MTRL_CD_MAT_TP,
        MTRL_DS_MAT_TP_DESC,
        MTRL_CD_MRP_TP,
        MTRL_DS_MRP_TP_DESC,
        MTRL_CD_LOT_SIZE,
        MTRL_DS_LOT_SIZE_DESC,
        MTRL_FL_BACKFLUSHING_MARKER,
        MTRL_CD_UNIT_OF_MEAS,
        MTRL_DS_UNIT_OF_MEAS_DESC,
        MTRL_FL_BULK_MAT,
        MTRL_FL_LOGICAL_DLT,
        MTRL_CD_ITM_FAM,
        MTRL_QT_NET_WEIGHT,
        MTRL_QT_GROSS_WEIGHT,
        MTRL_CD_UNIT_OF_MEAS_W,
        MTRL_QT_VOLUME,
        MTRL_CD_UNIT_OF_MEAS_V,
        MTRL_CD_MAT_SIZE,
        MTRL_CD_MAT_STU,
        MTRL_DS_MAT_STU_DESC,
        MTRL_CD_MAT_GRP,
        MTRL_DS_MAT_GRP_DESC,
        MTRL_CD_UNIT_OF_MEAS_P,
        MTRL_NR_PURCH_CONV_FACTOR,
        MTRL_CD_UNIT_OF_MEAS_S,
        MTRL_NR_SALES_CONV_FACTOR,
        MTRL_FL_SECURITY_FLAG,
        MTRL_DT_LAST_UPDT_DT,
        MTRL_CD_ABC_INDIC,
        MTRL_DS_ABC_INDIC_DESC,
        MTRL_FL_FLAG_ICP,
        MTRL_CD_PROD_HIERARCHY,
        MTRL_CD_TRACE_TP,
        MTRL_CD_MANUF_CD,
        MTRL_DS_MANUF_DESC,
        MTRL_CD_MRP_GRP,
        MTRL_CD_ASS_MARK,
        MTRL_QT_SAFETY_STOCK,
        MTRL_QT_MAX_STOCK_LEVEL,
        MTRL_QT_MIN_LOT_SIZE,
        MTRL_QT_MAX_LOT_SIZE,
        MTRL_QT_REORD_POINT,
        MTRL_PC_SCRAP_QTY,
        MTRL_CD_ALT_NBR,
        MTRL_CD_PREFIX,
        MTRL_CD_DRW_NBR,
        MTRL_CD_SUFFIX,
        MTRL_DS_LEAD_TIME_CLUSTER,
        MTRL_QT_PROD_LEAD_TIME,
        MTRL_QT_PLN_DLVR_TIME,
        MTRL_QT_INB_PROC_TIME,
        MTRL_CD_THICKNESS,
        MTRL_CD_GRADE_CAT,
        MTRL_CD_CNH_CD,
        MTRL_CD_PROJECT_CD,
        MTRL_FL_REVISION_LEVEL,
        MTRL_QT_FIXED_ORD_QTY,
        MTRL_CD_ACCUMUL_CD,
        MTRL_CD_ACQUIS_STORE_LOC,
        MTRL_DS_ACQUIS_STORE_LOC_DESC,
        MTRL_CS_ACQUIS_COST,
        MTRL_CS_STOCK_COST,
        MTRL_CD_USG_ORG,
        MTRL_QT_CARR_NBR,
        MTRL_QT_BAR_HOOK,
        MTRL_NR_ACRYL_BTCP,
        MTRL_NR_ACRYL_CD,
        MTRL_CD_PAINT_PROC_COLOR,
        MTRL_DS_PAINT_PROC_COLOR_DESC,
        MTRL_CD_TOOL_TP,
        MTRL_DS_TOOL_TP_DESC,
        MTRL_CD_TOOL_WEIGHT,
        MTRL_CD_TOOL_LENGTH,
        MTRL_CD_TOOL_HEIGHT,
        MTRL_CD_TOOL_WIDTH,
        MTRL_QT_TOOL_QTY,
        MTRL_FL_TOOL_PROG_MARK,
        MTRL_CD_TOOL_SUBCTR,
        MTRL_CD_LAST_KIT_ID,
        MTRL_CD_PROGRAM,
        MTRL_QT_ANNUAL_USAGE,
        MTRL_FL_ACTIVE_PART,
        MTRL_FL_BUY_AGRMNT_MARKER,
        MTRL_QT_WH_MONTHLY,
        MTRL_QT_LIN_MONTHLY,
        MTRL_QT_WH_DAILY,
        MTRL_QT_BLOCKED_QTY,
        MTRL_QT_RES_QTY,
        MTRL_QT_TOT_AVAILABLE_QTY,
        MTRL_QT_LIN_DAILY,
        MTRL_QT_TO_CQA_QTY,
        MTRL_QT_CQA_QTY,
        MTRL_QT_RDY_CQA_QTY,
        MTRL_DT_LAST_INV_MOV_DT,
        MTRL_DT_LAST_CYCLE_DT,
        MTRL_ID_AREA_PREF_AREA,
        MTRL_CD_PREF_AREA,
        MTRL_FL_CONT_MARK,
        MTRL_DT_MRP_SOD_DT,
        MTRL_DT_MRP_PLAN_DT,
        MTRL_NR_REM_COV_DAYS,
        MTRL_FL_ALREADY_SO,
        MTRL_ID_PLST_SOD_WCTR_CD,
        MTRL_CD_SOD_WCTR_CD,
        MTRL_QT_CUM_REQ_QTY,
        MTRL_CD_STOCK_TP,
        MTRL_CD_DEP_CD,
        MTRL_CD_KIT_FIX_POS,
        MTRL_CD_FLOW_RACK,
        MTRL_CD_LANG_MAIN,
        MTRL_CD_LANG_PLANT,
        MTRL_CD_LANG_ALTERNATIVE,
        MTRL_ID_BATCH_ID,
        MTRL_CD_SOURCE_SYSTEM,
        MTRL_CD_OPERATOR_CODE,
        MTRL_FL_SEQ_LIST_MARKER,
        MTRL_DT_INS_ROW,
        MTRL_DT_UPD_ROW)
VALUES (QRY.MAMD_CD_PLANT_CD, QRY.MAMD_ID_MAT_MASTER, QRY.MTRL_CD_LANGUAGE, QRY.MAMD_CD_PART_NBR, QRY.LPDS_DS_SHORT_DESC, QRY.MAMD_CD_MAKE_OR_BUY, QRY.PTMD_DS_PROC_TP_DESC, QRY.MAMD_CD_SPEC_PROC_TP, QRY.LPDS_DS_SHORT_DESC2, QRY.MAMD_CD_MRP_CTRL_CD, QRY.MRPC_DS_MRP_CTRL_DESC, QRY.MTRL_CS_TMC, QRY.LMMD_CD_DEF_INBOUND_AREA, QRY.LMMD_LD_DEF_INBOUND_AREA_DESC, QRY.LMMD_CD_DEF_STOCK_AREA, QRY.LMMD_LD_DEF_STOCK_AREA_DESC, QRY.MAMD_CD_MAT_TP, QRY.LPDS_DS_SHORT_DESC3, QRY.MAMD_CD_MRP_TP, QRY.LPDS_DS_SHORT_DESC4, QRY.MAMD_CD_LOT_SIZE, QRY.LPDS_DS_SHORT_DESC5, QRY.MAMD_FL_BACKFLUSHING_CD, QRY.MAMD_CD_UNIT_OF_MEAS, QRY.UNME_DS_UNIT_OF_MEASUREMENT, QRY.MAMD_FL_BULK_MAT, QRY.MAMD_FL_LOGICAL_DLT, QRY.MAMD_CD_ITM_FAM, QRY.MAMD_QT_NET_WEIGHT, QRY.MAMD_QT_GROSS_WEIGHT, QRY.MAMD_CD_UNIT_OF_MEAS_W, QRY.MAMD_QT_VOLUME, QRY.MAMD_CD_UNIT_OF_MEAS_V, QRY.MAMD_CD_MAT_SIZE, QRY.MAMD_CD_MAT_STU, QRY.MAMD_DS_MAT_STU_DESC, QRY.MAMD_CD_MAT_GRP, QRY.MAMD_DS_MAT_GRP_DESC, QRY.MAMD_CD_UNIT_OF_MEAS_P, QRY.MAMD_NR_PURCH_CONV_FACTOR, QRY.MAMD_CD_UNIT_OF_MEAS_S, QRY.MAMD_NR_SALES_CONV_FACTOR, QRY.MAMD_FL_SECURITY_FLAG, QRY.MAMD_DT_LAST_UPDT_DT, QRY.MAMD_CD_ABC_INDIC, QRY.MAMD_DS_ABC_INDIC_DESC, QRY.MAMD_FL_FLAG_ICP, QRY.MAMD_CD_PROD_HIERARCHY, QRY.MAMD_CD_TRACE_TP, QRY.MAMD_CD_MANUF_CD, QRY.MAMD_DS_MANUF_DESC, QRY.MAMD_CD_MRP_GRP, QRY.MAMD_CD_ASS_MARK, QRY.MAMD_QT_SAFETY_STOCK, QRY.MAMD_QT_MAX_STOCK_LEVEL, QRY.MAMD_QT_MIN_LOT_SIZE, QRY.MAMD_QT_MAX_LOT_SIZE, QRY.MAMD_QT_REORD_POINT, QRY.MAMD_PC_SCRAP_QTY, QRY.MAMD_CD_ALT_NBR, QRY.MAMD_CD_PREFIX, QRY.MAMD_CD_DRW_NBR, QRY.MAMD_CD_SUFFIX, QRY.MTRL_DS_LEAD_TIME_CLUSTER, QRY.MAMD_QT_PROD_LEAD_TIME, QRY.MAMD_QT_PLN_DLVR_TIME, QRY.MAMD_QT_INB_PROC_TIME, QRY.MAMD_CD_THICKNESS, QRY.MAMD_CD_GRADE_CAT, QRY.MAMD_CD_CNH_CD, QRY.MAMD_CD_PROJECT_CD, QRY.MAMD_FL_REVISION_LEVEL, QRY.MAMD_QT_FIXED_ORD_QTY, QRY.MAMD_CD_ACCUMUL_CD, QRY.MAMD_CD_ACQUIS_STORE_LOC, QRY.SLMD_DS_STORE_LOC_DESC, QRY.MAMD_CS_ACQUIS_COST, QRY.MAMD_CS_STOCK_COST, QRY.MAMD_CD_USG_ORG, QRY.MAMD_QT_CARR_NBR, QRY.MAMD_QT_BAR_HOOK, QRY.MAMD_NR_ACRYL_BTCP, QRY.MAMD_NR_ACRYL_CD, QRY.MAMD_CD_PAINT_PROC_COLOR, QRY.PPCL_DS_PAINT_PROC_COLOR_DESC, QRY.MAMD_CD_TOOL_TP, QRY.TTPM_DS_TOOL_TP_DESC, QRY.MAMD_CD_TOOL_WEIGHT, QRY.MAMD_CD_TOOL_LENGTH, QRY.MAMD_CD_TOOL_HEIGHT, QRY.MAMD_CD_TOOL_WIDTH, QRY.MAMD_QT_TOOL_QTY, QRY.MAMD_FL_TOOL_PROG_MARK, QRY.MAMD_CD_TOOL_SUBCTR, QRY.MTRL_CD_LAST_KIT_ID, QRY.MTRL_CD_PROGRAM, QRY.MAMD_QT_ANNUAL_USAGE, QRY.MAMD_FL_ACTIVE_PART, QRY.MAMD_FL_BUY_AGRMNT_MARKER, QRY.MAMD_QT_WH_MONTHLY, QRY.MAMD_QT_LIN_MONTHLY, QRY.MAMD_QT_WH_DAILY, QRY.MAMD_QT_BLOCKED_QTY, QRY.MAMD_QT_RES_QTY, QRY.MAMD_QT_TOT_AVAILABLE_QTY, QRY.MAMD_QT_LIN_DAILY, QRY.WINV_QT_TO_CQA_QTY, QRY.WINV_QT_CQA_QTY, QRY.WINV_QT_RDY_CQA_QTY, QRY.LMMD_DT_LAST_INV_MOV_DT, QRY.LMMD_DT_LAST_CYCLE_DT, QRY.MAMD_ID_ATMD_PREF_AREA, QRY.MAMD_CD_PREF_AREA, QRY.LMMD_FL_CONT_MARK, QRY.MAMD_DT_MRP_SOD_DT, QRY.MAMD_DT_MRP_PLAN_DT, QRY.MAMD_NR_REM_COV_DAYS, QRY.MAMD_FL_ALREADY_SO, QRY.MTRL_ID_PLST_SOD_WCTR_CD, QRY.MTRL_CD_SOD_WCTR_CD, QRY.MTRL_QT_CUM_REQ_QTY, QRY.MTRL_CD_STOCK_TP, QRY.MTRL_CD_DEP_CD, QRY.MTRL_CD_KIT_FIX_POS, QRY.MTRL_CD_FLOW_RACK, QRY.MTRL_CD_LANG_MAIN, QRY.MTRL_CD_LANG_PLANT, QRY.MTRL_CD_LANG_ALTERNATIVE, QRY.MAMD_ID_BATCH_ID, QRY.MAMD_CD_SOURCE_SYSTEM, 'ETL', QRY.MAMD_FL_SEQ_LIST_MARKER, SYSDATE, SYSDATE)