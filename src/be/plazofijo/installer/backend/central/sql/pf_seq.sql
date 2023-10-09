/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de secuenciales                                */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  07/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cobis
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

print '**************************************'
print '*****  CREACION DE SECUENCIALES ******'
print '**************************************'
print ''
print 'Inicio Ejecucion Creacion de Secuenciales Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''

print '-->Secuenciales: Insercion'
if exists (select 1 from cobis..cl_seqnos where tabla like 'pf_%')
   delete from cobis..cl_seqnos where tabla like 'pf_%'
go

insert into cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_pfijo',	'pf_cancelacion'        , 0  , 'canc_secuencial'       )
insert into cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_pfijo',	'pf_cliente_externo'    , 0  , 'ce_secuencial'         )
insert into cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_pfijo',	'pf_fpago'              , 0  , 'fp_tipo_fpago'         )
insert into cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_pfijo',	'pf_funcionario'        , 0  , 'fu_secuencial'         )
insert into cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_pfijo',	'pf_hist_tasa'          , 0  , 'ht_secuencial'         )
insert into cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_pfijo',	'pf_hist_tasa_variable' , 0  , 'hv_secuencial'         )
insert into cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_pfijo',	'pf_incre_op'           , 0  , 'io_secuencial'         )
insert into cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_pfijo',	'pf_limite'             , 0  , 'li_secuencial'         )
insert into cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_pfijo',	'pf_monto'              , 0  , 'mo_tipo_monto'         )
insert into cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_pfijo',	'pf_npreimpreso'        , 0  , 'np_preimpreso'         )
insert into cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_pfijo',	'pf_operacion'          , 0  , 'op_operacion'          )
insert into cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_pfijo',	'pf_plazo'              , 0  , 'pl_tipo_plazo'         )
insert into cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_pfijo',	'pf_scomprobante'       , 0  , 'sc_scomprobante'       )
insert into cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_pfijo',	'pf_sec_custodia'       , 0  , 'se_custodia'           )
insert into cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_pfijo',	'pf_sec_lev_custodia'   , 0  , 'se_lev_custodia'       )
insert into cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_pfijo',	'pf_tipo_deposito'      , 0  , 'td_tipo_deposito'      )
insert into cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_pfijo',	'pf_transferencias'     , 0  , 'tr_cod_transf'         )
insert into cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_pfijo', 'pf_rango_prorroga'     , 100, 'rp_tipo_rango'         )
insert into cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_pfijo', 'pf_carga_archivo_tasas', 1  , 'cat_secuencial_archivo')
go

print ''
print 'Fin Ejecucion Creacion de Secuenciales Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''