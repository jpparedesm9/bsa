/************************************************************************/
/*  Archivo:                        sp_traslada_ah_cuenta.sp            */
/*  Stored procedure:               sp_traslada_ah_cuenta               */
/*  Base de Datos:                  cob_externos                        */
/*  Producto:                       AHORROS                             */
/************************************************************************/
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                      PROPOSITO                                       */
/* Realiza el traspaso de las tablas MIGs a las tablas definitivas      */
/************************************************************************/
use cob_externos
go

if exists(select 1 from sysobjects where name = 'sp_traslada_ah_cuenta')
    drop proc sp_traslada_ah_cuenta
go

create proc sp_traslada_ah_cuenta(
    @i_clave_i            int          = null,
    @i_clave_f            int          = null
)
as
declare
  @w_conteo             int,
  @w_det_producto       int,
  @w_comentario         descripcion,
  @w_autorizante        smallint

select @i_clave_i    = @i_clave_i + 1,
       @w_comentario = 'APERTURA CUENTA DE AHORROS MIGRACION'
       
select @w_autorizante = fu_funcionario
from   cobis..cl_funcionario
where  fu_login = 'sa'
 
select @w_conteo = count(1)
from   ah_cuenta_mig
where  ah_cuenta between @i_clave_i and @i_clave_f
and    ah_estado_mig = 'VE'

if @w_conteo = 0  return 0
   
-- ------------------------------------------------------------------
-- - Cargo tabla definitiva
-- ------------------------------------------------------------------
insert into cob_ahorros..ah_cuenta
       (ah_cuenta          ,ah_cta_banco           ,ah_estado             ,ah_control            ,ah_filial           ,ah_oficina        ,
       ah_producto         ,ah_tipo ,ah_moneda     ,ah_fecha_aper         ,ah_oficial            ,ah_cliente          ,ah_ced_ruc        ,
       ah_nombre           ,ah_categoria           ,ah_tipo_promedio      ,ah_capitalizacion     ,ah_ciclo            ,ah_suspensos      ,
       ah_bloqueos         ,ah_condiciones         ,ah_monto_bloq         ,ah_num_blqmonto       ,ah_cred_24          ,ah_cred_rem       ,
       ah_tipo_def         ,ah_default             ,ah_rol_ente           ,ah_disponible         ,ah_12h              ,ah_12h_dif        ,
       ah_24h              ,ah_48h                 ,ah_remesas,ah_rem_hoy ,ah_interes            ,ah_interes_ganado   ,ah_saldo_libreta  ,
       ah_saldo_interes    ,ah_saldo_anterior      ,ah_saldo_ult_corte    ,ah_saldo_ayer         ,ah_creditos         ,ah_debitos        ,
       ah_creditos_hoy     ,ah_debitos_hoy         ,ah_fecha_ult_mov      ,ah_fecha_ult_mov_int  ,ah_fecha_ult_upd    ,ah_fecha_prx_corte,
       ah_fecha_ult_corte  ,ah_fecha_ult_capi      ,ah_fecha_prx_capita   ,ah_linea,ah_ult_linea ,ah_cliente_ec       ,ah_direccion_ec   ,
       ah_descripcion_ec   ,ah_tipo_dir,ah_agen_ec ,ah_parroquia          ,ah_zona               ,ah_prom_disponible  ,ah_promedio1      ,
       ah_promedio2        ,ah_promedio3           ,ah_promedio4          ,ah_promedio5          ,ah_promedio6        ,ah_personalizada  ,
       ah_contador_trx     ,ah_cta_funcionario     ,ah_tipocta            ,ah_prod_banc          ,ah_origen           ,ah_numlib         ,
       ah_dep_ini          ,ah_contador_firma      ,ah_telefono           ,ah_int_hoy            ,ah_tasa_hoy         ,ah_min_dispmes    ,
       ah_fecha_ult_ret    ,ah_cliente1            ,ah_nombre1            ,ah_cedruc1            ,ah_sector           ,ah_monto_imp      ,
       ah_monto_consumos   ,ah_ctitularidad        ,ah_promotor           ,ah_int_mes            ,ah_tipocta_super    ,ah_direccion_dv   ,
       ah_descripcion_dv   ,ah_tipodir_dv          ,ah_parroquia_dv       ,ah_zona_dv            ,ah_agen_dv          ,ah_cliente_dv     ,
       ah_traslado         ,ah_aplica_tasacorp     ,ah_monto_emb          ,ah_monto_ult_capi     ,ah_saldo_mantval    ,ah_cuota          ,
       ah_creditos2        ,ah_creditos3           ,ah_creditos4          ,ah_creditos5          ,ah_creditos6        ,ah_debitos2       ,
       ah_debitos3         ,ah_debitos4            ,ah_debitos5           ,ah_debitos6           ,ah_tasa_ayer        ,ah_estado_cuenta  ,
       ah_permite_sldcero  ,ah_rem_ayer            ,ah_numsol             ,ah_patente            ,ah_fideicomiso      ,ah_nxmil          ,
       ah_clase_clte       ,ah_deb_mes_ant         ,ah_cred_mes_ant       ,ah_num_deb_mes        ,ah_num_cred_mes     ,ah_num_con_mes    ,
       ah_num_deb_mes_ant  ,ah_num_cred_mes_ant    ,ah_num_con_mes_ant    ,ah_fecha_ult_proceso)   
select nc_cuenta           ,nc_cta_banco           ,ah_estado             ,ah_control            ,ah_filial           ,ah_oficina        ,
       ah_producto         ,ah_tipo,ah_moneda      ,ah_fecha_aper         ,ah_oficial            ,ah_cliente          ,ah_ced_ruc        ,
       ah_nombre           ,ah_categoria           ,ah_tipo_promedio      ,ah_capitalizacion     ,ah_ciclo            ,ah_suspensos      ,
       ah_bloqueos         ,ah_condiciones         ,ah_monto_bloq         ,ah_num_blqmonto       ,ah_cred_24          ,ah_cred_rem       ,
       ah_tipo_def         ,ah_default             ,ah_rol_ente           ,ah_disponible         ,ah_12h              ,ah_12h_dif        ,
       ah_24h              ,ah_48h                 ,ah_remesas,ah_rem_hoy ,ah_interes            ,ah_interes_ganado   ,ah_saldo_libreta  ,
       ah_saldo_interes    ,ah_saldo_anterior      ,ah_saldo_ult_corte    ,ah_saldo_ayer         ,ah_creditos         ,ah_debitos        ,
       ah_creditos_hoy     ,ah_debitos_hoy         ,ah_fecha_ult_mov      ,ah_fecha_ult_mov_int  ,ah_fecha_ult_upd    ,ah_fecha_prx_corte,
       ah_fecha_ult_corte  ,ah_fecha_ult_capi      ,ah_fecha_prx_capita   ,ah_linea,ah_ult_linea ,ah_cliente_ec       ,ah_direccion_ec   ,
       ah_descripcion_ec   ,ah_tipo_dir,ah_agen_ec ,ah_parroquia          ,ah_zona               ,ah_prom_disponible  ,ah_promedio1      ,
       ah_promedio2        ,ah_promedio3           ,ah_promedio4          ,ah_promedio5          ,ah_promedio6        ,ah_personalizada  ,
       ah_contador_trx     ,ah_cta_funcionario     ,ah_tipocta            ,ah_prod_banc          ,ah_origen           ,ah_numlib         ,
       ah_dep_ini          ,ah_contador_firma      ,ah_telefono           ,ah_int_hoy            ,ah_tasa_hoy         ,ah_min_dispmes    ,
       ah_fecha_ult_ret    ,ah_cliente1            ,ah_nombre1            ,ah_cedruc1            ,ah_sector           ,ah_monto_imp      ,
       ah_monto_consumos   ,ah_ctitularidad        ,ah_promotor           ,ah_int_mes            ,ah_tipocta_super    ,ah_direccion_dv   ,
       ah_descripcion_dv   ,ah_tipodir_dv          ,ah_parroquia_dv       ,ah_zona_dv            ,ah_agen_dv          ,ah_cliente_dv     ,
       ah_traslado         ,ah_aplica_tasacorp     ,ah_monto_emb          ,ah_monto_ult_capi     ,ah_saldo_mantval    ,ah_cuota          ,
       ah_creditos2        ,ah_creditos3           ,ah_creditos4          ,ah_creditos5          ,ah_creditos6        ,ah_debitos2       ,
       ah_debitos3         ,ah_debitos4            ,ah_debitos5           ,ah_debitos6           ,ah_tasa_ayer        ,ah_estado_cuenta  ,
       ah_permite_sldcero  ,ah_rem_ayer            ,ah_numsol             ,ah_patente            ,ah_fideicomiso      ,ah_nxmil          ,
       ah_clase_clte       ,ah_deb_mes_ant         ,ah_cred_mes_ant       ,ah_num_deb_mes        ,ah_num_cred_mes     ,ah_num_con_mes    ,
       ah_num_deb_mes_ant  ,ah_num_cred_mes_ant    ,ah_num_con_mes_ant    ,ah_fecha_ult_proceso
from   ah_cuenta_mig b, ah_numero_cuenta 
where  ah_cuenta = nc_cuenta_mig 
and    ah_cuenta between @i_clave_i and @i_clave_f
and    ah_estado_mig = 'VE'
         
if @@error <> 0
begin
    insert into ah_log_mig
    select top 1 convert(varchar, ah_cuenta),
           'ah_cuenta',
           convert(varchar, @i_clave_i),
           convert(varchar, @i_clave_f),
           convert(varchar, ah_cuenta),
           124,
           ah_cuenta,
           ah_cta_banco
    from   ah_cuenta_mig
end
/*
update cobis..cl_seqnos set siguiente = (select isnull(max(ah_cuenta),0) + 1 from cob_ahorros..ah_cuenta)
where  bdatos = 'cob_ahorros'
and    tabla  = 'ah_cuenta'    */
            
----------------------------------------
--INSERT EN LA ah_cuenta_aux
----------------------------------------
insert into cob_ahorros..ah_cuenta_aux
      (ca_cuenta  , ca_cta_banco, ca_cta_banco_rel  , ca_saldo_max  , ca_dias_plazo  , ca_cta_banco_mig, ca_fecha_mig)
select nc_cuenta  , nc_cta_banco, b.ah_cta_banco_rel, b.ah_saldo_max, b.ah_dias_plazo, nc_cta_banco_mig, getdate()
from   ah_cuenta_mig b, ah_numero_cuenta 
where  ah_cuenta between @i_clave_i and @i_clave_f
and    ah_cuenta     = nc_cuenta_mig 
and    ah_estado_mig = 'VE'

update ca
set    ca.ca_cta_banco_rel = (select x.nc_cta_banco from cob_externos..ah_numero_cuenta x where x.nc_cta_banco_mig = ca.ca_cta_banco_rel)
from   cob_ahorros..ah_cuenta_aux ca, cob_externos..ah_numero_cuenta nc
where  ca.ca_cta_banco = nc.nc_cta_banco
and    nc_cuenta between @i_clave_i and @i_clave_f
and    ca_cta_banco_rel is not null 


----------------------------------------
--INSERT MASIVO A LA  cl_det_producto
----------------------------------------
select @w_det_producto = siguiente + 1 
from   cobis..cl_seqnos
where  tabla = 'cl_det_producto'
         
insert into cobis..cl_det_producto
        (dp_det_producto              , dp_filial     ,  dp_oficina     , dp_producto      , dp_tipo            , dp_moneda, 
         dp_fecha                     , dp_comentario ,  dp_monto       , dp_tiempo        , dp_cuenta          , dp_estado_ser,
         dp_autorizante               , dp_oficial_cta,  dp_cliente_ec  , dp_direccion_ec  , dp_descripcion_ec  , dp_fecha_cambio)
select   @w_det_producto + nc_ctasec  , 1             ,  a.ah_oficina   , 4                , 'R'                , a.ah_moneda, 
         getdate()                    , @w_comentario ,  a.ah_disponible, NULL             , nc_cta_banco     , 'V',
         @w_autorizante               , a.ah_oficial  ,  a.ah_cliente   , a.ah_direccion_ec, a.ah_descripcion_ec, a.ah_fecha_aper
from     cob_ahorros..ah_cuenta a, ah_numero_cuenta
where    ah_cuenta = nc_cuenta 
and      nc_cuenta_mig between @i_clave_i and @i_clave_f 
order by a.ah_cuenta

if @@error <> 0
begin
    insert into ah_log_mig
        select top 1 convert(varchar, ah_cuenta),
               'ah_cuenta',
               'sp_traslada_ah_cuenta',
               'INS',
               convert(varchar, ah_cuenta),
               125,
               ah_cuenta,
               ah_cta_banco
        from   ah_cuenta_mig
end

update cobis..cl_seqnos set siguiente = (select isnull(max(dp_det_producto),0) from cobis..cl_det_producto)
where  bdatos = 'cobis'
and    tabla  = 'cl_det_producto' 

----------------------------------------
--INSERT MASIVO A LA  cl_cliente
----------------------------------------
insert into cobis..cl_cliente (cl_cliente, cl_det_producto, cl_rol, cl_ced_ruc, cl_fecha)
select ah_cliente, dp_det_producto, 'T', ah_ced_ruc, convert(varchar(10),dp_fecha,101)
from   cobis..cl_det_producto, cob_ahorros..ah_cuenta, ah_numero_cuenta
where  dp_cuenta = ah_cta_banco 
and    ah_cuenta = nc_cuenta 
and    nc_cuenta_mig between @i_clave_i and @i_clave_f 

----------------------------------------
--INSERT MASIVO A LA  ah_datos_adic
----------------------------------------
insert into cob_ahorros..ah_datos_adic
        (da_cta_banco,   da_fecha_ingreso,     da_fecha_ult_modif, da_usuario,
         da_dep_inicial, da_forma_dep_inicial, da_origen_fondos,   da_proposito_cuenta, 
         da_prod_cobis1)
select   ah_cta_banco,    ah_fecha_aper,       ah_fecha_aper,      'migracion',
         0,               '',                '1',                '1', 
         'AHO'
from     cob_ahorros..ah_cuenta, ah_numero_cuenta 
where    ah_cuenta = nc_cuenta
and      nc_cuenta_mig between @i_clave_i and @i_clave_f     
order by ah_cuenta 
 
if @@error <> 0
begin            
    insert into ah_log_mig
    select top 1 convert(varchar, ah_cuenta),
           'ah_cuenta',
           'sp_traslada_ah_cuenta',
           'INS',
           convert(varchar, ah_cuenta),
           231,
           ah_cuenta,
           ah_cta_banco
    from   ah_cuenta_mig
end


---------------------------------------------
--NUEVO PROCESO cob_ahorros..ah_cuenta_tmp 
---------------------------------------------
insert into cob_ahorros..ah_cuenta_tmp 
( 
ah_cuenta               ,ah_cta_banco           ,
ah_estado               ,ah_control             ,ah_filial              ,ah_oficina             , 
ah_producto             ,ah_tipo                ,ah_moneda              ,ah_fecha_aper          ,ah_oficial             ,ah_cliente           , 
ah_ced_ruc              ,ah_nombre              ,ah_categoria           ,ah_tipo_promedio       ,ah_capitalizacion      ,ah_ciclo             ,
ah_suspensos            ,ah_bloqueos            ,ah_condiciones         ,ah_monto_bloq          ,ah_num_blqmonto        ,ah_cred_24           ,
ah_cred_rem             ,ah_tipo_def            ,ah_default             ,ah_rol_ente            ,ah_disponible          ,ah_12h               ,
ah_12h_dif              ,ah_24h                 ,ah_48h                 ,ah_remesas             ,ah_rem_hoy             ,ah_interes           ,
ah_interes_ganado       ,ah_saldo_libreta       ,ah_saldo_interes       ,ah_saldo_anterior      ,ah_saldo_ult_corte     ,ah_saldo_ayer        ,
ah_creditos             ,ah_debitos             ,ah_creditos_hoy        ,ah_debitos_hoy         ,ah_fecha_ult_mov       ,ah_fecha_ult_mov_int ,
ah_fecha_ult_upd        ,ah_fecha_prx_corte     ,ah_fecha_ult_corte     ,ah_fecha_ult_capi      ,ah_fecha_prx_capita    ,ah_linea             ,
ah_ult_linea            ,ah_cliente_ec          ,ah_direccion_ec        ,ah_descripcion_ec      ,ah_tipo_dir            ,ah_agen_ec           ,
ah_parroquia            ,ah_zona                ,ah_prom_disponible     ,ah_promedio1           ,ah_promedio2           ,ah_promedio3         ,
ah_promedio4            ,ah_promedio5           ,ah_promedio6           ,ah_personalizada       ,ah_contador_trx        ,ah_cta_funcionario   ,
ah_tipocta              ,ah_prod_banc           ,ah_origen              ,ah_numlib              ,ah_dep_ini             ,ah_contador_firma    ,
ah_telefono             ,ah_int_hoy             ,ah_tasa_hoy            ,ah_min_dispmes         ,ah_fecha_ult_ret       ,ah_cliente1          ,
ah_nombre1              ,ah_cedruc1             ,ah_sector              ,ah_monto_imp           ,ah_monto_consumos      ,ah_ctitularidad      ,
ah_promotor             ,ah_int_mes             ,ah_tipocta_super       ,ah_direccion_dv        ,ah_descripcion_dv      ,ah_tipodir_dv        ,
ah_parroquia_dv         ,ah_zona_dv             ,ah_agen_dv             ,ah_cliente_dv          ,ah_traslado            ,ah_aplica_tasacorp   ,
ah_monto_emb            ,ah_monto_ult_capi      ,ah_saldo_mantval       ,ah_cuota               ,ah_creditos2           ,ah_creditos3         ,
ah_creditos4            ,ah_creditos5           ,ah_creditos6           ,ah_debitos2            ,ah_debitos3            ,ah_debitos4          ,
ah_debitos5             ,ah_debitos6            ,ah_tasa_ayer           ,ah_estado_cuenta       ,ah_permite_sldcero     ,ah_rem_ayer          ,
ah_numsol               ,ah_patente             ,ah_fideicomiso         ,ah_nxmil               ,ah_clase_clte          ,ah_deb_mes_ant       ,
ah_cred_mes_ant         ,ah_num_deb_mes         ,ah_num_cred_mes        ,ah_num_con_mes         ,ah_num_deb_mes_ant     ,ah_num_cred_mes_ant  ,
ah_num_con_mes_ant      ,ah_fecha_ult_proceso)
select 
nc.nc_cuenta            ,nc.nc_cta_banco        ,
b.ah_estado             ,b.ah_control           ,b.ah_filial            ,b.ah_oficina           ,                                              
b.ah_producto           ,b.ah_tipo              ,b.ah_moneda            ,b.ah_fecha_aper        ,b.ah_oficial           ,b.ah_cliente         , 
b.ah_ced_ruc            ,b.ah_nombre            ,b.ah_categoria         ,b.ah_tipo_promedio     ,b.ah_capitalizacion    ,b.ah_ciclo           , 
b.ah_suspensos          ,b.ah_bloqueos          ,b.ah_condiciones       ,b.ah_monto_bloq        ,b.ah_num_blqmonto      ,b.ah_cred_24         , 
b.ah_cred_rem           ,b.ah_tipo_def          ,b.ah_default           ,b.ah_rol_ente          ,b.ah_disponible        ,b.ah_12h             , 
b.ah_12h_dif            ,b.ah_24h               ,b.ah_48h               ,b.ah_remesas           ,b.ah_rem_hoy           ,b.ah_interes         , 
b.ah_interes_ganado     ,b.ah_saldo_libreta     ,b.ah_saldo_interes     ,b.ah_saldo_anterior    ,b.ah_saldo_ult_corte   ,b.ah_saldo_ayer      , 
b.ah_creditos           ,b.ah_debitos           ,b.ah_creditos_hoy      ,b.ah_debitos_hoy       ,b.ah_fecha_ult_mov     ,ah_fecha_ult_mov_int , 
b.ah_fecha_ult_upd      ,b.ah_fecha_prx_corte   ,b.ah_fecha_ult_corte   ,b.ah_fecha_ult_capi    ,b.ah_fecha_prx_capita  ,b.ah_linea           , 
b.ah_ult_linea          ,b.ah_cliente_ec        ,b.ah_direccion_ec      ,b.ah_descripcion_ec    ,b.ah_tipo_dir          ,b.ah_agen_ec         , 
b.ah_parroquia          ,b.ah_zona              ,b.ah_prom_disponible   ,b.ah_prom_disponible   ,b.ah_promedio2         ,b.ah_promedio3       , 
b.ah_promedio4          ,b.ah_promedio5         ,b.ah_promedio6         ,b.ah_personalizada     ,b.ah_contador_trx      ,b.ah_cta_funcionario , 
b.ah_tipocta            ,b.ah_prod_banc         ,b.ah_origen            ,b.ah_numlib            ,b.ah_dep_ini           ,b.ah_contador_firma  , 
b.ah_telefono           ,b.ah_int_hoy           ,b.ah_tasa_hoy          ,b.ah_min_dispmes       ,b.ah_fecha_ult_ret     ,b.ah_cliente1        , 
b.ah_nombre1            ,b.ah_cedruc1           ,b.ah_sector            ,b.ah_monto_imp         ,b.ah_monto_consumos    ,b.ah_ctitularidad    , 
b.ah_promotor           ,b.ah_int_mes           ,b.ah_tipocta_super     ,b.ah_direccion_dv      ,b.ah_descripcion_dv    ,b.ah_tipodir_dv      , 
b.ah_parroquia_dv       ,b.ah_zona_dv           ,b.ah_agen_dv           ,b.ah_cliente_dv        ,b.ah_traslado          ,b.ah_aplica_tasacorp , 
b.ah_monto_emb          ,b.ah_monto_ult_capi    ,b.ah_saldo_mantval     ,b.ah_cuota             ,b.ah_creditos2         ,b.ah_creditos3       , 
b.ah_creditos4          ,b.ah_creditos5         ,b.ah_creditos6         ,b.ah_debitos2          ,b.ah_debitos3          ,b.ah_debitos4        , 
b.ah_debitos5           ,b.ah_debitos6          ,b.ah_tasa_ayer         ,b.ah_estado_cuenta     ,b.ah_permite_sldcero   ,b.ah_rem_ayer        , 
b.ah_numsol             ,b.ah_patente           ,b.ah_fideicomiso       ,b.ah_nxmil             ,b.ah_clase_clte        ,b.ah_deb_mes_ant     , 
b.ah_cred_mes_ant       ,b.ah_num_deb_mes       ,b.ah_num_cred_mes      ,b.ah_num_con_mes       ,b.ah_num_deb_mes_ant   ,b.ah_num_cred_mes_ant, 
b.ah_num_con_mes_ant    ,b.ah_fecha_ult_proceso
from  ah_cuenta_mig b 
inner join ah_numero_cuenta nc on ( b.ah_cuenta = nc.nc_cuenta_mig )
where b.ah_cuenta between @i_clave_i and @i_clave_f 
and   b.ah_estado_mig = 'VE' 

if @@error <> 0
begin
    insert into ah_log_mig
    select top 1 convert(varchar, ah_cuenta),
           'ah_cuenta_tmp',
           'sp_traslada_ah_cuenta',
           'INS',
           convert(varchar, ah_cuenta),
           124,
           ah_cuenta,
           ah_cta_banco
    from   ah_cuenta_mig
end 

return  0
go
