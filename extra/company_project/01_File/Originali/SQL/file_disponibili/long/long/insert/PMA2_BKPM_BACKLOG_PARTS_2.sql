INSERT INTO DDWH02_DM_MA.TFCT_BKPM_BACKLOG_PARTS TRG (BKPM_CD_PLANT_CD, BKPM_ID_BKPM_ID_BKPM, BKPM_ID_TIME_SNAPSHOT, BKPM_CD_PROD_ORD, BKPM_CD_EFF_ORD, BKPM_ID_MTRL_MATERIAL, BKPM_CD_MATERIAL, BKPM_FL_UNRELEASED_MARK, BKPM_ID_PRST_STATUS, BKPM_CD_ORD_STATUS, BKPM_CD_OP, BKPM_CD_CTRL_KEY, BKPM_ID_WCTR_CD, BKPM_CD_WCTR_CD, BKPM_DT_SCHED_STR_OP_DT, BKPM_DT_SCHED_END_OP_DT, BKPM_QT_STD_SET_TIME_PER_OP, BKPM_QT_BASE_QTY, BKPM_QT_REM_QTY, BKPM_QT_REM_MAN_TIME, BKPM_QT_REM_MACHINE_TIME, BKPM_QT_REM_TOTAL_TIME, BKPM_CD_BCKLG_TP_PARTSMAKING, BKPM_CD_BCKLG_TP_PAINTING, BKPM_ID_PRIO_PRIORITY, BKPM_CD_OP_PRIORITY, BKPM_CD_PROC_LOT, BKPM_ID_TIME_SCHED_STR_ORD_DT, BKPM_ID_TIME_SCHED_END_ORD_DT, BKPM_FL_BACKLOG, BKPM_QT_ORD_CONF_QTY, BKPM_ID_BATCH_ID, BKPM_CD_SOURCE_SYSTEM, BKPM_CD_OPERATOR_CODE, BKPM_DT_INS_ROW, BKPM_DT_UPD_ROW)
SELECT QRY.BKPM_CD_PLANT_CD,
       DDWH02_DM_MA.SEQ_BKPM_TFCT01.NEXTVAL,
       QRY.BKPM_ID_TIME_SNAPSHOT,
       QRY.BKPM_CD_PROD_ORD,
       QRY.BKPM_CD_EFF_ORD,
       QRY.BKPM_ID_MTRL_MATERIAL,
       QRY.BKPM_CD_MATERIAL,
       QRY.BKPM_UNRELEASED_MARK,
       QRY.BKPM_ID_PRST_STATUS,
       QRY.BKPM_CD_ORD_STATUS,
       QRY.BKPM_CD_OP,
       QRY.BKPM_CD_CTRL_KEY,
       QRY.BKPM_ID_WCTR_CD,
       QRY.BKPM_CD_WCTR_CD,
       QRY.BKPM_DT_SCHED_STR_OP_DT,
       QRY.BKPM_DT_SCHED_END_OP_DT,
       QRY.BKPM_QT_STD_SET_TIME_PER_OP,
       QRY.BKPM_QT_BASE_QTY,
       QRY.BKPM_QT_REM_QTY,
       QRY.BKPM_QT_REM_MAN_TIME,
       QRY.BKPM_QT_REM_MACHINE_TIME,
       QRY.BKPM_QT_REM_TOTAL_TIME,
       QRY.BKPM_CD_BCKLG_TP_PARTSMAKING,
       QRY.BKPM_CD_BCKLG_TP_PAINTING,
       QRY.BKPM_ID_PRIO_PRIORITY,
       QRY.BKPM_CD_OP_PRIORITY,
       QRY.BKPM_CD_PROC_LOT,
       QRY.BKPM_ID_TIME_SCHED_STR_ORD_DT,
       QRY.BKPM_ID_TIME_SCHED_END_ORD_DT,
       QRY.BKPM_FL_BACKLOG,
       QRY.BKPM_QT_ORD_CONF_QTY,
       QRY.BKPM_ID_BATCH_ID,
       QRY.BKPM_CD_SOURCE_SYSTEM,
       'ETL',
       SYSDATE,
       SYSDATE
FROM
  (SELECT BKPM_CD_PLANT_CD,
          NULL BKPM_ID_BKPM_ID_BKPM,
               BKPM_ID_TIME_SNAPSHOT,
               BKPM_CD_PROD_ORD,
               BKPM_CD_EFF_ORD,
               BKPM_ID_MTRL_MATERIAL,
               BKPM_CD_MATERIAL,
               BKPM_UNRELEASED_MARK,
               BKPM_ID_PRST_STATUS,
               BKPM_CD_ORD_STATUS,
               BKPM_CD_OP,
               BKPM_CD_CTRL_KEY,
               BKPM_ID_WCTR_CD,
               BKPM_CD_WCTR_CD,
               BKPM_DT_SCHED_STR_OP_DT,
               BKPM_DT_SCHED_END_OP_DT,
               BKPM_QT_STD_SET_TIME_PER_OP,
               BKPM_QT_BASE_QTY,
               BKPM_QT_REM_QTY,
               BKPM_QT_REM_MAN_TIME,
               BKPM_QT_REM_MACHINE_TIME,
               BKPM_QT_REM_TOTAL_TIME,
               BKPM_CD_BCKLG_TP_PARTSMAKING,
               BKPM_CD_BCKLG_TP_PAINTING,
               NVL (BKPM_ID_PRIO_PRIORITY, -2) AS BKPM_ID_PRIO_PRIORITY,
               BKPM_CD_OP_PRIORITY,
               BKPM_CD_PROC_LOT,
               BKPM_ID_TIME_SCHED_STR_ORD_DT,
               BKPM_ID_TIME_SCHED_END_ORD_DT,
               BKPM_FL_BACKLOG,
               BKPM_QT_ORD_CONF_QTY,
               BKPM_ID_BATCH_ID,
               BKPM_CD_SOURCE_SYSTEM
   FROM
     (SELECT BKPM_CD_PLANT_CD,
             BKPM_ID_TIME_SNAPSHOT,
             BKPM_CD_PROD_ORD,
             BKPM_CD_EFF_ORD,
             BKPM_ID_MTRL_MATERIAL,
             BKPM_CD_MATERIAL,
             BKPM_UNRELEASED_MARK,
             BKPM_ID_PRST_STATUS,
             BKPM_CD_ORD_STATUS,
             BKPM_CD_OP,
             BKPM_CD_CTRL_KEY,
             BKPM_ID_WCTR_CD,
             BKPM_CD_WCTR_CD,
             BKPM_DT_SCHED_STR_OP_DT,
             BKPM_DT_SCHED_END_OP_DT,
             BKPM_QT_STD_SET_TIME_PER_OP,
             BKPM_QT_BASE_QTY,
             BKPM_QT_REM_QTY,
             BKPM_QT_REM_MAN_TIME,
             BKPM_QT_REM_MACHINE_TIME,
             BKPM_QT_REM_TOTAL_TIME,
             BKPM_CD_BCKLG_TP_PARTSMAKING,
             BKPM_CD_BCKLG_TP_PAINTING,
             BKPM_ID_PRIO_PRIORITY,
             BKPM_CD_OP_PRIORITY,
             BKPM_CD_PROC_LOT,
             BKPM_ID_TIME_SCHED_STR_ORD_DT,
             BKPM_ID_TIME_SCHED_END_ORD_DT,
             BKPM_FL_BACKLOG,
             BKPM_QT_ORD_CONF_QTY,
             BKPM_ID_BATCH_ID,
             BKPM_CD_SOURCE_SYSTEM
      FROM
        (SELECT PROP_CD_PLANT_CD AS BKPM_CD_PLANT_CD,
                BKPM_ID_TIME_SNAPSHOT AS BKPM_ID_TIME_SNAPSHOT,
                PROR_CD_PROD_ORD AS BKPM_CD_PROD_ORD,
                PROR_CD_EFF_ORD AS BKPM_CD_EFF_ORD,
                PROR_ID_MAMD_PART_NBR AS BKPM_ID_MTRL_MATERIAL,
                PROR_CD_PART_NBR AS BKPM_CD_MATERIAL,
                0 BKPM_UNRELEASED_MARK,
                PROR_ID_PPST_ORD_STU AS BKPM_ID_PRST_STATUS,
                PROR_CD_ORD_STU AS BKPM_CD_ORD_STATUS,
                PROP_CD_OP AS BKPM_CD_OP,
                PROP_CD_CTRL_KEY AS BKPM_CD_CTRL_KEY,
                PROP_ID_PLMD_WCTR_CD AS BKPM_ID_WCTR_CD,
                PROP_CD_WCTR_CD AS BKPM_CD_WCTR_CD,
                PROP_DT_SCHED_STR_OP_DT AS BKPM_DT_SCHED_STR_OP_DT,
                PROP_DT_SCHED_END_OP_DT AS BKPM_DT_SCHED_END_OP_DT,
                PROP_QT_STD_SET_TIME_PER_OP AS BKPM_QT_STD_SET_TIME_PER_OP,
                PROP_QT_BASE_QTY AS BKPM_QT_BASE_QTY,
                BKPM_QT_REM_QTY,
                BKPM_QT_REM_MAN_TIME,
                BKPM_QT_REM_MACHINE_TIME,
                BKPM_QT_REM_TOTAL_TIME,
                CASE
                    WHEN UPPER (MBUD_CD_MBU_CD) NOT IN ('MBU4',
                                                        'MBU5')
                         AND PROP_CD_OP <= NVL (PROP_CD_OP_MIN, '9999') THEN CASE
                                                                                 WHEN PROP_MIN_PERC_COMP >= 0.50 THEN 'PRIMARY - OK QUANTITY'
                                                                                 WHEN PROP_MIN_PERC_COMP < 0.50 THEN 'PRIMARY - NOK QUANTITY'
                                                                                 ELSE 'PRIMARY'
                                                                             END
                    WHEN UPPER (MBUD_CD_MBU_CD) NOT IN ('MBU4',
                                                        'MBU5')
                         AND PROP_CD_OP > NVL (PROP_CD_OP_MIN, '9999') THEN 'SECONDARY'
                    ELSE 'N/A'
                END AS BKPM_CD_BCKLG_TP_PARTSMAKING,
                CASE
                    WHEN UPPER (MBUD_CD_PROCESS) IN ('PAINTING')
                         AND UPPER (MBUD_CD_PROCESS) = NVL (UPPER (MBUD_PROCESS_MIN_OP) , 'XXXX') THEN CASE
                                                                                                           WHEN PROP_MIN_PERC_COMP_PAINTING >= 0.50 THEN 'STARTABLE - OK QUANTITY'
                                                                                                           WHEN PROP_MIN_PERC_COMP_PAINTING < 0.50 THEN 'STARTABLE - NOK QUANTITY'
                                                                                                           ELSE 'STARTABLE'
                                                                                                       END
                    WHEN UPPER (MBUD_CD_PROCESS) IN ('PAINTING')
                         AND UPPER (MBUD_CD_PROCESS) != NVL (UPPER (MBUD_PROCESS_MIN_OP) , 'XXX') THEN 'NOT STARTABLE'
                    ELSE 'N/A'
                END AS BKPM_CD_BCKLG_TP_PAINTING,
                NVL (TD_PRIO_ID_PRIOR, TT_PRIO_ID_PRIOR) AS BKPM_ID_PRIO_PRIORITY,
                NVL (TD_PRIO_CD_PRIORITY, TT_PRIO_CD_PRIORITY) AS BKPM_CD_OP_PRIORITY,
                NVL (PLPP_CD_PROC_LOT, POPL_CD_PROC_LOT) AS BKPM_CD_PROC_LOT,
                BKPM_ID_TIME_SCHED_STR_ORD_DT,
                BKPM_ID_TIME_SCHED_END_ORD_DT,
                BKPM_FL_BACKLOG,
                BKPM_QT_ORD_CONF_QTY,
                NVL (P_ELT_ID_BATCH, N_ELT_ID_JOB_LOG) BKPM_ID_BATCH_ID,
                PROP_CD_SOURCE_SYSTEM AS BKPM_CD_SOURCE_SYSTEM
         FROM
           (SELECT PROP_CD_PLANT_CD,
                   TO_NUMBER (TO_CHAR (TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'), 'J')) BKPM_ID_TIME_SNAPSHOT,
                   PROP_CD_OP,
                   PROP_CD_CTRL_KEY,
                   MIN_OP AS PROP_CD_OP_MIN,
                   MBUD_PROP_MILESTONE.MBUD_CD_PROCESS AS MBUD_PROCESS_MIN_OP,
                   PROP_ID_PLMD_WCTR_CD,
                   PROP_CD_WCTR_CD,
                   PROP_DT_SCHED_STR_OP_DT,
                   PROP_DT_SCHED_END_OP_DT,
                   PROP_QT_STD_SET_TIME_PER_OP,
                   PROP_QT_BASE_QTY,
                   ROUND ((PROP_QT_BASE_QTY - NVL (PROP_QT_CONFIRM_QTY, 0)) , 7) BKPM_QT_REM_QTY,
                   ROUND ((PROP_QT_LABOR_VAL) * (PROP_QT_BASE_QTY - NVL (PROP_QT_CONFIRM_QTY, 0)), 7) BKPM_QT_REM_MAN_TIME,
                   ROUND ((PROP_QT_WORKST_TIME) * (PROP_QT_BASE_QTY - NVL (PROP_QT_CONFIRM_QTY, 0)), 7) BKPM_QT_REM_MACHINE_TIME,
                   ROUND ((PROP_QT_LABOR_VAL + PROP_QT_WORKST_TIME) * (PROP_QT_BASE_QTY - NVL (PROP_QT_CONFIRM_QTY, 0)), 7) BKPM_QT_REM_TOTAL_TIME,
                   PROP_CD_SOURCE_SYSTEM,
                   PROR_CD_PROD_ORD,
                   PROR_CD_EFF_ORD,
                   PROR_ID_MAMD_PART_NBR,
                   PROR_CD_PART_NBR,
                   PROR_ID_PPST_ORD_STU,
                   PROR_CD_ORD_STU,
                   MBUD.MBUD_CD_PROCESS,
                   MBUD.MBUD_CD_MBU_CD,
                   PROP_MIN_PERC_COMP_PAINTING,
                   PROP_MIN_PERC_COMP,
                   POPL_CD_PROC_LOT,
                   PLPP_CD_PROC_LOT,
                   NVL (TO_NUMBER (TO_CHAR (PROR_DT_SCHED_STR_PROD_DT, 'J')), -2) AS BKPM_ID_TIME_SCHED_STR_ORD_DT,
                   NVL (TO_NUMBER (TO_CHAR (PROR_DT_SCHED_END_PROD_DT, 'J')), -2) AS BKPM_ID_TIME_SCHED_END_ORD_DT,
                   CASE
                       WHEN PROR_DT_SCHED_END_PROD_DT<= TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') THEN '1'
                       ELSE '0'
                   END AS BKPM_FL_BACKLOG,
                   PROR_QT_OK_QTY AS BKPM_QT_ORD_CONF_QTY,
                   TD_OPPO_OP_PRIORITY_PROD_ORD.PRIO_ID_PRIOR AS TD_PRIO_ID_PRIOR,
                   TT_PRPO_PRIORITY_PROD_ORD.PRIO_ID_PRIOR AS TT_PRIO_ID_PRIOR,
                   TD_OPPO_OP_PRIORITY_PROD_ORD.PRIO_CD_PRIORITY AS TD_PRIO_CD_PRIORITY,
                   TT_PRPO_PRIORITY_PROD_ORD.PRIO_CD_PRIORITY AS TT_PRIO_CD_PRIORITY
            FROM
              (SELECT NVL (MIN (CASE
                                    WHEN PRCO_QT_QTY-PRCO_QT_CONS_QTY = 0 THEN 1
                                    ELSE MTRL_QT_WH_DAILY/ (PRCO_QT_QTY-PRCO_QT_CONS_QTY)
                                END) , 1) PROP_MIN_PERC_COMP,
                      NVL (MIN (CASE
                                    WHEN MTRL_CD_PART_NBR NOT LIKE '85%' THEN CASE
                                                                                  WHEN PRCO_QT_QTY-PRCO_QT_CONS_QTY = 0 THEN 1
                                                                                  ELSE MTRL_QT_WH_DAILY/ (PRCO_QT_QTY-PRCO_QT_CONS_QTY)
                                                                              END
                                    ELSE 1
                                END) , 1) PROP_MIN_PERC_COMP_PAINTING,
                      PROP_CD_PLANT_CD,
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
                      PROP_CD_SOURCE_SYSTEM
               FROM
                 (SELECT *
                  FROM DDWH01_DW_MA.TD_PROP_PROD_ORD_OP
                  WHERE PROP_CD_PLANT_CD = P_ELT_CD_PLANT
                    AND PROP_FL_LOGICAL_STATUS = '1' ) PROP ,
                 (SELECT *
                  FROM DDWH01_DW_MA.TD_PRCO_PROD_ORD_COMP
                  WHERE PRCO_CD_PLANT_CD = P_ELT_CD_PLANT
                    AND PRCO_FL_COMP_CAT ='L'
                    AND PRCO_FL_LOGICAL_STATUS = '1' ) ,
                 (SELECT *
                  FROM DDWH02_DM_MA.TDIM_MTRL_MATERIAL,
                       DDWH01_DW_MA.TM_PLNT_PLANT
                  WHERE MTRL_CD_PLANT_CD = P_ELT_CD_PLANT
                    AND MTRL_CD_PLANT_CD= PLNT_CD_PLANT_CD
                    AND MTRL_CD_LANGUAGE = PLNT_CD_LANG_M )
               WHERE 1=1
                 AND PROP_FL_CLOSE_MARK=0
                 AND PROP_DT_SCHED_END_OP_DT < = TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD')
                 AND PROP_ID_PROD_ORD_OP = PRCO_ID_PROP_PROD_ORD_OP (+)
                 AND PRCO_ID_MAMD_COMP = MTRL_ID_MTRL_MATERIAL (+)
               GROUP BY PROP_CD_PLANT_CD,
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
                        PROP_CD_SOURCE_SYSTEM) ,
              (SELECT *
               FROM
                 (SELECT PROP_CD_PROD_ORD AS MIN_ORD,
                         MIN (PROP_CD_OP) KEEP (DENSE_RANK FIRST
                                                ORDER BY PROP_CD_OP) OVER (PARTITION BY PROP_CD_PLANT_CD,
                                                                                        PROP_CD_PROD_ORD) AS MIN_OP,
                                                                          MIN (PROP_CD_WCTR_CD) KEEP (DENSE_RANK FIRST
                                                                                                      ORDER BY PROP_CD_OP) OVER (PARTITION BY PROP_CD_PLANT_CD,
                                                                                                                                              PROP_CD_PROD_ORD) AS MIN_WCTR,
                                                                                                                                ROW_NUMBER () OVER (PARTITION BY PROP_CD_PLANT_CD,
                                                                                                                                                                 PROP_CD_PROD_ORD
                                                                                                                                                    ORDER BY PROP_CD_OP DESC) AS NUM_OCC
                  FROM
                    (SELECT *
                     FROM DDWH01_DW_MA.TD_PROP_PROD_ORD_OP
                     WHERE PROP_CD_PLANT_CD = P_ELT_CD_PLANT
                       AND PROP_FL_LOGICAL_STATUS = '1' ) PROP
                  WHERE 1=1
                    AND PROP_FL_CLOSE_MARK=0
                    AND PROP_DT_SCHED_END_OP_DT < TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD')
                    AND PROP_CD_CTRL_KEY = 'YPP2' )
               WHERE NUM_OCC = 1 ) PROP_MILESTONE ,
              (SELECT *
               FROM DDWH01_DW_MA.TT_PROR_PROD_ORD
               WHERE PROR_FL_CLOSE_MARK=0
                 AND PROR_CD_PLANT_CD = P_ELT_CD_PLANT
                 AND PROR_FL_LOGICAL_STATUS = '1'
                 AND NVL (PROR_CD_ORD_STU, '#') <> 'CLSD' ) ,
              (SELECT *
               FROM DDWH01_DW_MA.TM_PLMD_PLANT_MASTER
               WHERE PLMD_CD_PLANT_CD = P_ELT_CD_PLANT ) PLMD,

              (SELECT *
               FROM DDWH01_DW_MA.TM_PLMD_PLANT_MASTER
               WHERE PLMD_CD_PLANT_CD = P_ELT_CD_PLANT ) PLMD_PROP_MILESTONE,

              (SELECT *
               FROM DDWH01_DW_MA.TM_MBUD_MBU_MASTER
               WHERE MBUD_CD_PLANT_CD = P_ELT_CD_PLANT ) MBUD,

              (SELECT *
               FROM DDWH01_DW_MA.TM_MBUD_MBU_MASTER
               WHERE MBUD_CD_PLANT_CD = P_ELT_CD_PLANT ) MBUD_PROP_MILESTONE,

              (SELECT *
               FROM DDWH01_DW_MA.TD_OPPO_OP_PRIORITY_PROD_ORD,
                    DDWH02_DM_MA.TDIM_PRIO_PRIORITY
               WHERE 1=1
                 AND OPPO_CD_PLANT_CD = PRIO_CD_PLANT_CD (+)
                 AND TO_CHAR (OPPO_NR_OP_PRIORITY) = PRIO_CD_PRIORITY (+)
                 AND OPPO_CD_PLANT_CD = P_ELT_CD_PLANT ) TD_OPPO_OP_PRIORITY_PROD_ORD ,
              (SELECT *
               FROM DDWH01_DW_MA.TD_PLPP_PROC_LOT_PART_PROD
               WHERE PLPP_CD_PLANT_CD = P_ELT_CD_PLANT ) ,
              (SELECT POPL_CD_PROD_ORD,
                      MIN (POPL_CD_PROC_LOT) AS POPL_CD_PROC_LOT
               FROM DDWH01_DW_MA.TD_POPL_PROD_ORD_PROC_LOT
               WHERE POPL_FL_LOGICAL_STATUS = '1'
                 AND POPL_CD_PLANT_CD = P_ELT_CD_PLANT
               GROUP BY POPL_CD_PROD_ORD) POPL,

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
                 AND PROR_ID_PROD_ORD= PRPO_ID_PROR_CD_EFF_ORD ) TT_PRPO_PRIORITY_PROD_ORD
            WHERE PROR_CD_PLANT_CD = PROP_CD_PLANT_CD
              AND PROR_CD_PROD_ORD = PROP_CD_PROD_ORD
              AND PROP_CD_PROD_ORD = PROP_MILESTONE.MIN_ORD (+)
              AND PROP_CD_WCTR_CD = PLMD.PLMD_CD_WCTR_CD (+)
              AND PROP_CD_EFF_ORD = PRPO_CD_PROD_ORD (+)
              AND PROP_CD_EFF_ORD = POPL.POPL_CD_PROD_ORD (+)
              AND PLMD.PLMD_CD_DEP = MBUD.MBUD_CD_DEP_CD (+)
              AND PROP_MILESTONE.MIN_WCTR = PLMD_PROP_MILESTONE.PLMD_CD_WCTR_CD (+)
              AND PLMD_PROP_MILESTONE.PLMD_CD_DEP = MBUD_PROP_MILESTONE.MBUD_CD_DEP_CD (+)
              AND PROP_CD_EFF_ORD = OPPO_CD_PROD_ORD (+)
              AND PROP_CD_EFF_ORD = PLPP_CD_EFF_ORD (+)
              AND PROP_CD_OP = PLPP_CD_OP (+)
              AND PROP_CD_OP = OPPO_CD_OP (+) ))
      UNION ALL SELECT BKPM_CD_PLANT_CD,
                       BKPM_ID_TIME_SNAPSHOT,
                       BKPM_CD_PROD_ORD,
                       BKPM_CD_EFF_ORD,
                       BKPM_ID_MTRL_MATERIAL,
                       BKPM_CD_MATERIAL,
                       BKPM_UNRELEASED_MARK,
                       BKPM_ID_PRST_STATUS,
                       BKPM_CD_ORD_STATUS,
                       BKPM_CD_OP,
                       BKPM_CD_CTRL_KEY,
                       BKPM_ID_WCTR_CD,
                       BKPM_CD_WCTR_CD,
                       BKPM_DT_SCHED_STR_OP_DT,
                       BKPM_DT_SCHED_END_OP_DT,
                       BKPM_QT_STD_SET_TIME_PER_OP,
                       BKPM_QT_BASE_QTY,
                       BKPM_QT_REM_QTY,
                       BKPM_QT_REM_MAN_TIME,
                       BKPM_QT_REM_MACHINE_TIME,
                       BKPM_QT_REM_TOTAL_TIME,
                       BKPM_CD_BCKLG_TP_PARTSMAKING,
                       BKPM_CD_BCKLG_TP_PAINTING,
                       BKPM_ID_PRIO_PRIORITY,
                       BKPM_CD_OP_PRIORITY,
                       BKPM_CD_PROC_LOT,
                       BKPM_ID_TIME_SCHED_STR_ORD_DT,
                       BKPM_ID_TIME_SCHED_END_ORD_DT,
                       BKPM_FL_BACKLOG,
                       BKPM_QT_ORD_CONF_QTY,
                       BKPM_ID_BATCH_ID,
                       BKPM_CD_SOURCE_SYSTEM
      FROM
        (SELECT PLOP_CD_PLANT_CD AS BKPM_CD_PLANT_CD,
                BKPM_ID_TIME_SNAPSHOT AS BKPM_ID_TIME_SNAPSHOT,
                PLOR_CD_ORD_ID AS BKPM_CD_PROD_ORD,
                NULL AS BKPM_CD_EFF_ORD,
                PLOR_ID_MAMD_PART_NBR AS BKPM_ID_MTRL_MATERIAL,
                PLOR_CD_PART_NBR AS BKPM_CD_MATERIAL,
                1 BKPM_UNRELEASED_MARK,
                -2 AS BKPM_ID_PRST_STATUS,
                DDWH02_DM_MA.FUNC_NOT_APPLICABLE () AS BKPM_CD_ORD_STATUS,
                PLOP_CD_OP AS BKPM_CD_OP,
                PLOP_CD_CTRL_KEY AS BKPM_CD_CTRL_KEY,
                PLOP_ID_PLMD_WCTR_CD AS BKPM_ID_WCTR_CD,
                PLOP_CD_WCTR_CD AS BKPM_CD_WCTR_CD,
                PLOR_DT_STR_PROD_DT AS BKPM_DT_SCHED_STR_OP_DT,
                PLOR_DT_END_PROD_DT AS BKPM_DT_SCHED_END_OP_DT,
                PLOP_QT_STD_SET_TIME_PER_OP AS BKPM_QT_STD_SET_TIME_PER_OP,
                PLOP_QT_PLN_QTY AS BKPM_QT_BASE_QTY,
                BKPM_QT_REM_QTY,
                BKPM_QT_REM_MAN_TIME,
                BKPM_QT_REM_MACHINE_TIME,
                BKPM_QT_REM_TOTAL_TIME,
                CASE
                    WHEN UPPER (MBUD_CD_MBU_CD) NOT IN ('MBU4',
                                                        'MBU5') THEN 'UNRELEASED'
                    ELSE 'N/A'
                END AS BKPM_CD_BCKLG_TP_PARTSMAKING,
                CASE
                    WHEN UPPER (MBUD_CD_PROCESS) IN ('PAINTING') THEN 'UNRELEASED'
                    ELSE 'N/A'
                END AS BKPM_CD_BCKLG_TP_PAINTING,
                NVL (TD_PRIO_ID_PRIOR, TT_PRIO_ID_PRIOR) AS BKPM_ID_PRIO_PRIORITY,
                NVL (TD_PRIO_CD_PRIORITY, TT_PRIO_CD_PRIORITY) AS BKPM_CD_OP_PRIORITY,
                PLPP_CD_PROC_LOT AS BKPM_CD_PROC_LOT,
                NVL (TO_NUMBER (TO_CHAR (PLOR_DT_STR_PROD_DT, 'J')), -2) AS BKPM_ID_TIME_SCHED_STR_ORD_DT,
                NVL (TO_NUMBER (TO_CHAR (PLOR_DT_END_PROD_DT, 'J')), -2) AS BKPM_ID_TIME_SCHED_END_ORD_DT,
                '1' AS BKPM_FL_BACKLOG,
                0 AS BKPM_QT_ORD_CONF_QTY,
                NVL (P_ELT_ID_BATCH, N_ELT_ID_JOB_LOG) BKPM_ID_BATCH_ID,
                PLOP_CD_SOURCE_SYSTEM AS BKPM_CD_SOURCE_SYSTEM
         FROM
           (SELECT PLOP_CD_PLANT_CD,
                   TO_NUMBER (TO_CHAR (TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'), 'J')) BKPM_ID_TIME_SNAPSHOT,
                   PLOP_CD_OP,
                   PLOP_CD_CTRL_KEY,
                   PLOP_ID_PLMD_WCTR_CD,
                   PLOP_CD_WCTR_CD,
                   PLOR_DT_STR_PROD_DT,
                   PLOR_DT_END_PROD_DT,
                   PLOP_QT_STD_SET_TIME_PER_OP,
                   PLOP_QT_PLN_QTY,
                   ROUND (PLOP_QT_PLN_QTY, 7) BKPM_QT_REM_QTY,
                   ROUND (PLOP_QT_LABOR_VAL * PLOP_QT_PLN_QTY, 7) BKPM_QT_REM_MAN_TIME,
                   ROUND (PLOP_QT_WORKST_TIME * PLOP_QT_PLN_QTY, 7) BKPM_QT_REM_MACHINE_TIME,
                   ROUND ((PLOP_QT_LABOR_VAL + PLOP_QT_WORKST_TIME) * PLOP_QT_PLN_QTY, 7) BKPM_QT_REM_TOTAL_TIME,
                   PLOP_CD_SOURCE_SYSTEM,
                   PLOR_CD_ORD_ID,
                   PLOR_ID_MAMD_PART_NBR,
                   PLOR_CD_PART_NBR,
                   MBUD.MBUD_CD_PROCESS,
                   MBUD.MBUD_CD_MBU_CD,
                   PLPP_CD_PROC_LOT,
                   TD_OPPL_OP_PRIORITY_PLND_ORD.PRIO_ID_PRIOR AS TD_PRIO_ID_PRIOR,
                   TT_PRPL_PRIORITY_PLND_ORD.PRIO_ID_PRIOR AS TT_PRIO_ID_PRIOR,
                   TD_OPPL_OP_PRIORITY_PLND_ORD.PRIO_CD_PRIORITY AS TD_PRIO_CD_PRIORITY,
                   TT_PRPL_PRIORITY_PLND_ORD.PRIO_CD_PRIORITY AS TT_PRIO_CD_PRIORITY
            FROM
              (SELECT PLOP_CD_PLANT_CD,
                      PLOP_CD_ORD_ID,
                      PLOP_CD_OP,
                      PLOP_CD_CTRL_KEY,
                      PLOP_ID_PLMD_WCTR_CD,
                      PLOP_CD_WCTR_CD,
                      PLOP_DT_STR_PLN_OP_DT,
                      PLOP_DT_END_PLN_OP_DT,
                      PLOP_QT_STD_SET_TIME_PER_OP,
                      PLOP_QT_PLN_QTY,
                      PLOP_QT_LABOR_VAL,
                      PLOP_QT_WORKST_TIME,
                      PLOP_CD_SOURCE_SYSTEM
               FROM
                 (SELECT *
                  FROM DDWH01_DW_MA.TD_PLOP_PLND_ORD_OP
                  WHERE PLOP_CD_PLANT_CD = P_ELT_CD_PLANT ) PLOP
               WHERE 1=1 ) ,
              (SELECT *
               FROM DDWH01_DW_MA.TT_PLOR_PLND_ORD
               WHERE PLOR_CD_PLANT_CD = P_ELT_CD_PLANT
                 AND PLOR_DT_END_PROD_DT< TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') ) ,
              (SELECT *
               FROM DDWH01_DW_MA.TM_PLMD_PLANT_MASTER
               WHERE PLMD_CD_PLANT_CD = P_ELT_CD_PLANT ) PLMD,

              (SELECT *
               FROM DDWH01_DW_MA.TM_MBUD_MBU_MASTER
               WHERE MBUD_CD_PLANT_CD = P_ELT_CD_PLANT ) MBUD,

              (SELECT *
               FROM DDWH01_DW_MA.TD_OPPL_OP_PRIORITY_PLND_ORD,
                    DDWH02_DM_MA.TDIM_PRIO_PRIORITY
               WHERE 1=1
                 AND OPPL_CD_PLANT_CD = PRIO_CD_PLANT_CD (+)
                 AND TO_CHAR (OPPL_NR_OP_PRIORITY) = PRIO_CD_PRIORITY (+)
                 AND OPPL_CD_PLANT_CD = P_ELT_CD_PLANT ) TD_OPPL_OP_PRIORITY_PLND_ORD ,
              (SELECT *
               FROM DDWH01_DW_MA.TD_PLPP_PROC_LOT_PART_PROD
               WHERE PLPP_CD_PLANT_CD = P_ELT_CD_PLANT ) ,
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
                 AND PLOR_ID_PLND_ORD = PRPL_ID_PLOR_PLND_ORD ) TT_PRPL_PRIORITY_PLND_ORD
            WHERE 1=1
              AND PLOR_CD_ORD_ID = PLOP_CD_ORD_ID
              AND PLOP_CD_ORD_ID = PRPL_CD_PLND_ORD (+)
              AND PLOP_CD_WCTR_CD = PLMD.PLMD_CD_WCTR_CD (+)
              AND PLMD.PLMD_CD_DEP = MBUD.MBUD_CD_DEP_CD (+)
              AND PLOP_CD_ORD_ID = OPPL_CD_PLND_ORD (+)
              AND PLOP_CD_ORD_ID = PLPP_CD_EFF_ORD (+)
              AND PLOP_CD_OP = PLPP_CD_OP (+)
              AND PLOP_CD_OP = OPPL_CD_OP (+) )))) QRY