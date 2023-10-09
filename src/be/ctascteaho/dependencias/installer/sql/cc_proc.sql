use cobis
go

delete from ad_procedure
 where pd_procedure in (  78,2627,2628,2531, 2532, 94,99,2530,2579,2669,
                          75,  16,2597,2514, 2687, 49,57,011)

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2627,'sp_centro_canje','cob_cuentas','V', getdate(),'cccencanje.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2628,'sp_ofi_canje','cob_cuentas','V',getdate(),'ccoficanje.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2531,'sp_tr_crea_ofibanco','cob_cuentas','V',getdate(),'ccpofiba.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2532,'sp_tr_crea_banco','cob_cuentas','V',getdate(),'ccpbanco.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (94,'sp_tr_tot_caj_adm','cob_cuentas','V',getdate(),'tot_caj_adm.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (99,'sp_tr_cons_tot_ofi_adm','cob_cuentas','V', getdate(),'tot_ofi_adm.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2530, 'sp_tr_crea_rutayt', 'cob_cuentas', 'V', getdate(), 'ccprutat.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2579, 'sp_tr_cons_tot_nal_adm', 'cob_cuentas', 'V', getdate(), 'tr_tot_nac.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (75, 'sp_tr_query_nom_ctacte', 'cob_cuentas', 'V', getdate(), 'ccpconom.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (2669, 'sp_control_efectivo', 'cob_cuentas', 'V', getdate(), 'conefect.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (2597, 'sp_query_excep_sipla', 'cob_cuentas', 'V', getdate(), 'que_exc_sip.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (2514, 'sp_plazas_bco_rep', 'cob_cuentas', 'V', getdate(), 'ccplbrep.sp')

INSERT INTO dbo.ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (16, 'sp_tr_pag_chq_xfr', 'cob_cuentas', 'V', getdate(), 'trpaxfr.sp')

INSERT INTO dbo.ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (78, 'sp_tr_anl_chqr_c', 'cob_cuentas', 'V', getdate(), 'ccpanchc.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (2687, 'sp_causa_ingegr', 'cob_cuentas', 'V', getdate(), 'cccineg.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (49, 'sp_casilla', 'cob_cuentas', 'V', getdate(), 'casi.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (57, 'sp_desc_cliente_cc', 'cobis', 'V', getdate(), 'desclicc.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (011, 'sp_banco', 'cob_cuentas', 'V', getdate(), 'banco.sp')

go

