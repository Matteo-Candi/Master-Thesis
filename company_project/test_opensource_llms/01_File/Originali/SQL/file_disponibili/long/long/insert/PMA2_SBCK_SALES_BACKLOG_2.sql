INSERT INTO DDWH02_DM_MA.TFCT_SBCK_SALES_BACKLOG TRG (SBCK_CD_PLANT_CD, SBCK_ID_SBCK, SBCK_CD_SALE_ORD_NBR, SBCK_CD_SALE_ORD_LN, SBCK_ID_MTRL_MATERIAL, SBCK_CD_MATERIAL, SBCK_ID_CUST_SHIP_CUST_CD, SBCK_CD_SHIP_CUST_CD, SBCK_ID_REQU_REQUIREMENT, SBCK_CD_REQUIREMENT, SBCK_QT_BACKLOG_QTY, SBCK_QT_CUM_REQUESTED_QTY, SBCK_QT_CUM_SHIPPED_QTY, SBCK_QT_CUM_SHIPPED_QTY_CLICK, SBCK_QT_FUTURE_REQ_QTY, SBCK_QT_TOT_REQUIRED_QTY, SBCK_QT_REQUIRED_QTY, SBCK_QT_REQUIRED_QTY_W1, SBCK_QT_REQUIRED_QTY_W2, SBCK_QT_REQUIRED_QTY_W3, SBCK_QT_REQUIRED_QTY_W4, SBCK_FL_CRITICAL_PART, SBCK_ID_BATCH_ID, SBCK_CD_OPERATOR_CODE, SBCK_CD_SOURCE_SYSTEM, SBCK_DT_INS_ROW, SBCK_DT_UPD_ROW)
SELECT QRY.SBCK_CD_PLANT_CD,
       DDWH02_DM_MA.SEQ_SBCK_TFCT01.NEXTVAL,
       QRY.SBCK_CD_SALE_ORD_NBR,
       QRY.SBCK_CD_SALE_ORD_LN,
       QRY.SBCK_ID_MTRL_MATERIAL,
       QRY.SBCK_CD_MATERIAL,
       QRY.SBCK_ID_CUST_SHIP_CUST_CD,
       QRY.SBCK_CD_SHIP_CUST_CD,
       QRY.SBCK_ID_REQU_REQUIREMENT,
       QRY.SBCK_CD_REQUIREMENT,
       QRY.SBCK_QT_BACKLOG_QTY,
       QRY.SBCK_QT_CUM_REQUESTED_QTY,
       QRY.SBCK_QT_CUM_SHIPPED_QTY,
       QRY.SBCK_QT_CUM_SHIPPED_QTY_CLICK,
       QRY.SBCK_QT_FUTURE_REQ_QTY,
       QRY.SBCK_QT_TOT_REQUIRED_QTY,
       QRY.SBCK_QT_REQUIRED_QTY,
       QRY.SBCK_QT_REQUIRED_QTY_W1,
       QRY.SBCK_QT_REQUIRED_QTY_W2,
       QRY.SBCK_QT_REQUIRED_QTY_W3,
       QRY.SBCK_QT_REQUIRED_QTY_W4,
       QRY.SBCK_FL_CRITICAL_PART,
       QRY.SBCK_ID_BATCH_ID,
       'ETL',
       QRY.SBCK_CD_SOURCE_SYSTEM,
       SYSDATE,
       SYSDATE
FROM
  (WITH ELAB_TIME AS
     (SELECT TIME_DS_YEAR_WEEK
      FROM DDWH02_DM_MA.TDIM_TIME_TIME
      WHERE TIME_DT_DAY =TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') ) SELECT SBCK_CD_PLANT_CD,
                                                                               NULL SBCK_ID_SBCK,
                                                                                    SBCK_CD_SALE_ORD_NBR,
                                                                                    SBCK_CD_SALE_ORD_LN,
                                                                                    SBCK_ID_MTRL_MATERIAL,
                                                                                    SBCK_CD_MATERIAL,
                                                                                    SBCK_ID_CUST_SHIP_CUST_CD,
                                                                                    SBCK_CD_SHIP_CUST_CD,
                                                                                    SBCK_ID_REQU_REQUIREMENT,
                                                                                    SBCK_CD_REQUIREMENT,
                                                                                    SBCK_QT_BACKLOG_QTY,
                                                                                    SBCK_QT_CUM_REQUESTED_QTY,
                                                                                    SBCK_QT_CUM_SHIPPED_QTY,
                                                                                    SBCK_QT_CUM_SHIPPED_QTY_CLICK,
                                                                                    SBCK_QT_FUTURE_REQ_QTY,
                                                                                    SBCK_QT_TOT_REQUIRED_QTY,
                                                                                    SBCK_QT_REQUIRED_QTY,
                                                                                    SBCK_QT_REQUIRED_QTY_W1,
                                                                                    SBCK_QT_REQUIRED_QTY_W2,
                                                                                    SBCK_QT_REQUIRED_QTY_W3,
                                                                                    SBCK_QT_REQUIRED_QTY_W4,
                                                                                    SBCK_FL_CRITICAL_PART,
                                                                                    NVL (P_ELT_ID_BATCH, N_ELT_ID_JOB_LOG) AS SBCK_ID_BATCH_ID,
                                                                                    SBCK_CD_SOURCE_SYSTEM
   FROM
     (SELECT OPIR_CD_PLANT_CD AS SBCK_CD_PLANT_CD,
             OPIR_CD_SALE_ORD_NBR AS SBCK_CD_SALE_ORD_NBR,
             OPIR_CD_SALE_ORD_LN AS SBCK_CD_SALE_ORD_LN,
             OPIR_ID_MAMD_PART_NBR AS SBCK_ID_MTRL_MATERIAL,
             OPIR_CD_PART_NBR AS SBCK_CD_MATERIAL,
             SORS_ID_CUST_SHIP_CUST_CD AS SBCK_ID_CUST_SHIP_CUST_CD,
             SORS_CD_SHIP_CUST_CD AS SBCK_CD_SHIP_CUST_CD,
             OPIR_ID_IRCA_IND_REQ_CAT AS SBCK_ID_REQU_REQUIREMENT,
             OPIR_CD_IND_REQ_CAT AS SBCK_CD_REQUIREMENT,
             SBCK_QT_BACKLOG_QTY,
             NVL (COIS_QT_DLVR_QTY, 0) + SBCK_QT_BACKLOG_QTY + OPIR_QT_REQ_QTY_W0 AS SBCK_QT_CUM_REQUESTED_QTY,
             NVL (COIS_QT_DLVR_QTY, 0) AS SBCK_QT_CUM_SHIPPED_QTY,
             NVL (WHMR_QT_SHIPP_QTY, 0) AS SBCK_QT_CUM_SHIPPED_QTY_CLICK,
             SBCK_QT_FUTURE_REQ_QTY,
             NVL (COIS_QT_DLVR_QTY, 0) + SBCK_QT_BACKLOG_QTY + SBCK_QT_FUTURE_REQ_QTY AS SBCK_QT_TOT_REQUIRED_QTY,
             OPIR_QT_REQ_QTY_W0 AS SBCK_QT_REQUIRED_QTY,
             OPIR_QT_REQ_QTY_W1 AS SBCK_QT_REQUIRED_QTY_W1,
             OPIR_QT_REQ_QTY_W2 AS SBCK_QT_REQUIRED_QTY_W2,
             OPIR_QT_REQ_QTY_W3 AS SBCK_QT_REQUIRED_QTY_W3,
             OPIR_QT_REQ_QTY_W4 AS SBCK_QT_REQUIRED_QTY_W4,
             CASE
                 WHEN CRMA_CD_PART_NBR IS NULL THEN 0
                 ELSE 1
             END AS SBCK_FL_CRITICAL_PART,
             OPIR_CD_SOURCE_SYSTEM AS SBCK_CD_SOURCE_SYSTEM
      FROM
        (SELECT KEY.OPIR_CD_PLANT_CD,
                KEY.OPIR_CD_SALE_ORD_NBR,
                KEY.OPIR_CD_SALE_ORD_LN,
                KEY.OPIR_ID_MAMD_PART_NBR,
                KEY.OPIR_CD_PART_NBR,
                KEY.SORS_ID_CUST_SHIP_CUST_CD,
                KEY.SORS_CD_SHIP_CUST_CD,
                KEY.OPIR_ID_IRCA_IND_REQ_CAT,
                KEY.OPIR_CD_IND_REQ_CAT,
                NVL (KEY.SBCK_QT_BACKLOG_QTY, 0) SBCK_QT_BACKLOG_QTY,
                NVL (KEY.SBCK_QT_FUTURE_REQ_QTY, 0) AS SBCK_QT_FUTURE_REQ_QTY,
                NVL (WEEK_0.OPIR_QT_REM_QTY, 0) AS OPIR_QT_REQ_QTY_W0,
                NVL (WEEK_1.OPIR_QT_REM_QTY, 0) AS OPIR_QT_REQ_QTY_W1,
                NVL (WEEK_2.OPIR_QT_REM_QTY, 0) AS OPIR_QT_REQ_QTY_W2,
                NVL (WEEK_3.OPIR_QT_REM_QTY, 0) AS OPIR_QT_REQ_QTY_W3,
                NVL (WEEK_4.OPIR_QT_REM_QTY, 0) AS OPIR_QT_REQ_QTY_W4,
                NVL (CUMULATIVE.OPIR_QT_REQ_QTY, 0) AS OPIR_QT_REQ_QTY,
                KEY.OPIR_CD_SOURCE_SYSTEM
         FROM
           (SELECT OPIR_CD_PLANT_CD,
                   OPIR_CD_SALE_ORD_NBR,
                   OPIR_CD_SALE_ORD_LN,
                   OPIR_ID_MAMD_PART_NBR,
                   OPIR_CD_PART_NBR,
                   SORS_ID_CUST_SHIP_CUST_CD,
                   SORS_CD_SHIP_CUST_CD,
                   OPIR_ID_IRCA_IND_REQ_CAT,
                   OPIR_CD_IND_REQ_CAT,
                   SBCK_QT_BACKLOG_QTY,
                   SBCK_QT_FUTURE_REQ_QTY,
                   OPIR_CD_SOURCE_SYSTEM
            FROM
              (SELECT ROW_NUMBER () OVER (PARTITION BY OPIR_CD_SALE_ORD_NBR,
                                                       OPIR_CD_SALE_ORD_LN
                                          ORDER BY OPIR_DT_REQ_DT,
                                                   SORS_CD_SCHED_LN_ID) AS COUNTER,
                                         OPIR_CD_PLANT_CD,
                                         OPIR_CD_SALE_ORD_NBR,
                                         OPIR_CD_SALE_ORD_LN,
                                         OPIR_ID_MAMD_PART_NBR,
                                         OPIR_CD_PART_NBR,
                                         SORS_ID_CUST_SHIP_CUST_CD,
                                         SORS_CD_SHIP_CUST_CD,
                                         OPIR_ID_IRCA_IND_REQ_CAT,
                                         OPIR_CD_IND_REQ_CAT,
                                         SUM (CASE
                                                  WHEN REQ_TIME.TIME_DS_YEAR_WEEK < ELAB_TIME.TIME_DS_YEAR_WEEK THEN OPIR_QT_REM_QTY
                                                  ELSE 0
                                              END) KEEP (DENSE_RANK FIRST
                                                         ORDER BY SORS_ID_SALE_ORD_SCHED) OVER (PARTITION BY OPIR_CD_SALE_ORD_NBR,
                                                                                                             OPIR_CD_SALE_ORD_LN) AS SBCK_QT_BACKLOG_QTY,
                                                                                               SUM (CASE
                                                                                                        WHEN REQ_TIME.TIME_DS_YEAR_WEEK > ELAB_TIME.TIME_DS_YEAR_WEEK THEN OPIR_QT_REM_QTY
                                                                                                        ELSE 0
                                                                                                    END) KEEP (DENSE_RANK FIRST
                                                                                                               ORDER BY SORS_ID_SALE_ORD_SCHED) OVER (PARTITION BY OPIR_CD_SALE_ORD_NBR,
                                                                                                                                                                   OPIR_CD_SALE_ORD_LN) AS SBCK_QT_FUTURE_REQ_QTY,
                                                                                                                                                     OPIR_CD_SOURCE_SYSTEM
               FROM DDWH01_DW_MA.TT_OPIR_OPEN_IND_REQ,
                    DDWH01_DW_MA.TD_SORS_SALE_ORD_SCHED,
                    ELAB_TIME,
                    DDWH02_DM_MA.TDIM_TIME_TIME REQ_TIME
               WHERE OPIR_CD_PLANT_CD = P_ELT_CD_PLANT
                 AND SORS_CD_PLANT_CD = P_ELT_CD_PLANT
                 AND OPIR_CD_SALE_ORD_NBR = SORS_CD_SALE_ORD_NBR
                 AND OPIR_CD_SALE_ORD_LN = SORS_CD_SALE_ORD_LN
                 AND SORS_FL_LOGICAL_STATUS = '1'
                 AND OPIR_CD_IND_REQ_CAT IN ('SP',
                                             'IC',
                                             'SI',
                                             'OEM')
                 AND OPIR_DT_REQ_DT = REQ_TIME.TIME_DT_DAY )
            WHERE COUNTER = 1 ) KEY,

           (SELECT OPIR_CD_PLANT_CD,
                   OPIR_CD_SALE_ORD_NBR,
                   OPIR_CD_SALE_ORD_LN,
                   OPIR_QT_REQ_QTY
            FROM
              (SELECT ROW_NUMBER () OVER (PARTITION BY OPIR_CD_SALE_ORD_NBR,
                                                       OPIR_CD_SALE_ORD_LN
                                          ORDER BY OPIR_DT_REQ_DT,
                                                   OPIR_CD_SALE_ORD_LN) AS COUNTER,
                                         OPIR_CD_PLANT_CD,
                                         OPIR_CD_SALE_ORD_NBR,
                                         OPIR_CD_SALE_ORD_LN,
                                         SUM (OPIR_QT_REQ_QTY) OVER (PARTITION BY OPIR_CD_SALE_ORD_NBR,
                                                                                  OPIR_CD_SALE_ORD_LN) AS OPIR_QT_REQ_QTY
               FROM DDWH01_DW_MA.TT_OPIR_OPEN_IND_REQ
               WHERE OPIR_CD_PLANT_CD = P_ELT_CD_PLANT
                 AND OPIR_CD_IND_REQ_CAT IN ('SP',
                                             'IC',
                                             'SI',
                                             'OEM') )
            WHERE COUNTER = 1 ) CUMULATIVE,

           (SELECT OPIR_CD_PLANT_CD,
                   OPIR_CD_SALE_ORD_NBR,
                   OPIR_CD_SALE_ORD_LN,
                   OPIR_QT_REQ_QTY,
                   OPIR_QT_REM_QTY
            FROM
              (SELECT ROW_NUMBER () OVER (PARTITION BY OPIR_CD_SALE_ORD_NBR,
                                                       OPIR_CD_SALE_ORD_LN
                                          ORDER BY OPIR_DT_REQ_DT,
                                                   OPIR_CD_SALE_ORD_LN) AS COUNTER,
                                         OPIR_CD_PLANT_CD,
                                         OPIR_CD_SALE_ORD_NBR,
                                         OPIR_CD_SALE_ORD_LN,
                                         SUM (OPIR_QT_REQ_QTY) OVER (PARTITION BY OPIR_CD_SALE_ORD_NBR,
                                                                                  OPIR_CD_SALE_ORD_LN) AS OPIR_QT_REQ_QTY,
                                                                    SUM (OPIR_QT_REM_QTY) OVER (PARTITION BY OPIR_CD_SALE_ORD_NBR,
                                                                                                             OPIR_CD_SALE_ORD_LN) AS OPIR_QT_REM_QTY
               FROM DDWH01_DW_MA.TT_OPIR_OPEN_IND_REQ,
                    ELAB_TIME,
                    DDWH02_DM_MA.TDIM_TIME_TIME REQ_TIME
               WHERE OPIR_CD_PLANT_CD = P_ELT_CD_PLANT
                 AND OPIR_CD_IND_REQ_CAT IN ('SP',
                                             'IC',
                                             'SI',
                                             'OEM')
                 AND OPIR_DT_REQ_DT = REQ_TIME.TIME_DT_DAY
                 AND REQ_TIME.TIME_DS_YEAR_WEEK = ELAB_TIME.TIME_DS_YEAR_WEEK )
            WHERE COUNTER = 1 ) WEEK_0,

           (SELECT OPIR_CD_PLANT_CD,
                   OPIR_CD_SALE_ORD_NBR,
                   OPIR_CD_SALE_ORD_LN,
                   OPIR_QT_REQ_QTY,
                   OPIR_QT_REM_QTY
            FROM
              (SELECT ROW_NUMBER () OVER (PARTITION BY OPIR_CD_SALE_ORD_NBR,
                                                       OPIR_CD_SALE_ORD_LN
                                          ORDER BY OPIR_DT_REQ_DT,
                                                   OPIR_CD_SALE_ORD_LN) AS COUNTER,
                                         OPIR_CD_PLANT_CD,
                                         OPIR_CD_SALE_ORD_NBR,
                                         OPIR_CD_SALE_ORD_LN,
                                         SUM (OPIR_QT_REQ_QTY) OVER (PARTITION BY OPIR_CD_SALE_ORD_NBR,
                                                                                  OPIR_CD_SALE_ORD_LN) AS OPIR_QT_REQ_QTY,
                                                                    SUM (OPIR_QT_REM_QTY) OVER (PARTITION BY OPIR_CD_SALE_ORD_NBR,
                                                                                                             OPIR_CD_SALE_ORD_LN) AS OPIR_QT_REM_QTY
               FROM DDWH01_DW_MA.TT_OPIR_OPEN_IND_REQ,

                 (SELECT TIME_DS_YEAR_WEEK
                  FROM DDWH02_DM_MA.TDIM_TIME_TIME
                  WHERE TIME_DT_DAY =TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') +7 ) W1_TIME,
                    DDWH02_DM_MA.TDIM_TIME_TIME REQ_TIME
               WHERE OPIR_CD_PLANT_CD = P_ELT_CD_PLANT
                 AND OPIR_CD_IND_REQ_CAT IN ('SP',
                                             'IC',
                                             'SI',
                                             'OEM')
                 AND OPIR_DT_REQ_DT = REQ_TIME.TIME_DT_DAY
                 AND REQ_TIME.TIME_DS_YEAR_WEEK = W1_TIME.TIME_DS_YEAR_WEEK )
            WHERE COUNTER = 1 ) WEEK_1,

           (SELECT OPIR_CD_PLANT_CD,
                   OPIR_CD_SALE_ORD_NBR,
                   OPIR_CD_SALE_ORD_LN,
                   OPIR_QT_REQ_QTY,
                   OPIR_QT_REM_QTY
            FROM
              (SELECT ROW_NUMBER () OVER (PARTITION BY OPIR_CD_SALE_ORD_NBR,
                                                       OPIR_CD_SALE_ORD_LN
                                          ORDER BY OPIR_DT_REQ_DT,
                                                   OPIR_CD_SALE_ORD_LN) AS COUNTER,
                                         OPIR_CD_PLANT_CD,
                                         OPIR_CD_SALE_ORD_NBR,
                                         OPIR_CD_SALE_ORD_LN,
                                         SUM (OPIR_QT_REQ_QTY) OVER (PARTITION BY OPIR_CD_SALE_ORD_NBR,
                                                                                  OPIR_CD_SALE_ORD_LN) AS OPIR_QT_REQ_QTY,
                                                                    SUM (OPIR_QT_REM_QTY) OVER (PARTITION BY OPIR_CD_SALE_ORD_NBR,
                                                                                                             OPIR_CD_SALE_ORD_LN) AS OPIR_QT_REM_QTY
               FROM DDWH01_DW_MA.TT_OPIR_OPEN_IND_REQ,

                 (SELECT TIME_DS_YEAR_WEEK
                  FROM DDWH02_DM_MA.TDIM_TIME_TIME
                  WHERE TIME_DT_DAY =TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') +14 ) W2_TIME,
                    DDWH02_DM_MA.TDIM_TIME_TIME REQ_TIME
               WHERE OPIR_CD_PLANT_CD = P_ELT_CD_PLANT
                 AND OPIR_CD_IND_REQ_CAT IN ('SP',
                                             'IC',
                                             'SI',
                                             'OEM')
                 AND OPIR_DT_REQ_DT = REQ_TIME.TIME_DT_DAY
                 AND REQ_TIME.TIME_DS_YEAR_WEEK = W2_TIME.TIME_DS_YEAR_WEEK )
            WHERE COUNTER = 1 ) WEEK_2,

           (SELECT OPIR_CD_PLANT_CD,
                   OPIR_CD_SALE_ORD_NBR,
                   OPIR_CD_SALE_ORD_LN,
                   OPIR_QT_REQ_QTY,
                   OPIR_QT_REM_QTY
            FROM
              (SELECT ROW_NUMBER () OVER (PARTITION BY OPIR_CD_SALE_ORD_NBR,
                                                       OPIR_CD_SALE_ORD_LN
                                          ORDER BY OPIR_DT_REQ_DT,
                                                   OPIR_CD_SALE_ORD_LN) AS COUNTER,
                                         OPIR_CD_PLANT_CD,
                                         OPIR_CD_SALE_ORD_NBR,
                                         OPIR_CD_SALE_ORD_LN,
                                         SUM (OPIR_QT_REQ_QTY) OVER (PARTITION BY OPIR_CD_SALE_ORD_NBR,
                                                                                  OPIR_CD_SALE_ORD_LN) AS OPIR_QT_REQ_QTY,
                                                                    SUM (OPIR_QT_REM_QTY) OVER (PARTITION BY OPIR_CD_SALE_ORD_NBR,
                                                                                                             OPIR_CD_SALE_ORD_LN) AS OPIR_QT_REM_QTY
               FROM DDWH01_DW_MA.TT_OPIR_OPEN_IND_REQ,

                 (SELECT TIME_DS_YEAR_WEEK
                  FROM DDWH02_DM_MA.TDIM_TIME_TIME
                  WHERE TIME_DT_DAY =TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') +21 ) W3_TIME,
                    DDWH02_DM_MA.TDIM_TIME_TIME REQ_TIME
               WHERE OPIR_CD_PLANT_CD = P_ELT_CD_PLANT
                 AND OPIR_CD_IND_REQ_CAT IN ('SP',
                                             'IC',
                                             'SI',
                                             'OEM')
                 AND OPIR_DT_REQ_DT = REQ_TIME.TIME_DT_DAY
                 AND REQ_TIME.TIME_DS_YEAR_WEEK = W3_TIME.TIME_DS_YEAR_WEEK )
            WHERE COUNTER = 1 ) WEEK_3,

           (SELECT OPIR_CD_PLANT_CD,
                   OPIR_CD_SALE_ORD_NBR,
                   OPIR_CD_SALE_ORD_LN,
                   OPIR_QT_REQ_QTY,
                   OPIR_QT_REM_QTY
            FROM
              (SELECT ROW_NUMBER () OVER (PARTITION BY OPIR_CD_SALE_ORD_NBR,
                                                       OPIR_CD_SALE_ORD_LN
                                          ORDER BY OPIR_DT_REQ_DT,
                                                   OPIR_CD_SALE_ORD_LN) AS COUNTER,
                                         OPIR_CD_PLANT_CD,
                                         OPIR_CD_SALE_ORD_NBR,
                                         OPIR_CD_SALE_ORD_LN,
                                         SUM (OPIR_QT_REQ_QTY) OVER (PARTITION BY OPIR_CD_SALE_ORD_NBR,
                                                                                  OPIR_CD_SALE_ORD_LN) AS OPIR_QT_REQ_QTY,
                                                                    SUM (OPIR_QT_REM_QTY) OVER (PARTITION BY OPIR_CD_SALE_ORD_NBR,
                                                                                                             OPIR_CD_SALE_ORD_LN) AS OPIR_QT_REM_QTY
               FROM DDWH01_DW_MA.TT_OPIR_OPEN_IND_REQ,

                 (SELECT TIME_DS_YEAR_WEEK
                  FROM DDWH02_DM_MA.TDIM_TIME_TIME
                  WHERE TIME_DT_DAY =TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') +28 ) W4_TIME,
                    DDWH02_DM_MA.TDIM_TIME_TIME REQ_TIME
               WHERE OPIR_CD_PLANT_CD = P_ELT_CD_PLANT
                 AND OPIR_CD_IND_REQ_CAT IN ('SP',
                                             'IC',
                                             'SI',
                                             'OEM')
                 AND OPIR_DT_REQ_DT = REQ_TIME.TIME_DT_DAY
                 AND REQ_TIME.TIME_DS_YEAR_WEEK = W4_TIME.TIME_DS_YEAR_WEEK )
            WHERE COUNTER = 1 ) WEEK_4
         WHERE 1 = 1
           AND KEY.OPIR_CD_PLANT_CD = CUMULATIVE.OPIR_CD_PLANT_CD (+)
           AND KEY.OPIR_CD_SALE_ORD_NBR = CUMULATIVE.OPIR_CD_SALE_ORD_NBR (+)
           AND KEY.OPIR_CD_SALE_ORD_LN = CUMULATIVE.OPIR_CD_SALE_ORD_LN (+)
           AND KEY.OPIR_CD_PLANT_CD = WEEK_0.OPIR_CD_PLANT_CD (+)
           AND KEY.OPIR_CD_SALE_ORD_NBR = WEEK_0.OPIR_CD_SALE_ORD_NBR (+)
           AND KEY.OPIR_CD_SALE_ORD_LN = WEEK_0.OPIR_CD_SALE_ORD_LN (+)
           AND KEY.OPIR_CD_PLANT_CD = WEEK_1.OPIR_CD_PLANT_CD (+)
           AND KEY.OPIR_CD_SALE_ORD_NBR = WEEK_1.OPIR_CD_SALE_ORD_NBR (+)
           AND KEY.OPIR_CD_SALE_ORD_LN = WEEK_1.OPIR_CD_SALE_ORD_LN (+)
           AND KEY.OPIR_CD_PLANT_CD = WEEK_2.OPIR_CD_PLANT_CD (+)
           AND KEY.OPIR_CD_SALE_ORD_NBR = WEEK_2.OPIR_CD_SALE_ORD_NBR (+)
           AND KEY.OPIR_CD_SALE_ORD_LN = WEEK_2.OPIR_CD_SALE_ORD_LN (+)
           AND KEY.OPIR_CD_PLANT_CD = WEEK_3.OPIR_CD_PLANT_CD (+)
           AND KEY.OPIR_CD_SALE_ORD_NBR = WEEK_3.OPIR_CD_SALE_ORD_NBR (+)
           AND KEY.OPIR_CD_SALE_ORD_LN = WEEK_3.OPIR_CD_SALE_ORD_LN (+)
           AND KEY.OPIR_CD_PLANT_CD = WEEK_4.OPIR_CD_PLANT_CD (+)
           AND KEY.OPIR_CD_SALE_ORD_NBR = WEEK_4.OPIR_CD_SALE_ORD_NBR (+)
           AND KEY.OPIR_CD_SALE_ORD_LN = WEEK_4.OPIR_CD_SALE_ORD_LN (+) ) ,
        (SELECT *
         FROM DDWH01_DW_MA.TM_CRMA_CRITICAL_PARTS
         WHERE CRMA_CD_PLANT_CD = P_ELT_CD_PLANT
           AND CRMA_FL_LOGICAL_STATUS = '1' ) ,
        (SELECT OUSD_CD_PLANT_CD,
                OUSD_CD_SALE_ORD_NBR,
                OUSD_CD_SALE_ORD_LN,
                SUM (WHMR_QT_SHIPP_QTY) AS WHMR_QT_SHIPP_QTY
         FROM DDWH01_DW_MA.TD_OUSD_OUTB_SHIPM,
              DDWH01_DW_MA.TT_WHMR_WH_MAT_REQ
         WHERE OUSD_CD_PLANT_CD = P_ELT_CD_PLANT
           AND WHMR_CD_PLANT_CD = P_ELT_CD_PLANT
           AND WHMR_ID_WH_MAT_REQ = OUSD_ID_WHMR_WH_MAT_REQ
           AND WHMR_CD_REQ_TP = 'S'
         GROUP BY OUSD_CD_PLANT_CD,
                  OUSD_CD_SALE_ORD_NBR,
                  OUSD_CD_SALE_ORD_LN) SHIP_CLICK ,
        (SELECT COIS_CD_PLANT_CD,
                COIS_CD_SALE_ORD_NBR,
                COIS_CD_SALE_ORD_LN,
                COIS_CD_PART_NBR,
                SUM (COIS_QT_DLVR_QTY) AS COIS_QT_DLVR_QTY
         FROM DDWH01_DW_MA.TT_COIS_CUST_ORD_SHIPM
         WHERE COIS_CD_PLANT_CD = P_ELT_CD_PLANT
           AND COIS_FL_LOGICAL_STATUS = '1'
         GROUP BY COIS_CD_PLANT_CD,
                  COIS_CD_SALE_ORD_NBR,
                  COIS_CD_SALE_ORD_LN,
                  COIS_CD_PART_NBR)
      WHERE 1 = 1
        AND OPIR_CD_PLANT_CD = CRMA_CD_PLANT_CD (+)
        AND OPIR_CD_PART_NBR = CRMA_CD_PART_NBR (+)
        AND SORS_CD_SHIP_CUST_CD = CRMA_CD_CUST_CD (+)
        AND OPIR_CD_PLANT_CD = SHIP_CLICK.OUSD_CD_PLANT_CD (+)
        AND OPIR_CD_SALE_ORD_NBR = SHIP_CLICK.OUSD_CD_SALE_ORD_NBR (+)
        AND OPIR_CD_SALE_ORD_LN = SHIP_CLICK.OUSD_CD_SALE_ORD_LN (+)
        AND OPIR_CD_PLANT_CD = COIS_CD_PLANT_CD (+)
        AND OPIR_CD_SALE_ORD_NBR = COIS_CD_SALE_ORD_NBR (+)
        AND OPIR_CD_SALE_ORD_LN = COIS_CD_SALE_ORD_LN (+)
        AND OPIR_CD_PART_NBR = COIS_CD_PART_NBR (+) )) QRY