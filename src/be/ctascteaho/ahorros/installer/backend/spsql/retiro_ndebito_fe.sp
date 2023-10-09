/************************************************************************/
/*      Archivo:            retiro_ndebito_fe.sp                        */
/*  Stored procedure:       sp_retiro_ndebito_fe                        */
/*  Base de datos:          cob_ahorros                                 */
/*  Producto:               Cuentas de Ahorros                          */
/*  Disenado por:           Julio Navarrete/Javier Bucheli              */
/*  Fecha de escritura:     25-Feb-1993                                 */
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
/*  Este programa procesa las transacciones de depositos y nota de      */
/*  credito con fecha efectiva                                          */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA          AUTOR        RAZON                                   */
/*  07/Dic/1993    J Navarrete  Emision inicial                         */
/*  21/ene/2010    CMunoz       FRC-AHO-017-CobroComisiones CMU 2102110 */
/*  10/Abr/2013    J Colorado   Reintegro de GMF Alianza Cormecial      */
/*  02/Mayo/2016   Juan Tagle   Migración a CEN                         */
/************************************************************************/

use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_retiro_ndebito_fe')
        drop proc sp_retiro_ndebito_fe
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_retiro_ndebito_fe (
    @s_ssn            int,
    @s_srv            varchar(30),
    @s_lsrv           varchar(30),
    @s_ofi            smallint,
    @s_term           varchar(15) = null,
    @s_user           varchar(30) = 'AHO',
    @s_ssn_branch     int,
    @t_corr           char(1)     = 'N',
    @t_debug          char(1)     = 'N',
    @t_file           varchar(14) = null,
    @t_from           varchar(30) = null,
    @t_ejec           char(1)     = null,
    @t_ssn_corr       int         = null,
    @t_trn            int,
    @t_show_version   bit = 0,
    @i_filial         tinyint,
    @i_ofi            smallint,
    @i_cuenta         int,
    @i_val            money,
    @i_cau            varchar(3),
    @i_mon            tinyint,
    @i_ind            tinyint,
    @i_factor         smallint,
    @i_fecha          datetime,
    @i_fecha_efec     datetime,
    @i_marca          char(1),
    @i_canal          tinyint     = 4, --4 CAJAS
    @o_sldcont        money       out,
    @o_slddisp        money       out,
    @o_aj_int         money       out,
    @o_aj_cap         money       out,
    @o_aj_ret         money       out,
    @o_nombre         varchar(60) out,
    @o_cedula         varchar(20) out,
    @o_fecha          datetime    out,
    @o_ofi_cta        smallint    out,
    @o_prod_banc      tinyint     = null out,
    @o_clase_clte     char(1)     = null out,
    @o_val_nx1000     money       = null out,
    @o_valiva         money       = null out,
    @o_base_gmf       money       = null out,
    @o_concep_exc     smallint    = 0    out,
    @o_cliente        int         = null out,
    @o_categoria      char(1)     = null out, --MVE AH00007
    @o_tipocta_super  char(1)     = null out
)
as
declare
@w_return               int,
@w_sp_name              varchar(30),
@w_alic                 numeric(11,10),
@w_tasa                 float,
@w_fecha_aper           datetime,
@w_fecha_tmp            datetime,
@w_contador             smallint,
@w_capital_acum         money,
@w_ajuste_interes       money,
@w_interes_acum         money,
@w_tot_alic             money,
@w_tot                  money,
@w_saldo_para_girar     money,
@w_contable             money,
@w_saldo_minimo         money,
@w_disponible           money,
@w_retfte_tot           money,
@w_retfte_acum          money,
@w_retencion            char(1),
@w_promedio1            money,
@w_debitos              money,
@w_debhoy               money,
@w_sec                  int,
@w_dias_anio            float,
@w_num_dias             smallint,
@w_ndci                 tinyint,
@w_mes_efec             tinyint,
@w_mes_act              tinyint,
@w_anio_act             tinyint,
@w_mensaje              mensaje,
@w_tipo_bloqueo         char(3),
@w_tipo_prom            char(1),
@w_prom_disp            money,
@w_usadeci              char(1),
@w_tasa_efectiva        money,
@w_sldtmp               money,
@w_sldtmp1              money,
@w_prod_banc            tinyint,
@w_tipo_ente            char(1),
@w_categoria            char(1),
@w_rol_ente             char(1),
@w_default              int,
@w_producto             tinyint,
@w_tipo                 char(1),
@w_moneda               tinyint,
@w_personalizada        char(1),
@w_diftasa              float,
@w_tasa_ret             float,
@w_tipo_def             char(1),
@w_reentry              varchar(200),
@w_clave                int,
@w_cta                  varchar(12),
@w_error                char(1),
@w_fecpro               smalldatetime,
@w_fecha_aux            datetime,
@w_ndebmes              int,
@w_sldmin               money,
@w_numdeciimp           tinyint,
@w_imp_nx1000           float,
@w_reg_impnx1000        char(1),
@w_comision             money,
@w_impuesto             money,
@w_piva                 float,
@w_val_efe              money,
@w_timpuesto            real,
@w_cliente              int,
@w_clase_clte           char(1),
@w_codigo_pais          catalogo,
@w_acumu_deb            money,
@w_actualiza            char(1),
@w_fecha_ult_capi       datetime,
@w_valiva_tarifa        money,
@w_cobro_comision       money,
/*FRC-AHO-017-CobroComisiones CMU 2102110*/
@w_numdeb               int,
@w_numtot               int,
@w_numero               int,
@w_numcre               int,
@w_numco                int,
@w_tipocobro            char(1),
@w_factor1              float,
@w_factor2              float,
@w_factor               float,
@w_exento               char(1),
@w_cpto_rte             char(4),
@w_concto_iva           char(4),
@w_base_rtfte           money,
@w_binc                 money,
@w_porcentaje           float,
@w_total_val_imp        money,
@w_com_iva              char(1),
@w_rowcount             smallint,
@w_val_2x1000           money,
-- REQ 306 VALIDA DEPOSITO INICIAL
@w_estado               char(1),
@w_tasa_reintegro       float,
@w_gmf_reintegro        money


/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_retiro_ndebito_fe'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

--print @w_sp_name

/* Valida la fecha efectiva */
if @i_fecha_efec >= @i_fecha
begin
   exec cobis..sp_cerror
   @t_debug   = @t_debug,
   @t_file    = @t_file,
   @t_from    = @w_sp_name,
   @i_num     = 251020
   return 251020
end

/* Encuentra parametro de decimales */
select @w_usadeci = mo_decimales
from   cobis..cl_moneda
where  mo_moneda = @i_mon

if @w_usadeci = 'S'
  begin
    select @w_ndci = pa_tinyint from cobis..cl_parametro
     where pa_nemonico = 'DCI'
       and pa_producto = 'AHO'

    select @w_numdeciimp = pa_tinyint from cobis..cl_parametro
     where pa_nemonico = 'DIM'
       and pa_producto = 'AHO'

  end
else
  select @w_ndci       = 0,
         @w_numdeciimp = 0

/*  Determinacion de bloqueo de cuenta  */
select @w_tipo_bloqueo = cb_tipo_bloqueo
  from cob_ahorros..ah_ctabloqueada
 where cb_cuenta = @i_cuenta
   and cb_estado = 'V'
   and cb_tipo_bloqueo in ('2', '3')

if @@rowcount <> 0
begin
     select @w_mensaje = rtrim(valor) from cobis..cl_catalogo
     where  cobis..cl_catalogo.tabla =
             (select cobis..cl_tabla.codigo
                  from cobis..cl_tabla
                  where tabla = 'cc_tbloqueo')
     and cobis..cl_catalogo.codigo = @w_tipo_bloqueo
     select @w_mensaje = 'Cuenta bloqueada: ' + @w_mensaje
     exec cobis..sp_cerror
            @t_from         = @w_sp_name,
            @i_num          = 251007,
            @i_sev          = 1,
            @i_msg          = @w_mensaje
     return 251007
end

/*  Actualizacion de saldos  */
exec @w_return = cob_ahorros..sp_ahcalcula_saldo
                        @t_from         = @w_sp_name,
                        @i_cuenta       = @i_cuenta,
                        @i_fecha        = @i_fecha,
                        @i_ofi          = @s_ofi,
            @o_saldo_para_girar = @w_saldo_para_girar out,
            @o_saldo_contable   = @w_contable out
if @w_return <> 0
    return @w_return

/* lee tabla de ctas de ahorros */

select
@w_tipo_prom     = ah_tipo_promedio,
@w_fecha_aper    = convert (varchar(10),ah_fecha_aper, 101),
@o_nombre        = substring (ah_nombre,1, 60),
@o_cedula        = ah_ced_ruc,
@o_ofi_cta       = ah_oficina,
@w_disponible    = ah_disponible,
@w_debitos       = ah_debitos,
@w_debhoy        = ah_debitos_hoy,
@w_promedio1     = ah_promedio1,
@w_prom_disp     = ah_prom_disponible,
@w_tipo_ente     = ah_tipocta,
@w_rol_ente      = ah_rol_ente,
@w_tipo_def      = ah_tipo_def,
@w_default       = ah_default,
@w_personalizada = ah_personalizada,
@w_prod_banc     = ah_prod_banc,
@w_producto      = ah_producto,
@w_tipo          = ah_tipo,
@w_moneda        = ah_moneda,
@w_cta           = ah_cta_banco,
@w_categoria     = ah_categoria,
@w_clase_clte    = ah_clase_clte,
@w_reg_impnx1000 = ah_nxmil,
@w_cliente       = ah_cliente,
@w_fecha_ult_capi= convert(varchar(10),ah_fecha_ult_capi,101),
@o_tipocta_super = ah_tipocta_super,
/*FRC-AHO-017-CobroComisiones CMU 2102110*/
@w_ndebmes       = isnull(ah_num_deb_mes,0),
@w_estado        = ah_estado  --Req 306
from cob_ahorros..ah_cuenta with(nolock)
where ah_cuenta = @i_cuenta

/* Validar que la fecha efectiva no sea menor a la fecha de apertura */
if @w_fecha_aper > @i_fecha_efec
begin
     exec cobis..sp_cerror
     @t_debug   = @t_debug,
     @t_file    = @t_file,
     @t_from    = @w_sp_name,
     @i_num     = 251054
     return 251054
end

/* REQ 306 DEPOSITO INICIAL APERTURA */
if @w_estado in ('G','N')
begin
   exec cobis..sp_cerror
   @t_debug  = @t_debug,
   @t_file   = @t_file,
   @t_from   = @w_sp_name,
   @i_num    = 251099

   return 251099
end

--Ini JAR 18/01/2010
/* Si fecha de ultima capitalizacion es superior a fecha efectiva generar debito */
if @w_fecha_ult_capi <= @i_fecha_efec
begin
     exec cobis..sp_cerror
     @t_debug   = @t_debug,
     @t_file    = @t_file,
     @t_from    = @w_sp_name,
     @i_num     = 251054,
     @i_msg     = 'FECHA ULTIMA CAPITALIZACION MENOR A FECHA EFECTIVA'
     return 251054
end
--Fin JAR 18/01/2010

select @w_binc  = isnull(pa_money,0)
from   cobis..cl_parametro
where  pa_producto = 'AHO'
and    pa_nemonico = 'BINCR'

if @@rowcount <> 1
begin
    exec cobis..sp_cerror
    @i_num       = 201196,
    @i_msg       = 'ERROR EN PARAMETRO DE BASE DIARIA'
    return 201196
end


/* CALCULO IMPUESTO NX1000 */
select @w_codigo_pais = pa_char
from  cobis..cl_parametro
where pa_nemonico = 'ABPAIS'
and   pa_producto = 'ADM'

if @@rowcount = 0
begin
   /** No existe parametro de pais local **/
   exec cobis..sp_cerror
   @t_debug  = @t_debug,
   @t_file   = @t_file,
   @t_from   = @w_sp_name,
   @i_num    = 101190
   return 101190
end

/*INICIO COBRO IVA*/
if @w_codigo_pais = 'CO' -- Colombia
begin

  select @w_com_iva = an_comision
    from cob_remesas..re_accion_nd
   where an_producto = 4
     and an_causa = @i_cau

  select @w_rowcount = @@rowcount

  if @w_rowcount = 0
     select @w_com_iva  = 'N'

   if @w_com_iva = 'S'
   begin
      select @w_concto_iva = ci_concepto
      from   cob_remesas..re_concepto_imp
      where  ci_tran     = @t_trn
      and    ci_causal   = @i_cau
      and    ci_impuesto = 'V'

      if @@rowcount = 0
      begin
         print '@i_cau: ' + @i_cau + ' @t_trn' + cast(@t_trn as varchar)
         /** No existe parametro de pais local **/
         exec cobis..sp_cerror
            @t_debug  = @t_debug,
            @t_file   = @t_file,
            @t_from   = @w_sp_name,
            @i_num    = 201232
         return 201232
      end

      exec @w_return  = cob_interfase..sp_icon_impuestos
      @i_empresa      = 1,
      @i_concepto     = @w_concto_iva,
      @i_debcred      = 'C',
      @i_monto        = @i_val,
      @i_impuesto     = 'V',
      @i_oforig_admin = @o_ofi_cta,
      @i_ofdest_admin = @o_ofi_cta,
      @i_ente         = @w_cliente,
      @i_producto     = 4,
      @o_exento       = @w_exento  out,
      @o_porcentaje   = @w_porcentaje out

      if @w_return <> 0
      begin
          rollback
          return @w_return
      end

      if @w_exento = 'N'
         select @w_piva = @w_porcentaje
      else
         select @w_piva = 0

      select @w_impuesto  = round((@i_val * @w_piva / 100), @w_numdeciimp)
      select @o_valiva  =  @w_impuesto
      select @w_total_val_imp =  @i_val + @w_impuesto

   end
   else
     select @w_total_val_imp =  @i_val

   select @o_val_nx1000 = $0

   --  Llama sp que calcula GMF de acuerdo a concepto exencion
   exec @w_return = sp_calcula_gmf
   @s_user               = @s_user,
   @s_date               = @i_fecha,
   @s_ofi                = @s_ofi,
   @t_trn                = @t_trn,
   @t_ssn_corr           = @t_ssn_corr,
   @i_factor             = @i_factor,
   @i_mon                = @i_mon,
   @i_cta                = @w_cta,
   @i_cuenta             = @i_cuenta,
   @i_cliente            = @w_cliente,
   @i_val                = @w_total_val_imp, --@i_val,
   @i_val_tran           = @w_total_val_imp, --@i_val,
   @i_numdeciimp         = @w_numdeciimp,
   @i_producto           = @w_producto,
   @i_operacion          = 'Q',
   @o_total_gmf          = @o_val_nx1000 out,
   @o_acumu_deb          = @w_acumu_deb  out,
   @o_actualiza          = @w_actualiza  out,
   @o_base_gmf           = @o_base_gmf   out,
   @o_concepto           = @o_concep_exc out,
   @o_tasa_reintegro     = @w_tasa_reintegro out, --JCO
   @o_valor_reintegro    = @w_gmf_reintegro  out   -- JCO

   if @w_return <> 0
      return @w_return

   select
   @o_clase_clte   = @w_clase_clte,
   @o_prod_banc    = @w_prod_banc,
   @o_cliente      = @w_cliente,
   @o_ofi_cta      = @o_ofi_cta

   if @i_factor = -1
   begin
          select @w_val_2x1000 = isnull(tm_monto_imp,0)
          from   cob_ahorros..ah_tran_monet
          where  tm_ssn_branch = @t_ssn_corr
          and    tm_oficina    = @s_ofi
          --and    tm_cod_alterno = 1

          select @o_val_nx1000 = isnull(@o_val_nx1000, $0) + @w_val_2x1000
   end

end

/* Encuentra numero de dias desde fecha efectiva hasta hoy */
select @w_num_dias = datediff (day, @i_fecha_efec, @i_fecha)

/* Encuentra numero de dias del anio */
select @w_dias_anio = isnull(pa_smallint, 0)
 from cobis..cl_parametro
where pa_nemonico = 'DIA'
  and pa_producto = 'ADM'

/* Encuentra el primero del mes actual */
select @w_fecha_tmp = (convert(char(2),datepart(mm,@i_fecha)) +
                      '/01/' +
                      convert(char(4),datepart(yy,@i_fecha)))
if @i_fecha_efec > @w_fecha_tmp
   select @w_fecha_tmp = @i_fecha_efec

/* SMHB: Transacciones Inusuales    */
select  @w_ndebmes = @w_ndebmes + ( 1 * @i_factor )

/* Encuentra la alicuota para el promedio */
select @w_fecpro = @w_fecha_tmp

select @w_alic = fp_alicuota
from  cob_ahorros..ah_fecha_promedio
 where fp_tipo_promedio = @w_tipo_prom
   and fp_fecha_inicio = @w_fecpro

if @@rowcount = 0
begin
     exec cobis..sp_cerror
          @t_debug        = @t_debug,
          @t_file         = @t_file,
          @t_from         = @w_sp_name,
          @i_num          = 251013
     return 251013
end

/* Valida Fondos */
if @i_factor = 1
begin
     if @i_val > @w_saldo_para_girar
     begin
       exec cobis..sp_cerror
            @t_debug  = @t_debug,
            @t_file   = @t_file,
            @t_from   = @w_sp_name,
            @i_num    = 251033
       return 251033
     end
end


select
@w_interes_acum = 0.0,
@w_capital_acum = 0,
@i_val          = isnull (@i_val, 0),
@w_sldtmp       = isnull (@w_sldtmp,0),
@w_sldtmp1      = isnull (@w_sldtmp1,0),
@w_tasa         = isnull (@w_tasa,0),
@w_retfte_acum  = 0.0,
@w_retfte_tot   = 0.0



          /* Procesa las transacciones con fecha efectiva */
select
@w_contador = 0,
@w_ajuste_interes = 0,
@w_retfte_tot     = 0,
@w_interes_acum   = 0,
@w_retfte_acum    = 0

/* COBRO RTEFTE */
if @w_codigo_pais = 'CO'
begin
   select @w_cpto_rte = ci_concepto
   from   cob_remesas..re_concepto_imp
   where  ci_tran        = 308--Revisar trn
   and    ci_impuesto    = 'R' --Verificar nemonico tipo de impuesto
    and   ci_contabiliza = 'tm_valor'

   if @@rowcount <> 1
   begin
       exec cobis..sp_cerror
       @i_num       = 201196,
       @i_msg       = 'ERROR EN PARAMETRO DE CONCEPTO DE RETENCION'
       return 201196
   end

   select @w_retencion = isnull(en_retencion, 'N')
   from cobis..cl_ente
   where en_ente = @o_cliente

   if @@rowcount = 0
   begin
      /* Error en insercion de transaccion servicio */
      exec cobis..sp_cerror
      @t_debug      = @t_debug,
      @t_file       = @t_file,
      @t_from       = @w_sp_name,
      @i_num        = 121032
      return 121032
   end

   select @w_base_rtfte = @w_num_dias * @w_binc

end
else
   select @w_cpto_rte    = null



while @w_contador <= (@w_num_dias - 1)
begin

   select @w_fecha_tmp = dateadd (day, @w_contador, @i_fecha_efec)

   if @w_fecha_tmp <> @i_fecha
   begin
      /* Encuentra tasa de interes de la fecha temporal */
      select
      @w_fecha_aux = max(sd_fecha)
      from  cob_ahorros_his..ah_saldo_diario
      where sd_cuenta = @i_cuenta
      and   sd_fecha <= @w_fecha_tmp

      select
      @w_tasa   = sd_tasa_disponible,
      @w_sldtmp = isnull(sd_saldo_disponible,0)
      from  cob_ahorros_his..ah_saldo_diario
      where sd_cuenta = @i_cuenta
      and   sd_fecha = @w_fecha_aux
   end
   else
      select @w_tasa = 0

   select @w_sldtmp1 = @w_sldtmp - @i_val
   if @w_sldtmp1 < 0  --CCB
   begin
       exec cobis..sp_cerror
       @t_debug        = @t_debug,
       @t_file         = @t_file,
       @t_from         = @w_sp_name,
       @i_num          = 208003
      return 208003
   end

   exec @w_return = cob_remesas..sp_genera_costos
    @s_srv           = @s_srv,
    @s_ofi           = @s_ofi,
    @s_ssn           = @s_ssn,
    @s_user          = @s_user,
    @i_filial        = @i_filial,
    @i_oficina       = @i_ofi,
    @i_categoria     = @w_categoria,
    @i_tipo_ente     = @w_tipo_ente,
    @i_rol_ente      = @w_rol_ente,
    @i_tipo_def      = @w_tipo_def,
    @i_prod_banc     = @w_prod_banc,
    @i_producto      = @w_producto,
    @i_moneda        = @w_moneda,
    @i_tipo          = @w_tipo,
    @i_codigo        = @w_default,
    @i_servicio      = 'PINT',
    @i_rubro         = '18',
    @i_fecha         = @w_fecha_tmp,
    @i_disponible    = @w_sldtmp1,
    @i_contable      = @w_sldtmp1,
    @i_promedio      = @w_promedio1,
    @i_personaliza   = @w_personalizada,
    @i_prom_disp     = @w_prom_disp,
    @o_valor_total   = @w_tasa_efectiva out

   if @w_return <> 0
      return @w_return

   select @w_diftasa = @w_tasa - @w_tasa_efectiva

   select @w_factor1 = 1 + @w_tasa_efectiva
   select @w_factor2 = (convert(float,1)) / @w_dias_anio /*calculo del factor */
   select @w_factor  = (power (@w_factor1, @w_factor2) - 1)

   select  @w_interes_acum =  (@w_capital_acum + @i_val) * @w_factor


   if @w_codigo_pais <> 'CO'
   begin

      /* Encontrar los parametros de personalizacion */
      /* Tasa para la tasa de PINT para retencion en la fuente */
      exec @w_return = cob_remesas..sp_genera_costos
          @s_srv           = @s_srv,
          @s_ofi           = @s_ofi,
          @s_ssn           = @s_ssn,
          @s_user          = @s_user,
          @t_debug       = 'N',
          @t_file        =  null,
          @t_from        = @w_sp_name,
          @i_filial    = @i_filial,
          @i_oficina       = @i_ofi,
          @i_fecha       = @w_fecha_tmp,
          @i_valor       = 1,
          @i_categoria   = @w_categoria,
          @i_tipo_ente   = @w_tipo_ente,
          @i_rol_ente    = @w_rol_ente,
          @i_tipo_def    = @w_tipo_def,
          @i_prod_banc   = @w_prod_banc,
          @i_producto    = @w_producto,
          @i_moneda      = @w_moneda,
          @i_tipo        = @w_tipo,
          @i_codigo      = @w_default,
          @i_servicio    = 'PINT',
          @i_rubro       = '19',
          @i_disponible  = @w_sldtmp1,
          @i_contable    = @w_contable,
          @i_promedio    = @w_promedio1,
          @i_prom_disp   = @w_prom_disp,
          @i_personaliza = @w_personalizada,
          @o_valor_total = @w_tasa_ret out

      if @w_return <> 0
         return @w_return

      /* Calculo para hallar valor de retencion sobre intereses */
      select @w_retfte_acum = round(@w_interes_acum * @w_tasa_ret, @w_numdeciimp)
   end

   select @w_retfte_tot = @w_retfte_tot + @w_retfte_acum,
          @w_ajuste_interes = @w_ajuste_interes + @w_interes_acum

   select @w_capital_acum = @w_capital_acum + @w_interes_acum
        -- + @w_retfte_acum

   select @w_interes_acum = 0,
          @w_retfte_acum  = 0,
          @w_contador     = @w_contador + 1

end


if @w_codigo_pais = 'CO'
begin

    if @w_cpto_rte is not null and @w_capital_acum >= @w_base_rtfte
    begin

       --Calculo tasa retefuente - interfaz con contabilidad en variable @w_tasa_impuesto
       exec @w_return  = cob_interfase..sp_icon_impuestos
       @i_empresa      = @i_filial,
       @i_concepto     = @w_cpto_rte,
       @i_debcred      = 'D',
       @i_monto        = @w_capital_acum,
       @i_impuesto     = 'R', --Verificar nemonico tipo de impuesto
       @i_oforig_admin = @o_ofi_cta,
       @i_ofdest_admin = @o_ofi_cta,
       @i_ente         = @o_cliente,
       @i_producto     = 4,
       @o_exento       = @w_exento  out,
       @o_porcentaje   = @w_porcentaje out

       if @w_return <> 0
       begin
          exec cobis..sp_cerror
                @t_debug      = @t_debug,
                @t_file       = @t_file,
                @t_from       = @w_sp_name,
                @i_num        = 121032
             return 121032
       end

       if @w_exento = 'N'
           select @w_tasa_ret = (@w_porcentaje/100)
       else
          select @w_tasa_ret = 0


       /* Calculo para hallar valor de retencion sobre intereses */
       select @w_retfte_tot = round(@w_capital_acum * @w_tasa_ret, isnull(@w_numdeciimp,0))

   end
end


select @w_ajuste_interes = round(@w_interes_acum,@w_ndci)
select @w_capital_acum = round(@w_capital_acum,@w_ndci)

if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug @t_file=@t_file
    select  '/**  Stored Procedure  **/ ' = @w_sp_name,
        w_interes_acum  = @w_interes_acum,
        w_capital_acum  = @w_capital_acum,
        w_ajuste_interes = @w_ajuste_interes,
        w_alicuota  = @w_alic
    exec cobis..sp_end_debug
end

select @w_tot_alic = (@i_val + (isnull(@o_val_nx1000,$0)) + (isnull(@o_valiva,0)))   * @w_alic

select @w_disponible = @w_disponible - ((@i_val + (isnull(@o_val_nx1000,$0)) + (isnull(@o_valiva,0))) * @i_factor),--JAR FO-022
       @w_prom_disp  = @w_prom_disp  - (@w_tot_alic * @i_factor),
       @w_promedio1  = @w_promedio1  - (@w_tot_alic * @i_factor),
       @w_debitos    = @w_debitos    + ((@i_val + (isnull(@o_val_nx1000,$0)) + (isnull(@o_valiva,0))) * @i_factor) ,  --JAR FO-022
       @w_debhoy     = @w_debhoy     + ((@i_val + (isnull(@o_val_nx1000,$0)) + (isnull(@o_valiva,0))) * @i_factor)   --JAR FO-022

     --  @w_debitos    = @w_debitos    + ((@i_val + @w_acumu_deb + (isnull(@o_val_nx1000,$0)) + (isnull(@o_valiva,0))) * @i_factor) ,  --JAR FO-022
     --  @w_debhoy     = @w_debhoy     + ((@i_val + @w_acumu_deb + (isnull(@o_val_nx1000,$0)) + (isnull(@o_valiva,0))) * @i_factor)   --JAR FO-022

if @w_disponible < @w_sldmin
    select @w_sldmin = @w_disponible

begin tran

update cob_ahorros..ah_cuenta
set ah_disponible      = @w_disponible,
    ah_promedio1       = @w_promedio1,
    ah_prom_disponible = @w_prom_disp,
    ah_debitos         = @w_debitos,
    ah_debitos_hoy     = @w_debhoy,
    ah_fecha_ult_mov   = @i_fecha,
    ah_contador_trx    = ah_contador_trx + @i_factor,
    /*FRC-AHO-017-CobroComisiones CMU 2102110*/
    ah_num_deb_mes     = @w_ndebmes
where @i_cuenta = ah_cuenta

if @@rowcount <> 1
begin
      exec cobis..sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 255001
      return 255001
end

select @o_sldcont = @w_contable - @i_val * @i_factor,
       @o_slddisp = @w_disponible,
       @o_aj_int  = @w_ajuste_interes,
       @o_aj_cap  = @w_capital_acum,
       @o_aj_ret  = @w_retfte_tot,
       @o_fecha   = convert(char(10), @i_fecha, 101) + ' '
                    + convert(char(8), getdate(), 8),
       @o_categoria  = @w_categoria

if @w_capital_acum <> 0
begin

     if @w_capital_acum > $0
     begin

          if @i_factor = 1
          begin
               exec @w_return = cob_ahorros..sp_ahndc_automatica
                    @s_srv          = @s_srv,
                    @s_ofi          = @s_ofi,
                    @s_ssn          = @s_ssn,
                    @s_user         = @s_user,
                    @s_ssn_branch   = @s_ssn_branch,
                    @t_trn          = 264,
                    @i_cta          = @w_cta,
                    @i_val          = @w_capital_acum,
                    @i_cau          = '91', -- recalculo de intereses
                    @i_mon          = @i_mon,
                    @i_fecha        = @i_fecha,
                    @i_alt          = 10,
                    @i_canal        = 4

               if @w_return <> 0
                  return @w_return

               if @w_retfte_tot > 0
               begin

                    exec @w_return = cob_ahorros..sp_ahndc_automatica
                         @s_srv          = @s_srv,
                         @s_ofi          = @s_ofi,
                         @s_ssn          = @s_ssn,
                         @s_user         = @s_user,
                         @s_ssn_branch   = @s_ssn_branch,
                         @t_trn          = 253,
                         @i_cta          = @w_cta,
                         @i_val          = @w_retfte_tot,
                         @i_cau          = '108', -- DEVOLUCION RETEFUENTE
                         @i_mon          = @i_mon,
                         @i_fecha        = @i_fecha,
                         @i_alt          = 11,
                         @i_canal        = 4

                    if @w_return <> 0
                       return @w_return
               end
          end
          else
          begin
               exec @w_return = cob_ahorros..sp_ahndc_automatica
                    @s_srv          = @s_srv,
                    @s_ofi          = @s_ofi,
                    @s_ssn          = @s_ssn,
                    @s_user         = @s_user,
                    @s_ssn_branch   = @s_ssn_branch,
                    @t_corr         = @t_corr,
                    @t_ssn_corr     = @t_ssn_corr,
                    @t_trn          = 264,
                    @i_cta          = @w_cta,
                    @i_val          = @w_capital_acum,
                    @i_cau          = '91', --*************
                    @i_mon          = @i_mon,
                    @i_alt          = 10,
                    @i_fecha        = @i_fecha,
                    @i_canal        = 4

               if @w_return <> 0
                   return @w_return

           if @w_retfte_tot > 0
           begin
                    exec @w_return = cob_ahorros..sp_ahndc_automatica
                         @s_srv          = @s_srv,
                         @s_ofi          = @s_ofi,
                         @s_ssn          = @s_ssn,
                         @s_user         = @s_user,
                         @s_ssn_branch   = @s_ssn_branch,
                         @t_corr         = @t_corr,
                         @t_ssn_corr     = @t_ssn_corr,
                         @t_trn          = 253,
                         @i_cta          = @w_cta,
                         @i_val          = @w_retfte_tot,
                         @i_cau          = '108', --ND POR RETEFUENTE
                         @i_mon          = @i_mon,
                         @i_fecha        = @i_fecha,
                         @i_alt          = 11,
                         @i_canal        = 4

                    if @w_return <> 0
                       return @w_return
           end
          end
     end
     else
     if @w_capital_acum < $0
     begin
          select @w_capital_acum = @w_capital_acum * -1
          if @i_factor = 1
          begin
               exec @w_return = cob_ahorros..sp_ahndc_automatica
                    @s_srv          = @s_srv,
                    @s_ofi          = @s_ofi,
                    @s_ssn          = @s_ssn,
                    @s_user         = @s_user,
                    @t_trn          = 253,
                    @i_cta          = @w_cta,
                    @i_val          = @w_capital_acum,
                    @i_cau          = '19',
                    @i_mon          = @i_mon,
                    @i_alt          = 10,
                    @i_fecha        = @i_fecha,
                    @i_canal        =  4

               if @w_return <> 0
                   return @w_return

           if @w_retfte_tot > 0
           begin
                    exec @w_return = cob_ahorros..sp_ahndc_automatica
                         @s_srv          = @s_srv,
                         @s_ofi          = @s_ofi,
                         @s_ssn          = @s_ssn,
                         @s_user         = @s_user,
                         @t_trn          = 264,
                         @i_cta          = @w_cta,
                         @i_val          = @w_retfte_tot,
                         @i_cau          = '33',
                         @i_mon          = @i_mon,
                         @i_fecha        = @i_fecha,
                         @i_alt          = 11,
                         @i_canal        = 4

                    if @w_return <> 0
                       return @w_return
               end
          end
          else
          begin
               exec @w_return = cob_ahorros..sp_ahndc_automatica
                    @s_srv          = @s_srv,
                    @s_ofi          = @s_ofi,
                    @s_ssn          = @s_ssn,
                    @s_user         = @s_user,
                    @t_trn          = 264,
                    @i_cta          = @w_cta,
                    @i_val          = @w_capital_acum,
                    @i_ind          = 1,
                    @i_cau          = '29',
                    @i_mon          = @i_mon,
                    @i_alt          = 10,
                    @i_fecha        = @i_fecha,
                    @i_canal        = 4

               if @w_return <> 0
                  return @w_return

           if @w_retfte_tot > 0
           begin
                    exec @w_return = cob_ahorros..sp_ahndc_automatica
                         @s_srv          = @s_srv,
                         @s_ofi          = @s_ofi,
                         @s_ssn          = @s_ssn,
                         @s_user         = @s_user,
                         @t_trn          = 253,
                         @i_cta          = @w_cta,
                         @i_val          = @w_retfte_tot,
                         @i_cau          = '144',
                         @i_mon          = @i_mon,
                         @i_fecha        = @i_fecha,
                         @i_alt          = 11,
                        @i_canal        = 4

                    if @w_return <> 0
                       return @w_return
           end
          end
     end

end




/* POR RETIRO */
 if @o_val_nx1000 > 0
 begin

     if  @i_factor <> 1
       select @w_gmf_reintegro = isnull(round( isnull(@o_val_nx1000,0) * (@w_tasa_reintegro /100),@w_numdeciimp),0)


     if @w_gmf_reintegro > 0
     begin

      execute  @w_return =  sp_reintegro_gmf
               @s_srv               = @s_srv,
               @s_ofi               = @s_ofi,
               @s_ssn               = @s_ssn,
               @s_ssn_branch        = @s_ssn_branch ,
               @s_user              = @s_user,
               @s_term              = @s_term,
               @s_date              = @i_fecha,
               @t_corr              = @t_corr,
               @t_ssn_corr          = @t_ssn_corr,
               @i_cuenta            = @i_cuenta,
               @i_valor             = @w_gmf_reintegro,
               @i_mon               = @i_mon,
               @i_alterno           = 40,
               @i_factor            = @i_factor,
               @i_cliente           = @w_cliente,
               @i_base_gmf          = @o_base_gmf

          if @w_return <> 0
          begin
                exec cobis..sp_cerror
                     @t_debug = @t_debug,
                     @t_file  = @t_file,
                     @t_from  = @w_sp_name,
                     @i_num   =   252093
               return  252093
          end
      end
  end



-- Actualizacion de Impuesto GMF causado
if @w_codigo_pais = 'CO' -- Colombia
begin
   -- Actualiza acumulados topes gmf
   if @w_actualiza = 'S'
   begin
      exec @w_return = sp_calcula_gmf
           @s_date         = @i_fecha,
           @i_cuenta       = @i_cuenta,
           @i_producto     = @w_producto,
           @i_operacion    = 'U',
           @i_acum_deb     = @w_acumu_deb

      if @w_return <> 0
         return @w_return
   end
end

if @t_ejec = 'R'
begin
   exec @w_return = cob_ahorros..sp_resultados_branch_ah
   @s_ssn_host     = @s_ssn,
   @i_cuenta       = @i_cuenta,
   @i_fecha        = @i_fecha,
   @i_ofi          = @s_ofi,
   @i_tipo_cuenta  = 'O',
   @i_cedula       = @o_cedula,
   @i_iva          = @o_valiva,
   @i_gmf          = @o_val_nx1000,
   @i_comision     = @w_cobro_comision

   if @w_return <> 0
      return @w_return
end

   select
   @o_clase_clte   = @w_clase_clte,
   @o_prod_banc = @w_prod_banc,
   @o_cliente   = @w_cliente,
   @o_ofi_cta   = @o_ofi_cta,
   @o_cedula    = @o_cedula


commit tran
return 0

go

