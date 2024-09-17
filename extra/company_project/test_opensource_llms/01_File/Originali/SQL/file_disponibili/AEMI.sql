insert into ddwh01_dw.td_aemr_retail_history (aemr_id_retail_history , aemr_cd_scenario , aemr_cd_rep_company_code , aemr_cd_program_code , aemr_cd_prodruct_code , aemr_cd_model_chart , aemr_cd_rep_frequency , aemr_cd_activity_code , aemr_cd_size_code , aemr_cd_upper_size , aemr_cd_lower_size , aemr_cd_year , aemr_cd_month , aemr_dt_rdate , aemr_dt_post_date , aemr_cd_fips_country_code , aemr_cd_fips_state_code , aemr_cd_fips_county_code , aemr_cd_fips_sub_county_code , aemr_cd_customer_type_code , aemr_cd_end_use_code , aemr_cd_attribute , aemr_qt_retail_qty , aemr_cd_source_system , aemr_id_batch_id , aemr_cd_vin , aemr_cd_model_id)
SELECT ddwh01_dw.seq_aemr_td00001.nextval ,
       case when to_char (main1.postdate , 'YYYYMM') = to_char (main1.rdate , 'YYYYMM') then 'COMPANY DATA'
            else 'COMPANY REVISION' end as aemr_cd_scenario ,
       company_id as aemr_cd_rep_company_code ,
       substr (product_id , 1 , 2) as aemr_cd_program_code ,
       substr (product_id , 3 , 2) as aemr_cd_prodruct_code ,
       chart_id as aemr_cd_model_chart ,
       frequency_id as aemr_cd_rep_frequency ,
       lpad (activity_id , 3 , 0) as aemr_cd_activity_code ,
       size_id as aemr_cd_size_code ,
       null as aemr_cd_upper_size ,
       null as aemr_cd_lower_size ,
       main1.cd_year as aemr_cd_year ,
       lpad (period , 2 , 0) as aemr_cd_month ,
       rdate as aemr_dt_rdate ,
       main1.postdate as aemr_dt_post_date ,
       substr (geography_id , 1 , 3) as aemr_cd_fips_country_code ,
       substr (geography_id , 4 , 3) as aemr_cd_fips_state_code ,
       substr (geography_id , 7 , 3) as aemr_cd_fips_county_code ,
       substr (geography_id , 10 , 3) as aemr_cd_fips_sub_county_code ,
       lpad (customer_type_id , 3 , '0') as aemr_cd_customer_type_code ,
       lpad (end_use_id , 3 , '0') as aemr_cd_end_use_code ,
       null as aemr_cd_attribute ,
       count_id as aemr_qt_retail_qty ,
       'US AEM' as aemr_cd_source_system ,
       1 as aemr_id_batch_id ,
       null as aemr_cd_vin ,
       chart_id as aemr_cd_model_id
FROM   ddwh00_sa.ts_aemi0004_us_aem main1
WHERE  company_id in ('JIC' , 'FOR')
   and frequency_id = 'M'
   and case when product_id in ('CEB0' , 'CEE2' , 'CEE3' , 'CEF0' , 'CEG0') then '010' else '011' end = lpad (activity_id , 3 , '0')
   and attribute_id = '99' ;