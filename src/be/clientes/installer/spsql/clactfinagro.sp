/************************************************************************/
/*      Archivo:                clactfinagro.sp                         */
/*      Stored procedure:       sp_act_finagro                          */
/*      Base de datos:          COBIS                                   */
/*      Producto:               CLIENTES                                */
/*      Fecha de escritura:     12/01/2010                              */
/************************************************************************/
/*                            IMPORTANTE                                */
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
/*                             PROPOSITO                                */
/*    Este programa valida y carga los archivos de finagro que          */
/*    genera el banco con los valores para cada cliente                 */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR               RAZON                       */
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
           where  name = 'sp_act_finagro')
  drop proc sp_act_finagro
go

create proc sp_act_finagro
(
  @t_show_version bit = 0,
  @i_param1       varchar(255) = null,--ARCHIVO A CARGAR
  @i_param2       varchar(255) = null,--PROCESO V validacion C cargue
  @i_param3       varchar(255) = null,--PATH
  @i_archivo      varchar(255) = null,
  @i_operacion    char(1) = null,
  @i_path         varchar(255) = null
)
as
  declare
    @w_sp_name  varchar(32),
    @w_return   int,
    @w_vente    int,
    @w_cliente  int,
    @w_vnid     varchar(16),
    @w_vtid     varchar(10),
    @w_actprin  varchar(10),
    @w_act1     varchar(10),
    @w_act2     varchar(10),
    @w_actprin1 varchar(10),
    @w_act11    varchar(10),
    @w_act21    varchar(10),
    @w_mensaje  varchar(50),
    @w_bandera  smallint,
    @w_archivo2 varchar(20),
    @w_archivo1 varchar(20),
    @w_cuenta   int,
    @w_date     datetime,
    @w_tipo_ced char(2),
    @w_ced_ruc  char(13),
    @w_reg      int,
    @w_arch     varchar(255),
    @w_reg_arch int,
    @w_ruta     varchar(100),
    @w_comando  varchar(255),
    @w_error    int,
    @w_s_app    varchar(255),
    @w_destino  varchar(255),
    @w_errores  varchar(255),
    @w_ente     int,
    @w_path_lis varchar(255)

  set ansi_warnings off

  select
    @i_archivo = convert (varchar(255), @i_param1)
  select
    @i_operacion = convert (char(1), @i_param2)
  select
    @i_path = convert (varchar(255), @i_param3)
  select
    @w_sp_name = 'sp_act_finagro'
  select
    @w_reg = 0
  select
    @w_arch = ''
  select
    @w_reg_arch = 0
  select
    @w_date = getdate()

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_path_lis = pp_path_destino
  from   cobis..ba_path_pro
  where  pp_producto = 2

  select
    @w_ruta = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  if exists (select
               1
             from   sysobjects
             where  name = 'cl_val_arch')
    drop table cl_val_arch

  create table cl_val_arch
  (
    registros varchar(255)
  )

  -- *****************************************************************************
  -- *****************************************************************************
  -- Opcion validacion con cargue
  -- *****************************************************************************
  -- *****************************************************************************

  if @i_operacion = 'C'
  begin
    select
      @w_comando = 'wc -l ' + @i_path + '\' + @i_archivo + ' > ' + @w_path_lis +
                          '\salida.out'

    exec @w_error = xp_cmdshell
      @w_comando
    if @w_error <> 0
    begin
      print 'Error validando cantidad de registros'
      print @w_comando
      return 1
    end

    select
      @w_s_app = 's_app bcp -auto -login cobis..cl_val_arch in '
    select
      @w_destino = @i_path + @i_archivo,
      @w_errores = @w_path_lis + @i_archivo + '.err'
    select
      @w_comando =
      @w_s_app + @w_path_lis + '\' + 'salida.out' + ' -b5000 -c -e' + @w_errores
      +
      ' -t"|" ' + '-config '+
                   + @w_ruta + 's_app.ini'

    exec @w_error = xp_cmdshell
      @w_comando
    if @w_error <> 0
    begin
      print 'Error Cargando numero de registros del archivo'
      print @w_comando
      return 1
    end

    select
      @w_arch = registros
    from   cobis..cl_val_arch

    select
      @w_reg_arch = convert(int, rtrim(ltrim(substring (ltrim(@w_arch),
                                                        1,
                                                        charindex(' ',
                                                                  ltrim(@w_arch)
                                             ))
                                       ))
                    )

    select
      @w_reg_arch = isnull(@w_reg_arch,
                           0)

    delete cobis..cl_carga_finagro
    delete cobis..cl_carga_finagro_val

    select
      @w_s_app = 's_app bcp -auto -login cobis..cl_carga_finagro in '
    select
      @w_destino = @i_path + @i_archivo,
      @w_errores = @w_path_lis + @i_archivo + '.err'
    select
      @w_comando = @w_s_app + @i_path + '\' + @i_archivo + ' -b5000 -c -e' +
                   @w_errores + ' -t"|" '
                   + '-config ' + @w_ruta
                   + 's_app.ini'

    exec @w_error = xp_cmdshell
      @w_comando
    if @w_error <> 0
    begin
      print 'Error Cargando archivo: ' + @i_archivo
      print @w_comando
      return 1
    end

    select
      @w_reg = count(1)
    from   cobis..cl_carga_finagro

    if @w_reg <> @w_reg_arch
    begin
      print '@w_reg ' + cast(@w_reg as varchar)
      print '@w_reg_arch ' + cast(@w_reg_arch as varchar)
      print 'NO SE CARGO EL ARCHIVO CORRECTAMENTE, POR FAVOR VALIDAR'
      return 1
    end

    if @w_reg = 0
    begin
      print '@w_reg ' + cast(@w_reg as varchar)
      print 'NO SE CARGO EL ARCHIVO CORRECTAMENTE, POR FAVOR VALIDAR'
      return 1
    end

    --identificar entes que no existen en Cobis
    insert into cobis..cl_carga_finagro_val
      select
        cf_ente,cf_nroid,cf_tipoid,cf_act_prin,cf_activid1,
        cf_activid2,'N','EL ENTE NO EXISTE '
      from   cobis..cl_carga_finagro
      where  cf_ente not in(select
                              en_ente
                            from   cobis..cl_ente (nolock))

    delete from cobis..cl_carga_finagro
    where  cf_ente not in(select
                            en_ente
                          from   cobis..cl_ente (nolock))

    --identificar entes que no tengan mercado objetivo definido en Cobis
    insert into cobis..cl_carga_finagro_val
      select
        cf_ente,cf_nroid,cf_tipoid,cf_act_prin,cf_activid1,
        cf_activid2,'N','EL ENTE NO TIENE MERCADO OBJETIVO '
      from   cobis..cl_carga_finagro
      where  cf_ente not in(select
                              mo_ente
                            from   cobis..cl_mercado_objetivo_cliente (nolock))

    delete from cobis..cl_carga_finagro
    where  cf_ente not in(select
                            mo_ente
                          from   cobis..cl_mercado_objetivo_cliente (nolock))

    --identificar entes con mercado objetivo diferente a Rural
    insert into cobis..cl_carga_finagro_val
      select
        cf_ente,cf_nroid,cf_tipoid,cf_act_prin,cf_activid1,
        cf_activid2,'N','MERCADO OBJETIVO DEL CLIENTE NO ES RURAL '
      from   cobis..cl_carga_finagro
      where  cf_ente in
             (select
                mo_ente
              from   cobis..cl_mercado_objetivo_cliente (nolock)
              where  mo_mercado_objetivo <> 'R')

    delete from cobis..cl_carga_finagro
    where  cf_ente in
           (select
              mo_ente
            from   cobis..cl_mercado_objetivo_cliente (nolock)
            where  mo_mercado_objetivo <> 'R')

    while 1 = 1
    begin
      set rowcount 1

      select
        @w_ente = cf_ente
      from   cobis..cl_carga_finagro
      if @@rowcount = 0
      begin
        set rowcount 0
        break
      end

      select
        @w_vente = cf_ente,
        @w_vnid = cf_nroid,
        @w_vtid = cf_tipoid,
        @w_actprin = cf_act_prin,
        @w_act1 = cf_activid1,
        @w_act2 = cf_activid2
      from   cobis..cl_carga_finagro
      where  cf_ente = @w_ente
      if @@rowcount = 0
      begin
        set rowcount 0
        break
      end

      -- print 'validando el ente ' + cast(@w_ente as varchar)

      begin tran

      select
        @w_bandera = 0
      -- validar que el ente exista
      select
        @w_mensaje = null
      select
        @w_cliente = en_ente,
        @w_ced_ruc = en_ced_ruc,
        @w_tipo_ced = en_tipo_ced
      from   cobis..cl_ente
      where  en_ente = @w_vente

      if @@rowcount = 0
      begin
        select
          @w_mensaje = 'EL ENTE NO EXISTE ' + cast(@w_ente as varchar)
        update cobis..cl_carga_finagro_val
        set    fv_validado = 'N',
               fv_msg = @w_mensaje
        where  fv_ente = @w_vente
        select
          @w_bandera = @w_bandera + 1
      end

      -- validar que tipo y nro sean del ente
      if @w_ced_ruc <> @w_vnid
      begin
        select
          @w_mensaje = 'EL NUMERO ID DEL ENTE ES DIFERENTE ' + cast(@w_ente as
                       varchar
                       )
        insert into cobis..cl_carga_finagro_val
                    (fv_ente,fv_nroid,fv_tipoid,fv_act_prin,fv_activid1,
                     fv_activid2,fv_validado,fv_msg)
        values      ( @w_vente,@w_vnid,@w_vtid,@w_actprin,@w_act1,
                      @w_act2,'N',@w_mensaje)
        select
          @w_bandera = @w_bandera + 1
      end

      if @w_tipo_ced <> @w_vtid
      begin
        select
          @w_mensaje = 'EL TIPO ID DEL ENTE ES DIFERENTE ' + cast(@w_ente as
                       varchar
                       )
        insert into cobis..cl_carga_finagro_val
                    (fv_ente,fv_nroid,fv_tipoid,fv_act_prin,fv_activid1,
                     fv_activid2,fv_validado,fv_msg)
        values      ( @w_vente,@w_vnid,@w_vtid,@w_actprin,@w_act1,
                      @w_act2,'N',@w_mensaje)
        select
          @w_bandera = @w_bandera + 1
      end

      if @w_actprin is null
      begin
        select
          @w_mensaje = 'EL ACTIVIDAD PRINCIAL ES OBLIGATORIA ' + @w_actprin
        insert into cobis..cl_carga_finagro_val
                    (fv_ente,fv_nroid,fv_tipoid,fv_act_prin,fv_activid1,
                     fv_activid2,fv_validado,fv_msg)
        values      ( @w_vente,@w_vnid,@w_vtid,@w_actprin,@w_act1,
                      @w_act2,'N',@w_mensaje)
        select
          @w_bandera = @w_bandera + 1
      end

      -- validar actividad principal
      if @w_actprin is not null
      begin
        select
          @w_mensaje = null
        select
          @w_actprin1 = C.codigo
        from   cobis..cl_tabla T,
               cobis..cl_catalogo C
        where  T.tabla  = 'cl_actividad_finagro'
           and T.codigo = C.tabla
           and C.codigo = @w_actprin

        if @@rowcount = 0
        begin
          select
            @w_mensaje = 'EL CODIGO ACTIVIDAD PRINCIPAL NO EXISTE ' + @w_actprin
          insert into cobis..cl_carga_finagro_val
                      (fv_ente,fv_nroid,fv_tipoid,fv_act_prin,fv_activid1,
                       fv_activid2,fv_validado,fv_msg)
          values      ( @w_vente,@w_vnid,@w_vtid,@w_actprin,@w_act1,
                        @w_act2,'N',@w_mensaje)
          select
            @w_bandera = @w_bandera + 1
        end
      end

      -- validar actividad1
      if @w_act1 is not null
      begin
        select
          @w_mensaje = 'EL CODIGO ACTIVIDAD1 NO EXISTE ' + @w_act1
        select
          @w_act11 = C.codigo
        from   cobis..cl_tabla T,
               cobis..cl_catalogo C
        where  T.tabla  = 'cl_actividad_finagro'
           and T.codigo = C.tabla
           and C.codigo = @w_act1

        if @@rowcount = 0
        begin
          insert into cobis..cl_carga_finagro_val
                      (fv_ente,fv_nroid,fv_tipoid,fv_act_prin,fv_activid1,
                       fv_activid2,fv_validado,fv_msg)
          values      ( @w_vente,@w_vnid,@w_vtid,@w_actprin,@w_act1,
                        @w_act2,'N',@w_mensaje)
          select
            @w_bandera = @w_bandera + 1
        end
      end

      -- validar actividad2
      if @w_act2 is not null
      begin
        select
          @w_mensaje = null
        select
          @w_act21 = C.codigo
        from   cobis..cl_tabla T,
               cobis..cl_catalogo C
        where  T.tabla  = 'cl_actividad_finagro'
           and T.codigo = C.tabla
           and C.codigo = @w_act2

        if @@rowcount = 0
        begin
          select
            @w_mensaje = 'EL CODIGO ACTIVIDAD2 NO EXISTE ' + @w_act2
          insert into cobis..cl_carga_finagro_val
                      (fv_ente,fv_nroid,fv_tipoid,fv_act_prin,fv_activid1,
                       fv_activid2,fv_validado,fv_msg)
          values      ( @w_vente,@w_vnid,@w_vtid,@w_actprin,@w_act1,
                        @w_act2,'N',@w_mensaje)
          select
            @w_bandera = @w_bandera + 1
        end
      end

      if (@w_actprin = @w_act1)
         and @w_act1 is not null
      begin
        select
          @w_mensaje = 'EL CODIGO ACTIVIDAD PRINCIAL ES IGUAL A ACTIVIDAD1 ' +
                       @w_actprin
                              + ' ' +
                              @w_act1
        insert into cobis..cl_carga_finagro_val
                    (fv_ente,fv_nroid,fv_tipoid,fv_act_prin,fv_activid1,
                     fv_activid2,fv_validado,fv_msg)
        values      ( @w_vente,@w_vnid,@w_vtid,@w_actprin,@w_act1,
                      @w_act2,'N',@w_mensaje)
        select
          @w_bandera = @w_bandera + 1
      end

      if (@w_actprin = @w_act2)
         and @w_act2 is not null
      begin
        select
          @w_mensaje = 'EL CODIGO ACTIVIDAD PRINCIAL ES IGUAL A ACTIVIDAD2 ' +
                       @w_actprin
                              + ' ' +
                              @w_act2
        insert into cobis..cl_carga_finagro_val
                    (fv_ente,fv_nroid,fv_tipoid,fv_act_prin,fv_activid1,
                     fv_activid2,fv_validado,fv_msg)
        values      ( @w_vente,@w_vnid,@w_vtid,@w_actprin,@w_act1,
                      @w_act2,'N',@w_mensaje)
        select
          @w_bandera = @w_bandera + 1
      end

      if (@w_act1 = @w_act2)
         and @w_act1 is not null
      begin
        select
          @w_mensaje = 'EL CODIGO ACTIVIDAD1 ES IGUAL A ACTIVIDAD2 ' + @w_act1 +
                       ' '
                       +
                              @w_act2
        insert into cobis..cl_carga_finagro_val
                    (fv_ente,fv_nroid,fv_tipoid,fv_act_prin,fv_activid1,
                     fv_activid2,fv_validado,fv_msg)
        values      ( @w_vente,@w_vnid,@w_vtid,@w_actprin,@w_act1,
                      @w_act2,'N',@w_mensaje)
        select
          @w_bandera = @w_bandera + 1
      end

      delete cobis..cl_carga_finagro
      where  cf_ente = @w_ente

      if @w_bandera = 0
      begin
        insert into cobis..cl_carga_finagro_val
                    (fv_ente,fv_nroid,fv_tipoid,fv_act_prin,fv_activid1,
                     fv_activid2,fv_validado,fv_msg)
        values      ( @w_vente,@w_vnid,@w_vtid,@w_actprin,@w_act1,
                      @w_act2,'S',null)

        --        update cobis..cl_ente
        --           set en_banca = @w_banca
        --        where  en_ente = @w_vente

        /* Verificar si el ente YA tiene asignado un mercado objetivo */
        select
          @w_cuenta = isnull(count(0),
                             0)
        from   cl_mercado_objetivo_cliente
        where  mo_ente = @w_vente

        if @w_cuenta > 0
        begin
          update cobis..cl_mercado_objetivo_cliente
          set    mo_actprincipal = @w_actprin,
                 mo_actividad2 = @w_act1,
                 mo_actividad3 = @w_act2,
                 mo_funcionario = 'operador',
                 mo_fecha_modificacion = @w_date
          where  mo_ente = @w_vente

        end

      /*
            if @w_cuenta = 0 begin
             /* Insercion cl_mercado_objetivo_cliente */
             insert into cl_mercado_objetivo_cliente
                    (mo_ente,
                     mo_mercado_objetivo,
                     mo_subtipo_mo,
                     mo_fecha_registro,
                     mo_funcionario,
                     mo_segmento,
                     mo_subsegmento,
                     mo_actprincipal,
                     mo_actividad2,
                     mo_actividad3)
             values
                    (@w_vente,
                     'R',
                     '002',
                     @w_date,
                     'operador',
                     null,
                     null,
                     @w_actprin,
                     @w_act1,
                     @w_act2)
            end
      */

      end

      commit tran
      siguiente_d1:
    end --endW

    -- ***********************************
    -- Generacion archivo aprobaciones
    -- ***********************************

    select
      @w_archivo1 = 'finCapro_' + @i_archivo
    delete from cobis..cl_fin_aprobado
    insert into cobis..cl_fin_aprobado
      select
        'Ente' = fv_ente,'N£mero_ID' = fv_nroid,'Tipo_ID' = fv_tipoid,
        'Actividad principal' = fv_act_prin,
        'Actorin Actual' = isnull(mo_actprincipal,
                                  'NULL'),
        'Actividad1' = fv_activid1,'Actividad1 Actual' = isnull(mo_actividad2,
                                     'NULL'),'Actividad2' = fv_activid2,
        'Actividad2 Actual' = isnull(mo_actividad3,
                                     'NULL')
      from   cobis..cl_mercado_objetivo_cliente (nolock),
             cobis..cl_carga_finagro_val (nolock)
      where  fv_ente     = mo_ente
         and fv_validado = 'S'
      order  by fv_ente

    select
      @w_comando = 'echo '
    select
      @w_comando = @w_comando
                   +
'Ente;Numero_ID;Tipo_ID;Actividad Principal;Actprin Actual;Actividad1;Actividad1 Actual;Actividad2;Actividad1 Actual'
  select
    @w_comando = @w_comando + ' > ' + @w_path_lis + @w_archivo1 + '.csv'

  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    print 'Error generando archivo'
    print @w_comando
    return 1
  end

  select
    @w_s_app = 's_app bcp -auto -login cobis..cl_fin_aprobado out '
  select
    @w_destino = @w_path_lis + 'temporal.bcp',
    @w_errores = @w_path_lis + @w_archivo1 + '.err'
  select
    @w_comando =
    @w_s_app + @w_path_lis + 'temporal.bcp' + ' -b5000 -c -e' + @w_errores +
    ' -t";" ' + '-config '+
                 + @w_ruta + 's_app.ini'

  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    print 'Error generando archivo aprobaciones'
    print @w_comando
    return 1
  end

  select
    @w_comando = 'type ' + @w_path_lis + 'temporal.bcp' + ' >> ' + @w_path_lis +
                 '\'
                              +
                              @w_archivo1 + '.csv'

  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    print 'Error generando Archivo Aprobaciones: ' + @w_archivo1
    print @w_comando
    print @w_error
  end

  -- ***********************************
  --Generacion archivo rechazos
  -- ***********************************

  select
    @w_archivo2 = 'finCrech_' + @i_archivo
  delete from cobis..cl_fin_rechazado
  insert into cobis..cl_fin_rechazado
    select
      'Ente' = fv_ente,'N£mero_ID' = fv_nroid,'Tipo_ID' = fv_tipoid,
      'Actividad principal' = fv_act_prin,
      'Actorin Actual' = isnull(mo_actprincipal,
                                'NULL'),
      'Actividad1' = fv_activid1,'Actividad1 Actual' = isnull(mo_actividad2,
                                   'NULL'),'Actividad2' = fv_activid2,
      'Actividad2 Actual' = isnull(mo_actividad3,
                                   'NULL'),'Rechazo' = fv_msg
    from   cobis..cl_mercado_objetivo_cliente (nolock),
           cobis..cl_carga_finagro_val (nolock)
    where  fv_ente     = mo_ente
       and fv_validado = 'N'
    union
    select
      'Ente' = fv_ente,'N£mero_ID' = fv_nroid,'Tipo_ID' = fv_tipoid,
      'Actividad principal' = fv_act_prin,'Actorin Actual' = 'NULL',
      'Actividad1' = fv_activid1,'Actividad1 Actual' = 'NULL',
      'Actividad2' = fv_activid2,'Actividad2 Actual' = 'NULL','Rechazo' = fv_msg
    from   cobis..cl_carga_finagro_val (nolock)
    where  fv_msg in ('EL ENTE NO EXISTE', 'EL ENTE NO TIENE MERCADO OBJETIVO')
       and fv_validado = 'N'
    order  by fv_ente

  select
    @w_comando = 'echo '
  select
    @w_comando = @w_comando
                 +
'Ente;Numero_ID;Tipo_ID;Actividad Principal;Actprin Actual;Actividad1;Actividad1 Actual;Actividad2;Actividad1 Actual'
  select
    @w_comando = @w_comando + ' > ' + @w_path_lis + @w_archivo2 + '.csv'

  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    print 'Error generando archivo'
    print @w_comando
    return 1
  end

  select
    @w_s_app = 's_app bcp -auto -login cobis..cl_fin_rechazado out '
  select
    @w_destino = @w_path_lis + 'temporal.bcp',
    @w_errores = @w_path_lis + @w_archivo2 + '.err'
  select
    @w_comando =
    @w_s_app + @w_path_lis + 'temporal.bcp' + ' -b5000 -c -e' + @w_errores +
    ' -t";" ' + '-config '+
                 + @w_ruta + 's_app.ini'

  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    print 'Error generando archivo aprobaciones'
    print @w_comando
    return 1
  end

  select
    @w_comando = 'type ' + @w_path_lis + 'temporal.bcp' + ' >> ' + @w_path_lis +
                 '\'
                              +
                              @w_archivo2 + '.csv'

  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    print 'Error generando Archivo Aprobaciones: ' + @w_archivo2
    print @w_comando
    print @w_error
  end
end

  return 0

go

