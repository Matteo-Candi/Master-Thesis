INSERT INTO DDWH02_DM_MA.TFCT_PFPM_PERFORMANCE_PM TRG (PFPM_CD_PLANT_CD, PFPM_ID_PFPM, PFPM_ID_TIME_SNAPSHOT, PFPM_CD_SAP_ORD, PFPM_CD_MES_ORD, PFPM_CD_OP, PFPM_CD_CTRL_KEY, PFPM_CD_ORD_MARKER, PFPM_ID_MTRL_PART_NBR, PFPM_CD_PART_NBR, PFPM_ID_TIME_SCHED_STR_OP_DT, PFPM_ID_TIME_SCHED_END_OP_DT, PFPM_ID_PLST, PFPM_CD_WCTR_CD, PFPM_ID_ORTP_ORD_TP, PFPM_CD_ORD_TP, PFPM_ID_VEHI_VAN, PFPM_CD_VAN, PFPM_ID_PRIO_PRIORITY, PFPM_CD_OP_PRIORITY, PFPM_QT_ORD_QTY, PFPM_QT_REM_QTY, PFPM_ID_MTRL_COMP, PFPM_CD_COMP, PFPM_QT_COMP_QTY, PFPM_QT_REM_CONSUM, PFPM_ID_VEND, PFPM_CD_SUPPL_CD, PFPM_ID_TIME_CONFIRM_DT, PFPM_DT_CONFIRM_DT, PFPM_FL_CLOSE_MARK, PFPM_ID_BATCH_ID, PFPM_CD_SOURCE_SYSTEM, PFPM_CD_OPERATOR_CODE, PFPM_DT_INS_ROW, PFPM_DT_UPD_ROW, PFPM_ID_PLST_USED_WCTR, PFPM_CD_USED_WCTR_CD)
SELECT QRY.PFPM_CD_PLANT_CD,
       DDWH02_DM_MA.SEQ_PFPM_TFCT01.NEXTVAL,
       QRY.PFPM_ID_TIME_SNAPSHOT,
       QRY.PFPM_CD_SAP_ORD,
       QRY.PFPM_CD_MES_ORD,
       QRY.PFPM_CD_OP,
       QRY.PFPM_CD_CTRL_KEY,
       QRY.PFPM_CD_ORD_MARKER,
       QRY.PFPM_ID_MTRL_PART_NBR,
       QRY.PFPM_CD_PART_NBR,
       QRY.PFPM_ID_TIME_SCHED_STR_OP_DT,
       QRY.PFPM_ID_TIME_SCHED_END_OP_DT,
       QRY.PFPM_ID_PLST,
       QRY.PFPM_CD_WCTR_CD,
       QRY.PFPM_ID_ORTP_ORD_TP,
       QRY.PFPM_CD_ORD_TP,
       QRY.PFPM_ID_VEHI_VAN,
       QRY.PFPM_CD_VAN,
       QRY.PFPM_ID_PRIO_PRIORITY,
       QRY.PFPM_CD_OP_PRIORITY,
       QRY.PFPM_QT_ORD_QTY,
       QRY.PFPM_QT_REM_QTY,
       QRY.PFPM_ID_MTRL_COMP,
       QRY.PFPM_CD_COMP,
       QRY.PFPM_QT_COMP_QTY,
       QRY.PFPM_QT_REM_CONSUM,
       QRY.PFPM_ID_VEND,
       QRY.PFPM_CD_SUPPL_CD,
       QRY.PFPM_ID_TIME_CONFIRM_DT,
       QRY.PFPM_DT_CONFIRM_DT,
       QRY.PFPM_FL_CLOSE_MARK,
       QRY.PFPM_ID_BATCH_ID,
       QRY.PFPM_CD_SOURCE_SYSTEM,
       'ETL',
       SYSDATE,
       SYSDATE,
       QRY.PFPM_ID_PLST_USED_WCTR,
       QRY.PFPM_CD_USED_WCTR_CD
FROM
  (SELECT PFPM_CD_PLANT_CD,
          NULL PFPM_ID_PFPM,
               PFPM_ID_TIME_SNAPSHOT,
               PFPM_CD_SAP_ORD,
               PFPM_CD_MES_ORD,
               PFPM_CD_OP,
               PFPM_CD_CTRL_KEY,
               PFPM_CD_ORD_MARKER,
               NVL (PFPM_ID_MTRL_PART_NBR, -2) AS PFPM_ID_MTRL_PART_NBR,
               PFPM_CD_PART_NBR,
               PFPM_ID_TIME_SCHED_STR_OP_DT,
               PFPM_ID_TIME_SCHED_END_OP_DT,
               PFPM_ID_PLST,
               PFPM_CD_WCTR_CD,
               NVL (PFPM_ID_ORTP_ORD_TP, -2) AS PFPM_ID_ORTP_ORD_TP,
               PFPM_CD_ORD_TP,
               NVL (PFPM_ID_VEHI_VAN, -2) AS PFPM_ID_VEHI_VAN,
               PFPM_CD_VAN,
               NVL (PFPM_ID_PRIO_PRIORITY, -2) AS PFPM_ID_PRIO_PRIORITY,
               PFPM_CD_OP_PRIORITY,
               PFPM_QT_ORD_QTY,
               PFPM_QT_REM_QTY,
               NVL (PFPM_ID_MTRL_COMP, -2) AS PFPM_ID_MTRL_COMP,
               PFPM_CD_COMP,
               PFPM_QT_COMP_QTY,
               PFPM_QT_REM_CONSUM,
               NVL (PFPM_ID_VEND, -2) AS PFPM_ID_VEND,
               PFPM_CD_SUPPL_CD,
               NVL (PFPM_ID_TIME_CONFIRM_DT, -2) AS PFPM_ID_TIME_CONFIRM_DT,
               PFPM_DT_CONFIRM_DT,
               PFPM_FL_CLOSE_MARK,
               NVL (P_ELT_ID_BATCH, N_ELT_ID_JOB_LOG) AS PFPM_ID_BATCH_ID,
               PFPM_CD_SOURCE_SYSTEM,
               PFPM_ID_PLST_USED_WCTR,
               PFPM_CD_USED_WCTR_CD
   FROM
     (SELECT PROP_CD_PLANT_CD AS PFPM_CD_PLANT_CD,
             TO_NUMBER (TO_CHAR (TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'), 'J')) AS PFPM_ID_TIME_SNAPSHOT,
             PROP_CD_PROD_ORD AS PFPM_CD_SAP_ORD,
             PROP_CD_EFF_ORD AS PFPM_CD_MES_ORD,
             PROP_CD_OP AS PFPM_CD_OP,
             PROP_CD_CTRL_KEY AS PFPM_CD_CTRL_KEY,
             'PROD' AS PFPM_CD_ORD_MARKER,
             PROR_ID_MAMD_PART_NBR AS PFPM_ID_MTRL_PART_NBR,
             PROR_CD_PART_NBR AS PFPM_CD_PART_NBR,
             TO_NUMBER (TO_CHAR (PROP_DT_SCHED_STR_OP_DT, 'J')) AS PFPM_ID_TIME_SCHED_STR_OP_DT,
             TO_NUMBER (TO_CHAR (PROP_DT_SCHED_END_OP_DT, 'J')) AS PFPM_ID_TIME_SCHED_END_OP_DT,
             PROP_ID_PLMD_WCTR_CD AS PFPM_ID_PLST,
             PROP_CD_WCTR_CD AS PFPM_CD_WCTR_CD,
             PROR_ID_ORTP_ORD_TP AS PFPM_ID_ORTP_ORD_TP,
             PROR_CD_ORD_TP AS PFPM_CD_ORD_TP,
             PROR_ID_VHMD_VAN AS PFPM_ID_VEHI_VAN,
             PROR_CD_VAN AS PFPM_CD_VAN,
             NVL (TD_OPPO_OP_PRIORITY_PROD_ORD.PRIO_ID_PRIOR, TT_PRPO_PRIORITY_PROD_ORD.PRIO_ID_PRIOR) AS PFPM_ID_PRIO_PRIORITY,
             NVL (TD_OPPO_OP_PRIORITY_PROD_ORD.PRIO_CD_PRIORITY, TT_PRPO_PRIORITY_PROD_ORD.PRIO_CD_PRIORITY) AS PFPM_CD_OP_PRIORITY,
             PROP_QT_BASE_QTY AS PFPM_QT_ORD_QTY,
             PROP_QT_BASE_QTY - NVL (PROP_QT_CONFIRM_QTY, 0) AS PFPM_QT_REM_QTY,
             PRCO.PRCO_ID_MAMD_COMP AS PFPM_ID_MTRL_COMP,
             PRCO.PRCO_CD_COMP AS PFPM_CD_COMP,
             PRCO.PRCO_QT_QTY AS PFPM_QT_COMP_QTY,
             ROUND ((PRCO.PRCO_QT_QTY /PROP_QT_BASE_QTY) * (PROP_QT_BASE_QTY - NVL (PROP_QT_CONFIRM_QTY, 0)), 7) AS PFPM_QT_REM_CONSUM,
             TO_NUMBER (TO_CHAR (PROP_DT_CONFIRM_DT, 'J')) AS PFPM_ID_TIME_CONFIRM_DT,
             PROP_DT_CONFIRM_DT AS PFPM_DT_CONFIRM_DT,
             PROP_FL_CLOSE_MARK AS PFPM_FL_CLOSE_MARK,
             PROR_CD_SOURCE_SYSTEM AS PFPM_CD_SOURCE_SYSTEM,
             NVL (TD_ADOP_ACT_DECL_OP.ADOP_ID_PLMD_ACT_WCTR_CD, -2) AS PFPM_ID_PLST_USED_WCTR,
             TD_ADOP_ACT_DECL_OP.ADOP_CD_ACT_WCTR_CD AS PFPM_CD_USED_WCTR_CD
      FROM
        (SELECT *
         FROM DDWH01_DW_MA.TT_PROR_PROD_ORD
         WHERE PROR_CD_PLANT_CD = P_ELT_CD_PLANT
           AND PROR_FL_LOGICAL_STATUS ='1' ) ,
        (SELECT *
         FROM DDWH01_DW_MA.TD_PROP_PROD_ORD_OP
         WHERE PROP_CD_PLANT_CD = P_ELT_CD_PLANT
           AND PROP_FL_LOGICAL_STATUS ='1' ) ,
        (SELECT PRCO_CD_PLANT_CD,
                PRCO_ID_PROP_PROD_ORD_OP,
                PRCO_ID_MAMD_COMP,
                PRCO_CD_COMP,
                PRCO_QT_QTY
         FROM DDWH01_DW_MA.TD_PRCO_PROD_ORD_COMP
         WHERE 1=1
           AND PRCO_CD_PLANT_CD = P_ELT_CD_PLANT
           AND PRCO_FL_COMP_CAT = 'L'
           AND PRCO_FL_LOGICAL_STATUS ='1' ) PRCO,

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
              AND PROR_CD_ORD_TP <> 'Y901'
              AND PROR_FL_LOGICAL_STATUS ='1' )
         WHERE 1=1
           AND PRPO_CD_PLANT_CD = PRIO_CD_PLANT_CD (+)
           AND TO_CHAR (PRPO_NR_ORD_PRIORITY) = PRIO_CD_PRIORITY (+)
           AND PRPO_CD_PLANT_CD = P_ELT_CD_PLANT
           AND PROR_ID_PROD_ORD= PRPO_ID_PROR_CD_EFF_ORD ) TT_PRPO_PRIORITY_PROD_ORD,

        (SELECT *
         FROM DDWH01_DW_MA.TM_PLMD_PLANT_MASTER
         WHERE 1=1
           AND PLMD_CD_PLANT_CD = P_ELT_CD_PLANT ) TM_PLMD_PLANT_MASTER,

        (SELECT *
         FROM DDWH01_DW_MA.TM_MBUD_MBU_MASTER
         WHERE 1=1
           AND MBUD_CD_PLANT_CD = P_ELT_CD_PLANT
           AND UPPER (MBUD_CD_MBU_CD) NOT IN ('MBU4',
                                              'MBU5') ) TM_MBUD_MBU_MASTER,

        (SELECT *
         FROM DDWH01_DW_MA.TD_ADOP_ACT_DECL_OP
         WHERE 1=1
           AND ADOP_FL_LOGICAL_DELETION = 0
           AND ADOP_CD_PLANT_CD = P_ELT_CD_PLANT ) TD_ADOP_ACT_DECL_OP
      WHERE 1=1
        AND PROR_CD_PLANT_CD = PROP_CD_PLANT_CD
        AND PROR_ID_PROD_ORD = PROP_ID_PROR_PROD_ORD
        AND PROP_CD_PLANT_CD = PRCO.PRCO_CD_PLANT_CD (+)
        AND PROP_ID_PROD_ORD_OP = PRCO.PRCO_ID_PROP_PROD_ORD_OP (+)
        AND PROP_CD_PLANT_CD = TD_OPPO_OP_PRIORITY_PROD_ORD.OPPO_CD_PLANT_CD (+)
        AND PROP_CD_EFF_ORD = TD_OPPO_OP_PRIORITY_PROD_ORD.OPPO_CD_PROD_ORD (+)
        AND PROP_CD_OP = TD_OPPO_OP_PRIORITY_PROD_ORD.OPPO_CD_OP (+)
        AND PROP_CD_PLANT_CD = TT_PRPO_PRIORITY_PROD_ORD.PRPO_CD_PLANT_CD (+)
        AND PROP_CD_EFF_ORD = TT_PRPO_PRIORITY_PROD_ORD.PRPO_CD_PROD_ORD (+)
        AND PROP_ID_PROD_ORD_OP = TD_ADOP_ACT_DECL_OP.ADOP_ID_PROP_PROD_ORD_OP (+)
        AND PROP_ID_PLMD_WCTR_CD = TM_PLMD_PLANT_MASTER.PLMD_ID_PLANT_MASTER
        AND TM_PLMD_PLANT_MASTER.PLMD_CD_DEP = TM_MBUD_MBU_MASTER.MBUD_CD_DEP_CD
        AND PROR_CD_PLANT_CD = P_ELT_CD_PLANT
        AND ((PROR_FL_CLOSE_MARK = '0'
              AND (PROP_FL_CLOSE_MARK = '0'
                   OR (PROP_FL_CLOSE_MARK = '1'
                       AND PROP_DT_CONFIRM_DT = TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'))))
             OR (PROR_FL_CLOSE_MARK = '1'
                 AND (PROP_FL_CLOSE_MARK = '1'
                      AND PROP_DT_CONFIRM_DT = TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'))))
        AND PROP_CD_CTRL_KEY <> 'YPP1'
      UNION SELECT PLOP_CD_PLANT_CD AS PFPM_CD_PLANT_CD,
                   TO_NUMBER (TO_CHAR (TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD'), 'J')) AS PFPM_ID_TIME_SNAPSHOT,
                   PLOP_CD_ORD_ID AS PFPM_CD_SAP_ORD,
                   NULL AS PFPM_CD_MES_ORD,
                   PLOP_CD_OP AS PFPM_CD_OP,
                   PLOP_CD_CTRL_KEY AS PFPM_CD_CTRL_KEY,
                   'PLND' AS PFPM_CD_ORD_MARKER,
                   PLOR_ID_MAMD_PART_NBR AS PFPM_ID_MTRL_PART_NBR,
                   PLOR_CD_PART_NBR AS PFPM_CD_PART_NBR,
                   TO_NUMBER (TO_CHAR (PLOR_DT_STR_PROD_DT, 'J')) AS PFPM_ID_TIME_SCHED_STR_OP_DT,
                   TO_NUMBER (TO_CHAR (PLOR_DT_END_PROD_DT, 'J')) AS PFPM_ID_TIME_SCHED_END_OP_DT,
                   PLOP_ID_PLMD_WCTR_CD AS PFPM_ID_PLST,
                   PLOP_CD_WCTR_CD AS PFPM_CD_WCTR_CD,
                   PLOR_ID_ORTP_ORD_TP AS PFPM_ID_ORTP_ORD_TP,
                   PLOR_CD_ORD_TP AS PFPM_CD_ORD_TP,
                   PLOR_ID_VHMD_VAN AS PFPM_ID_VEHI_VAN,
                   PLOR_CD_VAN AS PFPM_CD_VAN,
                   NVL (TD_OPPL_OP_PRIORITY_PLND_ORD.PRIO_ID_PRIOR, TT_PRPL_PRIORITY_PLND_ORD.PRIO_ID_PRIOR) AS PFPM_ID_PRIO_PRIORITY,
                   NVL (TD_OPPL_OP_PRIORITY_PLND_ORD.PRIO_CD_PRIORITY, TT_PRPL_PRIORITY_PLND_ORD.PRIO_CD_PRIORITY) AS PFPM_CD_OP_PRIORITY,
                   PLOP_QT_PLN_QTY AS PFPM_QT_ORD_QTY,
                   PLOP_QT_PLN_QTY AS PFPM_QT_REM_QTY,
                   PLCO.PLCO_ID_MAMD_COMP AS PFPM_ID_MTRL_COMP,
                   PLCO.PLCO_CD_COMP AS PFPM_CD_COMP,
                   PLCO.PLCO_QT_QTY AS PFPM_QT_COMP_QTY,
                   PLCO.PLCO_QT_QTY AS PFPM_QT_REM_CONSUM,
                   NULL AS PFPM_ID_TIME_CONFIRM_DT,
                   NULL AS PFPM_DT_CONFIRM_DT,
                   NULL AS PFPM_FL_CLOSE_MARK,
                   PLOR_CD_SOURCE_SYSTEM AS PFPM_CD_SOURCE_SYSTEM,
                   -2 AS PFPM_ID_PLST_USED_WCTR,
                   NULL AS PFPM_CD_USED_WCTR_CD
      FROM DDWH01_DW_MA.TT_PLOR_PLND_ORD,
           DDWH01_DW_MA.TD_PLOP_PLND_ORD_OP,

        (SELECT PLCO_CD_PLANT_CD,
                PLCO_ID_PLOP_PLND_ORD_OP,
                PLCO_ID_MAMD_COMP,
                PLCO_CD_COMP,
                PLCO_QT_QTY
         FROM DDWH01_DW_MA.TD_PLCO_PLND_ORD_COMP
         WHERE 1=1
           AND PLCO_CD_PLANT_CD = P_ELT_CD_PLANT
           AND PLCO_FL_COMP_CAT = 'L' ) PLCO,

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

        (SELECT *
         FROM DDWH01_DW_MA.TM_PLMD_PLANT_MASTER
         WHERE 1=1
           AND PLMD_CD_PLANT_CD = P_ELT_CD_PLANT ) TM_PLMD_PLANT_MASTER,

        (SELECT *
         FROM DDWH01_DW_MA.TM_MBUD_MBU_MASTER
         WHERE 1=1
           AND MBUD_CD_PLANT_CD = P_ELT_CD_PLANT
           AND UPPER (MBUD_CD_MBU_CD) NOT IN ('MBU4',
                                              'MBU5') ) TM_MBUD_MBU_MASTER
      WHERE 1=1
        AND PLOR_CD_PLANT_CD = PLOP_CD_PLANT_CD
        AND PLOR_ID_PLND_ORD = PLOP_ID_PLOR_PLND_ORD
        AND PLOP_CD_PLANT_CD = PLCO.PLCO_CD_PLANT_CD (+)
        AND PLOP_ID_PLND_ORD_OP = PLCO.PLCO_ID_PLOP_PLND_ORD_OP (+)
        AND PLOP_CD_PLANT_CD = OPPL_CD_PLANT_CD (+)
        AND PLOP_CD_ORD_ID = OPPL_CD_PLND_ORD (+)
        AND PLOP_CD_OP = OPPL_CD_OP (+)
        AND PLOP_CD_PLANT_CD = PRPL_CD_PLANT_CD (+)
        AND PLOP_CD_ORD_ID = PRPL_CD_PLND_ORD (+)
        AND PLOP_ID_PLMD_WCTR_CD = TM_PLMD_PLANT_MASTER.PLMD_ID_PLANT_MASTER
        AND TM_PLMD_PLANT_MASTER.PLMD_CD_DEP = TM_MBUD_MBU_MASTER.MBUD_CD_DEP_CD
        AND PLOR_DT_END_PROD_DT <= TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') +90
        AND PLOR_CD_PLANT_CD = P_ELT_CD_PLANT
        AND PLOP_CD_CTRL_KEY <> 'YPP1' ) TFCT_PFPM_PERFORMANCE_PM,

     (SELECT ROW_NUMBER () OVER (PARTITION BY POLN_CD_PART_NBR
                                 ORDER BY SCLN_DT_REQ_DLVR_DT,
                                          SCLN_CD_PURCH_ORD_NBR,
                                          SCLN_CD_PURCH_ORD_LN,
                                          SCLN_CD_SEQ_ID) AS PURCHASING_ROW_NUM,
                                POLN_CD_PART_NBR,
                                PORD_ID_VEND_SUPPL_CD AS PFPM_ID_VEND,
                                PORD_CD_SUPPL_CD AS PFPM_CD_SUPPL_CD
      FROM DDWH01_DW_MA.TT_PORD_PURCH_ORD,
           DDWH01_DW_MA.TD_POLN_PURCH_ORD_LN,
           DDWH01_DW_MA.TD_SCLN_SCHED_LN
      WHERE 1=1
        AND PORD_CD_PLANT_CD = P_ELT_CD_PLANT
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
     AND TFCT_PFPM_PERFORMANCE_PM.PFPM_CD_COMP = PURCHASING_COMP.POLN_CD_PART_NBR (+) ) QRY