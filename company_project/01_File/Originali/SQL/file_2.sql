INSERT INTO ddwh01_dw.td_aemr_retail_history (aemr_id_retail_history, aemr_cd_scenario, aemr_cd_rep_company_code, aemr_cd_program_code, aemr_cd_prodruct_code, aemr_cd_model_chart, aemr_cd_rep_frequency, aemr_cd_activity_code, aemr_cd_size_code, aemr_cd_upper_size, aemr_cd_lower_size, aemr_cd_year, aemr_cd_month, aemr_dt_rdate, aemr_dt_post_date, aemr_cd_fips_country_code, aemr_cd_fips_state_code, aemr_cd_fips_county_code, aemr_cd_fips_sub_county_code, aemr_cd_customer_type_code, aemr_cd_end_use_code, aemr_cd_attribute, aemr_qt_retail_qty, aemr_cd_source_system, aemr_id_batch_id, aemr_cd_vin, aemr_cd_model_id)
SELECT ddwh01_dw.seq_aemr_td00001.nextval,
       CASE
           WHEN TO_CHAR (main1.postdate,
                         'YYYYMM') = TO_CHAR (main1.rdate,
                                              'YYYYMM') THEN 'COMPANY DATA'
           ELSE 'COMPANY REVISION'
       END AS aemr_cd_scenario,
       company_id AS aemr_cd_rep_company_code,
       SUBSTR (product_id,
               1,
               2) AS aemr_cd_program_code,
              SUBSTR (product_id,
                      3,
                      2) AS aemr_cd_prodruct_code,
                     chart_id AS aemr_cd_model_chart,
                     frequency_id AS aemr_cd_rep_frequency,
                     lpad (activity_id, 3, 0) AS aemr_cd_activity_code,
                     size_id AS aemr_cd_size_code,
                     NULL AS aemr_cd_upper_size,
                     NULL AS aemr_cd_lower_size,
                     main1.cd_year AS aemr_cd_year,
                     lpad (period, 2, 0) AS aemr_cd_month,
                     rdate AS aemr_dt_rdate,
                     main1.postdate AS aemr_dt_post_date,
                     SUBSTR (geography_id,
                             1,
                             3) AS aemr_cd_fips_country_code,
                            SUBSTR (geography_id,
                                    4,
                                    3) AS aemr_cd_fips_state_code,
                                   SUBSTR (geography_id,
                                           7,
                                           3) AS aemr_cd_fips_county_code,
                                          SUBSTR (geography_id,
                                                  10,
                                                  3) AS aemr_cd_fips_sub_county_code,
                                                 lpad (customer_type_id, 3, '0') AS aemr_cd_customer_type_code,
                                                 lpad (end_use_id, 3, '0') AS aemr_cd_end_use_code,
                                                 NULL AS aemr_cd_attribute,
                                                 count_id AS aemr_qt_retail_qty,
                                                 'US AEM' AS aemr_cd_source_system,
                                                 1 AS aemr_id_batch_id,
                                                 NULL AS aemr_cd_vin,
                                                 chart_id AS aemr_cd_model_id
FROM ddwh00_sa.ts_aemi0004_us_aem main1
WHERE company_id IN ('JIC',
                     'FOR')
  AND frequency_id = 'M'
  AND CASE
          WHEN product_id IN ('CEB0',
                              'CEE2',
                              'CEE3',
                              'CEF0',
                              'CEG0') THEN '010'
          ELSE '011'
      END = lpad (activity_id, 3, '0')
  AND attribute_id = '99' ;