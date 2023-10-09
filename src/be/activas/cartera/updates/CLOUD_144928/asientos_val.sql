/************************************************************************/
/*      Archivo:                asientos_val.sp                         */
/*      Stored procedure:       sp_sasiento_val                         */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:           Jose Orlando Forero Ramirez             */
/*      Fecha de escritura:     22/Oct/2003                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de:                     */
/*      Inserta los asientos de un comprobante a la tabla temporal      */
/*      de comprobantes generados por un subsistema                     */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR             RAZON                         */
/*      29-mar-2004     Diego Ayala       Programa exclusivo para       */
/*                                        validacion de comp. tmp.      */
/*      Ago-2020        JSA               RM 144928 Optimizacion Batch  */ 
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_sasiento_val')
        drop proc sp_sasiento_val
go

create proc sp_sasiento_val(
        @i_operacion            char(1) = null,
        @i_empresa              tinyint = null,
        @i_producto             tinyint = null
)
as
declare @w_sp_name              varchar(32),
        @w_moneda_base          tinyint,
        @w_moneda               tinyint,
        @w_cortes               int,
        @w_producto             tinyint,
        @w_max_asientos         int,
        @w_fecha_tran           datetime

select  
@w_sp_name    = 'sp_sasiento_val',
@w_fecha_tran = '01/01/1900'

/********  VALIDACIONES MASIVAS DE ASIENTOS CONTABLES  ***********/
if @i_operacion <> 'V' return 0

alter index ct_scomprobante_tmp_Key on cob_conta_tercero..ct_scomprobante_tmp rebuild
alter index idx2 on cob_conta_tercero..ct_scomprobante_tmp rebuild

alter index ct_sasiento_tmp_Key on cob_conta_tercero..ct_sasiento_tmp rebuild
alter index idx_ct_sasiento_tmp_sa_producto on cob_conta_tercero..ct_sasiento_tmp rebuild

update statistics cob_conta_tercero..ct_scomprobante_tmp
update statistics cob_conta_tercero..ct_sasiento_tmp

/* SELECCIONA LA MONEDA BASE DE LA EMPRESA */
select @w_moneda_base = em_moneda_base
from  cb_empresa with (nolock)
where em_empresa = @i_empresa

if @@rowcount = 0  begin
   print 'No existe empresa especificada'
   return 601018
end


select @w_producto = pr_producto
from   cob_conta..cb_producto with (nolock)
where  pr_empresa  = @i_empresa
and    pr_producto = @i_producto
and    pr_estado   = 'V'

if @@rowcount = 0 begin
   print 'No existe producto en contabilidad'
   return 601168
end

/* NUMERO MAXIMO ASIENTOS POR COMPROBANTE*/
select @w_max_asientos = pa_int from cobis..cl_parametro
where pa_producto = 'CON' and pa_nemonico = 'NMAC'


create table #errores(
fecha_tran   datetime     null,
comprobante  int          null,
descripcion  varchar(255) null)


/* VALIDA QUE LOS CORTES ESTEN ABIERTOS */
/****************************************/
insert into #errores
select 
sc_fecha_tran,   sc_comprobante, 'FECHA NO AUTORIZADA PARA PROCESAR INTERFAZ CONTABLE ' + convert(varchar(10),sc_fecha_tran,101)
from  cob_conta_tercero..ct_scomprobante_tmp with (nolock),  cob_conta..cb_corte with (nolock)
where sc_empresa        = @i_empresa
and   sc_producto       = @i_producto
and   co_empresa        = sc_empresa
and   co_fecha_ini      = sc_fecha_tran
and   co_estado    not in ('A','V')

if @@error <> 0 begin
   print 'Error en insert en :  #errores (1)'
   return 1
end


/* VALIDA QUE DEBITOS Y CREDITOS SEAN IGUALES Y DISTINTOS A CERO */
/*****************************************************************/
insert into #errores
select 
sc_fecha_tran,   sc_comprobante, 'DEBITOS Y CREDITOS NO CUADRADOS, DEB: ' + convert(varchar, sc_tot_debito) + 'CRE: ' + convert(varchar, sc_tot_credito)
from  cob_conta_tercero..ct_scomprobante_tmp with (nolock)
where sc_empresa        = @i_empresa
and   sc_producto       = @i_producto
and  (sc_tot_debito    <> sc_tot_credito or sc_tot_debito = 0 or sc_tot_credito = 0)

if @@error <> 0 begin
   print 'Error en insert en :  #errores (2)'
   return 1
end


/* NO SE ADMITEN COMPROBANTES NEGATIVOS */
/*****************************************************************/
insert into #errores
select 
sc_fecha_tran,   sc_comprobante, 'NO SE ADMITEN COMPROBANTES NEGATIVOS O IGUALES A CERO '
from  cob_conta_tercero..ct_scomprobante_tmp with (nolock)
where sc_empresa        = @i_empresa
and   sc_producto       = @i_producto
and   sc_comprobante   <= 0

if @@error <> 0 begin
   print 'Error en insert en :  #errores (3)'
   return 1
end




/* VALIDA QUE LA OFICINA ORIGEN EXISTA, SEA DE MOVIMIENTO Y VIGENTE */
/********************************************************************/
select 
sc_fecha_tran,   sc_comprobante,  sc_oficina_orig
into #oficinas
from  cob_conta_tercero..ct_scomprobante_tmp with (nolock)
where sc_empresa        = @i_empresa
and   sc_producto       = @i_producto

if @@error <> 0 begin
   print 'Error en insert en :  #oficinas)'
   return 1
end

delete #oficinas
from cob_conta..cb_oficina with (nolock)
where  of_empresa    = @i_empresa
and    of_movimiento = 'S' 
and    of_estado     = 'V'
and    of_oficina    = sc_oficina_orig

if @@error <> 0 begin
   print 'Error en delete de :  #oficinas)'
   return 1
end

insert into #errores
select 
sc_fecha_tran,   sc_comprobante, 'OFICINA ORIGEN NO EXISTE, NO ES DE MOVIMIENTO O NO SE ENCUENTRA VIGENTE  ' + convert(varchar(10),sc_oficina_orig)
from  #oficinas

if @@error <> 0 begin
   print 'Error en insert en :  #errores (4)'
   return 1
end


/* VALIDA QUE EL AREA ORIGEN EXISTA, SEA DE MOVIMIENTO Y VIGENTE */
/********************************************************************/
select 
sc_fecha_tran,   sc_comprobante, sc_area_orig
into #areas
from  cob_conta_tercero..ct_scomprobante_tmp with (nolock)
where sc_empresa        = @i_empresa
and   sc_producto       = @i_producto

if @@error <> 0 begin
   print 'Error en insert en :  #oficinas)'
   return 1
end

delete #areas
from cob_conta..cb_area with (nolock)
where  ar_empresa    = @i_empresa
and    ar_movimiento = 'S' 
and    ar_estado     = 'V'
and    ar_area       = sc_area_orig

if @@error <> 0 begin
   print 'Error en delete de :  #oficinas)'
   return 1
end

insert into #errores
select 
sc_fecha_tran,   sc_comprobante, 'OFICINA ORIGEN NO EXISTE, NO ES DE MOVIMIENTO O NO SE ENCUENTRA VIGENTE  ' + convert(varchar(10),sc_area_orig)
from  #areas

if @@error <> 0 begin
   print 'Error en insert en :  #errores (5)'
   return 1
end


/* VALIDA QUE LA OFICINA DESTINO EXISTA, SEA DE MOVIMIENTO Y VIGENTE */
/********************************************************************/
select distinct
sa_fecha_tran,   sa_comprobante,  sa_oficina_dest
into #oficinas_dest
from  cob_conta_tercero..ct_sasiento_tmp with (nolock)
where sa_empresa        = @i_empresa
and   sa_producto       = @i_producto

if @@error <> 0 begin
   print 'Error en insert en :  #oficinas)'
   return 1
end

delete #oficinas_dest
from cob_conta..cb_oficina with (nolock)
where  of_empresa    = @i_empresa
and    of_movimiento = 'S' 
and    of_estado     = 'V'
and    of_oficina    = sa_oficina_dest

if @@error <> 0 begin
   print 'Error en delete de :  #oficinas)'
   return 1
end

insert into #errores
select 
sa_fecha_tran,   sa_comprobante, 'OFICINA DESTINO NO EXISTE, NO ES DE MOVIMIENTO O NO SE ENCUENTRA VIGENTE  ' + convert(varchar(10),sa_oficina_dest)
from  #oficinas_dest

if @@error <> 0 begin
   print 'Error en insert en :  #errores (6)'
   return 1
end


/* VALIDA QUE EL AREA DESTINO EXISTA, SEA DE MOVIMIENTO Y VIGENTE */
/********************************************************************/
select distinct
sa_fecha_tran,   sa_comprobante,  sa_area_dest
into #areas_dest
from  cob_conta_tercero..ct_sasiento_tmp with (nolock)
where sa_empresa        = @i_empresa
and   sa_producto       = @i_producto

if @@error <> 0 begin
   print 'Error en insert en :  #oficinas)'
   return 1
end

delete #areas_dest
from cob_conta..cb_area with (nolock)
where  ar_empresa    = @i_empresa
and    ar_movimiento = 'S' 
and    ar_estado     = 'V'
and    ar_area       = sa_area_dest

if @@error <> 0 begin
   print 'Error en delete de :  #oficinas)'
   return 1
end

insert into #errores
select 
sa_fecha_tran,   sa_comprobante, 'OFICINA ORIGEN NO EXISTE, NO ES DE MOVIMIENTO O NO SE ENCUENTRA VIGENTE  ' + convert(varchar(10),sa_area_dest)
from  #areas_dest

if @@error <> 0 begin
   print 'Error en insert en :  #errores (7)'
   return 1
end



/* VALIDA COTIZACION MONEDA EXTRANJERA */
/***************************************/
insert into #errores
select distinct
sa_fecha_tran,   sa_comprobante, 'COMPROBANTES CON DETALES EN MONEDA EXTRAJERA SIN COTIZACION'
from  cob_conta_tercero..ct_sasiento_tmp with (nolock)
where sa_empresa      = @i_empresa
and   sa_producto     = @i_producto
and   sa_cotizacion   = 0
and  (sa_credito_me  <> 0 or sa_debito_me <> 0)

if @@error <> 0 begin
   print 'Error en insert en :  #errores (8)'
   return 1
end



/* VALIDA QUE LA CUENTA ESTE VIGENTE, SEA DE MOVIMIENTO Y LA MONEDA CORRESPONDA */
/********************************************************************************/
select distinct
sa_fecha_tran,   sa_comprobante, sa_cuenta, sa_moneda
into #cuentas
from  cob_conta_tercero..ct_sasiento_tmp with (nolock)
where sa_empresa      = @i_empresa
and   sa_producto     = @i_producto

delete #cuentas
from cob_conta..cb_cuenta with (nolock)
where cu_empresa    = @i_empresa
and   cu_movimiento = 'S'
and   cu_estado     = 'V'
and   cu_moneda     = sa_moneda
and   cu_cuenta     = sa_cuenta

insert into #errores
select 
sa_fecha_tran,   sa_comprobante, 'CUENTA NO EXISTE, NO ES DE MOVIMIENTO O MONEDA NO CORRESPONDE. Cta:'+ sa_cuenta + ' Mo:'+ convert(varchar,sa_moneda)
from  #cuentas

if @@error <> 0 begin
   print 'Error en insert en :  #errores (9)'
   return 1
end


/* VALIDA QUE LA CUENTA ESTE ASOCIADA A LA OFICINA */
/***************************************************/
select distinct
sa_fecha_tran,   sa_comprobante, sa_cuenta, sa_oficina_dest, sa_area_dest
into #cuentas_ofi
from  cob_conta_tercero..ct_sasiento_tmp with (nolock)
where sa_empresa      = @i_empresa
and   sa_producto     = @i_producto

delete #cuentas_ofi
from cob_conta..cb_plan_general with (nolock)
where pg_empresa = @i_empresa
and   pg_area    = sa_area_dest
and   pg_oficina = sa_oficina_dest
and   pg_cuenta  = sa_cuenta

insert into #errores
select 
sa_fecha_tran,   sa_comprobante, 'RELACION CUENTA-OFICINA-AREA NO PARAMETRIZADA EN EL PLAN GENERAL. Cta:'+ sa_cuenta + ' Of:'+ convert(varchar,sa_oficina_dest)+ ' Ar:'+ convert(varchar,sa_area_dest)
from  #cuentas_ofi

if @@error <> 0 begin
   print 'Error en insert en :  #errores (10)'
   return 1
end



/* VERIFICAR QUE LA MONEDA DE LA CUENTA CONTABLE CORRESPONDA CON EL VALOR MONETARIO EN MN Y/O EN ME */
/****************************************************************************************************/
insert into #errores
select distinct
sa_fecha_tran,   sa_comprobante, 'RELACION MONEDA-VALOR(MN/ME)INCONSISTENTE Cta:'+ sa_cuenta + ' Mo:'+ convert(varchar,sa_moneda)+ ' Monto(mn):'+ convert(varchar,sa_credito+sa_debito)+ ' Monto(me):'+ convert(varchar,sa_credito_me+sa_debito_me)
from cob_conta_tercero..ct_sasiento_tmp with (nolock)
where sa_empresa      = @i_empresa
and   sa_producto     = @i_producto
and (
(sa_moneda = @w_moneda_base and ((sa_debito_me <> 0 or sa_credito_me <> 0) or (sa_debito = 0 and sa_credito = 0))) or
(sa_moneda <> @w_moneda_base and ((sa_debito = 0 or sa_debito_me = 0) and (sa_credito = 0 or sa_credito_me = 0))) or
(sa_debito <> 0 and sa_credito <> 0 and sa_debito_me <> 0 and sa_credito_me <> 0)
)

if @@error <> 0 begin
   print 'Error en insert en :  #errores (11)'
   return 1
end


/* VERIFICA SI EXISTEN DOCUMENTOS DE COMPRA Y/O VENTA PARA CUADRAR ME */
/**********************************************************************/
insert into #errores
select distinct
sa_fecha_tran,   sa_comprobante, 'RELACION MONEDA-POSICION-TIPO_DOC INCONSISTENTE Cta:'+ sa_cuenta + ' Mo:'+ convert(varchar,sa_moneda)+ ' Pos:'+ sa_posicion+ ' TDoc:'+ sa_tipo_doc
from cob_conta_tercero..ct_sasiento_tmp with (nolock)
where sa_empresa      = @i_empresa
and   sa_producto     = @i_producto
and ((sa_posicion     = 'S'             and 
      sa_moneda      <>  @w_moneda_base and
      sa_debito_me   <>  0              and
      sa_tipo_doc    <> 'C')
or   (sa_posicion     = 'S'             and 
      sa_moneda      <>  @w_moneda_base and 
      sa_credito_me  <>  0              and 
      sa_tipo_doc   <> 'V')
or   (sa_posicion     = 'S'             and 
      sa_moneda       =  @w_moneda_base and 
      sa_tipo_doc    <> 'N')
or   (sa_posicion     = 'N'             and 
      sa_tipo_doc    <> 'N'))

if @@error <> 0 begin
   print 'Error en insert en :  #errores (12)'
   return 1
end


/* VERIFICA SI EXISTEN CUENTAS ASOCIADAS A TERCEROS CON ENTE VALIDO */
/********************************************************************/
select distinct
pt_proceso   = cp_proceso, 
pt_cuenta    = cu_cuenta, 
pt_condicion = cp_condicion
into #ct_tmp_ter
from   cob_conta..cb_cuenta_proceso, cob_conta..cb_cuenta with (nolock)
where  cp_empresa    = @i_empresa
and    cp_proceso    in (6003,6095)
and    cu_empresa    = @i_empresa
and    cu_empresa    = cp_empresa
and    rtrim(cu_cuenta) like rtrim(cp_cuenta) + '%'
and    cu_movimiento = 'S'

if @@error <> 0 begin
   print 'Error en insert en :  #ct_tmp_ter (1)'
   return 1
end

create index idx1 on #ct_tmp_ter(pt_cuenta, pt_proceso)


insert into #errores
select distinct
sa_fecha_tran,   sa_comprobante, 'CUENTA DE TERCERO SIN CODIGO DE CLIENTE Cta:'+ sa_cuenta 
from cob_conta_tercero..ct_sasiento_tmp with (nolock), #ct_tmp_ter
where sa_empresa      = @i_empresa
and   sa_producto     = @i_producto
and   sa_cuenta       = pt_cuenta
and   isnull(sa_ente, 0) = 0

if @@error <> 0 begin
   print 'Error en insert en :  #errores (13)'
   return 1
end

/* ACTUALIZA CONCEPTO DE RETENCION */
/***********************************/
select 
pc_cuenta    = cp_cuenta, 
pc_condicion = min(cp_condicion)
into #proceso_6004
from cob_conta..cb_cuenta_proceso
where cp_proceso = 6004
group by cp_cuenta

update cob_conta_tercero..ct_sasiento_tmp set 
sa_con_rete = pc_condicion
from cob_conta..cb_cuenta_proceso,
     #proceso_6004
where sa_producto = @i_producto
and   sa_empresa = @i_empresa
and   sa_cuenta = cp_cuenta
and   cp_proceso = 6095
and   cp_cuenta = pc_cuenta
and   cp_condicion = 'R'
and   sa_con_rete is null

/* VERIFICA SI LOS DATOS DEL IMPUESTO Y DEL DOCUMENTO SON VALIDOS */
/******************************************************************/
insert into #errores
select distinct
sa_fecha_tran,   sa_comprobante, 'CUENTA CON CONDICION IMPOSITIVA SIN DOCUMENTO Cta:'+ sa_cuenta +' Pos:'+ pt_condicion
from cob_conta_tercero..ct_sasiento_tmp with (nolock), #ct_tmp_ter
where sa_empresa      = @i_empresa
and   sa_producto     = @i_producto
and   sa_cuenta       = pt_cuenta
and   pt_condicion   is not null
and   sa_documento is null

if @@error <> 0 begin
   print 'Error en insert en :  #errores (14)'
   return 1
end


/* VERIFICA CUENTAS QUE EXIGEN VALOR BASE */
/******************************************/
insert into #errores
select distinct
sa_fecha_tran,   sa_comprobante, 'ASIENTO DE IMPUESTOS SIN VALOR BASE. Cta:'+ sa_cuenta 
from cob_conta_tercero..ct_sasiento_tmp with (nolock), #ct_tmp_ter
where sa_empresa      = @i_empresa
and   sa_producto     = @i_producto
and   sa_cuenta       = pt_cuenta
and   pt_proceso      = 6095
and   sa_base        is null

if @@error <> 0 begin
   print 'Error en insert en :  #errores (15)'
   return 1
end

/* VERIFICA CUENTAS QUE EXIGEN CONDICION IMPOSITIVA */
/****************************************************/
insert into #errores
select distinct
sa_fecha_tran,   sa_comprobante, 'ASIENTO DE IMPUESTOS SIN CONDICION IMPOSITIVA. Cta:'+ sa_cuenta 
from cob_conta_tercero..ct_sasiento_tmp with (nolock), #ct_tmp_ter
where sa_empresa      = @i_empresa
and   sa_producto     = @i_producto
and   sa_cuenta       = pt_cuenta
and   pt_proceso      = 6095
and ((pt_condicion = 'R' and (sa_con_rete      is null or sa_valret          is null))
  or (pt_condicion = 'I' and (sa_con_iva       is null or sa_valor_iva       is null))
  or (pt_condicion = 'C' and (sa_con_ica       is null or sa_valor_ica       is null))
  or (pt_condicion = 'T' and (sa_con_timbre    is null or sa_valor_timbre    is null))
  or (pt_condicion = 'P' and (sa_con_ivapagado is null or sa_valor_ivapagado is null))
  or (pt_condicion = 'E' and (sa_con_dptales   is null or sa_valor_dptales   is null)))

if @@error <> 0 begin
   print 'Error en insert en :  #errores (16)'
   return 1
end


/* VERIFICA QUE LAS CUENTAS DE BANCOS, TENGAN BANCO Y CHEQUE */
/*************************************************************/
insert into #errores
select distinct
sa_fecha_tran,   sa_comprobante, 'CUENTA EXIGE BANCO Y NRO.DE CHEQUE. Cta:'+ sa_cuenta 
from cob_conta_tercero..ct_sasiento_tmp with (nolock), cob_conta..cb_banco with (nolock)
where sa_empresa      = @i_empresa
and   sa_producto     = @i_producto
and   ba_empresa      = sa_empresa
and   ba_cuenta       = sa_cuenta
and (sa_oper_banco is null or sa_cheque is null)

if @@error <> 0 begin
   print 'Error en insert en :  #errores (17)'
   return 1
end


/* VERIFICAR QUE EL NUMERO Y VALOR DE LOS DETALLES COINCIDA CON LOS DATOS DE LA CABECERA */
/*****************************************************************************************/
select
fecha_tran   = sa_fecha_tran,
comprobante  = sa_comprobante,
nro_asientos = count(1),
tot_debito   = sum(isnull(sa_debito,0)),
tot_credito  = sum(isnull(sa_credito,0)),
min_asiento  = min(sa_asiento),
max_asiento  = max(sa_asiento)
into #totales
from cob_conta_tercero..ct_sasiento_tmp with (nolock)
where sa_empresa      = @i_empresa
and   sa_producto     = @i_producto
group by sa_fecha_tran, sa_comprobante

select 
sc_fecha_tran,
sc_comprobante,
sc_detalles
into #totales_cabecera
from cob_conta_tercero..ct_scomprobante_tmp
where sc_empresa  = @i_empresa
and   sc_producto = @i_producto


insert into #errores
select 
fecha_tran,   comprobante, 'COMPROBANTE CON NRO DE ASIENTO QUE NO INICIA EN UNO' 
from #totales
where min_asiento <> 1

if @@error <> 0 begin
   print 'Error en insert en :  #errores (18)'
   return 1
end

insert into #errores
select 
fecha_tran,   comprobante, 'NUMERO DE ASIENTOS SUPERIOR AL PERMITIDO'
from #totales
where max_asiento >= @w_max_asientos

if @@error <> 0 begin
   print 'Error en insert en :  #errores (18x)'
   return 1
end

insert into #errores
select 
fecha_tran,   comprobante, 'COMPROBANTE CON MAXIMO NRO DE ASIENTO DISTINTO AL NUMERO DE ASIENTOS' 
from #totales
where max_asiento <> nro_asientos

if @@error <> 0 begin
   print 'Error en insert en :  #errores (19)'
   return 1
end

delete #totales_cabecera
from #totales
where sc_fecha_tran  = fecha_tran
and   sc_comprobante = comprobante
and   sc_detalles    = nro_asientos

insert into #errores
select 
sc_fecha_tran,   sc_comprobante, 'COMPROBANTE SIN DETALLES O CON NUMERO DISTINTO AL DECLARADO EN LA CABECERA'
from #totales_cabecera

if @@error <> 0 begin
   print 'Error en insert en :  #errores (18x)'
   return 1
end


delete #totales 
from cob_conta_tercero..ct_scomprobante_tmp with (nolock)
where sc_empresa        = @i_empresa
and   sc_producto       = @i_producto
and   sc_comprobante    = comprobante
and   sc_fecha_tran     = fecha_tran
and   sc_tot_debito     = tot_debito
and   sc_tot_credito    = tot_credito
and   sc_detalles       = nro_asientos

insert into #errores
select 
fecha_tran,   comprobante, 'DATOS DE NRO.ASIENTOS/TOT.CREDITO/TOT.DEBITO NO ES CONSISTENTE CABECERA CON DETALLES' 
from #totales

if @@error <> 0 begin
   print 'Error en insert en :  #errores (20)'
   return 1
end

update cob_conta_tercero..ct_sasiento_tmp set
sa_ente                 = null,
sa_con_rete             = null,
sa_base                 = null,
sa_valret               = null,
sa_con_iva              = null,
sa_valor_iva            = null,
sa_iva_retenido         = null,
sa_con_ica              = null,
sa_valor_ica            = null,
sa_con_timbre           = null,
sa_valor_timbre         = null,
sa_con_iva_reten        = null,
sa_con_ivapagado     = null,
sa_valor_ivapagado      = null,
sa_documento            = null
where sa_empresa        = @i_empresa
and   sa_producto       = @i_producto
and   sa_cuenta not in (select pt_cuenta from #ct_tmp_ter)

if @@error <> 0 begin
   print 'Error update ct_sasiento_tmp (18)'
   return 1
end


SET IDENTITY_INSERT cob_interfase..cco_error_conaut ON

insert into cob_interfase..cco_error_conaut (
ec_empresa,            ec_producto,                ec_fecha_conta,
ec_secuencial,         ec_fecha,                   ec_tran_modulo,
ec_asiento,            ec_numerror,                ec_mensaje,
ec_perfil,             ec_oficina,                 ec_valor,
ec_comprobante)
select 
@i_empresa,            @i_producto,                fecha_tran,
0,                     getdate(),                  isnull(sc_tran_modulo,' '),
0,                     601181,                     substring(descripcion, 1, 150),
isnull(sc_perfil, ''), isnull(sc_oficina_orig,0),  isnull(sc_tot_debito,0),
comprobante      
from #errores
left outer join cob_conta_tercero..ct_scomprobante_tmp on
   sc_fecha_tran  = fecha_tran and
   sc_comprobante = comprobante
where sc_empresa     =  @i_empresa
and   sc_producto    =  @i_producto

if @@error <> 0 begin
   SET IDENTITY_INSERT cob_interfase..cco_error_conaut OFF
   print 'Error en paso de registros de Error a tabla definitiva'
   return 1
end


SET IDENTITY_INSERT cob_interfase..cco_error_conaut OFF


delete cob_conta_tercero..ct_scomprobante_tmp
from #errores
where sc_empresa        = @i_empresa
and   sc_producto       = @i_producto
and   sc_fecha_tran     = fecha_tran
and   sc_comprobante    = comprobante

if @@error <> 0 begin
   print 'Error en borrado de comprobantes con error'
   GOTO ERROR_FIN
end 

delete cob_conta_tercero..ct_sasiento_tmp
from #errores
where sa_empresa        = @i_empresa
and   sa_producto       = @i_producto
and   sa_fecha_tran     = fecha_tran
and   sa_comprobante    = comprobante

if @@error <> 0 begin
   print 'Error en borrado de asientos con error'
   GOTO ERROR_FIN
end 

select distinct sc_fecha_tran 
into #fechas
from cob_conta_tercero..ct_scomprobante_tmp
where sc_empresa        = @i_empresa
and   sc_producto       = @i_producto

while 1 = 1 begin
   set rowcount 1
   
   select @w_fecha_tran = sc_fecha_tran
   from #fechas
   
   if @@rowcount = 0 begin
      set rowcount 0
      break
   end
   
   set rowcount 0
   
   delete #fechas
   where sc_fecha_tran = @w_fecha_tran
   
   if exists(select 1 from cob_conta..cb_banco)
   begin
      /* VALIDA CUENTAS QUE MANEJAN CONCILIACION BANCARIA */
      insert into cob_conta_tercero..ct_conciliacion (
      cl_producto,     cl_comprobante,   cl_empresa,
      cl_fecha_tran,   cl_asiento,       cl_cuenta,
      cl_oficina_dest, cl_area_dest,     cl_debcred,
      cl_oper_banco,   cl_doc_banco,     cl_valor,        
      cl_banco,        cl_fecha_est,     cl_cuenta_cte,
      cl_detalle,      cl_relacionado,   cl_cheque
      )
      select  
      sa_producto,     sa_comprobante,   sa_empresa, 
      sa_fecha_tran,   sa_asiento,       sa_cuenta, 
      sa_oficina_dest, sa_area_dest,     case when sa_debito > 0 then 'D' else 'C' end, 
      sa_oper_banco,   sa_doc_banco,     case when sa_debito > 0 then sa_debito else sa_credito end,
      ba_banco,        sa_fecha_est,     ba_ctacte, 
      sa_detalle,      'N',              sa_cheque
      from  cob_conta_tercero..ct_sasiento_tmp with (index = ct_sasiento_tmp_Key),  
            cob_conta..cb_banco
      where sa_empresa        = @i_empresa
      and   sa_producto       = @i_producto
      and   sa_empresa        = ba_empresa
      and   sa_cuenta         = ba_cuenta
      and   sa_fecha_tran     = @w_fecha_tran
         
      if @@error <> 0 begin
         print 'Error en insert en :  ct_conciliacion (19)'
         GOTO ERROR_FIN
      end   
   end
     
   insert into cob_conta_tercero..ct_scomprobante (
   sc_producto,                    sc_comprobante,                 sc_empresa,                     
   sc_fecha_tran,                  sc_oficina_orig,                sc_area_orig,                   
   sc_fecha_gra,                   sc_digitador,                   sc_descripcion,                 
   sc_perfil,                      sc_detalles,                    sc_tot_debito,                  
   sc_tot_credito,                 sc_tot_debito_me,               sc_tot_credito_me,              
   sc_automatico,                  sc_reversado,                   sc_estado,                      
   sc_mayorizado,                  sc_observaciones,               sc_comp_definit,                
   sc_usuario_modulo,              sc_causa_error,                 sc_comp_origen,                 
   sc_tran_modulo,                 sc_error )
   select 
   sc_producto,                    sc_comprobante,                 sc_empresa,                     
   sc_fecha_tran,                  sc_oficina_orig,                sc_area_orig,                   
   sc_fecha_gra,                   sc_digitador,                   sc_descripcion,                 
   sc_perfil,                      sc_detalles,                    sc_tot_debito,                  
   sc_tot_credito,                 sc_tot_debito_me,               sc_tot_credito_me,              
   sc_automatico,                  sc_reversado,                   'B',
   sc_mayorizado,                  sc_observaciones,               sc_comp_definit,                
   sc_usuario_modulo,              sc_causa_error,                 sc_comp_origen,                 
   sc_tran_modulo,                 sc_error 
   from   cob_conta_tercero..ct_scomprobante_tmp
   where sc_producto       = @i_producto
   and   sc_empresa        = @i_empresa
   and   sc_fecha_tran     = @w_fecha_tran
         
   if @@error <> 0 begin
      print 'Error en el paso de COMPROBANTES temporales a definitivos'
      GOTO ERROR_FIN
   end
         
   -- PASO DE COMPORBANTES y ASIENTOS DE TABLAS TEMPORALES A DEFINITIVAS
   insert into cob_conta_tercero..ct_sasiento
   select *
   from  cob_conta_tercero..ct_sasiento_tmp
   where sa_producto       = @i_producto
   and   sa_empresa        = @i_empresa
   and   sa_fecha_tran     = @w_fecha_tran
         
   if @@error <> 0 begin
      print 'Error en el paso de ASIENTOS temporales a definitivos'
      GOTO ERROR_FIN
   end
   
   delete cob_conta_tercero..ct_sasiento_tmp
   where sa_empresa        = @i_empresa
   and   sa_producto       = @i_producto   
   and   sa_fecha_tran     = @w_fecha_tran
     
   if @@error <> 0 begin
      print 'Error en eliminación de asientos con ERROR'
      GOTO ERROR_FIN
   end
      
   delete cob_conta_tercero..ct_scomprobante_tmp
   where sc_empresa        = @i_empresa
   and   sc_producto       = @i_producto
   and   sc_fecha_tran     = @w_fecha_tran
      
   if @@error <> 0 begin
      print 'Error en eliminación de comprobantes con ERROR'
      GOTO ERROR_FIN
   end   
end -- while 1 = 1

return 0
   
ERROR_FIN:

return 1

GO
