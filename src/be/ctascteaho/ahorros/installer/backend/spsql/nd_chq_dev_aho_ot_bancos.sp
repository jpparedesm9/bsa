/************************************************************************/
/*      Archivo:                nd_chq_dev_aho_ot_bancos.sp             */
/*      Stored procedure:       sp_nd_chq_dev_aho_ot_bancos             */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:                                                   */
/*      Fecha de escritura:                                             */
/************************************************************************/
/*                               IMPORTANTE                             */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por  escrito de COBISCorp.    */
/*  Este programa esta  protegido  por la ley de   derechos de autor    */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a COBISCorp para    */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Registrar Nota de Debito Cheque Devueltos de otros Bancos           */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_nd_chq_dev_aho_ot_bancos')
   drop proc sp_nd_chq_dev_aho_ot_bancos
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_nd_chq_dev_aho_ot_bancos (
        @t_debug         char(1)     = 'N',
        @t_file          varchar(14) = null,
        @t_from          varchar(30) = null,
        @t_trn           int,
        @t_rty           char(1),
        @t_corr          char(1),
        @t_show_version  bit = 0,
        @s_ofi           smallint,
        @s_rol           smallint,
        @s_org           char(1),
        @s_user          varchar(30),
        @s_srv           varchar(30),
        @s_lsrv          varchar(30),
        @s_term          varchar(10),
        @s_date          datetime    = null, -- BRANCHII
        @s_ssn           int,
        @s_ssn_branch    int         = null,      -- BRANCHII
        @t_ssn_corr      int,
        @t_ejec          char(1)     = null,  -- BRANCHII
        @p_rssn_corr     int,
        @p_lssn          int,
        @i_producto      tinyint,
        @i_cta_int       int,
        @i_ctadb         cuenta,
        @i_bco           smallint,
        @i_ofi           smallint,
        @i_par           int,
        @i_ctachq        cuenta,
        @i_nchq          int,
        @i_valch         money,
        @i_tipchq        varchar(1),
        @i_mon           tinyint,
        @i_cau           varchar(3),
        @i_dpto          tinyint,
        @i_factor        smallint,   /* 1=Normal, -1=Correccion */
        @i_fecha         smalldatetime,
        @i_turno         smallint    = null,
        @i_sld_caja      money       = 0,
        @i_idcierre      int         = 0,
        @i_filial        smallint    = 1,
        @i_idcaja        int         = 0,
        @o_sldcont       money       out,
        @o_slddisp       money       out,
        @o_nombre        varchar(30) out,
        @o_val_deb       money       out,
        @o_comision      money       out,
        @o_clave1        int         out,
        @o_clave2        int         out,
        @o_prod_banc     smallint    = null out,
        @o_categoria     char(1)     = null out,
        @o_tipocta_super char(1)     = null out
)
as
declare @w_return           int,
        @w_ssn_corr         int,
        @w_sp_name          varchar(30),
        @w_alicuota         float,
        @w_alic             money,
        @w_disponible       money,
        @w_promedio1        money,
        @w_promdisp         money,
        @w_numdeci          tinyint,
        @w_clave1           int,
        @w_clave2           int,
        @w_mensaje          mensaje,
        @w_tipo_bloqueo     varchar(3),
        @w_saldo_para_girar money,
        @w_saldo_contable   money,
        @w_tipo_prom        char(1),
        @w_fldeci           char(1),
        @w_tipo_ente        char(1),
        @w_rol_ente         char(1),
        @w_tipo_def         char(1),
        @w_ofi              smallint,
        @w_producto         tinyint,
        @w_tipo             char(1),
        @w_codigo           int,
        @w_personaliza      char(1),
        @w_numreg           int,
        @w_control          int,
        @w_signo            char(1),
        @w_nemo             char(4),
        @w_comision         money,
        @w_val_efe          money,
        @w_lineas           smallint,
        @w_lp_sec           int,
        @w_ciudad           int,
        @w_24h              money,
        @w_tot_24h          money,
        @w_fecha_efe        smalldatetime,
        @w_cont             tinyint,
        @w_dias_ret         tinyint,
        @w_hora_ejecucion   smalldatetime,
        @w_fecha_depo       smalldatetime


/*  Captura nombre de Stored Procedure  */
select @w_sp_name        = 'sp_nd_chq_dev_aho_ot_bancos'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select @w_hora_ejecucion = convert(varchar(5),getdate(),108)

if @i_turno is null
    select @i_turno = @s_rol

/*  Modo de debug  */
if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug @t_file=@t_file
    select  '/**  Stored Procedure  **/ ' = @w_sp_name,
            t_file      = @t_file,
            t_from      = @t_from,
            i_cta_banco = @i_ctadb,
            i_cta_int   = @i_cta_int,
            i_producto  = @i_producto,
            i_bco       = @i_bco,
            i_ofi       = @i_ofi,
            i_par       = @i_par,
            i_ctachq    = @i_ctachq,
            i_nchq      = @i_nchq,
            i_valch     = @i_valch,
            i_tipchq    = @i_tipchq,
            i_mon       = @i_mon,
            i_factor    = @i_factor,
            i_fecha     = @i_fecha
    exec cobis..sp_end_debug
end

/* Determina el nemonico de la Transaccion */
select @w_nemo = tn_nemonico
  from cobis..cl_ttransaccion
 where tn_trn_code = @t_trn

/* Determina el signo */
if @i_factor = 1
   select @w_signo = 'D'
else
   select @w_signo = 'C', @w_nemo = 'CORR'

/*** Este valor se devuelve en el sp_fecha_habil   ***/
--Determinar el codigo de la ciudad de la compensacion
--select @w_ciudad = of_ciudad
--from cobis..cl_oficina
--where of_oficina = @s_ofi
--
--if @@rowcount <> 1
--begin
--      exec cobis..sp_cerror
--           @t_debug     = @t_debug,
--           @t_file      = @t_file,
--           @t_from      = @w_sp_name,
--          @i_num       = 201094
--      return 1
--end

/* Determinar el numero de dias de retencion para la ciudad */

select @w_dias_ret = rl_dias
from cob_ahorros..ah_retencion_locales
where rl_agencia = @s_ofi
and @w_hora_ejecucion between rl_hora_inicio and rl_hora_fin


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



--  /* Determinar la fecha de efectivizacion del deposito */
--  select @w_fecha_efe = dateadd(dd,@w_dias_ret,@i_fecha),
--   @w_cont = 0

--  while @w_cont = 0
--  if exists (select 1
--      from cobis..cl_dias_feriados
--      where df_ciudad = @w_ciudad
--      and df_fecha = @w_fecha_efe)
--
--         select @w_fecha_efe = dateadd(dd,1,@w_fecha_efe)
--  else
--         select @w_cont = 1

/*** La determinacion del siguiente dia laboral  se             ****/
/*** hace mediante el llamado al siguiente sp  - JLOYO          ****/
    exec @w_return = cob_remesas..sp_fecha_habil
            @i_val_dif   = 'N',
            @i_efec_dia  = 'S',
            @i_fecha     = @i_fecha,
            @i_oficina   =  @s_ofi,
            @i_dif       = 'N',              /**** Ingreso en  horario diferido  ***/
            @w_dias_ret  = @w_dias_ret,      /*** Dia siguiente habil            ***/
            @o_ciudad    = @w_ciudad    out,
            @o_fecha_sig = @w_fecha_efe out

    if @w_return <> 0
        return @w_return


/* Encuentra los decimales a utilizar */
select @w_fldeci = mo_decimales
  from cobis..cl_moneda
 where mo_moneda = @i_mon

if @w_fldeci = 'S'
   select @w_numdeci = pa_tinyint
     from cobis..cl_parametro
    where pa_producto = 'AHO'
      and pa_nemonico = 'DCI'
else
   select @w_numdeci = 0

/*  Determinacion de bloqueo de cuenta  */

select  @w_tipo_bloqueo = cb_tipo_bloqueo
  from  cob_ahorros..ah_ctabloqueada
 where  cb_cuenta = @i_cta_int
   and  cb_estado = 'V'
   and  (cb_tipo_bloqueo = '2'
    or  cb_tipo_bloqueo = '3')
if @@rowcount <> 0
begin
    select @w_mensaje = rtrim (valor)
        from cobis..cl_catalogo
        where tabla = (select codigo from cobis..cl_tabla  /* EGA10AGO95 */
                where tabla = 'ah_tbloqueo')
        and codigo = @w_tipo_bloqueo
        select @w_mensaje = 'Cuenta bloqueada: ' + @w_mensaje
        exec cobis..sp_cerror
            @t_debug    = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 201008,
            @i_sev          = 1,
            @i_msg          = @w_mensaje
        return 1
end

/* Calcular el saldo */
exec @w_return = cob_ahorros..sp_ahcalcula_saldo
        @t_debug            = @t_debug,
        @t_file             = @t_file,
        @t_from             = @w_sp_name,
        @i_cuenta           = @i_cta_int,
        @i_fecha            = @i_fecha,
        @o_saldo_para_girar = @w_saldo_para_girar out,
        @o_saldo_contable   = @w_saldo_contable out
if @w_return <> 0
    return @w_return

 /* Encuentra datos de trabajo de la cuenta */
 select @o_nombre        = substring(ah_nombre,1,30),
        @w_24h           = ah_24h,
        @w_disponible    = ah_disponible,
        @w_promedio1     = ah_promedio1,
        @w_promdisp      = ah_prom_disponible,
        @o_categoria     = ah_categoria,
        @w_tipo_ente     = ah_tipocta,
        @w_rol_ente      = ah_rol_ente,
        @w_tipo_def      = ah_tipo_def,
        @o_prod_banc     = ah_prod_banc,
        @w_producto      = ah_producto,
        @w_tipo          = ah_tipo,
        @w_codigo        = ah_default,
        @w_personaliza   = ah_personalizada,
        @w_tipo_prom     = ah_tipo_promedio,
        @w_lineas        = ah_linea,
        @w_ofi           = ah_oficina,
        @o_tipocta_super = ah_tipocta_super
   from cob_ahorros..ah_cuenta
  where ah_cuenta = @i_cta_int

if @w_tipo_ente = 'I'
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


   /* Encuentra alicuota del Promedio  */
   select  @w_alicuota      = fp_alicuota
     from  cob_ahorros..ah_fecha_promedio
    where  fp_tipo_promedio = @w_tipo_prom
      and  fp_fecha_inicio  = @i_fecha
   if @@rowcount = 0
   begin
        exec cobis..sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 251012,
            @i_msg          = @w_mensaje
        return 1
   end

/* Genera numero de Control para linea de libreta */
exec @w_return = cobis..sp_cseqnos
            @t_debug        = @t_debug,
            @t_file         = @t_file,
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
     where tabla = 'ah_control'
        if @@rowcount = 0
    begin
             exec cobis..sp_cerror
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 255005
         return 1
        end
end

select @i_cau = ltrim(rtrim(@i_cau))

/* Genera numero de linea Pendiente */
   select @w_lineas = @w_lineas + 1
exec @w_return = cobis..sp_cseqnos
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_tabla        = 'ah_lpendiente',
            @o_siguiente    = @w_lp_sec out
if @w_return <> 0
      return @w_return
if @w_lp_sec  > 2147483640
begin
    select @w_lp_sec  = 1
    update cobis..cl_seqnos
       set siguiente = @w_lp_sec
     where tabla = 'ah_lpendiente'
        if @@error <> 0
    begin
            exec cobis..sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 105001
       return 1
        end
end

if @s_org = 'S'
   select @w_ssn_corr = @p_rssn_corr
else
   select @w_ssn_corr = @t_ssn_corr

/* Validar Fondos */
 select @w_fecha_depo = cd_fecha_depo
  from cob_ahorros..ah_ciudad_deposito
 where cd_cuenta = @i_cta_int
   and cd_ciudad = @w_ciudad
   and cd_fecha_efe = @w_fecha_efe

 select @w_tot_24h = cd_valor_efe
 from   cob_ahorros..ah_ciudad_deposito
 where  cd_cuenta     = @i_cta_int
 and    cd_ciudad     = @w_ciudad
 and    cd_fecha_depo = @w_fecha_depo
 and    cd_fecha_efe  = @w_fecha_efe

if @@rowcount = 0
begin
        exec cobis..sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 201254
        return 1
end

begin tran
select @w_val_efe = @i_valch
if @i_factor = 1
begin
        if @w_val_efe <= @w_24h
            select @w_24h = @w_24h - @w_val_efe
    else
    begin
        exec cobis..sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 201255
        return 1
    end

    if @w_val_efe <= @w_tot_24h
        select @w_tot_24h = @w_tot_24h - @w_val_efe
    else
    begin
        exec cobis..sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 201231
        return 1
    end

end
else
        select @w_24h = @w_24h + @w_val_efe,
           @w_tot_24h = @w_tot_24h + @w_val_efe

/* Actualizacion de tabla de cuentas de ahorros */
select @w_alic = convert (money, round((@w_val_efe * @w_alicuota),
              @w_numdeci))
--select @w_promedio1 = @w_promedio1 - @w_alic  * @i_factor  El promedio es sobre el disponible no sobre el contable

update cob_ahorros..ah_cuenta
   set ah_promedio1       = @w_promedio1,
       ah_24h             = @w_24h,
       ah_fecha_ult_mov   = @i_fecha,
       ah_debitos         = ah_debitos + @w_val_efe * @i_factor,
       ah_debitos_hoy     = ah_debitos_hoy + @w_val_efe * @i_factor,
       ah_contador_trx    = ah_contador_trx + @i_factor,
       ah_linea           = @w_lineas
 where ah_cuenta = @i_cta_int
 if @@rowcount <> 1
 begin
      exec cobis..sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 205001
      return 1
 end

select @o_sldcont = @w_saldo_contable - @w_val_efe * @i_factor
select @o_slddisp = @w_disponible
select @o_val_deb = @w_val_efe

/* Inserta en Lineas Pendientes */
if @w_val_efe <> 0
begin
        insert into cob_ahorros..ah_linea_pendiente
                    (lp_cuenta, lp_linea, lp_nemonico, lp_valor,
                     lp_fecha, lp_control, lp_signo, lp_enviada)
             values (@i_cta_int, @w_lp_sec, @w_nemo, @w_val_efe,
                     @i_fecha, @w_control, @w_signo, 'N')
        if @@rowcount <> 1
        begin
             exec cobis..sp_cerror
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 205001
             return 1
        end
end

if @t_rty <> 'S'
begin
   if @i_factor = 1
   begin
    /* Insert en tabla re_cheque_rec */
    exec @w_return = cobis..sp_cseqnos
        @t_debug            = @t_debug,
        @t_file             = @t_file,
        @t_from             = @w_sp_name,
        @i_tabla            = 're_cheque_rec',
        @o_siguiente        = @w_numreg out
    if @w_return <> 0
      return @w_return

    /* Genera registro de cheque devuelto en tabla re_cheque_rec */
    insert into cob_remesas..re_cheque_rec
       (cr_cheque_rec, cr_fecha_ing, cr_status, cr_cta_depositada,
        cr_valor, cr_banco_p, cr_oficina_p, cr_ciudad_p,
        cr_cta_girada, cr_num_cheque, cr_oficina, cr_procedencia,
        cr_producto, cr_moneda, cr_cau_devolucion, cr_tipo_cheque,
        cr_estado, cr_num_papeleta)
    values  (@w_numreg, @i_fecha, 'D', @i_cta_int,
        @w_val_efe, @i_bco, @i_ofi, @i_par,
        @i_ctachq, @i_nchq, @s_ofi, 'V',
        @i_producto, @i_mon, @i_cau, @i_tipchq,
        'P', @s_ssn_branch)
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug        = @t_debug,
        @t_file         = @t_file,
        @t_from         = @w_sp_name,
        @i_num          = 203000
      return 1
    end
   end
   else
   begin
    delete cob_remesas..re_cheque_rec
     where cr_cta_depositada = @i_cta_int
       and cr_fecha_ing      = @i_fecha
       and cr_banco_p        = @i_bco
       and cr_num_cheque     = @i_nchq
       and cr_cta_girada     = @i_ctachq
       and cr_valor          = @i_valch
       and cr_status     = 'D'
       and cr_cau_devolucion = @i_cau
       and cr_producto       = @i_producto
       and cr_moneda         = @i_mon
       and cr_oficina    = @s_ofi
       and cr_num_papeleta   = @t_ssn_corr

    if @@error <> 0
    begin
          exec cobis..sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 207005
          return 1
    end
   end

   /* Actualizacion de ciudad deposito */
   update cob_ahorros..ah_ciudad_deposito
      set cd_valor_efe = @w_tot_24h
    where cd_cuenta = @i_cta_int
      and cd_ciudad = @w_ciudad
      and cd_fecha_depo = @i_fecha
      and cd_fecha_efe = @w_fecha_efe

   if @@error <> 0
   begin
      exec cobis..sp_cerror
        @t_debug        = @t_debug,
        @t_file         = @t_file,
        @t_from         = @w_sp_name,
        @i_num          = 205049
      return 1
   end

  if @i_factor = 1
  begin
   /* Genera el reentry para el debito de comision por cheque devuelto */
      exec @w_return = cob_remesas..sp_genera_costos
                @i_filial   = @i_filial,
                @i_oficina  = @w_ofi,
                @i_categoria    = @o_categoria,
                @i_tipo_ente    = @w_tipo_ente,
                @i_rol_ente     = @w_rol_ente,
                @i_tipo_def     = @w_tipo_def,
                @i_prod_banc    = @o_prod_banc,
                @i_producto     = @w_producto,
                @i_moneda       = @i_mon,
                @i_tipo         = @w_tipo,
                @i_codigo       = @w_codigo,
                @i_servicio     = 'CDEV',
                @i_rubro        = '11',
                @i_fecha         = @i_fecha,
                @i_disponible   = @w_disponible,
                @i_contable     = @w_saldo_contable,
                @i_promedio     = @w_promedio1,
                @i_promdisp     = @w_promdisp,
                @i_personaliza  = @w_personaliza,
                @o_valor_total  = @w_comision out

     if @w_return <> 0
        return @w_return
   end
   else -- FACTOR  = -1: reverso
   begin
          /* BUSCAR LO QUE SE COBRO POR COMISION */
          select @w_comision = fv_costo
          from cob_ahorros..ah_fecha_valor
          where fv_transaccion = @t_trn
            and fv_cuenta      = @i_cta_int
            and fv_referencia  = convert (varchar(24), @t_ssn_corr)
            and fv_rubro       = '4'

          if @@rowcount > 1
            begin
                /* NO EXISTE REGISTRO DE REGULARIZACION */
                exec cobis..sp_cerror
                     @t_debug        = @t_debug,
                     @t_file         = @t_file,
                     @t_from         = @w_sp_name,
                     @i_num          = 251075
                return 251075
            end
          if @w_comision is null
                select @w_comision = 0
   end
   select @w_clave1 = 0,
          @w_clave2 = 0

   select @o_comision = @w_comision

   /* COBRO DE LA COMISION RESPECTIVA */
   if @w_comision > 0
   begin
      exec @w_return = cob_ahorros..sp_ahndc_automatica
           @s_srv          = @s_srv,
           @s_ofi          = @s_ofi,
           @s_ssn          = @s_ssn,
           @s_ssn_branch   = @s_ssn_branch,  -- Branch II
           @s_user         = @s_user,
           @s_term         = @s_term,
           @s_rol          = @s_rol,
           @t_trn          = 264,
           @t_corr         = @t_corr,
           @t_ssn_corr     = @t_ssn_corr,
           @t_debug        = @t_debug,
           @t_file         = @t_file,
           @t_from         = @w_sp_name,
           @i_cta          = @i_ctadb,
           @i_val          = @w_comision,
           @i_cau          = '4',
           @i_mon          = @i_mon,
           @i_dpto         = @i_dpto,
           @i_fecha        = @i_fecha,
           @i_alt          = 10,
           @i_imp          = 'S',
           @i_turno        = @i_turno
      if @w_return <> 0
         return @w_return

      if @t_corr = 'N'
      begin
        insert into cob_ahorros..ah_fecha_valor
      (fv_transaccion, fv_cuenta, fv_referencia,
       fv_rubro, fv_costo)
        values (@t_trn, @i_cta_int, convert (varchar(24), @s_ssn_branch),
           '4', @w_comision)
        if @@error <> 0
        begin
          /* ERROR EN INSERCION DE REGISTRO DE REGULARIZACION */
          exec cobis..sp_cerror
              @t_debug        = @t_debug,
                   @t_file         = @t_file,
                   @t_from         = @w_sp_name,
                   @i_num          = 253012
              return 253012
        end
      end
      else -- REVERSO DE LA TRANSACCION
      begin
        delete cob_ahorros..ah_fecha_valor
         where fv_transaccion = @t_trn
           and fv_cuenta = @i_cta_int
       and fv_referencia = convert (varchar(24), @t_ssn_corr)
       and fv_rubro = '4'
        if @@error <> 0
        begin
          /* ERROR EN ELIMINACION REGISTRO DE REGULARIZACION */
          exec cobis..sp_cerror
                     @t_debug        = @t_debug,
                     @t_file         = @t_file,
                     @t_from         = @w_sp_name,
                     @i_num          = 257003
          return 257003
        end
      end
  end -- FIN DEL if @w_comision > 0

   select @o_clave1 = @w_clave1,
          @o_clave2 = @w_clave2
end

-- Inicio CAMBIOS BRANCHII
   if @t_ejec = 'R'
   begin
      exec @w_return = cob_ahorros..sp_resultados_branch_ah
                        @i_cuenta       = @i_cta_int,
                        @i_fecha        = @s_date,
                        @i_ofi          = @s_ofi,
                        @i_tipo_cuenta  = 'O'
       if @w_return <> 0
         return @w_return
   end
-- Fin CAMBIOS BRANCHII

commit tran
return 0

go

