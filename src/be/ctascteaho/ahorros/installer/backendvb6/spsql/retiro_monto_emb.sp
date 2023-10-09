/***************************************************************************/
/*  Archivo:            retiro_monto_emb.sp                                */
/*  Stored procedure:   sp_retiro_monto_emb                                */
/*  Base de datos:      cob_ahorros                                        */
/*  Producto:           Cuentas de Ahorros                                 */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                        */
/*  Fecha de escritura: 05-Mar-1993                                        */
/***************************************************************************/
/*              IMPORTANTE                                                 */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad           */
/*  de COBISCorp.                                                          */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como       */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus       */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.      */
/*  Este programa esta protegido por la ley de   derechos de autor         */
/*  y por las    convenciones  internacionales   de  propiedad inte-       */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para    */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir           */
/*  penalmente a los autores de cualquier   infraccion.                    */
/***************************************************************************/
/*              PROPOSITO                                                  */
/*  Este programa procesa las transacciones de retiros y notas             */
/*  de debito SIN LIBRETA                                                  */
/***************************************************************************/
/*                MODIFICACIONES                                           */
/*      FECHA       AUTOR             RAZON                                */
/*  05/Mar/1993   X Gellibert Coello  Emision Inicial                      */
/*  11/feb/2013   D.Pulido            REQ330-Validacion identidad cliente  */
/*  08/Abr/2013   J.Colorado H        Alianza cormecial                    */
/*  02/Mayo/2016  Juan Tagle          Migración a CEN                      */
/***************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_retiro_monto_emb')
    drop proc sp_retiro_monto_emb
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_retiro_monto_emb (
    @t_debug              char(1)     = 'N',
    @t_file               varchar(14) = null,
    @t_from               varchar(30) = null,
    @t_trn                int,
    @t_rty                char(1),
    @t_corr               char(1),
    @t_ejec               char(1)     = 'N',/*Cambios BRANCHII */
    @t_show_version       bit = 0,
    @s_ofi                smallint,
    @s_ssn_branch         int         = null,  /*Cambios BRANCHII */
    @s_org                char(1),
    @s_sev                tinyint     = null,
    @s_user               varchar(30),
    @s_lsrv               varchar(30),
    @s_srv                varchar(30),
    @s_term               varchar(10),
    @s_ssn                int,
    @s_date               datetime,
    @t_ssn_corr           int,
    @p_rssn_corr          int,
    @p_lssn               int,
    @i_cta                cuenta,
    @i_cuenta             int,
    @i_mon                tinyint,
    @i_val                money,
    @i_ind                tinyint,
    @i_cau                char(3),
    @i_factor             smallint,
    @i_fecha              smalldatetime,
    @i_chqrem             int         = null,
    @i_ncontrol           int,
    @i_lpend              int,
    @i_dif                char(1)     = 'N',
    @i_monto_imp          money,
    @i_sld_caja           money       = 0,
    @i_idcierre           int         = 0,
    @i_filial             smallint    = 1,
    @i_idcaja             int         = 0,
--CCR BRANCH III
    @i_fecha_valor_a      datetime    = null,
    @o_sus_flag           tinyint     out,
    @o_val_mon            money       out,
    @o_val_ser            money       out,
    @o_sldcont            money       out,
    @o_slddisp            money       out,
    @o_nombre             varchar(60) out,
    @o_cedula             varchar(20) out,
    @o_cliente            int         = 0 out,
    @o_prod_banc          smallint    = null out,
    @o_categoria          char(1)     = null out,
    @o_monto_imp          money       out,
    @o_tipo_exonerado_imp char(2)     out,
    @o_tipocta_super      char(1)     = null out,
    @o_val_2x1000         money       = null out,
    @o_base_gmf           money       = null out,
    @o_concep_exc         smallint    = 0    out,
    @o_valiva             money       = 0 out,
    @o_comision           money       = 0 out,
    @o_alerta_cli         varchar(40) = null out,
    @o_impuesto           money       = null out,
    @o_clase_clte         char(1)     = null out,
    @o_idorden            int         = null out
)
as
declare @w_return       int,
    @w_sp_name          varchar(30),
    @w_alic_prom        float,
    @w_numdeci          tinyint,
    @w_numdeci_imp      tinyint,
    @w_disponible       money,
    @w_promedio1        money,
    @w_promedio2        money,
    @w_promedio3        money,
    @w_promedio4        money,
    @w_promedio5        money,
    @w_promedio6        money,
    @w_12h              money,
    @w_12h_dif          money,
    @w_24h              money,
    @w_48h              money,
    @w_remesas          money,
    @w_debitos          money,
    @w_suspensos        smallint,
    @w_saldo_para_girar money,
    @w_saldo_contable   money,
    @w_tipo_prom        char(1),
    @w_signo            char(1),
    @w_control          int,
    @w_val              money,
    @w_lineas           smallint,
    @w_ciudad           int,
    @w_nemo             char(4),
    @w_nemo2            char(4),
    @w_nemo3            catalogo,
    @w_mon              tinyint,
    @w_flag             tinyint,
    @w_sec              int,
    @w_mensaje          mensaje,
    @w_secuencial       int,
    @w_ssn_corr         int,
    @w_tipo_bloqueo     char(3),
    @w_usadeci          char(1),
    @w_prom_disp        money,
    @w_accion           char(1),
    @w_estado           char(1),
    @w_debhoy           money,
    @w_rem_hoy          money,
    @w_monto_bloq       money,
    @w_fecha_efe        smalldatetime,
    @w_dias_ret         smallint,
    @w_contador_trx     smallint,
    @w_cont             smallint,
    @w_num_blqmonto     smallint,
    @w_oficina          smallint,
    @w_oficial          smallint,
    @w_bloqueos         smallint,
    @w_numlib           int,
    @w_dep_ini          money,
    @w_fapert           datetime,
    @w_ced_ruc          char(1),
    @w_cta_funcionario  char(1),
    @w_creditos         money,
    @w_credhoy          money,
    @w_tasa_imp         float,
    @w_val2             money,
    @w_ssn_tmp          int,
    @w_tipocta          char(1),
    @w_producto         tinyint,
    /*LBM */
    @w_act_fecha        char(1),
    @w_fecha_ult_mov    datetime,  --LBM
    @w_hora_ejecucion   smalldatetime,
    @w_codigo_pais      catalogo,
    @w_actualiza        char(1),
    @w_ciudad_cta       int,
    @w_ciudad_loc       int,
    @w_valor_tope       money,
    @w_val_total        money,
    @w_cobro_tarifa     money,
    @w_valiva_tarifa    money,
    @w_comision         money,
    @w_com_rev          money,
    @w_valor_cobro      money,
    @w_valiva           money,
    @w_val_cob_rev      money,
    @w_valor_cobro_com  money,
    @w_acumu_deb        money,
    @w_rol_ente         char(1),
    @w_tipo_def         char(1),
    @w_tipo             char(1),
    @w_personaliza      char(1),
    @w_codigo           int,
    @w_filial           tinyint,
    @w_cobro_total      money,
    @w_realizar_deb     tinyint,
    @w_iva              float,
    @w_reg_imp2x1000    char(1),
    @w_trna             int,
    @w_alerta_cli       varchar(40),
    @w_ente             int,
    /*FRC-AHO-017-CobroComisiones CMU 2102110*/
    @w_ndebmes          int,
    @w_cobro_comision   money,
    @w_numdeb           int,
    @w_tipocobro        char(1),
    @w_numtot           int,
    @w_numero           int,
    @w_numcre           int,
    @w_numco            int,
    @w_com_iva          char(1),
    @w_rowcount         int,
    @w_concto_iva       char(4),
    @w_piva             float,
    @o_exento           char(1),
    @o_porcentaje       float,
    @w_impuesto         money,
    @w_total_val_imp    money,
    @w_gmf              money,
    @w_valor            money,
    @w_tasa_gmf         float,
    @w_monto_emb        money,
    @w_monto_disponible money,
    @w_val_ret          money,
    @w_val_2x1000       money,
    @w_posteo           char(1),
    @w_pro_final        smallint,
    @w_sucursal         smallint,
    @w_operacion        char(1),
    @w_idorden          int,
    @w_causa            varchar(5),
    @w_cliente          int,    --REQ 330
    @w_estado_id        int, --REQ 330
    @w_msg_valida       varchar(64), --REQ 330
    @w_tasa_reintegro   float,
    @w_gmf_reintegro    money

/*  Captura nombre de Stored Procedure  */
select @w_sp_name = 'sp_retiro_monto_emb'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select @w_hora_ejecucion= convert(varchar(5),getdate(),108)
select @w_rowcount  = 0
select @w_realizar_deb = 0

--print @w_sp_name

/* LBM -- Colocarle el valor default a la variable @w_act_fecha */
select @w_act_fecha = 'S'

select
@o_comision      = 0,
@o_valiva        = 0,
@o_val_2x1000    = 0,
@o_impuesto      = 0,
@w_impuesto      = 0,
@w_total_val_imp = 0,
@w_gmf           = 0,
@w_tasa_reintegro  = 0,
@w_gmf_reintegro   = 0


if @i_factor = 1
begin
   /* Busqueda de la tasa del impuesto */
   select @w_tasa_imp = pa_float
   from  cobis..cl_parametro
   where pa_producto = 'ADM'
   and   pa_nemonico = 'TIDB'

  if @@rowcount <> 1
  begin
     exec cobis..sp_cerror
     @t_debug  = @t_debug,
     @t_file   = @t_file,
     @t_from   = @t_from,
     @i_num    = 201196
     return 201196
  end
end
else
  select @w_tasa_imp = 0.0

/* Encuentra parametro de decimales */
select @w_usadeci = mo_decimales
from  cobis..cl_moneda
where mo_moneda = @i_mon

if @w_usadeci = 'S'
begin
   select @w_numdeci = pa_tinyint from cobis..cl_parametro
   where  pa_nemonico = 'DCI'
   and    pa_producto = 'AHO'

   select @w_numdeci_imp = pa_tinyint from cobis..cl_parametro
   where  pa_nemonico = 'DIM'
   and    pa_producto = 'AHO'

end
else
   select @w_numdeci = 0, @w_numdeci_imp = 0


/* Calcular el saldo */
exec @w_return = cob_ahorros..sp_ahcalcula_saldo
@t_debug            = @t_debug,
@t_file             = @t_file,
@t_from             = @w_sp_name,
@i_cuenta           = @i_cuenta,
@i_fecha            = @i_fecha,
@i_ofi              = @s_ofi,
@o_saldo_para_girar = @w_saldo_para_girar out,
@o_saldo_contable   = @w_saldo_contable   out

if @w_return <> 0
   return @w_return

/* VALIDACIONES PARA SALDO MINIMO DE INEMBARGABILIDAD  */
if @i_factor = 1
begin
   if exists(select 1
             from   cobis..cl_cuentas_embargo
             where  ce_cta_banco = @i_cta
             and    ce_estado    = 'V')
   begin
       select @w_val_ret   = ce_valor_ret,
              @w_monto_emb = ce_valor_emb
       from   cobis..cl_cuentas_embargo
       where  ce_cta_banco = @i_cta
       and    ce_estado    = 'V'

       select @w_monto_disponible = @w_monto_emb - @w_val_ret

       if @w_monto_disponible < @i_val
       begin
          print 'SU MAXIMO RETIRO ES DE : '  + cast(@w_monto_disponible as varchar)
          exec cobis..sp_cerror
          @t_debug      = @t_debug,
          @t_file       = @t_file,
          @t_from       = @w_sp_name,
          @i_num        = 251033
          return 251033
       end
   end
   else
   begin
      exec cobis..sp_cerror
      @t_debug      = @t_debug,
      @t_file       = @t_file,
      @t_from       = @w_sp_name,
      @i_num        = 252080
      return 252080
   end
end


/* Encuentra el nemonico de la transaccion */
select @w_nemo = tn_nemonico
from  cobis..cl_ttransaccion
where tn_trn_code = @t_trn

select @w_nemo2 = 'IDB'

select @w_lineas        = ah_linea,
       @w_12h           = ah_12h,
       @w_12h_dif       = ah_12h_dif,
       @w_24h           = ah_24h,
       @w_48h           = ah_48h,
       @o_nombre        = substring(ah_nombre,1,60),
       @w_remesas       = ah_remesas,
       @w_rem_hoy       = ah_rem_hoy,
       @w_tipo_prom     = ah_tipo_promedio,
       @w_mon           = ah_moneda,
       @w_disponible    = ah_disponible,
       @w_promedio1     = ah_promedio1,
       @w_promedio2     = ah_promedio2,
       @w_promedio3     = ah_promedio3,
       @w_promedio4     = ah_promedio4,
       @w_promedio5     = ah_promedio5,
       @w_promedio6     = ah_promedio6,
       @w_suspensos     = ah_suspensos,
       @w_debitos       = ah_debitos,
       @w_debhoy        = ah_debitos_hoy,
       @w_creditos      = ah_creditos,
       @w_credhoy       = ah_creditos_hoy,
       @w_prom_disp     = ah_prom_disponible,
       @w_contador_trx  = ah_contador_trx,
       @w_monto_bloq    = ah_monto_bloq,
       @w_estado        = ah_estado,
       @w_num_blqmonto  = ah_num_blqmonto,
       @w_dep_ini       = ah_dep_ini,
       @w_fapert        = ah_fecha_aper,
       @w_oficina       = ah_oficina,
       @w_oficial       = ah_oficial,
       @o_cedula        = ah_ced_ruc,
       @w_bloqueos      = ah_bloqueos,
       @w_numlib        = ah_numlib,
       @w_fecha_ult_mov = ah_fecha_ult_mov, --LBM
       @o_prod_banc     = ah_prod_banc,
       @o_categoria     = ah_categoria,
       @o_clase_clte    = ah_clase_clte,
       @w_producto      = ah_producto,
       @w_tipocta       = ah_tipocta,
       @o_tipocta_super = ah_tipocta_super,
       @w_rol_ente      = ah_rol_ente,
       @w_tipo          = ah_tipo,
       @w_tipo_def      = ah_tipo_def,
       @w_codigo        = ah_default,
       @w_personaliza   = ah_personalizada,
       @w_reg_imp2x1000 = ah_nxmil,
       @w_filial        = ah_filial,
       @w_ente          = ah_cliente,
       /*FRC-AHO-017-CobroComisiones CMU 2102110*/
       @w_ndebmes      = isnull(ah_num_deb_mes,0)
from  cob_ahorros..ah_cuenta
where ah_cuenta = @i_cuenta

select @o_cliente = @w_ente

--REQ 330 VALIDACION IDENTIFICACION CLIENTE
if exists (select 1 from cobis..cl_val_iden
           where vi_transaccion = @t_trn
           and   vi_estado      = 'V'
           and   (vi_ind_causal = 'N' or (vi_ind_causal = 'S' and vi_causal = @i_cau))) and @t_corr <> 'S'
begin


         -----------------------------------------------
         --invocar al servicio de validacion de huella
         -----------------------------------------------
         exec @w_return    = cobis..sp_consulta_homini
         @s_term           = @s_term,
         @s_ofi            = @s_ofi,
         @i_operacion      = 'V',
         @i_ref            = @i_cta,
         @i_user           = @s_user,
         @i_id_caja        = @i_idcaja,
         @i_sec_cobis      = @s_ssn,
         @i_trn            = @t_trn,
         @o_codigo         = @w_estado_id out ,
         @o_mensaje        = @w_msg_valida out

         if @w_return <> 0 or @@error <> 0
         begin
            exec cobis..sp_cerror
            @t_debug     = @t_debug,
            @t_file      = @t_file,
            @t_from      = @w_sp_name,
            @i_num       = @w_return

            return @w_return

         end

         -- VALIDACION MENSAJES RESTRICTIVOS HOMINI
         if @w_estado_id <> 0
         begin
            exec cobis..sp_cerror
            @t_debug     = @t_debug,
            @t_file      = @t_file,
            @t_from      = @w_sp_name,
            @i_num       = @w_estado_id,
            @i_msg       = @w_msg_valida

            return @w_estado_id
         end

end


if @w_tipocta = 'I'
begin
   select 1 from cob_ahorros..ah_oficina_ctas_cifradas
   where  oc_oficina = @s_ofi
   and    oc_estado  = 'V'
   if @@rowcount = 0
   begin
      -- Oficina no autorizada para cuentas cifradas
      exec cobis..sp_cerror
      @t_debug      = @t_debug,
      @t_file       = @t_file,
      @t_from       = @w_sp_name,
      @i_num        = 251081
      return 1
   end
end

select @w_alerta_cli = (select case codigo
                               when 'NIN' then ''
                               else valor
                               end
                        from   cobis..cl_catalogo
                        where  tabla in (select codigo from cobis..cl_tabla where tabla = 'cl_accion_cliente')
                        and    codigo = X.en_accion)
from   cobis..cl_ente X
where  en_ente = @w_ente

select @o_alerta_cli = @w_alerta_cli

select @w_sucursal = isnull(of_regional, of_oficina)
from   cobis..cl_oficina
where  of_oficina = @w_oficina -- (Oficina de la cuenta)

select @w_pro_final = pf_pro_final
from   cob_remesas..pe_pro_final, cob_remesas..pe_mercado
where  pf_mercado      = me_mercado
and    me_tipo_ente    = @w_tipocta
and    me_pro_bancario = @o_prod_banc
and    pf_filial       = @w_filial
and    pf_sucursal     = @w_sucursal
and    pf_producto     = @w_producto
and    pf_moneda       = @w_mon
and    pf_tipo         = @w_tipo

if @@rowcount = 0
begin
   --No existe producto final
   exec cobis..sp_cerror
   @t_debug  = @t_debug,
   @t_file   = @t_file,
   @t_from   = @w_sp_name,
   @i_num    = 351527
   return 351527
end

select @w_posteo = cp_posteo
from   cob_remesas..pe_categoria_profinal
where  cp_profinal  = @w_pro_final
and    cp_categoria = @o_categoria

if @w_posteo is null
   select @w_posteo = 'N'


if (@w_tasa_imp > 0 and @i_factor = 1)
begin
   /* Verificar que la cuenta este exonerada */
   select @o_tipo_exonerado_imp = ei_tipo_exonerado_imp
   from  cob_remesas..re_exoneracion_impuesto
   where ei_producto = 'AHO'
   and   ei_cuenta   = @i_cuenta
   if @@rowcount = 1
      select @w_tasa_imp = 0.0
end

/* CALCULO DEL MONTO DE IDB */
if @w_tasa_imp > 0 or (@i_factor = -1 and @i_monto_imp > 0)
begin
  if @i_factor = 1
     select @o_monto_imp = round((@i_val * @w_tasa_imp), @w_numdeci_imp)
  else
     select @o_monto_imp = @i_monto_imp
end
else
   select @o_monto_imp = $0


/* Alicuota de Promedio */
select @w_alic_prom = fp_alicuota
from  ah_fecha_promedio
where fp_tipo_promedio = @w_tipo_prom
and   fp_fecha_inicio  = @i_fecha
if @@rowcount = 0
begin   /** Alicuota de Promedio No Existe **/
   exec cobis..sp_cerror
   @t_debug  = @t_debug,
   @t_file   = @t_file,
   @t_from   = @w_sp_name,
   @i_num    = 251012
   return 251012
end

select @w_control = @i_ncontrol,
       @w_sec     = @i_lpend

/* Asigna variables de origen de la transaccion */
if @s_org = 'S'
   select @w_ssn_corr = @p_rssn_corr
else
   select @w_ssn_corr = @t_ssn_corr

/* Determina la existencia de la transaccion de servicio (REVERSO DE TRN) */
/* @w_flag = 1 existe en transacciones de servicio */
/* @w_flag = 0 no existe en transacciones de servicio */

select @w_flag = 1
if @s_org = 'U'  /*Inicio cambios BRANCHII BBO 03/09/1999*/
begin
   if not exists (select 1 from cob_ahorros..ah_tran_servicio
                  where ts_ssn_branch = @w_ssn_corr
                  and   ts_oficina    = @s_ofi)
   select @w_flag = 0
end
else
begin /*Fin cambios BRANCHII BBO 03/09/1999*/
   if not exists (select 1
                  from  cob_ahorros..ah_tran_servicio
                  where ts_secuencial = @w_ssn_corr)
   select @w_flag = 0
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

if @w_codigo_pais = 'CO' -- Colombia
begin
   select @w_valor = @i_val

   /*INICIO COBRO IVA*/

   select @w_com_iva = an_comision
   from  cob_remesas..re_accion_nd
   where an_producto = 4
   and   an_causa = @i_cau

   select @w_rowcount = @@rowcount

   if @w_rowcount = 0
      select @w_com_iva  = 'N'


   if @i_factor = 1
   begin
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
         @i_oforig_admin = @w_oficina,
         @i_ofdest_admin = @w_oficina,
         @i_ente         = @w_ente,
         @i_producto     = 4,
         @o_exento       = @o_exento  out,
         @o_porcentaje   = @o_porcentaje out

         if @w_return <> 0
         begin
             rollback
             return @w_return
         end

         if @o_exento = 'N'
            select @w_piva = @o_porcentaje
         else
            select @w_piva = 0

         select @w_impuesto  = round((@i_val * @w_piva / 100), @w_numdeci_imp)
         select @w_total_val_imp =  @i_val + @w_impuesto

         select @o_impuesto  =  @w_impuesto
         select @o_valiva = @o_valiva + @w_impuesto

      end
      else
      begin
      	  select @w_total_val_imp =  @i_val
      	  select @w_piva = 0,
      	         @w_impuesto  = 0
      end
   end
   else
   begin
      select @w_valor      = tm_valor,
             @w_impuesto   = isnull(tm_valor_comision,0),
             @w_val_2x1000 = isnull(tm_monto_imp,0),
             @w_idorden    = tm_cheque
      from   cob_ahorros..ah_tran_monet
      where  tm_ssn_branch = @t_ssn_corr
      and    tm_oficina    = @s_ofi
      and    tm_cod_alterno = 0

      select @w_total_val_imp = @w_valor + @w_impuesto
   end

   /*FIN COBRO IVA*/

   select @o_val_2x1000 = $0

   --  Llama sp que calcula GMF de acuerdo a concepto exencion
   exec @w_return = sp_calcula_gmf
   @s_user               = @s_user,
   @s_date               = @i_fecha,
   @s_ofi                = @s_ofi,
   @t_trn                = @t_trn,
   @t_ssn_corr           = @t_ssn_corr,
   @i_factor             = @i_factor,
   @i_mon                = @i_mon,
   @i_cta                = @i_cta,
   @i_cuenta             = @i_cuenta,
   @i_val                = @w_total_val_imp, --@i_val,
   @i_val_tran           = @w_total_val_imp, --@i_val,
   @i_numdeciimp         = @w_numdeci_imp,
   @i_producto           = @w_producto,
   @i_cliente            = @w_ente,    --JCO
   @i_operacion          = 'Q',
   @o_total_gmf          = @o_val_2x1000 out,
   @o_acumu_deb          = @w_acumu_deb  out,
   @o_actualiza          = @w_actualiza  out,
   @o_base_gmf           = @o_base_gmf   out,
   @o_tasa               = @w_tasa_gmf   out,
   @o_concepto           = @o_concep_exc out,
   @o_tasa_reintegro     = @w_tasa_reintegro out, --JCO
   @o_valor_reintegro    = @w_gmf_reintegro out   -- JCO


   if @w_return <> 0
      return @w_return

   -- Calculo valor total de impuestos
   if @i_factor = 1
   begin

      if @t_trn = 392
         select @o_monto_imp = isnull(@o_monto_imp, $0) + @o_val_2x1000
      else
         select @o_val_2x1000 = $0

      select @o_valiva    = @w_impuesto,
             @o_impuesto  = @w_impuesto

   end
   else
      select @o_val_2x1000 = @w_val_2x1000
end

select @w_ndebmes = @w_ndebmes + ( 1 * @i_factor )

begin tran
/* Validar Fondos */
if @i_factor = 1
begin
   if (@i_val + @o_monto_imp + @o_impuesto) > @w_saldo_para_girar
   begin
      if @t_trn in(392)
      begin   /* Cuenta sin fondos */
         exec cobis..sp_cerror
         @t_debug  = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 251033
         return 1
      end
  end
end

/* Inserta linea pendiente */
if @i_factor = 1
   select  @w_signo = 'D',
           @w_nemo2 = 'IDB',
           @w_nemo3 = 'GMF'
else
   select  @w_signo = 'C',
           @w_nemo2 = 'CORR',
           @w_nemo  = 'CORR',
           @w_nemo3 = 'CORR'

if @w_posteo = 'S'
begin

   select @w_lineas = @w_lineas + 1
   insert into cob_ahorros..ah_linea_pendiente
         (lp_cuenta, lp_linea, lp_nemonico, lp_valor,
          lp_fecha, lp_control, lp_signo, lp_enviada)
   values (@i_cuenta, @w_sec, @w_nemo, @i_val,
           @i_fecha, @w_control, @w_signo, 'N')
   if @@error <> 0
   begin
        exec cobis..sp_cerror
             @t_debug        = @t_debug,
             @t_file         = @t_file,
             @t_from         = @w_sp_name,
             @i_num          = 253002
        return 1
   end

   /* COBRO DE IDB */
   if @o_monto_imp - isnull(@o_val_2x1000, $0) > 0
   begin
     select @w_lineas  = @w_lineas + 1,
            @w_control = @w_control + 1

     insert into cob_ahorros..ah_linea_pendiente
         (lp_cuenta, lp_linea, lp_nemonico, lp_valor,
          lp_fecha, lp_control, lp_signo, lp_enviada)
     values
         (@i_cuenta, @w_sec + 1, @w_nemo2, @o_monto_imp - isnull(@o_val_2x1000, $0),
          @i_fecha, @w_control, @w_signo, 'N')
     if @@error <> 0
     begin
        exec cobis..sp_cerror
             @t_debug        = @t_debug,
             @t_file         = @t_file,
             @t_from         = @w_sp_name,
             @i_num          = 253002
        return 1
     end
   end


   /* COBRO DE NX1000 */
   if @o_val_2x1000 > 0
   begin
     select @w_lineas  = @w_lineas + 1,
            @w_control = @w_control + 1

     insert into cob_ahorros..ah_linea_pendiente
         (lp_cuenta, lp_linea, lp_nemonico, lp_valor,
          lp_fecha, lp_control, lp_signo, lp_enviada)
     values
         (@i_cuenta, @w_sec + 1, @w_nemo3, @o_val_2x1000,
          @i_fecha, @w_control, @w_signo, 'N')
     if @@error <> 0
     begin
        exec cobis..sp_cerror
             @t_debug        = @t_debug,
             @t_file         = @t_file,
             @t_from         = @w_sp_name,
             @i_num          = 253002
        return 1
     end
   end
end


/*  Actualizacion Cuenta de Ahorros  */
if @t_trn = 392
begin
   select @w_disponible = @w_disponible - ((@i_val + @o_monto_imp + @o_impuesto) * @i_factor)
   select @w_prom_disp  = @w_prom_disp - round(((@i_val + @o_monto_imp + @o_impuesto) * @w_alic_prom),@w_numdeci) * @i_factor
end

select @w_promedio1 = @w_promedio1 - round(((@i_val + @o_monto_imp + @o_impuesto) * @w_alic_prom),@w_numdeci) * @i_factor,
       @w_debitos   = @w_debitos + ((@i_val + @o_monto_imp + @o_impuesto) * @i_factor)


/* LBM -- verificar si se debe actualizar el campo con la causal */
select @w_fecha_ult_mov = @i_fecha


update cob_ahorros..ah_cuenta
   set ah_disponible      = @w_disponible,
       ah_12h             = @w_12h,
       ah_12h_dif         = @w_12h_dif,
       ah_24h             = @w_24h,
       ah_remesas         = @w_remesas,
       ah_rem_hoy         = @w_rem_hoy,
       ah_linea           = @w_lineas,
       ah_promedio1       = @w_promedio1,
       ah_prom_disponible = @w_prom_disp,
       ah_debitos         = @w_debitos,
       ah_debitos_hoy     = ah_debitos_hoy + ((@i_val + @o_monto_imp + @o_impuesto) * @i_factor),
       ah_suspensos       = @w_suspensos,
       ah_fecha_ult_mov   = @w_fecha_ult_mov, --@i_fecha,
       ah_contador_trx    = ah_contador_trx + @i_factor,
       ah_fecha_ult_ret   = @i_fecha,
       ah_monto_imp       = ah_monto_imp + (@o_monto_imp * @i_factor),
       ah_num_deb_mes     = @w_ndebmes
where @i_cuenta = ah_cuenta
if @@rowcount <> 1
begin
   exec cobis..sp_cerror
   @t_debug  = @t_debug,
   @t_file   = @t_file,
   @t_from   = @w_sp_name,
   @i_num    = 255001
   return 255001
end


if @w_codigo_pais = 'CO' -- Colombia
begin
   -- Actualiza acumulados topes gmf
   if @w_actualiza = 'S'
   begin
      exec @w_return = sp_calcula_gmf
      @s_date        = @i_fecha,
      @i_cuenta      = @i_cuenta,
      @i_producto    = @w_producto,
      @i_operacion   = 'U',
      @i_acum_deb    = @w_acumu_deb

      if @w_return <> 0
         return @w_return
   end
end


 -- JCO devolucion de gmf
 if  @o_val_2x1000 > 0
 begin

      if  @i_factor <> 1
        select @w_gmf_reintegro = isnull(round( isnull(@o_val_2x1000,0) * (@w_tasa_reintegro /100),@w_numdeci_imp),0)

      if  @w_gmf_reintegro > 0
      begin

             execute  @w_return =  sp_reintegro_gmf
                   @s_srv               = @s_srv,
                   @s_ofi               = @s_ofi,
                   @s_ssn               = @s_ssn,
                   @s_ssn_branch        = @s_ssn_branch ,
                   @s_date              = @i_fecha,
                   @s_user              = @s_user,
                   @s_term              = @s_term,
                   @t_corr              = @t_corr,
                   @t_ssn_corr          = @t_ssn_corr,
                   @i_cuenta            = @i_cuenta,
                   @i_valor             = @w_gmf_reintegro,
                   @i_mon               = @i_mon,
                   @i_alterno           = 40,
                   @i_factor            = @i_factor,
                   @i_cliente           = @w_ente,
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


/* Invoca interfaz otros modulos y marca estado orden */
if @i_factor = 1
   select @w_operacion = 'I'
else
   select @w_operacion = 'A'

select @w_causa = '015'

exec @w_return    = cob_remesas..sp_genera_orden
@s_date      = @s_date,             --> Fecha de proceso
@s_user      = @s_user,             --> Usuario
@i_ofi       = @s_ofi,              --> Oficina de la transaccion
@i_operacion = 'I',                 --> Operacion ('I' -> Insercion, 'A' Anulaci¾n)
@i_causa     = @w_causa,            -- @i_causa, --> Causal de Ingreso(cc_causa_oioe)
@i_ente      = @w_ente,             --> Cod ente,
@i_valor     = @i_val,              --> Valor,
@i_tipo      = 'P',                 --> 'C' -> Orden de Cobro/Ingreso, 'P' -> Orden de Pago/Egreso
@i_idorden   = @w_idorden,          --> C¾d Orden cuando operaci¾n 'A',
@i_ref1      = @i_cuenta,           --> Ref. N·merica no oblicatoria
@i_ref2      = 0 ,                  --> Ref. N·merica no oblicatoria
@i_ref3      = @i_cta,              --> Ref. AlfaN·merica no oblicatoria
@i_interfaz  = 'S',                 --> 'N' - Invoca sp_cerror, 'S' - Solo devuelve c¾d error
@o_idorden   = @o_idorden out       --> Devuelve c¾d orden de pago/cobro generada - Operaci¾n 'I'

if @w_return <> 0 or @@error <> 0
begin
   if @w_return < 32500
      select @w_return = 255001
   exec cobis..sp_cerror
   @t_debug  = @t_debug,
   @t_file   = @t_file,
   @t_from   = @w_sp_name,
   @i_num    = @w_return

   if @@trancount > 0
      rollback
   return @w_return
end


commit tran

select @o_sldcont = @w_saldo_contable - ((@i_val+@o_monto_imp+@o_impuesto) * @i_factor)
select @o_slddisp = @w_disponible
select @o_val_mon = @i_val
select @o_sus_flag = 0

/* ACTUALIZA VALOR DE RETIRO EN CONSOLIDADO DE EMBARGOS*/
update cobis..cl_cuentas_embargo
set    ce_valor_ret = ce_valor_ret + @i_val * @i_factor
where  ce_cta_banco = @i_cta
and    ce_estado    = 'V'

if @@error <> 0
begin
   -- Error en la eliminacion
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 208052

   return 208052
end


/* Cambios por el nuevo Branch 22/01/1999 Req.Func 00 item 01 */
/*Inicio cambios BRANCHII BBO 03/09/1999*/
if @t_ejec = 'R'
begin

   exec @w_return = cob_ahorros..sp_resultados_branch_ah
        @s_ssn_host      =     @s_ssn,
        @i_cuenta        =     @i_cuenta,
        @i_fecha         =     @s_date,
        @i_ofi           =     @s_ofi,
        @i_tipo_cuenta   =     'O',
        @i_cedula        =     @o_cedula,
        @i_comision      =     @o_comision,
        @i_iva           =     @o_valiva,
        @i_gmf           =     @o_monto_imp
   if @w_return  <> 0
      return  @w_return
end
/*Fin cambios BRANCHII BBO 03/09/1999*/

return 0

go

