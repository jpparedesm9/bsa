
use cobis
go

/************/
/*  SEQNOS  */
/************/

delete cl_seqnos
 where bdatos = 'cob_credito'
   and tabla in ('cr_califica_interna','cr_cobranza','cr_det_est_financiero','cr_est_financiero','cr_etapa','cr_ficha','cr_fuente_recurso',    
                 'cr_hist_credito','cr_imp_documento','cr_linea','cr_microempresa','cr_parametros_fuente','cr_producto_no_cobis','cr_regla',             
                 'cr_seguro_parentesco','cr_seguro_plan','cr_tramite','cr_truta','cr_agenda', 'cr_lista_negra')
go

insert into cobis..cl_seqnos values  ('cob_credito', 'cr_califica_interna',   0, 'ci_codigo_calif')
insert into cobis..cl_seqnos values  ('cob_credito', 'cr_cobranza',           0, 'cr_cobranza_Key')
insert into cobis..cl_seqnos values  ('cob_credito', 'cr_det_est_financiero', 0, 'def_codigo')
insert into cobis..cl_seqnos values  ('cob_credito', 'cr_est_financiero',     0, 'ef_codigo')
insert into cobis..cl_seqnos values  ('cob_credito', 'cr_etapa',              0, 'cr_etapa_key')
insert into cobis..cl_seqnos values  ('cob_credito', 'cr_ficha',              0, 'cr_ficha_Key')
insert into cobis..cl_seqnos values  ('cob_credito', 'cr_fuente_recurso',     0, 'fr_codigo_fuente')
insert into cobis..cl_seqnos values  ('cob_credito', 'cr_hist_credito',       0, 'cr_hist_credito_Key')
insert into cobis..cl_seqnos values  ('cob_credito', 'cr_imp_documento',      0, 'cr_imp_documento_Key')
insert into cobis..cl_seqnos values  ('cob_credito', 'cr_linea',              0, 'cr_linea_Key')
insert into cobis..cl_seqnos values  ('cob_credito', 'cr_microempresa',       0, 'mi_codigo_mic')
insert into cobis..cl_seqnos values  ('cob_credito', 'cr_parametros_fuente',  0, 'pf_codigo_par')
insert into cobis..cl_seqnos values  ('cob_credito', 'cr_producto_no_cobis',  0, 'cr_producto_no_cobis_Key')
insert into cobis..cl_seqnos values  ('cob_credito', 'cr_regla',              0, 'cr_regla_key')
insert into cobis..cl_seqnos values  ('cob_credito', 'cr_seguro_parentesco',  0, 'sp_codigo')
insert into cobis..cl_seqnos values  ('cob_credito', 'cr_seguro_plan',        0, 'sp_codigo')
insert into cobis..cl_seqnos values  ('cob_credito', 'cr_tramite',            0, 'cr_tramite_pkey')
insert into cobis..cl_seqnos values  ('cob_credito', 'cr_truta',              0, 'cr_truta_key')
insert into cobis..cl_seqnos values  ('cob_credito', 'cr_agenda',             0, 'ag_visita_key')
insert into cobis..cl_seqnos values  ('cob_credito', 'cr_lista_negra',        0, 'cr_lista_negra_key')
go

