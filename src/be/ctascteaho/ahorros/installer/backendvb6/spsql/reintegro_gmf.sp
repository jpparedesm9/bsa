/***************************************************************************/
/*  Archivo:            reintegro_gmf.sp                                   */
/*  Stored procedure:   sp_reintegro_gmf                                   */
/*  Base de datos:      cob_ahorros                                        */
/*  Producto:           Cuentas de Ahorros                                 */
/*  Disenado por:       Julissa Colorado                                   */
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
/*      05/Mar/1993    Julissa Colorado       Emision Inicial              */
/*      02/Mayo/2016   Juan Tagle             Migración a CEN              */
/***************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_reintegro_gmf')
    drop proc sp_reintegro_gmf
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_reintegro_gmf (
     @s_srv               varchar(30) = null,
     @s_ofi               smallint,
     @s_ssn               int,
     @s_ssn_branch        int = null,
     @s_user              varchar(30) = 'sa',
     @s_term              varchar(10) = 'consola',
     @s_rol               smallint = null,
     @s_date              datetime,
     @t_trn               int = 253,
     @t_corr              char(1) = 'N',
     @t_ssn_corr          int = null,
     @t_debug             char(1) = 'N',
     @t_file              varchar(14) = null,
     @t_from              varchar(32) = null,
     @t_show_version      bit = 0,
     @i_turno             smallint = null,
     @i_cuenta            int,
     @i_valor             money,
     @i_mon               tinyint,
     @i_cliente           int = null,
     @i_referencia        varchar(17) = null,
     @i_canal             smallint = 4 ,
     @i_filial            smallint    = 1,
     @i_alterno           int,
     @i_factor            smallint   = 1,
     @i_nomtrn            varchar(10) = null,
     @i_is_batch          char(1) = 'N',
     @i_saldo_contable    money = 0,
     @i_linea_lib         int = 0,
     @i_control           int = 0,
     @i_posteo            char(1) = 'S',
     @i_base_gmf          money = 0,
     @i_corresponsal char(1)       = 'N'  --Req. 381 CB Red Posicionada
)
as
declare @w_return           int,
        @w_sp_name          varchar(30),
        @w_lp_sec           int,
        @w_alic_prom        float,
        @w_numdeci          tinyint,
        @w_numdeci_imp      tinyint,
        @w_disponible       money,
        @w_promedio1        money,
        @w_creditos_hoy     money,
        @w_saldo_max        money,
        @w_debitos_hoy      money,
        @w_debitos          money,
        @w_prod_banc        smallint,
        @w_saldo_para_girar money,
        @w_saldo_contable   money,
        @w_tipo_prom        char(1),
        @w_signo            char(1),
        @w_control          int,
        @w_lineas           int,
        @w_sev              int,
        @w_nemo             char(4),
        @w_nemo2            char(4),
        @w_categoria        catalogo,
        @w_mon              tinyint,
        @w_error            int,
        @w_sec              int,
        @w_mensaje          mensaje,
        @w_secuencial       int,
        @w_ssn_corr         int,
        @w_tipo_bloqueo     char(3),
        @w_usadeci          char(1),
        @w_prom_disp        money,
        @w_clase_clte       char(1),
        @w_estado           char(1),
        @w_debhoy           money,
        @w_monto_bloq       money,
        @w_contador_trx     smallint,
        @w_cont             smallint,
        @w_num_blqmonto     smallint,
        @w_oficina          smallint,
        @w_bloqueos         smallint,
        @w_numlib           int,
        @w_dep_ini          money,
        @w_tipocta_super    char(1),
        @w_creditos         money,
        @w_credhoy          money,
        @w_tasa_imp         float,
        @w_tipocta          char(1),
        @w_producto         tinyint,
        @w_act_fecha        char(1),
        @w_fecha_ult_mov    datetime,
        @w_hora_ejecucion   smalldatetime,
        @w_actualiza        char(1),
        @w_rol_ente         char(1),
        @w_tipo_def         char(1),
        @w_tipo             char(1),
        @w_personaliza      char(1),
        @w_codigo           int,
        @w_filial           tinyint,
        @w_ente             int,
        @w_ncredmes         int,
        @w_ndebmes          int,
        @w_numdeb           int,
        @w_tipocobro        char(1),
        @w_numtotcta        int,
        @w_rowcount         int,
        @w_posteo           char(1),
        @w_pro_final        smallint,
        @w_sucursal         smallint,
        @w_cliente          int,
        @w_cobro_comision_chq   money,
        @w_trn                  int,
        @w_modulo               char(3), --REQ 217
        @w_autoriza             char(1),
        @w_cta_banco            cuenta,
        @w_oper_cont            char(1),
        @w_commit               varchar(1),
        @w_msg                  varchar(250),
        @w_prod_bancario        varchar(50) --Req. 381 CB Red Posicionada

/*  Captura nombre de Stored Procedure  */
select @w_sp_name   = 'sp_reintegro_gmf',
       @w_rowcount  = 0,
       @w_sev       = 1,
       @w_act_fecha = 'S',
       @w_commit    = 'N'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

if @i_turno is null
    select @i_turno = @s_rol

IF @s_term  IS NULL
    select  @s_term = 'consola'

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
      and cb_tipo_bloqueo in ('1', '3')

   if   @@rowcount <> 0
   begin

          select @w_mensaje = rtrim(valor) from cobis..cl_catalogo
           where cobis..cl_catalogo.tabla =
                       (select cobis..cl_tabla.codigo from cobis..cl_tabla
                         where tabla = 'ah_tbloqueo')
            and cobis..cl_catalogo.codigo = @w_tipo_bloqueo
          select @w_mensaje = 'Cuenta bloqueada: ' + @w_mensaje

          select @w_error = 251025,
                 @w_msg   = 'NO EXISTE TIPO DE BLOQUEO',
                 @w_sev   = 0
         goto ERROR
   end


    /* Calcular el saldo */
    exec @w_return = cob_ahorros..sp_ahcalcula_saldo
         @t_debug            = @t_debug,
         @t_file             = @t_file,
         @t_from             = @w_sp_name,
         @i_cuenta           = @i_cuenta,
         @i_fecha            = @s_date,
         @i_ofi              = @s_ofi,
         @o_saldo_para_girar = @w_saldo_para_girar out,
         @o_saldo_contable   = @w_saldo_contable out

    if @w_return <> 0
    begin
           select @w_msg  = mensaje
             from cobis..cl_errores
           where numero = @w_return

           if @@rowcount <> 1
              select @w_msg = 'ERROR EN CALCULA SALDO '

           select @w_error = 251025,
                  @w_msg   = @w_msg,
                  @w_sev   = 0
           goto ERROR
    end


   /* Encuentra el nemonico de la transaccion */
   select @w_nemo = tn_nemonico
     from cobis..cl_ttransaccion
    where tn_trn_code = 253

   if  @i_factor = 1
   begin

        select @w_act_fecha = pr_act_fecha
          from cob_remesas..re_propiedad_ndc
         where pr_producto = 4
           and  pr_signo    = @w_signo
           and  pr_causa    = '20'

      if @@rowcount = 0
          select @w_act_fecha = 'S'
   end

--Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
select @w_prod_bancario = rtrim(cl_catalogo.codigo)
from cobis..cl_catalogo, cobis..cl_tabla
where cl_catalogo.tabla  = cl_tabla.codigo and
      cl_tabla.tabla     = 're_pro_banc_cb'
and   cl_catalogo.estado = 'V'

-- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
if @i_corresponsal = 'N'
begin
   select @w_lineas        = ah_linea,
       @w_tipo_prom     = ah_tipo_promedio,
       @w_mon           = ah_moneda,
       @w_disponible    = ah_disponible,
       @w_promedio1     = ah_promedio1,
       @w_debitos       = ah_debitos,
       @w_debhoy        = ah_debitos_hoy,
       @w_creditos      = ah_creditos,
       @w_credhoy       = ah_creditos_hoy,
       @w_prom_disp     = ah_prom_disponible,
       @w_contador_trx  = ah_contador_trx,
       @w_monto_bloq    = ah_monto_bloq,
       @w_estado        = ah_estado,
       @w_oficina       = ah_oficina,
       @w_bloqueos      = ah_bloqueos,
       @w_numlib        = ah_numlib,
       @w_fecha_ult_mov = ah_fecha_ult_mov, --LBM
       @w_prod_banc     = ah_prod_banc,
       @w_categoria     = ah_categoria,
       @w_producto      = ah_producto,
       @w_tipocta       = ah_tipocta,
       @w_clase_clte    = ah_clase_clte,
       @w_rol_ente      = ah_rol_ente,
       @w_tipo          = ah_tipo,
       @w_tipo_def      = ah_tipo_def,
       @w_codigo        = ah_default,
       @w_personaliza   = ah_personalizada,
       @w_filial        = ah_filial,
       @w_ente          = ah_cliente,
       @w_ncredmes      = isnull(ah_num_cred_mes,0),
       @w_ndebmes       = isnull(ah_num_deb_mes,0),
       @w_cta_banco     = ah_cta_banco,
       @w_estado        = ah_estado,
       @w_cliente       = ah_cliente,
       @w_tipocta_super = ah_tipocta_super
   from cob_ahorros..ah_cuenta
   where ah_cuenta = @i_cuenta
   and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada
end
else
begin
   select @w_lineas        = ah_linea,
       @w_tipo_prom     = ah_tipo_promedio,
       @w_mon           = ah_moneda,
       @w_disponible    = ah_disponible,
       @w_promedio1     = ah_promedio1,
       @w_debitos       = ah_debitos,
       @w_debhoy        = ah_debitos_hoy,
       @w_creditos      = ah_creditos,
       @w_credhoy       = ah_creditos_hoy,
       @w_prom_disp     = ah_prom_disponible,
       @w_contador_trx  = ah_contador_trx,
       @w_monto_bloq    = ah_monto_bloq,
       @w_estado        = ah_estado,
       @w_oficina       = ah_oficina,
       @w_bloqueos      = ah_bloqueos,
       @w_numlib        = ah_numlib,
       @w_fecha_ult_mov = ah_fecha_ult_mov, --LBM
       @w_prod_banc     = ah_prod_banc,
       @w_categoria     = ah_categoria,
       @w_producto      = ah_producto,
       @w_tipocta       = ah_tipocta,
       @w_clase_clte    = ah_clase_clte,
       @w_rol_ente      = ah_rol_ente,
       @w_tipo          = ah_tipo,
       @w_tipo_def      = ah_tipo_def,
       @w_codigo        = ah_default,
       @w_personaliza   = ah_personalizada,
       @w_filial        = ah_filial,
       @w_ente          = ah_cliente,
       @w_ncredmes      = isnull(ah_num_cred_mes,0),
       @w_ndebmes       = isnull(ah_num_deb_mes,0),
       @w_cta_banco     = ah_cta_banco,
       @w_estado        = ah_estado,
       @w_cliente       = ah_cliente,
       @w_tipocta_super = ah_tipocta_super
   from cob_ahorros..ah_cuenta
   where ah_cuenta = @i_cuenta
end

if @w_estado in ('G','N')
begin
     select @w_error = 251099,
            @w_msg   = ' CUENTA NO VIGENTE',
            @w_sev   = 0

    goto ERROR
end


if @i_posteo = 'S'
begin

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
    and   me_pro_bancario = @w_prod_banc


   select @w_sucursal = isnull(of_regional, of_oficina)
     from   cobis..cl_oficina
    where  of_oficina = @w_oficina -- (Oficina de la cuenta)

   select @w_pro_final = pf_pro_final
     from cob_remesas..pe_pro_final, cob_remesas..pe_mercado
    where pf_mercado      = me_mercado
      and me_tipo_ente    = @w_tipocta
      and    me_pro_bancario = @w_prod_banc
      and    pf_filial       = @w_filial
      and    pf_sucursal     = @w_sucursal
      and    pf_producto     = @w_producto
      and    pf_moneda       = @w_mon
      and    pf_tipo         = @w_tipo

   if @@rowcount = 0
   begin

     select @w_error = 251099,
            @w_msg   = 'No existe producto final',
            @w_sev   = 0
    goto ERROR
   end

   select @w_posteo = cp_posteo
     from cob_remesas..pe_categoria_profinal
    where cp_profinal  = @w_pro_final
      and cp_categoria = @w_categoria

   if @w_posteo is null
        select @w_posteo = 'N'


    if @w_posteo = 'S'
    begin
           /* Genera numero de control */
      update cobis..cl_seqnos
         set siguiente = siguiente + 2
       where tabla = 'ah_control'

      select @w_control = siguiente - 1
        from cobis..cl_seqnos
       where tabla = 'ah_control'

      if @w_control > = 9997
      begin
           update cobis..cl_seqnos
              set siguiente = 2
           where tabla = 'ah_control'
          select @w_control = 0
      end
     /*  Genera numero de linea Pendiente  */
     update cobis..cl_seqnos
       set siguiente = siguiente + 2
     where tabla = 'ah_lpendiente'

     select @w_lp_sec = siguiente - 1
      from cobis..cl_seqnos
     where tabla = 'ah_lpendiente'

     if @w_lp_sec > 2147483637
     begin
          update cobis..cl_seqnos
             set siguiente = 2
           where tabla ='ah_lpendiente'

         if @@error <> 0
         begin
              select @w_error = 105001,
                     @w_sev   = 0,
                     @w_msg   = ' Error en actualizacion de seqnos'
              goto ERROR
         end
         select @w_lp_sec = 1
   end
end
end

/* Alicuota de Promedio */
select @w_alic_prom = fp_alicuota
  from ah_fecha_promedio
 where fp_tipo_promedio = @w_tipo_prom
   and fp_fecha_inicio = @s_date

if @@rowcount = 0
begin   /** Alicuota de Promedio No Existe **/
     select @w_error = 251012,
            @w_msg   = 'ERROR EN TABLA DE ALICUOTAS',
            @w_sev   = 0
    goto ERROR
end


if @i_factor = -1 and @i_valor > @w_disponible
begin
    select @w_error = 161724,
           @w_sev   = 0,
           @w_msg   = 'FONDOS DE LA CUENTA INSUFICIENTES'
    goto ERROR
end


/*

if @w_saldo_max > 0 and  (@w_saldo_contable + (@i_valor  * @i_factor) >  @w_saldo_max )
begin
    select @w_error = 252077,
           @w_sev   = 0 ,
           @w_msg   = 'EL CREDITO A LA CUENTA EXCEDE EL SALDO MAXIMO PERMITIDO'

    goto ERROR
end
*/


select @w_creditos      = @w_creditos      + @i_valor * @i_factor,
       @w_credhoy       = @w_credhoy       + @i_valor * @i_factor,
       @w_prom_disp     = @w_prom_disp     + round(((@i_valor * @w_alic_prom ) * @i_factor), @w_numdeci),
       @w_promedio1     = @w_promedio1     + round(((@i_valor * @w_alic_prom ) * @i_factor), @w_numdeci),
       @w_ncredmes      = @w_ncredmes      + ( 1 * @i_factor )



/* Inserta linea pendiente */
if @i_factor = 1
   select  @w_signo = 'C'
else
   select  @w_signo = 'D',
           @w_nemo  = 'CORR'


if @@trancount = 0
begin
    begin tran
    select @w_commit = 'S'
end


if @w_posteo = 'S'
begin
       select @w_lineas  = @w_lineas  + 1

       if @i_factor = 1
       begin
            insert into cob_ahorros..ah_linea_pendiente
                   (lp_cuenta, lp_linea,    lp_nemonico, lp_valor,
                    lp_fecha,  lp_control,  lp_signo,    lp_enviada)
            values (@i_cuenta, @w_lp_sec,    @w_nemo,     @i_valor,
                    @s_date,   @w_control,   @w_signo,    'N')


            if @@error <> 0
            begin
               select @w_error = 253002,
                      @w_sev   = 0,
                      @w_msg   = 'ERROR EN INSERCION DE LINEA PENDIENTE'
               goto ERROR
            end

       end
       else   /***  @i_factor = -1  ***/
       begin

            insert into cob_ahorros..ah_linea_pendiente
                   (lp_cuenta,   lp_linea,      lp_nemonico, lp_valor,
                    lp_fecha,    lp_control,    lp_signo,    lp_enviada)
            values (@i_cuenta,   @w_lp_sec,     @w_nemo,     @i_valor,
                    @s_date,     @w_control,    @w_signo,    'N')

            if @@error <> 0
            begin
               select @w_error = 253002,
                      @w_sev   = 0,
                      @w_msg   = 'ERROR EN INSERCION DE LINEA PENDIENTE'
               goto ERROR
            end
       end
end


    update cob_ahorros..ah_cuenta
       set ah_disponible      = @w_disponible + (@i_valor * @i_factor),
           ah_promedio1       = @w_promedio1,
           ah_prom_disponible = @w_prom_disp,
           ah_linea           = @w_lineas,
           ah_creditos        = @w_creditos,
           ah_creditos_hoy    = @w_credhoy,
           ah_fecha_ult_mov   = @w_fecha_ult_mov,
           ah_contador_trx    = ah_contador_trx + @i_factor,
           ah_num_cred_mes    = @w_ncredmes
      where  ah_cuenta = @i_cuenta

      if @@rowcount <> 1
      begin


             select @w_error = 255001,
                    @w_msg   = 'ERROR AL ACTUALIZAR CUENTA DE AHORROS'
             goto ERROR
      end

   if @i_factor = 1
   begin
          /*  Transaccion monetaria */
          insert into cob_ahorros..ah_notcredeb
                   (secuencial,        tipo_tran,              oficina,    filial,
                    usuario,           terminal,               correccion, reentry,
                    fecha,             cta_banco,              nodo,
                    origen,            valor,                  moneda,     causa,
                    signo,             alterno,                saldocont,  saldodisp,
                    oficina_cta,       prod_banc,              categoria,
                    ssn_branch,        tipocta_super,          turno,       hora,
                    canal,             cliente,                clase_clte, indicador,
                    base_gmf,          concepto)

            values (@s_ssn,            253,                    @s_ofi,     @i_filial,
                    @s_user,           @s_term,                'N',        'N',
                    @s_date,           @w_cta_banco,           @s_srv,
                    'L',               @i_valor,               @i_mon,     '20',
                    @w_signo,          @i_alterno,             @w_saldo_contable + @i_valor,
                    @w_disponible + @i_valor,
                    @w_oficina,        @w_prod_banc,           @w_categoria,
                    @s_ssn_branch,     @w_tipocta_super,       @i_turno,      getdate(),
                    @i_canal,          @w_cliente,             @w_clase_clte, 1,
                    @i_base_gmf,       'REINTEGRO DE GMF A CARGO DEL BANCO' )

          if @@error <> 0
          begin
                 select @w_error = 253000,
                        @w_msg   = 'ERROR EN INSERCION DE TRANSACCION MONETARIA'
                 goto ERROR
          end
   end
   else   /***** @i_factor <> 1 *****/
   begin

          /*  Transaccion monetaria */
          insert into cob_ahorros..ah_notcredeb
                    (secuencial,        tipo_tran,             oficina,       filial,
                     usuario,           terminal,              correccion,
                     sec_correccion,    reentry,               origen,
                     fecha,             cta_banco,             nodo,
                     valor,             moneda,                causa,
                     signo,             alterno,               saldocont,
                     saldodisp,         oficina_cta,           estado,
                     prod_banc,         categoria,             ssn_branch,
                     tipocta_super,     turno,                 hora,
                     canal,             cliente,               clase_clte,
                     indicador,         base_gmf)
             values (@s_ssn,            253,                   @s_ofi,        @i_filial,
                     @s_user,           @s_term,               'S',
                     @t_ssn_corr,       'N',                   'L',
                     @s_date,           @w_cta_banco,          @s_srv,
                     @i_valor,          @i_mon,                '20',
                     @w_signo,          @i_alterno,            @w_saldo_contable - @i_valor,
                     @w_disponible     - @i_valor,             @w_oficina,        'R',
                     @w_prod_banc,      @w_categoria,          @s_ssn_branch,
                     @w_tipocta_super,  @i_turno,              getdate(),
                     @i_canal,          @w_cliente,            @w_clase_clte,
                     1,                 @i_base_gmf )

          if @@error <> 0
          begin
                 select @w_error = 253000,
                        @w_msg   = 'ERROR EN INSERCION DE TRANSACCION MONETARIA'

                 goto ERROR
          end


          /* ACTUALIZAR LA TRANSACCION MONET. ORIGINAL */
          update cob_ahorros..ah_tran_monet
          set    tm_estado = 'R'
          where  isnull(tm_ssn_branch, tm_secuencial)    = @t_ssn_corr
          and    tm_cta_banco      = @w_cta_banco
          and    tm_valor          = @i_valor
          and    tm_tipo_tran      = 253
          and    tm_causa          = '20'
          and    tm_moneda         = @i_mon
          and    tm_estado         is null

          if @@rowcount <> 1 or @@error <> 0
          begin
               select @w_error = 251067,
                      @w_msg   = 'TRANSACCION ORIGEN DEL REVERSO NO COINCIDE O TRANSACCION YA REVERSADA'
               goto ERROR
          end
  end




  if @w_commit = 'S'
       commit tran


return 0

ERROR:

   if @w_commit = 'S'
       rollback tran

   return @w_error

go

