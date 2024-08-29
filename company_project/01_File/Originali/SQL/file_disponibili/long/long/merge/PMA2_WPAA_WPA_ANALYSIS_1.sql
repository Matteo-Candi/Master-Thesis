MERGE INTO DDWH02_DM_MA.TFCT_WPAA_WPA_ANALYSIS TRG USING
  (SELECT PROP_CD_PLANT_CD,
          NULL WPAA_ID_WPAA,
               PROR_ID_MAMD_PART_NBR,
               PROR_CD_PART_NBR,
               NVL (PLRM.PLRM_ID_MAX_MAMD_ACT_COMP, -2) AS WPAA_ID_MTRL_RAW_MATERIAL,
               PLRM.PLRM_CD_MAX_ACT_COMP,
               PROP_ID_PLMD_WCTR_CD,
               PROP_CD_WCTR_CD,
               NVL (TO_NUMBER (TO_CHAR (PDCC.PDCC_DT_CONFIRM_DT, 'J')), -2) AS WPAA_ID_CONFIRM_DT,
               NVL (TO_NUMBER (TO_CHAR (PROP_DT_SCHED_END_OP_DT, 'J')), -2) AS WPAA_ID_SCHED_END_OP_DT,
               PROP_CD_PROD_ORD,
               PROP_CD_OP,
               PROP_CD_CTRL_KEY,
               PROP_CD_EFF_ORD,
               INFERRED_CLOSE_MARK,
               PROP_QT_BASE_QTY,
               PDCC.QTY AS WPAA_QT_CONFIRM_QTY,
               PDCC.CUM_QTY AS WPAA_QT_CUM_CONFIRM_QTY,
               CASE
                   WHEN INFERRED_CLOSE_MARK = 0
                        AND NVL (PROP_QT_CONFIRM_QTY, 0) < NVL (PROP_QT_BASE_QTY, 0)
                        AND PROP_DT_SCHED_END_OP_DT <= TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD')
                        AND
                          (SELECT COUNT (*)
                           FROM DDWH01_DW_MA.TD_PROP_PROD_ORD_OP PROP_SUB
                           WHERE 1=1
                             AND PROP_SUB.PROP_CD_PLANT_CD = P_ELT_CD_PLANT
                             AND PROP_SUB.PROP_CD_PROD_ORD = TD_PROP_PROD_ORD_OP.PROP_CD_PROD_ORD
                             AND PROP_SUB.PROP_CD_PLANT_CD = TD_PROP_PROD_ORD_OP.PROP_CD_PLANT_CD
                             AND PROP_SUB.PROP_FL_CLOSE_MARK = 0
                             AND PROP_SUB.PROP_FL_LOGICAL_STATUS = '1'
                             AND PROP_SUB.PROP_CD_CTRL_KEY = 'YPP2'
                             AND NVL (PROP_QT_CONFIRM_QTY, 0) < NVL (PROP_QT_BASE_QTY, 0)
                             AND PROP_DT_SCHED_END_OP_DT <= TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD')
                             AND PROP_SUB.PROP_CD_OP < TD_PROP_PROD_ORD_OP.PROP_CD_OP ) <> 0 THEN 'SE'
                   WHEN INFERRED_CLOSE_MARK = 0
                        AND NVL (PROP_QT_CONFIRM_QTY, 0) < NVL (PROP_QT_BASE_QTY, 0)
                        AND PROP_DT_SCHED_END_OP_DT <= TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD')
                        AND
                          (SELECT COUNT (*)
                           FROM DDWH01_DW_MA.TD_PROP_PROD_ORD_OP PROP_SUB
                           WHERE 1=1
                             AND PROP_SUB.PROP_CD_PLANT_CD = P_ELT_CD_PLANT
                             AND PROP_SUB.PROP_CD_PROD_ORD = TD_PROP_PROD_ORD_OP.PROP_CD_PROD_ORD
                             AND PROP_SUB.PROP_CD_PLANT_CD = TD_PROP_PROD_ORD_OP.PROP_CD_PLANT_CD
                             AND PROP_SUB.PROP_FL_CLOSE_MARK = 0
                             AND PROP_SUB.PROP_FL_LOGICAL_STATUS = '1'
                             AND PROP_SUB.PROP_CD_CTRL_KEY = 'YPP2'
                             AND NVL (PROP_QT_CONFIRM_QTY, 0) < NVL (PROP_QT_BASE_QTY, 0)
                             AND PROP_DT_SCHED_END_OP_DT <= TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD')
                             AND PROP_SUB.PROP_CD_OP < TD_PROP_PROD_ORD_OP.PROP_CD_OP ) = 0 THEN 'PR'
               END AS WPAA_CD_OP_MARKER,
               NVL (PROP_QT_BASE_QTY, 0) - NVL (PDCC.CUM_QTY, 0) AS WPAA_QT_REM_QTY,
               NVL (PLPP_CD_MAX_PROC_LOT, POPL_CD_PROC_LOT) AS PLPP_CD_PROC_LOT,
               NVL (NVL (TD_OPPO_OP_PRIORITY_PROD_ORD.PRIO_ID_PRIOR, TT_PRPO_PRIORITY_PROD_ORD.PRIO_ID_PRIOR), -2) AS WPAA_ID_PRIO_PRIORITY,
               NVL (TD_OPPO_OP_PRIORITY_PROD_ORD.PRIO_CD_PRIORITY, TT_PRPO_PRIORITY_PROD_ORD.PRIO_CD_PRIORITY) AS WPAA_CD_OP_PRIORITY,
               CASE
                   WHEN (NVL (PLPP_CD_MAX_PROC_LOT, POPL_CD_PROC_LOT) IS NOT NULL
                         AND PROP_MAX_FL_TOOL_PROG_MARK = '1') THEN 'FN'
                   WHEN (NVL (PLPP_CD_MAX_PROC_LOT, POPL_CD_PROC_LOT) IS NOT NULL
                         AND PROP_MAX_FL_TOOL_PROG_MARK = '0') THEN 'VN'
                   ELSE NULL
               END AS WPAA_CD_NESTING_TP,
               PROP_QT_WORKST_TIME,
               PROP_QT_LABOR_VAL,
               (PROP_QT_WORKST_TIME + PROP_QT_LABOR_VAL) AS WPAA_QT_RUN_TIME,
               CASE
                   WHEN PDCC.QTY IS NULL
                        AND PDCC.CUM_QTY IS NULL THEN PROP_QT_STD_SET_TIME_PER_OP
                   WHEN PDCC.QTY = PDCC.CUM_QTY THEN PROP_QT_STD_SET_TIME_PER_OP
                   ELSE 0
               END AS WPAA_QT_STD_SET_TIME_PER_OP,
               PROP_QT_WORKST_TIME * (NVL (PROP_QT_BASE_QTY, 0) - NVL (PDCC.CUM_QTY, 0)) AS WPAA_QT_REM_MACH_TIME,
               PROP_QT_LABOR_VAL * (NVL (PROP_QT_BASE_QTY, 0) - NVL (PDCC.CUM_QTY, 0)) AS WPAA_QT_REM_MAN_TIME,
               (PROP_QT_WORKST_TIME + PROP_QT_LABOR_VAL) * (NVL (PROP_QT_BASE_QTY, 0) - NVL (PDCC.CUM_QTY, 0)) AS WPAA_QT_REM_RUN_TIME,
               PDCC.WPAA_QT_WORKED AS WPAA_QT_WORKED,
               PROP_QT_WORKST_TIME * PDCC.WPAA_QT_WORKED AS WPAA_QT_MACH_TIME_WORKED,
               PROP_QT_LABOR_VAL * PDCC.WPAA_QT_WORKED AS WPAA_QT_MAN_TIME_WORKED,
               (PROP_QT_WORKST_TIME + PROP_QT_LABOR_VAL) * PDCC.WPAA_QT_WORKED AS WPAA_QT_HOURS_WORKED,
               CASE
                   WHEN COALESCE (OPPO_NR_OP_PRIORITY,
                                  PRPO_NR_ORD_PRIORITY,
                                  0) <=2 THEN 0
                   ELSE (PROP_QT_WORKST_TIME + PROP_QT_LABOR_VAL) * PDCC.WPAA_QT_WORKED
               END AS WPAA_QT_HOURS_CORRECT,
               TO_NUMBER (TO_CHAR (PROR_DT_SCHED_END_PROD_DT, 'J')) AS WPAA_ID_TIME_SCHED_END_PROD_DT,
               NVL (P_ELT_ID_BATCH, N_ELT_ID_JOB_LOG) AS WPAA_ID_BATCH_ID,
               PROP_CD_SOURCE_SYSTEM AS WPAA_CD_SOURCE_SYSTEM
   FROM
     (SELECT *
      FROM DDWH02_DM_MA.TW_WPAK_WPA_ANALYSIS_KEY
      WHERE WPAK_CD_PLANT_CD = P_ELT_CD_PLANT ) TW_WPAK_WPA_ANALYSIS_KEY,

     (SELECT NVL (MAX (MTRL_FL_TOOL_PROG_MARK) , 0) PROP_MAX_FL_TOOL_PROG_MARK,
             PROP_CD_PLANT_CD,
             PROP_ID_PROR_PROD_ORD,
             PROP_CD_PROD_ORD,
             PROP_CD_OP,
             PROP_CD_CTRL_KEY,
             PROP_ID_PLMD_WCTR_CD,
             PROP_CD_WCTR_CD,
             PROP_DT_SCHED_STR_OP_DT,
             PROP_DT_SCHED_END_OP_DT,
             PROP_QT_STD_SET_TIME_PER_OP,
             PROP_QT_BASE_QTY,
             PROP_QT_CONFIRM_QTY,
             PROP_QT_LABOR_VAL,
             PROP_QT_SCRAP_QTY,
             PROP_QT_WORKST_TIME,
             PROP_CD_EFF_ORD,
             PROP_FL_CLOSE_MARK,
             CASE
                 WHEN PROR_FL_CLOSE_MARK = '1' THEN '1'
                 ELSE PROP_FL_CLOSE_MARK
             END AS INFERRED_CLOSE_MARK,
             PROP_CD_SOURCE_SYSTEM
      FROM
        (SELECT *
         FROM DDWH01_DW_MA.TD_PROP_PROD_ORD_OP,
              DDWH01_DW_MA.TT_PROR_PROD_ORD
         WHERE PROP_CD_PLANT_CD = P_ELT_CD_PLANT
           AND PROP_FL_LOGICAL_STATUS = '1'
           AND PROR_CD_PLANT_CD = P_ELT_CD_PLANT
           AND PROR_FL_LOGICAL_STATUS = '1'
           AND PROP_ID_PROR_PROD_ORD = PROR_ID_PROD_ORD ) PROP ,
        (SELECT *
         FROM DDWH01_DW_MA.TD_PRCO_PROD_ORD_COMP
         WHERE PRCO_CD_PLANT_CD = P_ELT_CD_PLANT
           AND PRCO_FL_COMP_CAT ='M'
           AND PRCO_FL_LOGICAL_STATUS = '1' ) ,
        (SELECT *
         FROM DDWH02_DM_MA.TDIM_MTRL_MATERIAL,
              DDWH01_DW_MA.TM_PLNT_PLANT
         WHERE MTRL_CD_PLANT_CD = P_ELT_CD_PLANT
           AND MTRL_CD_PLANT_CD= PLNT_CD_PLANT_CD
           AND MTRL_CD_LANGUAGE = PLNT_CD_LANG_M )
      WHERE 1=1
        AND PROP_ID_PROD_ORD_OP = PRCO_ID_PROP_PROD_ORD_OP (+)
        AND PRCO_ID_MAMD_COMP = MTRL_ID_MTRL_MATERIAL (+)
      GROUP BY PROP_CD_PLANT_CD,
               PROP_ID_PROR_PROD_ORD,
               PROP_CD_PROD_ORD,
               PROP_CD_OP,
               PROP_CD_CTRL_KEY,
               PROP_ID_PLMD_WCTR_CD,
               PROP_CD_WCTR_CD,
               PROP_DT_SCHED_STR_OP_DT,
               PROP_DT_SCHED_END_OP_DT,
               PROP_QT_STD_SET_TIME_PER_OP,
               PROP_QT_BASE_QTY,
               PROP_QT_CONFIRM_QTY,
               PROP_QT_LABOR_VAL,
               PROP_QT_SCRAP_QTY,
               PROP_QT_WORKST_TIME,
               PROP_CD_EFF_ORD,
               PROP_FL_CLOSE_MARK,
               PROR_FL_CLOSE_MARK,
               PROP_CD_SOURCE_SYSTEM) TD_PROP_PROD_ORD_OP,

     (SELECT *
      FROM DDWH01_DW_MA.TT_PROR_PROD_ORD
      WHERE PROR_CD_PLANT_CD = P_ELT_CD_PLANT
        AND PROR_FL_LOGICAL_STATUS = '1' ) TT_PROR_PROD_ORD,

     (SELECT PLPP_CD_EFF_ORD,
             PLPP_CD_OP,
             MAX (PLPP_CD_MAX_PROC_LOT) AS PLPP_CD_MAX_PROC_LOT
      FROM
        (SELECT MIN (PLPP_CD_PROC_LOT) KEEP (DENSE_RANK FIRST
                                             ORDER BY PLPP_QT_QTY_OK DESC) OVER (PARTITION BY PLPP_CD_EFF_ORD,
                                                                                              PLPP_CD_OP) AS PLPP_CD_MAX_PROC_LOT,
                                                                                PLPP_CD_EFF_ORD,
                                                                                PLPP_CD_OP
         FROM
           (SELECT *
            FROM DDWH01_DW_MA.TD_PLPP_PROC_LOT_PART_PROD
            WHERE PLPP_CD_PLANT_CD = P_ELT_CD_PLANT
              AND PLPP_FL_LOGICAL_STATUS = '1' ))
      GROUP BY PLPP_CD_EFF_ORD,
               PLPP_CD_OP) PLPP_MAX,

     (SELECT *
      FROM DDWH01_DW_MA.TD_OPPO_OP_PRIORITY_PROD_ORD,
           DDWH02_DM_MA.TDIM_PRIO_PRIORITY
      WHERE 1=1
        AND OPPO_CD_PLANT_CD = PRIO_CD_PLANT_CD (+)
        AND TO_CHAR (OPPO_NR_OP_PRIORITY) = PRIO_CD_PRIORITY (+)
        AND OPPO_CD_PLANT_CD = P_ELT_CD_PLANT ) TD_OPPO_OP_PRIORITY_PROD_ORD,

     (SELECT PRPO.*,
             PRIO.*
      FROM DDWH01_DW_MA.TT_PRPO_PRIORITY_PROD_ORD PRPO,
           DDWH02_DM_MA.TDIM_PRIO_PRIORITY PRIO ,
        (SELECT *
         FROM DDWH01_DW_MA.TT_PROR_PROD_ORD
         WHERE PROR_CD_PLANT_CD=P_ELT_CD_PLANT
           AND PROR_CD_ORD_TP <> 'Y901' )
      WHERE 1=1
        AND PRPO_CD_PLANT_CD = PRIO_CD_PLANT_CD (+)
        AND TO_CHAR (PRPO_NR_ORD_PRIORITY) = PRIO_CD_PRIORITY (+)
        AND PRPO_CD_PLANT_CD = P_ELT_CD_PLANT
        AND PROR_ID_PROD_ORD= PRPO_ID_PROR_CD_EFF_ORD ) TT_PRPO_PRIORITY_PROD_ORD,

     (SELECT PLRM_CD_EFF_ORD,
             PLRM_CD_OP,
             PLRM_CD_PROC_LOT,
             MAX (PLRM_ID_MAX_MAMD_ACT_COMP) PLRM_ID_MAX_MAMD_ACT_COMP,
                 MAX (PLRM_CD_MAX_ACT_COMP) PLRM_CD_MAX_ACT_COMP
      FROM
        (SELECT MIN (PLRM_ID_MAMD_ACT_COMP) KEEP (DENSE_RANK FIRST
                                                  ORDER BY PLRM_QT_ACT_USAGE_QTY DESC) OVER (PARTITION BY PLRM_CD_EFF_ORD,
                                                                                                          PLRM_CD_OP,
                                                                                                          PLRM_CD_PROC_LOT) AS PLRM_ID_MAX_MAMD_ACT_COMP,
                                                                                            MIN (PLRM_CD_ACT_COMP) KEEP (DENSE_RANK FIRST
                                                                                                                         ORDER BY PLRM_QT_ACT_USAGE_QTY DESC) OVER (PARTITION BY PLRM_CD_EFF_ORD,
                                                                                                                                                                                 PLRM_CD_OP,
                                                                                                                                                                                 PLRM_CD_PROC_LOT) AS PLRM_CD_MAX_ACT_COMP,
                                                                                                                                                                   PLRM_CD_EFF_ORD,
                                                                                                                                                                   PLRM_CD_OP,
                                                                                                                                                                   PLRM_CD_PROC_LOT
         FROM
           (SELECT *
            FROM DDWH01_DW_MA.TD_PLRM_PROC_LOT_RAW_MAT
            WHERE PLRM_CD_PLANT_CD = P_ELT_CD_PLANT
              AND PLRM_FL_LOGICAL_STATUS = '1' ))
      GROUP BY PLRM_CD_EFF_ORD,
               PLRM_CD_OP,
               PLRM_CD_PROC_LOT) PLRM,

     (SELECT POPL_CD_PROD_ORD,
             MIN (POPL_CD_PROC_LOT) AS POPL_CD_PROC_LOT
      FROM DDWH01_DW_MA.TD_POPL_PROD_ORD_PROC_LOT
      WHERE POPL_FL_LOGICAL_STATUS = '1'
      GROUP BY POPL_CD_PROD_ORD) POPL,

     (SELECT *
      FROM
        (SELECT PDCC_CD_PROD_ORD,
                PDCC_CD_OP,
                PDCC_DT_CONFIRM_DT,
                PDCC_ID_PROP_PROD_ORD_OP,
                SUM (PDCC_QT_CONFIRM_QTY) OVER (PARTITION BY PDCC_CD_PROD_ORD,
                                                             PDCC_CD_OP,
                                                             PDCC_DT_CONFIRM_DT) QTY,
                                               SUM (PDCC_QT_CONFIRM_QTY + PDCC_QT_SCRAP_QTY) OVER (PARTITION BY PDCC_CD_PROD_ORD,
                                                                                                                PDCC_CD_OP,
                                                                                                                PDCC_DT_CONFIRM_DT) WPAA_QT_WORKED,
                                                                                                  SUM (PDCC_QT_CONFIRM_QTY) OVER (PARTITION BY PDCC_CD_PROD_ORD,
                                                                                                                                               PDCC_CD_OP
                                                                                                                                  ORDER BY PDCC_NR_CONFIRM_COUNTER) CUM_QTY,
                                                                                                                                 ROW_NUMBER () OVER (PARTITION BY PDCC_CD_PROD_ORD,
                                                                                                                                                                  PDCC_CD_OP,
                                                                                                                                                                  PDCC_DT_CONFIRM_DT
                                                                                                                                                     ORDER BY PDCC_NR_CONFIRM_COUNTER DESC) MIN_OCC
         FROM DDWH01_DW_MA.TD_PDCC_PROD_DECL_CC
         WHERE PDCC_CD_PLANT_CD = P_ELT_CD_PLANT )
      WHERE MIN_OCC=1 ) PDCC,

     (SELECT *
      FROM DDWH01_DW_MA.TM_MBUD_MBU_MASTER
      WHERE MBUD_CD_PLANT_CD = P_ELT_CD_PLANT ) MBUD,

     (SELECT *
      FROM DDWH01_DW_MA.TM_PLMD_PLANT_MASTER
      WHERE PLMD_CD_PLANT_CD = P_ELT_CD_PLANT ) PLMD
   WHERE 1=1
     AND PROP_ID_PROR_PROD_ORD = PROR_ID_PROD_ORD
     AND PROR_CD_PROD_ORD = WPAK_CD_PROD_ORD
     AND PROP_CD_EFF_ORD = OPPO_CD_PROD_ORD (+)
     AND PROP_CD_OP = OPPO_CD_OP (+)
     AND PROP_CD_EFF_ORD = PRPO_CD_PROD_ORD (+)
     AND PROP_CD_EFF_ORD = PLPP_MAX.PLPP_CD_EFF_ORD (+)
     AND PROP_CD_OP = PLPP_MAX.PLPP_CD_OP (+)
     AND PLPP_MAX.PLPP_CD_EFF_ORD = PLRM.PLRM_CD_EFF_ORD (+)
     AND PLPP_MAX.PLPP_CD_OP = PLRM.PLRM_CD_OP (+)
     AND PLPP_MAX.PLPP_CD_MAX_PROC_LOT = PLRM.PLRM_CD_PROC_LOT (+)
     AND PROP_CD_EFF_ORD = POPL.POPL_CD_PROD_ORD (+)
     AND PROP_CD_PROD_ORD = PDCC.PDCC_CD_PROD_ORD (+)
     AND PROP_CD_OP = PDCC.PDCC_CD_OP (+)
     AND PROP_CD_WCTR_CD = PLMD_CD_WCTR_CD (+)
     AND PLMD_CD_DEP = MBUD_CD_DEP_CD (+)
     AND UPPER (MBUD_CD_MBU_CD) NOT IN ('MBU4',
                                        'MBU5') ) QRY ON (TRG.WPAA_CD_PLANT_CD = QRY.PROP_CD_PLANT_CD
                                                          AND TRG.WPAA_ID_CONFIRM_DT = QRY.WPAA_ID_CONFIRM_DT
                                                          AND TRG.WPAA_CD_PROD_ORD = QRY.PROP_CD_PROD_ORD
                                                          AND TRG.WPAA_CD_OP = QRY.PROP_CD_OP) WHEN MATCHED THEN
UPDATE
SET TRG.WPAA_ID_WPAA= DDWH02_DM_MA.SEQ_WPAA_TFCT01.NEXTVAL,
    TRG.WPAA_ID_MTRL_PART_NBR= QRY.PROR_ID_MAMD_PART_NBR,
    TRG.WPAA_CD_PART_NBR= QRY.PROR_CD_PART_NBR,
    TRG.WPAA_ID_MTRL_RAW_MATERIAL= QRY.WPAA_ID_MTRL_RAW_MATERIAL,
    TRG.WPAA_CD_RAW_MATERIAL= QRY.PLRM_CD_MAX_ACT_COMP,
    TRG.WPAA_ID_PLST= QRY.PROP_ID_PLMD_WCTR_CD,
    TRG.WPAA_CD_WCTR_CD= QRY.PROP_CD_WCTR_CD,
    TRG.WPAA_ID_SCHED_END_OP_DT= QRY.WPAA_ID_SCHED_END_OP_DT,
    TRG.WPAA_CD_CTRL_KEY= QRY.PROP_CD_CTRL_KEY,
    TRG.WPAA_CD_EFF_ORD= QRY.PROP_CD_EFF_ORD,
    TRG.WPAA_FL_CLOSE_MARK= QRY.INFERRED_CLOSE_MARK,
    TRG.WPAA_QT_BASE_QTY= QRY.PROP_QT_BASE_QTY,
    TRG.WPAA_QT_CONFIRM_QTY= QRY.WPAA_QT_CONFIRM_QTY,
    TRG.WPAA_QT_CUM_CONFIRM_QTY= QRY.WPAA_QT_CUM_CONFIRM_QTY,
    TRG.WPAA_CD_OP_MARKER= QRY.WPAA_CD_OP_MARKER,
    TRG.WPAA_QT_REM_QTY= QRY.WPAA_QT_REM_QTY,
    TRG.WPAA_CD_PROC_LOT= QRY.PLPP_CD_PROC_LOT,
    TRG.WPAA_ID_PRIO_PRIORITY= QRY.WPAA_ID_PRIO_PRIORITY,
    TRG.WPAA_CD_OP_PRIORITY= QRY.WPAA_CD_OP_PRIORITY,
    TRG.WPAA_CD_NESTING_TP= QRY.WPAA_CD_NESTING_TP,
    TRG.WPAA_QT_WORKST_TIME= QRY.PROP_QT_WORKST_TIME,
    TRG.WPAA_QT_LABOR_VAL= QRY.PROP_QT_LABOR_VAL,
    TRG.WPAA_QT_RUN_TIME= QRY.WPAA_QT_RUN_TIME,
    TRG.WPAA_QT_STD_SET_TIME_PER_OP= QRY.WPAA_QT_STD_SET_TIME_PER_OP,
    TRG.WPAA_QT_REM_MACH_TIME= QRY.WPAA_QT_REM_MACH_TIME,
    TRG.WPAA_QT_REM_MAN_TIME= QRY.WPAA_QT_REM_MAN_TIME,
    TRG.WPAA_QT_REM_RUN_TIME= QRY.WPAA_QT_REM_RUN_TIME,
    TRG.WPAA_QT_WORKED= QRY.WPAA_QT_WORKED,
    TRG.WPAA_QT_MACH_TIME_WORKED= QRY.WPAA_QT_MACH_TIME_WORKED,
    TRG.WPAA_QT_MAN_TIME_WORKED= QRY.WPAA_QT_MAN_TIME_WORKED,
    TRG.WPAA_QT_HOURS_WORKED= QRY.WPAA_QT_HOURS_WORKED,
    TRG.WPAA_QT_HOURS_CORRECT= QRY.WPAA_QT_HOURS_CORRECT,
    TRG.WPAA_ID_TIME_SCHED_END_PROD_DT= QRY.WPAA_ID_TIME_SCHED_END_PROD_DT,
    TRG.WPAA_ID_BATCH_ID= QRY.WPAA_ID_BATCH_ID,
    TRG.WPAA_CD_SOURCE_SYSTEM= QRY.WPAA_CD_SOURCE_SYSTEM,
    TRG.WPAA_CD_OPERATOR_CODE= 'ETL',
    TRG.WPAA_DT_INS_ROW= SYSDATE,
    TRG.WPAA_DT_UPD_ROW= SYSDATE WHEN NOT MATCHED THEN
INSERT (WPAA_CD_PLANT_CD,
        WPAA_ID_WPAA,
        WPAA_ID_MTRL_PART_NBR,
        WPAA_CD_PART_NBR,
        WPAA_ID_MTRL_RAW_MATERIAL,
        WPAA_CD_RAW_MATERIAL,
        WPAA_ID_PLST,
        WPAA_CD_WCTR_CD,
        WPAA_ID_CONFIRM_DT,
        WPAA_ID_SCHED_END_OP_DT,
        WPAA_CD_PROD_ORD,
        WPAA_CD_OP,
        WPAA_CD_CTRL_KEY,
        WPAA_CD_EFF_ORD,
        WPAA_FL_CLOSE_MARK,
        WPAA_QT_BASE_QTY,
        WPAA_QT_CONFIRM_QTY,
        WPAA_QT_CUM_CONFIRM_QTY,
        WPAA_CD_OP_MARKER,
        WPAA_QT_REM_QTY,
        WPAA_CD_PROC_LOT,
        WPAA_ID_PRIO_PRIORITY,
        WPAA_CD_OP_PRIORITY,
        WPAA_CD_NESTING_TP,
        WPAA_QT_WORKST_TIME,
        WPAA_QT_LABOR_VAL,
        WPAA_QT_RUN_TIME,
        WPAA_QT_STD_SET_TIME_PER_OP,
        WPAA_QT_REM_MACH_TIME,
        WPAA_QT_REM_MAN_TIME,
        WPAA_QT_REM_RUN_TIME,
        WPAA_QT_WORKED,
        WPAA_QT_MACH_TIME_WORKED,
        WPAA_QT_MAN_TIME_WORKED,
        WPAA_QT_HOURS_WORKED,
        WPAA_QT_HOURS_CORRECT,
        WPAA_ID_TIME_SCHED_END_PROD_DT,
        WPAA_ID_BATCH_ID,
        WPAA_CD_SOURCE_SYSTEM,
        WPAA_CD_OPERATOR_CODE,
        WPAA_DT_INS_ROW,
        WPAA_DT_UPD_ROW)
VALUES (QRY.PROP_CD_PLANT_CD, DDWH02_DM_MA.SEQ_WPAA_TFCT01.NEXTVAL, QRY.PROR_ID_MAMD_PART_NBR, QRY.PROR_CD_PART_NBR, QRY.WPAA_ID_MTRL_RAW_MATERIAL, QRY.PLRM_CD_MAX_ACT_COMP, QRY.PROP_ID_PLMD_WCTR_CD, QRY.PROP_CD_WCTR_CD, QRY.WPAA_ID_CONFIRM_DT, QRY.WPAA_ID_SCHED_END_OP_DT, QRY.PROP_CD_PROD_ORD, QRY.PROP_CD_OP, QRY.PROP_CD_CTRL_KEY, QRY.PROP_CD_EFF_ORD, QRY.INFERRED_CLOSE_MARK, QRY.PROP_QT_BASE_QTY, QRY.WPAA_QT_CONFIRM_QTY, QRY.WPAA_QT_CUM_CONFIRM_QTY, QRY.WPAA_CD_OP_MARKER, QRY.WPAA_QT_REM_QTY, QRY.PLPP_CD_PROC_LOT, QRY.WPAA_ID_PRIO_PRIORITY, QRY.WPAA_CD_OP_PRIORITY, QRY.WPAA_CD_NESTING_TP, QRY.PROP_QT_WORKST_TIME, QRY.PROP_QT_LABOR_VAL, QRY.WPAA_QT_RUN_TIME, QRY.WPAA_QT_STD_SET_TIME_PER_OP, QRY.WPAA_QT_REM_MACH_TIME, QRY.WPAA_QT_REM_MAN_TIME, QRY.WPAA_QT_REM_RUN_TIME, QRY.WPAA_QT_WORKED, QRY.WPAA_QT_MACH_TIME_WORKED, QRY.WPAA_QT_MAN_TIME_WORKED, QRY.WPAA_QT_HOURS_WORKED, QRY.WPAA_QT_HOURS_CORRECT, QRY.WPAA_ID_TIME_SCHED_END_PROD_DT, QRY.WPAA_ID_BATCH_ID, QRY.WPAA_CD_SOURCE_SYSTEM, 'ETL', SYSDATE, SYSDATE)