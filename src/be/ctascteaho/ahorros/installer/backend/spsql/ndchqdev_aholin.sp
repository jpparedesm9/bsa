/************************************************************************/
/*  Archivo:            ndchqdev_aholin.sp                              */
/*  Stored procedure:   sp_ndchqdev_aholin                              */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Julio Navarrete V.                              */
/*  Fecha de escritura: 25-Nov-1994                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/*  Este programa procesa la transaccion de nota de debito por          */
/*  cheque devuelto enn forma sequencial.(Logica de la transaccion)     */
/*  2502 = Nota de debito por cheque devuelto.                          */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  25/Nov/1994  G. Velasquez    Validacion                             */
/*  28/Abr/2005  L. Bernuil      Ajustes en el procesamiento            */
/*  02/May/2016  Juan Tagle      Migración a CEN                        */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_ndchqdev_aholin')
    drop proc sp_ndchqdev_aholin
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_ndchqdev_aholin (
    @s_rol             smallint       = null,
    @s_srv             varchar(30)    ,
    @s_user            varchar(10)    = null,
    @s_term            varchar(10)    = 'consola',
    @t_debug           char(1)        = 'N',
    @t_file            varchar(30)    = null,
    @t_show_version    bit = 0,
    @i_fecha           smalldatetime  ,
    @i_turno           smallint       = null,
    @i_cta_depositada  cuenta         = null,
    @i_tipo_cheque     char(1)        = null,
    @i_valor           money          ,
    @i_causa           char(5)        = null,
    @i_mon             tinyint        ,
    @i_canal           smallint       = 4

)
as
declare @w_return         int,
        @w_sp_name        varchar(30),
        @w_alicuota       float,
        @w_alic           money,
        @w_disponible     money,
        @w_contable       money,
        @w_promedio1      money,
        @w_prom_disp      money,
        @w_12h            money,
        @w_12h_dif        money,
        @w_numdeci        tinyint,
        @w_ssn            int,
        @w_mensaje        mensaje,
        @w_tipo_bloqueo   varchar(3),
        @w_tipo_prom      char(1),
        @w_fldeci         char(1),
        @w_trx            int,
        @w_categoria      char(1),
        @w_tipo_ente      char(1),
        @w_rol_ente       char(1),
        @w_tipo_def       char(1),
        @w_prod_banc      smallint,
        @w_producto       tinyint,
        @w_tipo           char(1),
        @w_reentry        varchar(255),
        @w_codigo         int,
        @w_personaliza    char(1),
        @w_comision       money,
        @w_cuenta         int,
        @w_factor         int,
        @w_prod           int,
        @w_filial         tinyint,
        @w_oficina        smallint,
        @w_control        smallint,
        @w_promedio       char(1),
        @w_flag           smallint,
        @w_signo          char(1),
        @w_fecdia         smalldatetime,
        @w_debmes         money,
        @w_debhoy         money,
        @w_ult            tinyint,
        @w_24h            money,
        @w_48h            money,
        @w_remesas        money,
        @w_cta_depositada int,
        @w_contador       int,
        @w_total          money,
        @w_moneda         tinyint,
        @w_cta_banco      cuenta,
        @w_cta            int,
        @w_cliente        int,
        @w_lp_sec         int,
        @w_estado         char(1),
        @w_sucursal       smallint,
        @w_lineas         smallint,
        @w_monto          money ,
        @w_tipo_atributo  char(1),
        @w_tipo_cheque    char(1),
        @w_tipocta_super  char(1)

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_ndchqdev_aholin'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

/* Lectura para login operador batch*/
select @s_user = pa_char from cobis..cl_parametro
where pa_nemonico = 'LOB'
and pa_producto = 'ADM'

if @i_turno is null
    select @i_turno = @s_rol

select @w_fecdia = convert(varchar(10),@i_fecha,101)

exec @w_ssn = ADMIN...rp_ssn

/* Validacion de la causa de la devolucion */
if (@i_causa is null) or (ltrim(@i_causa) = '') or (rtrim(@i_causa) = '')
begin
     select @w_mensaje = 'CAUSA DE DEVOLUCION NO VALIDA'
end

select @w_factor = 1, @w_signo = 'D'

exec @w_return = cob_ahorros..sp_ctah_vigente
@i_cta_banco     = @i_cta_depositada,
@i_moneda        = @i_mon, --@w_moneda,
@o_cuenta        = @w_cta out,
@o_filial        = @w_filial out,
@o_oficina       = @w_oficina out,
@o_tipo_promedio = @w_promedio out

if @w_return <> 0
   return @w_return

/* Encuentra datos de trabajo de la cuenta */
select  @w_tipo_prom     = ah_tipo_promedio,
        @w_12h           = ah_12h,
        @w_12h_dif       = ah_12h_dif,
        @w_disponible    = ah_disponible,
        @w_promedio1     = ah_promedio1,
        @w_prom_disp     = ah_prom_disponible,
        @w_categoria     = ah_categoria,
        @w_tipo_ente     = ah_tipocta,
        @w_rol_ente      = ah_rol_ente,
        @w_tipo_def      = ah_tipo_def,
        @w_prod_banc     = ah_prod_banc,
        @w_producto      = ah_producto,
        @w_tipo          = ah_tipo,
        @w_codigo        = ah_default,
        @w_personaliza   = ah_personalizada,
        @w_trx           = ah_contador_trx,
        @w_debmes        = ah_debitos,
        @w_debhoy        = ah_debitos_hoy,
        @w_24h           = ah_24h,
        @w_remesas       = ah_remesas,
        @w_48h           = ah_48h,
        @w_moneda        = ah_moneda,
        @w_cta_banco     = ah_cta_banco,
        @w_lineas        = ah_linea,
        @w_oficina       = ah_oficina,
        @w_tipocta_super = ah_tipocta_super,
        @w_cliente       = ah_cliente
  from  cob_ahorros..ah_cuenta
 where  ah_cuenta = @w_cta

/* Determinacion de vigencia de cuenta */

select @w_contable = @w_disponible + @w_12h + @w_24h + @w_48h + @w_remesas

/* Encuentra los decimales a utilizar */
select @w_fldeci = mo_decimales
from cobis..cl_moneda
where mo_moneda = @w_moneda

if @w_fldeci = 'S'
   select @w_numdeci = pa_tinyint
   from   cobis..cl_parametro
   where  pa_producto = 'AHO'
   and    pa_nemonico = 'DCI'
else
   select @w_numdeci = 0

/*  Determinacion de bloqueo de cuenta  */

select @w_tipo_bloqueo = cb_tipo_bloqueo
from   cob_ahorros..ah_ctabloqueada
where  cb_cuenta = @w_cta_depositada
  and  cb_estado = 'V'
  and  (cb_tipo_bloqueo = '2'
   or  cb_tipo_bloqueo = '3')
if @@rowcount <> 0
begin
   select @w_mensaje = 'CUENTA BLOQUEADA'
end

/* Encuentra alicuota del promedio */
select @w_alicuota = fp_alicuota
from   cob_ahorros..ah_fecha_promedio
where  fp_tipo_promedio = @w_tipo_prom
and    fp_fecha_inicio  = @w_fecdia

if @@rowcount = 0
begin
   exec cobis..sp_cerror
   @t_debug        = @t_debug,
   @t_file         = @t_file,
   @t_from         = @w_sp_name,
   @i_num          = 201060
   return 201060
end

/* Validar Fondos */
/* Debita del disponible tenga o no fondos suficientes */
if @i_valor > @w_12h
begin
   if @i_valor > @w_disponible
     begin
        select @w_mensaje = 'CUENTA SIN FONDOS DISPONIBLES'
     end
   else
     begin
        select @w_disponible = @w_disponible - @i_valor,
       @w_flag = 1
     end
end
else
   select @w_12h = @w_12h     - @i_valor,
      @w_12h_dif = @w_12h_dif - @i_valor,
      @w_flag    = 2

 /* Actualizacion de tabla de cuentas de ahorros */
select @w_alic = convert (money , round((@i_valor * @w_alicuota), @w_numdeci))
select @w_promedio1 = @w_promedio1 - @w_alic * @w_factor
if @w_flag = 1
   select @w_prom_disp = @w_prom_disp - @w_alic * @w_factor,
          @w_promedio1 = @w_promedio1 - @w_alic * @w_factor

select @w_debmes = @w_debmes + @i_valor * @w_factor,
       @w_debhoy = @w_debhoy + @i_valor * @w_factor

select @w_contable = @w_contable - @i_valor * @w_factor
select @w_trx = @w_trx + 1

/* Cambio a la bandera flag para la contabilizacion automatica */
--if @w_tipo_cheque <> 'L'
--  select @w_flag = 1
--else
--  select @w_flag = 2

begin tran

   select @w_lineas = @w_lineas + 1,
          @w_ssn    = @w_ssn + 1

   update cob_ahorros..ah_cuenta
      set ah_disponible      = @w_disponible,
          ah_promedio1       = @w_promedio1,
          ah_prom_disponible = @w_prom_disp,
          ah_12h             = @w_12h,
          ah_12h_dif         = @w_12h_dif,
          ah_fecha_ult_mov   = @w_fecdia,
          ah_contador_trx    = @w_trx,
          ah_debitos         = @w_debmes,
          ah_debitos_hoy     = @w_debhoy,
          ah_linea           = @w_lineas
   where ah_cuenta = @w_cta

   if @@rowcount <> 1
   begin
      exec cobis..sp_cerror
      @t_debug        = @t_debug,
      @t_file         = @t_file,
      @t_from         = @w_sp_name,
      @i_num          = 2600039
      return 2600039
   end

   /* Grabacion de Linea Pendiente por monto de cheque Devuelto*/
   /* Genera numero de Control para linea de libreta */
   exec @w_return = cobis..sp_cseqnos
   @t_from         = @w_sp_name,
   @i_tabla        = 'ah_control',
   @o_siguiente    = @w_control out
   if @w_return <> 0
      return @w_return
   if @w_control > 9999
   begin
        select @w_control = 0
        update cobis..cl_seqnos
        set siguiente = 0
        where tabla   = 'ah_control'
        if @@rowcount = 0
        begin
           exec cobis..sp_cerror
           @t_from         = @w_sp_name,
           @i_num          = 255005
           return 255005
        end
   end

   /* Genera numero de linea Pendiente */
   exec @w_return = cobis..sp_cseqnos
   @t_from      = @w_sp_name,
   @i_tabla     = 'ah_lpendiente',
   @o_siguiente = @w_lp_sec out

   if @w_return <> 0
      return @w_return

   if @w_lp_sec  > 2147483640
   begin
      select @w_lp_sec  = 1
      update cobis..cl_seqnos
      set siguiente = @w_lp_sec
      where tabla   = 'ah_lpendiente'
      if @@error <> 0
      begin
         exec cobis..sp_cerror
         @t_debug        = null,
         @t_file         = null,
         @t_from         = @w_sp_name,
         @i_num          = 105001
         return 1
      end
   end

   /* Inserta en Lineas Pendientes */
   insert into cob_ahorros..ah_linea_pendiente
          (lp_cuenta, lp_linea, lp_nemonico, lp_valor,
           lp_fecha, lp_control, lp_signo, lp_enviada)
   values (@w_cta, @w_lp_sec, 'NDDA', @i_valor,
           @i_fecha, @w_control, @w_signo, 'N')
   if @@rowcount <> 1
   begin
      exec cobis..sp_cerror
      @t_from         = @w_sp_name,
      @i_num          = 205001
      return 1
   end

   /* Transaccion Monetaria */
   /* campo vcomision, @w_comision inexistente, borrado */
   insert into cob_ahorros..ah_notcredeb
         (secuencial,     ssn_branch,  tipo_tran, oficina,   alterno,
          usuario,        terminal,    correccion,
          sec_correccion, reentry,     origen,
          nodo,           fecha,       cta_banco, signo,     causa,          val_cheque,
          valor,          remoto_ssn,  moneda,    saldocont, indicador,
          saldodisp,      filial,
          banco,          oficina_cta, prod_banc, categoria,
          tipocta_super,  turno,       hora,
          canal,          cliente)
   values (@w_ssn,          @w_ssn,     240,          @w_oficina,   1,
          @s_user,          @s_term,    'N',
          null,             'N',        'L',
          @s_srv,           @w_fecdia,  @w_cta_banco, @w_signo,     '0',     @i_valor,
          @i_valor,         null,       @w_moneda,    @w_contable,  @w_flag,
          @w_disponible,    @w_filial,
          null,             @w_oficina, @w_prod_banc, @w_categoria,
          @w_tipocta_super, @i_turno,   getdate(),
          @i_canal,         @w_cliente)

   if @@error <> 0
   begin
      exec cobis..sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 203000
      return 203000
   end

   exec @w_return = cob_remesas..sp_genera_costos
   @t_debug        = @t_debug,
   @t_file         = @t_file,
   @t_from         = @w_sp_name,
   @i_valor        = 1,
   @i_fecha        = @w_fecdia,
   @i_categoria    = @w_categoria,
   @i_tipo_ente    = @w_tipo_ente,
   @i_rol_ente     = @w_rol_ente,
   @i_tipo_def     = @w_tipo_def,
   @i_prod_banc    = @w_prod_banc,
   @i_producto     = @w_producto,
   @i_moneda       = @w_moneda,
   @i_tipo         = @w_tipo,
   @i_codigo       = @w_codigo,
   @i_servicio     = 'CDEV',
   @i_rubro        = '11',
   @i_disponible   = @w_disponible,
   @i_contable     = @w_contable,
   @i_promedio     = @w_promedio1,
   @i_prom_disp    = @w_prom_disp,
   @i_personaliza  = @w_personaliza,
   @i_filial       = @w_filial,
   @i_oficina      = @w_oficina,
   @i_is_batch     = 'S',
   @o_valor_total  = @w_comision out

   if @w_return <> 0
      return @w_return

   if @w_comision > 0
   begin
      exec @w_ssn = ADMIN...rp_ssn

      exec @w_return = cob_ahorros..sp_ahndc_automatica
      @s_srv         = @s_srv,
      @s_ssn         = @w_ssn,
      @s_ssn_branch  = @w_ssn,
      @s_ofi         = @w_oficina,
      @s_rol         = @s_rol,
      @s_user        = @s_user,
      @s_term        = @s_term,
      @t_trn         = 264,
      @i_cta         = @w_cta_banco,
      @i_val         = @w_comision,
      @i_cau         = '6',
      @i_mon         = @w_moneda,
      @i_fecha       = @w_fecdia,
      @i_imp         = 'S',
      @i_turno       = @i_turno

      if @w_return <> 0
         return @w_return
   end
commit tran
return 0

go

