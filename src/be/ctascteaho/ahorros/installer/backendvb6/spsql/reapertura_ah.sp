/************************************************************************/
/*  Archivo:            reapertura_ah.sp                                */
/*  Stored procedure:   sp_reapertura_ah                                */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 07-Dic-1993                                     */
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
/*                              PROPOSITO                               */
/*  Este programa realiza la transaccion de consulta de bloqueos        */
/*  contra valores de cuentas de ahorros.                               */
/*  204 = Reapertura de cuentas de ahorros.                             */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*      FECHA           AUTOR       RAZON                               */
/*  07/Dic/1993     P Mena          Emision inicial                     */
/*  04/Dic/1994     J. Bucheli      Personaclizacion para Banco de      */
/*                                  la Produccion                       */
/*  22/Jul/1999     M. Sanguino     Personaclizacion Baribe             */
/*  27/Jun/2006     P. Coello       Tomar Valor Interes de Transaccion  */
/*                                  de Servicio                         */
/*  29/Ago/2006     A. Riggs        Agrego la Oper='S', que permite     */
/*                                  obtener inf. de la cuenta           */
/*  02/May/2016     Juan Tagle      Migración a CEN                     */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_reapertura_ah')
   drop proc sp_reapertura_ah
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_reapertura_ah (
    @s_ssn                int,
    @s_ssn_branch         int,
    @s_srv                varchar(30) = null,
    @s_lsrv               varchar(30) = null,
    @s_user               varchar(30) = null,
    @s_sesn               int,
    @s_term               varchar(10),
    @s_date               datetime,
    @s_org                char(1),
    @s_ofi                smallint,    /* Localidad origen transaccion */
    @s_rol                smallint    = 1,
    @s_org_err            char(1)     = null, /* Origen de error:[A], [S] */
    @s_error              int         = null,
    @s_sev                tinyint     = null,
    @s_msg                mensaje     = null,
    @t_debug              char(1)     = 'N',
    @t_file               varchar(14) = null,
    @t_from               varchar(32) = null,
    @t_rty                char(1)     = 'N',
    @t_trn                smallint,
    @t_show_version       bit = 0,
    @i_cta                cuenta,
    @i_mon                tinyint,
    @i_turno              smallint    = null,
    @i_operacion          char(1)     = null,   --ARiggs 08-29-06
    @i_nombre             varchar(30) = null,   --ARiggs 08-29-06
    @i_formato_fecha      int         = 103,    --ARiggs 08-29-06
    @i_corresponsal       char(1)     = 'N',  --Req. 381 CB Red Posicionada
    @o_oficina_cta        smallint    = null out
)
as
declare
    @w_return               int,
    @w_sp_name              varchar(30),
    @w_cuenta               int,
    @w_filial               tinyint,
    @w_estado               char(1),
    @w_moneda               tinyint,
    @w_oficina_cta          smallint,
    @w_fecha_cierre         datetime,
    @w_creditos_mes         money,
    @w_creditos_hoy         money,
    @w_debitos_mes          money,
    @w_debitos_hoy          money,
    @w_saldo_ayer           money,
    @w_prom_disponible      money,
    @w_monto_imp            money,
    @w_mes_hoy              varchar(2),
    @w_anio_hoy             varchar(4),
    @w_mes_cierre           varchar(2),
    @w_anio_cierre          varchar(4),
    @w_credito2             money,
    @w_credito3             money,
    @w_credito4             money,
    @w_credito5             money,
    @w_credito6             money,
    @w_debito2              money,
    @w_debito3              money,
    @w_debito4              money,
    @w_debito5              money,
    @w_debito6              money,
    @w_saldo                money,
    @w_estado_cierre        char(1),
    @w_prod_banc            smallint,
    @w_tipocta_super        char(1),
    @w_saldo_interes        money,
    @w_int_mes              money,
    @w_interes_ganado       money,
    @w_ctacte               int,          --ARiggs 08-29-06
    @w_fecha_aper           varchar(10),  --ARiggs 08-29-06
    @w_forma_pg             char(4),
    @w_numorden             int,
    @w_causa_rev            char(1),
    @w_instrumento          int,
    @w_grupo1               varchar(255),
    @w_debug                char(1),
    @w_gmfmarca             char(1),
    @w_prod_bancario        varchar(50) --Req. 381 CB Red Posicionada

/* Captura del nombre del Store Procedure */
select @w_sp_name = 'sp_reapertura_ah'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

if @i_turno is null
    select @i_turno = @s_rol

/* Modo de debug */
if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug @t_file=@t_file
    select '/** Store Procedure **/ ' = @w_sp_name,
        s_ssn           = @s_ssn,
        s_srv           = @s_srv,
        s_user          = @s_user,
        s_sesn          = @s_sesn,
        s_term          = @s_term,
        s_date          = @s_date,
        s_ofi           = @s_ofi,
        s_rol           = @s_rol,
        s_org_err       = @s_org_err,
        s_error         = @s_error,
        s_sev           = @s_sev,
        s_msg           = @s_msg,
        t_debug         = @t_debug,
        t_file          = @t_file,
        t_from          = @t_from,
        t_rty           = @t_rty,
        t_trn           = @t_trn,
        i_cta       = @i_cta,
        i_mon       = @i_mon
    exec cobis..sp_end_debug
end

if @t_trn <> 204
begin
  /* Error en codigo de transaccion */
   exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num   = 201048
   return 1
end

select @w_debug = 'N'

--Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
select @w_prod_bancario = rtrim(cl_catalogo.codigo)
from cobis..cl_catalogo, cobis..cl_tabla
where cl_catalogo.tabla  = cl_tabla.codigo and
      cl_tabla.tabla     = 're_pro_banc_cb'
and   cl_catalogo.estado = 'V'

if @i_operacion = 'S'    --ARiggs 08-29-06
begin
/*Permite obtener datos asociados al cierre*/

   select @w_ctacte     = ah_cuenta,
          @w_fecha_aper = convert(char(10),ah_fecha_aper,@i_formato_fecha)
    from cob_ahorros..ah_cuenta
   where ah_cta_banco = @i_cta
     and ah_moneda    = @i_mon

   select 'Fecha Apert'       = @w_fecha_aper,
          'Fecha Cancelacion' = convert(char(10),hc_fecha,@i_formato_fecha),
          'Saldo Act.'        = hc_saldo,
          'Causa'             = substring(valor,1,35)
    from cob_ahorros..ah_his_cierre,cobis..cl_moneda,cobis..cl_catalogo
   where hc_cuenta = @w_ctacte
     and isnull(hc_estado,'C') in ('C','P')
     and mo_moneda = @i_mon
     and codigo    = hc_causa
     and tabla     = (select codigo
                      from   cobis..cl_tabla
                      where  tabla = 'ah_causa_cierre')

   if @w_debug = 'S'
      print @i_cta + ' @i_mon ' + cast(@i_mon as varchar) + ' @w_ctacte ' + cast(@w_ctacte as varchar)
   return 0
end


/* Se obtiene la filial */
select  @w_filial = of_filial
  from  cobis..cl_oficina
 where  of_oficina = @s_ofi

-- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
if @i_corresponsal = 'N'
begin
   select
   @w_cuenta          = ah_cuenta,
   @w_estado          = ah_estado,
   @w_oficina_cta     = ah_oficina,
   @w_fecha_cierre    = ah_fecha_ult_mov,
   @w_saldo_ayer      = ah_saldo_ayer,
   @w_prom_disponible = ah_prom_disponible,
   @w_creditos_hoy    = ah_creditos_hoy,
   @w_creditos_mes    = ah_creditos,
   @w_debitos_hoy     = ah_debitos_hoy,
   @w_debitos_mes     = ah_debitos,
   @w_monto_imp       = ah_monto_imp,
   @w_credito2        = ah_creditos2,
   @w_credito3        = ah_creditos3,
   @w_credito4        = ah_creditos4,
   @w_credito5        = ah_creditos5,
   @w_credito6        = ah_creditos6,
   @w_debito2         = ah_debitos2,
   @w_debito3         = ah_debitos3,
   @w_debito4         = ah_debitos4,
   @w_debito5         = ah_debitos5,
   @w_debito6         = ah_debitos6,
   @w_prod_banc       = ah_prod_banc,
   @w_tipocta_super   = ah_tipocta_super --,
   --@w_saldo_interes   = ah_saldo_interes,
   --@w_int_mes         = ah_int_mes,
   --@w_interes_ganado  = ah_interes_ganado
   from   cob_ahorros..ah_cuenta
   where  ah_cta_banco = @i_cta
   and    ah_moneda    = @i_mon
   and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada

   /* Chequeo de existencias */

   if @@rowcount <> 1
   begin
      /* No existe cuenta_banco */
      exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num   = 251001
     return 1
   end
end
else
begin
   select
   @w_cuenta          = ah_cuenta,
   @w_estado          = ah_estado,
   @w_oficina_cta     = ah_oficina,
   @w_fecha_cierre    = ah_fecha_ult_mov,
   @w_saldo_ayer      = ah_saldo_ayer,
   @w_prom_disponible = ah_prom_disponible,
   @w_creditos_hoy    = ah_creditos_hoy,
   @w_creditos_mes    = ah_creditos,
   @w_debitos_hoy     = ah_debitos_hoy,
   @w_debitos_mes     = ah_debitos,
   @w_monto_imp       = ah_monto_imp,
   @w_credito2        = ah_creditos2,
   @w_credito3        = ah_creditos3,
   @w_credito4        = ah_creditos4,
   @w_credito5        = ah_creditos5,
   @w_credito6        = ah_creditos6,
   @w_debito2         = ah_debitos2,
   @w_debito3         = ah_debitos3,
   @w_debito4         = ah_debitos4,
   @w_debito5         = ah_debitos5,
   @w_debito6         = ah_debitos6,
   @w_prod_banc       = ah_prod_banc,
   @w_tipocta_super   = ah_tipocta_super --,
   --@w_saldo_interes   = ah_saldo_interes,
   --@w_int_mes         = ah_int_mes,
   --@w_interes_ganado  = ah_interes_ganado
   from   cob_ahorros..ah_cuenta
   where  ah_cta_banco = @i_cta
   and    ah_moneda    = @i_mon

   /* Chequeo de existencias */

   if @@rowcount <> 1
   begin
      /* No existe cuenta_banco */
      exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num   = 251001
      return 1
   end
end

select @w_gmfmarca    = eg_marca
from   cob_ahorros..ah_exenta_gmf
where  eg_cta_banco= @i_cta
and    eg_marca    = 'S'

if @w_gmfmarca is null
   select @w_gmfmarca = 'N'

if @w_gmfmarca = 'S'
begin
   select @w_gmfmarca    = eg_marca
   from   cob_ahorros..ah_exenta_gmf
   where  eg_cta_banco<> @i_cta
   and    eg_marca    = 'S'

   if @@rowcount <> 0
   begin
      exec cobis..sp_cerror
           @t_debug    = @t_debug,
           @t_file     = @t_file,
           @t_from     = @w_sp_name,
           @i_msg      = 'Tiene otra cuenta marcada con exoneracion de GMF. Por favor verificar',
           @i_num      = 2600093
      return 2600093
   end
end


select @o_oficina_cta = @w_oficina_cta

/* Validaciones */
if @w_estado <> 'C'
begin
  /* Cuenta no se encuentra cancelada */
   exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num   = 251041
   return 1
end

-- Verificar la fecha de reapertura sea dentro del mismo mes

   select @w_mes_cierre = convert(varchar(2),datepart(mm,@w_fecha_cierre))
   select @w_anio_cierre = convert(varchar(4),datepart(yy,@w_fecha_cierre))
   select @w_mes_hoy = convert(varchar(2),datepart(mm,@w_fecha_cierre))
   select @w_anio_hoy = convert(varchar(4),datepart(yy,@w_fecha_cierre))

   if @w_mes_cierre = @w_mes_hoy and @w_anio_cierre = @w_anio_hoy
                 and @w_fecha_cierre <> @s_date
    select @w_creditos_hoy = 0,
           @w_debitos_hoy = 0,
           @w_saldo_ayer  = 0

-- Verificar la fecha de reapertura sea dentro de otro mes
   if @w_mes_cierre <> @w_mes_hoy and @w_anio_cierre = @w_anio_hoy
      select
      @w_creditos_hoy = 0,
      @w_debitos_hoy = 0,
      @w_creditos_mes = 0,
      @w_debitos_mes = 0,
      @w_prom_disponible = 0,
      @w_saldo_ayer  = 0,
      @w_monto_imp   = 0,
      @w_credito2    = 0,
      @w_credito3    = 0,
      @w_credito4    = 0,
      @w_credito5    = 0,
      @w_credito6    = 0,
      @w_debito2     = 0,
      @w_debito3     = 0,
      @w_debito4     = 0,
      @w_debito5     = 0,
      @w_debito6     = 0

if exists( select 1
           from  cob_ahorros..ah_his_cierre
           where hc_cuenta = @w_cuenta
           and   hc_estado = 'P')
begin
       select @w_saldo         = 0 -- ESTADO P INDICA QUE EL SALDO YA FUE PAGADO POR SBA
       select @w_estado_cierre = 'P'
       select @w_saldo_interes = 0 -- El interes se capitalizo en el cierre
end
else
begin
   select @w_saldo         = hc_saldo,
          @w_estado_cierre = hc_estado,
          @w_forma_pg      = hc_forma_pg,
          @w_numorden      = hc_sec_ord_pago
   from   cob_ahorros..ah_his_cierre
   where  hc_cuenta = @w_cuenta
   and    hc_estado = 'C'

   if @@rowcount <> 1
   begin
      /* VALOR DE CIERRE NO COINCIDE */
      exec cobis..sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 251055
      return 1
   end
   if isnull(@w_saldo,0) > 0
   begin
      if @w_forma_pg = 'E'
      begin
         exec @w_return = cob_remesas..sp_genera_orden
         @s_date      = @s_date,
         @s_user      = @s_user,
         @i_operacion = 'A',
         @i_idorden   = @w_numorden,
         @i_interfaz  = 'S'

         if  @w_return <> 0 or @@error <> 0
         begin
            if @w_return < 32500 or  @w_return is null
               select @w_return = 251055
            exec cobis..sp_cerror
            @t_debug  = @t_debug,
            @t_file   = @t_file,
            @t_from   = @w_sp_name,
            @i_num    = @w_return

            return @w_return
         end
      end

      if @w_forma_pg = 'G'
      begin

         select @w_instrumento = pa_int
         from   cobis..cl_parametro
         where  pa_nemonico = 'CCHGER'
         and    pa_producto = 'SBA'

         select @w_causa_rev      = 'T'

         select
         @w_grupo1 = cast(@w_numorden as varchar) + '@' +
         @w_causa_rev                   + '@' +
         ''                             + '@' +
         ''                             + '@' +
         ''                             + '@' +
         cast(@i_mon as varchar) + '@'

         exec @w_return = cob_sbancarios..sp_actualizar_lotes
         @s_ssn          = @s_ssn,
         @s_date         = @s_date,
         @s_user         = @s_user,
         @s_term         = @s_term,
         @s_ofi          = @s_ofi,
         @s_srv          = @s_srv,
         @s_lsrv         = @s_lsrv,
         @t_trn          = 29301,
         @i_producto     = 4,
         @i_instrumento  = @w_instrumento,
         @i_causa_anul   = '99',
         @i_subtipo      = @w_instrumento,
         @i_grupo1       = @w_grupo1,
         @i_llamada_ext  = 'S'

         if @w_return <> 0
         begin
            /* Error al actualizar cheque */
            exec cobis..sp_cerror
                @t_debug     = @t_debug,
                @t_file      = @t_file,
                @t_from      = @w_sp_name,
                @i_num   = 255001
            return 1

         end

      end
   end
end

if @w_fecha_cierre <> @s_date
begin
   select @w_saldo_interes  = $0,
          @w_int_mes        = $0,
          @w_interes_ganado = $0
end
else  --PCOELLO TOMA EL VALOR DE LA TRANSACCION DE SERVICIO y GRABA REVERSO
begin
  if exists(select 1
            from  cob_ahorros..ah_tran_servicio
            where ts_tipo_transaccion = 323
            and   ts_ctacte           = @w_cuenta
            and   ts_estado          is null
            and   ts_tsfecha          = @s_date)
  begin
     select
     @w_saldo_interes = isnull(ts_valor, 0), @w_int_mes = isnull(ts_valor, 0),
     @w_interes_ganado = isnull(ts_saldo, 0)
     from  cob_ahorros..ah_tran_servicio
     where ts_tipo_transaccion = 323
     and   ts_ctacte           = @w_cuenta
     and   ts_estado          is null

     insert into cob_ahorros..ah_tran_servicio
     (ts_secuencial, ts_ssn_branch, ts_tipo_transaccion,
      ts_tsfecha,    ts_usuario,    ts_terminal,         ts_ctacte,
      ts_filial,     ts_valor,      ts_oficina,          ts_oficina_cta,
      ts_prod_banc,  ts_categoria,  ts_moneda,           ts_tipocta_super,
      ts_turno,      ts_saldo,      ts_cta_banco,        ts_estado,
      ts_ssn_corr,   ts_correccion)
     select
      @s_ssn,        @s_ssn_branch, ts_tipo_transaccion,
      ts_tsfecha,    ts_usuario,    ts_terminal,          ts_ctacte,
      ts_filial,     ts_valor,      ts_oficina,           ts_oficina_cta,
      ts_prod_banc,  ts_categoria,  ts_moneda,            ts_tipocta_super,
      ts_turno,      ts_saldo,      ts_cta_banco,         'R',
      ts_ssn_branch, 'S'
     from  cob_ahorros..ah_tran_servicio
     where ts_tipo_transaccion = 323
     and   ts_ctacte           = @w_cuenta
     and   ts_estado           is null

     update cob_ahorros..ah_tran_servicio
     set    ts_estado = 'R'
     where  ts_tipo_transaccion = 323
     and    ts_ctacte = @w_cuenta
     and    ts_estado is null

     if @w_estado_cierre = 'P'
     begin
        select
        @w_saldo_interes  = 0, @w_int_mes = 0,
        @w_interes_ganado = 0
     end
   end
   else
        SELECT @w_saldo_interes = 0, @w_int_mes = 0, @w_interes_ganado = 0
end

begin tran

/* Actualizacion del estado de la cuenta de ahorros */

update cob_ahorros..ah_cuenta set
ah_estado          = 'A',
ah_creditos        = @w_creditos_mes,
ah_creditos_hoy    = @w_creditos_hoy,
ah_debitos         = @w_debitos_mes,
ah_debitos_hoy     = @w_debitos_hoy,
ah_saldo_ayer      = @w_saldo_ayer,
ah_prom_disponible = @w_prom_disponible,
ah_monto_imp       = @w_monto_imp,
ah_creditos2       = @w_credito2,
ah_creditos3       = @w_credito3,
ah_creditos4       = @w_credito4,
ah_creditos5       = @w_credito5,
ah_creditos6       = @w_credito6,
ah_saldo_interes   = @w_saldo_interes,
ah_int_mes         = @w_int_mes,
ah_interes_ganado  = @w_interes_ganado
where ah_cuenta = @w_cuenta

if @@rowcount <> 1
begin
   /* Error al actualizar cuenta de ahorros */
   exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num   = 255001
   return 1
end

/* Actualizacion del Detalle del Producto */
update cobis..cl_det_producto
set    dp_estado_ser = 'V'
where  dp_cuenta   = @i_cta
and    dp_producto = 4

if @@rowcount <> 1
begin
   /* Error en actualizacion de registro en cl_det_producto */
   exec cobis..sp_cerror
      @t_debug      = @t_debug,
      @t_file       = @t_file,
      @t_from       = @w_sp_name,
      @i_num        = 105050
   return 1
end

/* Actualizacion del historico de cierre */
update cob_ahorros..ah_his_cierre
  set hc_fecha_act    = @s_date,
      hc_estado       = 'R',
      hc_nombre_rt    = isnull(@i_nombre,@s_user),  --ARiggs 08-29-06
      hc_observacion  = '',
      hc_observacion1 = ''
where hc_cuenta = @w_cuenta
  and hc_estado = @w_estado_cierre

if @@rowcount <> 1
begin
   /* Error al actualizar la tabla cc_his_cierre */
   exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file    = @t_file,
      @t_from    = @w_sp_name,
      @i_num     = 205019
   return 1
end
if @w_saldo > 0
begin
   -- GENERA LA NOTA DE CREDITO CAUSA 42 REAPERTURA DE CUENTA
   exec @w_return = cob_ahorros..sp_ahndc_automatica
   @s_srv         = @s_srv,
   @s_ofi         = @s_ofi,
   @s_ssn         = @s_ssn,
   @s_user        = @s_user,
   @s_term        = @s_term,
   @t_trn         = 253,
   @i_cta         = @i_cta,
   @i_val         = @w_saldo,
   @i_cau         = '42',
   @i_mon         = @i_mon,
   @i_fecha       = @s_date,
   @i_inmovi      = 'N'

   if @w_return <> 0
      return @w_return
end
/* Creacion de transaccion de servicio */
insert into cob_ahorros..ah_tscambia_estado
(secuencial, ssn_branch, tipo_transaccion, tsfecha,
 usuario,    terminal,   reentry,          oficina, origen,
 cta_banco,  moneda,     estado,           oficina_cta,
 turno,      prod_banc,  tipocta_super)
values
(@s_ssn,  @s_ssn_branch, @t_trn,           @s_date,
 @s_user, @s_term,       @t_rty,           @s_ofi, @s_org,
 @i_cta,  @i_mon,        'A',              @w_oficina_cta,
 @i_turno,@w_prod_banc,  @w_tipocta_super)

if @@error <> 0
begin
  /* Error en creacion de transaccion de servicio */
  exec cobis..sp_cerror
       @t_debug  = @t_debug,
       @t_file   = @t_file,
       @t_from   = @w_sp_name,
       @i_num    = 203005
  return 1
end

commit tran

return 0

go

