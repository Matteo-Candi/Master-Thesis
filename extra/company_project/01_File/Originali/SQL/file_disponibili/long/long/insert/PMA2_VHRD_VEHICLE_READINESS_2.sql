INSERT INTO DDWH02_DM_MA.TW_VHRD_VEHICLE_READINESS (VHRD_CD_PLANT_CD, VHRD_ID_VHRD, VHRD_ID_VEHI_FIRST_VAN, VHRD_CD_FIRST_VAN, VHRD_CD_SERIE, VHRD_ID_MTRL_ENG_VAR, VHRD_CD_ENG_VAR, VHRD_ID_MTRL_PART_NBR, VHRD_CD_PART_NBR, VHRD_ID_TIME_FIXED_KEY_DT, VHRD_ID_PLST_WCTR_CD, VHRD_CD_WCTR_CD, VHRD_CD_OP, VHRD_CD_STU, VHRD_NR_ROUTING_LEVEL, VHRD_CD_LN_PREALLOC_AREA, VHRD_CD_LN_BIN_TP, VHRD_CD_LN_REPL_TP, VHRD_QT_LN_REPL_QTY, VHRD_QT_LN_DEC_QTY, VHRD_CD_LN_FLOW_RACK, VHRD_CD_WH_PREALLOC_AREA, VHRD_CD_WH_BIN_TP, VHRD_CD_WH_REPL_TP, VHRD_QT_WH_REPL_QTY, VHRD_QT_WH_DEC_QTY, VHRD_CD_WH_FLOW_RACK, VHRD_LD_LIST_PROD_ORG, VHRD_LD_LIST_PROD_OP, VHRD_NT_LIST_PROD_TOOLS, VHRD_QT_PART_QTY, VHRD_QT_PART_CNT_QTY, VHRD_CD_LAST_ORD_PROD, VHRD_CD_LAST_EFF_ORD, VHRD_ID_TIME_LAST_CONFIRM_DT, VHRD_QT_LAST_PROD_QTY, VHRD_ID_PRST_LAST_ORD_STU, VHRD_CD_LAST_ORD_STU, VHRD_CD_WIP_ORD_PROD, VHRD_CD_WIP_EFF_ORD, VHRD_CD_WIP_CONFIRM_OP, VHRD_ID_TIME_WIP_CONFIRM_DT, VHRD_QT_WIP_QTY, VHRD_ID_PRST_WIP_ORD_STU, VHRD_CD_WIP_ORD_STU, VHRD_ID_ISIR_MAKE_ISIR_CD, VHRD_CD_MAKE_ISIR_CD, VHRD_CD_MAKE_REVISION_LEVEL, VHRD_FL_CSCN_MARK, VHRD_ID_VEND_LAST_SUPPL_CD, VHRD_CD_LAST_SUPPL_CD, VHRD_CD_LAST_PURCH_ORD, VHRD_CD_LAST_PURCH_ORD_LN, VHRD_ID_TIME_LAST_RCVD_DT, VHRD_QT_LAST_RCVD_QT, VHRD_ID_SITE_SITE_INT, VHRD_CD_SITE_INT, VHRD_ID_TIME_PURCH_ORD_DLVR_DT, VHRD_ID_TIME_PURCH_ORD_SHIP_DT, VHRD_QT_REQ_QTY, VHRD_QT_CUM_REQ_QTY, VHRD_QT_CUM_REC_QTY, VHRD_QT_TRANS_QTY, VHRD_QT_CUM_PUR_QTY, VHRD_CD_LAST_REC_PACKLIST, VHRD_CD_LAST_ASN_PACKLIST, VHRD_CD_LAST_PICKUP_REQID, VHRD_ID_TIME_PROM_DT, VHRD_DT_PROM_DT, VHRD_QT_PROM_QTY, VHRD_DS_PURCH_NOTE, VHRD_DS_PROD_NOTE, VHRD_ID_ISIR_BUY_ISIR_CD, VHRD_CD_BUY_ISIR_CD, VHRD_CD_BUY_REVISION_LEVEL, VHRD_ID_BATCH_ID, VHRD_CD_SOURCE_SYSTEM, VHRD_CD_OPERATOR_CODE, VHRD_DT_INS_ROW, VHRD_DT_UPD_ROW)
SELECT VHRD_CD_PLANT_CD,
       VHRD_ID_VHRD,
       VHRD_ID_VEHI_FIRST_VAN,
       VHRD_CD_FIRST_VAN,
       VHRD_CD_SERIE,
       VHRD_ID_MTRL_ENG_VAR,
       VHRD_CD_ENG_VAR,
       VHRD_ID_MTRL_PART_NBR,
       VHRD_CD_PART_NBR,
       NVL (VHRD_ID_TIME_FIXED_KEY_DT, -2),
       VHRD_ID_PLST_WCTR_CD,
       VHRD_CD_WCTR_CD,
       VHRD_CD_OP,
       VHRD_CD_STU,
       VHRD_NR_ROUTING_LEVEL,
       VHRD_CD_LN_PREALLOC_AREA,
       VHRD_CD_LN_BIN_TP,
       VHRD_CD_LN_REPL_TP,
       VHRD_QT_LN_REPL_QTY,
       VHRD_QT_LN_DEC_QTY,
       VHRD_CD_LN_FLOW_RACK,
       VHRD_CD_WH_PREALLOC_AREA,
       VHRD_CD_WH_BIN_TP,
       VHRD_CD_WH_REPL_TP,
       VHRD_QT_WH_REPL_QTY,
       VHRD_QT_WH_DEC_QTY,
       VHRD_CD_WH_FLOW_RACK,
       VHRD_LD_LIST_PROD_ORG,
       VHRD_LD_LIST_PROD_OP,
       VHRD_NT_LIST_PROD_TOOL,
       VHRD_QT_PART_QTY,
       VHRD_QT_PART_CNT_QTY,
       VHRD_CD_LAST_ORD_PROD,
       VHRD_CD_LAST_EFF_ORD,
       NVL (VHRD_ID_TIME_LAST_CONFIRM_DT, -2),
       VHRD_QT_LAST_PROD_QTY,
       NVL (VHRD_ID_PRST_LAST_ORD_STU, -2),
       NVL (VHRD_CD_LAST_ORD_STU, FNAC),
       VHRD_CD_WIP_ORD_PROD,
       VHRD_CD_WIP_EFF_ORD,
       VHRD_CD_WIP_CONFIRM_OP,
       NVL (VHRD_ID_TIME_WIP_CONFIRM_DT, -2),
       VHRD_QT_WIP_QTY,
       NVL (VHRD_ID_PRST_WIP_ORD_STU, -2),
       NVL (VHRD_CD_WIP_ORD_STU, FNAC),
       NVL (MAKE.ISIR_ID_ICMD_ISIR_CD, -2),
       NVL (MAKE.ISIR_CD_ISIR_CD, FNAC),
       NVL (MAKE.ISIR_CD_REVISION_LEVEL, FNAC),
       VHRD_FL_CSCN_MARK,
       VHRD_ID_VEND_LAST_SUPPL_CD,
       VHRD_CD_LAST_SUPPL_CD,
       VHRD_CD_LAST_PURCH_ORD,
       VHRD_CD_LAST_PURCH_ORD_LN,
       NVL (VHRD_ID_TIME_LAST_RCVD_DT, -2),
       VHRD_QT_LAST_RCVD_QT,
       NVL (VHRD_ID_SITE_SITE_INT, -2),
       NVL (VHRD_CD_SITE_INT, FNAC),
       NVL (VHRD_ID_TIME_PURCH_ORD_DLVR_DT, -2),
       NVL (VHRD_ID_TIME_PURCH_ORD_SHIP_DT, -2),
       VHRD_QT_REQ_QTY,
       VHRD_QT_CUM_REQ_QTY,
       VHRD_QT_CUM_REC_QTY,
       VHRD_QT_TRANS_QTY,
       VHRD_QT_CUM_PUR_QTY,
       VHRD_CD_LAST_REC_PACKLIST,
       VHRD_CD_LAST_ASN_PACKLIST,
       VHRD_CD_LAST_PICKUP_REQID,
       NVL (VHRD_ID_TIME_PROM_DT, -2),
       VHRD_DT_PROM_DT,
       VHRD_QT_PROM_QTY,
       VHRD_DS_PURCH_NOTE,
       VHRD_DS_PROD_NOTE,
       NVL (BUY.ISIR_ID_ICMD_ISIR_CD, -2),
       NVL (BUY.ISIR_CD_ISIR_CD, FNAC),
       NVL (BUY.ISIR_CD_REVISION_LEVEL, FNAC),
       NVL (P_ELT_ID_BATCH, N_ELT_ID_JOB_LOG) AS VHRD_ID_BATCH_ID,
       VHRD_CD_SOURCE_SYSTEM,
       'ETL',
       SYSDATE,
       SYSDATE
FROM
  (SELECT VHRD_CD_PLANT_CD,
          VHRD_ID_VHRD,
          VHRD_ID_VEHI_FIRST_VAN,
          VHRD_CD_FIRST_VAN,
          VHRD_CD_SERIE,
          VHRD_ID_MTRL_ENG_VAR,
          VHRD_CD_ENG_VAR,
          VHRD_ID_MTRL_PART_NBR,
          VHRD_CD_PART_NBR,
          VHRD_ID_TIME_FIXED_KEY_DT,
          VHRD_ID_PLST_WCTR_CD,
          VHRD_CD_WCTR_CD,
          VHRD_CD_OP,
          VHRD_CD_STU,
          VHRD_NR_ROUTING_LEVEL,
          VHRD_CD_LN_PREALLOC_AREA,
          VHRD_CD_LN_BIN_TP,
          VHRD_CD_LN_REPL_TP,
          VHRD_QT_LN_REPL_QTY,
          VHRD_QT_LN_DEC_QTY,
          CASE
              WHEN VHRD_CD_LN_PREALLOC_AREA IS NULL THEN NULL
              WHEN INSTR (VHRD_CD_LN_PREALLOC_AREA, '.', 1, 3) <>0
                   AND INSTR (VHRD_CD_LN_PREALLOC_AREA, '.', 1, 4) =0 THEN 'YES'
              ELSE 'NO'
          END AS VHRD_CD_LN_FLOW_RACK,
          VHRD_CD_WH_PREALLOC_AREA,
          VHRD_CD_WH_BIN_TP,
          VHRD_CD_WH_REPL_TP,
          VHRD_QT_WH_REPL_QTY,
          VHRD_QT_WH_DEC_QTY,
          CASE
              WHEN VHRD_CD_WH_PREALLOC_AREA IS NULL THEN NULL
              WHEN INSTR (VHRD_CD_WH_PREALLOC_AREA, '.', 1, 3) <>0
                   AND INSTR (VHRD_CD_WH_PREALLOC_AREA, '.', 1, 4) =0 THEN 'YES'
              ELSE 'NO'
          END AS VHRD_CD_WH_FLOW_RACK,
          VHRD_LD_LIST_PROD_ORG,
          VHRD_LD_LIST_PROD_OP,
          VHRD_NT_LIST_PROD_TOOL,
          VHRD_QT_PART_QTY,
          VHRD_QT_PART_CNT_QTY,
          VHRD_CD_LAST_ORD_PROD,
          VHRD_CD_LAST_EFF_ORD,
          VHRD_ID_TIME_LAST_CONFIRM_DT,
          VHRD_QT_LAST_PROD_QTY,
          VHRD_ID_PRST_LAST_ORD_STU,
          VHRD_CD_LAST_ORD_STU,
          VHRD_CD_WIP_ORD_PROD,
          VHRD_CD_WIP_EFF_ORD,
          VHRD_CD_WIP_CONFIRM_OP,
          VHRD_ID_TIME_WIP_CONFIRM_DT,
          VHRD_QT_WIP_QTY,
          VHRD_ID_PRST_WIP_ORD_STU,
          VHRD_CD_WIP_ORD_STU,
          VHRD_FL_CSCN_MARK,
          VHRD_ID_VEND_LAST_SUPPL_CD,
          VHRD_CD_LAST_SUPPL_CD,
          VHRD_CD_LAST_PURCH_ORD,
          VHRD_CD_LAST_PURCH_ORD_LN,
          VHRD_ID_TIME_LAST_RCVD_DT,
          VHRD_QT_LAST_RCVD_QT,
          VHRD_ID_SITE_SITE_INT,
          VHRD_CD_SITE_INT,
          VHRD_ID_TIME_PURCH_ORD_DLVR_DT,
          VHRD_ID_TIME_PURCH_ORD_SHIP_DT,
          VHRD_QT_REQ_QTY,
          VHRD_QT_CUM_REQ_QTY,
          VHRD_QT_CUM_REC_QTY,
          VHRD_QT_TRANS_QTY,
          VHRD_QT_CUM_PUR_QTY,
          VHRD_CD_LAST_REC_PACKLIST,
          VHRD_CD_LAST_ASN_PACKLIST,
          VHRD_CD_LAST_PICKUP_REQID,
          VHRD_ID_TIME_PROM_DT,
          VHRD_DT_PROM_DT,
          VHRD_QT_PROM_QTY,
          VHRD_DS_PURCH_NOTE,
          VHRD_DS_PROD_NOTE,

     (SELECT MAX (ROWID) KEEP (DENSE_RANK FIRST
                               ORDER BY ISIR_ID_ISIR_MASTER DESC)
      FROM DDWH01_DW_MA.TM_ISIR_ISIR_MASTER
      WHERE ISIR_CD_PLANT_CD = P_ELT_CD_PLANT
        AND ISIR_FL_BUY = '0'
        AND ISIR_CD_PART_NBR = VHRD_CD_PART_NBR
        AND VHRD_DT_TIME_FIXED_KEY_DT BETWEEN ISIR_DT_VALID_STR_DT AND ISIR_DT_VALID_END_DT ) MAKE_ISIR,

     (SELECT MAX (ROWID) KEEP (DENSE_RANK FIRST
                               ORDER BY ISIR_ID_ISIR_MASTER DESC) BUY_ISIR
      FROM DDWH01_DW_MA.TM_ISIR_ISIR_MASTER
      WHERE ISIR_CD_PLANT_CD = P_ELT_CD_PLANT
        AND ISIR_FL_BUY = '1'
        AND ISIR_CD_PART_NBR = VHRD_CD_PART_NBR
        AND ISIR_CD_SUPPL_CD = VHRD_CD_LAST_SUPPL_CD
        AND VHRD_DT_TIME_FIXED_KEY_DT BETWEEN ISIR_DT_VALID_STR_DT AND ISIR_DT_VALID_END_DT ) BUY_ISIR,
          VHRD_CD_SOURCE_SYSTEM
   FROM
     (SELECT COMP.COUS_CD_PLANT_CD VHRD_CD_PLANT_CD,
             MAX (COMP.COUS_ID_COUS) VHRD_ID_VHRD,
                 COMP.COUS_ID_VEHI_FIRST_VAN VHRD_ID_VEHI_FIRST_VAN,
                 COMP.COUS_CD_FIRST_VAN VHRD_CD_FIRST_VAN,
                 COMP.COUS_CD_SERIE VHRD_CD_SERIE,
                 COMP.COUS_ID_MTRL_ENG_VAR VHRD_ID_MTRL_ENG_VAR,
                 COMP.COUS_CD_ENG_VAR VHRD_CD_ENG_VAR,
                 COMP.COUS_ID_MTRL_COMP VHRD_ID_MTRL_PART_NBR,
                 COMP.COUS_CD_COMP VHRD_CD_PART_NBR,
                 COMP.COUS_ID_TIME_FIXED_KEY_DT VHRD_ID_TIME_FIXED_KEY_DT,
                 TO_DATE (CASE
                              WHEN COMP.COUS_ID_TIME_FIXED_KEY_DT > 0 THEN COMP.COUS_ID_TIME_FIXED_KEY_DT
                              ELSE NULL
                          END, 'J') VHRD_DT_TIME_FIXED_KEY_DT,
                 COMP.COUS_ID_PLST_WCTR_CD VHRD_ID_PLST_WCTR_CD,
                 COMP.COUS_CD_WCTR_CD VHRD_CD_WCTR_CD,
                 COMP.COUS_CD_OP VHRD_CD_OP,
                 COMP.COUS_CD_STU VHRD_CD_STU,
                 MIN (COMP.COUS_NR_ROUTING_LEVEL) VHRD_NR_ROUTING_LEVEL,
                     MAX (LORU_DERU_LN.LORU_CD_PREALLOC_AREA) KEEP (DENSE_RANK FIRST
                                                                    ORDER BY CASE
                                                                                 WHEN LORU_DERU_LN.LORU_WS = SUBSTR (COUS_CD_WCTR_CD, 1, 7) THEN 1
                                                                                 WHEN LORU_DERU_LN.LORU_ORG = SUBSTR (COUS_CD_WCTR_CD, 1, 3) THEN 2
                                                                                 ELSE 9
                                                                             END, LORU_DERU_LN.LORU_ID_ALLOCATION_RULES) AS VHRD_CD_LN_PREALLOC_AREA,
                         MAX (LORU_DERU_LN.LORU_CD_BIN_TP) KEEP (DENSE_RANK FIRST
                                                                 ORDER BY CASE
                                                                              WHEN LORU_DERU_LN.LORU_WS = SUBSTR (COUS_CD_WCTR_CD, 1, 7) THEN 1
                                                                              WHEN LORU_DERU_LN.LORU_ORG = SUBSTR (COUS_CD_WCTR_CD, 1, 3) THEN 2
                                                                              ELSE 9
                                                                          END, LORU_DERU_LN.LORU_ID_ALLOCATION_RULES) AS VHRD_CD_LN_BIN_TP,
                             MAX (LORU_DERU_LN.LORU_CD_REPL_TP) KEEP (DENSE_RANK FIRST
                                                                      ORDER BY CASE
                                                                                   WHEN LORU_DERU_LN.LORU_WS = SUBSTR (COUS_CD_WCTR_CD, 1, 7) THEN 1
                                                                                   WHEN LORU_DERU_LN.LORU_ORG = SUBSTR (COUS_CD_WCTR_CD, 1, 3) THEN 2
                                                                                   ELSE 9
                                                                               END, LORU_DERU_LN.LORU_ID_ALLOCATION_RULES) AS VHRD_CD_LN_REPL_TP,
                                 MAX (LORU_DERU_LN.LORU_QT_REPL_QTY) KEEP (DENSE_RANK FIRST
                                                                           ORDER BY CASE
                                                                                        WHEN LORU_DERU_LN.LORU_WS = SUBSTR (COUS_CD_WCTR_CD, 1, 7) THEN 1
                                                                                        WHEN LORU_DERU_LN.LORU_ORG = SUBSTR (COUS_CD_WCTR_CD, 1, 3) THEN 2
                                                                                        ELSE 9
                                                                                    END, LORU_DERU_LN.LORU_ID_ALLOCATION_RULES) AS VHRD_QT_LN_REPL_QTY,
                                     MAX (LORU_DERU_LN.DERU_QT_DEC_QTY) KEEP (DENSE_RANK FIRST
                                                                              ORDER BY CASE
                                                                                           WHEN LORU_DERU_LN.LORU_WS = SUBSTR (COUS_CD_WCTR_CD, 1, 7) THEN 1
                                                                                           WHEN LORU_DERU_LN.LORU_ORG = SUBSTR (COUS_CD_WCTR_CD, 1, 3) THEN 2
                                                                                           ELSE 9
                                                                                       END, LORU_DERU_LN.LORU_ID_ALLOCATION_RULES) AS VHRD_QT_LN_DEC_QTY,
                                         MAX (LORU_DERU_WH.LORU_CD_PREALLOC_AREA) KEEP (DENSE_RANK FIRST
                                                                                        ORDER BY CASE
                                                                                                     WHEN LORU_DERU_WH.LORU_WS = SUBSTR (COUS_CD_WCTR_CD, 1, 7) THEN 1
                                                                                                     WHEN LORU_DERU_WH.LORU_ORG = SUBSTR (COUS_CD_WCTR_CD, 1, 3) THEN 2
                                                                                                     ELSE 9
                                                                                                 END, LORU_DERU_WH.LORU_ID_ALLOCATION_RULES) AS VHRD_CD_WH_PREALLOC_AREA,
                                             MAX (LORU_DERU_WH.LORU_CD_BIN_TP) KEEP (DENSE_RANK FIRST
                                                                                     ORDER BY CASE
                                                                                                  WHEN LORU_DERU_WH.LORU_WS = SUBSTR (COUS_CD_WCTR_CD, 1, 7) THEN 1
                                                                                                  WHEN LORU_DERU_WH.LORU_ORG = SUBSTR (COUS_CD_WCTR_CD, 1, 3) THEN 2
                                                                                                  ELSE 9
                                                                                              END, LORU_DERU_WH.LORU_ID_ALLOCATION_RULES) AS VHRD_CD_WH_BIN_TP,
                                                 MAX (LORU_DERU_WH.LORU_CD_REPL_TP) KEEP (DENSE_RANK FIRST
                                                                                          ORDER BY CASE
                                                                                                       WHEN LORU_DERU_WH.LORU_WS = SUBSTR (COUS_CD_WCTR_CD, 1, 7) THEN 1
                                                                                                       WHEN LORU_DERU_WH.LORU_ORG = SUBSTR (COUS_CD_WCTR_CD, 1, 3) THEN 2
                                                                                                       ELSE 9
                                                                                                   END, LORU_DERU_WH.LORU_ID_ALLOCATION_RULES) AS VHRD_CD_WH_REPL_TP,
                                                     MAX (LORU_DERU_WH.LORU_QT_REPL_QTY) KEEP (DENSE_RANK FIRST
                                                                                               ORDER BY CASE
                                                                                                            WHEN LORU_DERU_WH.LORU_WS = SUBSTR (COUS_CD_WCTR_CD, 1, 7) THEN 1
                                                                                                            WHEN LORU_DERU_WH.LORU_ORG = SUBSTR (COUS_CD_WCTR_CD, 1, 3) THEN 2
                                                                                                            ELSE 9
                                                                                                        END, LORU_DERU_WH.LORU_ID_ALLOCATION_RULES) AS VHRD_QT_WH_REPL_QTY,
                                                         MAX (LORU_DERU_WH.DERU_QT_DEC_QTY) KEEP (DENSE_RANK FIRST
                                                                                                  ORDER BY CASE
                                                                                                               WHEN LORU_DERU_WH.LORU_WS = SUBSTR (COUS_CD_WCTR_CD, 1, 7) THEN 1
                                                                                                               WHEN LORU_DERU_WH.LORU_ORG = SUBSTR (COUS_CD_WCTR_CD, 1, 3) THEN 2
                                                                                                               ELSE 9
                                                                                                           END, LORU_DERU_WH.LORU_ID_ALLOCATION_RULES) AS VHRD_QT_WH_DEC_QTY,
                                                             MAX (COUS_LD_LIST_PROD_ORG) VHRD_LD_LIST_PROD_ORG,
                                                                 MAX (COUS_LD_LIST_PROD_OP) VHRD_LD_LIST_PROD_OP,
                                                                     MAX (COUS_NT_LIST_PROD_TOOL) VHRD_NT_LIST_PROD_TOOL,
                                                                         SUM (COMP.COUS_QT_COMP_QTY) KEEP (DENSE_RANK FIRST
                                                                                                           ORDER BY LORU_DERU_LN.LORU_ID_ALLOCATION_RULES, LORU_DERU_WH.LORU_ID_ALLOCATION_RULES) VHRD_QT_PART_QTY,
                                                                                                     DECODE (ROW_NUMBER () OVER (PARTITION BY COMP.COUS_CD_PLANT_CD, COMP.COUS_ID_VEHI_FIRST_VAN, COMP.COUS_CD_FIRST_VAN, COMP.COUS_CD_SERIE, COMP.COUS_ID_MTRL_ENG_VAR, COMP.COUS_CD_ENG_VAR, COMP.COUS_ID_TIME_FIXED_KEY_DT, COMP.COUS_ID_MTRL_COMP, COMP.COUS_CD_COMP
                                                                                                                                 ORDER BY COUS_CD_OP, COUS_CD_WCTR_CD) , 1, 1, 0) VHRD_QT_PART_CNT_QTY,
                                                                                                     MAX (CLOSE_ORD.PROR_CD_PROD_ORD) VHRD_CD_LAST_ORD_PROD,
                                                                                                         MAX (CLOSE_ORD.PROR_CD_EFF_ORD) VHRD_CD_LAST_EFF_ORD,
                                                                                                             TO_NUMBER (TO_CHAR (MAX (CLOSE_ORD.PROR_DT_ORD_CONFIRM_DT) , 'J')) VHRD_ID_TIME_LAST_CONFIRM_DT,
                                                                                                             MAX (CLOSE_ORD.PROR_QT_OK_QTY) VHRD_QT_LAST_PROD_QTY,
                                                                                                                 MAX (CLOSE_ORD.PROR_ID_PPST_ORD_STU) VHRD_ID_PRST_LAST_ORD_STU,
                                                                                                                     MAX (CLOSE_ORD.PROR_CD_ORD_STU) VHRD_CD_LAST_ORD_STU,
                                                                                                                         MAX (WIP_ORD.PROR_CD_PROD_ORD) VHRD_CD_WIP_ORD_PROD,
                                                                                                                             MAX (WIP_ORD.PROR_CD_EFF_ORD) VHRD_CD_WIP_EFF_ORD,
                                                                                                                                 MAX (WIP_ORD.PROP_CD_OP) VHRD_CD_WIP_CONFIRM_OP,
                                                                                                                                     TO_NUMBER (TO_CHAR (MAX (WIP_ORD.PROP_DT_CONFIRM_DT) , 'J')) VHRD_ID_TIME_WIP_CONFIRM_DT,
                                                                                                                                     MAX (WIP_ORD.PROP_QT_CONFIRM_QTY) VHRD_QT_WIP_QTY,
                                                                                                                                         MAX (WIP_ORD.PROR_ID_PPST_ORD_STU) VHRD_ID_PRST_WIP_ORD_STU,
                                                                                                                                             MAX (WIP_ORD.PROR_CD_ORD_STU) VHRD_CD_WIP_ORD_STU,
                                                                                                                                                 CASE
                                                                                                                                                     WHEN MAX (OSLN.OSLN_CD_PURCH_ORD_NBR) IS NULL THEN '0'
                                                                                                                                                     ELSE '1'
                                                                                                                                                 END VHRD_FL_CSCN_MARK,
                                                                                                                                                 NVL (MAX (OSLN.OSLN_ID_VEND_SUPPL_CD) , MAX (POLN_SCLN.VEND_ID_VENDORS)) VHRD_ID_VEND_LAST_SUPPL_CD,
                                                                                                                                                 NVL (MAX (OSLN.OSLN_CD_SUPPL_CD) , MAX (POLN_SCLN.POLN_CD_SUPPL_CD)) VHRD_CD_LAST_SUPPL_CD,
                                                                                                                                                 NVL (MAX (OSLN.OSLN_CD_PURCH_ORD_NBR) , MAX (POLN_SCLN.POLN_CD_PURCH_ORD)) VHRD_CD_LAST_PURCH_ORD,
                                                                                                                                                 NVL (MAX (LPAD (OSLN.OSLN_CD_PURCH_ORD_LN, 5, '0')) , MAX (POLN_SCLN.POLN_CD_PURCH_ORD_LN)) VHRD_CD_LAST_PURCH_ORD_LN,
                                                                                                                                                 TO_NUMBER (TO_CHAR (NVL (MAX (SLPR.SLPR_DT_RECEPT_DT) , MAX (SLPR_POLN.SLPR_DT_RECEPT_DT)), 'J')) VHRD_ID_TIME_LAST_RCVD_DT,
                                                                                                                                                 NVL (MAX (SLPR.SLPR_QT_RCVD_QTY) , MAX (SLPR_POLN.SLPR_QT_RCVD_QTY)) VHRD_QT_LAST_RCVD_QT,
                                                                                                                                                 MAX (OSLN_ID_STMD_SITE_INT) VHRD_ID_SITE_SITE_INT,
                                                                                                                                                     MAX (OSLN_CD_SITE_INT) VHRD_CD_SITE_INT,
                                                                                                                                                         TO_NUMBER (TO_CHAR (NVL (MAX (OSLN_DT_PURCH_ORD_DLVR_DT) , MAX (POLN_SCLN.SCLN_DT_REQ_DLVR_DT)), 'J')) VHRD_ID_TIME_PURCH_ORD_DLVR_DT,
                                                                                                                                                         TO_NUMBER (TO_CHAR (MAX (OSLN_DT_PURCH_ORD_SHIPM_DT) , 'J')) VHRD_ID_TIME_PURCH_ORD_SHIP_DT,
                                                                                                                                                         NVL (MAX (OSLN_QT_REQ_QTY) , MAX (POLN_SCLN.SCLN_QT_REQ_QTY)) VHRD_QT_REQ_QTY,
                                                                                                                                                         NVL (MAX (OSLN_QT_CUM_REQ_QTY) , MAX (POLN_SCLN.CUM_REQ_QTY)) VHRD_QT_CUM_REQ_QTY,
                                                                                                                                                         NVL (MAX (OSLN_QT_CUM_REC_QTY) , MAX (POLN_SCLN.POLN_QT_CUM_QTY)) VHRD_QT_CUM_REC_QTY,
                                                                                                                                                         MAX (OSLN_QT_TRANS_QTY) VHRD_QT_TRANS_QTY,
                                                                                                                                                             MAX (OSLN_QT_CUM_PUR_QTY) VHRD_QT_CUM_PUR_QTY,
                                                                                                                                                                 MAX (OSLN_QT_BALANCE_QTY) VHRD_QT_BALANCE_QTY,
                                                                                                                                                                     NVL (MAX (OSLN_CD_LAST_REC_PACKLIST) , MAX (SLPR_POLN.SLPR_CD_SUPPL_DLVR_NT)) VHRD_CD_LAST_REC_PACKLIST,
                                                                                                                                                                     MAX (OSLN_CD_LAST_ASN_PACKLIST) VHRD_CD_LAST_ASN_PACKLIST,
                                                                                                                                                                         MAX (OSLN_CD_LAST_PICKUP_REQID) VHRD_CD_LAST_PICKUP_REQID,
                                                                                                                                                                             TO_NUMBER (TO_CHAR (MAX (EXPR.EXPR_DT_PROM_DT) , 'J')) VHRD_ID_TIME_PROM_DT,
                                                                                                                                                                             MAX (EXPR.EXPR_DT_PROM_DT) VHRD_DT_PROM_DT,
                                                                                                                                                                                 MAX (EXPR.EXPR_QT_PROM_QTY) VHRD_QT_PROM_QTY,
                                                                                                                                                                                     MAX (EXPR.EXPR_DS_PURCH_NOTE) VHRD_DS_PURCH_NOTE,
                                                                                                                                                                                         MAX (EXPR.EXPR_DS_PROD_NOTE) VHRD_DS_PROD_NOTE,
                                                                                                                                                                                             MAX (COMP.COUS_CD_SOURCE_SYSTEM) VHRD_CD_SOURCE_SYSTEM
      FROM
        (SELECT *
         FROM DDWH02_DM_MA.TFCT_COUS_COMP_USG
         WHERE COUS_CD_PLANT_CD = P_ELT_CD_PLANT ) COMP,

        (SELECT COUS_CD_PLANT_CD,
                COUS_CD_SERIE,
                COUS_CD_ENG_VAR,
                COUS_CD_PART_NBR,
                COUS_ID_TIME_FIXED_KEY_DT,
                COUS_LD_LIST_PROD_ORG,
                COUS_LD_LIST_PROD_OP
         FROM DDWH02_DM_MA.TW_VHRD_COUS_PROD
         WHERE COUS_CD_PLANT_CD = P_ELT_CD_PLANT ) PROD,

        (SELECT COUS_CD_PLANT_CD,
                COUS_CD_SERIE,
                COUS_CD_ENG_VAR,
                COUS_CD_PART_NBR,
                COUS_ID_TIME_FIXED_KEY_DT,
                COUS_NT_LIST_PROD_TOOL
         FROM DDWH02_DM_MA.TW_VHRD_COUS_PROD_TOOLS
         WHERE COUS_CD_PLANT_CD = P_ELT_CD_PLANT ) PROD_TOOLS,

        (SELECT PROR_CD_PART_NBR,
                MAX (PROR_CD_PROD_ORD) KEEP (DENSE_RANK FIRST
                                             ORDER BY PROR_DT_ORD_CONFIRM_DT DESC , PROR_ID_PROD_ORD DESC) PROR_CD_PROD_ORD,
                                       MAX (PROR_CD_EFF_ORD) KEEP (DENSE_RANK FIRST
                                                                   ORDER BY PROR_DT_ORD_CONFIRM_DT DESC , PROR_ID_PROD_ORD DESC) PROR_CD_EFF_ORD,
                                                             MAX (PROR_DT_ORD_CONFIRM_DT) KEEP (DENSE_RANK FIRST
                                                                                                ORDER BY PROR_DT_ORD_CONFIRM_DT DESC , PROR_ID_PROD_ORD DESC) PROR_DT_ORD_CONFIRM_DT,
                                                                                          MAX (PROR_QT_OK_QTY) KEEP (DENSE_RANK FIRST
                                                                                                                     ORDER BY PROR_DT_ORD_CONFIRM_DT DESC , PROR_ID_PROD_ORD DESC) PROR_QT_OK_QTY,
                                                                                                               MAX (PROR_ID_PPST_ORD_STU) KEEP (DENSE_RANK FIRST
                                                                                                                                                ORDER BY PROR_DT_ORD_CONFIRM_DT DESC , PROR_ID_PROD_ORD DESC) PROR_ID_PPST_ORD_STU,
                                                                                                                                          MAX (PROR_CD_ORD_STU) KEEP (DENSE_RANK FIRST
                                                                                                                                                                      ORDER BY PROR_DT_ORD_CONFIRM_DT DESC , PROR_ID_PROD_ORD DESC) PROR_CD_ORD_STU
         FROM DDWH01_DW_MA.TT_PROR_PROD_ORD PROR_1
         WHERE PROR_CD_PLANT_CD = P_ELT_CD_PLANT
           AND PROR_FL_CLOSE_MARK = '1'
           AND PROR_FL_LOGICAL_STATUS = '1'
         GROUP BY PROR_CD_PART_NBR) CLOSE_ORD,

        (SELECT PROR_CD_PART_NBR,
                MAX (PROR_CD_PROD_ORD) KEEP (DENSE_RANK FIRST
                                             ORDER BY PROP_CD_OP DESC , PROP_DT_CONFIRM_DT DESC , PROP_ID_PROD_ORD_OP DESC) PROR_CD_PROD_ORD,
                                       MAX (PROR_CD_EFF_ORD) KEEP (DENSE_RANK FIRST
                                                                   ORDER BY PROP_CD_OP DESC , PROP_DT_CONFIRM_DT DESC , PROP_ID_PROD_ORD_OP DESC) PROR_CD_EFF_ORD,
                                                             MAX (PROP_CD_OP) KEEP (DENSE_RANK FIRST
                                                                                    ORDER BY PROP_CD_OP DESC , PROP_DT_CONFIRM_DT DESC , PROP_ID_PROD_ORD_OP DESC) PROP_CD_OP,
                                                                              MAX (PROP_DT_CONFIRM_DT) KEEP (DENSE_RANK FIRST
                                                                                                             ORDER BY PROP_CD_OP DESC , PROP_DT_CONFIRM_DT DESC , PROP_ID_PROD_ORD_OP DESC) PROP_DT_CONFIRM_DT,
                                                                                                       MAX (PROP_QT_CONFIRM_QTY) KEEP (DENSE_RANK FIRST
                                                                                                                                       ORDER BY PROP_CD_OP DESC , PROP_DT_CONFIRM_DT DESC , PROP_ID_PROD_ORD_OP DESC) PROP_QT_CONFIRM_QTY,
                                                                                                                                 MAX (PROR_ID_PPST_ORD_STU) KEEP (DENSE_RANK FIRST
                                                                                                                                                                  ORDER BY PROP_CD_OP DESC , PROP_DT_CONFIRM_DT DESC , PROP_ID_PROD_ORD_OP DESC) PROR_ID_PPST_ORD_STU,
                                                                                                                                                            MAX (PROR_CD_ORD_STU) KEEP (DENSE_RANK FIRST
                                                                                                                                                                                        ORDER BY PROP_CD_OP DESC , PROP_DT_CONFIRM_DT DESC , PROP_ID_PROD_ORD_OP DESC) PROR_CD_ORD_STU
         FROM
           (SELECT PROR_2.*
            FROM DDWH01_DW_MA.TT_PROR_PROD_ORD PROR_2
            WHERE PROR_CD_PLANT_CD = P_ELT_CD_PLANT
              AND PROR_FL_CLOSE_MARK = '0'
              AND PROR_FL_LOGICAL_STATUS = '1' ) ,
           (SELECT PROP.*
            FROM DDWH01_DW_MA.TD_PROP_PROD_ORD_OP PROP
            WHERE PROP_CD_PLANT_CD = P_ELT_CD_PLANT
              AND PROP_FL_LOGICAL_STATUS = '1' )
         WHERE PROR_ID_PROD_ORD = PROP_ID_PROR_PROD_ORD
           AND PROP_QT_CONFIRM_QTY > 0
         GROUP BY PROR_CD_PART_NBR) WIP_ORD,

        (SELECT OSLN_CD_PART_NBR,
                MAX (OSLN_ID_VEND_SUPPL_CD) KEEP (DENSE_RANK FIRST
                                                  ORDER BY OSLN_DT_PURCH_ORD_DLVR_DT ASC , OSLN_ID_OPEN_SCHED_LN ASC) OSLN_ID_VEND_SUPPL_CD,
                                            MAX (OSLN_CD_SUPPL_CD) KEEP (DENSE_RANK FIRST
                                                                         ORDER BY OSLN_DT_PURCH_ORD_DLVR_DT ASC , OSLN_ID_OPEN_SCHED_LN ASC) OSLN_CD_SUPPL_CD,
                                                                   MAX (OSLN_CD_PURCH_ORD) KEEP (DENSE_RANK FIRST
                                                                                                 ORDER BY OSLN_DT_PURCH_ORD_DLVR_DT ASC , OSLN_ID_OPEN_SCHED_LN ASC) OSLN_CD_PURCH_ORD_NBR,
                                                                                           MAX (OSLN_CD_PURCH_ORD_LN) KEEP (DENSE_RANK FIRST
                                                                                                                            ORDER BY OSLN_DT_PURCH_ORD_DLVR_DT ASC , OSLN_ID_OPEN_SCHED_LN ASC) OSLN_CD_PURCH_ORD_LN,
                                                                                                                      MAX (OSLN_ID_STMD_SITE_INT) KEEP (DENSE_RANK FIRST
                                                                                                                                                        ORDER BY OSLN_DT_PURCH_ORD_DLVR_DT ASC , OSLN_ID_OPEN_SCHED_LN ASC) OSLN_ID_STMD_SITE_INT,
                                                                                                                                                  MAX (OSLN_CD_SITE_INT) KEEP (DENSE_RANK FIRST
                                                                                                                                                                               ORDER BY OSLN_DT_PURCH_ORD_DLVR_DT ASC , OSLN_ID_OPEN_SCHED_LN ASC) OSLN_CD_SITE_INT,
                                                                                                                                                                         MAX (OSLN_DT_PURCH_ORD_DLVR_DT) KEEP (DENSE_RANK FIRST
                                                                                                                                                                                                               ORDER BY OSLN_DT_PURCH_ORD_DLVR_DT ASC , OSLN_ID_OPEN_SCHED_LN ASC) OSLN_DT_PURCH_ORD_DLVR_DT,
                                                                                                                                                                                                         MAX (OSLN_DT_PURCH_ORD_SHIPM_DT) KEEP (DENSE_RANK FIRST
                                                                                                                                                                                                                                                ORDER BY OSLN_DT_PURCH_ORD_DLVR_DT ASC , OSLN_ID_OPEN_SCHED_LN ASC) OSLN_DT_PURCH_ORD_SHIPM_DT,
                                                                                                                                                                                                                                          MAX (OSLN_QT_REQ_QTY) KEEP (DENSE_RANK FIRST
                                                                                                                                                                                                                                                                      ORDER BY OSLN_DT_PURCH_ORD_DLVR_DT ASC , OSLN_ID_OPEN_SCHED_LN ASC) OSLN_QT_REQ_QTY,
                                                                                                                                                                                                                                                                MAX (OSLN_QT_CUM_REQ_QTY) KEEP (DENSE_RANK FIRST
                                                                                                                                                                                                                                                                                                ORDER BY OSLN_DT_PURCH_ORD_DLVR_DT ASC , OSLN_ID_OPEN_SCHED_LN ASC) OSLN_QT_CUM_REQ_QTY,
                                                                                                                                                                                                                                                                                          MAX (OSLN_QT_CUM_REC_QTY) KEEP (DENSE_RANK FIRST
                                                                                                                                                                                                                                                                                                                          ORDER BY OSLN_DT_PURCH_ORD_DLVR_DT ASC , OSLN_ID_OPEN_SCHED_LN ASC) OSLN_QT_CUM_REC_QTY,
                                                                                                                                                                                                                                                                                                                    MAX (OSLN_QT_TRANS_QTY) KEEP (DENSE_RANK FIRST
                                                                                                                                                                                                                                                                                                                                                  ORDER BY OSLN_DT_PURCH_ORD_DLVR_DT ASC , OSLN_ID_OPEN_SCHED_LN ASC) OSLN_QT_TRANS_QTY,
                                                                                                                                                                                                                                                                                                                                            MAX (OSLN_QT_CUM_PUR_QTY) KEEP (DENSE_RANK FIRST
                                                                                                                                                                                                                                                                                                                                                                            ORDER BY OSLN_DT_PURCH_ORD_DLVR_DT ASC , OSLN_ID_OPEN_SCHED_LN ASC) OSLN_QT_CUM_PUR_QTY,
                                                                                                                                                                                                                                                                                                                                                                      MAX (OSLN_QT_BALANCE_QTY) KEEP (DENSE_RANK FIRST
                                                                                                                                                                                                                                                                                                                                                                                                      ORDER BY OSLN_DT_PURCH_ORD_DLVR_DT ASC , OSLN_ID_OPEN_SCHED_LN ASC) OSLN_QT_BALANCE_QTY,
                                                                                                                                                                                                                                                                                                                                                                                                MAX (OSLN_CD_LAST_REC_PACKLIST) KEEP (DENSE_RANK FIRST
                                                                                                                                                                                                                                                                                                                                                                                                                                      ORDER BY OSLN_DT_PURCH_ORD_DLVR_DT ASC , OSLN_ID_OPEN_SCHED_LN ASC) OSLN_CD_LAST_REC_PACKLIST,
                                                                                                                                                                                                                                                                                                                                                                                                                                MAX (OSLN_CD_LAST_ASN_PACKLIST) KEEP (DENSE_RANK FIRST
                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ORDER BY OSLN_DT_PURCH_ORD_DLVR_DT ASC , OSLN_ID_OPEN_SCHED_LN ASC) OSLN_CD_LAST_ASN_PACKLIST,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                MAX (OSLN_CD_LAST_PICKUP_REQID) KEEP (DENSE_RANK FIRST
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ORDER BY OSLN_DT_PURCH_ORD_DLVR_DT ASC , OSLN_ID_OPEN_SCHED_LN ASC) OSLN_CD_LAST_PICKUP_REQID
         FROM
           (SELECT *
            FROM DDWH01_DW_MA.TT_OSLN_OPEN_SCHED_LN
            WHERE OSLN_CD_PLANT_CD = P_ELT_CD_PLANT )
         GROUP BY OSLN_CD_PART_NBR) OSLN,

        (SELECT POLN_CD_PART_NBR,
                MIN (POLN_CD_PURCH_ORD) KEEP (DENSE_RANK FIRST
                                              ORDER BY POLN_DT_REQ_DLVR_DT, SCLN_DT_REQ_DLVR_DT) AS POLN_CD_PURCH_ORD,
                    MIN (POLN_CD_PURCH_ORD_LN) KEEP (DENSE_RANK FIRST
                                                     ORDER BY POLN_DT_REQ_DLVR_DT, SCLN_DT_REQ_DLVR_DT) AS POLN_CD_PURCH_ORD_LN,
                        MIN (VEND_ID_VENDORS) KEEP (DENSE_RANK FIRST
                                                    ORDER BY POLN_DT_REQ_DLVR_DT, SCLN_DT_REQ_DLVR_DT) AS VEND_ID_VENDORS,
                            MIN (POLN_CD_SUPPL_CD) KEEP (DENSE_RANK FIRST
                                                         ORDER BY POLN_DT_REQ_DLVR_DT, SCLN_DT_REQ_DLVR_DT) AS POLN_CD_SUPPL_CD,
                                MIN (SCLN_DT_REQ_DLVR_DT) KEEP (DENSE_RANK FIRST
                                                                ORDER BY POLN_DT_REQ_DLVR_DT, SCLN_DT_REQ_DLVR_DT) AS SCLN_DT_REQ_DLVR_DT,
                                    MIN (SCLN_QT_REQ_QTY) KEEP (DENSE_RANK FIRST
                                                                ORDER BY POLN_DT_REQ_DLVR_DT, SCLN_DT_REQ_DLVR_DT) AS SCLN_QT_REQ_QTY,
                                        SUM (CASE
                                                 WHEN SCLN_DT_REQ_DLVR_DT<TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') THEN SCLN_QT_REQ_QTY
                                                 ELSE 0
                                             END) CUM_REQ_QTY,
                                            MIN (POLN_QT_CUM_QTY) KEEP (DENSE_RANK FIRST
                                                                        ORDER BY POLN_DT_REQ_DLVR_DT, SCLN_DT_REQ_DLVR_DT) AS POLN_QT_CUM_QTY
         FROM
           (SELECT *
            FROM DDWH01_DW_MA.TD_POLN_PURCH_ORD_LN
            WHERE POLN_CD_PLANT_CD = P_ELT_CD_PLANT
              AND POLN_FL_LOGICAL_STATUS = '1'
              AND POLN_FL_CLOSE_MARK='0' ) ,
           (SELECT *
            FROM DDWH01_DW_MA.TD_SCLN_SCHED_LN
            WHERE SCLN_CD_PLANT_CD = P_ELT_CD_PLANT
              AND SCLN_FL_LOGICAL_STATUS = '1'
              AND SCLN_FL_CLOSE_MARK='0'
              AND SCLN_QT_REQ_QTY > 0 ) ,
           (SELECT *
            FROM DDWH01_DW_MA.TM_VEND_VENDORS
            WHERE VEND_CD_PLANT_CD = P_ELT_CD_PLANT )
         WHERE POLN_ID_PURCH_ORD_LN=SCLN_ID_POLN_PURCH_ORD (+)
           AND POLN_CD_SUPPL_CD=VEND_CD_VENDOR_CD (+)
         GROUP BY POLN_CD_PART_NBR) POLN_SCLN,

        (SELECT SLPR_CD_PURCH_ORD,
                SLPR_CD_PURCH_ORD_LN,
                SLPR_DT_RECEPT_DT,
                SLPR_QT_RCVD_QTY
         FROM DDWH02_DM_MA.TW_VHRD_SLPR
         WHERE SLPR_CD_PLANT_CD = P_ELT_CD_PLANT ) SLPR,

        (SELECT SLPR_CD_PURCH_ORD,
                SLPR_CD_PURCH_ORD_LN,
                SLPR_DT_RECEPT_DT,
                SLPR_QT_RCVD_QTY,
                SLPR_CD_SUPPL_DLVR_NT
         FROM DDWH02_DM_MA.TW_VHRD_SLPR
         WHERE SLPR_CD_PLANT_CD = P_ELT_CD_PLANT ) SLPR_POLN,

        (SELECT EXPR_DT_PROM_DT,
                EXPR_QT_PROM_QTY,
                EXPR_DS_PURCH_NOTE,
                EXPR_DS_PROD_NOTE,
                EXPR_CD_SUPPL_CD,
                EXPR_CD_PART_NBR
         FROM DDWH01_DW_MA.TT_EXPR_EXP_PROM_RCPT
         WHERE EXPR_CD_PLANT_CD = P_ELT_CD_PLANT
           AND EXPR_FL_LOGICAL_STATUS = '1' ) EXPR,

        (SELECT LORU_CD_PART_NBR,
                SUBSTR
           (REPLACE (LORU_CD_PREALLOC_AREA, '-', '') , 1, 7) LORU_WS,
                SUBSTR
           (REPLACE (LORU_CD_PREALLOC_AREA, '-', '') , 1, 3) LORU_ORG,
                MAX (LORU_CD_PREALLOC_AREA) KEEP (DENSE_RANK FIRST
                                                  ORDER BY LORU_ID_ALLOCATION_RULES) LORU_CD_PREALLOC_AREA,
                                            MAX (LORU_CD_BIN_TP) KEEP (DENSE_RANK FIRST
                                                                       ORDER BY LORU_ID_ALLOCATION_RULES) LORU_CD_BIN_TP,
                                                                 MAX (LORU_CD_REPL_TP) KEEP (DENSE_RANK FIRST
                                                                                             ORDER BY LORU_ID_ALLOCATION_RULES) LORU_CD_REPL_TP,
                                                                                       MAX (LORU_QT_REPL_QTY) KEEP (DENSE_RANK FIRST
                                                                                                                    ORDER BY LORU_ID_ALLOCATION_RULES) LORU_QT_REPL_QTY,
                                                                                                              MAX (DERU_QT_DEC_QTY) KEEP (DENSE_RANK FIRST
                                                                                                                                          ORDER BY LORU_ID_ALLOCATION_RULES) DERU_QT_DEC_QTY,
                                                                                                                                    MIN (LORU_ID_ALLOCATION_RULES) LORU_ID_ALLOCATION_RULES
         FROM DDWH01_DW_MA.TM_LORU_ALLOCATION_RULES LORU_1,
              DDWH01_DW_MA.TM_DERU_DECANTING_RULES
         WHERE LORU_CD_PLANT_CD=P_ELT_CD_PLANT
           AND LORU_FL_LOGICAL_STATUS='1'
           AND DERU_CD_PLANT_CD (+) =P_ELT_CD_PLANT
           AND DERU_FL_LOGICAL_STATUS (+) ='1'
           AND LORU_CD_LOC_TP='LIN'
           AND DERU_CD_PART_NBR (+) =LORU_CD_PART_NBR
           AND DERU_CD_BIN_TP (+) =LORU_CD_BIN_TP
         GROUP BY LORU_CD_PART_NBR,
                  SUBSTR
           (REPLACE (LORU_CD_PREALLOC_AREA, '-', '') , 1, 7),
                  SUBSTR
           (REPLACE (LORU_CD_PREALLOC_AREA, '-', '') , 1, 3)) LORU_DERU_LN,

        (SELECT LORU_CD_PART_NBR,
                SUBSTR
           (REPLACE (LORU_CD_PREALLOC_AREA, '-', '') , 1, 7) LORU_WS,
                SUBSTR
           (REPLACE (LORU_CD_PREALLOC_AREA, '-', '') , 1, 3) LORU_ORG,
                MAX (LORU_CD_PREALLOC_AREA) KEEP (DENSE_RANK FIRST
                                                  ORDER BY LORU_ID_ALLOCATION_RULES) LORU_CD_PREALLOC_AREA,
                                            MAX (LORU_CD_BIN_TP) KEEP (DENSE_RANK FIRST
                                                                       ORDER BY LORU_ID_ALLOCATION_RULES) LORU_CD_BIN_TP,
                                                                 MAX (LORU_CD_REPL_TP) KEEP (DENSE_RANK FIRST
                                                                                             ORDER BY LORU_ID_ALLOCATION_RULES) LORU_CD_REPL_TP,
                                                                                       MAX (LORU_QT_REPL_QTY) KEEP (DENSE_RANK FIRST
                                                                                                                    ORDER BY LORU_ID_ALLOCATION_RULES) LORU_QT_REPL_QTY,
                                                                                                              MAX (DERU_QT_DEC_QTY) KEEP (DENSE_RANK FIRST
                                                                                                                                          ORDER BY LORU_ID_ALLOCATION_RULES) DERU_QT_DEC_QTY,
                                                                                                                                    MIN (LORU_ID_ALLOCATION_RULES) LORU_ID_ALLOCATION_RULES
         FROM DDWH01_DW_MA.TM_LORU_ALLOCATION_RULES LORU_2,
              DDWH01_DW_MA.TM_DERU_DECANTING_RULES
         WHERE LORU_CD_PLANT_CD=P_ELT_CD_PLANT
           AND LORU_FL_LOGICAL_STATUS='1'
           AND DERU_CD_PLANT_CD (+) =P_ELT_CD_PLANT
           AND DERU_FL_LOGICAL_STATUS (+) ='1'
           AND LORU_CD_LOC_TP='STC'
           AND DERU_CD_PART_NBR (+) =LORU_CD_PART_NBR
           AND DERU_CD_BIN_TP (+) =LORU_CD_BIN_TP
         GROUP BY LORU_CD_PART_NBR,
                  SUBSTR
           (REPLACE (LORU_CD_PREALLOC_AREA, '-', '') , 1, 7),
                  SUBSTR
           (REPLACE (LORU_CD_PREALLOC_AREA, '-', '') , 1, 3)) LORU_DERU_WH
      WHERE (COMP.COUS_ID_TIME_FIXED_KEY_DT > 0
             AND TO_DATE (COMP.COUS_ID_TIME_FIXED_KEY_DT, 'J') > TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD')
             OR COMP.COUS_CD_SERIE IN
               (SELECT DISTINCT VEHI_CD_MRP_SERIE
                FROM DDWH02_DM_MA.TDIM_VEHI_VEHICLE
                WHERE VEHI_CD_PLANT_CD = P_ELT_CD_PLANT
                  AND (VEHI_DT_PLND_INLINE_DT > TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD')
                       OR VEHI_DT_INLINE_DT > TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD')) ))
        AND COMP.COUS_FL_COMP_CAT = 'L'
        AND COMP.COUS_CD_PLANT_CD = PROD.COUS_CD_PLANT_CD (+)
        AND COMP.COUS_CD_SERIE = PROD.COUS_CD_SERIE (+)
        AND COMP.COUS_CD_ENG_VAR = PROD.COUS_CD_ENG_VAR (+)
        AND COMP.COUS_CD_COMP = PROD.COUS_CD_PART_NBR (+)
        AND COMP.COUS_ID_TIME_FIXED_KEY_DT = PROD.COUS_ID_TIME_FIXED_KEY_DT (+)
        AND COMP.COUS_CD_PLANT_CD = PROD_TOOLS.COUS_CD_PLANT_CD (+)
        AND COMP.COUS_CD_SERIE = PROD_TOOLS.COUS_CD_SERIE (+)
        AND COMP.COUS_CD_ENG_VAR = PROD_TOOLS.COUS_CD_ENG_VAR (+)
        AND COMP.COUS_CD_COMP = PROD_TOOLS.COUS_CD_PART_NBR (+)
        AND COMP.COUS_ID_TIME_FIXED_KEY_DT = PROD_TOOLS.COUS_ID_TIME_FIXED_KEY_DT (+)
        AND COMP.COUS_CD_COMP = CLOSE_ORD.PROR_CD_PART_NBR (+)
        AND COMP.COUS_CD_COMP = WIP_ORD.PROR_CD_PART_NBR (+)
        AND COMP.COUS_CD_COMP = OSLN.OSLN_CD_PART_NBR (+)
        AND OSLN.OSLN_CD_PURCH_ORD_NBR = SLPR.SLPR_CD_PURCH_ORD (+)
        AND LPAD (OSLN.OSLN_CD_PURCH_ORD_LN, 5, '0') = SLPR.SLPR_CD_PURCH_ORD_LN (+)
        AND COMP.COUS_CD_COMP = POLN_SCLN.POLN_CD_PART_NBR (+)
        AND POLN_SCLN.POLN_CD_PURCH_ORD = SLPR_POLN.SLPR_CD_PURCH_ORD (+)
        AND POLN_SCLN.POLN_CD_PURCH_ORD_LN = SLPR_POLN.SLPR_CD_PURCH_ORD_LN (+)
        AND OSLN.OSLN_CD_SUPPL_CD = EXPR.EXPR_CD_SUPPL_CD (+)
        AND OSLN.OSLN_CD_PART_NBR = EXPR.EXPR_CD_PART_NBR (+)
        AND COMP.COUS_CD_COMP = LORU_DERU_LN.LORU_CD_PART_NBR (+)
        AND COMP.COUS_CD_COMP = LORU_DERU_WH.LORU_CD_PART_NBR (+)
      GROUP BY COMP.COUS_CD_PLANT_CD,
               COMP.COUS_ID_VEHI_FIRST_VAN,
               COMP.COUS_CD_FIRST_VAN,
               COMP.COUS_CD_SERIE,
               COMP.COUS_ID_MTRL_ENG_VAR,
               COMP.COUS_CD_STU,
               COMP.COUS_CD_ENG_VAR,
               COMP.COUS_ID_MTRL_COMP,
               COMP.COUS_CD_COMP,
               COMP.COUS_ID_TIME_FIXED_KEY_DT,
               COMP.COUS_ID_PLST_WCTR_CD,
               COMP.COUS_CD_WCTR_CD,
               COMP.COUS_CD_OP)) ,
  (SELECT *
   FROM DDWH01_DW_MA.TM_ISIR_ISIR_MASTER
   WHERE ISIR_CD_PLANT_CD = P_ELT_CD_PLANT ) MAKE,

  (SELECT *
   FROM DDWH01_DW_MA.TM_ISIR_ISIR_MASTER
   WHERE ISIR_CD_PLANT_CD = P_ELT_CD_PLANT ) BUY ,
  (SELECT DDWH02_DM_MA.FUNC_NOT_APPLICABLE_CODE FNAC
   FROM DUAL)
WHERE MAKE_ISIR = MAKE.ROWID (+)
  AND BUY_ISIR = BUY.ROWID (+)