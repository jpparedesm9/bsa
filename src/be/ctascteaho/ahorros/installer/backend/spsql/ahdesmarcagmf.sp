/********************************************************************/
/*  Archivo            : ahdesmarcagmf.sp                           */
/*  Stored procedure   : sp_desmarca_gmf                            */
/*  Base de datos      : cob_ahorros                                */
/*  Producto           : Ahorross                                   */
/*  Disenado por       : A Celis                                    */
/*  Fecha de escritura : 2013/05/08                                 */
/********************************************************************/
/*                         IMPORTANTE                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*  de COBISCorp.                                                   */
/*  Su uso no autorizado queda expresamente prohibido asi como      */
/*  cualquier alteracion o agregado hecho por alguno  de sus        */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*  Este programa esta protegido por la ley de derechos de autor    */
/*  y por las convenciones  internacionales de propiedad inte-      */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*  penalmente a los autores de cualquier infraccion.               */
/********************************************************************/
/*                       PROPOSITO                                  */
/*  Proceso de Desmarcacion de cuentas exentas GMF fuente CIFIN     */
/********************************************************************/
/*                     MODIFICACIONES                               */
/*  FECHA              AUTOR           RAZON                        */
/*  2013/05/08         ACelis          Emision Inicial              */
/*  03/May/2016        J. Salazar      Migracion COBIS CLOUD MEXICO */
/********************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_desmarca_gmf')
  drop proc sp_desmarca_gmf
go

/****** Object:  StoredProcedure [dbo].[sp_desmarca_gmf]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_desmarca_gmf
  @t_show_version bit = 0
as
  declare
    @w_tipo_id           varchar(2),
    @w_identificacion    numero,
    @w_cta_max           int,
    @w_cta_min           int,
    @w_dat_min           int,
    @w_dat_max           int,
    @w_msg               varchar(255),
    @w_mensaje           varchar(255),
    @w_ente              int,
    @w_ente_ah           int,
    @w_titular           varchar(1),
    @w_estado            varchar(30),
    @w_validaOK          smallint,
    @w_marca             varchar(1),
    @w_path_destino      varchar(100),
    @w_path              varchar(100),
    @w_s_app             varchar(50),
    @w_cmd               varchar(255),
    @w_comando           varchar(255),
    @w_nombre_archivo    varchar(255),
    @w_error             int,
    @w_datos             varchar(1000),
    @w_encab             varchar(1000),
    @w_ano               varchar(4),
    @w_mes               varchar(2),
    @w_dia               varchar(2),
    @w_spname            varchar(15),
    @w_fecha_carga       datetime,
    @w_tmpfile           varchar(255),
    @w_tmpfile1          varchar(255),
    @w_fecha_trans       varchar(8),
    @w_ah_cuenta         int,
    @w_ah_cta_banco      varchar(16),
    @w_ah_filial         tinyint,
    @w_ah_oficina        smallint,
    @w_ah_producto       tinyint,
    @w_ah_moneda         tinyint,
    @w_ah_oficial        smallint,
    @w_ah_origen         varchar(3),
    @w_ah_clase_clte     char,
    @w_ah_nxmil          char,
    @w_ah_descripcion_ec varchar(120),
    @w_fecha             datetime,
    @s_user              varchar(30),
    @s_ofi               smallint,
    @w_concepto          smallint,
    @w_sec               int,
    @w_count             int,
    @w_nom_usuario       varchar(64),
    @w_nombre            varchar(64)

  select
    @w_spname = 'sp_desmarca_gmf',
    @w_fecha_carga = getdate(),
    @s_user = 'opbatch'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_spname + ' Version=' + '4.0.0.0'
    return 0
  end

  set ANSI_NULLS off

  select
    @w_ano = convert(varchar(4), datepart(yyyy,
                                          @w_fecha_carga)),
    @w_mes = convert(varchar(2), datepart(mm,
                                          @w_fecha_carga)),
    @w_dia = convert(varchar(2), datepart(dd,
                                          @w_fecha_carga))

  select
    @w_fecha_trans = (right('00'+ @w_dia, 2) + right('00' + @w_mes, 2) + @w_ano)

  select
    @w_fecha = fp_fecha
  from   cobis..ba_fecha_proceso with (nolock)

  if exists (select
               1
             from   sysobjects
             where  name = 'ah_cta_gmf_tmp')
    drop table ah_cta_gmf_tmp

  create table ah_cta_gmf_tmp
  (
    cgt_sec            int identity,
    cgt_fecha          varchar(10) null,
    cgt_tipo_id        varchar(2) null,
    cgt_identificacion varchar(30) null,
    cgt_nombre         varchar(254) null,
    cgt_entidad        varchar(2) null,
    cgt_cuenta         varchar(16) null,
    cgt_estado         varchar(30) null,
    cgt_msg            varchar(254) null
  )

  if exists (select
               1
             from   sysobjects
             where  name = 'ah_datos_gmf_tmp')
    drop table ah_datos_gmf_tmp

  create table ah_datos_gmf_tmp
  (
    dgt_sec         int identity,
    dgt_ente        int null,
    dgt_cuenta      int null,
    dgt_cta_banco   varchar(16) null,
    dgt_filial      tinyint null,
    dgt_oficina     smallint null,
    dgt_producto    tinyint null,
    dgt_moneda      tinyint null,
    dgt_oficial     smallint null,
    dgt_origen      varchar(3) null,
    dgt_clase       char null,
    dgt_nxmil       char null,
    dgt_descripcion varchar(120) null
  )

  select
    @w_count = count(1)
  from   cob_externos..ex_cta_gmf

  if @w_count = 0
  begin
    select
      @w_error = 208158
    select
      @w_mensaje = 'NO EXISTEN DATOS EN COB_EXTERNOS PARA PROCESAR'
    print @w_mensaje
    goto ERRORFIN
  end

  insert into cob_ahorros..ah_cta_gmf_tmp
              (cgt_fecha,cgt_tipo_id,cgt_identificacion,cgt_nombre,cgt_entidad,
               cgt_cuenta)
    select
      convert(varchar(8), @w_fecha, 112),cg_tipo_id,
      convert(varchar(30), cg_identificacion),cg_nombre,cg_entidad,
      convert(varchar(16), cg_cuenta)
    from   cob_externos..ex_cta_gmf

  if @@error = 0
  begin
    print ' IMPORTA CORRECTAMENTE LOS DATOS DE COB_EXTERNOS'
    truncate table cob_externos..ex_cta_gmf
  end
  else
  begin
    select
      @w_error = 150001
    select
      @w_mensaje = 'ERROR AL IMPORTAR LOS DATOS DE COB_EXTERNOS'
    print @w_mensaje
    goto ERRORFIN
  end

  select
    @w_nom_usuario = fu_nombre
  from   cobis..cl_funcionario
  where  fu_login = @s_user

  select
    @w_cta_max = 0,
    @w_cta_min = 0,
    @w_mensaje = null

  select
    @w_cta_min = min (cgt_sec)
  from   cob_ahorros..ah_cta_gmf_tmp
  where  cgt_estado is null

  select
    @w_cta_max = max (cgt_sec)
  from   cob_ahorros..ah_cta_gmf_tmp
  where  cgt_estado is null

  exec @w_sec = ADMIN...rp_ssn

  while (@w_cta_min <= @w_cta_max)
  begin
    select
      @w_msg = null

    -- *********Valida existencia del cliente
    select
      @w_tipo_id = cgt_tipo_id,
      @w_identificacion = cgt_identificacion,
      @w_nombre = cgt_nombre
    from   cob_ahorros..ah_cta_gmf_tmp
    where  cgt_sec = @w_cta_min

    print ' Procesando Cliente con Id...  ' + @w_identificacion

    select
      @w_validaOK = 1

    select
      @w_ente = null

    select
      @w_ah_cta_banco = null

    select
      @w_ente = en_ente
    from   cobis..cl_ente
    where  en_ced_ruc = @w_identificacion
       and en_tipo_ced in
           (select
              c.codigo
            from   cobis..cl_catalogo c,
                   cobis..cl_tabla t
            where  t.tabla  = 'cl_doc_cifin'
               and t.codigo = c.tabla
               and c.valor  = @w_tipo_id
               and c.estado = 'V')

    if (@@error <> 0
         or @@rowcount = 0)
    begin
      select
        @w_validaOK = 0
      select
        @w_msg =
        'Tipo de identificacion Invﬂlido o No existe Numero de Identificacion '
    end

    if (isnull(@w_ente,
               0) <> 0)
    begin
      truncate table ah_datos_gmf_tmp
      insert into ah_datos_gmf_tmp
        select
          ah_cliente,ah_cuenta,ah_cta_banco,ah_filial,ah_oficina,
          ah_producto,ah_moneda,ah_oficial,ah_origen,ah_clase_clte,
          ah_nxmil,ah_descripcion_ec
        from   cob_ahorros..ah_cuenta,
               cob_ahorros..ah_exenta_gmf
        where  ah_cliente        = @w_ente
           and isnull(@w_ente,
                      0) <> 0
           and eg_cta_banco      = ah_cta_banco
           and eg_marca          = 'S'

      if (@@error <> 0
           or @@rowcount = 0)
        select
          @w_validaOK = 0

      select
        @w_dat_min = min (dgt_sec)
      from   cob_ahorros..ah_datos_gmf_tmp

      select
        @w_dat_max = max (dgt_sec)
      from   cob_ahorros..ah_datos_gmf_tmp

      if (isnull(@w_dat_min,
                 0) = isnull(@w_dat_max,
                             0))
         and isnull(@w_dat_max,
                    0) = 0
        select
          @w_msg = 'Numero de Identificacion sin Cuentas a Desmarcar'

      select
        @w_ah_cta_banco = null

      /**** PROCESA TODAS LAS CUENTAS QUE TENGAN LA MARCA DE LA EXENCION */

      while (@w_dat_min <= @w_dat_max)
      begin
        select
          @w_ente_ah = dgt_ente,
          @w_ah_cuenta = dgt_cuenta,
          @w_ah_cta_banco = dgt_cta_banco,
          @w_ah_filial = dgt_filial,
          @w_ah_oficina = dgt_oficina,
          @w_ah_producto = dgt_producto,
          @w_ah_moneda = dgt_moneda,
          @w_ah_oficial = dgt_oficial,
          @w_ah_origen = dgt_origen,
          @w_ah_clase_clte = dgt_clase,
          @w_ah_nxmil = dgt_nxmil,
          @w_ah_descripcion_ec = dgt_descripcion
        from   cob_ahorros..ah_datos_gmf_tmp
        where  dgt_sec = @w_dat_min

        update cob_ahorros..ah_exenta_gmf
        set    eg_marca = 'N',
               eg_fecha_actua = @w_fecha,
               eg_fecha_desm = @w_fecha,
               eg_usuario_desm = @s_user,
               eg_oficina_desm = @w_ah_oficina,
               eg_oficina_actua = @w_ah_oficina
        where  eg_cta_banco = @w_ah_cta_banco
        if @@error <> 0
        begin
          select
            @w_error = 150001
          select
            @w_mensaje = 'NO ACTUALIZA LA DESMARCACION DE LA EXENCION GMF'
          print @w_mensaje
          goto ERRORFIN
        end
        else
        begin
          insert into cob_ahorros..ah_tsapertura
                      (secuencial,alterno,tipo_transaccion,oficina,usuario,
                       terminal,clase,tsfecha,cta_banco,filial,
                       oficial,moneda,nombre1,cliente,cuenta,
                       oficina_cta,prod_banc,clase_clte,nxmil,observacion,
                       hora,descripcion_ec,microficha,marca_gmf,fec_marca_gmf)
          values      ( @w_sec,41,4148,@s_ofi,@s_user,
                        'consola','A',@w_fecha,@w_ah_cta_banco,@w_ah_filial,
                        @w_ah_oficial,@w_ah_moneda,@w_nom_usuario,@w_ente_ah,
                        @w_ah_cuenta,
                        @w_ah_oficina,@w_ah_producto,@w_ah_clase_clte,
                        @w_ah_nxmil,
                        'DesmarcaCIFIN',
                        getdate(),@w_nombre,@w_concepto,'S',@w_fecha)

          if @@error <> 0
          begin
            print ' Error en creacion de transaccion de servicio '
            select
              @w_error = 203005
            goto ERRORFIN
          end
          select
            @w_msg = 'Ctas desmarcadas : '

          select
            @w_msg = @w_msg + @w_ah_cta_banco + ' '
          exec @w_sec = ADMIN...rp_ssn
        end
        select
          @w_dat_min = @w_dat_min + 1

      end --while dat
    end --existe cliente

    if @w_validaOK = 1
      select
        @w_estado = 'Procesado con Exito '
    else
      select
        @w_estado = 'Procesado sin Exito'

    update cob_ahorros..ah_cta_gmf_tmp
    set    cgt_estado = @w_estado,
           cgt_cuenta = @w_ah_cta_banco,
           cgt_msg = @w_msg
    where  cgt_sec = @w_cta_min

    if (@@error <> 0)
    begin
      select
        @w_error = 150001
      select
        @w_mensaje = 'NO ACTUALIZA EL ESTADO DEL PROCESO'
      print @w_mensaje
      goto ERRORFIN
    end

    if exists (select
                 1
               from   cob_ahorros..ah_tran_servicio
               where  ts_tipo_transaccion = 4148
                  and ts_cod_alterno      = 41
                  and ts_tsfecha          = @w_fecha
                  and ts_cta_banco        = @w_ah_cta_banco)
    begin
      update cob_ahorros..ah_tran_servicio
      set    ts_autoriz_anula = @w_msg,
             ts_autorizante = @w_estado
      where  ts_tipo_transaccion = 4148
         and ts_cod_alterno      = 41
         and ts_tsfecha          = @w_fecha
         and ts_cta_banco        = @w_ah_cta_banco

      if (@@error <> 0)
      begin
        select
          @w_error = 150001
        select
          @w_mensaje = 'NO ACTUALIZA TRANSACCION DE SERVICIO'
        print @w_mensaje
        goto ERRORFIN
      end
    end

    select
      @w_cta_min = @w_cta_min + 1

  end --while

  --****** GENERACION BCP

  select
    @w_path = ba_path_destino
  from   cobis..ba_batch with (nolock)
  where  ba_arch_fuente = 'cob_ahorros..sp_desmarca_gmf'
  if @w_path is null
  begin
    select
      @w_error = 101077,
      @w_mensaje =
      'ERROR : NO EXISTE RUTA DESTINO DE LISTADOS PARA EL BATCH sp_desmarca_gmf'
    print @w_mensaje
    goto ERRORFIN
  end

  select
    @w_nombre_archivo = @w_path + 'DatosCIFIN' + convert(varchar(8), getdate(),
                        112)
                        + substring(convert(varchar, getdate(), 108), 1, 2)
                        + substring(convert(varchar, getdate(), 108), 4, 2) +
                        '.txt'

  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'
  if @@rowcount = 0
  begin
    select
      @w_error = 101077,
      @w_mensaje = 'NO EXISTE RUTA DEL S_APP'
    print @w_mensaje
    goto ERRORFIN
  end

  --*****
  select
    @w_tmpfile = @w_path + 'encrep_362.txt'
  select
    @w_tmpfile1 = @w_path + 'DesmarcaCIFIN' + convert(varchar(8), getdate(), 112
                  )
                  + substring(convert(varchar, getdate(), 108), 1, 2)
                  + substring(convert(varchar, getdate(), 108), 4, 2) + '.txt'

  select
    @w_encab = 'TIPO_ID;NUMERO_ID;NOMBRES;ENTIDAD;CUENTA;RESULTADO;CAUSA'

  select
    @w_cmd = 'echo ' + @w_encab + '> ' + @w_tmpfile
  exec xp_cmdshell
    @w_cmd

  select
    @w_cmd =
'bcp  "select cgt_tipo_id,cgt_identificacion,cgt_nombre,cgt_entidad,cgt_cuenta, cgt_estado, cgt_msg  from cob_ahorros..ah_cta_gmf_tmp " queryout   '
  select
       @w_comando = @w_cmd + @w_nombre_archivo + ' -b5000 -c  -t";" -T -S' +
                    @@servername
    +
                    ' -ePRODUIF.err'
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_error = 'Error Generando BCP ' + @w_comando
    exec cob_conta_super..sp_errorlog
      @i_operacion    = 'I',
      @i_fecha_fin    = @w_fecha_carga,
      @i_fuente       = @w_spname,
      @i_origen_error = '28020',
      @i_descrp_error = @w_error
    goto ERRORFIN
  end

  select
    @w_cmd = 'type ' + @w_tmpfile + ' ' + @w_nombre_archivo + '> ' + @w_tmpfile1
  exec xp_cmdshell
    @w_cmd

  select
    @w_cmd = 'del ' + @w_tmpfile
  exec xp_cmdshell
    @w_cmd

  select
    @w_cmd = 'del ' + @w_nombre_archivo
  exec xp_cmdshell
    @w_cmd

  --drop table  ah_datos_gmf_tmp
  return 0

  ERRORFIN:

  exec cob_ahorros..sp_errorlog
    @i_fecha       = @w_fecha_carga,
    @i_error       = @w_error,
    @i_usuario     = 'operador',
    @i_tran        = null,
    @i_descripcion = @w_mensaje,
    @i_programa    = @w_spname

  return @w_error

go

