/************************************************************************/
/*      Archivo:            reingreso_chq_ah.sp                         */
/*      Stored procedure:   sp_reingreso_chq_ah                         */
/*      Base de datos:      cob_ahorros                                 */
/*      Producto:           Cuentas Corrientes                          */
/*      Disenado por:       Jaime Hidalgo                               */
/*      Fecha de escritura: 12-Jun-2002                                 */
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
/*      Este programa procesa la transaccion de reingreso de cheques    */
/*      en Cuentas de Ahorros (2do Proc)                                */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA          AUTOR           RAZON                            */
/*      29/Jun/2002   J. Hidalgo  Emision Inicial                       */
/*      17/Feb/2010   J. Loyo     Manejo de la fecha de efectivizacion  */
/*                                teniendo el sabado como habil         */
/*      02/Mayo/2016  Juan Tagle  Migración a CEN                       */
/************************************************************************/

use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_reingreso_chq_ah')
    drop proc sp_reingreso_chq_ah
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_reingreso_chq_ah (
        @s_ssn      int,
        @s_ssn_branch   int,
        @s_srv          varchar(30),
        @s_lsrv         varchar(30),
        @s_user     varchar(30),
        @s_sesn         int=null,
        @s_term     varchar(10),
        @s_date     datetime,
        @s_ofi      smallint,   /* Localidad origen transaccion */
        @s_rol      smallint,
        @s_org_err  char(1) = null, /* Origen de error: [A], [S] */
        @s_error    int = null,
        @s_sev          tinyint = null,
        @s_msg      mensaje = null,
        @s_org      char(1),
        @t_ejec     char(1) = 'N',
        @t_user         varchar(30) = null,
        @t_term         varchar(30) = null,
        @t_srv          varchar(30) = null,
        @t_ofi          smallint     = null,
        @t_rol          smallint     = null,
        @t_corr     char(1) = 'N',
        @t_ssn_corr int = null, /* Trans a ser reversada */
        @t_debug    char(1) = 'N',
        @t_file     varchar(14) = null,
        @t_from     varchar(32) = null,
        @t_rty      char(1) = 'N',
        @t_trn      smallint,
        @t_show_version  bit = 0,
        @p_lssn     int = null,
        @p_rssn     int = null,
        @p_rssn_corr    int = null,
        @p_slddisp  money   = null,
        @p_sldcont  money   = null,
        @p_nombre   varchar(30) = null,
        @p_envio    char(1) = 'N',
        @p_rpta         char(1) = 'N',
        @i_fecha    datetime,
        @i_mon          tinyint,
        @i_cta_banco    cuenta,
        @i_banco    smallint,
        @i_cta_chq  cuenta,
        @i_chq      int,
        @i_val      money,
        @i_cau      varchar(3),
        @i_sld_caja money       = 0,
        @i_idcierre int         = 0,
        @i_filial   smallint    = 1,
        @i_idcaja   int         = 0,
        @i_turno    smallint = null,
        @o_sldcont      money out,
        @o_slddisp      money out,
        @o_oficina      smallint = null out,
        @o_flag     float out,
        @o_prod_banc    smallint = null out,
        @o_categoria    char(1) = null out,
        @o_nombre   varchar(30) out,
        @o_ssn          int = null out,
        @o_tipocta_super    char(1) = null out
)
as

declare @w_return       int,
        @w_ssn_corr             int,
        @w_sp_name      varchar(30),
        @w_disponible           money,
        @w_saldo_para_girar     money,
        @w_saldo_contable       money,
        @w_prod_banc            smallint,
        @w_oficina      smallint,
        @w_cuenta       int,
        @w_filial       tinyint,
        @w_factor       int,
        @w_estado           varchar(1),
        @w_signo        char(1),
        @w_est          char(1),
        @w_num_dias_ret     tinyint,
        @w_reservas_locales money,
        @w_diferencia       money,
        @w_producto     tinyint,
        @w_numreg       int,
        @w_alicuota             float, --
        @w_alic         money,
        @w_promedio1            money,
        @w_prom_disp            money,
        @w_12h                  money,
        @w_24h          money,
        @w_flag                 float,
        @w_valor                money,
        @w_numdeci              tinyint,
        @w_mensaje      mensaje,
        @w_tipo_bloqueo     varchar(3),
        @w_tipo_prom        char(1),
        @w_fldeci       char(1),
        @w_categoria            char(1),
        @w_tipo_ente            char(1),
        @w_rol_ente             char(1),
        @w_tipo_def             char(1),
        @w_tipo                 char(1),
        @w_codigo               int,
        @w_personaliza          char(1),
        @w_comision     money,
        @w_debmes       money,
        @w_debhoy       money,
        @w_sldcont              money,
        @w_slddisp              money,
        @w_nombre               varchar(30),
        @w_val_mon              money,
        @w_val_ser              money,
        @w_sus_flag             tinyint,
        @w_bco          smallint,
        @w_corr         char(1),
        @w_ciudad               int,
        @w_cont                 tinyint,
        @w_fecha_efe            smalldatetime,
        @w_fecha_depo           smalldatetime,
        @w_nueva_fecha_depo     smalldatetime,
        @w_deploc_antes_hoy money,
        @w_val_consigna     money,
        @w_referencia       varchar(20)

/*  Captura nombre de Stored Procedure  */
select @w_sp_name = 'sp_reingreso_chq_ah'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

-- Determinar si la transaccion es ejecutada por el REENTRY del SAIP
if @t_user is not null
begin
    select @s_user = @t_user,
           @s_term = @t_term,
           @s_srv  = @t_srv,
           @s_ofi  = @t_ofi,
           @s_rol  = @t_rol
end

select @o_ssn = @s_ssn

/*  Modo de debug  */
if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug @t_file=@t_file
    select  '/**  Stored Procedure  **/ ' = @w_sp_name,
        t_file      = @t_file,
        t_from      = @t_from,
        i_mon       = @i_mon,
        i_cta_banco = @i_cta_banco,
        i_banco     = @i_banco,
        i_cta_chq   = @i_cta_chq,
        i_chq       = @i_chq,
        i_valor     = @i_val,
        i_cau       = @i_cau,
        i_sld_caja  = @i_sld_caja,
        i_idcierre  = @i_idcierre,
        i_filial    = @i_filial,
        i_idcaja    = @i_idcaja
    exec cobis..sp_end_debug
end

/*  Modo de correccion  */
if @t_corr = 'N'
   select @w_factor = 1, @w_signo = 'C', @w_estado = null
else
   select @w_factor = -1, @w_signo = 'D', @w_estado = 'R'


/* Chequeo de errores generados remotamente */
if @s_org_err is not null           /*  Error del Sistema  */
begin
        exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = @s_error,
               @i_sev          = @s_sev,
               @i_msg          = @s_msg
        return @s_error
end

/* Determinar el codigo de banco */
select @w_bco = pa_smallint
  from cobis..cl_parametro
 where pa_producto = 'CTE'
   and pa_nemonico = 'CBCO'
if @@rowcount = 0
begin
      exec cobis..sp_cerror
           @i_num       = 201196
      return 201196
end

/* Encuentra los decimales a utilizar */
select @w_fldeci = mo_decimales
  from cobis..cl_moneda
 where mo_moneda = @i_mon

if @w_fldeci = 'S'
begin
   select @w_numdeci = pa_tinyint
     from cobis..cl_parametro
    where pa_producto = 'CTE'
      and pa_nemonico = 'DCI'
   if @@rowcount <> 1
   begin
      exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 201196
      return 201196
   end
end
else
   select @w_numdeci = 0

--Determinar el codigo de la ciudad de la compensacion
select @w_ciudad = of_ciudad
from cobis..cl_oficina
where of_oficina = @s_ofi

if @i_turno is null
    select @i_turno = @s_rol

/* Encuentra datos de trabajo de la cuenta */
select  @w_tipo_prom     = ah_tipo_promedio,
    @w_12h           = ah_12h,
    @w_promedio1     = ah_promedio1,
    @w_prom_disp     = ah_prom_disponible,
    @w_categoria     = ah_categoria,
    @w_tipo_ente     = ah_tipocta,
    @w_rol_ente      = ah_rol_ente,
    @w_tipo_def      = ah_tipo_def,
    @w_tipo          = ah_tipo,
    @w_codigo        = ah_default,
    @w_personaliza   = ah_personalizada,
    @w_debmes    = ah_debitos,
    @w_debhoy    = ah_debitos_hoy,
    @w_est       = ah_estado,
    @w_reservas_locales = ah_24h,
    @w_cuenta    = ah_cuenta,
    @w_disponible    = ah_disponible,
    @w_prod_banc     = ah_prod_banc,
    @w_producto      = ah_producto,
    @o_tipocta_super = ah_tipocta_super,
    @o_prod_banc     = ah_prod_banc,
    @o_categoria     = ah_categoria,
    @o_nombre    = substring(ah_nombre,1,30)
     from  cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta_banco
      and  ah_estado <> 'G'     /* Cuenta de Gerencia */

  if @w_est <> 'A'
  begin
    /* Cuenta no activa o cancelada */
     exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num       = 251002
     return 251002
  end

/*  Determinacion de bloqueo de cuenta  */

select  @w_tipo_bloqueo = cb_tipo_bloqueo
  from  cob_ahorros..ah_ctabloqueada
 where  cb_cuenta = @w_cuenta
   and  cb_estado = 'V'
   and  (cb_tipo_bloqueo = '2'
    or  cb_tipo_bloqueo = '3')
if @@rowcount <> 0
begin
    select @w_mensaje = rtrim (valor)
        from cobis..cl_catalogo
        where tabla = (select codigo from cobis..cl_tabla
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
        return 201008
end


/* Determinacion de vigencia de la cuenta  */
exec @w_return = cob_ahorros..sp_ctah_vigente
    @t_debug    = @t_debug,
        @t_file     = @t_file,
    @t_from     = @w_sp_name,
    @i_cta_banco    = @i_cta_banco,
    @i_moneda   = @i_mon,
    @o_filial   = @w_filial out,
    @o_oficina  = @w_oficina out,
    @o_cuenta   = @w_cuenta out


if @w_return <> 0
    return @w_return

if @s_org = 'S'
   select @w_ssn_corr = @p_rssn_corr
else
   select @w_ssn_corr = @t_ssn_corr


   /* Calcular el saldo */
   exec @w_return = cob_ahorros..sp_ahcalcula_saldo
        @t_debug            = @t_debug,
        @t_file             = @t_file,
        @t_from             = @w_sp_name,
                @i_cuenta           = @w_cuenta, --@i_cta_banco,
                @i_fecha            = @s_date,
                @i_ofi              = @s_ofi,
        @o_saldo_para_girar = @w_saldo_para_girar out,
        @o_saldo_contable   = @w_saldo_contable out
   if @w_return <> 0
      return @w_return


  select @w_num_dias_ret = pa_tinyint
  from cobis..cl_parametro
  where pa_producto = 'CTE'
  and pa_nemonico = 'DCR'

  if @@rowcount <> 1
  begin
    /* Error en lectura de numero de dias */
    exec cobis..sp_cerror
         @i_num       = 111020,
         @i_msg       = 'ERROR EN PARAMETRO NUM. DIAS DE RETENCION'
    return 111020
  end


            /****PEDRO COELLO MODIFICA EL CALCULO DE DIAS DE HOLD ****/
--            select @w_fecha_efe = dateadd(dd,1,@i_fecha),
--                   @w_cont = 1

--            while @w_cont <= @w_num_dias_ret
--                if exists (select 1
--                             from cobis..cl_dias_feriados
--                          where df_ciudad = @w_ciudad
--                              and df_fecha  = @w_fecha_efe)
--                  select @w_fecha_efe = dateadd(dd,1,@w_fecha_efe)
--                else
--                begin
--                      select @w_cont = @w_cont + 1
--                if @w_cont <= @w_num_dias_ret
--                         select @w_fecha_efe = dateadd(dd,1,@w_fecha_efe)
--                end

/*** La determinacion del siguiente dia laboral  se             ****/
/*** hace mediante el llamado al siguiente sp  - JLOYO          ****/
    exec @w_return = cob_remesas..sp_fecha_habil
            @i_val_dif  = 'N',
            @i_efec_dia = 'S',
            @i_fecha    = @i_fecha,
            @i_oficina  =  @s_ofi,
            @i_dif  = 'N',               /**** Ingreso en  horario normal  ***/
            @w_dias_ret = @w_num_dias_ret,   /*** Dia siguiente habil          ***/
            @o_ciudad   = @w_ciudad    out,
            @o_fecha_sig= @w_fecha_efe out

    if @w_return <> 0
        return @w_return


  if @w_factor = -1
  begin
     if exists (select 1 from cob_ahorros..ah_tran_servicio
                 where ts_moneda    = @i_mon
                   and ts_estado    is null
           and ts_ssn_branch    = @t_ssn_corr
           and ts_oficina       = @s_ofi
               and ts_tipo_transaccion     = @t_trn
                   and ts_cta_banco     = @i_cta_banco
                   and ts_valor     = @i_val
                   and ts_usuario   = @s_user)
        select @t_debug = 'N'
     else
     begin  /* No encontro el registro en monetarias */
           exec cobis..sp_cerror
                  @t_debug     = @t_debug,
                  @t_file      = @t_file,
                  @t_from      = @w_sp_name,
                  @i_num       = 208020
           return 208020
    end
  end

   /* Encuentra alicuota del promedio */
   select  @w_alicuota      = fp_alicuota
     from  cob_ahorros..ah_fecha_promedio
    where  fp_tipo_promedio = @w_tipo_prom
      and  fp_fecha_inicio  = @s_date
   if @@rowcount = 0
   begin
        exec cobis..sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 201060
        return 201060
   end


begin tran

   /* Busqueda de existencia de transacciones a ser efectivizadas hoy */


  /* Busqueda de existencia de transacciones a ser efectivizadas hoy */


    select @w_fecha_depo = cd_fecha_depo
    from cob_ahorros..ah_ciudad_deposito
    where cd_fecha_efe = @i_fecha
    and cd_cuenta = @w_cuenta
    and isnull(cd_efectivizado, 'N') = 'N'
    and cd_ciudad = @w_ciudad
        and cd_valor_efe >= @i_val

        if @@rowcount = 0
         begin
         exec cobis..sp_cerror
             @t_debug        = @t_debug,
             @t_file         = @t_file,
             @t_from         = @w_sp_name,
             @i_num          = 201290
         return 201290
     end
        else
          begin

        select @w_val_consigna = @w_12h - @i_val

        if @w_val_consigna >= 0
        begin

           /* Actualizo Maestro de cuentas */
            update cob_ahorros..ah_cuenta
            set ah_12h = ah_12h - @i_val,
                ah_24h = ah_24h + @i_val
            where ah_cuenta = @w_cuenta


                 /* Actualizo Ciudad deposito para Fecha Actual */

                update cob_ahorros..ah_ciudad_deposito
                        set   cd_valor_efe  = cd_valor_efe - (@i_val * @w_factor)
            where cd_cuenta     = @w_cuenta
            and   cd_ciudad     = @w_ciudad
            and   cd_fecha_efe  = @i_fecha
                and   cd_fecha_depo = @w_fecha_depo

            if @@error <> 0
                  begin
                 exec cobis..sp_cerror
                      @t_debug        = @t_debug,
                      @t_file         = @t_file,
                      @t_from         = @w_sp_name,
                      @i_num          = 205052
                 return 205052
                  end

                 /* Actualizo o Inserto Ciudad deposito para Nueva Fecha  */

                select @w_nueva_fecha_depo = cd_fecha_depo
                         from cob_ahorros..ah_ciudad_deposito
                        where cd_cuenta = @w_cuenta
                          and cd_ciudad = @w_ciudad
                          and cd_fecha_efe  = @w_fecha_efe

                if @@rowcount = 0
                begin
                   insert into cob_ahorros..ah_ciudad_deposito
                       (cd_cuenta, cd_ciudad, cd_fecha_depo,
                      cd_fecha_efe, cd_valor, cd_valor_efe)
                    values (@w_cuenta, @w_ciudad, @i_fecha,
                      @w_fecha_efe, @i_val, @i_val)

                    if @@error <> 0
                    begin
                         exec cobis..sp_cerror
                                @t_debug        = @t_debug,
                                @t_file         = @t_file,
                                @t_from         = @w_sp_name,
                                @i_num          = 203069
                         return 203069
                    end

                     end
                     else
                     begin
                    update cob_ahorros..ah_ciudad_deposito
                                set cd_valor_efe = cd_valor_efe + (@i_val * @w_factor),
                                cd_valor = cd_valor + (@i_val * @w_factor)
                    where cd_cuenta     = @w_cuenta
                    and cd_ciudad     = @w_ciudad
                    and cd_fecha_efe  = @w_fecha_efe
                and cd_fecha_depo = @w_nueva_fecha_depo

                    if @@error <> 0
                    begin
                        exec cobis..sp_cerror
                             @t_debug        = @t_debug,
                             @t_file         = @t_file,
                             @t_from         = @w_sp_name,
                             @i_num          = 205052
                        return 205052
                    end
                     end
        end /* if @w_val_consigna >= 0 */
        else /* El monto paso al disponible */
        begin

              exec cobis..sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 201291
          return 201291


        end /* del else */
      end /*Del rowcount = 0 */



if @w_factor = 1  /* Modo Normal */
begin

/* Insercion en tabla re_cheque_rec */
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
     cr_valor, cr_banco_p, cr_oficina_p,
     cr_cta_girada, cr_num_cheque, cr_oficina, cr_procedencia,
     cr_producto, cr_moneda, cr_cau_devolucion, cr_tipo_cheque,
     cr_estado, cr_num_papeleta)
    values  (@w_numreg, @s_date, 'R', @w_cuenta,
         @i_val, @i_banco, @s_ofi,
         @i_cta_chq, @i_chq, @s_ofi, 'V',
         @w_producto, @i_mon, @i_cau, 'R',
         'P', @s_ssn)
    if @@error <> 0
       begin
          exec cobis..sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 203000
          return 203000
       end
end
else /* Correccion */
begin
    /* Eliminacion de registro de re_cheque_rec */
    delete cob_remesas..re_cheque_rec
     where cr_cta_depositada = @w_cuenta
       and cr_fecha_ing = @s_date
       and cr_banco_p = @i_banco
       and cr_cta_girada = @i_cta_chq
       and cr_num_cheque = @i_chq
       and cr_valor = @i_val
       and cr_status = 'R'
       and cr_cau_devolucion = @i_cau
       and cr_producto = @w_producto
       and cr_moneda = @i_mon
       and cr_num_papeleta = @w_ssn_corr

       if @@error <> 0
       begin
          exec cobis..sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 207005
          return 207005
       end
end

select @w_referencia = convert(varchar(20), @i_chq)

if @s_org = 'S'
begin


        /*  Transaccion de servicio */
    insert into cob_ahorros..ah_tran_servicio
        (ts_secuencial, ts_ssn_branch, ts_cod_alterno, ts_tipo_transaccion, ts_oficina,
         ts_usuario, ts_terminal, ts_correccion,
         ts_sec_correccion, ts_reentry, ts_origen,
         ts_nodo, ts_tsfecha, ts_cta_banco, --tm_signo,
         ts_causa, ts_valor,
         ts_remoto_ssn, ts_moneda, ts_cheque, --tm_banco,
                 ts_oficina_cta, ts_filial, ts_estado,
         ts_saldo,--_contable, ts_saldo_disponible,
         ts_prod_banc, ts_categoria,
         ts_tipocta_super, ts_turno)
        values (@s_ssn, @s_ssn_branch, 0, @t_trn, @s_ofi,
                @s_user, @s_term, @t_corr,
            @p_rssn_corr, @t_rty, 'R',
                @s_srv, @s_date, @i_cta_banco, --@w_signo,
        @i_cau, @i_val,
        @p_lssn, @i_mon, @i_chq,-- @i_banco,
                @w_oficina, @w_filial, @w_estado,
        @o_slddisp,
        @o_prod_banc, @o_categoria,
        @o_tipocta_super, @i_turno)

        if @@error <> 0
        begin
            exec cobis..sp_cerror
                    @t_debug    = @t_debug,
                @t_file     = @t_file,
                @t_from     = @w_sp_name,
                @i_num      = 203005
            return 203005
        end

        if @w_factor = -1
           begin
                   update cob_ahorros..ah_tran_servicio
                      set ts_estado = 'R'
                    where ts_ssn_branch = @t_ssn_corr
              and ts_oficina = @s_ofi
              and ts_cod_alterno <> 10
                          and ts_tipo_transaccion = @t_trn
              and ts_oficina = @s_ofi
                          and ts_cta_banco = @i_cta_banco
                          and ts_causa = @i_cau
                          and ts_valor = @i_val
                          and ts_moneda = @i_mon
                          and ts_usuario = @s_user
                          and ts_estado is null
                          and ts_cheque = @i_chq
                          --and ts_banco = @i_banco

                   if @@rowcount <> 1
                     begin
                       /* No encontro el registro en monetarias */
                       exec cobis..sp_cerror
                            @t_debug     = @t_debug,
                            @t_file      = @t_file,
                            @t_from      = @w_sp_name,
                            @i_num       = 205043
             return 205043
             end
       end

end
else
if @s_org = 'U'
begin
                /* Actualizacion de Totales de cajero */


        if @t_corr = 'S'
        begin
           select @w_estado = 'R',
                  @p_rssn_corr = @t_ssn_corr
        end

     insert into cob_ahorros..ah_tran_servicio
        (ts_secuencial, ts_ssn_branch, ts_cod_alterno, ts_tipo_transaccion, ts_oficina,
         ts_usuario, ts_terminal, ts_correccion,
         ts_sec_correccion, ts_reentry, ts_origen,
         ts_nodo, ts_tsfecha, ts_cta_banco, --tm_signo,
         ts_causa, ts_valor,
         ts_remoto_ssn, ts_moneda, ts_cheque, --tm_banco,
                 ts_oficina_cta, ts_filial, ts_estado,
         ts_saldo, --_contable, tm_saldo_disponible,
         ts_prod_banc, ts_categoria,
         ts_tipocta_super, ts_turno)
        values (@s_ssn, @s_ssn_branch, 0, @t_trn, @s_ofi,
                @s_user, @s_term, @t_corr,
            @p_rssn_corr, @t_rty, 'L',
                @s_srv, @s_date, @i_cta_banco, --@w_signo,
        @i_cau, @i_val,
        @p_lssn, @i_mon, @i_chq, --@i_banco,
                @w_oficina, @w_filial, @w_estado,
        @o_slddisp,
        @o_prod_banc, @o_categoria,
        @o_tipocta_super, @i_turno)

        if @@error <> 0
        begin

          exec cobis..sp_cerror
             @t_debug      = @t_debug,
             @t_file       = @t_file,
             @t_from       = @w_sp_name,
             @i_num        = 203005

          return 203005
         end

        if @w_factor = -1
           begin
                   update cob_ahorros..ah_tran_servicio
                      set ts_estado = 'R'
                    where ts_ssn_branch = @t_ssn_corr
              and ts_oficina = @s_ofi
                          and ts_cod_alterno <> 10
                          and ts_tipo_transaccion = @t_trn
              and ts_oficina = @s_ofi
                          and ts_cta_banco = @i_cta_banco
                          and ts_causa = @i_cau
                          and ts_valor = @i_val
                          and ts_moneda = @i_mon
                          and ts_usuario = @s_user
                          and ts_estado is null
                          and ts_cheque = @i_chq
                          --and tm_banco = @i_banco

                   if @@rowcount <> 1
                     begin
                       /* No encontro el registro en monetarias */
                       exec cobis..sp_cerror
                            @t_debug     = @t_debug,
                            @t_file      = @t_file,
                            @t_from      = @w_sp_name,
                            @i_num       = 205043
             return 205043
             end
       end
    /*select 'Nombre' = @o_nombre*/
--select 'Nombre' = @w_oficina
select @o_nombre = @o_nombre
end
commit tran

-- Devolucion de resultados al branch
  if @t_ejec = 'R'
  begin
    exec @w_return = cob_ahorros..sp_resultados_branch_ah
    @s_ssn_host = @s_ssn,
    @i_cuenta = @w_cuenta,
    @i_fecha = @s_date,
    @i_ofi = @s_ofi,
    @i_tipo_cuenta = 'O'

    if @w_return <> 0
    return @w_return
  end
return 0

go

