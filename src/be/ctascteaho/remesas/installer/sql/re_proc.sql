use cobis
go
-- ----------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------COB_REMESAS---------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------
delete cobis..ad_procedure 
 where pd_base_datos = 'cob_remesas' 
   and pd_procedure in (  700, 636, 637, 436, 406, 423, 630, 631, 398, 703,
                          706, 716, 440, 400, 401, 402, 408,2548,  40, 633,
                          472, 614, 459, 460, 709, 414, 704, 705, 396, 397,
                          720, 718, 635,2524, 717, 707, 458, 708,713, 407,
						  710, 7067119)

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (700, 'sp_consulta_alianza', 'cob_remesas', 'V', getdate(), 'consalianza.sp')

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (636, 'sp_mantenca_transfer', 'cob_remesas', 'V', getdate(), 'mantransfer.sp')

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (637, 'sp_mant_transfer', 'cob_remesas', 'V', getdate(), 'ccmantrf.sp')

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (436, 'sp_rem_ayuda', 'cob_remesas', 'V', getdate(), 'remayuda.sp')

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (406, 'sp_rem_consulcar', 'cob_remesas', 'V', getdate(), 'remconscar.sp')

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (423, 'sp_rem_chequexofi', 'cob_remesas', 'V', getdate(), 'remcheqxofi.sp')

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (630, 'sp_rem_cons_chq_eofi', 'cob_remesas', 'V', getdate(), 'remconcheof.sp')

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (631, 'sp_acuse_remesas', 'cob_remesas', 'V', getdate(), 'acusrem.sp')

INSERT INTO cobis..ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (398, 'sp_mantenimiento_cupo_cb', 'cob_remesas', 'V', getdate(), 'pemantcupcb.sp')

INSERT INTO cobis..ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (703, 'sp_devolucion_val_recaudo', 'cob_remesas', 'V', getdate(), 'redevrec.sp')

INSERT INTO cobis..ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (706, 'sp_consolida_trn_cb', 'cob_remesas', 'V', getdate(), 'reconsocb.sp')

INSERT INTO cobis..ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (716, 'sp_mto_aho_contractual', 'cob_remesas', 'V', getdate(), 'remaahco.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (400, 'sp_rem_chequedev', 'cob_remesas', 'V', getdate(), 'rechqdev.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (401, 'sp_rem_confcheque','cob_remesas', 'V', getdate(), 'reconchq.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (402, 'sp_rem_confcarman','cob_remesas', 'V', getdate(), 'recocarm.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (408, 'sp_rem_postfecha', 'cob_remesas', 'V', getdate(), 'reposfch.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (2548, 'sp_tr_mensaje_estcta', 'cob_remesas', 'V', convert(varchar(20) ,getdate(),101), 'tr_estcta.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (40, 'sp_agencia', 'cob_remesas', 'V', getdate(), 'agen.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (633,'sp_novedad_remesas','cob_remesas','V',getdate(),'remnovre.sp')

INSERT INTO dbo.ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (472, 'sp_cons_carta_remesas', 'cob_remesas', 'V', getdate(), 'recocart.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (614, 'sp_ctabco_oficina', 'cob_remesas', 'V', '05/11/2009 04:52:36', 'rectabcta.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (459, 'sp_help_trn_contabilizar', 'cob_remesas', 'V', getdate(), 'rehecont.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (460, 'sp_consulta_prod', 'cob_remesas', 'V', getdate(), 'reprocob.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (709, 'sp_par_perfil', 'cob_remesas', 'V', getdate(), 'reparperfil.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (440, 'sp_cat_bancos', 'cob_remesas', 'V', getdate(), 'cmcatban.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (414, 'sp_oficina_tipo_canje', 'cob_remesas', 'V', getdate(), 'reofican.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (704, 'sp_punto_red_cb', 'cob_remesas', 'V', getdate(), 'reptoredcb.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (705, 'sp_consulta_trn_cb', 'cob_remesas', 'V', getdate(), 'recontrncb.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (396, 'sp_mantenimiento_cb', 'cob_remesas', 'V', getdate(), 're_mantcb.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (397, 'sp_punto_red_cb', 'cob_remesas', 'V', getdate(), 're_puntocb.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (720, 'sp_relacion_cta_canal', 'cob_remesas', 'V', getdate(), 'rerelctacan.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (718, 'sp_caubusq', 'cob_remesas', 'V', getdate(), 'recaubusq.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (635, 'sp_tr_crea_acciond', 'cob_remesas', 'V',  getdate(), 'ccpaccin.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (2524, 'sp_qry_tranms', 'cob_remesas', 'V', getdate(), 'ccqrytms.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (717, 'sp_causal_ndc_oficina', 'cob_remesas', 'V', getdate(), 'causndcofi.sp')

INSERT INTO dbo.ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (707, 'sp_personaliza_ndc', 'cob_remesas', 'V', getdate(), 'reperndc.sp')

INSERT INTO dbo.ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (458, 'sp_mant_trn_contabilizar', 'cob_remesas', 'V', getdate(), 'remtcont.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (708, 'sp_rem_parctocble', 'cob_remesas', 'V', getdate(), 'rem_parctocble')

INSERT INTO cobis..ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (713, 'sp_addhold_locales', 'cob_remesas', 'V', getdate(), 're_addhold.sp')

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (407, 'sp_rem_chequexcta', 'cob_remesas', 'V', getdate(), 'rechqofi.sp')

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (710, 'sp_mto_marca_servicio', 'cob_remesas', 'V', getdate(), 'remtomase.sp')

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES(7067119,'sp_cheq_aprob_rechaz','cob_remesas','V',getdate(),'che_aprrec.sp')

go

