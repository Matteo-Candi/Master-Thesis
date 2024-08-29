insert into ddwh02_sm.twrk_fbil_billing_l_flash fbil (fbil_id_comp_company , fbil_cd_accg_doc_code , fbil_nr_accg_doc_fiscal_year , fbil_cd_cmm_doc_code , fbil_cd_cmm_doc_pos_code , fbil_id_pvan_vcl , fbil_cd_sls_ord_code , fbil_cd_sls_ord_pos_code , fbil_id_cmm_doc_id , fbil_id_cmm_doc_pos_id , fbil_id_bdty_billing_doc_tp , fbil_id_time_cmm_doc_date , fbil_id_cust_payer , fbil_id_cust_sold , fbil_id_cuty_customer_type , fbil_id_divi_division , fbil_id_hmup_hmu_product , fbil_id_prat_pr_attributes , fbil_id_prp_prpp_product , fbil_id_time_return_date , fbil_id_time_sales_order_date , fbil_id_sls_ord_id , fbil_id_sls_ord_pos_id , fbil_id_time_start_billing_dat , fbil_cd_currency , fbil_id_batch_id , fbil_fl_itc_flg , fbil_id_cust_payee , fbil_id_cust_billtoparner , fbil_id_cust_saleschannel , fbil_id_cust_soldtoparner , fbil_id_cust_ownership_group , fbil_id_addr_ownership_group , fbil_cd_business_area_code , fbil_cd_codice_resa , fbil_cd_dlr_code , fbil_cd_dlr_ord_ref , fbil_cd_dlr_ord_tp , fbil_cd_doc_nbr , fbil_cd_doc_tp , fbil_cd_draft_inv_code , fbil_cd_eng_nbr , fbil_cd_machine_tp , fbil_cd_market_legacy , fbil_cd_price_tyres_1 , fbil_cd_price_tyres_2 , fbil_cd_price_list , fbil_cd_price_tech_tp , fbil_cd_product_cl , fbil_cd_product_line , fbil_cd_product_tp , fbil_cd_progressive_ord , fbil_cd_ref_doc_nbr , fbil_cd_serial_nbr , fbil_cd_shipment_progressive , fbil_cd_sls_ord , fbil_cd_source_ord , fbil_cd_source_ord_sequence , fbil_cd_std_card_mdl , fbil_cd_std_card_tyres , fbil_cd_std_card_vrs , fbil_cd_tech_tp , fbil_id_time_itc_inv_date , fbil_fl_inv_reject_reason , fbil_id_time_draft_inv_date , fbil_id_coun_country , fbil_cd_source_system , fbil_in_wholesale_qty , fbil_in_wholesale_net_qty , fbil_in_wholesale_rev_qty , fbil_id_time_accounting_date)
SELECT -1 as fbil_id_comp_company ,
       '-1' as fbil_cd_accg_doc_code ,
       to_number (to_char (inol.inol_dt_document_date , 'YYYY')) as fbil_nr_accg_doc_fiscal_year ,
       inol.inol_cd_document_number as fbil_cd_cmm_doc_code ,
       inol.inol_cd_progressive_order as fbil_cd_cmm_doc_pos_code ,
       nvl (inol.inol_id_vele_vcl_legacy , -1) as fbil_id_pvan_vcl ,
       inol.inol_cd_sales_order as fbil_cd_sls_ord_code ,
       inol.inol_cd_progressive_order as fbil_cd_sls_ord_pos_code ,
       nvl (inol.inol_id_inoh_invoice_orders_he , -1) as fbil_id_cmm_doc_id ,
       nvl (inol.inol_id_invoice_orders_lines , -1) as fbil_id_cmm_doc_pos_id ,
       inol_cd_document_type as fbil_id_bdty_billing_doc_tp ,
       nvl (to_number (to_char (inol.inol_dt_document_date , 'J')) , 5373484) as fbil_id_time_cmm_doc_date ,
       nvl (inol.inol_id_cust_customer , -1) as fbil_id_cust_payer ,
       nvl (inol.inol_id_cust_customer , -1) as fbil_id_cust_sold ,
       -2 as fbil_id_cuty_customer_type ,
       nvl (vele.vele_id_ledi_legacy_division , -1) as fbil_id_divi_division ,
       nvl (vele.vele_id_hmup_plank_key , -1) as fbil_id_hmup_hmu_product ,
       nvl (tdim_pvan.pvan_id_prat_pr_attributes , -1) as fbil_id_prat_pr_attributes ,
       nvl (tdim_pvan.pvan_id_prpp_prp_product , -1) as fbil_id_prp_prpp_product ,
       5373484 as fbil_id_time_return_date ,
       nvl (to_number (to_char (slor.slor_dt_document_date , 'J')) , 5373484) as fbil_id_time_sales_order_date ,
       nvl (slor.slor_id_sales_order , -1) as fbil_id_sls_ord_id ,
       nvl (sops.sops_id_sales_order_pos , -1) as fbil_id_sls_ord_pos_id ,
       nvl (to_number (to_char (vele.vele_dt_dealer_invoice_date , 'J')) , 5373484) as fbil_id_time_start_billing_dat ,
       inoh.inoh_cd_currency_code as fbil_cd_currency ,
       1 as fbil_id_batch_id ,
       null as fbil_fl_itc_flg ,
       nvl (inoh.inoh_id_cust_customer , -1) as fbil_id_cust_payee ,
       nvl (inoh.inoh_id_cust_customer , -1) as fbil_id_cust_billtoparner ,
       nvl (inoh.inoh_id_cust_customer , -1) as fbil_id_cust_saleschannel ,
       nvl (inoh.inoh_id_cust_customer , -1) as fbil_id_cust_soldtoparner ,
       nvl (inoh.inoh_id_cust_customer , -1) as fbil_id_cust_ownership_group ,
       -2 as fbil_id_addr_ownership_group ,
       inol.inol_cd_business_area_code as fbil_cd_business_area_code ,
       slor.slor_cd_codice_resa as fbil_cd_codice_resa ,
       inol.inol_cd_dealer_code as fbil_cd_dlr_code ,
       inoh.inoh_cd_dealer_order_reference as fbil_cd_dlr_ord_ref ,
       inol.inol_cd_dealer_order_type as fbil_cd_dlr_ord_tp ,
       inol.inol_cd_document_number as fbil_cd_doc_nbr ,
       inol.inol_cd_document_type as fbil_cd_doc_tp ,
       inol.inol_cd_draft_number as fbil_cd_draft_inv_code ,
       inol.inol_cd_engine_number as fbil_cd_eng_nbr ,
       inol.inol_cd_machine_type as fbil_cd_machine_tp ,
       inol.inol_cd_legacy_mkt as fbil_cd_market_legacy ,
       inol.inol_cd_tyres_price_1 as fbil_cd_price_tyres_1 ,
       inol.inol_cd_tyres_price_2 as fbil_cd_price_tyres_2 ,
       inol.inol_cd_price_list as fbil_cd_price_list ,
       inol.inol_cd_tech_type_price as fbil_cd_price_tech_tp ,
       inol.inol_cd_product_class as fbil_cd_product_cl ,
       inol.inol_cd_product_line as fbil_cd_product_line ,
       inol.inol_cd_product_type as fbil_cd_product_tp ,
       inol.inol_cd_progressive_order as fbil_cd_progressive_ord ,
       inol.inol_cd_reference_document_num as fbil_cd_ref_doc_nbr ,
       inol.inol_cd_serial_number as fbil_cd_serial_nbr ,
       inol.inol_cd_shipment_progressive as fbil_cd_shipment_progressive ,
       inol.inol_cd_sales_order as fbil_cd_sls_ord ,
       inol.inol_cd_source_order as fbil_cd_source_ord ,
       inol.inol_cd_source_order_sequence as fbil_cd_source_ord_sequence ,
       inol.inol_cd_standard_card_model as fbil_cd_std_card_mdl ,
       inol.inol_cd_standard_card_tyres as fbil_cd_std_card_tyres ,
       inol.inol_cd_standard_card_version as fbil_cd_std_card_vrs ,
       inol.inol_cd_tech_tp as fbil_cd_tech_tp ,
       5373484 as fbil_id_time_itc_inv_date ,
       inol.inol_fl_invoice_reject_reason as fbil_fl_inv_reject_reason ,
       nvl (to_number (to_char (inol.inol_dt_draft_date , 'J')) , 5373484) as fbil_id_time_draft_inv_date ,
       nvl (inol.inol_id_mark_std_legacy_mkt , -1) as fbil_id_coun_country ,
       inol.inol_cd_source_system as fbil_cd_source_system ,
       case when inol.inol_cd_document_type in ('1') then 1
            else 0 end as fbil_in_wholesale_qty ,
       case when inol.inol_cd_document_type in ('1') then 1
            else 0 end - case when inol.inol_cd_document_type in ('6') then 1
            else 0 end as fbil_in_wholesale_net_qty ,
       case when inol.inol_cd_document_type in ('6') th
FROM   ddwh01_dw.td_inol_invoice_orders_lines inol
    INNER JOIN ddwh02_dim.twrk_pvan_delta_flash_leg delta
        ON delta.vele_id_vehicle_legacy_id_pk = inol.inol_id_vele_vcl_legacy
    INNER JOIN ddwh01_dw.tm_vele_vehicle_legacy vele
        ON vele.vele_id_vehicle_legacy_id_pk = inol.inol_id_vele_vcl_legacy left
    OUTER JOIN (SELECT *
                FROM   (SELECT s.* ,
                               max (s.sops_id_sales_order_pos) OVER (PARTITION BY s.sops_cd_sales_order ,
                                                                                  s.sops_cd_legacy_mkt ,
                                                                                  s.sops_cd_dealer_code ,
                                                                                  s.sops_cd_source_order ,
                                                                                  s.sops_cd_source_order_sequence ,
                                                                                  s.sops_cd_source_system ,
                                                                                  s.sops_cd_product_line ,
                                                                                  s.sops_id_vele_vcl_legacy) as max_id_sops
                        FROM   ddwh01_dw.td_sops_sales_order_position s
                        WHERE  sops_cd_source_system not like '%SAP%')
                WHERE  sops_id_sales_order_pos = max_id_sops) sops
        ON inol.inol_cd_sales_order = sops.sops_cd_sales_order and
           inol.inol_cd_legacy_mkt = sops.sops_cd_legacy_mkt and
           inol.inol_cd_dealer_code = sops.sops_cd_dealer_code and
           inol.inol_cd_source_order = sops.sops_cd_source_order and
           inol.inol_cd_source_order_sequence = sops.sops_cd_source_order_sequence and
           inol.inol_cd_source_system = sops.sops_cd_source_system and
           inol.inol_cd_product_line = sops.sops_cd_product_line and
           inol.inol_id_vele_vcl_legacy = sops.sops_id_vele_vcl_legacy left
    OUTER JOIN ddwh01_dw.tt_slor_sales_order slor
        ON sops.sops_id_slor_sales_order = slor.slor_id_sales_order left
    OUTER JOIN ddwh01_dw.tt_inoh_invoice_orders_header inoh
        ON inoh.inoh_id_invoice_orders_header = inol.inol_id_inoh_invoice_orders_he left
    OUTER JOIN tdim_pvan_vehicle tdim_pvan
        ON tdim_pvan.pvan_id_vcl = inol.inol_id_vele_vcl_legacy
WHERE  inol.inol_fl_delete_line is null ;