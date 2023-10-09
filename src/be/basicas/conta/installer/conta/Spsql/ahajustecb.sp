/************************************************************************/
/*   Archivo:             ahajustecb.sp                                 */
/*   Stored procedure:    sp_ajuste_cb_aho                              */
/*   Base de datos:       cob_conta                                     */
/*   Producto:            Contabilidad                                  */
/*   Disenado por:        Carlos Avendaño                               */
/*   Fecha de escritura:  Febrero-2014                                  */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/  
/*                           PROPOSITO                                  */  
/*   Este programa maneja el ajuste de corresponsales bancarios para la */
/*   cuenta de proceso 19049500800                                      */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA              AUTOR             RAZON                          */
/* 	04/02/2014		   Carlos Avendaño   Reclasificación de terceros de */
/*                                       ahorros                        */
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_ajuste_cb_aho')
   drop proc sp_ajuste_cb_aho
go

create proc sp_ajuste_cb_aho(
@i_param1 varchar(255), --Empresa
@i_param2 varchar(255)  --Fecha
)

as 
declare 
@i_fecha         datetime,
@i_empresa       tinyint,
@w_cuenta        varchar(24),
@w_cobcb         int,
@w_oficina       smallint,
@w_comprobante   int,
@w_descripcion   varchar(80),
@w_concepto      varchar(80),
@w_usuario       varchar(20),
@w_error         int,
@w_rowcount      int,
@w_sp_name       varchar(32),
@w_observacion   varchar(500),
@w_registro      varchar(500),
@w_s_app         varchar(50),
@w_path          varchar(60),
@w_path_cb       varchar(60),
@w_cmd           varchar(255),
@w_mensaje       varchar(255),
@w_comando       varchar(255),
@w_cabecera      varchar(500)

set nocount on

select @w_sp_name     = 'sp_ajuste_cb_aho',
       @w_comprobante = 0,
       @w_usuario     = 'BANCOR',
       @w_descripcion = 'RECLASIFICACION POR CLIENTES CB',
       @w_concepto    = 'RECLASI. CLIENTE CB',
       @w_error       = 0,
       @w_rowcount    = 0

select  @i_empresa  = convert(tinyint,  @i_param1)
select  @i_fecha    = convert(datetime, @i_param2)

/* PARAMETRO COB CORRESPONSALES */
select @w_cobcb = pa_int
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'CCCNB'

/* IDENTIFICACION DE CUENTAS CONTABLES A AFECTAR */
select cp_cuenta
into #cuentas
from cob_conta..cb_cuenta_proceso
where cp_proceso = 6159

if @@rowcount = 0 begin
   print 'Error no existe cuenta asociada al proceso'
   return 141142 
end

select c.codigo
into #productos
from cobis..cl_tabla t,
     cobis..cl_catalogo c
where t.tabla = 'cb_productos_cb'
and   t.codigo = c.tabla

--Insertamos la interfaz cargada BANCOR en la tabla cb_cartera_bancor_tmp para el proceso de ahorros
insert into cb_cartera_bancor_tmp
select 
sa_empresa                   , sa_producto                  , sa_oficina_dest , 
sa_area_dest                 , sa_fecha_tran                , sa_cuenta       , 
(sa_credito - sa_debito)     , sa_credito_me - sa_debito_me , sa_ente         , 
0                            , sa_documento                 , 0               , 
sa_comprobante               , sa_moneda                    , 'N'             ,
sa_concepto                  , sa_credito                   , sa_debito       ,
sa_credito_me                , sa_debito_me
from   cob_conta_tercero..ct_sasiento a
where  sa_empresa     = 1
and    sa_comprobante > 0
and    sa_fecha_tran  = @i_fecha
and    sa_cuenta      in (select cp_cuenta from #cuentas)
and    sa_concepto    not like '%' + @w_concepto + '%'
and    sa_producto    = 6

if @@ROWCOUNT = 0
begin
   print 'NO EXISTE INTERFAZ BANCOR CARGADA PARA LA FECHA'
   return 601182
end

update cob_conta..cb_cartera_bancor_tmp
set bt_procesado = 'S'
from cob_conta..cb_cartera_bancor_tmp,
     cob_conta..cb_ajuste_cb_log
where ac_fecha    = @i_fecha
and   ac_producto in (select codigo from #productos)
and   ac_ente_cb  = bt_ente 
and   ac_valor    = bt_valor
and   ac_cuenta   = bt_cuenta
and   ac_fecha    = bt_fecha
and   ac_comp_cb  = bt_comp_ext
and   ac_estado   <> 'P'

select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

If @w_s_app is null
begin
   print 'ERROR CARGANDO PARAMETRO BCP'
   return 1000002 
end

select @w_path = pp_path_destino 
from cobis..ba_path_pro
where pp_producto = 204

If @w_path is null
begin
   print  'ERROR CARGANDO LA RUTA BATCH DE DESTINO, REVISAR PARAMETRIZACION'
   return 1000003     
end

 
select @w_path_cb = pa_char 
from cobis..cl_parametro
where pa_nemonico = 'RUTACB'

If @w_path_cb is null
begin
   print 'ERROR CARGANDO LA RUTA BATCH DE DESTINO, REVISAR PARAMETRIZACION'
   return 1000003     
end

--Creamos la cabecera de la tabla ex_convivencia_tmp
select *
into #convivencia_tmp
from cob_externos..ex_convivencia_tmp
where 1=2
--Creamos la cabecera para los comprobantes de ahorros
select 
ah_empresa  = sa_empresa,
ah_producto = sa_producto, 
ah_oficina  = sa_oficina_dest, 
ah_Area     = sa_area_dest, 
ah_Fecha    = sa_fecha_tran, 
ah_Cuenta   = sa_cuenta, 
ah_Valor    = sa_debito - sa_credito,
ah_Valor_me = sa_debito_me - sa_credito_me,
ah_Ente     = sa_ente, 
ah_CB       = 0, 
ah_Documento  = sa_documento, 
ah_Comp_cobis = 0, 
ah_Comp_ext   = 0,
ah_moneda     = sa_moneda
into   #ahorros
from   cob_conta_tercero..ct_sasiento
where  1=2

--Insertamos los comprobantes de ahorro en la tabla temporal
insert into #ahorros
select 
sa_empresa, 
sa_producto, 
sc_oficina_orig, 
sa_area_dest, 
sa_fecha_tran, 
sa_cuenta, 
sa_valor = (sa_debito - sa_credito), 
valor_me = (sa_debito_me - sa_credito_me), 
sa_ente, 
0, --CODIGO CLIENTE CORRESPONSAL
sa_documento, 
sa_comprobante, 
0, -- COMPROBANTE BANCOR SIEMPRE CERO PORQUE NO TENGO DE DONDE SACARLO
sa_moneda
from   cob_conta_tercero..ct_sasiento with (nolock),
       cob_conta_tercero..ct_scomprobante with (nolock),  
	   cobis..cl_oficina with (nolock)
where  sa_empresa                  = @i_empresa
and    sa_comprobante              > 0
and    sa_fecha_tran               = @i_fecha
and    sa_cuenta                   in (select cp_cuenta from #cuentas)
and    sa_producto                 = 4
and    sa_empresa                  = sc_empresa
and    sa_comprobante              = sc_comprobante
and    sa_fecha_tran               = sc_fecha_tran
and    sa_producto                 = sc_producto
and    sc_oficina_orig             = of_oficina
and    of_cob                      = @w_cobcb
and    abs(sa_debito - sa_credito) > 0

--Actualizamos el corresponsal segun la oficina para los comprobantes
update #ahorros
set    ah_CB = ac_cliente
from   #ahorros, cobis..cl_asoc_clte_serv
where  ac_codigo   = ah_oficina

--Realizamos la totalización de comprobantes por CB
select 
at_producto = ah_producto ,
at_oficina  = ah_oficina  ,
at_Area     = ah_Area     ,
at_Fecha    = ah_Fecha    ,
at_Cuenta   = ah_Cuenta   ,
at_Valor    = sum(ah_Valor)    ,
at_Valor_me = sum(isnull(ah_Valor_me, 0)) ,
at_CB       = ah_CB     ,
at_moneda   = ah_moneda 
into #ahorrostot    
from   #ahorros
group by ah_empresa, ah_producto, ah_oficina, ah_Area, ah_Fecha, ah_Cuenta, ah_CB, ah_moneda

Select 
ba_empresa    = bt_empresa, 
ba_producto   = bt_producto,
ba_oficina    = bt_oficina, 
ba_Area       = bt_area,
ba_Fecha      = bt_fecha, 
ba_Cuenta     = bt_cuenta, 
ba_Valor      = sum(bt_valor),
ba_Ente       = bt_ente,
ba_moneda     = bt_moneda,
ba_Comp_cobis = 0
into    #bancor
from   cb_cartera_bancor_tmp
where  bt_fecha     = @i_fecha
and    bt_procesado = 'N'
group by bt_oficina, bt_fecha, bt_cuenta, bt_ente, bt_area, bt_empresa, bt_producto, bt_moneda


select distinct ah_oficina
into #oficinas
from #ahorros
order by ah_oficina

select @w_comprobante = max(ct_comprobante)
from cob_externos..ex_convivencia_tmp
where ct_fecha_tran = @i_fecha
and   ct_cuenta     in (select cp_cuenta from #cuentas)


while 1 = 1 
begin
   select top 1 
   @w_oficina = ah_oficina
   from #oficinas

   if @@rowcount = 0 
      break
   
   delete #oficinas
   where ah_oficina = @w_oficina

   select @w_comprobante = @w_comprobante + 1
   
   begin tran
           
      insert into #convivencia_tmp
      select 
      @w_comprobante,   @i_empresa,        @i_fecha,
      @w_oficina,       ah_Area,              @w_descripcion,
      0,                '',                1,
      ah_Cuenta,           ah_oficina,           ah_Area,
      case when ah_Valor > 0 then ah_Valor else 0 end,        case when ah_Valor < 0 then abs(ah_Valor) else 0 end,      substring(  @w_concepto + ' Com Cob:' + cast (ah_Comp_cobis as varchar) + ' Cli:' + cast(ah_Ente as varchar) + ' Corr:' + cast(ah_CB as varchar),1,80),
      'N',              ah_moneda,            'BANCOR',
      ah_Valor_me,         0,                 1,
      '',               (select en_tipo_ced from cobis..cl_ente where en_ente = ah_Ente), (select en_ced_ruc from cobis..cl_ente where en_ente = ah_Ente),
      '',               0,                 '',
      null,             null,              null,
      'BANCOR'
      from #ahorros 
      where ah_oficina = @w_oficina
   
      union all
      select 
      @w_comprobante,   @i_empresa,        @i_fecha,
      @w_oficina,       ah_Area,              @w_descripcion,
      0,                '',                1,
      ah_Cuenta,           ah_oficina,           ah_Area,
      case when ah_Valor < 0 then abs(ah_Valor) else 0 end,   case when ah_Valor > 0 then ah_Valor else 0 end,         substring(    @w_concepto + ' Com Cob:' + cast (ah_Comp_cobis as varchar) + ' Cli:' + cast(ah_Ente as varchar) + ' Corr:' + cast(ah_CB as varchar),1,80),
      'N',              ah_moneda,            'BANCOR',
      ah_Valor_me,         0,                 1,
      '',               (select en_tipo_ced from cobis..cl_ente where en_ente = ah_CB), (select en_ced_ruc from cobis..cl_ente where en_ente = ah_CB),
      '',               0,                 '',
      null,             null,              null,
      'BANCOR'
      from #ahorros 
      where ah_oficina = @w_oficina
   
      if @@error <> 0 begin
         rollback tran      
         print 'Error en la insercion de Registros en la tabla #convivencia_tmp'
         return 601161    ---Error en insercion de registro
      end

      insert into cob_externos..ex_convivencia_tmp(
      ct_comprobante,   ct_empresa,        ct_fecha_tran,
      ct_oficina_orig,  ct_area_orig,      ct_descripcion,
      ct_automatico,    ct_estado,         ct_asiento,
      ct_cuenta,        ct_oficina_dest,   ct_area_dest,
      ct_credito,       ct_debito,         ct_concepto,
      ct_tipo_doc,      ct_moneda,         ct_usuario_modulo,
      ct_credito_me,    ct_debito_me,      ct_cotizacion,
      ct_tipo_tran,     ct_tipo,           ct_identifica,
      ct_concepto_imp,  ct_base_imp,       ct_documento,
      ct_oper_banco,    ct_cheque,         ct_origen_mvto,
      ct_archivo)
      select 
      ct_comprobante,   ct_empresa,        ct_fecha_tran,
      ct_oficina_orig,  ct_area_orig,      ct_descripcion,
      ct_automatico,    ct_estado,         row_number() over(order by ct_identifica),
      ct_cuenta,        ct_oficina_dest,   ct_area_dest,
      ct_credito,       ct_debito,         ct_concepto,
      ct_tipo_doc,      ct_moneda,         ct_usuario_modulo,
      ct_credito_me,    ct_debito_me,      ct_cotizacion,
      ct_tipo_tran,     ct_tipo,           ct_identifica,
      ct_concepto_imp,  ct_base_imp,       ct_documento,
      ct_oper_banco,    ct_cheque,         ct_origen_mvto,
      ct_archivo
      from #convivencia_tmp
      
      if @@error <> 0 begin
         rollback tran      
         print 'Error en la insercion de Registros en la tabla cob_externos..ex_convivencia_tmp1'
         return 601161    ---Error en insercion de registro
      end

      insert into cob_conta..cb_ajuste_cb_log (
      ac_producto,    ac_fecha,    ac_ente_cobis,
      ac_ente_cb,     ac_cuenta,   ac_valor,
      ac_comp_cobis,  ac_comp_cb,  ac_estado)
      select
      ah_producto,       ah_Fecha,          ah_Ente,
      ah_CB,             ah_Cuenta,         ah_Valor,
      ah_Comp_cobis    , @w_comprobante, 'P'
      from  #ahorros
      where ah_oficina = @w_oficina
      
      if @@error <> 0 begin      
         rollback tran
         print 'Error en la insercion de Registros en la tabla cob_conta..cb_ajuste_cb_log'
         return 601161    ---Error en insercion de registro
      end

   commit tran

   truncate table #convivencia_tmp

end

create table cob_conta..tmp_registro
(
  registro      varchar(5000),
  observacion   varchar(5000)
)

select @w_cabecera = 'Fecha|Cliente Aho|Cliente CB|Comprobante Cobis|Comprobante Reclasificacion|Monto'

insert into cob_conta..tmp_registro
(registro) values (@w_cabecera)

insert into cob_conta..tmp_registro
(registro)
select convert(varchar, ac_fecha, 103) + '|' + convert(varchar, ac_ente_cobis) + '|' + convert(varchar, ac_ente_cb) + '|' + 
       convert(varchar, ac_comp_cobis) + '|' + convert(varchar, ac_comp_cb) + '|' + convert(varchar, ac_valor) from 
cob_conta..cb_ajuste_cb_log
where ac_fecha = @i_fecha
and   ac_producto = 4 --Ahorros

select distinct ah_oficina
into #oficinas1
from #ahorros
order by ah_oficina

while 1 = 1 
begin
   select top 1 
   @w_oficina = ah_oficina
   from #oficinas1
 
   if @@rowcount = 0 
      break
   
   delete #oficinas1
   where ah_oficina = @w_oficina
   

   select at_oficina, at_Cuenta, at_Fecha, at_CB from #ahorrostot, #bancor 
   where at_oficina = ba_oficina
   and at_Area    = ba_Area
   and at_Cuenta  = ba_Cuenta
   and at_Fecha   = ba_Fecha
   and at_Valor   = ba_Valor
   and at_oficina = @w_oficina
   
   select @w_rowcount = @@ROWCOUNT 
   
   if @w_rowcount = 0
   begin
      select @w_observacion =  'ATENCION: VALOR TOTAL COMP. BANCOR NO COINCIDE CON TOTAL COMP COBIS AHORROS. FAVOR VERIFICAR'
      select @w_registro = 'Fecha: ' + convert(varchar, @i_fecha, 103) + 
                           ' CB: ' + convert(varchar, at_CB) + 
                           ' Cuenta: ' + convert(varchar, at_Cuenta) +
                           ' Corresponsal: ' + convert(varchar, at_oficina) +
                           ' Valor Aho: ' + CONVERT(varchar, at_Valor) +
                           ' Valor CB: ' + isnull((select CONVERT(varchar, sum(ba_Valor))
                                            from #bancor a
                                            where a.ba_oficina = @w_oficina), '0.00')
      from #ahorrostot
      where at_oficina = @w_oficina
      
      insert into  cob_conta..tmp_registro values(@w_registro, @w_observacion)
   end
end

set   @w_comando = @w_s_app + 's_app bcp -auto -login cob_conta..tmp_registro out "'+@w_path+'Reclaf_Aho' + +convert(varchar(10), getdate(),112) + '.txt"  -b1000 -c '+ /*' -t"," ' + */'-config '+ @w_s_app+ 's_app.ini'
exec  @w_error = xp_cmdshell @w_comando

delete from cb_cartera_bancor_tmp

drop table cob_conta..tmp_registro