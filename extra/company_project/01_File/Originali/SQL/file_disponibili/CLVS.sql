delete
FROM   th_clvs_claim_version
WHERE  clvs_id_claim_vrs in (SELECT clvs_id_claim_vrs
                             FROM   (SELECT t.* ,
                                            rank () OVER (PARTITION BY clvs_cd_claim_vrs ,
                                                                       clvs_cd_source_system
                                                          ORDER BY clvs_id_user_modifier desc , clvs_id_claim_vrs asc , rowid) as id_rk
                                     FROM   ddwh01_dw.th_clvs_claim_version t
                                     WHERE  clvs_id_claim_vrs not in (-1 , -2))
                             WHERE  id_rk > 1) ;