INSERT INTO DDWH02_DM_MA.TFCT_PNNS_PART_NBR_NO_STOCK TRG (PNNS_CD_PLANT_CD, PNNS_ID_PNNS, PNNS_CD_SALE_ORD_NBR, PNNS_CD_SALE_ORD_LN, PNNS_ID_CUST_SHIP_CUST_CD, PNNS_CD_SHIP_CUST_CD, PNNS_ID_MTRL_MATERIAL, PNNS_CD_MATERIAL, PNNS_ID_REQU_REQUIREMENT, PNNS_CD_REQUIREMENT, PNNS_DT_REQUIRED_SHIP_DT, PNNS_QT_REQUIRED_SHIP_QTY, PNNS_QT_BUY_BALANCE_QTY, PNNS_QT_MAKE_BALANCE_QTY, PNNS_QT_BUY_REQUIRED_QTY_W0, PNNS_QT_MAKE_REQUIRED_QTY_W0, PNNS_QT_BUY_REQUIRED_QTY_W1, PNNS_QT_MAKE_REQUIRED_QTY_W1, PNNS_QT_BUY_REQUIRED_QTY_W2, PNNS_QT_MAKE_REQUIRED_QTY_W2, PNNS_QT_BUY_REQUIRED_QTY_W3, PNNS_QT_MAKE_REQUIRED_QTY_W3, PNNS_QT_BUY_REQUIRED_QTY_W4, PNNS_QT_MAKE_REQUIRED_QTY_W4, PNNS_QT_MAKE_PLANNED_QTY, PNNS_ID_BATCH_ID, PNNS_CD_OPERATOR_CODE, PNNS_CD_SOURCE_SYSTEM, PNNS_DT_INS_ROW, PNNS_DT_UPD_ROW)
SELECT QRY.PNNS_CD_PLANT_CD,
       DDWH02_DM_MA.SEQ_PNNS_TFCT01.NEXTVAL,
       QRY.PNNS_CD_SALE_ORD_NBR,
       QRY.PNNS_CD_SALE_ORD_LN,
       QRY.PNNS_ID_CUST_SHIP_CUST_CD,
       QRY.PNNS_CD_SHIP_CUST_CD,
       QRY.PNNS_ID_MTRL_MATERIAL,
       QRY.PNNS_CD_MATERIAL,
       QRY.PNNS_ID_REQU_REQUIREMENT,
       QRY.PNNS_CD_REQUIREMENT,
       QRY.PNNS_DT_REQUIRED_SHIP_DT,
       QRY.PNNS_QT_REQUIRED_SHIP_QTY,
       QRY.PNNS_QT_BUY_BALANCE_QTY,
       QRY.PNNS_QT_MAKE_BALANCE_QTY,
       QRY.PNNS_QT_BUY_REQUIRED_QTY_W0,
       QRY.PNNS_QT_MAKE_REQUIRED_QTY_W0,
       QRY.PNNS_QT_BUY_REQUIRED_QTY_W1,
       QRY.PNNS_QT_MAKE_REQUIRED_QTY_W1,
       QRY.PNNS_QT_BUY_REQUIRED_QTY_W2,
       QRY.PNNS_QT_MAKE_REQUIRED_QTY_W2,
       QRY.PNNS_QT_BUY_REQUIRED_QTY_W3,
       QRY.PNNS_QT_MAKE_REQUIRED_QTY_W3,
       QRY.PNNS_QT_BUY_REQUIRED_QTY_W4,
       QRY.PNNS_QT_MAKE_REQUIRED_QTY_W4,
       QRY.PNNS_QT_MAKE_PLANNED_QTY,
       QRY.PNNS_ID_BATCH_ID,
       'ETL',
       QRY.PNNS_CD_SOURCE_SYSTEM,
       SYSDATE,
       SYSDATE
FROM
  (SELECT PNNS_CD_PLANT_CD,
          NULL AS PNNS_ID_PNNS,
          PNNS_CD_SALE_ORD_NBR,
          PNNS_CD_SALE_ORD_LN,
          PNNS_ID_CUST_SHIP_CUST_CD,
          PNNS_CD_SHIP_CUST_CD,
          PNNS_ID_MTRL_MATERIAL,
          PNNS_CD_MATERIAL,
          PNNS_ID_REQU_REQUIREMENT,
          PNNS_CD_REQUIREMENT,
          PNNS_DT_REQUIRED_SHIP_DT,
          PNNS_QT_REQUIRED_SHIP_QTY,
          PNNS_QT_BUY_BALANCE_QTY,
          PNNS_QT_MAKE_BALANCE_QTY,
          PNNS_QT_BUY_REQUIRED_QTY_W0,
          PNNS_QT_MAKE_REQUIRED_QTY_W0,
          PNNS_QT_BUY_REQUIRED_QTY_W1,
          PNNS_QT_MAKE_REQUIRED_QTY_W1,
          PNNS_QT_BUY_REQUIRED_QTY_W2,
          PNNS_QT_MAKE_REQUIRED_QTY_W2,
          PNNS_QT_BUY_REQUIRED_QTY_W3,
          PNNS_QT_MAKE_REQUIRED_QTY_W3,
          PNNS_QT_BUY_REQUIRED_QTY_W4,
          PNNS_QT_MAKE_REQUIRED_QTY_W4,
          PNNS_QT_MAKE_PLANNED_QTY,
          PNNS_ID_BATCH_ID,
          PNNS_CD_SOURCE_SYSTEM
   FROM
     (SELECT KEY.OPIR_CD_PLANT_CD AS PNNS_CD_PLANT_CD,
             KEY.OPIR_CD_SALE_ORD_NBR AS PNNS_CD_SALE_ORD_NBR,
             KEY.OPIR_CD_SALE_ORD_LN AS PNNS_CD_SALE_ORD_LN,
             NVL (KEY.SORS_ID_CUST_SHIP_CUST_CD, -2) AS PNNS_ID_CUST_SHIP_CUST_CD,
             KEY.SORS_CD_SHIP_CUST_CD AS PNNS_CD_SHIP_CUST_CD,
             NVL (KEY.OPIR_ID_MAMD_PART_NBR, -2) AS PNNS_ID_MTRL_MATERIAL,
             KEY.OPIR_CD_PART_NBR AS PNNS_CD_MATERIAL,
             NVL (KEY.OPIR_ID_IRCA_IND_REQ_CAT, -2) AS PNNS_ID_REQU_REQUIREMENT,
             KEY.OPIR_CD_IND_REQ_CAT AS PNNS_CD_REQUIREMENT,
             KEY.OPIR_DT_REQ_DT AS PNNS_DT_REQUIRED_SHIP_DT,
             KEY.OPIR_QT_REQ_QTY AS PNNS_QT_REQUIRED_SHIP_QTY,
             NVL (BUY_BACKLOG.BACKLOG_QTY, 0) AS PNNS_QT_BUY_BALANCE_QTY,
             NVL (MAKE_BACKLOG.BACKLOG_QTY, 0) AS PNNS_QT_MAKE_BALANCE_QTY,
             NVL (BUY_NEXT_W0.QTY_W0, 0) AS PNNS_QT_BUY_REQUIRED_QTY_W0,
             NVL (MAKE_NEXT_W0.QTY_W0, 0) AS PNNS_QT_MAKE_REQUIRED_QTY_W0,
             NVL (BUY_NEXT_W1.QTY_W1, 0) AS PNNS_QT_BUY_REQUIRED_QTY_W1,
             NVL (MAKE_NEXT_W1.QTY_W1, 0) AS PNNS_QT_MAKE_REQUIRED_QTY_W1,
             NVL (BUY_NEXT_W2.QTY_W2, 0) AS PNNS_QT_BUY_REQUIRED_QTY_W2,
             NVL (MAKE_NEXT_W2.QTY_W2, 0) AS PNNS_QT_MAKE_REQUIRED_QTY_W2,
             NVL (BUY_NEXT_W3.QTY_W3, 0) AS PNNS_QT_BUY_REQUIRED_QTY_W3,
             NVL (MAKE_NEXT_W3.QTY_W3, 0) AS PNNS_QT_MAKE_REQUIRED_QTY_W3,
             NVL (BUY_NEXT_W4.QTY_W4, 0) AS PNNS_QT_BUY_REQUIRED_QTY_W4,
             NVL (MAKE_NEXT_W4.QTY_W4, 0) AS PNNS_QT_MAKE_REQUIRED_QTY_W4,
             NVL (MAKE_PLANNED.QTY, 0) AS PNNS_QT_MAKE_PLANNED_QTY,
             NVL (P_ELT_ID_BATCH, N_ELT_ID_JOB_LOG) AS PNNS_ID_BATCH_ID,
             KEY.OPIR_CD_SOURCE_SYSTEM AS PNNS_CD_SOURCE_SYSTEM
      FROM
        (SELECT OPIR_CD_PLANT_CD,
                OPIR_CD_SALE_ORD_NBR,
                OPIR_CD_SALE_ORD_LN,
                SORS_ID_CUST_SHIP_CUST_CD,
                SORS_CD_SHIP_CUST_CD,
                OPIR_ID_MAMD_PART_NBR,
                OPIR_CD_PART_NBR,
                OPIR_ID_IRCA_IND_REQ_CAT,
                OPIR_CD_IND_REQ_CAT,
                OPIR_DT_REQ_DT,
                OPIR_QT_REQ_QTY,
                OPIR_CD_SOURCE_SYSTEM
         FROM
           (SELECT ROW_NUMBER () OVER (PARTITION BY OPIR_CD_SALE_ORD_NBR,
                                                    OPIR_CD_SALE_ORD_LN
                                       ORDER BY OPIR_DT_REQ_DT) AS COUNTER,
                                      OPIR_CD_PLANT_CD,
                                      OPIR_CD_SALE_ORD_NBR,
                                      OPIR_CD_SALE_ORD_LN,
                                      SORS_ID_CUST_SHIP_CUST_CD,
                                      SORS_CD_SHIP_CUST_CD,
                                      OPIR_ID_MAMD_PART_NBR,
                                      OPIR_CD_PART_NBR,
                                      OPIR_ID_IRCA_IND_REQ_CAT,
                                      OPIR_CD_IND_REQ_CAT,
                                      OPIR_DT_REQ_DT,
                                      OPIR_QT_REQ_QTY,
                                      OPIR_CD_SOURCE_SYSTEM,
                                      NVL (WINV.WINV_ID_MAMD_PART_NBR, -2) AS WINV_ID_MAMD_PART_NBR
            FROM DDWH01_DW_MA.TT_OPIR_OPEN_IND_REQ,
                 DDWH01_DW_MA.TD_SORS_SALE_ORD_SCHED,

              (SELECT DISTINCT WINV_ID_MAMD_PART_NBR
               FROM DDWH01_DW_MA.TH_WINV_WH_INV
               WHERE WINV_DT_INV_DT =
                   (SELECT MAX (WINV_DT_INV_DT)
                    FROM DDWH01_DW_MA.TH_WINV_WH_INV)
                 AND WINV_CD_PLANT_CD = P_ELT_CD_PLANT ) WINV
            WHERE 1=1
              AND OPIR_ID_SORS_SALE_ORD_SCHED = SORS_ID_SALE_ORD_SCHED (+)
              AND OPIR_ID_MAMD_PART_NBR = WINV.WINV_ID_MAMD_PART_NBR (+)
              AND OPIR_CD_PLANT_CD = P_ELT_CD_PLANT
              AND OPIR_CD_IND_REQ_CAT NOT IN ('VH',
                                              'OIR',
                                              'FO',
                                              'EV')
              AND OPIR_DT_REQ_DT >= TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') )
         WHERE COUNTER = 1
           AND WINV_ID_MAMD_PART_NBR = -2 ) KEY,

        (SELECT PORD_CD_PLANT_CD,
                POLN_ID_MAMD_PART_NBR,
                BACKLOG_QTY
         FROM
           (SELECT ROW_NUMBER () OVER (PARTITION BY POLN_CD_PART_NBR
                                       ORDER BY SCLN_DT_REQ_DLVR_DT,
                                                SCLN_CD_PURCH_ORD_NBR,
                                                SCLN_CD_PURCH_ORD_LN) AS PURCHASING_ROW_NUM,
                                      PORD_CD_PLANT_CD,
                                      SCLN_CD_PURCH_ORD_NBR,
                                      SCLN_CD_PURCH_ORD_LN,
                                      POLN_ID_MAMD_PART_NBR,
                                      POLN_CD_PART_NBR,
                                      SUM (NVL (SCLN_QT_REQ_QTY, 0) - NVL (SCLN_QT_CUM_RCVD_QTY, 0)) OVER (PARTITION BY POLN_CD_PART_NBR) AS BACKLOG_QTY
            FROM DDWH01_DW_MA.TT_PORD_PURCH_ORD,
                 DDWH01_DW_MA.TD_POLN_PURCH_ORD_LN,
                 DDWH01_DW_MA.TD_SCLN_SCHED_LN
            WHERE 1=1
              AND PORD_CD_PLANT_CD = P_ELT_CD_PLANT
              AND POLN_CD_PLANT_CD = PORD_CD_PLANT_CD
              AND SCLN_CD_PLANT_CD = POLN_CD_PLANT_CD
              AND POLN_ID_PORD_PURCH_ORD = PORD_ID_PURCH_ORD
              AND SCLN_ID_POLN_PURCH_ORD = POLN_ID_PURCH_ORD_LN
              AND POLN_FL_CLOSE_MARK = 0
              AND SCLN_FL_CLOSE_MARK = 0
              AND SCLN_DT_REQ_DLVR_DT <= TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') )
         WHERE PURCHASING_ROW_NUM = 1 ) BUY_BACKLOG,

        (SELECT PROR_CD_PLANT_CD,
                PROR_ID_MAMD_PART_NBR,
                BACKLOG_QTY
         FROM
           (SELECT ROW_NUMBER () OVER (PARTITION BY PROR_CD_PART_NBR
                                       ORDER BY PROR_CD_PART_NBR) AS PRODUCING_ROW_NUM,
                                      PROR_CD_PLANT_CD,
                                      PROR_ID_MAMD_PART_NBR,
                                      PROR_CD_PART_NBR,
                                      COUNT (*) OVER (PARTITION BY PROR_CD_PART_NBR) AS BACKLOG_QTY
            FROM DDWH01_DW_MA.TT_PROR_PROD_ORD
            WHERE 1=1
              AND PROR_CD_PLANT_CD = P_ELT_CD_PLANT
              AND PROR_FL_CLOSE_MARK = 0
              AND PROR_DT_SCHED_END_PROD_DT < TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') )
         WHERE PRODUCING_ROW_NUM = 1 ) MAKE_BACKLOG,

        (SELECT PORD_CD_PLANT_CD,
                POLN_ID_MAMD_PART_NBR,
                QTY_W0
         FROM
           (SELECT ROW_NUMBER () OVER (PARTITION BY POLN_CD_PART_NBR
                                       ORDER BY SCLN_DT_REQ_DLVR_DT,
                                                SCLN_CD_PURCH_ORD_NBR,
                                                SCLN_CD_PURCH_ORD_LN) AS PURCHASING_ROW_NUM,
                                      PORD_CD_PLANT_CD,
                                      SCLN_CD_PURCH_ORD_NBR,
                                      SCLN_CD_PURCH_ORD_LN,
                                      POLN_ID_MAMD_PART_NBR,
                                      POLN_CD_PART_NBR,
                                      SUM (NVL (SCLN_QT_REQ_QTY, 0) - NVL (SCLN_QT_CUM_RCVD_QTY, 0)) OVER (PARTITION BY POLN_CD_PART_NBR) AS QTY_W0
            FROM DDWH01_DW_MA.TT_PORD_PURCH_ORD,
                 DDWH01_DW_MA.TD_POLN_PURCH_ORD_LN,
                 DDWH01_DW_MA.TD_SCLN_SCHED_LN
            WHERE 1=1
              AND PORD_CD_PLANT_CD = P_ELT_CD_PLANT
              AND POLN_CD_PLANT_CD = PORD_CD_PLANT_CD
              AND SCLN_CD_PLANT_CD = POLN_CD_PLANT_CD
              AND POLN_ID_PORD_PURCH_ORD = PORD_ID_PURCH_ORD
              AND SCLN_ID_POLN_PURCH_ORD = POLN_ID_PURCH_ORD_LN
              AND POLN_FL_CLOSE_MARK = 0
              AND SCLN_FL_CLOSE_MARK = 0
              AND TO_CHAR (SCLN_DT_REQ_DLVR_DT, 'YYYY-IW') =
                (SELECT TO_CHAR (TIME_DT_DAY, 'YYYY-IW')
                 FROM DDWH02_DM_MA.TDIM_TIME_TIME
                 WHERE TIME_DT_DAY = TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') ) )
         WHERE PURCHASING_ROW_NUM = 1 ) BUY_NEXT_W0,

        (SELECT PROR_CD_PLANT_CD,
                PROR_ID_MAMD_PART_NBR,
                QTY_W0
         FROM
           (SELECT ROW_NUMBER () OVER (PARTITION BY PROR_CD_PART_NBR
                                       ORDER BY PROR_CD_PART_NBR) AS PRODUCING_ROW_NUM,
                                      PROR_CD_PLANT_CD,
                                      PROR_ID_MAMD_PART_NBR,
                                      PROR_CD_PART_NBR,
                                      COUNT (*) OVER (PARTITION BY PROR_CD_PART_NBR) AS QTY_W0
            FROM DDWH01_DW_MA.TT_PROR_PROD_ORD
            WHERE 1=1
              AND PROR_CD_PLANT_CD = P_ELT_CD_PLANT
              AND PROR_FL_CLOSE_MARK = 0
              AND TO_CHAR (PROR_DT_SCHED_END_PROD_DT, 'YYYY-IW') =
                (SELECT TO_CHAR (TIME_DT_DAY, 'YYYY-IW')
                 FROM DDWH02_DM_MA.TDIM_TIME_TIME
                 WHERE TIME_DT_DAY = TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') ) )
         WHERE PRODUCING_ROW_NUM = 1 ) MAKE_NEXT_W0,

        (SELECT PORD_CD_PLANT_CD,
                POLN_ID_MAMD_PART_NBR,
                QTY_W1
         FROM
           (SELECT ROW_NUMBER () OVER (PARTITION BY POLN_CD_PART_NBR
                                       ORDER BY SCLN_DT_REQ_DLVR_DT,
                                                SCLN_CD_PURCH_ORD_NBR,
                                                SCLN_CD_PURCH_ORD_LN) AS PURCHASING_ROW_NUM,
                                      PORD_CD_PLANT_CD,
                                      SCLN_CD_PURCH_ORD_NBR,
                                      SCLN_CD_PURCH_ORD_LN,
                                      POLN_ID_MAMD_PART_NBR,
                                      POLN_CD_PART_NBR,
                                      SUM (NVL (SCLN_QT_REQ_QTY, 0) - NVL (SCLN_QT_CUM_RCVD_QTY, 0)) OVER (PARTITION BY POLN_CD_PART_NBR) AS QTY_W1
            FROM DDWH01_DW_MA.TT_PORD_PURCH_ORD,
                 DDWH01_DW_MA.TD_POLN_PURCH_ORD_LN,
                 DDWH01_DW_MA.TD_SCLN_SCHED_LN
            WHERE 1=1
              AND PORD_CD_PLANT_CD = P_ELT_CD_PLANT
              AND POLN_CD_PLANT_CD = PORD_CD_PLANT_CD
              AND SCLN_CD_PLANT_CD = POLN_CD_PLANT_CD
              AND POLN_ID_PORD_PURCH_ORD = PORD_ID_PURCH_ORD
              AND SCLN_ID_POLN_PURCH_ORD = POLN_ID_PURCH_ORD_LN
              AND POLN_FL_CLOSE_MARK = 0
              AND SCLN_FL_CLOSE_MARK = 0
              AND TO_CHAR (SCLN_DT_REQ_DLVR_DT, 'YYYY-IW') =
                (SELECT TO_CHAR (TIME_DT_DAY, 'YYYY-IW')
                 FROM DDWH02_DM_MA.TDIM_TIME_TIME
                 WHERE TIME_DT_DAY = TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') +7 ) )
         WHERE PURCHASING_ROW_NUM = 1 ) BUY_NEXT_W1,

        (SELECT PROR_CD_PLANT_CD,
                PROR_ID_MAMD_PART_NBR,
                QTY_W1
         FROM
           (SELECT ROW_NUMBER () OVER (PARTITION BY PROR_CD_PART_NBR
                                       ORDER BY PROR_CD_PART_NBR) AS PRODUCING_ROW_NUM,
                                      PROR_CD_PLANT_CD,
                                      PROR_ID_MAMD_PART_NBR,
                                      PROR_CD_PART_NBR,
                                      COUNT (*) OVER (PARTITION BY PROR_CD_PART_NBR) AS QTY_W1
            FROM DDWH01_DW_MA.TT_PROR_PROD_ORD
            WHERE 1=1
              AND PROR_CD_PLANT_CD = P_ELT_CD_PLANT
              AND PROR_FL_CLOSE_MARK = 0
              AND TO_CHAR (PROR_DT_SCHED_END_PROD_DT, 'YYYY-IW') =
                (SELECT TO_CHAR (TIME_DT_DAY, 'YYYY-IW')
                 FROM DDWH02_DM_MA.TDIM_TIME_TIME
                 WHERE TIME_DT_DAY = TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') +7 ) )
         WHERE PRODUCING_ROW_NUM = 1 ) MAKE_NEXT_W1,

        (SELECT PORD_CD_PLANT_CD,
                POLN_ID_MAMD_PART_NBR,
                QTY_W2
         FROM
           (SELECT ROW_NUMBER () OVER (PARTITION BY POLN_CD_PART_NBR
                                       ORDER BY SCLN_DT_REQ_DLVR_DT,
                                                SCLN_CD_PURCH_ORD_NBR,
                                                SCLN_CD_PURCH_ORD_LN) AS PURCHASING_ROW_NUM,
                                      PORD_CD_PLANT_CD,
                                      SCLN_CD_PURCH_ORD_NBR,
                                      SCLN_CD_PURCH_ORD_LN,
                                      POLN_ID_MAMD_PART_NBR,
                                      POLN_CD_PART_NBR,
                                      SUM (NVL (SCLN_QT_REQ_QTY, 0) - NVL (SCLN_QT_CUM_RCVD_QTY, 0)) OVER (PARTITION BY POLN_CD_PART_NBR) AS QTY_W2
            FROM DDWH01_DW_MA.TT_PORD_PURCH_ORD,
                 DDWH01_DW_MA.TD_POLN_PURCH_ORD_LN,
                 DDWH01_DW_MA.TD_SCLN_SCHED_LN
            WHERE 1=1
              AND PORD_CD_PLANT_CD = P_ELT_CD_PLANT
              AND POLN_CD_PLANT_CD = PORD_CD_PLANT_CD
              AND SCLN_CD_PLANT_CD = POLN_CD_PLANT_CD
              AND POLN_ID_PORD_PURCH_ORD = PORD_ID_PURCH_ORD
              AND SCLN_ID_POLN_PURCH_ORD = POLN_ID_PURCH_ORD_LN
              AND POLN_FL_CLOSE_MARK = 0
              AND SCLN_FL_CLOSE_MARK = 0
              AND TO_CHAR (SCLN_DT_REQ_DLVR_DT, 'YYYY-IW') =
                (SELECT TO_CHAR (TIME_DT_DAY, 'YYYY-IW')
                 FROM DDWH02_DM_MA.TDIM_TIME_TIME
                 WHERE TIME_DT_DAY = TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') +14 ) )
         WHERE PURCHASING_ROW_NUM = 1 ) BUY_NEXT_W2,

        (SELECT PROR_CD_PLANT_CD,
                PROR_ID_MAMD_PART_NBR,
                QTY_W2
         FROM
           (SELECT ROW_NUMBER () OVER (PARTITION BY PROR_CD_PART_NBR
                                       ORDER BY PROR_CD_PART_NBR) AS PRODUCING_ROW_NUM,
                                      PROR_CD_PLANT_CD,
                                      PROR_ID_MAMD_PART_NBR,
                                      PROR_CD_PART_NBR,
                                      COUNT (*) OVER (PARTITION BY PROR_CD_PART_NBR) AS QTY_W2
            FROM DDWH01_DW_MA.TT_PROR_PROD_ORD
            WHERE 1=1
              AND PROR_CD_PLANT_CD = P_ELT_CD_PLANT
              AND PROR_FL_CLOSE_MARK = 0
              AND TO_CHAR (PROR_DT_SCHED_END_PROD_DT, 'YYYY-IW') =
                (SELECT TO_CHAR (TIME_DT_DAY, 'YYYY-IW')
                 FROM DDWH02_DM_MA.TDIM_TIME_TIME
                 WHERE TIME_DT_DAY = TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') +14 ) )
         WHERE PRODUCING_ROW_NUM = 1 ) MAKE_NEXT_W2,

        (SELECT PORD_CD_PLANT_CD,
                POLN_ID_MAMD_PART_NBR,
                QTY_W3
         FROM
           (SELECT ROW_NUMBER () OVER (PARTITION BY POLN_CD_PART_NBR
                                       ORDER BY SCLN_DT_REQ_DLVR_DT,
                                                SCLN_CD_PURCH_ORD_NBR,
                                                SCLN_CD_PURCH_ORD_LN) AS PURCHASING_ROW_NUM,
                                      PORD_CD_PLANT_CD,
                                      SCLN_CD_PURCH_ORD_NBR,
                                      SCLN_CD_PURCH_ORD_LN,
                                      POLN_ID_MAMD_PART_NBR,
                                      POLN_CD_PART_NBR,
                                      SUM (NVL (SCLN_QT_REQ_QTY, 0) - NVL (SCLN_QT_CUM_RCVD_QTY, 0)) OVER (PARTITION BY POLN_CD_PART_NBR) AS QTY_W3
            FROM DDWH01_DW_MA.TT_PORD_PURCH_ORD,
                 DDWH01_DW_MA.TD_POLN_PURCH_ORD_LN,
                 DDWH01_DW_MA.TD_SCLN_SCHED_LN
            WHERE 1=1
              AND PORD_CD_PLANT_CD = P_ELT_CD_PLANT
              AND POLN_CD_PLANT_CD = PORD_CD_PLANT_CD
              AND SCLN_CD_PLANT_CD = POLN_CD_PLANT_CD
              AND POLN_ID_PORD_PURCH_ORD = PORD_ID_PURCH_ORD
              AND SCLN_ID_POLN_PURCH_ORD = POLN_ID_PURCH_ORD_LN
              AND POLN_FL_CLOSE_MARK = 0
              AND SCLN_FL_CLOSE_MARK = 0
              AND TO_CHAR (SCLN_DT_REQ_DLVR_DT, 'YYYY-IW') =
                (SELECT TO_CHAR (TIME_DT_DAY, 'YYYY-IW')
                 FROM DDWH02_DM_MA.TDIM_TIME_TIME
                 WHERE TIME_DT_DAY = TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') +21 ) )
         WHERE PURCHASING_ROW_NUM = 1 ) BUY_NEXT_W3,

        (SELECT PROR_CD_PLANT_CD,
                PROR_ID_MAMD_PART_NBR,
                QTY_W3
         FROM
           (SELECT ROW_NUMBER () OVER (PARTITION BY PROR_CD_PART_NBR
                                       ORDER BY PROR_CD_PART_NBR) AS PRODUCING_ROW_NUM,
                                      PROR_CD_PLANT_CD,
                                      PROR_ID_MAMD_PART_NBR,
                                      PROR_CD_PART_NBR,
                                      COUNT (*) OVER (PARTITION BY PROR_CD_PART_NBR) AS QTY_W3
            FROM DDWH01_DW_MA.TT_PROR_PROD_ORD
            WHERE 1=1
              AND PROR_CD_PLANT_CD = P_ELT_CD_PLANT
              AND PROR_FL_CLOSE_MARK = 0
              AND TO_CHAR (PROR_DT_SCHED_END_PROD_DT, 'YYYY-IW') =
                (SELECT TO_CHAR (TIME_DT_DAY, 'YYYY-IW')
                 FROM DDWH02_DM_MA.TDIM_TIME_TIME
                 WHERE TIME_DT_DAY = TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') +21 ) )
         WHERE PRODUCING_ROW_NUM = 1 ) MAKE_NEXT_W3,

        (SELECT PORD_CD_PLANT_CD,
                POLN_ID_MAMD_PART_NBR,
                QTY_W4
         FROM
           (SELECT ROW_NUMBER () OVER (PARTITION BY POLN_CD_PART_NBR
                                       ORDER BY SCLN_DT_REQ_DLVR_DT,
                                                SCLN_CD_PURCH_ORD_NBR,
                                                SCLN_CD_PURCH_ORD_LN) AS PURCHASING_ROW_NUM,
                                      PORD_CD_PLANT_CD,
                                      SCLN_CD_PURCH_ORD_NBR,
                                      SCLN_CD_PURCH_ORD_LN,
                                      POLN_ID_MAMD_PART_NBR,
                                      POLN_CD_PART_NBR,
                                      SUM (NVL (SCLN_QT_REQ_QTY, 0) - NVL (SCLN_QT_CUM_RCVD_QTY, 0)) OVER (PARTITION BY POLN_CD_PART_NBR) AS QTY_W4
            FROM DDWH01_DW_MA.TT_PORD_PURCH_ORD,
                 DDWH01_DW_MA.TD_POLN_PURCH_ORD_LN,
                 DDWH01_DW_MA.TD_SCLN_SCHED_LN
            WHERE 1=1
              AND PORD_CD_PLANT_CD = P_ELT_CD_PLANT
              AND POLN_CD_PLANT_CD = PORD_CD_PLANT_CD
              AND SCLN_CD_PLANT_CD = POLN_CD_PLANT_CD
              AND POLN_ID_PORD_PURCH_ORD = PORD_ID_PURCH_ORD
              AND SCLN_ID_POLN_PURCH_ORD = POLN_ID_PURCH_ORD_LN
              AND POLN_FL_CLOSE_MARK = 0
              AND SCLN_FL_CLOSE_MARK = 0
              AND TO_CHAR (SCLN_DT_REQ_DLVR_DT, 'YYYY-IW') =
                (SELECT TO_CHAR (TIME_DT_DAY, 'YYYY-IW')
                 FROM DDWH02_DM_MA.TDIM_TIME_TIME
                 WHERE TIME_DT_DAY = TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') +28 ) )
         WHERE PURCHASING_ROW_NUM = 1 ) BUY_NEXT_W4,

        (SELECT PROR_CD_PLANT_CD,
                PROR_ID_MAMD_PART_NBR,
                QTY_W4
         FROM
           (SELECT ROW_NUMBER () OVER (PARTITION BY PROR_CD_PART_NBR
                                       ORDER BY PROR_CD_PART_NBR) AS PRODUCING_ROW_NUM,
                                      PROR_CD_PLANT_CD,
                                      PROR_ID_MAMD_PART_NBR,
                                      PROR_CD_PART_NBR,
                                      COUNT (*) OVER (PARTITION BY PROR_CD_PART_NBR) AS QTY_W4
            FROM DDWH01_DW_MA.TT_PROR_PROD_ORD
            WHERE 1=1
              AND PROR_CD_PLANT_CD = P_ELT_CD_PLANT
              AND PROR_FL_CLOSE_MARK = 0
              AND TO_CHAR (PROR_DT_SCHED_END_PROD_DT, 'YYYY-IW') =
                (SELECT TO_CHAR (TIME_DT_DAY, 'YYYY-IW')
                 FROM DDWH02_DM_MA.TDIM_TIME_TIME
                 WHERE TIME_DT_DAY = TO_DATE (P_ELT_DT_JOB_DATE_ELAB, 'YYYYMMDD') +28 ) )
         WHERE PRODUCING_ROW_NUM = 1 ) MAKE_NEXT_W4,

        (SELECT PLOR_CD_PLANT_CD,
                PLOR_ID_MAMD_PART_NBR,
                QTY
         FROM
           (SELECT ROW_NUMBER () OVER (PARTITION BY PLOR_CD_PART_NBR
                                       ORDER BY PLOR_CD_PART_NBR) AS PRODUCING_ROW_NUM,
                                      PLOR_CD_PLANT_CD,
                                      PLOR_ID_MAMD_PART_NBR,
                                      PLOR_CD_PART_NBR,
                                      COUNT (*) OVER (PARTITION BY PLOR_CD_PART_NBR) AS QTY
            FROM DDWH01_DW_MA.TT_PLOR_PLND_ORD
            WHERE 1=1
              AND PLOR_CD_PLANT_CD = P_ELT_CD_PLANT )
         WHERE PRODUCING_ROW_NUM = 1 ) MAKE_PLANNED
      WHERE 1=1
        AND KEY.OPIR_CD_PLANT_CD = BUY_BACKLOG.PORD_CD_PLANT_CD (+)
        AND KEY.OPIR_ID_MAMD_PART_NBR = BUY_BACKLOG.POLN_ID_MAMD_PART_NBR (+)
        AND KEY.OPIR_CD_PLANT_CD = MAKE_BACKLOG.PROR_CD_PLANT_CD (+)
        AND KEY.OPIR_ID_MAMD_PART_NBR = MAKE_BACKLOG.PROR_ID_MAMD_PART_NBR (+)
        AND KEY.OPIR_CD_PLANT_CD = BUY_NEXT_W0.PORD_CD_PLANT_CD (+)
        AND KEY.OPIR_ID_MAMD_PART_NBR = BUY_NEXT_W0.POLN_ID_MAMD_PART_NBR (+)
        AND KEY.OPIR_CD_PLANT_CD = MAKE_NEXT_W0.PROR_CD_PLANT_CD (+)
        AND KEY.OPIR_ID_MAMD_PART_NBR = MAKE_NEXT_W0.PROR_ID_MAMD_PART_NBR (+)
        AND KEY.OPIR_CD_PLANT_CD = BUY_NEXT_W1.PORD_CD_PLANT_CD (+)
        AND KEY.OPIR_ID_MAMD_PART_NBR = BUY_NEXT_W1.POLN_ID_MAMD_PART_NBR (+)
        AND KEY.OPIR_CD_PLANT_CD = MAKE_NEXT_W1.PROR_CD_PLANT_CD (+)
        AND KEY.OPIR_ID_MAMD_PART_NBR = MAKE_NEXT_W1.PROR_ID_MAMD_PART_NBR (+)
        AND KEY.OPIR_CD_PLANT_CD = BUY_NEXT_W2.PORD_CD_PLANT_CD (+)
        AND KEY.OPIR_ID_MAMD_PART_NBR = BUY_NEXT_W2.POLN_ID_MAMD_PART_NBR (+)
        AND KEY.OPIR_CD_PLANT_CD = MAKE_NEXT_W2.PROR_CD_PLANT_CD (+)
        AND KEY.OPIR_ID_MAMD_PART_NBR = MAKE_NEXT_W2.PROR_ID_MAMD_PART_NBR (+)
        AND KEY.OPIR_CD_PLANT_CD = BUY_NEXT_W3.PORD_CD_PLANT_CD (+)
        AND KEY.OPIR_ID_MAMD_PART_NBR = BUY_NEXT_W3.POLN_ID_MAMD_PART_NBR (+)
        AND KEY.OPIR_CD_PLANT_CD = MAKE_NEXT_W3.PROR_CD_PLANT_CD (+)
        AND KEY.OPIR_ID_MAMD_PART_NBR = MAKE_NEXT_W3.PROR_ID_MAMD_PART_NBR (+)
        AND KEY.OPIR_CD_PLANT_CD = BUY_NEXT_W4.PORD_CD_PLANT_CD (+)
        AND KEY.OPIR_ID_MAMD_PART_NBR = BUY_NEXT_W4.POLN_ID_MAMD_PART_NBR (+)
        AND KEY.OPIR_CD_PLANT_CD = MAKE_NEXT_W4.PROR_CD_PLANT_CD (+)
        AND KEY.OPIR_ID_MAMD_PART_NBR = MAKE_NEXT_W4.PROR_ID_MAMD_PART_NBR (+)
        AND KEY.OPIR_CD_PLANT_CD = MAKE_PLANNED.PLOR_CD_PLANT_CD (+)
        AND KEY.OPIR_ID_MAMD_PART_NBR = MAKE_PLANNED.PLOR_ID_MAMD_PART_NBR (+) )) QRY