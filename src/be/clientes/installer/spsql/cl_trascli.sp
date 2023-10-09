/* **********************************************************************/
/*      Archivo           : cl_tracli.sp                                */
/*      Stored procedure  : sp_traslada_cliente                         */
/*      Base de datos     : cobis                                       */
/*      Producto          : Clientes                                    */
/*      Disenado por      : J.Gutierre                                  */
/*      Fecha de escritura: 30-Abr-2008                                 */
/* **********************************************************************/
/*                          IMPORTANTE                                  */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de 'COBISCorp'.                                                     */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                           PROPOSITO                                  */
/*  Permite seleccionar funcionario de determinado cargo en una         */
/*  oficina                                                             */
/* **********************************************************************/
/*                             MODIFICACIONES                           */
/*      FECHA            AUTOR                RAZON                     */
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
/************************************************************************/
use cobis
go
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_traslada_cliente')
  drop proc sp_traslada_cliente
go

create proc sp_traslada_cliente
(
  @t_show_version bit = 0
)
as
  declare
    @w_tipoid      varchar(10),
    @w_cedruc      varchar(30),
    @w_ofiori      int,
    @w_ofides      int,
    @w_ejedes      int,
    @w_sp_name     descripcion,
    @w_ente        int,
    @w_oficial     smallint,
    @w_subtipo     varchar(2),
    @w_return      int,
    @w_error       int,
    @w_today       datetime,
    @w_err         varchar(500),
    @w_linea       varchar(500),
    @w_oficina     smallint,
    @w_alterno     int,
    @w_ssn         int,
    @w_cargo       varchar(10),
    @w_funcionario smallint,
    @w_path_salida varchar(255),
    @w_nombre      varchar(50),
    @w_comando     varchar(255),
    @w_cargo1      smallint,
    @w_path_s_app  varchar(50),
    @w_hora        varchar(50),
    @w_commit      char(1),
    @w_procesados  int,
    @w_fecha       varchar(10),
    @w_opi         char(1)

  /* INICIALIZAR VARIABLES DE TRABAJO */
  select
    @w_sp_name = 'sp_traslada_cliente',
    @w_alterno = 0,
    @w_ssn = 0,
    @w_linea = '',
    @w_err = '',
    @w_commit = 'N',
    @w_opi = 'N'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_today = convert(varchar(10), fp_fecha, 101)
  from   cobis..ba_fecha_proceso

  select
    @w_path_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  if @@rowcount = 0
  begin
    select
      @w_err = 'NO SE ENCUENTRA EL PARAMETRO GENERAL -S_APP- DEL ADMIN'
    goto ERRORFIN
  end

  select
    @w_cargo1 = pa_smallint
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'DOF'

  if @@rowcount = 0
  begin
    select
      @w_err = 'NO SE ENCUENTRA EL PARAMETRO GENERAL -DOF- DEL MIS'
    goto ERRORFIN
  end

  select
    @w_procesados = isnull(count(0),
                           0)
  from   cobis..tmp_traslado

  if @@rowcount = 0
  begin
    select
      @w_err = 'NO SE ENCONTRARON REGISTROS A PROCESAR'
    goto ERRORFIN
  end

  select
    @w_ssn = se_numero + 1
  from   cobis..ba_secuencial

  if @@rowcount = 0
  begin
    select
      @w_err = 'ERROR AL OBTENER SECUENCIAL INICIAL SSN'
    goto ERRORFIN
  end

  update cobis..ba_secuencial
  set    se_numero = @w_ssn + @w_procesados

  if @@rowcount <> 1
  begin
    select
      @w_err = 'ERROR AL ACTUALIZAR SECUENCIAL INICIAL SSN'
    goto ERRORFIN
  end

  select
    @w_fecha = convert(varchar(19), getdate(), 5)
  select
    @w_hora = substring((convert(varchar(8), getdate(), 108)), 1, 2) + '-'
              + substring((convert(varchar(8), getdate(), 108)), 4, 2)

  truncate table cl_error_log

  declare traslado_cursor cursor for
    select
      tr_tipoid,
      tr_cedruc,
      tr_ofiori,
      tr_ofides,
      tr_ejedes
    from   cobis..tmp_traslado

  open traslado_cursor

  fetch next from traslado_cursor into @w_tipoid,
                                       @w_cedruc,
                                       @w_ofiori,
                                       @w_ofides,
                                       @w_ejedes

  while @@fetch_status = 0
  begin
    select
      @w_linea = ' - Tipo de Documento : ' + isnull(@w_tipoid, 'NULO') +
                        ' - Numero de Documento : '
                 + isnull(@w_cedruc, 'NULO') + ' - Oficina Origen : '
                 + isnull(convert(varchar, @w_ofiori), 'NULO') +
                        ' - Oficina Destino : '
                 + isnull(convert(varchar, @w_ofides), 'NULO') +
                        ' - Ejecutivo Destino :'
                 + isnull(convert(varchar, @w_ejedes), 'NULO')

    if @w_tipoid is null
        or @w_cedruc is null
        or @w_ofiori is null
        or @w_ofides is null
        or @w_ejedes is null
    begin
      select
        @w_err = 'Error Datos invalidos para completar el traslado'
      goto ERROR1
    end

    select
      @w_ente = en_ente,
      @w_oficial = en_oficial,
      @w_subtipo = en_subtipo
    from   cobis..cl_ente
    where  en_ced_ruc  = @w_cedruc
       and en_tipo_ced = @w_tipoid

    if @@rowcount = 0
    begin
      select
        @w_err = 'Error No se encuentra Usuario'
      goto ERROR1
    end

    --Valida que nuevo oficial sea de la misma oficina
    select
      @w_oficina = fu_oficina
    from   cobis..cl_funcionario,
           cobis..cc_oficial
    where  fu_funcionario = oc_funcionario
       and oc_oficial     = @w_ejedes

    if @@rowcount = 0
    begin
      select
        @w_err = 'No existe ejecutivo'
      goto ERROR1
    end

    if @w_oficina <> @w_ofides
    begin
      select
        @w_err = 'Ejecutivo no corresponde a oficina'
      goto ERROR1
    end

    --Valida que la oficina origen exista
    if not exists(select
                    1
                  from   cobis..cl_oficina
                  where  of_oficina = @w_ofiori)
    begin
      select
        @w_err = 'No existe oficina origen'
      goto ERROR1
    end

    --Valida que la oficina destino exista
    if not exists(select
                    1
                  from   cobis..cl_oficina
                  where  of_oficina = @w_ofides)
    begin
      select
        @w_err = 'No existe oficina destino'
      goto ERROR1
    end

    if not exists(select
                    1
                  from   cob_conta..cb_relofi with (nolock)
                  where  re_filial  = 1
                     and re_empresa = 1
                     and re_ofadmin = @w_ofides)
    begin
      select
        @w_err =
      'La oficina destino no esta definida como oficina contable (cb-relofi)'
      goto ERROR1
    end

    select
      @w_opi = isnull(to_opi,
                      'N')
    from   cob_credito..cr_tipo_oficina
    where  to_oficina = @w_ofides

    select
      @w_cargo1 = pa_smallint
    from   cobis..cl_parametro
    where  pa_producto = 'MIS'
       and pa_nemonico = 'DOF'

    if @w_opi = 'S'
    begin
      select
        @w_cargo1 = pa_smallint
      from   cobis..cl_parametro
      where  pa_nemonico = 'ENCOPI' --Encargado OPI
         and pa_producto = 'CRE'

      if @@rowcount = 0
      begin
        /* No existe oficial */
        select
          @w_err = 'No existe oficial'
        goto ERROR1
      end

    end

    select
      @w_funcionario = oc_oficial
    from   cobis..cc_oficial,
           cobis..cl_funcionario
    where  oc_funcionario = fu_funcionario
       and fu_oficina     = @w_ofides
       and fu_cargo       = @w_cargo1
       and fu_estado      = 'V'

    if @@rowcount = 0
    begin
      select
        @w_err = 'Clientes - Error No existe Oficial para esa oficina '
      goto ERROR1
    end

    if @@trancount = 0
    begin
      begin tran
      select
        @w_commit = 'S'
    end

    select
      @w_alterno = @w_alterno + 1

    exec @w_return = cobis..sp_asesor_upd
      @s_ssn       = @w_ssn,
      @s_user      = 'op_traslado',
      @s_term      = 'Consola',
      @s_date      = @w_today,
      @s_ofi       = @w_ofiori,
      @t_trn       = 1316,
      @i_tipo_cli  = @w_subtipo,
      @i_operacion = 'U',
      @i_ente      = @w_ente,
      @i_filial    = 1,
      @i_oficina   = @w_ofides,
      @i_oficial   = @w_funcionario,
      @i_alterno   = @w_alterno

    if @w_return <> 0
        or @@error <> 0
    begin
      select
        @w_err = 'Error al ejecutar sp_asesor_upd'
      goto ERROR1
    end

    update cobis..cl_ente
    set    en_oficina_prod = @w_ofides
    where  en_ced_ruc  = @w_cedruc
       and en_tipo_ced = @w_tipoid

    if @@rowcount = 0
    begin
      select
        @w_err = 'Error al actualizar la oficina'
      goto ERROR1
    end

    /*INSERCION DE REGISTROS EN LA TABLA CA_TRASLADOS_CARTERA */
    execute @w_return = cob_cartera..sp_traslada_cartera
      @s_user            = 'op_traslado',
      @s_term            = 'Consola',
      @s_date            = @w_today,
      @s_ofi             = @w_ofiori,
      @i_operacion       = 'I',
      @i_cliente         = @w_ente,
      @i_oficina_origen  = @w_ofiori,
      @i_oficina_destino = @w_ofides,
      @i_oficial_destino = @w_ejedes,
      @i_en_linea        = 'N'

    if @w_return <> 0
        or @@error <> 0
    begin
      select
        @w_err = 'Error al ejecutar cob_cartera..sp_traslada_cartera'
      goto ERROR1
    end

    /* COMENTAREADO HASTA DEFINIR COMO SE HACE EL TRASLADO DE TRAMITES
    execute @w_return = cob_credito..sp_traslada_credito
    @s_ssn             = @w_ssn,
    @s_user            = 'op_traslado',
    @s_term            = 'Consola',
    @s_date            = @w_today,
    @s_ofi             = @w_ofiori,
    @t_trn             = 1316,
    @i_cliente         = @w_ente,
    @i_oficina_origen  = @w_ofiori,
    @i_oficina_destino = @w_ofides,
    @i_oficial_destino = @w_ejedes
    
    if @w_return <> 0 or @@error <> 0 begin
       select @w_err = 'Error al ejecutar cob_credito..sp_traslada_credito'
       goto ERROR1
    end
    */

    if @w_commit = 'S'
    begin
      commit tran
      select
        @w_commit = 'N'
    end

    select
      @w_ssn = @w_ssn + 1
    goto SIGUIENTE

    ERROR1:

    print 'ENTRA A ERROR 1'
    print @w_err

    if @w_commit = 'S'
    begin
      rollback tran
      select
        @w_commit = 'N'
    end

    select
      @w_err = @w_err + @w_linea

    insert into cl_error_log
                (er_fecha_proc,er_usuario,er_descripcion)
    values      ( @w_today,'op_traslado',@w_err )

    SIGUIENTE:

    fetch NEXT from traslado_cursor into @w_tipoid,
                                         @w_cedruc,
                                         @w_ofiori,
                                         @w_ofides,
                                         @w_ejedes

  end

  close traslado_cursor
  deallocate traslado_cursor

  select
    @w_path_salida = isnull(ba_path_destino,
                            ba_path_fuente)
  from   cobis..ba_batch
  where  ba_arch_fuente = 'cobis..sp_traslada_cliente'

  select
    @w_nombre = 'tracli' + @w_fecha + '_' + @w_hora + '.txt'
  select
       @w_comando = @w_path_s_app + 's_app bcp cobis..cl_error_log out ' +
                    @w_path_salida
    +
                    @w_nombre
                 + ' -T -c -e ' + @w_path_salida +
    'error_log.out -m10000 -b5000 -auto -login -config '
                 + @w_path_s_app + 's_app.ini'

  exec @w_return = master..xp_cmdshell
    @w_comando
  if @w_return <> 0
  begin
    select
      @w_err = 'Error al generar tracli.txt'
    goto ERRORFIN
  end

  return 0

  ERRORFIN:

  print @w_err
  print 'ENTRA A ERRORFIN'

  if @w_commit = 'S'
  begin
    rollback tran
    select
      @w_commit = 'N'
  end

  return 1

go

