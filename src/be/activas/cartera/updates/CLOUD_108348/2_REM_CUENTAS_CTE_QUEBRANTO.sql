

use cob_conta
go 

declare 
@w_codvalor_objetado  int ,
@w_codvalor_quebranto int ,
@w_asiento_objetado   int ,
@w_asiento_quebranto  int 

--CODIGO VALOR TOMADOS DE PRODUCCION
select 
@w_codvalor_objetado  = 142,
@w_codvalor_quebranto = 143


--118442
--COD VAL OBJETADO
delete cob_cartera..ca_producto where cp_producto = 'OBJETADO'
   

insert into cob_cartera..ca_producto(
cp_producto  ,cp_descripcion     , cp_categoria, 
cp_moneda    ,cp_codvalor        , cp_desembolso, 
cp_pago      ,cp_atx             , cp_retencion, 
cp_pago_aut  ,cp_pcobis          , cp_producto_reversa, 
cp_afectacion,cp_estado          , cp_act_pas, 
cp_instrum_SB, cp_canal) 
values(	 
'OBJETADO' ,'OBJETADO'		     ,'OTRO'      
, 0        ,@w_codvalor_objetado , 'N'        ,  
'S'        ,'N'                  ,0           , 
'N'        ,NULL                 ,'OBJETADO'  , 
'D'        ,'V'                  , 'T'        , 
NULL       ,NULL ) 


delete cob_cartera..ca_producto where cp_producto = 'QUEBRANTO'
   
 --COD VAL QUEBRANTO  
insert into cob_cartera..ca_producto(
cp_producto  ,cp_descripcion        , cp_categoria, 
cp_moneda    ,cp_codvalor           , cp_desembolso, 
cp_pago      ,cp_atx                , cp_retencion, 
cp_pago_aut  ,cp_pcobis             , cp_producto_reversa, 
cp_afectacion,cp_estado             , cp_act_pas, 
cp_instrum_SB, cp_canal) 
values(
'QUEBRANTO' ,'QUEBRANTO'            ,'OTRO'      
, 0        , @w_codvalor_quebranto  , 'N'        ,  
'S'        ,'N'                     ,0           , 
'N'        ,NULL                    ,'QUEBRANTO' , 
'D'        ,'V'                     , 'T'        , 
NULL       , NULL)



delete  cob_cartera..ca_tipo_trn where tt_codigo = 'REG'

insert into cob_cartera..ca_tipo_trn (tt_codigo, tt_descripcion, tt_reversa, tt_contable)
values ('REG', 'REGULARIZACION PAGOS OBJETADOS', 'N', 'S')




--DETALLE DE  PERFIL 


select @w_asiento_objetado = max(dp_asiento) + 1 
from cb_det_perfil
where dp_producto = 7 
and dp_perfil ='CCA_RPA'
 
select @w_asiento_quebranto = @w_asiento_objetado +1 

delete cb_det_perfil where dp_perfil = 'CCA_RPA' and dp_codval in (  @w_codvalor_objetado,@w_codvalor_quebranto) 

insert into dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
values ( 1, 7, 'CCA_RPA', @w_asiento_objetado, 'F_PAGO', 'CTB_OF', '1', @w_codvalor_objetado, 'N', 'O', NULL, 'L')

insert into dbo.cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
values (1, 7, 'CCA_RPA',@w_asiento_quebranto, 'F_PAGO', 'CTB_OF', '1', @w_codvalor_quebranto, 'N', 'O', NULL, 'L')


--TIPO_TRN
delete  cob_cartera..ca_trn_oper where to_tipo_trn = 'REG'

select * into #tipo_trn from cob_cartera..ca_trn_oper where to_tipo_trn = 'RPA'


update  #tipo_trn set 
to_tipo_trn = 'REG',
to_perfil   = 'CCA_RPA'

update cb_det_perfil set 
dp_origen_dest = 'D'
where dp_perfil in ( 'CCA_RPA','CCA_PAG')


insert into cob_cartera..ca_trn_oper
select * from #tipo_trn




--REL PARAM 


delete cb_relparam where re_clave in ( 'OBJETADO' , 'QUEBRANTO' )
   
   
insert into dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
values (1, 'F_PAGO', 'OBJETADO', '14019006', 7, 'CTB_OF', 'D')


insert into dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
values (1, 'F_PAGO', 'QUEBRANTO', '50502604', 7, 'CTB_OF', 'D')



delete  cob_cartera..ca_corresponsal where co_nombre in ( 'OBJETADO', 'QUEBRANTO')
   
insert into  cob_cartera..ca_corresponsal (co_id, co_nombre, co_descripcion, co_token_validacion, co_sp_generacion_ref, co_sp_validacion_ref, co_estado, co_tiempo_aplicacion_pag_rev)
values ('8', 'OBJETADO', 'OBJETADO', NULL, 'cob_cartera..sp_santander_val_ref', 'cob_cartera..sp_santander_val_ref', 'A', 5)


insert into  cob_cartera..ca_corresponsal (co_id, co_nombre, co_descripcion, co_token_validacion, co_sp_generacion_ref, co_sp_validacion_ref, co_estado, co_tiempo_aplicacion_pag_rev)
values ('9', 'QUEBRANTO', 'OBJETADO', NULL, 'cob_cartera..sp_santander_val_ref', 'cob_cartera..sp_santander_val_ref', 'A', 5)


--cuenta proceso
delete cob_conta..cb_cuenta_proceso where cp_cuenta = '14019006'
insert into cob_conta..cb_cuenta_proceso (cp_proceso, cp_empresa, cp_cuenta, cp_oficina, cp_area, cp_imprima, cp_condicion, cp_texto, cp_quiebre)
values (6003, 1, '14019006', 0, 0, '0', '1', '', '')


--plan general 
delete cob_conta..cb_plan_general where pg_cuenta = '14019006'

select * into #cb_plan_general2 from cob_conta..cb_plan_general where pg_cuenta = '14019004'

update #cb_plan_general2 set 
pg_cuenta = '14019006'

update #cb_plan_general2 set 
pg_clave = ltrim(rtrim(pg_cuenta))+ltrim(rtrim(convert(varchar,pg_oficina)))+ltrim(rtrim(convert(varchar,pg_area)))

insert into cob_conta..cb_plan_general 
select * from #cb_plan_general2




--

delete  cob_conta..cb_codigo_valor where cv_codval in ( 142,143)

INSERT INTO dbo.cb_codigo_valor (cv_empresa, cv_producto, cv_codval, cv_descripcion)
VALUES (1, 7, 142, 'OBJETADO')


INSERT INTO dbo.cb_codigo_valor (cv_empresa, cv_producto, cv_codval, cv_descripcion)
VALUES (1, 7, 143, 'QUEBRANTO')




--VERIFICADOR 

select 'DESPUES',* from cob_cartera..ca_producto where cp_producto = 'OBJETADO'
select 'DESPUES',* from cob_cartera..ca_producto where cp_producto = 'QUEBRANTO'
select 'DESPUES',* from cob_conta..cb_cuenta where cu_empresa = 1 and cu_cuenta in( '14019006','14019004')
select 'DESPUES',* from cb_det_perfil where  dp_perfil = 'CCA_RPA'  and dp_codval in ( @w_codvalor_objetado,@w_codvalor_quebranto)
select 'DESPUES',* from cb_relparam where re_clave in ( 'OBJETADO' , 'QUEBRANTO' )
select 'DESPUES',* FROM cob_conta..cb_cuenta_proceso where cp_cuenta in( '14019006','14019004')
select 'DESPUES',* FROM  cob_conta..cb_plan_general where pg_cuenta in( '14019006','14019004') order by pg_oficina
select 'DESPUES',* from  cob_conta..cb_codigo_valor where cv_codval in ( @w_codvalor_objetado,@w_codvalor_quebranto)
select 'DESPUES',* from cob_cartera..ca_trn_oper where to_tipo_trn = 'REG'


drop table  #cb_plan_general2
drop table #tipo_trn
go 



















