CREATE OR REPLACE FORCE EDITIONABLE VIEW "DDWH02_SM"."VW_EKKO_PURCH_DOC_HEADER_AGCE" ("EKKO_DT_LAST_MODIFY", "EKKO_ID_PURCH_DOC_HEADER_GPP", "EKKO_CD_PURCH_DOC_NBR", "EKKO_NR_TOT_VAL_OF_RELEASE", "EKKO_DT_PURCH_DOC_DATE", "EKKO_DT_RECORD_CREATED_ON", "EKKO_CD_PURCH_GRP", "EKKO_FL_TAKE_PURCH_GRP", "EKKO_CD_VENDOR_ACCOUNT_NBR", "EKKO_CD_DOC_PROCESS_STATE", "EKKO_CD_PURCH_DOC_CATEGORY", "EKKO_CD_PURCH_DOCTYPE", "EKKO_DT_CONTRACT_START_DATE", "EKKO_NR_CHG_TIMESTAMP", "EKKO_DT_CONTRACT_END_DATE", "EKKO_CD_PURCH_DOC_STATUS", "EKKO_NR_CURRENCY_KEY", "EKKO_CD_PURCH_AGREEMENT_NBR", "EKKO_CD_OBJ_CREATED_BY", "EKKO_CD_INCOTERMS_PART_1", "EKKO_CD_INCOTERMS_PART_2", "EKKO_CD_TERMS_OF_PAYMENT_1", "EKKO_CD_PURCH_ORG_1", "EKKO_CD_COMPANY_CODE", "EKKO_CD_REMARK_1", "EKKO_NR_PURCH_DOC_YEAR", "PLBR_DS_PLANT_SEGMENT", "ODAG_PODOCUMENTTYPE", "ODAG_SUPPLIERCODE", "EKKO_DT_RETENTION_YEAR", "ODAG_PODOCUMENTYEAR", "EKKO_CD_PURCH_DOC_NBR10", "EKKO_CD_SUPPLIER_TYPE") AS 
  select
  EKKO_DT_LAST_MODIFY,
    EKKO_ID_PURCH_DOC_HEADER_GPP,
    EKKO_CD_PURCH_DOC_NBR,
    EKKO_NR_TOT_VAL_OF_RELEASE,
    EKKO_DT_PURCH_DOC_DATE,     
    EKKO_DT_RECORD_CREATED_ON,  
    EKKO_CD_PURCH_GRP,
    EKKO_FL_TAKE_PURCH_GRP,
    EKKO_CD_VENDOR_ACCOUNT_NBR,
    EKKO_CD_DOC_PROCESS_STATE,
    EKKO_CD_PURCH_DOC_CATEGORY,
    EKKO_CD_PURCH_DOCTYPE,
    EKKO_DT_CONTRACT_START_DATE,
	EKKO_NR_CHG_TIMESTAMP,
	EKKO_DT_CONTRACT_END_DATE,
    EKKO_CD_PURCH_DOC_STATUS,
    EKKO_NR_CURRENCY_KEY,
    EKKO_CD_PURCH_AGREEMENT_NBR,
    EKKO_CD_OBJ_CREATED_BY,
    EKKO_CD_INCOTERMS_PART_1,
    EKKO_CD_INCOTERMS_PART_2,
    EKKO_CD_TERMS_OF_PAYMENT_1 ,
    EKKO_CD_PURCH_ORG_1,
    EKKO_CD_COMPANY_CODE,
    EKKO_CD_REMARK_1,
    TO_NUMBER(TO_CHAR(EKKO_DT_PURCH_DOC_DATE,'YYYY'))    AS EKKO_NR_PURCH_DOC_YEAR,
   ' ' AS PLBR_DS_PLANT_SEGMENT,
   EKKO_CD_PURCH_DOCTYPE       AS ODAG_PODOCUMENTTYPE,
   EKKO_CD_VENDOR_ACCOUNT_NBR  AS ODAG_SUPPLIERCODE,
   TO_CHAR(COALESCE(EKKO_DT_CONTRACT_END_DATE,EKKO_DT_RECORD_CREATED_ON),'YYYY') as EKKO_DT_RETENTION_YEAR,
   TO_CHAR(EKKO_DT_PURCH_DOC_DATE,'YYYY')                                         AS ODAG_PODOCUMENTYEAR,
   to_Char(substr('0000000000'||EKKO_CD_PURCH_DOC_NBR,-10)) as EKKO_CD_PURCH_DOC_NBR10,
   Supplier_Type                                            as EKKO_CD_SUPPLIER_TYPE

  from ddwh01_dw.TT_EKKO_PURCH_DOC_HEADER_GPP
  INNER JOIN 
          (SELECT DISTINCT EKPO_CD_PO_NBR
                           --,EKPO_CD_PLANT,
                           --,PLBR_DS_PLANT_SEGMENT
           FROM ddwh01_dw.TT_EKPO_PURCH_DOC_ITEM_GPP
           INNER JOIN ddwh01_dw.TD_PLBR_PLANT_BRANCHES
           ON EKPO_CD_PLANT=PLBR_CD_PLANT
        AND PLBR_DS_PLANT_SEGMENT IN ('AG','CE','-1','AM','AS') 
         AND (   EKPO_CD_PLANT NOt IN ('FA01','FB01','IA01') OR EKPO_CD_PLANT NOt like '00%')) AGCE
 
   ON EKKO_CD_PURCH_DOC_NBR=AGCE.EKPO_CD_PO_NBR
   LEFT JOIN 
   (Select distinct
   SUPM_CD_ACCOUNT_NBR,
   CASE WHEN LENGTH(SUPM_CD_COMP_TRADING_PARTNER) > 1 then 'Intercompany'
        ELSE 'Third Party'   END           as Supplier_Type
        from ddwh01_dw.TM_SUPM_SUPPLIER_GPP) SUPM
    ON EKKO_CD_VENDOR_ACCOUNT_NBR = SUPM.SUPM_CD_ACCOUNT_NBR;
