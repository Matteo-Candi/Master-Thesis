INSERT INTO DDWH02_DM_MA.TW_MCMC_MC_MTO_CONS TRG (MCMC_CD_PLANT_CD, MCMC_ID_MC_MTO_CONS, MCMC_ID_REQU_REQ_CAT, MCMC_CD_REQ_CAT, MCMC_ID_VEHI_VAN, MCMC_CD_VAN, MCMC_DT_REQ_DT, MCMC_DT_REQ_DT_LT, MCMC_DT_PLND_INLINE_DT, MCMC_DT_INLINE_DT, MCMC_CD_PROD_LINE, MCMC_CD_VEHI_STU, MCMC_CD_SERIE, MCMC_NR_SEQ_NBR, MCMC_CD_IND_ID, MCMC_CD_SALE_ORD_NBR, MCMC_CD_SALE_ORD_LN, MCMC_CD_SCHED_LN_ID, MCMC_ID_MTRL_PART_NBR_IR, MCMC_CD_PART_NBR_IR, MCMC_ID_CUST_CUST_CD, MCMC_CD_CUST_CD, MCMC_DT_EXPL_DT, MCMC_ID_MTRL_COMP, MCMC_CD_COMP, MCMC_CD_PROCUR_TP, MCMC_CD_COMP_ASS_MARK, MCMC_ID_VEND_SUPPL_CD, MCMC_CD_SUPPL_CD, MCMC_FL_LEAF_COMP_MARK, MCMC_QT_COMP_QTY, MCMC_QT_COMP_QTY_CONS, MCMC_QT_COMP_QTY_MNT, MCMC_QT_COMP_QTY_MNT_LT, MCMC_QT_COMP_QTY_REQ, MCMC_QT_COMP_QTY_REQ_LT, MCMC_QT_COMP_QTY_REQ_PROG, MCMC_QT_COMP_QTY_REQ_PROG_LT, MCMC_QT_MIN_LEAD_TIME, MCMC_QT_MAX_LEAD_TIME, MCMC_ID_BATCH_ID, MCMC_CD_SOURCE_SYSTEM, MCMC_DT_INSERT_ROW, MCMC_DT_UPDATE_ROW, MCMC_CD_OPERATOR_CODE)
SELECT QRY.MCMC_CD_PLANT_CD,
       QRY.MCMC_ID_MC_MTO_CONS,
       QRY.MCMC_ID_REQU_REQ_CAT,
       QRY.MCMC_CD_REQ_CAT,
       QRY.MCMC_ID_VEHI_VAN,
       QRY.MCMC_CD_VAN,
       QRY.MCMC_DT_REQ_DT,
       QRY.MCMC_DT_REQ_DT_LT,
       QRY.MCMC_DT_PLND_INLINE_DT,
       QRY.MCMC_DT_INLINE_DT,
       QRY.MCMC_CD_PROD_LINE,
       QRY.MCMC_CD_VEHI_STU,
       QRY.MCMC_CD_SERIE,
       QRY.MCMC_NR_SEQ_NBR,
       QRY.MCMC_CD_IND_ID,
       QRY.MCMC_CD_SALE_ORD_NBR,
       QRY.MCMC_CD_SALE_ORD_LN,
       QRY.MCMC_CD_SCHED_LN_ID,
       QRY.MCMC_ID_MTRL_PART_NBR_IR,
       QRY.MCMC_CD_PART_NBR_IR,
       QRY.MCMC_ID_CUST_CUST_CD,
       QRY.MCMC_CD_CUST_CD,
       QRY.MCMC_DT_EXPL_DT,
       QRY.MCMC_ID_MTRL_COMP,
       QRY.MCMC_CD_COMP,
       QRY.MCMC_CD_PROCUR_TP,
       QRY.MCMC_CD_COMP_ASS_MARK,
       QRY.MCMC_ID_VEND_SUPPL_CD,
       QRY.MCMC_CD_SUPPL_CD,
       QRY.MCMC_FL_LEAF_COMP_MARK,
       QRY.MCMC_QT_COMP_QTY,
       QRY.MCMC_QT_COMP_QTY_CONS,
       QRY.MCMC_QT_COMP_QTY_MNT,
       QRY.MCMC_QT_COMP_QTY_MNT_LT,
       QRY.MCMC_QT_COMP_QTY_REQ,
       QRY.MCMC_QT_COMP_QTY_REQ_LT,
       QRY.MCMC_QT_COMP_QTY_REQ_PROG,
       QRY.MCMC_QT_COMP_QTY_REQ_PROG_LT,
       QRY.MCMC_QT_MIN_LEAD_TIME,
       QRY.MCMC_QT_MAX_LEAD_TIME,
       QRY.MCMC_ID_BATCH_ID,
       QRY.MCMC_CD_SOURCE_SYSTEM,
       SYSDATE,
       SYSDATE,
       'ETL'
FROM
  (WITH MTO_PARTNBR AS
     (SELECT MCVE_CD_PLANT_CD,
             MCVE_CD_VAN,
             MCVE_CD_SERIE,
             MCVE_CD_COMP,
             SUM (MCMO_QT_OK_QTY) MCMO_QT_OK_QTY_TOT
      FROM
        (SELECT *
         FROM DDWH02_DM_MA.TW_MCVE_MC_VEHICLE
         WHERE MCVE_CD_PLANT_CD = P_ELT_CD_PLANT
           AND MCVE_CD_VEHI_STU != 'FLEET' ) V,

        (SELECT *
         FROM DDWH02_DM_MA.TW_MCMO_VEHI_PART_NBR_MTO
         WHERE MCMO_CD_PLANT_CD = P_ELT_CD_PLANT ) P
      WHERE V.MCVE_CD_VAN = P.MCMO_CD_VAN
        AND V.MCVE_CD_COMP = P.MCMO_CD_PART_NBR
        AND (P.MCMO_FL_CLOSED_MARK = '1'
             OR MCMO_FL_PART_CLOSED_MARK = '1')
      GROUP BY MCVE_CD_PLANT_CD,
               MCVE_CD_VAN,
               MCVE_CD_SERIE,
               MCVE_CD_COMP,
               MCVE_CD_COMP_ASS_MARK,
               MCVE_FL_LEAF_COMP_MARK,
               MCVE_QT_COMP_QTY),
        MTO_COMP AS
     (SELECT MCVE_CD_PLANT_CD,
             MCVE_CD_VAN,
             MCVE_CD_SERIE,
             MCPR_CD_COMP,
             SUM (MCMO_QT_OK_QTY_COMP) MCMO_QT_OK_QTY_COMP
      FROM
        (SELECT V.MCVE_CD_PLANT_CD,
                V.MCVE_CD_VAN,
                V.MCVE_CD_SERIE,
                MCPR_CD_COMP,
                SUM (MCPR_QT_COMP_TOT_QTY*MCMO_QT_OK_LAST_OP_CLOSED_QTY) MCMO_QT_OK_QTY_COMP
         FROM
           (SELECT *
            FROM DDWH02_DM_MA.TW_MCVE_MC_VEHICLE
            WHERE MCVE_CD_PLANT_CD = P_ELT_CD_PLANT
              AND MCVE_CD_VEHI_STU != 'FLEET' ) V,

           (SELECT *
            FROM DDWH02_DM_MA.TW_MCMO_VEHI_PART_NBR_MTO
            WHERE MCMO_CD_PLANT_CD = P_ELT_CD_PLANT ) P,

           (SELECT *
            FROM DDWH02_DM_MA.TW_MCPR_MC_PN_ROUT
            WHERE MCPR_CD_PLANT_CD = P_ELT_CD_PLANT ) C
         WHERE V.MCVE_CD_VAN = P.MCMO_CD_VAN
           AND V.MCVE_CD_COMP = P.MCMO_CD_PART_NBR
           AND P.MCMO_FL_CLOSED_MARK = '0'
           AND P.MCMO_FL_OP_CLOSED_MARK = '1'
           AND V.MCVE_CD_SERIE = C.MCPR_CD_SERIE
           AND V.MCVE_CD_COMP = C.MCPR_CD_PART_NBR
           AND C.MCPR_CD_OP <= MCMO_CD_LAST_OP_CLOSED
         GROUP BY V.MCVE_CD_PLANT_CD,
                  MCVE_CD_VAN,
                  V.MCVE_CD_SERIE,
                  MCPR_CD_COMP
         UNION ALL SELECT V.MCVE_CD_PLANT_CD,
                          MCVE_CD_VAN,
                          V.MCVE_CD_SERIE,
                          MCPR_CD_COMP,
                          SUM (MCPR_QT_COMP_TOT_QTY*MCMO_QT_OK_LAST_OP_PART_QTY) MCMO_QT_OK_QTY_COMP
         FROM
           (SELECT *
            FROM DDWH02_DM_MA.TW_MCVE_MC_VEHICLE
            WHERE MCVE_CD_PLANT_CD = P_ELT_CD_PLANT
              AND MCVE_CD_VEHI_STU != 'FLEET' ) V,

           (SELECT *
            FROM DDWH02_DM_MA.TW_MCMO_VEHI_PART_NBR_MTO
            WHERE MCMO_CD_PLANT_CD = P_ELT_CD_PLANT ) P,

           (SELECT *
            FROM DDWH02_DM_MA.TW_MCPR_MC_PN_ROUT
            WHERE MCPR_CD_PLANT_CD = P_ELT_CD_PLANT ) C
         WHERE V.MCVE_CD_VAN = P.MCMO_CD_VAN
           AND V.MCVE_CD_COMP = P.MCMO_CD_PART_NBR
           AND P.MCMO_FL_CLOSED_MARK = '0'
           AND P.MCMO_FL_PART_CLOSED_MARK = '0'
           AND MCMO_QT_OK_LAST_OP_PART_QTY > 0
           AND V.MCVE_CD_SERIE = C.MCPR_CD_SERIE
           AND V.MCVE_CD_COMP = C.MCPR_CD_PART_NBR
           AND C.MCPR_CD_OP <= MCMO_CD_LAST_OP_PART
           AND C.MCPR_CD_OP > NVL (MCMO_CD_LAST_OP_CLOSED, '0000')
         GROUP BY V.MCVE_CD_PLANT_CD,
                  MCVE_CD_VAN,
                  V.MCVE_CD_SERIE,
                  MCPR_CD_COMP)
      GROUP BY MCVE_CD_PLANT_CD,
               MCVE_CD_VAN,
               MCVE_CD_SERIE,
               MCPR_CD_COMP) SELECT MCMC_CD_PLANT_CD,
                                    0 AS MCMC_ID_MC_MTO_CONS,
                                    MCMC_ID_REQU_REQ_CAT,
                                    MCMC_CD_REQ_CAT,
                                    MCMC_ID_VEHI_VAN,
                                    MCMC_CD_VAN,
                                    MCMC_DT_REQ_DT,
                                    (MCMC_DT_REQ_DT - MCMC_QT_MAX_LEAD_TIME - DDWH01_DW_MA.PKG_CALENDAR.GETNOTWORKINGDAY (P_ELT_CD_PLANT , (MCMC_DT_REQ_DT - MCMC_QT_MAX_LEAD_TIME) , MCMC_DT_REQ_DT)) AS MCMC_DT_REQ_DT_LT,
                                    MCMC_DT_PLND_INLINE_DT,
                                    MCMC_DT_INLINE_DT,
                                    MCMC_CD_PROD_LINE,
                                    MCMC_CD_VEHI_STU,
                                    MCMC_CD_SERIE,
                                    MCMC_NR_SEQ_NBR,
                                    MCMC_CD_IND_ID,
                                    MCMC_CD_SALE_ORD_NBR,
                                    MCMC_CD_SALE_ORD_LN,
                                    MCMC_CD_SCHED_LN_ID,
                                    MCMC_ID_MTRL_PART_NBR_IR,
                                    MCMC_CD_PART_NBR_IR,
                                    MCMC_ID_CUST_CUST_CD,
                                    MCMC_CD_CUST_CD,
                                    MCMC_DT_EXPL_DT,
                                    MCMC_ID_MTRL_COMP,
                                    MCMC_CD_COMP,
                                    MCMC_CD_PROCUR_TP,
                                    MCMC_CD_COMP_ASS_MARK,
                                    MCMC_ID_VEND_SUPPL_CD,
                                    MCMC_CD_SUPPL_CD,
                                    MCMC_FL_LEAF_COMP_MARK,
                                    MCMC_QT_COMP_QTY,
                                    MCMC_QT_COMP_QTY_CONS,
                                    MCMC_QT_COMP_QTY_MNT,
                                    MCMC_QT_COMP_QTY_MNT_LT,
                                    (MCMC_QT_COMP_QTY - MCMC_QT_COMP_QTY_CONS) AS MCMC_QT_COMP_QTY_REQ,
                                    (MCMC_QT_COMP_QTY - MCMC_QT_COMP_QTY_CONS) AS MCMC_QT_COMP_QTY_REQ_LT,
                                    0 AS MCMC_QT_COMP_QTY_REQ_PROG,
                                    0 AS MCMC_QT_COMP_QTY_REQ_PROG_LT,
                                    MCMC_QT_MIN_LEAD_TIME,
                                    MCMC_QT_MAX_LEAD_TIME,
                                    NVL (P_ELT_ID_BATCH, N_ELT_ID_JOB_LOG) AS MCMC_ID_BATCH_ID,
                                    MCMC_CD_SOURCE_SYSTEM
   FROM
     (SELECT *
      FROM
        (SELECT V.MCVE_CD_PLANT_CD AS MCMC_CD_PLANT_CD,
                NVL (IRCA_ID_IND_REQ_CAT, -2) AS MCMC_ID_REQU_REQ_CAT,
                'VH' AS MCMC_CD_REQ_CAT,
                NVL (VEHI_ID_VEHI_VEHICLE, -2) AS MCMC_ID_VEHI_VAN,
                V.MCVE_CD_VAN AS MCMC_CD_VAN,
                CASE
                    WHEN V.MCVE_CD_VEHI_STU = 'INLINE' THEN V.MCVE_DT_INLINE_DT
                    WHEN V.MCVE_CD_VEHI_STU = 'PLANNED' THEN V.MCVE_DT_PLND_INLINE_DT
                END AS MCMC_DT_REQ_DT,
                V.MCVE_DT_PLND_INLINE_DT AS MCMC_DT_PLND_INLINE_DT,
                V.MCVE_DT_INLINE_DT AS MCMC_DT_INLINE_DT,
                VEHI_CD_MRP_CTRL_CD AS MCMC_CD_PROD_LINE,
                V.MCVE_NR_SEQ_NBR AS MCMC_NR_SEQ_NBR,
                V.MCVE_CD_VEHI_STU AS MCMC_CD_VEHI_STU,
                V.MCVE_CD_SERIE AS MCMC_CD_SERIE,
                NULL AS MCMC_CD_IND_ID,
                NULL AS MCMC_CD_SALE_ORD_NBR,
                NULL AS MCMC_CD_SALE_ORD_LN,
                NULL AS MCMC_CD_SCHED_LN_ID,
                NULL AS MCMC_ID_MTRL_PART_NBR_IR,
                NULL AS MCMC_CD_PART_NBR_IR,
                NULL AS MCMC_ID_CUST_CUST_CD,
                NULL AS MCMC_CD_CUST_CD,
                NULL AS MCMC_DT_EXPL_DT,
                NULL AS MCMC_ID_MTRL_COMP,
                V.MCVE_CD_COMP AS MCMC_CD_COMP,
                V.MCVE_CD_PROCUR_TP AS MCMC_CD_PROCUR_TP,
                V.MCVE_CD_COMP_ASS_MARK AS MCMC_CD_COMP_ASS_MARK,
                NULL AS MCMC_ID_VEND_SUPPL_CD,
                NULL AS MCMC_CD_SUPPL_CD,
                V.MCVE_FL_LEAF_COMP_MARK AS MCMC_FL_LEAF_COMP_MARK,
                V.MCVE_QT_COMP_QTY AS MCMC_QT_COMP_QTY,
                LEAST (MCVE_QT_COMP_QTY, GREATEST (NVL (P.MCMO_QT_OK_QTY_TOT, 0), NVL (C.MCMO_QT_OK_QTY_COMP, 0), NVL (PC.MCMO_QT_OK_QTY_COMP, 0), NVL (CC.MCMO_QT_OK_QTY_COMP, 0))) MCMC_QT_COMP_QTY_CONS,
                0 MCMC_QT_COMP_QTY_MNT,
                0 MCMC_QT_COMP_QTY_MNT_LT,
                V.MCVE_QT_MIN_LEAD_TIME AS MCMC_QT_MIN_LEAD_TIME,
                V.MCVE_QT_MAX_LEAD_TIME AS MCMC_QT_MAX_LEAD_TIME,
                V.MCVE_CD_SOURCE_SYSTEM AS MCMC_CD_SOURCE_SYSTEM
         FROM
           (SELECT *
            FROM DDWH02_DM_MA.TW_MCVE_MC_VEHICLE
            WHERE MCVE_CD_PLANT_CD = P_ELT_CD_PLANT
              AND MCVE_CD_VEHI_STU != 'FLEET'
              AND MCVE_CD_PROCUR_TP != 'PHANTOM' ) V ,
           (SELECT *
            FROM DDWH01_DW_MA.TM_IRCA_IND_REQ_CAT
            WHERE IRCA_CD_PLANT_CD = P_ELT_CD_PLANT ) ,
           (SELECT *
            FROM DDWH02_DM_MA.TDIM_VEHI_VEHICLE
            WHERE VEHI_CD_PLANT_CD = P_ELT_CD_PLANT ) ,
           (SELECT *
            FROM MTO_PARTNBR
            WHERE MCVE_CD_PLANT_CD = P_ELT_CD_PLANT ) P,

           (SELECT *
            FROM MTO_COMP
            WHERE MCVE_CD_PLANT_CD = P_ELT_CD_PLANT ) C,

           (SELECT P.MCVE_CD_PLANT_CD,
                   P.MCVE_CD_VAN,
                   P.MCVE_CD_SERIE,
                   C.MCPR_CD_COMP,
                   SUM (MCMO_QT_OK_QTY_TOT*MCPR_QT_COMP_TOT_QTY) MCMO_QT_OK_QTY_COMP
            FROM
              (SELECT *
               FROM MTO_PARTNBR
               WHERE MCVE_CD_PLANT_CD = P_ELT_CD_PLANT ) P,

              (SELECT *
               FROM DDWH02_DM_MA.TW_MCPR_MC_PN_ROUT
               WHERE MCPR_CD_PLANT_CD = P_ELT_CD_PLANT ) C
            WHERE P.MCVE_CD_SERIE = C.MCPR_CD_SERIE
              AND P.MCVE_CD_COMP = C.MCPR_CD_PART_NBR
            GROUP BY P.MCVE_CD_PLANT_CD,
                     P.MCVE_CD_VAN,
                     P.MCVE_CD_SERIE,
                     C.MCPR_CD_COMP) PC,

           (SELECT P.MCVE_CD_PLANT_CD,
                   P.MCVE_CD_VAN,
                   P.MCVE_CD_SERIE,
                   C.MCPR_CD_COMP,
                   SUM (MCMO_QT_OK_QTY_COMP*MCPR_QT_COMP_TOT_QTY) MCMO_QT_OK_QTY_COMP
            FROM
              (SELECT *
               FROM MTO_COMP
               WHERE MCVE_CD_PLANT_CD = P_ELT_CD_PLANT ) P,

              (SELECT *
               FROM DDWH02_DM_MA.TW_MCPR_MC_PN_ROUT
               WHERE MCPR_CD_PLANT_CD = P_ELT_CD_PLANT ) C
            WHERE P.MCVE_CD_SERIE = C.MCPR_CD_SERIE
              AND P.MCPR_CD_COMP = C.MCPR_CD_PART_NBR
            GROUP BY P.MCVE_CD_PLANT_CD,
                     P.MCVE_CD_VAN,
                     P.MCVE_CD_SERIE,
                     C.MCPR_CD_COMP) CC
         WHERE 'VH' = IRCA_CD_IND_REQ_CAT (+)
           AND V.MCVE_CD_VAN = VEHI_CD_VAN (+)
           AND V.MCVE_CD_VAN = P.MCVE_CD_VAN (+)
           AND V.MCVE_CD_SERIE = P.MCVE_CD_SERIE (+)
           AND V.MCVE_CD_COMP = P.MCVE_CD_COMP (+)
           AND V.MCVE_CD_VAN = C.MCVE_CD_VAN (+)
           AND V.MCVE_CD_SERIE = C.MCVE_CD_SERIE (+)
           AND V.MCVE_CD_COMP = C.MCPR_CD_COMP (+)
           AND V.MCVE_CD_VAN = PC.MCVE_CD_VAN (+)
           AND V.MCVE_CD_SERIE = PC.MCVE_CD_SERIE (+)
           AND V.MCVE_CD_COMP = PC.MCPR_CD_COMP (+)
           AND V.MCVE_CD_VAN = CC.MCVE_CD_VAN (+)
           AND V.MCVE_CD_SERIE = CC.MCVE_CD_SERIE (+)
           AND V.MCVE_CD_COMP = CC.MCPR_CD_COMP (+)
         UNION ALL SELECT MCIR_CD_PLANT_CD AS MCMC_CD_PLANT_CD,
                          NVL (IRCA_ID_IND_REQ_CAT, -2) AS MCMC_ID_REQU_REQ_CAT,
                          MCIR_CD_IND_REQ_CAT AS MCMC_CD_REQ_CAT,
                          NULL AS MCMC_ID_VEHI_VAN,
                          NULL AS MCMC_CD_VAN,
                          MCIR_DT_IND_REQ_DT AS MCMC_DT_REQ_DT,
                          NULL AS MCMC_DT_PLND_INLINE_DT,
                          NULL AS MCMC_DT_INLINE_DT,
                          NULL AS MCMC_CD_PROD_LINE,
                          NULL AS MCMC_NR_SEQ_NBR,
                          'PLANNED' AS MCMC_CD_VEHI_STU,
                          MCIR_CD_SERIE AS MCMC_CD_SERIE,
                          MCIR_CD_IND_ID AS MCMC_CD_IND_ID,
                          MCIR_CD_SALE_ORD_NBR AS MCMC_CD_SALE_ORD_NBR,
                          MCIR_CD_SALE_ORD_LN AS MCMC_CD_SALE_ORD_LN,
                          MCIR_CD_SCHED_LINE_ID AS MCMC_CD_SCHED_LN_ID,
                          MCIR_ID_MTRL_PART_NBR_IR AS MCMC_ID_MTRL_PART_NBR_IR,
                          MCIR_CD_PART_NBR_IR AS MCMC_CD_PART_NBR_IR,
                          MCIR_ID_CUST_CUST_CD AS MCMC_ID_CUST_CUST_CD,
                          MCIR_CD_CUST_CD AS MCMC_CD_CUST_CD,
                          MCIR_DT_EXPL_DT AS MCMC_DT_EXPL_DT,
                          MCIR_ID_MTRL_COMP AS MCMC_ID_MTRL_COMP,
                          MCIR_CD_COMP AS MCMC_CD_COMP,
                          MCIR_CD_PROCUR_TP AS MCMC_CD_PROCUR_TP,
                          MCIR_CD_COMP_ASS_MARK AS MCMC_CD_COMP_ASS_MARK,
                          NULL AS MCMC_ID_VEND_SUPPL_CD,
                          NULL AS MCMC_CD_SUPPL_CD,
                          MCIR_FL_LEAF_COMP_MARK AS MCMC_FL_LEAF_COMP_MARK,
                          MCIR_QT_COMP_QTY AS MCMC_QT_COMP_QTY,
                          0 MCMC_QT_COMP_QTY_CONS,
                          0 MCMC_QT_COMP_QTY_MNT,
                          0 MCMC_QT_COMP_QTY_MNT_LT,
                          MCIR_QT_MIN_LEAD_TIME AS MCMC_QT_MIN_LEAD_TIME,
                          MCIR_QT_MAX_LEAD_TIME AS MCMC_QT_MAX_LEAD_TIME,
                          MCIR_CD_SOURCE_SYSTEM AS MCMC_CD_SOURCE_SYSTEM
         FROM
           (SELECT *
            FROM DDWH02_DM_MA.TW_MCIR_MC_IND_REQ
            WHERE MCIR_CD_PLANT_CD = P_ELT_CD_PLANT
              AND MCIR_CD_PROCUR_TP != 'PHANTOM' ) ,
           (SELECT *
            FROM DDWH01_DW_MA.TM_IRCA_IND_REQ_CAT
            WHERE IRCA_CD_PLANT_CD = P_ELT_CD_PLANT )
         WHERE MCIR_CD_IND_REQ_CAT = IRCA_CD_IND_REQ_CAT (+) ))
   UNION ALL SELECT MCVE_CD_PLANT_CD AS MCMC_CD_PLANT_CD,
                    0 AS MCMC_ID_MC_MTO_CONS,
                    NVL (IRCA_ID_IND_REQ_CAT, -2) AS MCMC_ID_REQU_REQ_CAT,
                    'VH' AS MCMC_CD_REQ_CAT,
                    NVL (VEHI_ID_VEHI_VEHICLE, -2) AS MCMC_ID_VEHI_VAN,
                    MCVE_CD_VAN AS MCMC_CD_VAN,
                    VEHI_DT_OFFLINE_DT AS MCMC_DT_REQ_DT,
                    (VEHI_DT_OFFLINE_DT - MCVE_QT_MAX_LEAD_TIME - DDWH01_DW_MA.PKG_CALENDAR.GETNOTWORKINGDAY (P_ELT_CD_PLANT , (VEHI_DT_OFFLINE_DT - MCVE_QT_MAX_LEAD_TIME) , VEHI_DT_OFFLINE_DT)) AS MCMC_DT_REQ_DT_LT,
                    MCVE_DT_PLND_INLINE_DT AS MCMC_DT_PLND_INLINE_DT,
                    MCVE_DT_INLINE_DT AS MCMC_DT_INLINE_DT,
                    VEHI_CD_MRP_CTRL_CD AS MCMC_CD_PROD_LINE,
                    MCVE_CD_VEHI_STU AS MCMC_CD_VEHI_STU,
                    MCVE_CD_SERIE AS MCMC_CD_SERIE,
                    MCVE_NR_SEQ_NBR AS MCMC_NR_SEQ_NBR,
                    NULL AS MCMC_CD_IND_ID,
                    NULL AS MCMC_CD_SALE_ORD_NBR,
                    NULL AS MCMC_CD_SALE_ORD_LN,
                    NULL AS MCMC_CD_SCHED_LN_ID,
                    NULL AS MCMC_ID_MTRL_PART_NBR_IR,
                    NULL AS MCMC_CD_PART_NBR_IR,
                    NULL AS MCMC_ID_CUST_CUST_CD,
                    NULL AS MCMC_CD_CUST_CD,
                    NULL AS MCMC_DT_EXPL_DT,
                    NULL AS MCMC_ID_MTRL_COMP,
                    MCVE_CD_COMP AS MCMC_CD_COMP,
                    MCVE_CD_PROCUR_TP AS MCMC_CD_PROCUR_TP,
                    MCVE_CD_COMP_ASS_MARK AS MCMC_CD_COMP_ASS_MARK,
                    NULL AS MCMC_ID_VEND_SUPPL_CD,
                    NULL AS MCMC_CD_SUPPL_CD,
                    MCVE_FL_LEAF_COMP_MARK AS MCMC_FL_LEAF_COMP_MARK,
                    MCVE_QT_COMP_QTY AS MCMC_QT_COMP_QTY,
                    MCVE_QT_COMP_QTY AS MCMC_QT_COMP_QTY_CONS,
                    0 AS MCMC_QT_COMP_QTY_MNT,
                    0 AS MCMC_QT_COMP_QTY_MNT_LT,
                    0 AS MCMC_QT_COMP_QTY_REQ,
                    0 AS MCMC_QT_COMP_QTY_REQ_LT,
                    NULL AS MCMC_QT_COMP_QTY_REQ_PROG,
                    NULL AS MCMC_QT_COMP_QTY_REQ_PROG_LT,
                    MCVE_QT_MIN_LEAD_TIME AS MCMC_QT_MIN_LEAD_TIME,
                    MCVE_QT_MAX_LEAD_TIME AS MCMC_QT_MAX_LEAD_TIME,
                    NVL (P_ELT_ID_BATCH, N_ELT_ID_JOB_LOG) AS MCMC_ID_BATCH_ID,
                    MCVE_CD_SOURCE_SYSTEM AS MCMC_CD_SOURCE_SYSTEM
   FROM
     (SELECT *
      FROM DDWH02_DM_MA.TW_MCVE_MC_VEHICLE
      WHERE MCVE_CD_PLANT_CD = P_ELT_CD_PLANT
        AND MCVE_CD_VEHI_STU IN ('FLEET')
        AND MCVE_CD_PROCUR_TP != 'PHANTOM' ) ,
     (SELECT *
      FROM DDWH01_DW_MA.TM_IRCA_IND_REQ_CAT
      WHERE IRCA_CD_PLANT_CD = P_ELT_CD_PLANT ) ,
     (SELECT *
      FROM DDWH02_DM_MA.TDIM_VEHI_VEHICLE
      WHERE VEHI_CD_PLANT_CD = P_ELT_CD_PLANT )
   WHERE 'VH' = IRCA_CD_IND_REQ_CAT (+)
     AND MCVE_CD_VAN = VEHI_CD_VAN (+) ) QRY