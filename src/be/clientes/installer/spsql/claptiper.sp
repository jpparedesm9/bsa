/************************************************************************/
/*   Archivo:                 claptiper.sp                              */
/*   Stored procedure:        sp_par_tipersona                          */
/*   Base de datos:           cobis                                     */
/*   Producto:                Clientes                                  */
/*   Disenado por:                                                      */
/*   Fecha de escritura:      13-Mar-2009                               */
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
/*   Permite el mantenimiento:  insert, update, delete de regis-        */
/*   tros en la tabla cl_aplica_tipo_persona.  Es utilizada para        */
/*   parametrizar el comportamiento de la pantalla de creacion segun    */
/*      el tipo de persona.                                             */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*       FECHA          AUTOR              RAZON                        */
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
/************************************************************************/

use cobis
go

if exists (select
             *
           from   sysobjects
           where  name like 'sp_par_tipersona')
  drop proc sp_par_tipersona
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_par_tipersona
(
  @s_ssn          int,
  @s_sesn         int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @s_rol          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char (1) = 'N',
  @t_file         varchar (14) = null,
  @t_from         varchar (30) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char (1),
  @i_modo         tinyint = null,
  @i_tipo         char (1) = null,
  @i_tipo_per     varchar(10) = null,
  @i_siguiente    smallint = null,
  @i_tipop        char(1) = null,
  @i_tipoobj      char(1) = null,
  @i_nombre       varchar(30) = null,
  @i_aplica       char(1) = null,
  @i_secuencial   smallint = null
)
as
  declare
    @w_sp_name     char (20),
    @w_return      int,
    @w_siguiente   int,
    @w_bandera     varchar(1),
    @w_codigo      catalogo,
    @w_descripcion descripcion,
    @w_sec         int,
    @w_tipop       char(1),
    @w_tipo_per    varchar(10),
    @w_tipoobj     char(1),
    @w_nombre      varchar(30),
    @w_aplica      char(1),
    @w_secuencial  smallint

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /*  Inicializacion de Variables  */
  select
    @w_sp_name = 'sp_par_tipersona'

  /*  Insert  */
  if @i_operacion = 'I'
  begin
    if @t_trn = 1405
    begin
      /* verificar que es validad la categoria */
      if @i_tipop not in ('P', 'C')
      begin
        /*  No Existe Tipo de Persona */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101021
        return 1
      end

      if exists (select
                   atp_secuencia
                 from   cl_aplica_tipo_persona
                 where  atp_tipo       = @i_tipop
                    and atp_tpersona   = @i_tipo_per
                    and atp_t_objeto   = @i_tipoobj
                    and atp_nom_objeto = @i_nombre)
      begin
        /*  Ya existe codigo  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101186
        return 1
      end

      select
        @w_siguiente = isnull(max(atp_secuencia), 0) + 1
      from   cl_aplica_tipo_persona
      where  atp_tipo     = @i_tipop
         and atp_tpersona = @i_tipo_per
         and atp_t_objeto = @i_tipoobj

      begin tran
      /* insertar los datos de entrada */
      insert into cl_aplica_tipo_persona
                  (atp_tipo,atp_tpersona,atp_t_objeto,atp_nom_objeto,atp_aplica,
                   atp_secuencia)
      values      (@i_tipop,@i_tipo_per,@i_tipoobj,@i_nombre,@i_aplica,
                   @w_siguiente)
      if @@error <> 0
      begin
        /*  Error en creacion de catalogo*/
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103015
        return 1
      end

      /*  Transaccion de Servicio  */
      insert into ts_aplica_tipo_persona
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,tipo_persona,nombre_obj,
                   tipo,aplica,sec_interno,tipo_objeto)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_tipo_per,@i_nombre,
                   @i_tipop,@i_aplica,@w_siguiente,@i_tipoobj)
      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 1
      end
      select
        @w_bandera = 'S'
      commit tran

      if @w_bandera = 'S'
      begin
        /* Actualizacion de la los datos en el catalogo */
        exec @w_return = sp_catalogo
          @s_ssn         = @s_ssn,
          @s_user        = @s_user,
          @s_sesn        = @s_sesn,
          @s_term        = @s_term,
          @s_date        = @s_date,
          @s_srv         = @s_srv,
          @s_lsrv        = @s_lsrv,
          @s_rol         = @s_rol,
          @s_ofi         = @s_ofi,
          @s_org_err     = @s_org_err,
          @s_error       = @s_error,
          @s_sev         = @s_sev,
          @s_msg         = @s_msg,
          @s_org         = @s_org,
          @t_debug       = @t_debug,
          @t_file        = @t_file,
          @t_from        = @w_sp_name,
          @t_trn         = 584,
          @i_operacion   = 'I',
          @i_tabla       = 'cl_aplica_tipo_persona',
          @i_codigo      = @i_tipo_per,
          @i_descripcion = @i_nombre,
          @i_estado      = 'V'
        if @w_return <> 0
          return @w_return
      end

      return 0

    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end

  /*  Update  */
  if @i_operacion = 'U'
  begin
    if @t_trn = 1406
    begin
      /* verificar que es validad la categoria */
      if @i_tipop not in ('P', 'C')
      begin
        /*  No Existe Tipo de Persona */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101021
        return 1
      end

      select
        @w_tipop = atp_tipo,
        @w_tipo_per = atp_tpersona,
        @w_tipoobj = atp_t_objeto,
        @w_nombre = atp_nom_objeto,
        @w_aplica = atp_aplica,
        @w_secuencial = atp_secuencia
      from   cl_aplica_tipo_persona
      where  atp_tipo      = @i_tipop
         and atp_tpersona  = @i_tipo_per
         and atp_t_objeto  = @i_tipoobj
         and atp_secuencia = @i_secuencial

      if @@rowcount <> 1
      begin
        /*  No existe Codigo en Catalogo */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101000
        return 1
      end

      begin tran
      update cl_aplica_tipo_persona
      set    atp_nom_objeto = @i_nombre,
             atp_aplica = @i_aplica
      where  atp_tipo      = @i_tipop
         and atp_tpersona  = @i_tipo_per
         and atp_t_objeto  = @i_tipoobj
         and atp_secuencia = @i_secuencial

      if @@rowcount <> 1
      begin
        /*  Error en actualizacion de catalogo  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  =105000
        return 1
      end

      insert into ts_aplica_tipo_persona
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,tipo_persona,nombre_obj,
                   tipo,aplica,sec_interno,tipo_objeto)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@w_tipo_per,@w_nombre,
                   @w_tipop,@w_aplica,@w_secuencial,@w_tipoobj)

      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 1
      end

      /*  Transaccion de Servicio - Actual */
      insert into ts_aplica_tipo_persona
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,tipo_persona,nombre_obj,
                   tipo,aplica,sec_interno,tipo_objeto)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_tipo_per,@i_nombre,
                   @i_tipop,@i_aplica,@i_secuencial,@i_tipoobj)
      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 1
      end
      select
        @w_bandera = 'S'
      commit tran

      if @w_bandera = 'S'
      begin
        exec @w_return = sp_catalogo
          @s_ssn         = @s_ssn,
          @s_user        = @s_user,
          @s_sesn        = @s_sesn,
          @s_term        = @s_term,
          @s_date        = @s_date,
          @s_srv         = @s_srv,
          @s_lsrv        = @s_lsrv,
          @s_rol         = @s_rol,
          @s_ofi         = @s_ofi,
          @s_org_err     = @s_org_err,
          @s_error       = @s_error,
          @s_sev         = @s_sev,
          @s_msg         = @s_msg,
          @s_org         = @s_org,
          @t_debug       = @t_debug,
          @t_file        = @t_file,
          @t_from        = @w_sp_name,
          @t_trn         = 585,
          @i_operacion   = 'U',
          @i_tabla       = 'cl_aplica_tipo_persona',
          @i_codigo      = @w_tipo_per,
          @i_descripcion = @i_nombre,
          @i_estado      = 'V'
        if @w_return <> 0
          return @w_return
      end
      return 0
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end

  /*  Search  */
  if @i_operacion = 'S'
  begin
    if @t_trn = 1408
    begin
      delete cl_aplica_tipo_persona2
      insert into cl_aplica_tipo_persona2
                  (atp_orden,atp_tpersona,atp_descripcion,atp_tipo,atp_t_objeto,
                   atp_nom_objeto,atp_aplica,atp_secuencia)
        select
          "ORDEN    " = 0,"TPERSONA " = atp_tpersona,"DESCRIPCION"=
          cl_catalogo.valor,
          "TIPO     " = atp_tipo,"TOBJETO  " = atp_t_objeto,
          "NOMBRE   " = atp_nom_objeto,"APLICA   " = atp_aplica,
          "SECUENCIA" = atp_secuencia
        from   cl_aplica_tipo_persona,
               cl_catalogo,
               cl_tabla
        where  cl_catalogo.codigo = atp_tpersona
           and cl_catalogo.tabla  = cl_tabla.codigo
           and cl_tabla.tabla     = 'cl_ptipo'
        order  by atp_tpersona asc,
                  atp_tipo,
                  atp_t_objeto,
                  atp_secuencia

      select
        @w_sec = 0

      update cobis..cl_aplica_tipo_persona2
      set    atp_orden = @w_sec,
             @w_sec = @w_sec + 1

      set rowcount 20
      if @i_modo = 0
        select
          'Orden       ' = atp_orden,
          'Tipo' = atp_tipo,
          'Tipo Persona' = atp_tpersona,
          'Descripcion ' = atp_descripcion,
          'Tipo Objeto ' = atp_t_objeto,
          'Nombre      ' = atp_nom_objeto,
          'Aplica      ' = atp_aplica,
          'Secuencial  ' = atp_secuencia
        from   cl_aplica_tipo_persona2
        order  by atp_orden
      else if @i_modo = 1
        select
          'Orden       ' = atp_orden,
          'Tipo' = atp_tipo,
          'Tipo Persona' = atp_tpersona,
          'Descripcion ' = atp_descripcion,
          'Tipo Objeto ' = atp_t_objeto,
          'Nombre      ' = atp_nom_objeto,
          'Aplica      ' = atp_aplica,
          'Secuencial  ' = atp_secuencia
        from   cl_aplica_tipo_persona2
        where  atp_orden > @i_siguiente
        order  by atp_orden
      set rowcount 0
      return 0

    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end

go

