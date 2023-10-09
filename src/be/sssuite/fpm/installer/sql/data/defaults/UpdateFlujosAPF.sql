UPDATE cob_fpm..fp_processbyproducthistory
SET pph_flow_id = convert(varchar,pr.pr_codigo_proceso)
FROM cob_fpm..fp_processbyproducthistory pp, cob_workflow..wf_proceso pr
WHERE pp.pph_processname = pr.pr_nombre_proceso

UPDATE cob_fpm..fp_processbyproduct
SET pp_flow_id = convert(varchar,pr.pr_codigo_proceso)
FROM cob_fpm..fp_processbyproduct pp, cob_workflow..wf_proceso pr
WHERE pp.pp_processname = pr.pr_nombre_proceso

go

UPDATE cob_fpm..fp_amountitemvalues
SET aiv_policy_id  = rl.rl_id
FROM cob_fpm..fp_amountitemvalues aa, cob_pac..bpl_rule rl
WHERE aa.aiv_policyname = rl.rl_name

UPDATE cob_fpm..fp_amountitemvalueshistory
SET aivh_policy_id  = rl.rl_id
FROM cob_fpm..fp_amountitemvalueshistory aa, cob_pac..bpl_rule rl
WHERE aa.aivh_policyname = rl.rl_name

go

