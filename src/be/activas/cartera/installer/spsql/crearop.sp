/************************************************************************/
/*      Archivo:                crearop.sp                              */
/*      Stored procedure:       sp_crear_operacion                      */
/*      Base de datos:          cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           Fabian de la Torre, Rodrigo Garces      */
/*      Fecha de escritura:     Ene. 1998                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA"                                                        */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Crea una operacion de Cartera con sus rubros asociados y su     */
/*      tabla de amortizacion                                           */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      Oct.23/98   Nydia Velasco NVR        Cambio tipo dato           */
/*                                                                      */
/*      11/May/99   Ramiro Buitron (CONTEXT) Personalizacion CORFINSURA */
/*                                           Incorporacion parametros de*/
/*                                           origen de fondos, ref rede.*/
/*      05/Ene/2017 Lorena Regalado          Incorporar concepto de     */
/*                                           Agrupamiento de Operaciones*/
/*      22/May/2017 Jorge Salazar            CGS-S112643                */
/*      13/May2017  Jorge Salazar            Parametros de entrada      */
/*                                           @i_tdividendo              */
/*                                           @i_periodo_cap             */
/*                                           @i_periodo_int             */
/*      17/Sep/2020 Sonia Rojas              Req #140073                */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_crear_operacion')
   drop proc sp_crear_operacion
go
create proc sp_crear_operacion
   @s_user              login        = null,
   @s_sesn              int          = null,
   @s_ofi               smallint     = null,
   @s_date              datetime     = null,
   @s_term              varchar(30)  = null,
   @i_anterior          cuenta       = null,
   @i_migrada           cuenta       = null,
   @i_tramite           int          = null,
   @i_cliente           int          = 0,
   @i_nombre            descripcion  = null,
   @i_sector            catalogo     = null,
   @i_toperacion        catalogo     = null,
   @i_oficina           smallint     = null,
   @i_moneda            tinyint      = null,
   @i_comentario        varchar(255) = null,
   @i_oficial           smallint     = null,
   @i_fecha_ini         datetime     = null,
   @i_monto             money        = null,
   @i_monto_aprobado    money        = null,
   @i_destino           catalogo     = null,
   @i_lin_credito       cuenta       = null,
   @i_ciudad            int          = null,
   @i_forma_pago        catalogo     = null,
   @i_cuenta            cuenta       = null,
   @i_formato_fecha     int          = 101,
   @i_no_banco          char(1)      = null,
   @i_dia_pago          int          = null,
   @i_clase_cartera     catalogo     = null,
   @i_origen_fondos     catalogo     = null,
   @i_tipo_empresa      catalogo     = null,
   @i_validacion        catalogo     = null,
   @i_fondos_propios    char(1)      = null,
   @i_ref_exterior      cuenta       = null,
   @i_sujeta_nego       char(1)      = 'N' ,
   @i_ref_red           varchar(24)  = null,
   @i_convierte_tasa    char(1)      = null,
   @i_tasa_equivalente  char(1)      = null,
   @i_fec_embarque      datetime     = null,
   @i_fec_dex           datetime     = null,
   @i_num_deuda_ext     cuenta       = null,
   @i_num_comex         cuenta       = null,
   @i_batch_dd          char(1)      = null,
   @i_tramite_hijo      int          = null,
   @i_reestructuracion  char(1)      = null,
   @i_tipo_cambio       char(1)      = null,
   @i_numero_reest      int          = null,
   @i_oper_pas_ext      varchar(64)  = null,
   @i_en_linea          char(1)      = 'S',
   @i_banca             catalogo     = null,
   @i_salida            char(1)      = 'S',
   @i_grupal            Char(1)      = null, --LRE 05/Ene/2017
   @i_promocion         char(1)      = null, --LPO Santander
   @i_acepta_ren        char(1)      = null, --LPO Santander
   @i_no_acepta         char(1000)   = null, --LPO Santander
   @i_emprendimiento    char(1)      = null, --LPO Santander
   @i_tasa              float        = null, --JSA Santander
   @i_plazo             int          = null,
   @i_tplazo            catalogo     = null,
   @i_tdividendo        catalogo     = null,
   @i_periodo_cap       int          = null,
   @i_periodo_int       int          = null,
   @i_desplazamiento    int          = 0,    --SRO #140073
   @o_banco             cuenta       = null output

as
declare
   @w_sp_name           descripcion,
   @w_return            int,
   @w_error             int,
   @w_pa_char           catalogo,
   @w_direccion         tinyint,
   @w_banco             cuenta,
   @w_operacionca       int,
   @w_sector_cli        catalogo,
   @w_sector_ger        catalogo,
   @w_fecha_proceso     datetime,   --HRE Ref 001 04/03/2002
   @w_dias_contr        int,        --HRE Ref 001 04/03/2002
   @w_dias_hoy          int,        --HRE Ref 001 04/03/2002
   @w_rowcount          int


/* CARGAR VALORES INICIALES */
select @w_sp_name  = 'sp_crear_operacion',
       @i_no_banco = 'N' -- LGU cambio S x N para que genere numero largo


/* DIAS CONTROL TRAMITE */
select @w_dias_contr = pa_smallint
from  cobis..cl_parametro
where pa_producto = 'CCA'
and   pa_nemonico = 'DCTRA'
select @w_rowcount = @@rowcount
set transaction isolation level read uncommitted

if @w_rowcount = 0 begin

   exec cobis..sp_cerror
       @t_debug='N',
       @t_file = null,
       @t_from =@w_sp_name,
       @i_num = 710215
--       @i_cuenta= ' '
       return 1
end

select @w_fecha_proceso = fc_fecha_cierre
from cobis..ba_fecha_cierre
where fc_producto = 7  -- 7 pertence a Cartera


select @w_dias_hoy = datediff(dd,@i_fecha_ini,@w_fecha_proceso)

if @w_dias_hoy > @w_dias_contr begin

   exec cobis..sp_cerror
       @t_debug='N',
       @t_file = null,
       @t_from =@w_sp_name,
       @i_num = 710212
--       @i_cuenta= ' '
       return 1
end

/* Fin Ref 001  */

if (@i_monto is null or @i_monto = 0)  and(@i_toperacion <> 'REVOLVENTE') 
begin
  PRINT 'crearop.sp no puede llegar el valor de creacion en NULL o 0'
  return 708154
end


--LA DIRECCION INICIAL ES LA No.1 LA CUAL SE MODIFICA UNA VEZ SE CREA LA OBLIGACION
--POR LA PANTALLA DE PARAMETROS EN LA CREACION MISMA O ACTUALIZACIOn
select @w_direccion = min(di_direccion)
from cobis..cl_direccion
where di_ente    = @i_cliente
and di_vigencia  = 'S'
and di_principal = 'S'
set transaction isolation level read uncommitted


if @i_en_linea = 'S'
   begin tran

exec @w_return              = sp_crear_operacion_int
     @s_user                = @s_user,
     @s_sesn                = @s_sesn,
     @s_ofi                 = @s_ofi,
     @s_date                = @s_date,
     @s_term                = @s_term,
     @i_anterior            = @i_anterior,
     @i_migrada             = @i_migrada,
     @i_tramite             = @i_tramite,
     @i_cliente             = @i_cliente,
     @i_nombre              = @i_nombre,
     @i_sector              = @i_sector,
     @i_toperacion          = @i_toperacion,
     @i_oficina             = @i_oficina,
     @i_moneda              = @i_moneda,
     @i_comentario          = @i_comentario,
     @i_oficial             = @i_oficial,
     @i_fecha_ini           = @i_fecha_ini,
     @i_monto               = @i_monto,
     @i_monto_aprobado      = @i_monto_aprobado,
     @i_destino             = @i_destino,
     @i_lin_credito         = @i_lin_credito,
     @i_ciudad              = @i_ciudad,
     @i_forma_pago          = @i_forma_pago,
     @i_cuenta              = @i_cuenta,
     @i_formato_fecha       = @i_formato_fecha,
     @i_periodo_crecimiento = 0,
     @i_tasa_crecimiento    = 0,
     @i_direccion           = @w_direccion,
     @i_clase_cartera       = @i_clase_cartera,
     @i_origen_fondos       = @i_origen_fondos,
     @i_fondos_propios      = @i_fondos_propios,
     @i_tipo_empresa        = @i_tipo_empresa,
     @i_validacion          = @i_validacion,
     @i_ref_exterior        = @i_ref_exterior,
     @i_sujeta_nego         = @i_sujeta_nego,
     @i_ref_red             = @i_ref_red,
     @i_convierte_tasa      = @i_convierte_tasa,
     @i_tasa_equivalente    = @i_tasa_equivalente,
     @i_fec_embarque        = @i_fec_embarque,
     @i_fec_dex             = @i_fec_dex,
     @i_num_deuda_ext       = @i_num_deuda_ext,
     @i_num_comex           = @i_num_comex,
     @i_no_banco            = @i_no_banco,
     @i_batch_dd            = @i_batch_dd,
     @i_tramite_hijo        = @i_tramite_hijo,
     @i_reestructuracion    = @i_reestructuracion,
     @i_subtipo             = @i_tipo_cambio,
     @i_numero_reest        = @i_numero_reest,
     @i_oper_pas_ext        = @i_oper_pas_ext,
	 @i_dia_pago            = @i_dia_pago,
     @i_banca               = @i_banca,
     @i_salida              = @i_salida,
     @i_grupal              = @i_grupal,        --LRE 05/Ene/2017
     @i_promocion           = @i_promocion,     --LPO Santander
     @i_acepta_ren          = @i_acepta_ren,    --LPO Santander
     @i_no_acepta           = @i_no_acepta,     --LPO Santander
     @i_emprendimiento      = @i_emprendimiento,--LPO Santander
     @i_tasa                = @i_tasa,          --JSA Santander
     @i_plazo               = @i_plazo,
     @i_tplazo              = @i_tplazo,
     @i_tdividendo          = @i_tdividendo,
     @i_periodo_cap         = @i_periodo_cap,
     @i_periodo_int         = @i_periodo_int,
     @i_desplazamiento      = @i_desplazamiento,
     @o_banco               = @o_banco output

if @w_return != 0 begin
   select @w_error = @w_return
   goto ERROR
end


if @i_en_linea = 'S'
   commit tran

return 0

ERROR:

if @i_en_linea = 'S'
begin
   while @@trancount > 0
      rollback

   exec cobis..sp_cerror
      @t_debug  = 'N',
      @t_file   = null,
      @t_from   = @w_sp_name,
      @i_num    = @w_error
--      @i_cuenta = ' '
end
ELSE
begin

   exec sp_errorlog
        @i_fecha       = @s_date,
        @i_error       = @w_error,
        @i_usuario     = @s_user,
        @i_tran        = 7000,
        @i_tran_name   = '',
        @i_rollback    = 'S',
        @i_cuenta      = @i_toperacion
end

return @w_error

go

