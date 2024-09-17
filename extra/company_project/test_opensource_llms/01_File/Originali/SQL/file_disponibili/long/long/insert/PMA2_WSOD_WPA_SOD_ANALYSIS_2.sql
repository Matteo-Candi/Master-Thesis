INSERT INTO DDWH02_DM_MA.TFCT_WSOD_WPA_SOD_ANALYSIS TRG (WSOD_CD_PLANT_CD, WSOD_ID_WSOD, WSOD_ID_TIME_SNAPSHOT, WSOD_FL_UNRELEASED_MARK, WSOD_ID_MTRL_PART_NBR, WSOD_CD_PART_NBR, WSOD_ID_MTRL_RAW_MATERIAL, WSOD_CD_RAW_MATERIAL, WSOD_ID_PLST, WSOD_CD_WCTR_CD, WSOD_ID_CONFIRM_DT, WSOD_ID_SCHED_END_OP_DT, WSOD_CD_PROD_ORD, WSOD_CD_OP, WSOD_CD_CTRL_KEY, WSOD_CD_EFF_ORD, WSOD_ID_ORTP_ORD_TP, WSOD_CD_ORD_TP, WSOD_FL_CLOSE_MARK, WSOD_QT_BASE_QTY, WSOD_QT_CONFIRM_QTY, WSOD_QT_CUM_CONFIRM_QTY, WSOD_CD_OP_MARKER, WSOD_QT_REM_QTY, WSOD_CD_PROC_LOT, WSOD_ID_PRIO_PRIORITY, WSOD_CD_OP_PRIORITY, WSOD_CD_NESTING_TP, WSOD_QT_WORKST_TIME, WSOD_QT_LABOR_VAL, WSOD_QT_RUN_TIME, WSOD_QT_STD_SET_TIME_PER_OP, WSOD_QT_REM_MACH_TIME, WSOD_QT_REM_MAN_TIME, WSOD_QT_REM_RUN_TIME, WSOD_QT_WORKED, WSOD_QT_MACH_TIME_WORKED, WSOD_QT_MAN_TIME_WORKED, WSOD_QT_HOURS_WORKED, WSOD_QT_HOURS_CORRECT, WSOD_ID_BATCH_ID, WSOD_CD_SOURCE_SYSTEM, WSOD_CD_OPERATOR_CODE, WSOD_DT_INS_ROW, WSOD_DT_UPD_ROW, WSOD_QT_STD_SET_TIME_WORKED)
SELECT QRY.WSOD_CD_PLANT_CD,
       DDWH02_DM_MA.SEQ_WSOD_TFCT01.NEXTVAL,
       QRY.WSOD_ID_TIME_SNAPSHOT,
       QRY.WSOD_FL_UNRELEASED_MARK,
       QRY.WSOD_ID_MTRL_PART_NBR,
       QRY.WSOD_CD_PART_NBR,
       QRY.WSOD_ID_MTRL_RAW_MATERIAL,
       QRY.WSOD_CD_RAW_MATERIAL,
       QRY.WSOD_ID_PLST,
       QRY.WSOD_CD_WCTR_CD,
       QRY.WSOD_ID_CONFIRM_DT,
       QRY.WSOD_ID_SCHED_END_OP_DT,
       QRY.WSOD_CD_PROD_ORD,
       QRY.WSOD_CD_OP,
       QRY.WSOD_CD_CTRL_KEY,
       QRY.WSOD_CD_EFF_ORD,
       QRY.WSOD_ID_ORTP_ORD_TP,
       QRY.WSOD_CD_ORD_TP,
       QRY.WSOD_FL_CLOSE_MARK,
       QRY.WSOD_QT_BASE_QTY,
       QRY.WSOD_QT_CONFIRM_QTY,
       QRY.WSOD_QT_CUM_CONFIRM_QTY,
       QRY.WSOD_CD_OP_MARKER,
       QRY.WSOD_QT_REM_QTY,
       QRY.WSOD_CD_PROC_LOT,
       QRY.WSOD_ID_PRIO_PRIORITY,
       QRY.WSOD_CD_OP_PRIORITY,
       QRY.WSOD_CD_NESTING_TP,
       QRY.WSOD_QT_WORKST_TIME,
       QRY.WSOD_QT_LABOR_VAL,
       QRY.WSOD_QT_RUN_TIME,
       QRY.WSOD_QT_STD_SET_TIME_PER_OP,
       QRY.WSOD_QT_REM_MACH_TIME,
       QRY.WSOD_QT_REM_MAN_TIME,
       QRY.WSOD_QT_REM_RUN_TIME,
       QRY.WSOD_QT_WORKED,
       QRY.WSOD_QT_MACH_TIME_WORKED,
       QRY.WSOD_QT_MAN_TIME_WORKED,
       QRY.WSOD_QT_HOURS_WORKED,
       QRY.WSOD_QT_HOURS_CORRECT,
       QRY.WSOD_ID_BATCH_ID,
       QRY.WSOD_CD_SOURCE_SYSTEM,
       'ETL',
       SYSDATE,
       SYSDATE,
       QRY.WSOD_QT_STD_SET_TIME_WORKED
FROM
  (SELECT WSOD_CD_PLANT_CD,
          NULL WSOD_ID_WSOD,
               WSOD_ID_TIME_SNAPSHOT,
               WSOD_FL_UNRELEASED_MARK,
               WSOD_ID_MTRL_PART_NBR,
               WSOD_CD_PART_NBR,
               WSOD_ID_MTRL_RAW_MATERIAL,
               WSOD_CD_RAW_MATERIAL,
               WSOD_ID_PLST,
               WSOD_CD_WCTR_CD,
               WSOD_ID_CONFIRM_DT,
               WSOD_ID_SCHED_END_OP_DT,
               WSOD_CD_PROD_ORD,
               WSOD_CD_OP,
               WSOD_CD_CTRL_KEY,
               WSOD_CD_EFF_ORD,
               WSOD_ID_ORTP_ORD_TP,
               WSOD_CD_ORD_TP,
               WSOD_FL_CLOSE_MARK,
               WSOD_QT_BASE_QTY,
               WSOD_QT_CONFIRM_QTY,
               WSOD_QT_CUM_CONFIRM_QTY,
               WSOD_CD_OP_MARKER,
               WSOD_QT_REM_QTY,
               WSOD_CD_PROC_LOT,
               NVL (WSOD_ID_PRIO_PRIORITY, -2) AS WSOD_ID_PRIO_PRIORITY,
               WSOD_CD_OP_PRIORITY,
               WSOD_CD_NESTING_TP,
               WSOD_QT_WORKST_TIME,
               WSOD_QT_LABOR_VAL,
               WSOD_QT_RUN_TIME,
               WSOD_QT_STD_SET_TIME_WORKED,
               WSOD_QT_STD_SET_TIME_PER_OP,
               WSOD_QT_REM_MACH_TIME,
               WSOD_QT_REM_MAN_TIME,
               WSOD_QT_REM_RUN_TIME,
               WSOD_QT_WORKED,
               WSOD_QT_MACH_TIME_WORKED,
               WSOD_QT_MAN_TIME_WORKED,
               WSOD_QT_HOURS_WORKED,
               WSOD_QT_HOURS_CORRECT,
               WSOD_ID_BATCH_ID,
               WSOD_CD_SOURCE_SYSTEM
   FROM
     (SELECT PROP_CD_PLANT_CD AS WSOD_CD_PLANT_CD,
             TO_NUMBER (TO_CHAR (TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'), 'J')) WSOD_ID_TIME_SNAPSHOT,
             0 WSOD_FL_UNRELEASED_MARK,
             PROR_ID_MAMD_PART_NBR AS WSOD_ID_MTRL_PART_NBR,
             PROR_CD_PART_NBR AS WSOD_CD_PART_NBR,
             NVL (PLRM.PLRM_ID_MAX_MAMD_ACT_COMP, -2) AS WSOD_ID_MTRL_RAW_MATERIAL,
             PLRM.PLRM_CD_MAX_ACT_COMP AS WSOD_CD_RAW_MATERIAL,
             PROP_ID_PLMD_WCTR_CD AS WSOD_ID_PLST,
             PROP_CD_WCTR_CD AS WSOD_CD_WCTR_CD,
             NVL (TO_NUMBER (TO_CHAR (PDCC.PDCC_DT_CONFIRM_DT, 'J')), -2) AS WSOD_ID_CONFIRM_DT,
             NVL (TO_NUMBER (TO_CHAR (PROP_DT_SCHED_END_OP_DT, 'J')), -2) AS WSOD_ID_SCHED_END_OP_DT,
             PROP_CD_PROD_ORD AS WSOD_CD_PROD_ORD,
             PROP_CD_OP AS WSOD_CD_OP,
             PROP_CD_CTRL_KEY AS WSOD_CD_CTRL_KEY,
             PROP_CD_EFF_ORD AS WSOD_CD_EFF_ORD,
             NVL (PROR_ID_ORTP_ORD_TP, -2) AS WSOD_ID_ORTP_ORD_TP,
             PROR_CD_ORD_TP AS WSOD_CD_ORD_TP,
             PROP_FL_CLOSE_MARK AS WSOD_FL_CLOSE_MARK,
             PROP_QT_BASE_QTY AS WSOD_QT_BASE_QTY,
             PDCC.QTY AS WSOD_QT_CONFIRM_QTY,
             PDCC.CUM_QTY AS WSOD_QT_CUM_CONFIRM_QTY,
             CASE
                 WHEN PROP_FL_CLOSE_MARK = 0
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
                 WHEN PROP_FL_CLOSE_MARK = 0
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
             END AS WSOD_CD_OP_MARKER,
             NVL (PROP_QT_BASE_QTY, 0) - NVL (PDCC.CUM_QTY, 0) AS WSOD_QT_REM_QTY,
             NVL (PLPP_CD_MAX_PROC_LOT, POPL_CD_PROC_LOT) AS WSOD_CD_PROC_LOT,
             NVL (TD_OPPO_OP_PRIORITY_PROD_ORD.PRIO_ID_PRIOR, TT_PRPO_PRIORITY_PROD_ORD.PRIO_ID_PRIOR) AS WSOD_ID_PRIO_PRIORITY,
             NVL (TD_OPPO_OP_PRIORITY_PROD_ORD.PRIO_CD_PRIORITY, TT_PRPO_PRIORITY_PROD_ORD.PRIO_CD_PRIORITY) AS WSOD_CD_OP_PRIORITY,
             CASE
                 WHEN (NVL (PLPP_CD_MAX_PROC_LOT, POPL_CD_PROC_LOT) IS NOT NULL
                       AND PROP_MAX_FL_TOOL_PROG_MARK = '1') THEN 'FN'
                 WHEN (NVL (PLPP_CD_MAX_PROC_LOT, POPL_CD_PROC_LOT) IS NOT NULL
                       AND PROP_MAX_FL_TOOL_PROG_MARK = '0') THEN 'VN'
                 ELSE NULL
             END AS WSOD_CD_NESTING_TP,
             PROP_QT_WORKST_TIME AS WSOD_QT_WORKST_TIME,
             PROP_QT_LABOR_VAL AS WSOD_QT_LABOR_VAL,
             (PROP_QT_WORKST_TIME + PROP_QT_LABOR_VAL) AS WSOD_QT_RUN_TIME,
             (CASE
                  WHEN PDCC.QTY = PDCC.CUM_QTY
                       AND PDCC.QTY <> 0
                       AND PDCC.CUM_QTY <> 0 THEN PROP_QT_STD_SET_TIME_PER_OP
                  ELSE 0
              END) AS WSOD_QT_STD_SET_TIME_WORKED,
             PROP_QT_STD_SET_TIME_PER_OP AS WSOD_QT_STD_SET_TIME_PER_OP,
             PROP_QT_WORKST_TIME * (NVL (PROP_QT_BASE_QTY, 0) - NVL (PDCC.CUM_QTY, 0)) AS WSOD_QT_REM_MACH_TIME,
             PROP_QT_LABOR_VAL * (NVL (PROP_QT_BASE_QTY, 0) - NVL (PDCC.CUM_QTY, 0)) AS WSOD_QT_REM_MAN_TIME,
             (PROP_QT_WORKST_TIME + PROP_QT_LABOR_VAL) * (NVL (PROP_QT_BASE_QTY, 0) - NVL (PDCC.CUM_QTY, 0)) AS WSOD_QT_REM_RUN_TIME,
             PDCC.WSOD_QT_WORKED AS WSOD_QT_WORKED,
             PROP_QT_WORKST_TIME * PDCC.WSOD_QT_WORKED AS WSOD_QT_MACH_TIME_WORKED,
             PROP_QT_LABOR_VAL * PDCC.WSOD_QT_WORKED AS WSOD_QT_MAN_TIME_WORKED,
             (PROP_QT_WORKST_TIME + PROP_QT_LABOR_VAL) * PDCC.WSOD_QT_WORKED AS WSOD_QT_HOURS_WORKED,
             CASE
                 WHEN COALESCE (OPPO_NR_OP_PRIORITY,
                                PRPO_NR_ORD_PRIORITY,
                                0) <=2 THEN 0
                 ELSE (PROP_QT_WORKST_TIME + PROP_QT_LABOR_VAL) * PDCC.WSOD_QT_WORKED
             END AS WSOD_QT_HOURS_CORRECT,
             NVL (P_ELT_ID_BATCH, N_ELT_ID_JOB_LOG) AS WSOD_ID_BATCH_ID,
             PROP_CD_SOURCE_SYSTEM AS WSOD_CD_SOURCE_SYSTEM
      FROM
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
                PROP_DT_CONFIRM_DT,
                PROP_CD_SOURCE_SYSTEM
         FROM
           (SELECT *
            FROM DDWH01_DW_MA.TD_PROP_PROD_ORD_OP
            WHERE PROP_CD_PLANT_CD = P_ELT_CD_PLANT
              AND PROP_FL_LOGICAL_STATUS = '1' ) PROP ,
           (SELECT *
            FROM DDWH01_DW_MA.TD_PRCO_PROD_ORD_COMP
            WHERE PRCO_CD_PLANT_CD = P_ELT_CD_PLANT
              AND PRCO_FL_COMP_CAT ='M'
              AND PRCO_FL_LOGICAL_STATUS = '1' ) ,
           (SELECT *
            FROM DDWH02_DM_MA.TDIM_MTRL_MATERIAL,
                 DDWH01_DW_MA.TM_PLNT_PLANT
            WHERE MTRL_CD_PLANT_CD =P_ELT_CD_PLANT
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
                  PROP_DT_CONFIRM_DT,
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
                                                                                                                   PDCC_DT_CONFIRM_DT) WSOD_QT_WORKED,
                                                                                                     SUM (PDCC_QT_CONFIRM_QTY) OVER (PARTITION BY PDCC_CD_PROD_ORD,
                                                                                                                                                  PDCC_CD_OP
                                                                                                                                     ORDER BY PDCC_DT_CONFIRM_DT ASC) CUM_QTY,
                                                                                                                                    ROW_NUMBER () OVER (PARTITION BY PDCC_CD_PROD_ORD,
                                                                                                                                                                     PDCC_CD_OP
                                                                                                                                                        ORDER BY PDCC_DT_CONFIRM_DT DESC) MAX_OCC
            FROM DDWH01_DW_MA.TD_PDCC_PROD_DECL_CC
            WHERE PDCC_CD_PLANT_CD = P_ELT_CD_PLANT )
         WHERE MAX_OCC=1 ) PDCC,

        (SELECT *
         FROM DDWH01_DW_MA.TM_MBUD_MBU_MASTER
         WHERE MBUD_CD_PLANT_CD = P_ELT_CD_PLANT ) MBUD,

        (SELECT *
         FROM DDWH01_DW_MA.TM_PLMD_PLANT_MASTER
         WHERE PLMD_CD_PLANT_CD = P_ELT_CD_PLANT ) PLMD
      WHERE 1=1
        AND PROP_ID_PROR_PROD_ORD = PROR_ID_PROD_ORD
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
                                           'MBU5')
        AND ((PROR_FL_CLOSE_MARK = '0'
              AND (PROP_FL_CLOSE_MARK = '0'
                   OR (PROP_FL_CLOSE_MARK = '1'
                       AND PROP_DT_CONFIRM_DT = TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'))))
             OR (PROR_FL_CLOSE_MARK = '1'
                 AND (PROP_FL_CLOSE_MARK = '1'
                      AND PROP_DT_CONFIRM_DT = TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'))))
      UNION ALL SELECT PLOP_CD_PLANT_CD AS WSOD_CD_PLANT_CD,
                       TO_NUMBER (TO_CHAR (TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'), 'J')) WSOD_ID_TIME_SNAPSHOT,
                       1 WSOD_FL_UNRELEASED_MARK,
                       PLOR_ID_MAMD_PART_NBR AS WSOD_ID_MTRL_PART_NBR,
                       PLOR_CD_PART_NBR AS WSOD_CD_PART_NBR,
                       NVL (PLRM.PLRM_ID_MAX_MAMD_ACT_COMP, -2) AS WSOD_ID_MTRL_RAW_MATERIAL,
                       PLRM.PLRM_CD_MAX_ACT_COMP AS WSOD_CD_RAW_MATERIAL,
                       PLOP_ID_PLMD_WCTR_CD AS WSOD_ID_PLST,
                       PLOP_CD_WCTR_CD AS WSOD_CD_WCTR_CD,
                       -2 AS WSOD_ID_CONFIRM_DT,
                       NVL (TO_NUMBER (TO_CHAR (PLOR_DT_END_PROD_DT, 'J')), -2) AS WSOD_ID_SCHED_END_OP_DT,
                       PLOP_CD_ORD_ID AS WSOD_CD_PROD_ORD,
                       PLOP_CD_OP AS WSOD_CD_OP,
                       PLOP_CD_CTRL_KEY AS WSOD_CD_CTRL_KEY,
                       NULL AS WSOD_CD_EFF_ORD,
                       NVL (PLOR_ID_ORTP_ORD_TP, -2) AS WSOD_ID_ORTP_ORD_TP,
                       PLOR_CD_ORD_TP AS WSOD_CD_ORD_TP,
                       NULL AS WSOD_FL_CLOSE_MARK,
                       PLOP_QT_PLN_QTY AS WSOD_QT_BASE_QTY,
                       NULL AS WSOD_QT_CONFIRM_QTY,
                       NULL AS WSOD_QT_CUM_CONFIRM_QTY,
                       CASE
                           WHEN PLOR_DT_END_PROD_DT <= TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') THEN 'UN'
                           ELSE NULL
                       END AS WSOD_CD_OP_MARKER,
                       PLOP_QT_PLN_QTY AS WSOD_QT_REM_QTY,
                       PLPP_CD_MAX_PROC_LOT AS WSOD_CD_PROC_LOT,
                       NVL (TD_OPPL_OP_PRIORITY_PLND_ORD.PRIO_ID_PRIOR, TT_PRPL_PRIORITY_PLND_ORD.PRIO_ID_PRIOR) AS WSOD_ID_PRIO_PRIORITY,
                       NVL (TD_OPPL_OP_PRIORITY_PLND_ORD.PRIO_CD_PRIORITY, TT_PRPL_PRIORITY_PLND_ORD.PRIO_CD_PRIORITY) AS WSOD_CD_OP_PRIORITY,
                       CASE
                           WHEN (PLPP_CD_MAX_PROC_LOT IS NOT NULL
                                 AND PLOP_MAX_FL_TOOL_PROG_MARK = '1') THEN 'FN'
                           WHEN (PLPP_CD_MAX_PROC_LOT IS NOT NULL
                                 AND PLOP_MAX_FL_TOOL_PROG_MARK = '0') THEN 'VN'
                           ELSE NULL
                       END AS WSOD_CD_NESTING_TP,
                       PLOP_QT_WORKST_TIME AS WSOD_QT_WORKST_TIME,
                       PLOP_QT_LABOR_VAL AS WSOD_QT_LABOR_VAL,
                       (PLOP_QT_WORKST_TIME + PLOP_QT_LABOR_VAL) AS WSOD_QT_RUN_TIME,
                       NULL AS WSOD_QT_STD_SET_TIME_WORKED,
                       PLOP_QT_STD_SET_TIME_PER_OP AS WSOD_QT_STD_SET_TIME_PER_OP,
                       PLOP_QT_WORKST_TIME*PLOP_QT_PLN_QTY AS WSOD_QT_REM_MACH_TIME,
                       PLOP_QT_LABOR_VAL*PLOP_QT_PLN_QTY AS WSOD_QT_REM_MAN_TIME,
                       (PLOP_QT_WORKST_TIME + PLOP_QT_LABOR_VAL) *PLOP_QT_PLN_QTY AS WSOD_QT_REM_RUN_TIME,
                       NULL AS WSOD_QT_WORKED,
                       NULL AS WSOD_QT_MACH_TIME_WORKED,
                       NULL AS WSOD_QT_MAN_TIME_WORKED,
                       NULL AS WSOD_QT_HOURS_WORKED,
                       NULL AS WSOD_QT_HOURS_CORRECT,
                       NVL (P_ELT_ID_BATCH, N_ELT_ID_JOB_LOG) AS WSOD_ID_BATCH_ID,
                       PLOP_CD_SOURCE_SYSTEM AS WSOD_CD_SOURCE_SYSTEM
      FROM
        (SELECT NVL (MAX (MTRL_FL_TOOL_PROG_MARK) , 0) PLOP_MAX_FL_TOOL_PROG_MARK,
                PLOP_CD_PLANT_CD,
                PLOP_ID_PLOR_PLND_ORD,
                PLOP_CD_ORD_ID,
                PLOP_CD_OP,
                PLOP_CD_CTRL_KEY,
                PLOP_ID_PLMD_WCTR_CD,
                PLOP_CD_WCTR_CD,
                PLOP_QT_STD_SET_TIME_PER_OP,
                PLOP_QT_PLN_QTY,
                PLOP_QT_LABOR_VAL,
                PLOP_QT_WORKST_TIME,
                PLOP_CD_SOURCE_SYSTEM
         FROM
           (SELECT *
            FROM DDWH01_DW_MA.TD_PLOP_PLND_ORD_OP
            WHERE PLOP_CD_PLANT_CD = P_ELT_CD_PLANT ) PLOP ,
           (SELECT *
            FROM DDWH01_DW_MA.TD_PLCO_PLND_ORD_COMP
            WHERE PLCO_CD_PLANT_CD = P_ELT_CD_PLANT
              AND PLCO_FL_COMP_CAT ='M' ) ,
           (SELECT *
            FROM DDWH02_DM_MA.TDIM_MTRL_MATERIAL,
                 DDWH01_DW_MA.TM_PLNT_PLANT
            WHERE MTRL_CD_PLANT_CD = P_ELT_CD_PLANT
              AND MTRL_CD_PLANT_CD= PLNT_CD_PLANT_CD
              AND MTRL_CD_LANGUAGE = PLNT_CD_LANG_M )
         WHERE 1=1
           AND PLOP_ID_PLND_ORD_OP = PLCO_ID_PLOP_PLND_ORD_OP (+)
           AND PLCO_ID_MAMD_COMP = MTRL_ID_MTRL_MATERIAL (+)
         GROUP BY PLOP_CD_PLANT_CD,
                  PLOP_ID_PLOR_PLND_ORD,
                  PLOP_CD_ORD_ID,
                  PLOP_CD_OP,
                  PLOP_CD_CTRL_KEY,
                  PLOP_ID_PLMD_WCTR_CD,
                  PLOP_CD_WCTR_CD,
                  PLOP_QT_STD_SET_TIME_PER_OP,
                  PLOP_QT_PLN_QTY,
                  PLOP_QT_LABOR_VAL,
                  PLOP_QT_WORKST_TIME,
                  PLOP_CD_SOURCE_SYSTEM) TD_PLOP_PLND_ORD_OP,

        (SELECT *
         FROM DDWH01_DW_MA.TT_PLOR_PLND_ORD
         WHERE PLOR_CD_PLANT_CD = P_ELT_CD_PLANT ) TT_PLOR_PLND_ORD,

        (SELECT PLPP_CD_EFF_ORD,
                PLPP_CD_OP,
                MAX (PLPP_CD_MAX_PROC_LOT) AS PLPP_CD_MAX_PROC_LOT,
                    PLPP_ID_PROC_LOT_PART_PROD
         FROM
           (SELECT MIN (PLPP_CD_PROC_LOT) KEEP (DENSE_RANK FIRST
                                                ORDER BY PLPP_QT_QTY_OK DESC) OVER (PARTITION BY PLPP_CD_EFF_ORD,
                                                                                                 PLPP_CD_OP) AS PLPP_CD_MAX_PROC_LOT,
                                                                                   PLPP_CD_EFF_ORD,
                                                                                   PLPP_CD_OP,
                                                                                   PLPP_ID_PROC_LOT_PART_PROD
            FROM
              (SELECT *
               FROM DDWH01_DW_MA.TD_PLPP_PROC_LOT_PART_PROD
               WHERE PLPP_CD_PLANT_CD = P_ELT_CD_PLANT
                 AND PLPP_FL_LOGICAL_STATUS = '1' ))
         GROUP BY PLPP_CD_EFF_ORD,
                  PLPP_CD_OP,
                  PLPP_ID_PROC_LOT_PART_PROD) PLPP_MAX,

        (SELECT *
         FROM DDWH01_DW_MA.TD_OPPL_OP_PRIORITY_PLND_ORD,
              DDWH02_DM_MA.TDIM_PRIO_PRIORITY
         WHERE 1=1
           AND OPPL_CD_PLANT_CD = PRIO_CD_PLANT_CD (+)
           AND TO_CHAR (OPPL_NR_OP_PRIORITY) = PRIO_CD_PRIORITY (+)
           AND OPPL_CD_PLANT_CD = P_ELT_CD_PLANT ) TD_OPPL_OP_PRIORITY_PLND_ORD,

        (SELECT PRPL.*,
                PRIO.*
         FROM DDWH01_DW_MA.TT_PRPL_PRIORITY_PLND_ORD PRPL,
              DDWH02_DM_MA.TDIM_PRIO_PRIORITY PRIO ,
           (SELECT *
            FROM DDWH01_DW_MA.TT_PLOR_PLND_ORD
            WHERE PLOR_CD_PLANT_CD = P_ELT_CD_PLANT
              AND PLOR_CD_ORD_TP<>'KD' )
         WHERE 1=1
           AND PRPL_CD_PLANT_CD = PRIO_CD_PLANT_CD (+)
           AND TO_CHAR (PRPL_NR_ORD_PRIORITY) = PRIO_CD_PRIORITY (+)
           AND PRPL_CD_PLANT_CD = P_ELT_CD_PLANT
           AND PLOR_ID_PLND_ORD = PRPL_ID_PLOR_PLND_ORD ) TT_PRPL_PRIORITY_PLND_ORD,

        (SELECT PLRM_CD_EFF_ORD,
                PLRM_CD_OP,
                PLRM_CD_PROC_LOT,
                MAX (PLRM_ID_MAX_MAMD_ACT_COMP) PLRM_ID_MAX_MAMD_ACT_COMP,
                    PLRM_ID_PLPP_PROC_LOT_PART_NBR,
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
                                                                                                                                                                      PLRM_CD_PROC_LOT,
                                                                                                                                                                      PLRM_ID_PLPP_PROC_LOT_PART_NBR
            FROM
              (SELECT *
               FROM DDWH01_DW_MA.TD_PLRM_PROC_LOT_RAW_MAT
               WHERE PLRM_CD_PLANT_CD = P_ELT_CD_PLANT
                 AND PLRM_FL_LOGICAL_STATUS = '1' ))
         GROUP BY PLRM_CD_EFF_ORD,
                  PLRM_CD_OP,
                  PLRM_CD_PROC_LOT,
                  PLRM_ID_PLPP_PROC_LOT_PART_NBR) PLRM,

        (SELECT *
         FROM DDWH01_DW_MA.TM_MBUD_MBU_MASTER
         WHERE MBUD_CD_PLANT_CD = P_ELT_CD_PLANT ) MBUD,

        (SELECT *
         FROM DDWH01_DW_MA.TM_PLMD_PLANT_MASTER
         WHERE PLMD_CD_PLANT_CD = P_ELT_CD_PLANT ) PLMD
      WHERE 1=1
        AND PLOP_ID_PLOR_PLND_ORD = PLOR_ID_PLND_ORD
        AND PLOP_CD_ORD_ID = OPPL_CD_PLND_ORD (+)
        AND PLOP_CD_OP = OPPL_CD_OP (+)
        AND PLOP_CD_ORD_ID = PRPL_CD_PLND_ORD (+)
        AND PLOP_CD_ORD_ID = PLPP_MAX.PLPP_CD_EFF_ORD (+)
        AND PLOP_CD_OP = PLPP_MAX.PLPP_CD_OP (+)
        AND PLPP_MAX.PLPP_CD_EFF_ORD = PLRM.PLRM_CD_EFF_ORD (+)
        AND PLPP_MAX.PLPP_CD_OP = PLRM.PLRM_CD_OP (+)
        AND PLPP_MAX.PLPP_CD_MAX_PROC_LOT = PLRM.PLRM_CD_PROC_LOT (+)
        AND PLOP_CD_WCTR_CD = PLMD_CD_WCTR_CD (+)
        AND PLMD_CD_DEP = MBUD_CD_DEP_CD (+)
        AND UPPER (MBUD_CD_MBU_CD) NOT IN ('MBU4',
                                           'MBU5')
        AND PLOR_DT_END_PROD_DT <= TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') +203+ (7-TO_CHAR (TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'), 'D')) )) QRY