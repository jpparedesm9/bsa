
/************************************************************************/
/*  Archivo:            dir_dml.sp                                      */
/*  Stored procedure:   sp_direccion_dml                                */
/*  Base de datos:      cobis                                           */
/*  Producto: Clientes                                                  */
/*  Disenado por:  Mauricio Bayas/Sandra Ortiz                          */
/*  Fecha de escritura: 07-Nov-1992                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este programa procesa las transacciones DML de direcciones          */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA           AUTOR         RAZON                                 */
/*  05/Abr/2010     R. Altamirano Control de vigencia de datos del Ente */
/*  24/Ene/12       L. Moreno     Cambia fecha proceso por fecha sistema*/
/*  18/Abr/2013     D. Alfonso    Realizar en modo Batch la inserción   */
/*                                masiva de datos de direcciones        */
/*                                específicamente                       */
/*  09/04/2013      A. Munoz      Requerimiento 0353 Alianzas           */
/*  03/May/2016     T. Baidal     Migracion a CEN                       */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_direccion_dml')
           drop proc sp_direccion_dml
go

create proc sp_direccion_dml
(
  @s_ssn                 int,
  @s_user                login = null,
  @s_term                varchar(30) = null,
  @s_date                datetime,
  @s_srv                 varchar(30) = null,
  @s_lsrv                varchar(30) = null,
  @s_ofi                 smallint = null,
  @s_rol                 smallint = null,
  @s_org_err             char(1) = null,
  @s_error               int = null,
  @s_sev                 tinyint = null,
  @s_msg                 descripcion = null,
  @s_org                 char(1) = null,
  @t_debug               char(1) = 'N',
  @t_file                varchar(10) = null,
  @t_from                varchar(32) = null,
  @t_trn                 smallint = null,
  @t_show_version        bit = 0,
  @i_operacion           char(1),
  @i_ente                int = null,
  @i_direccion           tinyint = null,
  @i_descripcion         varchar(254)= null,
  @i_tipo                catalogo = null,
  @i_sector              catalogo = null,
  @i_parroquia           smallint = null,
  @i_barrio              char(40) = null,
  @i_zona                catalogo = null,
  @i_ciudad              int = null,
  @i_oficina             smallint = null,
  @i_verificado          char(1) = 'N',
  @i_fecha_ver           datetime = null,
  @i_principal           char(1) = 'N',
  @i_provincia           smallint = null,
  @i_tienetel            char(1) = null,
  @i_rural_urb           char(1) = null,
  @i_observacion         varchar(80) = null,
  @i_resultado           catalogo = null,
  @i_llamado             tinyint = 0,

  /* REQUERIMIENTO 349 */
  @i_linea               char(1) = 'S',
  @i_crea_ext            char(1) = null,-- Req. 353 Alianzas Comerciales
  @o_siguiente_direccion int = null out,
  @o_mensaje_retorno     varchar(80) = null out,
  @o_msg_msv             varchar(255)= null out -- Req. 353 Alianzas Comerciales
--  @i_fecha_recidencia datetime = null

)
as
  declare
    @w_transaccion        int,
    @w_sp_name            varchar(32),
    @w_codigo             int,
    @w_error              int,
    @w_return             int,
    @w_descripcion        varchar(254),
    @w_tipo               catalogo,
    @w_sector             catalogo,
    @w_zona_ant           catalogo,
    @w_zona               catalogo,
    @w_parroquia          smallint,
    @w_barrio             char(40),
    @w_ciudad             int,
    @w_oficina            smallint,
    @w_verificado         char(1),
    @w_vigencia           char(1),
    @w_principal          char(1),
    @w_resultado          catalogo,
    --  @w_fecha_recidencia  datetime,

    @v_descripcion        varchar(254),
    @v_tipo               catalogo,
    @v_sector             catalogo,
    @v_zona               catalogo,
    @v_parroquia          smallint,
    @v_barrio             char(40),
    @v_ciudad             int,
    @v_oficina            smallint,
    @v_verificado         char(1),
    @v_vigencia           char(1),
    @v_principal          char(1),
    @v_resultado          catalogo,
    --  @v_fecha_recidencia datetime,

    @o_ente               int,
    @o_ennombre           descripcion,
    @o_cedruc             numero,
    @o_direccion          tinyint,
    @o_descripcion        varchar(254),
    @o_ciudad             int,
    @o_cinombre           descripcion,
    @o_parroquia          smallint,
    @o_barrio             char(40),
    @o_pqnombre           descripcion,
    @o_tipo               catalogo,
    @o_tinombre           descripcion,
    @o_sector             catalogo,
    @o_sector_nombre      descripcion,
    @o_zona               catalogo,
    @o_zona_nombre        descripcion,
    @o_telefono           tinyint,
    @o_valor              varchar(12),
    @o_siguiente          int,
    @o_oficina            smallint,
    @o_ofinombre          descripcion,
    @o_verificado         char(1),
    @o_vigencia           char(1),
    @o_principal          char(1),
    @o_fecha_registro     datetime,
    @o_fecha_modificacion datetime,
    --  @o_fecha_recidencia datetime,

    @w_provincia          smallint,
    @v_provincia          smallint,
    @w_direccion          varchar(3),
    @w_funcionario        login,
    @v_funcionario        login,
    @w_bandera            tinyint,
    @w_bloqueado          char(1),
    @v_rural_urb          char(1),
    @v_observacion        varchar(80),
    @w_rural_urb          char(1),
    @w_observacion        varchar(80),
    @w_tdn                catalogo,
    @w_ofi_prd            smallint,
    @w_oficial            smallint,
    @w_dif_oficial        tinyint,
    @w_subtipo            char(1),
    @w_tipo_vin           catalogo,
    @w_ofiprod            varchar(10),
    @w_commit             char(1)

  --version /*  14/Jul/2009     E. Laguna      oficina producto   */

  select
    @w_sp_name = 'sp_direccion_dml'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_commit = 'N'

  select
    @w_subtipo = en_subtipo,
    @w_tipo_vin = p_tipo_persona
  from   cl_ente
  where  en_ente = @i_ente

  if @@rowcount = 0
  begin
    if @i_crea_ext is null
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @i_num   = 101042
      /*'No existe ente'*/
      return 101042
    end
    else
    begin
      select
        @o_msg_msv = 'Error: No existe Ente: ' + convert(varchar(8), isnull(
                     @i_ente,
                     0
                     ))
                            + ', ' +
                            @w_sp_name
      select
        @w_return = 101042
      return @w_return
    end
  end

  /** Insert **/
  if @i_operacion = 'I'
  begin
    if @t_trn = 109
    begin
      if @i_tipo <> '001'
      begin
        if @i_linea = 'S'
        begin
          if not exists (select
                           pv_provincia
                         from   cl_provincia
                         where  pv_provincia = @i_provincia)
          begin
            select
              @w_return = 101038
            goto ERROR_FIN
          /* 'No existe provincia'*/
          end

          if not exists (select
                           ci_ciudad
                         from   cl_ciudad
                         where  ci_ciudad = @i_ciudad)
          begin
            select
              @w_return = 101024
            goto ERROR_FIN
          /* 'No existe ciudad'*/
          end
        end
      end
      else
      begin
        select
          @i_ciudad = d.codigo
        from   cobis..cl_default d,
               cobis..cl_tabla t
        where  d.tabla   = t.codigo
           and t.tabla   = 'cl_ciudad'
           and d.oficina = @s_ofi

        if @@rowcount = 0
        begin
          select
            @w_return = 101024
          goto ERROR_FIN
        /* 'No existe ciudad'*/
        end

        select
          @i_provincia = d.codigo
        from   cobis..cl_default d,
               cobis..cl_tabla t
        where  d.tabla   = t.codigo
           and t.tabla   = 'cl_provincia'
           and d.oficina = @s_ofi

        if @@rowcount = 0
        begin
          select
            @w_return = 101038
          goto ERROR_FIN
        /* 'No existe ciudad'*/
        end

        select
          @i_parroquia = 0
      end

      if @i_linea = 'S'
      begin
        if not exists (select
                         of_oficina
                       from   cl_oficina
                       where  of_oficina = @i_oficina)
           and @i_oficina is not null
        begin
          select
            @w_return = 101016
          goto ERROR_FIN
        /* 'No existe oficina'*/
        end
      end

      if @i_linea = 'S'
      begin
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_tabla     = 'cl_tdireccion',
          @i_operacion = 'E',
          @i_codigo    = @i_tipo
        if @w_return <> 0
        begin
          select
            @w_return = 101025
          goto ERROR_FIN
        end
      end

      /* Verificar que no exista mas de una direccion como Principal NVR*/
      if @i_principal = 'S'
      begin
        if exists (select
                     di_direccion
                   from   cl_direccion
                   where  di_ente      = @i_ente
                      and di_principal = 'S')
        begin
          select
            @w_return = 101187
          goto ERROR_FIN

        end
      end

      select
        @w_tdn = pa_char
      from   cobis..cl_parametro
      where  pa_producto = 'MIS'
         and pa_nemonico = 'TDN'

      if @i_tipo = @w_tdn
      begin
        if exists (select
                     di_direccion
                   from   cl_direccion
                   where  di_ente = @i_ente
                      and di_tipo = @w_tdn)
        begin
          select
            @w_return = 101226
          goto ERROR_FIN
        end

        if @i_zona is null
        begin
          select
            @w_return = 101187
          goto ERROR_FIN
        end
        else
        begin
          select
            @i_zona = of_oficina
          from   cl_oficina
          where  of_oficina = @i_zona

          if @@rowcount = 0
          begin
            select
              @w_return = 101016
            goto ERROR_FIN
          /* 'No existe oficina'*/
          end
        end
        select
          @w_ofi_prd = @i_zona
      end
      else
        select
          @w_ofi_prd = null

      if @i_crea_ext is null
      begin
        begin tran
        select
          @w_commit = 'S'
      end

      update cl_ente
      set    en_direccion = isnull(en_direccion, 0) + 1,
             en_oficina_prod = isnull (@w_ofi_prd,
                                       en_oficina_prod)
      where  en_ente = @i_ente

      if @@error <> 0
      begin
        select
          @w_return = 105034
        goto ERROR_FIN
      /* 'Error en incremento de direccion'*/
      end

      select
        @o_siguiente = isnull(max (di_direccion),
                              0)
      from   cl_direccion
      where  di_ente = @i_ente

      if @o_siguiente = 0
        select
          @o_siguiente = 1
      else
        select
          @o_siguiente = @o_siguiente + 1
      select
        @o_siguiente_direccion = @o_siguiente

      if @i_rural_urb = 'U'
      begin
        if @i_parroquia is null
           and isnumeric(@i_barrio) = 1
          select
            @i_parroquia = convert(smallint, @i_barrio)
        select
          @i_barrio = ''
      end
      else
        select
          @i_parroquia = 0

      select
        @i_parroquia = isnull(@i_parroquia,
                              0)

      insert into cl_direccion
                  (di_ente,di_direccion,di_descripcion,di_tipo,di_telefono,
                   di_vigencia,di_fecha_registro,di_fecha_modificacion,di_sector
                   ,
                   di_zona,
                   di_parroquia,di_ciudad,di_oficina,di_verificado,di_principal,
                   di_barrio,di_funcionario,di_provincia,di_tienetel,
                   di_rural_urb,
                   di_observacion
      --      di_fecha_recidencia
      )
      values      (@i_ente,@o_siguiente,@i_descripcion,@i_tipo,0,
                   'S',getdate(),getdate(),@i_sector,@i_zona,
                   @i_parroquia,@i_ciudad,@i_oficina,'N',@i_principal,
                   @i_barrio,@s_user,@i_provincia,@i_tienetel,@i_rural_urb,
                   @i_observacion
      --      @i_fecha_recidencia
      )

      if @@error <> 0
      begin
        select
          @w_return = 103007
        goto ERROR_FIN
      /* 'Error en creacion de direccion'*/
      end

      /* Transaccion servicios - cl_direccion */
      insert into ts_direccion
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,direccion,
                   descripcion,sector,zona,parroquia,ciudad,
                   tipo,vigencia,oficina,verificado,barrio,
                   provincia,rural_urbano) --,observacion)
      values     (@s_ssn,@t_trn,'N',@s_date,@s_user,
                  @s_term,@s_srv,@s_lsrv,@i_ente,@o_siguiente,
                  substring(@i_descripcion,
                            1,
                            63),@i_sector,@i_zona,@i_parroquia,@i_ciudad,
                  @i_tipo,'S',@i_oficina,'N',@i_barrio,
                  @i_provincia,@i_rural_urb) --,@i_observacion )

      if @@error <> 0
      begin
        select
          @w_return = 103005
        goto ERROR_FIN
      /* 'Error en creacion de transaccion de servicio'*/
      end

      if @i_tipo = @w_tdn
      begin
        /* Encontrar oficial SIPLA */
        exec @w_return = cobis..sp_funcionario_oficina
          -- sp_helptext  sp_funcionario_oficina
          @s_ssn         = @s_ssn,
          @s_date        = @s_date,
          @s_ofi         = @w_ofi_prd,
          @t_debug       = @t_debug,
          @t_file        = @t_file,
          @t_trn         = null,
          @i_operacion   = 'Q',
          @i_tipo        = @w_tipo_vin,
          @i_linea       = 'N',
          @i_crea_ext    = @i_crea_ext,-- 353
          @o_msg_msv     = @o_msg_msv out,-- 353
          @o_funcionario = @w_oficial out

        if @w_return <> 0
        begin
          goto ERROR_FIN
        end

        /* Asignacion automatica de Oficial SIPLA */
        if @w_oficial is not null
        begin
          exec @w_return = cobis..sp_asesor_upd
            -- sp_helptext sp_asesor_upd  *****
            @s_ssn         = @s_ssn,
            @s_user        = @s_user,
            @s_term        = @s_term,
            @s_srv         = @s_srv,
            @s_lsrv        = @s_lsrv,
            @t_trn         = 1316,
            @i_tipo_cli    = @w_subtipo,
            @i_operacion   = 'U',
            @i_ente        = @i_ente,
            @i_filial      = 1,
            @i_linea       = 'N',
            @i_oficina     = @w_ofi_prd,
            @i_oficial     = @w_oficial,
            @i_crea_ext    = @i_crea_ext,
            @o_dif_oficial = @w_dif_oficial out

          if @w_return <> 0
          begin
            goto ERROR_FIN
          end
        end
      end

      if @i_crea_ext is null
        commit tran

      if @i_crea_ext is null
        select
          @o_siguiente

      /*MGV Buscar estado de bloqueo del ente por informacion incompleta       */
      if @i_linea = 'S'
      begin
        exec sp_ente_bloqueado -- sp_helptext sp_ente_bloqueado
          @s_ssn       = @s_ssn,
          @s_user      = @s_user,
          @s_term      = @s_term,
          @s_date      = @s_date,
          @s_srv       = @s_srv,
          @s_lsrv      = @s_lsrv,
          @s_ofi       = @s_ofi,
          @s_rol       = @s_rol,
          @s_org_err   = @s_org_err,
          @s_error     = @s_error,
          @s_sev       = @s_sev,
          @s_msg       = @s_msg,
          @s_org       = @s_org,
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @t_from,
          @t_trn       = 176,
          @i_operacion = 'U',
          @i_linea     = 'N',
          @i_ente      = @i_ente,
          @o_retorno   = @w_bloqueado output

        /* MGV Fin Buscar       */

        if exists (select
                     1
                   from   cobis..cl_telefono
                   where  te_tipo_telefono = 'C'
                      and te_ente          = @i_ente)
        begin
          select
            @w_bandera = 1
        end
        else
        begin
          --SLI cambio mensaje NR494
          if @i_tipo <> '001'
          begin
            if @i_crea_ext is null
              print
          'Recuerde solicitar el numero de telefono celular al cliente'
          end
        --print 'Favor ingresar un número de telefono Celular'
        end
      end--linea
      return 0
    end
    else
    begin
      select
        @w_return = 151051
      goto ERROR_FIN
    /*  'No corresponde codigo de transaccion' */
    end
  end

  /** Update **/
  if @i_operacion = 'U'
  begin
    if @t_trn = 110
        or @t_trn = 1347
    begin
      if @i_linea = 'S'
      begin
        if not exists (select
                         ci_ciudad
                       from   cl_ciudad
                       where  ci_ciudad = @i_ciudad)
           and @i_tipo <> '001'
        begin
          select
            @w_return = 101024
          goto ERROR_FIN
        /* 'No existe ciudad'*/
        end

        if not exists (select
                         of_oficina
                       from   cl_oficina
                       where  of_oficina = @i_oficina)
           and @i_oficina is not null
        begin
          select
            @w_return = 101016
          goto ERROR_FIN
        /* 'No existe oficina'*/
        end

        if @i_oficina is null
          select
            @i_oficina = @s_ofi

        if not exists (select
                         codigo
                       from   cl_catalogo
                       where  tabla  = (select
                                          codigo
                                        from   cl_tabla
                                        where  tabla = 'cl_tdireccion')
                          and codigo = @i_tipo)
        begin
          select
            @w_return = 101025
          goto ERROR_FIN
        /* 'No existe tipo de direccion'*/
        end

        if @i_verificado <> 'S'
           and @i_verificado <> 'N'
        begin
          select
            @w_return = 101114
          goto ERROR_FIN
        /* Parametro Invalido'*/
        end
      end
      /* Verificar que no exista mas de una direccion como principal y de extracto NVR */
      select
        @w_principal = di_principal
      from   cl_direccion
      where  di_ente      = @i_ente
         and di_direccion = @i_direccion

      if @w_principal <> 'S'
      begin
        if @i_principal = 'S'
        begin
          if exists (select
                       di_direccion
                     from   cl_direccion
                     where  di_ente      = @i_ente
                        and di_principal = 'S')
          begin
            select
              @w_return = 101187
            goto ERROR_FIN
          /* Ya existe una direccion como Principal */
          end
        end
      end

      if @i_tipo = '001'
      begin
        select
          @i_ciudad = d.codigo
        from   cobis..cl_default d,
               cobis..cl_tabla t
        where  d.tabla   = t.codigo
           and t.tabla   = 'cl_ciudad'
           and d.oficina = @s_ofi

        if @@rowcount = 0
        begin
          if @i_crea_ext is null
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101024
            /* 'No existe ciudad'*/
            return 1
          end
          else
          begin
            select
              @o_msg_msv = 'Error: No existe Ciudad, ' + @w_sp_name
            select
              @w_return = 101024
            return @w_return
          end
        end

        select
          @i_provincia = d.codigo
        from   cobis..cl_default d,
               cobis..cl_tabla t
        where  d.tabla   = t.codigo
           and t.tabla   = 'cl_provincia'
           and d.oficina = @s_ofi

        if @@rowcount = 0
        begin
          select
            @w_return = 101038
          goto ERROR_FIN
        /* 'No existe provincia'*/
        end

        select
          @i_parroquia = 0
      end

      /* Chequeo de campos a actualizar */
      select
        @w_descripcion = di_descripcion,
        @w_tipo = di_tipo,
        @w_parroquia = di_parroquia,
        @w_barrio = di_barrio,
        @w_principal = di_principal,
        @w_ciudad = di_ciudad,
        @w_sector = di_sector,
        @w_vigencia = di_vigencia,
        @w_oficina = di_oficina,
        @w_verificado = di_verificado,
        @w_zona = di_zona,
        @w_provincia = di_provincia,
        @w_funcionario = di_funcionario,
        @w_rural_urb = di_rural_urb,
        @w_observacion = di_observacion,
        @w_resultado = di_obs_verificado
      --  @w_fecha_recidencia = di_fecha_recidencia
      from   cl_direccion
      where  di_ente      = @i_ente
         and di_direccion = @i_direccion

      if @@rowcount <> 1
      begin
        select
          @w_return = 101059
        goto ERROR_FIN
      /* 'No existe direccion'*/
      end

      select
        @v_descripcion = @w_descripcion,
        @v_tipo = @w_tipo,
        @v_parroquia = @w_parroquia,
        @v_barrio = @w_barrio,
        @v_principal = @w_principal,
        @v_ciudad = @w_ciudad,
        @v_sector = @w_sector,
        @v_vigencia = @w_vigencia,
        @v_oficina = @w_oficina,
        @v_verificado = @w_verificado,
        @v_zona = @w_zona,
        @v_provincia = @w_provincia,
        @v_funcionario = @w_funcionario,
        @v_rural_urb = @w_rural_urb,
        @v_observacion = @w_observacion,
        @v_resultado = @w_resultado

      --  @v_fecha_recidencia = @w_fecha_recidencia

      if @w_descripcion = @i_descripcion
        select
          @w_descripcion = null,
          @v_descripcion = null
      else
        select
          @w_descripcion = @i_descripcion

      if @w_oficina = @i_oficina
        select
          @w_oficina = null,
          @v_oficina = null
      else
        select
          @w_oficina = @i_oficina

      if @w_verificado = @i_verificado
        select
          @w_verificado = null,
          @v_verificado = null
      else
        select
          @w_verificado = @i_verificado

      if @w_tipo = @i_tipo
        select
          @w_tipo = null,
          @v_tipo = null
      else
        select
          @w_tipo = @i_tipo
      if @w_sector = @i_sector
        select
          @w_sector = null,
          @v_sector = null
      else
        select
          @w_sector = @i_sector
      if @w_provincia = @i_provincia
        select
          @w_provincia = null,
          @v_provincia = null
      else
        select
          @w_provincia = @i_provincia

      /*actualiza direccion principal  */

      if @w_principal = @i_principal
        select
          @w_principal = null,
          @v_principal = null
      else
        select
          @w_principal = @i_principal

      if @w_ciudad = @i_ciudad
        select
          @w_ciudad = null,
          @v_ciudad = null
      else
        select
          @w_ciudad = @i_ciudad

      if @w_zona = @i_zona
        select
          @w_zona = null,
          @v_zona = null
      else
        select
          @w_zona = @i_zona

      if @w_barrio = @i_barrio
        select
          @w_barrio = null,
          @v_barrio = null
      else
        select
          @w_barrio = @i_barrio

      if @w_rural_urb = @i_rural_urb
        select
          @w_rural_urb = null,
          @v_rural_urb = null
      else
        select
          @w_rural_urb = @i_rural_urb

      if @w_observacion = @i_observacion
        select
          @w_observacion = null,
          @v_observacion = null
      else
        select
          @w_observacion = @i_observacion

      if @w_funcionario = @s_user
        select
          @v_funcionario = null
      else
        select
          @w_funcionario = @s_user

      if @w_resultado = @i_resultado
        select
          @w_resultado = null,
          @v_resultado = null
      else
        select
          @w_resultado = @i_resultado

      --   if @w_fecha_recidencia  = @i_fecha_recidencia
      --       select @w_fecha_recidencia= null, @v_fecha_recidencia = null
      --   else
      --       select @w_fecha_recidencia  = @i_fecha_recidencia

      if @i_rural_urb = 'U'
      begin
        if @i_parroquia is null
           and isnumeric(@i_barrio) = 1
          select
            @i_parroquia = convert(smallint, @i_barrio)

        select
          @i_barrio = ''
      end
      else
        select
          @i_parroquia = ''

      select
        @w_vigencia = null,
        @v_vigencia = null --ream 05.abr.2010 control vigencia de datos del ente

      if @i_tipo = '001'
        select
          @i_parroquia = isnull(@i_parroquia,
                                0)

      if @i_crea_ext is null
      begin
        begin tran
        select
          @w_commit = 'S'
      end

      update cl_direccion
      set    di_descripcion = @i_descripcion,
             di_tipo = @i_tipo,
             di_parroquia = @i_parroquia,
             di_barrio = @i_barrio,
             di_ciudad = @i_ciudad,
             di_sector = @i_sector,
             di_principal = @i_principal,
             di_vigencia = isnull(@w_vigencia,
                                  di_vigencia),
             --ream 05.abr.2010 control vigencia de datos del ente
             di_fecha_modificacion = getdate(),
             di_oficina = @i_oficina,
             di_verificado = @i_verificado,
             di_zona = @i_zona,
             di_fecha_ver = @i_fecha_ver,
             di_funcionario = @w_funcionario,
             di_provincia = @i_provincia,
             di_tienetel = isnull(@i_tienetel,
                                  di_tienetel),
             di_rural_urb = @i_rural_urb,
             di_observacion = @i_observacion,
             di_obs_verificado = @i_resultado
      -- di_fecha_recidencia = @i_fecha_recidencia
      where  di_ente      = @i_ente
         and di_direccion = @i_direccion

      if @@error <> 0
      begin
        select
          @w_return = 105034
        goto ERROR_FIN
      /* 'Error en actualizacion de direccion'*/
      end

      /* Transaccion servicio - cl_direccion */
      insert into ts_direccion
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,direccion,
                   descripcion,sector,vigencia,zona,parroquia,
                   ciudad,tipo,oficina,verificado,barrio,
                   provincia,rural_urbano --,observacion
      --  fecha_recidencia
      )
      values     (@s_ssn,@t_trn,'P',@s_date,@v_funcionario,
                  @s_term,@s_srv,@s_lsrv,@i_ente,@i_direccion,
                  @v_descripcion,@v_sector,@v_vigencia,@v_zona,@v_parroquia,
                  @v_ciudad,@v_tipo,@v_oficina,@v_verificado,@v_barrio,
                  @v_provincia,@v_rural_urb--,@v_observacion
      --  @v_fecha_recidencia
      )

      if @@error <> 0
      begin
        select
          @w_return = 103005
        goto ERROR_FIN
      /* 'Error en creacion de transaccion de servicio'*/
      end

      insert into ts_direccion
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,direccion,
                   descripcion,sector,vigencia,zona,parroquia,
                   ciudad,tipo,oficina,verificado,barrio,
                   provincia,rural_urbano --,observacion
      --  fecha_recidencia
      )
      values     (@s_ssn,@t_trn,'A',@s_date,@w_funcionario,
                  @s_term,@s_srv,@s_lsrv,@i_ente,@i_direccion,
                  @w_descripcion,@w_sector,@w_vigencia,@w_zona,@w_parroquia,
                  @w_ciudad,
                  --ream 05.abr.2010 control vigencia de datos del ente
                  @w_tipo,@w_oficina,@w_verificado,@w_barrio,
                  @w_provincia,@w_rural_urb--,@w_observacion
      --  @w_fecha_recidencia
      )

      if @@error <> 0
      begin
        select
          @w_return = 103005
        goto ERROR_FIN
      /* 'Error en creacion de transaccion de servicio'*/
      end

      select
        @w_ofiprod = en_oficina_prod
      from   cobis..cl_ente
      where  en_ente = @i_ente

      if @w_ofiprod is null
      begin
        select
          @w_ofiprod = di_zona
        from   cobis..cl_direccion
        where  di_ente = @i_ente
           and di_tipo = '011'

        if @w_ofiprod is not null
        begin
          update cobis..cl_ente
          set    en_oficina_prod = convert(smallint, @w_ofiprod)
          where  en_ente = @i_ente
        end

      end

      /*  Actualizacion de cl_det_producto */

      if @v_descripcion <> @w_descripcion
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
        values      (@i_ente,getdate(),'cl_direccion','di_descripcion',
                     @v_descripcion,
                     @w_descripcion,'U',@i_direccion,null)
        if @@error <> 0
        begin
          select
            @w_return = 103001
          goto ERROR_FIN
        /*'Error en creacion de cliente'*/
        end
      end
      if @v_zona <> @w_zona
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
        values      (@i_ente,getdate(),'cl_direccion','di_zona',@v_zona,
                     @w_zona,'U',@i_direccion,null)
        if @@error <> 0
        begin
          select
            @w_return = 103001
          goto ERROR_FIN
        /*'Error en creacion de cliente'*/
        end
      end

      if @i_crea_ext is null
        commit tran

      /*MGV Buscar estado de bloqueo del ente por informacion incompleta       */
      if @i_linea = 'S'
      begin
        exec sp_ente_bloqueado --   sp_helptext sp_ente_bloqueado
          @s_ssn       = @s_ssn,
          @s_user      = @s_user,
          @s_term      = @s_term,
          @s_date      = @s_date,
          @s_srv       = @s_srv,
          @s_lsrv      = @s_lsrv,
          @s_ofi       = @s_ofi,
          @s_rol       = @s_rol,
          @s_org_err   = @s_org_err,
          @s_error     = @s_error,
          @s_sev       = @s_sev,
          @s_msg       = @s_msg,
          @s_org       = @s_org,
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @t_from,
          @t_trn       = 176,
          @i_operacion = 'U',
          @i_linea     = 'N',
          @i_ente      = @i_ente,
          @o_retorno   = @w_bloqueado output

        /* MGV Fin Buscar       */

        if exists (select
                     1
                   from   cobis..cl_telefono
                   where  te_tipo_telefono = 'C'
                      and te_ente          = @i_ente)
          if @i_llamado <> 0
          begin
            select
              @w_bandera = 1
          end
          else
          begin
            --SLI cambio mensaje NR494
            if @i_tipo <> '001'
            begin
              if @i_crea_ext is null
                print
            'Recuerde solicitar el numero de telefono celular al cliente'
            --print 'Favor ingresar un número de telefono Celular'
            end
          end

        if @w_tipo_vin in ('002', '004', '005')
        begin
          /*CARGA DE INFORMACION DEL CLIENTE PROVEEDORES HACIA DYNAMICS */

          exec @w_return = cobis..sp_cobis_dynamics
            -- sp_helptext  sp_cobis_dynamics   ****
            @s_ssn      = @s_ssn,
            @s_user     = @s_user,
            @s_term     = @s_term,
            @s_date     = @s_date,
            @s_srv      = @s_srv,
            @s_lsrv     = @s_lsrv,
            @s_ofi      = @s_ofi,
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @t_from,
            @i_crea_ext = @i_crea_ext,
            @i_ente     = @i_ente,
            @i_ws       = @i_crea_ext
          --REQ 428 Se envia para control de errores desde WS.

          if @w_return <> 0
          begin
            if @i_crea_ext is null
              return 1
            else
            begin
              select
                @o_msg_msv = 'Error: En Carga Informacion Cliente ' + @i_ente +
                             ' en DYNAMICS, '
                                    + @w_sp_name
              select
                @w_return = 103119
              return @w_return
            end
          end
        end
      end--linea
      return 0

    end
    else
    begin
      select
        @w_return = 151051
      goto ERROR_FIN
    /*  'No corresponde codigo de transaccion' */
    end

  end

  /** Delete **/
  if @i_operacion = 'D'
  begin
    if @t_trn = 1226
    begin
      /*  Campos para transaccion de  servicios */
      select
        @w_descripcion = di_descripcion,
        @w_tipo = di_tipo,
        @w_principal = di_principal,
        @w_parroquia = di_parroquia,
        @w_barrio = di_barrio,
        @w_ciudad = di_ciudad,
        @w_sector = di_sector,
        @w_zona = di_zona,
        @w_oficina = di_oficina,
        @w_verificado = di_verificado,
        @w_provincia = di_provincia,
        @w_rural_urb = di_rural_urb,
        @w_observacion = di_observacion
      --  @w_fecha_recidencia = di_fecha_recidencia

      from   cl_direccion
      where  di_ente      = @i_ente
         and di_direccion = @i_direccion

      if @@rowcount = 0
      begin
        if @i_crea_ext is null
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001
          /*'No existe dato solicitado'*/
          return 1
        end
        else
        begin
          select
            @o_msg_msv = 'No Existe Dato Solicitado, ' + @w_sp_name
          select
            @w_return = 101001
          return @w_return
        end
      end
      if (select
            count (dp_direccion_ec)
          from   cl_cliente,
                 cl_det_producto
          where  cl_cliente      = @i_ente
             and cl_det_producto = dp_det_producto
             and dp_direccion_ec = @i_direccion) > 0
      begin
        if @i_crea_ext is null
        begin
          print
'NO SE PUEDE ELIMINAR DIRECCION YA QUE SE ENCUENTRA REFERENCIADA PORUN PRODUCTO'
  return 1
end
else
begin
  select
    @o_msg_msv = 'Error: Eliminando Direccion ' + @i_direccion
                 + ' Referenciada a un Producto, Cliente ' + convert(varchar(10)
                 ,
                        @i_ente) + ', '
                 + @w_sp_name
  select
    @w_return = 103120
  return @w_return
end
end
  if @i_crea_ext is null
  begin
    begin tran
    select
      @w_commit = 'S'
  end

  update cl_ente
  set    en_direccion = en_direccion - 1
  where  en_ente = @i_ente
  if @@error <> 0
  begin
    if @i_crea_ext is null
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107007
      /* 'Error en disminucion de direcciones'*/
      return 1
    end
    else
    begin
      select
        @o_msg_msv = 'Error: Actualizando Numero de Direcciones, Cliente ' +
                     @i_ente
                     +
                            ', ' +
                            @w_sp_name
      select
        @w_return = 107007
      return @w_return
    end
  end

  /* Si se quiere borrar todas las direcciones */
  select
    @w_codigo = en_direccion
  from   cl_ente
  where  en_ente = @i_ente

  if @w_codigo = 0
  begin
    if @i_crea_ext is null
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101053
      /* 'No se puede eliminar todas las direcciones'*/
      return 1
    end
    else
    begin
      select
        @o_msg_msv =
        'Error: No se puede Eliminar Todas las Direcciones, Cliente '
        +
               @i_ente + ', '
        + @w_sp_name
      select
        @w_return = 101053
      return @w_return
    end
  end

  /* Evitar Eliminar las direcciones principales NVR */

  select
    @w_principal = di_principal
  from   cl_direccion
  where  di_ente      = @i_ente
     and di_direccion = @i_direccion

  if @w_principal = 'S'
  begin
    if @i_crea_ext is null
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101053
      /* 'No se puede eliminar todas las direcciones'*/
      return 1
    end
    else
    begin
      select
        @o_msg_msv = 'Error: No se puede Eliminar Direccion Principal, Cliente '
                     +
                            @i_ente + ', ' +
                            @w_sp_name
      select
        @w_return = 101053
      return @w_return
    end
  end

  /* @w_codigo = numero de telefonos de la direccion */
  select
    @w_codigo = di_telefono
  from   cl_direccion
  where  di_ente      = @i_ente
     and di_direccion = @i_direccion

  /** Eliminacion de todos los telefonos de la direccion **/
  while @w_codigo > 0
  begin
    exec @w_return = sp_telefono
      @s_ssn       = @s_ssn,
      @s_user      = @s_user,
      @s_term      = @s_term,
      @s_date      = @s_date,
      @s_srv       = @s_srv,
      @s_lsrv      = @s_lsrv,
      @s_ofi       = @s_ofi,
      @s_rol       = @s_rol,
      @s_org_err   = @s_org_err,
      @s_error     = @s_error,
      @s_sev       = @s_sev,
      @s_msg       = @s_msg,
      @s_org       = @s_org,
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @t_from,
      @t_trn       = 148,
      @p_alterno   = @w_codigo,
      @i_operacion = 'D',
      @i_ente      = @i_ente,
      @i_direccion = @i_direccion,
      @i_secuencial= @w_codigo,
      @i_crea_ext  = @i_crea_ext,
      @o_msg_msv   = @o_msg_msv out

    if @w_return <> 0
      return @w_return

    select
      @w_codigo = @w_codigo - 1
  end

  /* Eliminacion de la direccion */
  delete from cl_direccion
  where  di_ente      = @i_ente
     and di_direccion = @i_direccion

  if @@error <> 0
  begin
    if @i_crea_ext is null
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 107007
      /* 'Error en eliminacion de direccion'*/
      return 1
    end
    else
    begin
      select
        @o_msg_msv = 'Error: Eliminando Direccion, Cliente ' + @i_ente + ', ' +
                            @w_sp_name
      select
        @w_return = 107007
      return @w_return
    end
  end

  select
    @w_direccion = convert(varchar(3), @i_direccion)
  insert into cl_actualiza
              (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
               ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
  values      (@i_ente,getdate(),'cl_direccion','di_direccion',@w_direccion,
               null,'D',@i_direccion,null)
  if @@error <> 0
  begin
    if @i_crea_ext is null
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103001
      /*'Error en creacion de cliente'*/
      return 1
    end
    else
    begin
      select
        @o_msg_msv = 'Error: Ingresando Registro de Actualizacion, Cliente ' +
                     @i_ente
                     +
                            ', ' +
                            @w_sp_name
      select
        @w_return = 103001
      return @w_return
    end
  end

  /** Transaccion servicios - cl_direccion */
  insert into ts_direccion
              (secuencial,tipo_transaccion,clase,fecha,usuario,
               terminal,srv,lsrv,ente,direccion,
               descripcion,sector,zona,parroquia,ciudad,
               tipo,oficina,verificado,barrio,provincia,
               rural_urbano --,observacion
  --  fecha_recidencia
  )
  values     (@s_ssn,@t_trn,'B',@s_date,@s_user,
              @s_term,@s_srv,@s_lsrv,@i_ente,@i_direccion,
              @w_descripcion,@w_sector,@w_zona,@w_parroquia,@w_ciudad,
              @w_tipo,@w_oficina,@w_verificado,@w_barrio,@w_provincia,
              @w_rural_urb ---,@w_observacion
  --  @w_fecha_recidencia
  )
  if @@error <> 0
  begin
    if @i_crea_ext is null
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103005
      /* 'Error en creacion de transaccion de servicio'*/
      return 1
    end
    else
    begin
      select
        @o_msg_msv = 'Error: Creando Transaccion de Servicio, Cliente ' +
                     @i_ente
                     +
                     ', '
                            + @w_sp_name
      select
        @w_return = 103005
      return @w_return
    end
  end
  if @i_crea_ext is null
    commit tran

  /*MGV Buscar estado de bloqueo del ente por informacion incompleta       */
  exec @w_return = sp_ente_bloqueado
    @s_ssn       = @s_ssn,
    @s_user      = @s_user,
    @s_term      = @s_term,
    @s_date      = @s_date,
    @s_srv       = @s_srv,
    @s_lsrv      = @s_lsrv,
    @s_ofi       = @s_ofi,
    @s_rol       = @s_rol,
    @s_org_err   = @s_org_err,
    @s_error     = @s_error,
    @s_sev       = @s_sev,
    @s_msg       = @s_msg,
    @s_org       = @s_org,
    @t_debug     = @t_debug,
    @t_file      = @t_file,
    @t_from      = @t_from,
    @t_trn       = 176,
    @i_operacion = 'U',
    @i_ente      = @i_ente,
    @i_crea_ext  = @i_crea_ext,
    @o_retorno   = @w_bloqueado output,
    @o_msg_msv   = @o_msg_msv out

  if @w_return <> 0
  begin
    if @i_crea_ext is not null
      return @w_return
  end

  /* MGV Fin Buscar       */

  return 0
end
else
begin
  if @i_crea_ext is null
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 151051
    /*  'No corresponde codigo de transaccion' */
    return 1
  end
  else
  begin
    select
      @o_msg_msv = 'Error: Codigo de Transaccion No Corresponde, ' + @w_sp_name
    select
      @w_return = 151051
    return @w_return
  end
end
end
  return 0

  ERROR_FIN:

  if @w_commit = 'S'
  begin
    rollback tran
    select
      @w_commit = 'N'
  end
  if @i_crea_ext is null
  begin
    if @i_linea = 'S'
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_return
      return 1
    /*  'No corresponde codigo de transaccion' */
    end
    else
    begin
      select
        @o_mensaje_retorno = mensaje
      from   cobis..cl_errores
      where  numero = @w_return
    end
  end
  else
  begin
    if @o_msg_msv is not null
      select
        @o_msg_msv = @o_msg_msv + ' Error: Procesando Direccion DML ' +
                     @w_sp_name
    else
      select
        @o_msg_msv = ' Error: Procesando Direccion DML ' + @w_sp_name
  end

  return @w_return

go

