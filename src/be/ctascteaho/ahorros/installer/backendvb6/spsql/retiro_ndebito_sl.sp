/***************************************************************************/
/*  Archivo:            retiro_ndebito_sl.sp                               */
/*  Stored procedure:   sp_retiro_ndebito_sl                               */
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
/*      FECHA           AUTOR                 RAZON                        */
/*      05/Mar/1993     X Gellibert Coello    Emision Inicial              */
/*      23/Nov/1993     J Navarrete V.        Modificaciones Generales     */
/*      19/Ene/1996     D Villafuerte         Control de Calidad (param)   */
/*      10/Ago/1998     V.Molina E.           Requerimiento del Caribe     */
/*      30/Ago/2000     Juan F. Cadena        Correccion de error          */
/*      04/Oct/2000     X Gellibert           Optimizacion                 */
/*      2002/11/22      Carlos Cruz D.        Branch III                   */
/*      18/Mar/2005     L. Bernuil            Validacion de fecha de       */
/*                                            ultimo Movimiento.           */
/*      21/ene/2010     CMunoz     FRC-AHO-017-CobroComisiones CMU 2102110 */
/*      17/Feb/2010     J. Loyo        Manejo de la fecha de efectivizacion*/
/*                                     teniendo el sabado como habil       */
/*      13/Feb/2013     Nini Salazar   Verificar si la  transacción de     */
/*                                     retiro requiere validación identidad*/
/*                                     del cliente                         */
/*      08/Abr/2013     J. Colorado    Alianza Cormecial GMF               */
/*      02/Mayo/2016    Juan Tagle     Migración a CEN                     */
/***************************************************************************/
use cob_ahorros
go

if   exists (select 1 from sysobjects where name = 'sp_retiro_ndebito_sl')
     drop proc sp_retiro_ndebito_sl
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_retiro_ndebito_sl (
    @t_debug              char(1)     = 'N',
    @t_file               varchar(14) = null,
    @t_from               varchar(30) = null,
    @t_trn                int,
    @t_rty                char(1),
    @t_corr               char(1),
    @t_ejec               char(1)     = 'N',/*Cambios BRANCHII */
    @t_show_version       bit  = 0,
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
    @i_ofiord             smallint    = null,
-- REQ 249 RETIRO EN CHEQUE
    @i_tipo_id_benef      varchar(10) = null,
    @i_num_id_benef       varchar(50) = null,
    @i_nom_benef          varchar(100)= null,
    @i_sec_cheque         int         = null,
    @i_comision           money        = 0,              --REQ 203
    @i_causal             char(3)      = '',             --REQ 203


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
    @o_clase_clte         char(1)     = null out,
    @o_val_2x1000         money       = null out,
    @o_base_gmf           money       = null out,
    @o_concep_exc         smallint    = 0    out,
    @o_valiva             money       = 0 out,
    @o_comision           money       = 0 out,
    @o_alerta_cli         varchar(40) = null out,
    @o_impuesto           money       = null out,
    @o_sec_cheque         int         = null out

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
    @w_valor_cobro      money,
    @w_valiva           money,
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
    @w_alerta_cli       varchar(40),
    @w_ente             int,
    /*FRC-AHO-017-CobroComisiones CMU 2102110*/
    @w_ndebmes          int,
    @w_numdeb           int,
    @w_tipocobro        char(1),
    @w_numtotcta        int,
    @w_numtot           int,
    @w_numero           int,
    @w_numcre           int,
    @w_numco            int,
    @w_ofiord           smallint,
    @w_com_iva          char(1),
    @w_rowcount         int,
    @w_concto_iva       char(4),
    @w_piva             float,
    @o_exento           char(1),
    @o_porcentaje       float,
    @w_impuesto         money,
    @w_baseimp          money,
    @w_valimp           money,
    @w_total_val_imp    money,
    @w_gmf              money,
    @w_valor            money,
    @w_tasa_gmf         float,
    @w_val_2x1000       money,
    @w_posteo           char(1),
    @w_pro_final        smallint,
    @w_sucursal         smallint,
    @w_cobro_comision_chq   money,
    -- REQ 249 CHEQUE GERENCIA
    @w_numero_lote      int ,
    @w_referencia       varchar(20),
    @w_campo1           varchar(100),
    @w_campo3           varchar(100),
    @w_campo8           varchar(100),
    @w_observaciones    varchar(100),
    @w_idlote           int,
    --@w_secuencial_cheque    int,
    @w_c_tipo_compania      varchar(2),
    @w_grupo1               varchar(100),
    @w_sec_lote             int   ,
    @w_numrg                int,
    @w_cpto_emision         varchar(64),
    @w_par380               varchar(3),
    @w_comision_trn         money,
    @w_oper_cont            char(1),
    @w_alt                  int,
    @w_trn                  int,
    @w_modulo               char(3), --REQ 217
    @w_autoriza             char(1),
    @w_cta_banco            cuenta,
    @w_estado_id            int    ,   --REQ330
    @w_msg_valida           varchar(64), --REQ330
    @w_tasa_reintegro       float,
    @w_gmf_reintegro        money,
    @w_cobro_td             money, --Valor comision Tarjeta Debito
    @w_corresponsal         varchar(1),  --Req. 381 CB Red Posicionada
    @w_prod_banc_cb         smallint, --REQ 381
    @w_servicio             char(4)

/*  Captura nombre de Stored Procedure  */
select @w_sp_name = 'sp_retiro_ndebito_sl'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end


--declare @FechaIni datetime
--declare @FechaFin datetime
select @w_hora_ejecucion= convert(varchar(5),getdate(),108)
select @w_rowcount  = 0

--print @w_sp_name


/* LBM -- Colocarle el valor default a la variable @w_act_fecha */
select @w_act_fecha = 'S'

select
@o_comision   = 0,
@o_valiva     = 0,
@o_val_2x1000 = 0,
@o_impuesto   = 0,
@w_impuesto   = 0,
@w_total_val_imp = 0,
@w_gmf           = 0,
@w_cobro_comision_chq = 0,
@w_tasa_gmf = 0,
@w_piva = 0

--Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
select @w_prod_banc_cb = rtrim(cl_catalogo.codigo)
from cobis..cl_catalogo, cobis..cl_tabla
where cl_catalogo.tabla  = cl_tabla.codigo and
      cl_tabla.tabla     = 're_pro_banc_cb'
and   cl_catalogo.estado = 'V'

if @i_ofiord is not null
   select @w_ofiord = @i_ofiord
else
   select @w_ofiord = @s_ofi


if @i_factor = 1
begin
  /* Busqueda de la tasa del impuesto */
  select @w_tasa_imp = pa_float
    from cobis..cl_parametro
   where pa_producto = 'ADM'
     and pa_nemonico = 'TIDB'

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
from cobis..cl_moneda
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


/*  Determinacion de bloqueo de cuenta  */
select @w_tipo_bloqueo = cb_tipo_bloqueo
  from cob_ahorros..ah_ctabloqueada
 where cb_cuenta = @i_cuenta
   and cb_estado = 'V'
   and cb_tipo_bloqueo in ('2', '3')
if   @@rowcount <> 0
begin
   select @w_mensaje = rtrim(valor) from cobis..cl_catalogo
    where cobis..cl_catalogo.tabla =
         (select cobis..cl_tabla.codigo from cobis..cl_tabla
           where tabla = 'ah_tbloqueo')
    and cobis..cl_catalogo.codigo = @w_tipo_bloqueo
    select @w_mensaje = 'Cuenta bloqueada: ' + @w_mensaje
    exec cobis..sp_cerror
          @t_debug  = @t_debug,
          @t_file   = @t_file,
          @t_from   = @t_from,
          @i_num    = 251025,
          @i_sev    = 1,
          @i_msg    = @w_mensaje
    return 1
end

/* Encuentra el nemonico de la transaccion */
select @w_nemo = tn_nemonico
  from cobis..cl_ttransaccion
 where tn_trn_code = @t_trn

select @w_nemo2 = 'IDB'


/*LBM -- Verificamos la tabla re_propiedad_ndc para establecer si se afecta la fecha de ultimo movimiento */
if @t_trn = 264 and @i_factor = 1
begin
    select @w_act_fecha = pr_act_fecha
      from cob_remesas..re_propiedad_ndc
     where pr_producto = 4
       and pr_signo    = 'D'
       and pr_causa    = @i_cau

    if @@rowcount = 0
      select @w_act_fecha = 'S'
end

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
       @w_producto      = ah_producto,
       @w_tipocta       = ah_tipocta,
       @o_tipocta_super = ah_tipocta_super,
       @o_clase_clte    = ah_clase_clte,
       @w_rol_ente      = ah_rol_ente,
       @w_tipo          = ah_tipo,
       @w_tipo_def      = ah_tipo_def,
       @w_codigo        = ah_default,
       @w_personaliza   = ah_personalizada,
       @w_reg_imp2x1000 = ah_nxmil,
       @w_filial        = ah_filial,
       @w_ente          = ah_cliente,
       /*FRC-AHO-017-CobroComisiones CMU 2102110*/
       @w_ndebmes      = isnull(ah_num_deb_mes,0), --REQ 217
       @w_cta_banco  = ah_cta_banco,
       @w_estado     = ah_estado  --REQ 306
  from cob_ahorros..ah_cuenta
 where ah_cuenta = @i_cuenta

select @o_cliente = @w_ente

select @w_prod_banc_cb = isnull(pa_smallint,0)
from cobis..cl_parametro
where pa_nemonico = 'PBCB'
and   pa_producto = 'AHO'

if @w_prod_banc_cb = @o_prod_banc and @t_trn <> 264
begin
  exec cobis..sp_cerror
  @t_from = @w_sp_name,
  @i_num  = 251007,
  @i_sev  = 0,
  @i_msg  = 'TRANSACCION NO PERMITIDA PARA CUENTA CB'

  return 251007
end


if @w_prod_banc_cb = @o_prod_banc
   select @w_corresponsal = 'S'
else
   select @w_corresponsal = 'N'


/* Calcular el saldo */
exec @w_return = cob_ahorros..sp_ahcalcula_saldo
            @t_debug            = @t_debug,
            @t_file             = @t_file,
            @t_from             = @w_sp_name,
            @i_cuenta           = @i_cuenta,
            @i_fecha            = @i_fecha,
            @i_ofi              = @s_ofi,
            @i_corresponsal     = @w_corresponsal,
            @o_saldo_para_girar = @w_saldo_para_girar out,
            @o_saldo_contable   = @w_saldo_contable out
if @w_return <> 0
        return @w_return

/*****REQ330 VALIDAR SI LA TRANSACCION DE RETIRO NOTA DEBITO ESTA INCLUIDA EN LA TABLA COBIS*****/
if exists(select 1
          from   cobis..cl_val_iden
          where  vi_transaccion = @t_trn
          and    vi_estado      = 'V'
          and    (vi_ind_causal = 'N' or (vi_ind_causal = 'S' and vi_causal = @i_cau))) and @t_corr <> 'S'
begin

--set @FechaIni = getdate()

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
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = @w_return

            return @w_return
  end

         -- VALIDACION MENSAJES RESTRICTIVOS HOMINI
         if @w_estado_id <> 0
         begin

            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_msg   = @w_msg_valida,
            @i_num   = @w_estado_id

            return @w_estado_id
         end

--set @FechaFin = getdate()
--insert into SQLAdmin.dbo.log_sp_consulta_homini (FechaIni, FechaFin, s_ssn) values (@FechaIni, @FechaFin, @s_ssn)
end
/***********************************************************************************************/


/* ADI: REQ 217 AHORRO CONTRACTUAL */

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

/* ADI: REQ 217 AHORRO CONTRACTUAL */
if @w_producto = 4
   select @w_modulo = 'AHO'
else
   select @w_modulo = 'CTE'

select @w_sucursal = isnull(of_sucursal, of_regional)
from cobis..cl_oficina
where of_oficina = @s_ofi

select distinct @w_pro_final = pf_pro_final
from   cob_remesas..pe_pro_final, cob_remesas..pe_mercado,
       cob_remesas..pe_pro_bancario
where pf_filial       = @w_filial
and   pf_sucursal     = @w_sucursal
and   pf_producto     = @w_producto
and   pf_moneda       = @w_mon
and   me_tipo_ente    = @w_tipocta
and   pf_tipo         = @w_tipo
and   me_mercado      = pf_mercado
and   me_pro_bancario = pb_pro_bancario
and   me_pro_bancario = @o_prod_banc

exec cob_remesas..sp_autoriza_trn_caja
  @t_trn          = 730,
  @i_operacion    = 'V',
  @i_modulo       = @w_modulo,
  @i_sucursal     = @w_sucursal,
  @i_producto     = @w_pro_final,
  @i_categoria    = @o_categoria,
  @i_tran         = @t_trn,
  @o_autorizada   = @w_autoriza out




if @w_autoriza = 'N'
begin
   exec cobis..sp_cerror  -- Transaccion no autorizada para esta cuenta
       @t_from = @w_sp_name,
       @i_num  = 351575,
       @i_sev  = 0
  return 1
end
/* ADI: FIN - REQ 217 AHORRO CONTRACTUAL */

/* Valida que la cuenta no este embargada */
if exists(select 1
          from   cobis..cl_cuentas_embargo
          where  ce_cta_banco = @i_cta
          and    ce_estado    = 'V')
begin

   exec cobis..sp_cerror
   @t_debug      = @t_debug,
   @t_file       = @t_file,
   @t_from       = @w_sp_name,
   @i_num        = 252081
   return 1
end

if @w_tipocta = 'I'
begin
  select 1 from cob_ahorros..ah_oficina_ctas_cifradas
  where oc_oficina = @s_ofi
  and  oc_estado = 'V'
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
   return 1
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
    from cob_remesas..re_exoneracion_impuesto
   where ei_producto = 'AHO'
     and ei_cuenta = @i_cuenta
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
  from ah_fecha_promedio
 where fp_tipo_promedio = @w_tipo_prom
   and fp_fecha_inicio = @i_fecha
if @@rowcount = 0
begin   /** Alicuota de Promedio No Existe **/
   exec cobis..sp_cerror
       @t_debug  = @t_debug,
       @t_file   = @t_file,
       @t_from   = @w_sp_name,
       @i_num    = 251012
   return 1
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
                     and ts_oficina    = @s_ofi)
   select @w_flag = 0
end
else
begin /*Fin cambios BRANCHII BBO 03/09/1999*/
   if not exists (select 1
                    from cob_ahorros..ah_tran_servicio
                   where ts_secuencial = @w_ssn_corr)
   select @w_flag = 0
end

/* CALCULO IMPUESTO NX1000 */
select @w_codigo_pais = pa_char
  from cobis..cl_parametro
 where pa_nemonico = 'ABPAIS'
   and pa_producto = 'ADM'

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

if @i_factor = -1 and @t_trn in (264,228) and @w_flag = 1 and @i_ind = 1
begin

   select @w_ssn_tmp = ts_secuencial
   from   cob_ahorros..ah_tran_servicio
   where  ts_oficina    = @s_ofi
   and    ts_ssn_branch = @w_ssn_corr

    select @w_val = vs_valor
    from   cob_ahorros..ah_val_suspenso
    where  vs_fecha = @i_fecha
    and    vs_ssn   = @w_ssn_tmp

    if @w_val = @i_val
    begin
         select @o_sus_flag = 2
         select @o_val_ser = @w_val
         select @o_val_mon = @i_val
    end
    else
    begin
         select @o_sus_flag = 1
         select @o_val_ser = @w_val
         select @o_val_mon = @i_val - @w_val
    end
end


if @w_codigo_pais = 'CO' -- Colombia
begin

   if @i_factor = 1 and @t_trn in (264,228) and @i_ind = 1
   begin
      -- Valor a poner en suspenso
      if @w_saldo_para_girar <= 0
         select @w_valor = @i_val
      else
         select @w_valor = @w_saldo_para_girar
   end
   else
      select @w_valor = @i_val

   if @i_factor = -1 and @t_trn in (264,228) and @w_flag = 1 and @i_ind = 1
      select @w_valor = @o_val_mon


   /*INICIO COBRO IVA*/

   select @w_com_iva = an_comision
   from   cob_remesas..re_accion_nd
   where  an_producto = 4
   and    an_causa = @i_cau

   select @w_rowcount = @@rowcount

   if @w_rowcount = 0
    select @w_com_iva  = 'N'


   select @o_val_2x1000 = $0

   if @i_factor = 1
   begin -- 1

      if @w_com_iva = 'S'
      begin --2
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


         /** cuando es nota debito y no alcanza el disponible calcula para generar valor en suspenso */
         if (@i_val + @w_impuesto) > @w_saldo_para_girar
         begin  --3
               select @w_valimp = @w_valor/(1+@w_piva)
               select @w_impuesto  = round((@w_valimp * @w_piva), @w_numdeci_imp)
               select @w_total_val_imp =  @w_valimp + @w_impuesto
         end--3
         else
            select @w_total_val_imp =  @i_val + @w_impuesto

         select @o_impuesto  =  @w_impuesto
         select @o_valiva = @o_valiva + @w_impuesto

      end --2
      else
      begin --2

         if @i_val > @w_saldo_para_girar
            select @w_total_val_imp =  @w_valor
         else
            select @w_total_val_imp =  @i_val

         select @w_piva = 0,
                @w_impuesto  = 0
      end --2
   end -- 2
   else
   begin
     select @w_valor      = tm_valor,
            @w_impuesto   = isnull(tm_valor_comision,0),
            @w_val_2x1000 = isnull(tm_monto_imp,0)
     from   cob_ahorros..ah_tran_monet
     where  tm_ssn_branch = @w_ssn_corr
     and    tm_oficina    = @w_ofiord
     and    tm_cod_alterno = 0

     select @w_total_val_imp = @w_valor + @w_impuesto
   end

/*FIN COBRO IVA*/

   if @w_corresponsal = 'N' begin
   --  Llama sp que calcula GMF de acuerdo a concepto exencion
   exec @w_return = sp_calcula_gmf
        @s_user               = @s_user,
        @s_date               = @i_fecha,
        @s_ofi                = @s_ofi,
        @t_trn                = @t_trn,
        @t_ssn_corr           = @t_ssn_corr,
        @i_cliente            = @w_ente,
        @i_factor             = @i_factor,
        @i_mon                = @i_mon,
        @i_cta                = @i_cta,
        @i_cuenta             = @i_cuenta,
        @i_val                = @w_total_val_imp, --@i_val,
        @i_val_tran           = @w_total_val_imp, --@i_val,
        @i_numdeciimp         = @w_numdeci,
        @i_producto           = @w_producto,
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

   end
   -- Calculo valor total de impuestos
   if @i_factor = 1
   begin

      if @t_trn = 264 and ((@i_val + @w_impuesto + @o_val_2x1000) > @w_saldo_para_girar)
      begin
         if @w_impuesto = 0
            select @w_valor = @w_saldo_para_girar,
                   @w_piva = 0

         select @w_valor    = round(@w_valor/(1+@w_tasa_gmf), @w_numdeci_imp)
         select @w_baseimp  = round((@w_valor /(1+(@w_piva/100))), @w_numdeci_imp)
         select @w_impuesto = @w_valor - @w_baseimp
         select @w_valor    = @w_valor - @w_impuesto

         select @o_val_2x1000 = round(((@w_valor + @w_impuesto) * @w_tasa_gmf), @w_numdeci_imp)
      end

      if @t_trn in(263, 371, 380) or (@t_trn = 264 and @i_ind = 1)
         select @o_monto_imp = isnull(@o_monto_imp, $0) + @o_val_2x1000
      else
         select @o_val_2x1000 = $0

   end
   else
       select @o_val_2x1000 = @w_val_2x1000


   select @o_valiva    = @w_impuesto,
          @o_impuesto  = @w_impuesto

     -- Consulta de ciudad para las oficinas de la cuenta*/
     -- y oficina con la que trabaja el sistema

   select @w_realizar_deb = 0

   if @t_trn in (264)
      select @w_trn = 264

   if @t_trn in( 263, 380)
   begin

        /*FRC-AHO-017-CobroComisiones CMU 2102110*/
        select @w_ciudad_cta =oc_centro
        from cob_cuentas..cc_ofi_centro
        where oc_oficina = @w_oficina

        if @@rowcount <> 1
        begin
           exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 201094
           return 201094
        end

        select @w_ciudad_loc =oc_centro
        from cob_cuentas..cc_ofi_centro
        where oc_oficina = @s_ofi

        /*FRC-AHO-017-CobroComisiones CMU 2102110*/
 if @@rowcount <> 1
        begin
           exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 201094
           return 201094
        end

        select @w_trn = 264

        if @i_factor = 1
        begin
           select @w_comision_trn  = @i_comision

           if @w_ciudad_cta <> @w_ciudad_loc
           begin -- Se realiza el cobro de la comision por transaccion nacional

              /*exec @w_return = cob_remesas..sp_genera_costos
                   @t_debug        = @t_debug,
                   @t_file         = @t_file,
                   @t_from         = @w_sp_name,
                   @i_fecha        = @i_fecha,
                   @i_valor        = 1,
                   @i_categoria    = @o_categoria,
                   @i_tipo_ente    = @w_tipocta,
                   @i_rol_ente     = @w_rol_ente,
                   @i_tipo_def     = @w_tipo_def,
                   @i_prod_banc    = @o_prod_banc,
                   @i_producto     = @w_producto,
                   @i_moneda       = @i_mon,
                   @i_tipo         = @w_tipo,
                   @i_codigo       = @w_codigo,
                   @i_servicio     = 'TRNA',
                   @i_rubro        = '3',
                   @i_disponible   = @w_disponible,
                   @i_contable     = @w_saldo_contable,
                   @i_promedio     = @w_promedio1,
                   @i_prom_disp    = @w_prom_disp,
                   @i_personaliza  = @w_personaliza,
                   @i_filial       = @w_filial,
                   @i_oficina      = @w_oficina,
                   @o_valor_total  = @w_comision out

             if @w_return <> 0
                return @w_return*/
             if isnull(@w_comision_trn, 0) > 0
             begin
                select @w_iva = 0  -- No se cobra IVA sobre la comision

                select @w_valor_cobro = (( @w_comision_trn * @w_iva)/100)
                select @w_valor_cobro_com = @w_valor_cobro + @w_comision_trn
                select @w_cobro_total =  @w_valor_cobro_com + @w_val_total

                if @w_cobro_total > @w_saldo_para_girar
                begin /* Fondos Insuficientes */
                   select @w_realizar_deb = 0
                   exec cobis..sp_cerror
                   @t_debug  = @t_debug,
                   @t_file   = @t_file,
                   @t_from   = @w_sp_name,
                   @i_num    = 251033

                   return 251033
                end
                else
                   select @w_realizar_deb = 1
             end
          end
       end
   end


   -- Parametro tope para cobro comision retiro ventanilla
   select @w_valor_tope = pa_money
   from   cobis..cl_parametro
   where  pa_nemonico = 'AHMCRV'
   and    pa_producto = 'AHO'

    if @@rowcount = 0
    begin
       -- No existe parametro
       exec cobis..sp_cerror
        @t_debug   = null,
        @t_file    = null,
        @t_from    = @w_sp_name,
        @i_num = 101077

       return 101077
    end

    -- VALIDACION APLICACION COBRO RETIRO VENTANILLA
    if @i_val < @w_valor_tope
    begin

       exec @w_return = cob_remesas..sp_genera_costos
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_fecha        = @i_fecha,
            @i_valor        = 1,
            @i_categoria    = @o_categoria,
            @i_tipo_ente    = @w_tipocta,
            @i_rol_ente     = @w_rol_ente,
            @i_tipo_def     = @w_tipo_def,
            @i_prod_banc    = @o_prod_banc,
            @i_producto     = @w_producto,
            @i_moneda       = @i_mon,
   @i_tipo         = @w_tipo,
            @i_codigo       = @w_codigo,
            @i_servicio     = 'REVE',
            @i_rubro        = '3',
            @i_disponible   = @w_disponible,
            @i_contable     = @w_saldo_contable,
            @i_promedio     = @w_promedio1,
            @i_prom_disp    = @w_prom_disp,
            @i_personaliza  = @w_personaliza,
            @i_filial       = @w_filial,
            @i_oficina      = @w_oficina,
            @o_valor_total  = @w_cobro_tarifa out

       if @w_return <> 0
          return @w_return
    end

    if exists (select 1 from cob_remesas..re_relacion_cta_canal where rc_cuenta = @i_cta and rc_canal = 'TAR')
    begin
       select @w_servicio = valor
       from cobis..cl_tabla t, cobis..cl_catalogo c
       where t.tabla  = 'pe_comision_td'
       and   t.codigo = c.tabla
       and   c.codigo = CONVERT(char, @t_trn)

       if @w_servicio is not null
       begin
          exec @w_return = cob_remesas..sp_genera_costos
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_fecha        = @i_fecha,
               @i_valor        = 1,
               @i_categoria    = @o_categoria,
               @i_tipo_ente    = @w_tipocta,
               @i_rol_ente     = @w_rol_ente,
               @i_tipo_def     = @w_tipo_def,
               @i_prod_banc    = @o_prod_banc,
               @i_producto     = @w_producto,
               @i_moneda       = @i_mon,
               @i_tipo         = @w_tipo,
               @i_codigo       = @w_codigo,
               @i_servicio     = @w_servicio,--Comision por retiro a cuentas con tarjeta debito
               @i_rubro        = '3',
               @i_disponible   = @w_disponible,
               @i_contable     = @w_saldo_contable,
               @i_promedio     = @w_promedio1,
               @i_prom_disp    = @w_prom_disp,
               @i_personaliza  = @w_personaliza,
               @i_filial       = @w_filial,
               @i_oficina      = @w_oficina,
               @o_valor_total  = @w_cobro_td out --Valor comision Tarjeta Debito

          if @w_return <> 0
             return @w_return
       end
    end

    if @t_trn = 380  begin

       -- SE BUSCA COSTOS DE COBRO COMISIONES por retiro con cheque de gerencia

       exec @w_return = cob_remesas..sp_genera_costos
       @t_debug        = @t_debug,
       @t_file         = @t_file,
       @t_from         = @w_sp_name,
       @i_fecha        = @i_fecha,
       @i_valor        = 1,
       @i_categoria    = @o_categoria,
       @i_tipo_ente    = @w_tipocta,
       @i_rol_ente     = @w_rol_ente,
       @i_tipo_def     = @w_tipo_def,
       @i_prod_banc    = @o_prod_banc,
       @i_producto     = @w_producto,
       @i_moneda       = @i_mon,
       @i_tipo         = @w_tipo,
       @i_codigo       = @w_codigo,
       @i_servicio     = 'CHQG',
       @i_rubro        = '3',
       @i_disponible   = @w_disponible,
       @i_contable     = @w_saldo_contable,
       @i_promedio     = @w_promedio1,
       @i_prom_disp    = @w_prom_disp,
       @i_personaliza  = @w_personaliza,
       @i_filial       = @w_filial,
       @i_oficina      = @w_oficina,
       @o_valor_total  = @w_cobro_comision_chq out

       if @w_return <> 0
          return @w_return


    end
    else
       select @w_cobro_comision_chq   = 0

    --print 'retiro_ndebito_sl @w_cobro_comision_chq: ' + cast(@w_cobro_comision_chq as varchar)
end

/*FRC-AHO-017-CobroComisiones CMU 2102110*/
if @w_ciudad_cta = @w_ciudad_loc
   select @w_ndebmes = @w_ndebmes + ( 1 * @i_factor )

begin tran
/* Validar Fondos */
if @i_factor = 1
begin
   if @t_trn = 264 or @t_trn = 228
   begin
      if  @i_ind = 2
      select @w_saldo_para_girar = @w_12h
      else
      if  @i_ind = 3
      select @w_saldo_para_girar = @w_24h
      else
      if  @i_ind = 4
      select @w_saldo_para_girar = @w_remesas
   end
   if (@i_val + @o_monto_imp + @o_impuesto) > @w_saldo_para_girar
   begin
      if @t_trn in(263, 371, 380)
      begin   /* Cuenta sin fondos */
         exec cobis..sp_cerror
         @t_debug  = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 251033
         return 251033
      end

      if @t_trn in (264, 228) and @i_ind > 1
      begin   /* Valor mayor a retencion */
         exec cobis..sp_cerror
         @t_debug  = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 251028
         return 1
      end

      /* Encuentra accion para la causa de las notas de debito */
      select @w_accion = an_accion
      from  cob_remesas..re_accion_nd
      where an_producto = 4
      and   an_causa = @i_cau
      if @@rowcount = 0 or @w_accion = 'S'
         select @w_accion = 'V'

      if @w_accion = 'E'
      begin   /* Cuenta sin fondos */
         exec cobis..sp_cerror
         @t_debug  = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 251033
         return 251033
      end

      if @t_trn in (264,228) and @i_ind = 1
      begin

         /* Valor a poner en suspenso */
         if @w_saldo_para_girar <= 0
         begin
            /* pone todo a suspenso */
            select @w_val       = @i_val,
                   @o_sus_flag  = 2,
                   @o_val_ser   = @i_val,
                   @o_monto_imp = $0,
                   @o_impuesto  = $0
         end
         else
         begin
            /* pone solo el faltante a suspenso */
            if @w_codigo_pais = 'CO'
               select @w_val2 = @w_valor
            else
               select @w_val2 = round((@w_saldo_para_girar / (1 + @w_tasa_imp)), @w_numdeci_imp)

            select @w_val = @i_val - @w_val2
            --select @o_monto_imp = @w_saldo_para_girar - @w_val2
            select @o_sus_flag = 1,
                   @o_val_ser = @w_val,
                   @o_val_mon = @i_val - @w_val
         end

         select @o_val_mon = isnull(@o_val_mon, $0)

         exec @w_return = cobis..sp_cseqnos
         @t_debug     = @t_debug,
         @t_file      = @t_file,
         @t_from      = @w_sp_name,
         @i_tabla     = 'ah_val_suspenso',
         @o_siguiente = @w_sec out

         if @w_return <> 0
                 return @w_return
         if @w_sec > 2147483640
         begin
            select @w_sec = 1
            update cobis..cl_seqnos
            set   siguiente = @w_sec
            where tabla   = 'ah_val_suspenso'
         end

         select @w_suspensos = @w_suspensos + 1

         insert into cob_ahorros..ah_val_suspenso
                (vs_cuenta, vs_secuencial, vs_servicio, vs_valor,
                 vs_oficina, vs_fecha, vs_hora, vs_ssn,
                 vs_estado, vs_procesada, vs_clave, vs_impuesto)
         values (@i_cuenta, @w_sec, @i_cau, @w_val,
                 @s_ofi, @i_fecha, getdate(), @s_ssn,
                 'N', 'N', 0, 'S')
         if   @@error <> 0
         begin
            exec cobis..sp_cerror
            @t_debug  = @t_debug,
            @t_file   = @t_file,
            @t_from   = @w_sp_name,
            @i_num    = 253003
            return 1
         end

         if @w_corresponsal = 'S' begin
          --Se genera transacci¾n de servicio para disminuci¾n
               insert into cob_ahorros..ah_tran_servicio
               (ts_secuencial,    ts_ssn_branch, ts_cod_alterno, ts_tipo_transaccion, ts_oficina,    ts_usuario,
                ts_terminal,      ts_correccion, ts_ssn_corr,    ts_reentry,
                ts_origen,        ts_nodo,       ts_tsfecha,     ts_cta_banco,        ts_moneda,
                ts_valor,         ts_interes,    ts_indicador,   ts_causa,
                ts_prod_banc,     ts_categoria,  ts_oficina_cta, ts_observacion,
                ts_tipocta_super, ts_clase_clte, ts_cliente,    ts_hora)
               values
               (@s_ssn,           @s_ssn,        1,              752,                 @w_oficina,        @s_user,
                @s_term,          'N',           null,           'N',
                'L',              @s_srv,        @i_fecha,        @i_cta,        0,
                @w_val       ,    null,          1,              '50',
                @o_prod_banc,     @o_categoria,  @w_oficina,   ('DISMINUCION CUPO CB POSICIONADO ' + CAST(@w_oficina as varchar)),
                @w_tipocta,       @o_clase_clte, @o_cliente,    getdate())

                if   @@error <> 0
                begin
                   exec cobis..sp_cerror
                   @t_debug  = @t_debug,
                   @t_file   = @t_file,
                   @t_from   = @w_sp_name,
                   @i_num    = 253003
                   return 1
                end
         end

         if @o_sus_flag = 1  and @w_posteo = 'S' -- Si es 'S' mantener lineas pendientes
         begin
            select @w_lineas = @w_lineas + 1,
                   @w_sec = @i_lpend

            insert into cob_ahorros..ah_linea_pendiente
                   (lp_cuenta, lp_linea, lp_nemonico, lp_valor,
                    lp_fecha, lp_control, lp_signo, lp_enviada)
            values (@i_cuenta, @w_sec, @w_nemo, @o_val_mon,
                    @i_fecha, @w_control, 'D', 'N')
            if @@error <> 0
            begin
               exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 253002
               return 1
      end

            if @o_monto_imp > 0
            begin
               select @w_lineas = @w_lineas + 1
               insert into cob_ahorros..ah_linea_pendiente
                    (lp_cuenta, lp_linea, lp_nemonico, lp_valor,
                     lp_fecha, lp_control, lp_signo, lp_enviada)
               values (@i_cuenta, @w_sec + 1, @w_nemo2, @o_monto_imp,
                     @i_fecha, @w_control + 1, 'D', 'N')
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

        select @w_debitos  = @w_debitos + (@i_val - @w_val + @o_monto_imp + @o_impuesto)* @i_factor
        select @w_debhoy   = @w_debhoy + (@i_val - @w_val + @o_monto_imp + @o_impuesto)* @i_factor

        /* Actualiza Maestro de Ahorros */
        update cob_ahorros..ah_cuenta
           set ah_suspensos       = @w_suspensos,
               ah_fecha_ult_mov   = @i_fecha,
               ah_linea           = @w_lineas,
               ah_debitos         = @w_debitos,
               ah_debitos_hoy     = @w_debhoy,
               ah_promedio1       = @w_promedio1 -
                                    round((@i_val - @w_val + @o_monto_imp + @o_impuesto ) *
                                    @w_alic_prom * @i_factor,@w_numdeci),
               ah_prom_disponible = @w_prom_disp -
                                    round((@i_val - @w_val + @o_monto_imp + @o_impuesto ) *
                                    @w_alic_prom * @i_factor,@w_numdeci),
               ah_disponible      = @w_disponible - (@i_val - @w_val +
                                    @o_monto_imp + @o_impuesto )*@i_factor,
               ah_contador_trx    = ah_contador_trx + @i_factor,
               ah_fecha_ult_ret   = @i_fecha,
               ah_monto_imp       = ah_monto_imp + @o_monto_imp
         where ah_cuenta = @i_cuenta
        if   @@rowcount <> 1
        begin
           exec cobis..sp_cerror
           @t_debug  = @t_debug,
           @t_file   = @t_file,
           @t_from   = @w_sp_name,
           @i_num    = 255001
           return 1
        end

        select @o_sldcont = @w_saldo_contable - (@i_val - @w_val + @o_monto_imp + @o_impuesto )
        select @o_slddisp = @w_disponible - (@i_val - @w_val + @o_monto_imp + @o_impuesto )

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

        commit tran
        return 0
     end
  end
end

/* Validar valor en suspenso */
if @i_factor = -1 and @t_trn in (264,228) and @w_flag = 1 and @i_ind = 1
begin
     update cob_ahorros..ah_val_suspenso
     set vs_estado = 'A', vs_procesada = 'S'
     where vs_fecha = @i_fecha
     and vs_ssn = @w_ssn_tmp
     if @@rowcount <> 1
     begin
        exec cobis..sp_cerror
        @t_debug  = @t_debug,
        @t_file   = @t_file,
        @t_from   = @w_sp_name,
        @i_num    = 203011
        return 1
     end

     select @w_val = vs_valor
     from cob_ahorros..ah_val_suspenso
     where vs_fecha = @i_fecha
     and vs_ssn = @w_ssn_tmp
     and vs_estado = 'A'
     and vs_procesada = 'S'

     if @w_corresponsal = 'S' begin
     --REQ 381 Validar si existe ts de la disminucion de cupo, para marcar como Reverso para no contabilizar
            if exists (select 1 from cob_ahorros..ah_tran_servicio
                 where ts_tsfecha          = @i_fecha --Fecha de la transaccion (Solo del dia)
                 and   ts_tipo_transaccion = 752 --Tx Disminucion Cupo
                 and   ts_causa            = 50  --Causal Disminucion Cupo
                 and   ts_secuencial       = @w_ssn_tmp
                 and   ts_valor            = @w_val )
            begin
               update cob_ahorros..ah_tran_servicio
               set ts_estado = 'R'
               where ts_tsfecha          = @i_fecha --Fecha de la transaccion (Solo del dia)
               and   ts_tipo_transaccion = 752 --Tx Disminucion Cupo
               and   ts_causa            = 50  --Causal Disminucion Cupo
               and   ts_secuencial       = @w_ssn_tmp
               and   ts_valor            = @w_val

               --Se genera transacci¾n de servicio para aumento de cupo
               insert into cob_ahorros..ah_tran_servicio
               (ts_secuencial,    ts_ssn_branch, ts_cod_alterno, ts_tipo_transaccion, ts_oficina,    ts_usuario,
                ts_terminal,      ts_correccion, ts_ssn_corr,    ts_reentry,
                ts_origen,        ts_nodo,       ts_tsfecha,     ts_cta_banco,        ts_moneda,
                ts_valor,         ts_interes,    ts_indicador,   ts_causa,
                ts_prod_banc,     ts_categoria,  ts_oficina_cta, ts_observacion,
                ts_tipocta_super, ts_clase_clte, ts_cliente,    ts_hora, ts_estado)
               values
               (@s_ssn,           @s_ssn,        1,              752,                 @s_ofi,        @s_user,
                @s_term,          'S',           @w_ssn_tmp,    'N',
                'L',              @s_srv,        @i_fecha,        @i_cta,        0,
                @i_val       ,    null,          1,            '50',
                @o_prod_banc,     @o_categoria,  @w_oficina,    ('CORR: ' + cast(@w_ssn_tmp as varchar) +
                                                                 ' DISMINUCION CUPO CB POSICIONADO ' + CAST(@w_oficina as varchar)),
                @w_tipocta,       @o_clase_clte, @o_cliente,    getdate(), 'R')
            end
            else
            begin
               select @w_return = @@error

               if @w_return <> 0
               begin
                  exec cobis..sp_cerror
                  @t_debug    = @t_debug,
                  @t_file     = @t_file,
                  @t_from     = @w_sp_name,
                  @i_num      = 251067
                  return 1
               end
            end
     end

     select @w_suspensos = @w_suspensos - 1

     if @o_sus_flag = 1  and @w_posteo = 'S' -- Si es 'S' mantener lineas pendientes
     begin
        select @w_lineas = @w_lineas + 1
        insert into cob_ahorros..ah_linea_pendiente
               (lp_cuenta, lp_linea, lp_nemonico, lp_valor,
                lp_fecha, lp_control, lp_signo, lp_enviada)
        values (@i_cuenta, @w_sec, 'CORR', @o_val_mon,
               @i_fecha, @w_control, 'C', 'N')
        if @@error <> 0
        begin
            exec cobis..sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 253002
            return 1
       end

       if @o_monto_imp > 0
       begin
             select @w_lineas = @w_lineas + 1
             insert into cob_ahorros..ah_linea_pendiente
                  (lp_cuenta, lp_linea, lp_nemonico, lp_valor,
                   lp_fecha, lp_control, lp_signo, lp_enviada)
             values (@i_cuenta, @w_sec+1, 'CORR', @o_monto_imp,
                   @i_fecha, @w_control+1, 'C', 'N')
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

    select @w_debitos = @w_debitos + (@i_val - @w_val + @o_monto_imp + @o_impuesto ) * @i_factor
    select @w_debhoy =  @w_debhoy + (@i_val - @w_val +  @o_monto_imp + @o_impuesto ) * @i_factor

    /* Actualiza Maestro de Ahorro */
    update cob_ahorros..ah_cuenta
       set ah_suspensos       = @w_suspensos,
           ah_fecha_ult_mov   = @i_fecha,
           ah_linea           = @w_lineas,
           ah_debitos         = @w_debitos,
           ah_debitos_hoy     = @w_debhoy,
           ah_promedio1       = @w_promedio1    + (@i_val - @w_val +
                                @o_monto_imp + @o_impuesto)   * @w_alic_prom,
           ah_prom_disponible = @w_prom_disp    + (@i_val - @w_val +
                                @o_monto_imp + @o_impuesto)   * @w_alic_prom,
           ah_disponible      = @w_disponible   + (@i_val - @w_val + @o_monto_imp + @o_impuesto ),
           ah_contador_trx    = ah_contador_trx + @i_factor,
           ah_fecha_ult_ret   = @i_fecha,
           ah_monto_imp       = ah_monto_imp - @o_monto_imp
    where ah_cuenta = @i_cuenta
    if   @@rowcount <> 1
    begin
       exec cobis..sp_cerror
       @t_debug  = @t_debug,
       @t_file   = @t_file,
       @t_from   = @w_sp_name,
       @i_num    = 255001
       return 1
    end

    select @o_sldcont = @w_saldo_contable + (@i_val - @w_val + @o_monto_imp + @o_impuesto)
    select @o_slddisp = @w_disponible + (@i_val - @w_val + @o_monto_imp + @o_impuesto)

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

    commit tran
    return 0
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


if @w_posteo = 'S' -- Si es 'S' mantener lineas pendientes
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
end

/* COBRO DE NX1000 */
if @o_val_2x1000 > 0 and @w_posteo = 'S' -- Si es 'S' mantener lineas pendientes
begin
  select @w_lineas  = @w_lineas + 1,
         @w_control = @w_control + 1

  insert into cob_ahorros..ah_linea_pendiente
      (lp_cuenta, lp_linea, lp_nemonico, lp_valor,
       lp_fecha, lp_control, lp_signo, lp_enviada)
  values
      (@i_cuenta, @w_sec + 2, @w_nemo3, @o_val_2x1000,
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
/*  Actualizacion Cuenta de Ahorros  */
if @t_trn in(263, 371, 380) or (@t_trn in (264,228) and @i_ind = 1)
begin
   select @w_disponible = @w_disponible - ((@i_val+@o_monto_imp+@o_impuesto) * @i_factor)
   select @w_prom_disp  = @w_prom_disp - round(((@i_val+@o_monto_imp+@o_impuesto) * @w_alic_prom),@w_numdeci) * @i_factor
end
else
begin
   if @i_ind = 2
   begin
      select @w_12h = @w_12h - @i_val * @i_factor
      if @i_dif = 'S'
         select @w_12h_dif = @w_12h_dif - @i_val * @i_factor
   end
   else
      if @i_ind = 3
      begin
         select @w_24h = @w_24h - @i_val * @i_factor

         /* Determinar el numero de dias de retencion para la ciudad */
         select @w_dias_ret = rl_dias
         from  cob_ahorros..ah_retencion_locales
         where rl_agencia = @s_ofi
         and   @w_hora_ejecucion between rl_hora_inicio and rl_hora_fin

         if @@rowcount = 0
         begin
            /* Determinar el parametro general */

            select @w_dias_ret = pa_tinyint
              from cobis..cl_parametro
             where pa_producto = 'AHO'
               and pa_nemonico = 'DIRE'

            if @@rowcount = 0
            begin
              exec cobis..sp_cerror
                   @t_debug        = @t_debug,
                   @t_file         = @t_file,
                   @t_from         = @w_sp_name,
                   @i_num          = 205001
              return 1
            end
         end

         /*** La determinacion del siguiente dia laboral  se             ****/
         /*** hace mediante el llamado al siguiente sp  - JLOYO          ****/
         exec @w_return = cob_remesas..sp_fecha_habil
         @i_val_dif       = 'N',
         @i_efec_dia      = 'S',
         @i_fecha         = @w_fecha_efe,
         @i_oficina       = @s_ofi,
         @i_dif           = @i_dif,               /**** Ingreso en  horario normal  ***/
         @w_dias_ret      = @w_dias_ret,                /*** Dias siguientes habil ***/
         @o_ciudad        = @w_ciudad  out,
         @o_fecha_sig     = @w_fecha_efe out

         if @w_return <> 0
             return @w_return


          if exists (select 1 from cob_ahorros..ah_ciudad_deposito
                          where cd_cuenta = @i_cuenta
                            and cd_ciudad = @w_ciudad
               and cd_fecha_depo = @i_fecha
                            and cd_fecha_efe  = @w_fecha_efe)
            begin

               update cob_ahorros..ah_ciudad_deposito
                  set cd_valor      = cd_valor - (@i_val * @i_factor)
                where cd_cuenta     = @i_cuenta
                  and cd_ciudad     = @w_ciudad
                  and cd_fecha_depo = @i_fecha
                  and cd_fecha_efe  = @w_fecha_efe

               if @@rowcount <> 1
                 begin
                   exec cobis..sp_cerror
                        @t_debug        = @t_debug,
                        @t_file         = @t_file,
                        @t_from         = @w_sp_name,
                        @i_num          = 253002
                   return 253002
                 end

            end
          else
            begin

              insert into cob_ahorros..ah_ciudad_deposito
                     (cd_cuenta, cd_ciudad, cd_fecha_depo,
                      cd_fecha_efe, cd_valor)
              values (@i_cuenta, @w_ciudad, @i_fecha,
                      @w_fecha_efe, @i_val)

              if @@error <> 0
                begin
                  exec cobis..sp_cerror
                       @t_debug        = @t_debug,
                       @t_file         = @t_file,
                       @t_from         = @w_sp_name,
                       @i_num          = 205001
                  return 1
                end
            end
        end
      else
         if @i_ind = 4
            select @w_remesas = @w_remesas - @i_val * @i_factor,
                   @w_rem_hoy = @w_rem_hoy - @i_val * @i_factor
end

select @w_promedio1 = @w_promedio1 - round(((@i_val+@o_monto_imp+@o_impuesto) * @w_alic_prom),@w_numdeci)
                     * @i_factor,
       @w_debitos   = @w_debitos + ((@i_val+@o_monto_imp+@o_impuesto) * @i_factor)


/* LBM -- verificar si se debe actualizar el campo con la causal */
if @t_trn = 264 and @i_factor = 1
   begin
    if @w_act_fecha = 'S'
       select @w_fecha_ult_mov = @i_fecha
   end
else
   begin
       select @w_fecha_ult_mov = @i_fecha
   end

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
       /*FRC-AHO-017-CobroComisiones CMU 2102110*/
       ah_num_deb_mes     = @w_ndebmes
where @i_cuenta = ah_cuenta
if   @@rowcount <> 1
begin
   exec cobis..sp_cerror
       @t_debug  = @t_debug,
           @t_file   = @t_file,
       @t_from   = @w_sp_name,
       @i_num    = 255001
   return 1
end



if @w_codigo_pais = 'CO' -- Colombia
begin

   if @t_trn in (264,371) and @i_factor = 1
      select @w_trn = 264,
             @w_comision_trn  = @i_comision

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

   -- ND Comision Transaccion Nacional e IVA

   if @i_factor = -1
   begin
      -- Reverso Comision e IVA


      if @t_trn  = 371
          select @w_trn = 264

      select @w_comision_trn = 0

          select @w_comision_trn = fv_costo
           from cob_ahorros..ah_fecha_valor
             where fv_transaccion = @w_trn
            and fv_referencia =  convert(varchar(24), @t_ssn_corr)
            and fv_rubro = '1'

   end
      if isnull(@w_comision_trn, 0) > 0
      begin
         if @w_ciudad_cta <> @w_ciudad_loc
            select @w_alt = 2
         else
            select @w_alt = 4

         select
         @w_gmf        = 0,
         @w_valiva = 0
         exec @w_return = cob_ahorros..sp_ahndc_automatica
                    @s_srv        = @s_srv,
                    @s_ofi        = @s_ofi,
                    @s_ssn        = @s_ssn,
                    @s_ssn_branch = @s_ssn_branch,
                    @s_user       = @s_user,
                    @t_trn        = @w_trn,
                    @t_corr       = @t_corr,
                    @t_ssn_corr   = @t_ssn_corr,
                    @i_cta        = @i_cta,
                    @i_val        = @w_comision_trn,
                    @i_cau        = @i_causal,
                    @i_mon        = @i_mon,
                    @i_alt        = @w_alt,
                    @i_fecha      = @i_fecha,
                    @i_cobiva     = 'S',
                    @i_canal      = 4,
                    @o_valiva     = @w_valiva out,
                    @o_val_2x1000 = @w_gmf out

         if @w_return <> 0
            return @w_return

         if @i_factor = 1
         begin
               /* Inserto en ah_fecha_valor el valor de la comision CPA */
               insert into cob_ahorros..ah_fecha_valor
                      (fv_transaccion, fv_cuenta, fv_referencia,
                       fv_rubro, fv_costo)
               values (@w_trn, @i_cuenta, convert(varchar(24), @s_ssn_branch),
                       '1', @w_comision_trn)
               if @@error <> 0
               begin
                   exec cobis..sp_cerror
                        @t_debug        = @t_debug,
                        @t_file         = @t_file,
                        @t_from         = @w_sp_name,
                        @i_num          = 601161

                   return 601161
               end

               if isnull(@w_valiva,0) > 0
               begin
                  -- Inserto en ah_fecha_valor el valor del iva CPA
                  insert into cob_ahorros..ah_fecha_valor
                         (fv_transaccion, fv_cuenta, fv_referencia,
                          fv_rubro, fv_costo)
                  values (@w_trn, @i_cuenta, convert(varchar(24), @s_ssn_branch),
                          '2', @w_valiva)
                  if @@error <> 0
                  begin
                     exec cobis..sp_cerror
                          @t_debug        = @t_debug,
                          @t_file         = @t_file,
                          @t_from         = @w_sp_name,
                          @i_num          = 601161

                     return 601161
                  end
               end
         end
         select
         @o_comision = @o_comision + @w_comision_trn,
         @o_valiva = @o_valiva + @w_valiva,
         @o_monto_imp = @o_monto_imp + @w_gmf

      end

   if @i_factor = -1
   begin
      -- Reversos


      --select @o_comision = @o_comision + @w_comision_trn

      -- Actualiza movimiento Original
      update cob_ahorros..ah_tran_monet
      set    tm_estado = 'R'
      where  tm_oficina = @w_ofiord -- EAL RETCALL.
      and    tm_ssn_branch = @t_ssn_corr
      and    tm_cta_banco = @i_cta
      and    tm_tipo_tran = @w_trn
      and    tm_cod_alterno = 2
      and    tm_estado = null

      if @@error <> 0
      begin
      -- Error en la eliminacion
         exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251067

         return 251067
      end

      -- Borro los registros de ah_fecha_valor
      delete cob_ahorros..ah_fecha_valor
       where fv_transaccion = @w_trn
         and fv_referencia = convert(varchar(24), @t_ssn_corr)
         and fv_rubro in('1', '2')

      if @@error <> 0
      begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 601161

          return 601161
      end
   end

      -- AUTOMATICA TARIFARIO
   if isnull(@w_cobro_tarifa, 0) > 0
   begin
      select
      @w_gmf        = 0,
      @w_valiva_tarifa = 0
      -- ND por  valor comision

      exec @w_return = cob_ahorros..sp_ahndc_automatica
           @s_srv        = @s_srv,
           @s_ofi        = @s_ofi,
           @s_ssn        = @s_ssn,
           @s_ssn_branch = @s_ssn_branch,
           @s_user       = @s_user,
           @t_trn        = 264,
           @t_corr       = @t_corr,
           @t_ssn_corr   = @t_ssn_corr,
           @i_cta        = @i_cta,
           @i_val        = @w_cobro_tarifa,
           @i_cau        = '31',          -- causa cobro comision ret ventanilla
           @i_mon        = @i_mon,
           @i_alt        = 3,
           @i_fecha      = @i_fecha,
           @i_cobiva     = 'S',
           @i_canal      = 4,
           @o_valiva     = @w_valiva_tarifa out,
           @o_val_2x1000 = @w_gmf out

      if @w_return <> 0
         return @w_return

      select @o_comision = @o_comision + @w_cobro_tarifa,
             @o_valiva   = @o_valiva   + @w_valiva_tarifa,
             @o_monto_imp = @o_monto_imp + @w_gmf


      if @i_factor = -1
      begin

             -- Actualiza movimiento Original
             update cob_ahorros..ah_tran_monet
                set tm_estado = 'R'
              where tm_oficina     = @w_ofiord  -- EAL RETCALL.
                and tm_ssn_branch  = @t_ssn_corr
                and tm_cta_banco   = @i_cta
                and tm_tipo_tran   = 264
                and tm_cod_alterno = 1
                and tm_estado      is null

             if @@error <> 0
             begin
                -- Error en la eliminacion
                exec cobis..sp_cerror
                     @t_debug = @t_debug,
                     @t_file  = @t_file,
                     @t_from  = @w_sp_name,
                     @i_num   = 251067

                return 251067
             end

             -- Actualiza movimiento Original
             update cob_ahorros..ah_tran_monet
             set    tm_estado = 'R'
             where  tm_oficina = @w_ofiord -- EAL RETCALL.
             and    tm_ssn_branch = @t_ssn_corr
             and    tm_cta_banco = @i_cta
             and    tm_tipo_tran = @w_trn
             and    tm_cod_alterno = 3
             and    tm_estado = null

             if @@error <> 0
             begin
             -- Error en la eliminacion
                exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 251067

                return 251067
             end
         end
   end

   /*FRC-AHO-017-CobroComisiones CMU 2102110*/
   -- COBRO COMISIONES


   if isnull(@w_cobro_td, 0) > 0
   begin
select
      @w_gmf = 0,
      @w_valiva_tarifa = 0
      -- ND por  valor comision
      exec @w_return = cob_ahorros..sp_ahndc_automatica
           @s_srv        = @s_srv,
           @s_ofi        = @s_ofi,
           @s_ssn        = @s_ssn,
           @s_ssn_branch = @s_ssn_branch,
           @s_user       = @s_user,
           @t_trn        = 264,
           @t_corr       = @t_corr,
           @t_ssn_corr   = @t_ssn_corr,
           @i_cta        = @i_cta,
           @i_val        = @w_cobro_td,
           @i_cau        = '160',         -- causa cobro comision retiro con cheque
           @i_mon        = @i_mon,
           @i_alt        = 7,
           @i_fecha      = @i_fecha,
           @i_cobiva     = 'S',
           @i_canal      = 4,
           @o_valiva     = @w_valiva_tarifa out,
           @o_val_2x1000 = @w_gmf out

      if @w_return <> 0
         return @w_return

      select @o_comision  = @o_comision  + @w_cobro_comision_chq,
             @o_valiva    = @o_valiva    + @w_valiva_tarifa,
             @o_monto_imp = @o_monto_imp + @w_gmf
   end

   if isnull(@w_cobro_comision_chq, 0) > 0
   begin
      select
      @w_gmf = 0,
      @w_valiva_tarifa = 0
      -- ND por  valor comision
      exec @w_return = cob_ahorros..sp_ahndc_automatica
           @s_srv        = @s_srv,
           @s_ofi        = @s_ofi,
           @s_ssn        = @s_ssn,
           @s_ssn_branch = @s_ssn_branch,
           @s_user       = @s_user,
           @t_trn        = 264,
           @t_corr       = @t_corr,
           @t_ssn_corr   = @t_ssn_corr,
           @i_cta        = @i_cta,
           @i_val        = @w_cobro_comision_chq,
           @i_cau        = '35',         -- causa cobro comision retiro con cheque
           @i_mon        = @i_mon,
           @i_alt        = 5,
           @i_fecha      = @i_fecha,
           @i_cobiva     = 'S',
           @i_canal      = 4,
           @o_valiva     = @w_valiva_tarifa out,
           @o_val_2x1000 = @w_gmf out

      if @w_return <> 0
         return @w_return

      select @o_comision  = @o_comision  + @w_cobro_comision_chq,
             @o_valiva    = @o_valiva    + @w_valiva_tarifa,
             @o_monto_imp = @o_monto_imp + @w_gmf
   end

   if @t_trn = 380  and @i_factor = 1-- generacion cheque gerencia
   begin

      select @w_c_tipo_compania = c_tipo_compania   from cobis..cl_ente
      where en_ced_ruc  = @i_num_id_benef
      and   en_tipo_ced = @i_tipo_id_benef


      exec   @w_idlote    = cob_interfase..sp_isba_cseqnos    -- BRON: 15/07/09  cob_sbancarios..sp_cseqnos
             @i_tabla     = 'sb_identificador_lotes',
             @o_siguiente = @w_numero_lote out

      select @w_referencia   = cast(@i_cuenta as varchar)
      select @w_campo1 = @i_tipo_id_benef + '-' + @i_num_id_benef
      select @w_campo3 = @i_tipo_id_benef + '-' + @i_num_id_benef


      select @w_observaciones = tn_descripcion
      from   cobis..cl_ttransaccion
      where  tn_trn_code = @t_trn

      /* REQ 249 PARAMETRO CONCEPTO EMISION CHQ GERENCIA */
      select  @w_par380 = pa_char
      from    cobis..cl_parametro
      where   pa_nemonico = 'ERCHQ'
      and     pa_producto = 'AHO'

      select @w_cpto_emision = valor
      from cobis..cl_catalogo
      where tabla = (select codigo from   cobis..cl_tabla
                     where  tabla = 'cc_concepto_emision')
      and   codigo = @w_par380


      exec     @w_return = cob_interfase..sp_isba_imprimir_lotes     -- BRON: 15/07/09  cob_sbancarios..sp_imprimir_lotes
               @s_ssn              = @s_ssn,
               @s_user             = @s_user,
               @s_term             = @s_term,
               @s_date             = @s_date,
               @s_srv              = @s_srv,
             @s_lsrv             = @s_lsrv,
               @s_ofi              = @s_ofi,
               @t_debug            = @t_debug,
               @t_trn              = 29334,
               @i_oficina_origen   = @s_ofi,
               @i_ofi_destino      = @s_ofi,
               @i_area_origen      = 99,
               @i_func_solicitante = 0,
               @i_fecha_solicitud  = @s_date,
               @i_producto         = 4,
               @i_instrumento      = 1,
               @i_subtipo          = 1,
               @i_valor            = @i_val,
               @i_beneficiario     = @i_nom_benef,
               @i_referencia       = @w_referencia,
               @i_tipo_benef       = @w_c_tipo_compania,
               @i_campo1           = @w_campo1,
               @i_campo2           = @i_nom_benef,
               @i_campo3           = @w_campo3,
               @i_campo4           = @i_nom_benef,
               @i_campo5           = @i_cta,
               @i_campo6           = @w_par380,
               @i_campo7           = @w_cpto_emision,
               @i_campo8           = @w_campo8,
               @i_observaciones    = @w_observaciones,
               @i_llamada_ext      = 'S',
               @i_concepto         = null,
               @i_fpago            = 'CHG',      -- REQ 249 NEMONICO DE LA FORMA DE PAGO
               @i_moneda           = @i_mon,
               @i_origen_ing       = '3',
               @i_idlote           = @w_idlote,  -- REQ 249 SECUENCIAL DEL SEQNOS DE SERVICIOS BANCARIOS
               @i_estado           = 'D',
               @i_campo21          = 'AHO',
               @i_campo22          = 'D',
               @i_campo40          = 'E',
               @o_idlote           = @w_idlote out,
               @o_secuencial       = @o_sec_cheque out

      if @w_return <> 0
      begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 141168
          return 141168
      end
   end



   if @i_factor = -1
   begin

         -- Actualiza movimiento Original
         update cob_ahorros..ah_tran_monet
         set    tm_estado = 'R'
         where  tm_oficina = @w_ofiord -- EAL RETCALL.
         and    tm_ssn_branch = @t_ssn_corr
         and    tm_cta_banco = @i_cta
         and    tm_tipo_tran = 264
         and    tm_cod_alterno = 5
         and    tm_estado is null

         if @@error <> 0
         begin
            print ' 5 - @w_ofiord: ' + cast(@w_ofiord as varchar) + '- @t_ssn_corr: ' + cast(@t_ssn_corr as varchar) + @i_cta
            -- Error en la eliminacion
            exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 251067

            return 251067
         end

         -- Actualiza movimiento Original
         update cob_ahorros..ah_tran_monet
         set    tm_estado = 'R'
         where  tm_oficina     = @w_ofiord   -- EAL RETCALL.
         and    tm_ssn_branch  = @t_ssn_corr
         and    tm_cta_banco   = @i_cta
         and    tm_tipo_tran   = 264
         and    tm_cod_alterno = 1
         and    tm_estado      is null

         if @@error <> 0
         begin
            print ' 1 -@w_ofiord: ' + cast(@w_ofiord as varchar) + '- @t_ssn_corr: ' + cast(@t_ssn_corr as varchar) + @i_cta
            -- Error en la eliminacion
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 251067

            return 251067
         end


         if @t_trn in(380) begin

             -------------------------------------------
             -- Reversar cheque si no fue emitido en SB
             -------------------------------------------

             -- secuencial@estado@serielit@serienum@fautoriza@moneda@
             select @w_grupo1 = cast(@i_sec_cheque as varchar) + '@T@@@@' + cast(@i_mon as varchar) + '@'

             exec  @w_return = cob_interfase..sp_isba_reversar_lotes  -- BRON: 15/07/09  cob_sbancarios..sp_reversar_lotes
                   @s_ssn              = @s_ssn,
                   @s_date             = @s_date,
                   @s_term             = @s_term,
                   --@s_sesn             = @s_sesn,
                   @s_srv              = @s_srv,
                   @s_lsrv             = @s_lsrv,
                   @s_user             = @s_user,
                   @s_ofi              = @s_ofi,
                   --@s_rol              = @s_rol,
                   @t_debug            = 'N',
                   @t_file             = @t_file,
                   @t_trn              = 29301,
                   @i_codigo_alterno   = 1,               -- SI SE LLAMA MAS DE UNA VEZ DESDE UN SP DEBE SUMARSE UNO A ESTE CAMPO PARA LA TRANSACCION DE SERVICIO
                   @i_origen_ing       = '1',             -- 1 INTERFASE 2 CARGA  3 MANUAL
                   @i_secuencial       = @i_sec_cheque,   -- CODIGO GENERADO POR SBA DEL CHEQUE A REVERSAR
                   @i_modulo           = 'AHO',           -- MODULO QUE GENERO LA SOLICITUD DEL CHEQUE
                   @i_moneda           = @i_mon,          -- MONEDA DEL INSTRUMENTO
                   @i_func_aut         = @s_user,         -- LOGIN DEL FUNCIONARIO QUE AUTORIZA EL REVERSO EN EL MODULO ORIGINAL
                   @i_producto         = 4,               -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
                   @i_instrumento      = 1,               -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
                   @i_subtipo_ins      = 1,               -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
                   @i_causal_anul      = '99',            -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
                   @i_llamada_ext      = 'S',             -- GAL 09/SEP/2009 - INTERFAZ - CHQCOM
                   @i_grupo1           = @w_grupo1        -- GAL 23/SEP/2009 - INTERFAZ - CHQCOM

             if @w_return <> 0
             begin
                 -- Error en la eliminacion
                 exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 208052
                 return 208052
             end
         end
   end
end

if @i_factor = 1
   select @w_oper_cont = 'I'
else
   select @w_oper_cont = 'D'

if @t_trn = 371
   select @t_trn = 263



/* POR RETIRO */
 if  @o_val_2x1000 > 0
 begin

     if  @i_factor <> 1
       select @w_gmf_reintegro = isnull(round( isnull(@o_val_2x1000,0) * (@w_tasa_reintegro /100),@w_numdeci_imp),0)


     if @w_gmf_reintegro > 0
     begin
          execute  @w_return =  sp_reintegro_gmf
                   @s_srv               = @s_srv,
                   @s_ofi               = @s_ofi,
                   @s_ssn               = @s_ssn,
                   @s_ssn_branch        = @s_ssn_branch ,
                   @s_user              = @s_user,
                   @s_term              = @s_term,
                   @t_corr              = @t_corr,
                   @t_ssn_corr          = @t_ssn_corr,
                   @s_date              = @i_fecha,
                   @i_cuenta            = @i_cuenta,
                   @i_valor             = @w_gmf_reintegro,
                   @i_mon               = @i_mon,
                   @i_alterno           = 50,
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


 /* Actualiza el contador de transacciones */
 exec @w_return     = sp_act_cont_trn
      @s_date       = @s_date,
      @t_debug      = @t_debug,
      @i_operacion  = @w_oper_cont,
      @i_cta        = @i_cta,
      @i_trn_accion = @t_trn

if @w_return <> 0
   return @w_return

commit tran


select @o_sldcont = @w_saldo_contable - ((@i_val+ @o_val_2x1000 + @o_impuesto) * @i_factor)
select @o_slddisp = @w_disponible

select @o_val_mon = @i_val
select @o_sus_flag = 0

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

