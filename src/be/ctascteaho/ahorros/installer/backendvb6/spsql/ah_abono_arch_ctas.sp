/************************************************************************/
/*      Archivo:                ah_abono_arch_ctas.sp                   */
/*      Stored procedure:       sp_abono_archivo_cuentas                */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               clientes                                */
/*      Disenado por:           Alfredo Zamudio                         */
/*      Fecha de escritura:     16/05/2012                              */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*      Realiza abono a Cuentas cargadas a trav�s de la base de Datos   */
/*      de cob_externos.                                                */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*         FECHA                AUTOR                  RAZ�N            */
/*     05/DIC/2013          Liana Coto   Req 393 Dispersi�n de Fondos   */
/*                                       para abonos a cuentas inactivas*/
/*                                       no trasladadas al DTN          */
/*     02/Mayo/2016         Ignacio Yupa Migraci�n a CEN                */
/************************************************************************/

use cob_ahorros
go

if exists(select
            1
          from   sysobjects
          where  name = 'sp_abono_archivo_cuentas')
  drop proc sp_abono_archivo_cuentas
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_abono_archivo_cuentas
(
  @t_show_version bit = 0,
  @i_corresponsal char(1) = 'S' --Req. 381 CB Red Posicionada
)
as
  declare
    @w_spname            varchar(60),
    @w_int               int,
    @w_fproc             datetime,
    @w_cont              int,
    @w_tot               int,
    @w_mensaje           varchar(60),
    @w_error             int,
    @w_var_s             varchar(30),
    @w_sec               int,
    @w_tced              varchar(5),
    @w_cruc              varchar(15),
    @w_nom               varchar(60),
    @w_ente              int,
    @w_cuenta            varchar(20),
    @w_valor             money,
    @w_estado            char(1),
    @w_estado_cta        char(1),
    @w_fecha             datetime,
    @w_causa             char(3),
    @w_test              int,
    @w_tmov              char(1),
    @w_trn_prod          int,
    @w_ab_oficina        int,
    @w_saldo_disponible  money,
    @w_return            int,
    @t_debug             char(1),
    @t_file              varchar(20),
    @w_saldo_para_girar  money,
    @w_par_ofi_bv        int,
    @w_saldo_disponiblef money,
    @o_monto_real        money,
    @s_ofi               int,
    @w_saldo_contable    money,
    @s_date              datetime,
    @s_ssn               int,
    @s_srv               int,
    @w_mon               tinyint,
    @w_ssn_corr          varchar(20),
    @w_corr              char(1),
    @w_ofi               smallint,
    @w_ssn               int,
    @w_empresa           int,
    @w_treg              char(2),
    @w_alt               int,
    @w_srv               varchar(30),
    --/*** req 393****/
    @w_est_dtn           char(1),
    @w_count_dtn         int,
    @w_inact_dtn         char(1),
    --/*******/
    @w_prod_bancario     varchar(50) --Req. 381 CB Red Posicionada

  select
    @w_spname = 'sp_abono_archivo_cuentas'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_spname + ' Version= ' + '4.0.0.0'
    return 0
  end

  --Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
  select
    @w_prod_bancario = rtrim(cl_catalogo.codigo)
  from   cobis..cl_catalogo,
         cobis..cl_tabla
  where  cl_catalogo.tabla  = cl_tabla.codigo
     and cl_tabla.tabla     = 're_pro_banc_cb'
     and cl_catalogo.estado = 'V'

  select
    @w_fproc = fp_fecha
  from   cobis..ba_fecha_proceso

  select
    @w_srv = nl_nombre
  from   cobis..ad_nodo_oficina
  where  nl_nodo = 1 --Nodo del servidor central

  select
    @w_int = count(1)
  from   cob_ahorros..ah_carga_archivo_cuentas_tmp

  if @w_int = 0
      or @w_int is null
  begin
    select
      @w_mensaje = 'NO HAY DATOS PARA PROCESAR EN LA TABLA',
      @w_error = 10000001
    goto ERRORFIN
  end

  if not exists (select
                   1
                 from   cob_ahorros..ah_carga_archivo_cuentas_tmp
                 where  ca_fecha_reg = @w_fproc
                    and ca_tipo_reg  = 'R1')
  begin
    select
      @w_mensaje = 'NO HAY CABECERA(S) QUE COINCIDAN CON LA FECHA DE PROCESO',
      @w_error = 10000001
    goto ERRORFIN
  end

  select
    @w_cont = min(ca_autnum)
  from   cob_ahorros..ah_carga_archivo_cuentas_tmp

  select
    @w_tot = max(ca_autnum)
  from   cob_ahorros..ah_carga_archivo_cuentas_tmp

  exec @w_ssn = ADMIN...rp_ssn
  select
    @w_alt = 1

  /* Para cada uno de los registros */
  while(@w_cont <= @w_tot)
  begin
    begin tran

    -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
    if @i_corresponsal = 'N'
    begin
      select
        @w_treg = ca_tipo_reg,
        @w_sec = ca_autnum,
        @w_tced = ca_tipo_ced,
        @w_cruc = ca_ced_ruc,
        @w_nom = ca_nomb_arch,
        @w_ente = ca_ente,
        @w_cuenta = ltrim(rtrim(ca_cta_banco)),
        @w_valor = ca_valor,
        @w_estado = ca_estado,
        @w_fecha = ca_fecha_proc,
        @w_empresa = ca_empresa,
        @w_causa = ca_causal,
        @w_tmov = ca_tipo_mov
      from   cob_ahorros..ah_carga_archivo_cuentas_tmp
      where  ca_autnum    = @w_cont
         and ca_tipo_prod <> @w_prod_bancario -- Req. 381 CB Red Posicionada
    end
    else
    begin
      select
        @w_treg = ca_tipo_reg,
        @w_sec = ca_autnum,
        @w_tced = ca_tipo_ced,
        @w_cruc = ca_ced_ruc,
        @w_nom = ca_nomb_arch,
        @w_ente = ca_ente,
        @w_cuenta = ltrim(rtrim(ca_cta_banco)),
        @w_valor = ca_valor,
        @w_estado = ca_estado,
        @w_fecha = ca_fecha_proc,
        @w_empresa = ca_empresa,
        @w_causa = ca_causal,
        @w_tmov = ca_tipo_mov
      from   cob_ahorros..ah_carga_archivo_cuentas_tmp
      where  ca_autnum = @w_cont
    end

    if @w_treg = 'R1'
    begin
      goto SIG
    end
    else
    begin
      if @w_estado = 'R'
      begin
        select
          @w_mensaje = 'ERROR DATA: '

        /*VALIDACION FECHA PROCESO*/

        if @w_fecha <> @w_fproc
        begin
          rollback
          update cob_ahorros..ah_carga_archivo_cuentas_tmp
          set    ca_estado = 'X',
                 ca_error = @w_mensaje + ' + FECHA DE REGISTRO'
          where  ca_autnum = @w_cont

          goto SIG
        end

        select
          @w_int = 0
        /*VALIDACION EXISTENCIA CLIENTE*/
        select
          @w_int = count(1)
        from   cobis..cl_ente
        where  ltrim(rtrim(en_ced_ruc)) = ltrim(rtrim(@w_cruc))
           and en_tipo_ced              = @w_tced

        if @w_int = 0
        begin
          rollback
          select
            cont = @w_cont,
            tced = @w_tced,
            cruc = @w_cruc
          update cob_ahorros..ah_carga_archivo_cuentas_tmp
          set    ca_estado = 'X',
                 ca_error = @w_mensaje + ' + DOCUMENTO NO VALIDO'
          where  ca_autnum = @w_cont

          goto SIG
        end

        /*VALIDACION TITULARIDAD CUENTA*/
        select
          @w_int = 0

        select
          @w_int = 1
        from   cobis..cl_det_producto,
               cobis..cl_cliente
        where  cl_det_producto            = dp_det_producto
           and dp_cuenta                  = @w_cuenta
           and dp_producto                = 4
           and convert(bigint, cl_ced_ruc) = convert(bigint, @w_cruc)
           and cl_rol in ('T', 'C')

        if @w_int = 0
        begin
          rollback
          update cob_ahorros..ah_carga_archivo_cuentas_tmp
          set    ca_estado = 'X',
                 ca_error = @w_mensaje + ' TITULAR NO VALIDO'
          where  ca_autnum = @w_cont
          goto SIG
        end

        -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
        if @i_corresponsal = 'N'
        begin
        /*VALIDACION VIGENCIA CAUSALES ND/NC*/--PRINT 'VALIDA TITULAR'
          select
            @w_ofi = ah_oficina,
            @w_mon = ah_moneda,
            @w_est_dtn = ah_estado --req 393
          from   cob_ahorros..ah_cuenta
          where  ah_cta_banco = @w_cuenta
             and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada
        end
        else
        begin
        /*VALIDACION VIGENCIA CAUSALES ND/NC*/--PRINT 'VALIDA TITULAR'
          select
            @w_ofi = ah_oficina,
            @w_mon = ah_moneda,
            @w_est_dtn = ah_estado --req 393
          from   cob_ahorros..ah_cuenta
          where  ah_cta_banco = @w_cuenta
        end

        select
          @w_inact_dtn = 'N',--req 393
          @w_count_dtn = 0 --req 393

        /*APLICACION ND/NC*/
        if @w_tmov = 'C'
        begin -- notas de credito
          select
            @w_trn_prod = 253
          if @w_est_dtn = 'I' --Req 393
          begin
            select
              @w_count_dtn = count(1)
            --verifica si la cuenta esta traslada al DTN
            from   cob_remesas..re_tesoro_nacional
            where  tn_cuenta = @w_cuenta
               and tn_estado = 'P'

            if @w_count_dtn = 0
            begin
              select
                @w_inact_dtn = 'S'
            end
            else
            begin
              rollback
              update cob_ahorros..ah_carga_archivo_cuentas_tmp
              set    ca_estado = 'X',
                     ca_error =
                     'ERROR DATA: ND/NC ERROR: CUENTA TRASLADADA A DTN CAUSAL: '
                     + cast(@w_causa as varchar)
              where  ca_autnum = @w_cont
              goto SIG
            end
          end--@w_est_dtn = 'I'  req 393
        end --@w_tmov = 'C'
        else
        begin -- notas de debito
          select
            @w_trn_prod = 264
        end

        select
          @w_alt = @w_alt + 1

        exec @w_error = cob_ahorros..sp_ahndc_automatica
          @s_srv         = @w_srv,
          @s_ssn         = @w_ssn,
          @s_ofi         = @w_ofi,
          @t_trn         = @w_trn_prod,
          @i_alt         = @w_alt,
          @i_cta         = @w_cuenta,
          @i_val         = @w_valor,
          @i_cau         = @w_causa,
          @i_mon         = @w_mon,
          @i_fecha       = @w_fproc,
          @i_activar_cta = 'N',
          @i_cobiva      = 'S',
          @i_is_batch    = 'S',
          @i_inmovi      = @w_inact_dtn --Req 393

        if @w_error <> 0
        begin
          rollback
          select
            @w_mensaje = isnull(mensaje,
                                '')
          from   cobis..cl_errores
          where  numero = @w_error

          update cob_ahorros..ah_carga_archivo_cuentas_tmp
          set    ca_estado = 'X',
                 ca_error = 'ERROR DATA: ND/NC ERROR: ' + @w_mensaje +
                            ' CAUSAL: '
                            +
                            cast(
                            @w_causa as
                            varchar)
          where  ca_autnum = @w_cont

          goto SIG
        end
        else
        begin
          update cob_ahorros..ah_carga_archivo_cuentas_tmp
          set    ca_estado = 'P',
                 ca_error = 'OK: PROCESADA' --+ @w_registro
          where  ca_autnum = @w_cont
        end
      end --Debitos o credito s CTAHO

      SIG:
      if @@trancount > 0
        commit tran

      set @w_cont = @w_cont + 1
      select
        @w_mensaje = ''

    end
  end

  update cob_ahorros..ah_carga_archivo_cuentas_tmp
  set    ca_estado = 'P',
         ca_error = 'LOTE PROCESADO. POR FAVOR REVISAR ESTADOS DE LOS DETALLES'
  where  ca_tipo_reg = 'R1'

  -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
  if @i_corresponsal = 'N'
  begin
    insert into cob_ahorros..ah_carga_archivo_cuentas
      select
        ca_tipo_reg,ca_secuencia,ca_tipo_carga,ca_tipo_ced,ca_ced_ruc,
        ca_nomb_arch,ca_ente,ca_cta_banco,ca_tipo_prod,ca_fecha_reg,
        ca_cant_reg,ca_valor,ca_tipo_mov,ca_causal,ca_fecha_proc,
        ca_tipo_oper,ca_estado,ca_error,ca_empresa
      from   cob_ahorros..ah_carga_archivo_cuentas_tmp
      where  ca_tipo_prod <> @w_prod_bancario -- Req. 381 CB Red Posicionada

    if @@error <> 0
    begin
      select
        @w_mensaje = 'ERROR AL PASAR A TABLAS DEFINITIVAS',
        @w_error = 10000001
      goto ERRORFIN
    end
  end
  else
  begin
    insert into cob_ahorros..ah_carga_archivo_cuentas
      select
        ca_tipo_reg,ca_secuencia,ca_tipo_carga,ca_tipo_ced,ca_ced_ruc,
        ca_nomb_arch,ca_ente,ca_cta_banco,ca_tipo_prod,ca_fecha_reg,
        ca_cant_reg,ca_valor,ca_tipo_mov,ca_causal,ca_fecha_proc,
        ca_tipo_oper,ca_estado,ca_error,ca_empresa
      from   cob_ahorros..ah_carga_archivo_cuentas_tmp

    if @@error <> 0
    begin
      select
        @w_mensaje = 'ERROR AL PASAR A TABLAS DEFINITIVAS',
        @w_error = 10000001
      goto ERRORFIN
    end
  end

  truncate table cob_ahorros..ah_carga_archivo_cuentas_tmp320

  -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
  if @i_corresponsal = 'N'
  begin
    /* LLENA TABLA CON REGISTROS DE PAGOS PARA LA GENERACION DEL REPORTE DE SALIDA */
    insert into cob_ahorros..ah_carga_archivo_cuentas_tmp320
      select
        ca_tipo_carga,cast((select
                count(0)
              from   cob_ahorros..ah_carga_archivo_cuentas_tmp
              where  ca_tipo_reg   = 'R2'
                 and ca_fecha_proc = @w_fproc)as varchar),cast((select
                count(ca_error)
              from   cob_ahorros..ah_carga_archivo_cuentas_tmp
              where  ca_error like 'OK%'
                 and ca_tipo_reg   = 'R2'
                 and ca_fecha_proc = @w_fproc)as varchar),(select
           count(ca_error)
         from   cob_ahorros..ah_carga_archivo_cuentas_tmp
         where  ca_error like '%DAT%'
            and ca_fecha_proc = @w_fproc),(select
           count(ca_error)
         from   cob_ahorros..ah_carga_archivo_cuentas_tmp
         where  ca_error like '%ESTRUCTURA%'
            and ca_fecha_proc = @w_fproc),
        cast((select
                isnull(ah_nombre,
                       '')
              from   cob_ahorros..ah_cuenta
              where  ah_cta_banco = ca_cta_banco) as varchar),cast(
        ca_tipo_ced as varchar),cast(ca_ced_ruc as varchar),cast(
        ca_valor as varchar
        ),
        cast((select
                isnull(ah_producto,
                       '')
              from   cob_ahorros..ah_cuenta
              where  ah_cta_banco = ca_cta_banco) as varchar),
        --ò Tipo de producto: ( 4- ahorros / 3 - corriente)
        cast(ca_cta_banco as varchar),
        --ò N·mero de cuenta: (N·mero de cuenta corriente o de ahorros)
        ca_estado,--ò Estado: (Procesado, Rechazado )
        ca_error,--ò Mensaje-ERROR: 
        ca_nomb_arch -- Nombre del archivo
      from   cob_ahorros..ah_carga_archivo_cuentas_tmp
      where  ca_fecha_proc = @w_fproc
          or ca_fecha_reg  = @w_fproc
             and ca_tipo_prod  <> @w_prod_bancario
    -- Req. 381 CB Red Posicionada

    if @@error <> 0
    begin
      select
        @w_mensaje = 'ERROR AL PASAR A TABLAS DEL REPORTE DE SALIDA DEL PROCESO'
        ,
        @w_error = 10000001
      goto ERRORFIN
    end
  end
  else
  begin
    /* LLENA TABLA CON REGISTROS DE PAGOS PARA LA GENERACION DEL REPORTE DE SALIDA */
    insert into cob_ahorros..ah_carga_archivo_cuentas_tmp320
      select
        ca_tipo_carga,cast((select
                count(0)
              from   cob_ahorros..ah_carga_archivo_cuentas_tmp
              where  ca_tipo_reg   = 'R2'
                 and ca_fecha_proc = @w_fproc)as varchar),cast((select
                count(ca_error)
              from   cob_ahorros..ah_carga_archivo_cuentas_tmp
              where  ca_error like 'OK%'
                 and ca_tipo_reg   = 'R2'
                 and ca_fecha_proc = @w_fproc)as varchar),(select
           count(ca_error)
         from   cob_ahorros..ah_carga_archivo_cuentas_tmp
         where  ca_error like '%DAT%'
            and ca_fecha_proc = @w_fproc),(select
           count(ca_error)
         from   cob_ahorros..ah_carga_archivo_cuentas_tmp
         where  ca_error like '%ESTRUCTURA%'
            and ca_fecha_proc = @w_fproc),
        cast((select
                isnull(ah_nombre,
                       '')
              from   cob_ahorros..ah_cuenta
              where  ah_cta_banco = ca_cta_banco) as varchar),cast(
        ca_tipo_ced as varchar),cast(ca_ced_ruc as varchar),cast(
        ca_valor as varchar
        ),
        cast((select
                isnull(ah_producto,
                       '')
              from   cob_ahorros..ah_cuenta
              where  ah_cta_banco = ca_cta_banco) as varchar),
        --ò Tipo de producto: ( 4- ahorros / 3 - corriente)
        cast(ca_cta_banco as varchar),
        --ò N·mero de cuenta: (N·mero de cuenta corriente o de ahorros)
        ca_estado,--ò Estado: (Procesado, Rechazado )
        ca_error,--ò Mensaje-ERROR: 
        ca_nomb_arch -- Nombre del archivo
      from   cob_ahorros..ah_carga_archivo_cuentas_tmp
      where  ca_fecha_proc = @w_fproc
          or ca_fecha_reg  = @w_fproc

    if @@error <> 0
    begin
      select
        @w_mensaje = 'ERROR AL PASAR A TABLAS DEL REPORTE DE SALIDA DEL PROCESO'
        ,
        @w_error = 10000001
      goto ERRORFIN
    end
  end

  /* GENERA REPORTE DE SALIDA DEL PROCESO */
  exec @w_error = cob_ahorros..sp_genera_archivo_cuentas
    @i_param1 = @w_fproc,
    @i_param2 = null

  if @w_error <> 0
  begin
    select
      @w_mensaje = 'ERROR AL GENERAR REPORTE DE SALIDA'
    goto ERRORFIN
  end

  delete cob_ahorros..ah_carga_archivo_cuentas_tmp

  return 0

  ERRORFIN:

  print 'Error ejecucion: ' + cast(@w_mensaje as varchar)

  exec cob_ahorros..sp_errorlog
    @i_fecha       = @w_fproc,
    @i_error       = @w_error,
    @i_cuenta      = @w_cuenta,
    @i_tran        = @w_trn_prod,
    @i_usuario     = 'opbatch',
    @i_descripcion = @w_mensaje,
    @i_programa    = @w_spname

  return @w_error

go

