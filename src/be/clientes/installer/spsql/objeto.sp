/************************************************************************/
/*  Archivo:        objeto.sp                                           */
/*  Stored procedure:   sp_obj_social                                   */
/*  Base de datos:      cobis                                           */
/*  Producto:       Clientes                                            */
/*  Disenado por:       Carlos Rodriguez V.                             */
/*  Fecha de escritura:     10-May-1994                                 */
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
/*  Permite :                                                           */
/*  Insertar, Eliminar y consultar el objeto social de una compania     */
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  04/May/2016 T. Baidal   Migracion a CEN                             */
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
           where  name = 'sp_obj_social')
    drop proc sp_obj_social
go

create proc sp_obj_social
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @s_rol          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_show_version bit = 0,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @i_operacion    char (1),
  @i_modo         tinyint = null,
  @i_compania     int = null,
  @i_ultimo       int = null
)
as
  declare
    @w_sp_name varchar(30),
    @w_codigo  int

  select
    @w_sp_name = 'sp_obj_social'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /*  Verificacion de existencias  */

  select
    @w_codigo = en_ente
  from   cl_ente
  where  en_ente    = @i_compania
     and en_subtipo = 'C'

  if @@rowcount = 0
  begin
    /*  No existe compania */
    exec cobis..sp_cerror
      @t_debug= @t_debug,
      @t_file = @t_file,
      @t_from = @w_sp_name,
      @i_num  = 101136
    return 1
  end

  /*  Insert  */
  if @i_operacion = 'I'
  begin
    if @t_trn = 1157
    begin
      /*  Insertar en la tabla definitiva  */
      begin tran
      if exists (select
                   ob_compania
                 from   cl_objeto_com
                 where  ob_compania = @i_compania)
      begin
        delete cl_objeto_com
        where  ob_compania = @i_compania

        if @@error <> 0
        begin
          /*  Error en insercion de objeto social*/
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @t_from,
            @i_num  = 103071
          return 1
        end

        /*  Transaccion de Servicios  */

        insert into ts_objeto
                    (secuencial,tipo_transaccion,clase,fecha,usuario,
                     terminal,srv,lsrv,compania)
        values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
                     @s_term,@s_srv,@s_lsrv,@i_compania)
        if @@error <> 0
        begin
          /*  Error en creacion de la Transaccion de Servicio  */
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 103005
          return 1
        end
      end

      insert into cl_objeto_com
                  (ob_compania,ob_secuencial,ob_linea)
        select
          ot_compania,ot_secuencial,ot_linea
        from   cl_objeto_tmp
        where  ot_usuario  = @s_user
           and ot_terminal = @s_term

      if @@error <> 0
      begin
        /*  Error en creacion del objeto social */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @t_from,
          @i_num  = 103071
        return 1
      end

      delete cl_objeto_tmp
      where  ot_usuario  = @s_user
         and ot_terminal = @s_term

      /*  Transaccion de Servicios  */
      insert into ts_objeto
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,compania)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_compania)
      if @@error <> 0
      begin
        /*  Error en creacion de la Transaccion de Servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 1
      end
      commit tran
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

  /*  Delete  */
  if @i_operacion = 'D'
  begin
    if @t_trn = 1158
    begin
      if (select
            count(*)
          from   cl_objeto_com
          where  ob_compania = @i_compania) = 0
      begin
        /*  No existe objeto de la compania*/
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101138
        return 1
      end

      begin tran

      delete cl_objeto_com
      where  ob_compania = @i_compania

      if @@error <> 0
      begin
        /*  Error en la eliminacion del objeto de la compania */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 107062
        return 1
      end
      /*  Transaccion de Servicios  */
      insert into ts_objeto
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,compania)
      values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_compania)
      if @@error <> 0
      begin
        /*  Error en creacion de la Transaccion de Servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 1
      end
      commit tran
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

  /*  SEARCH  */
  if @i_operacion = 'S'
  begin
    if @t_trn = 122
    begin
      set rowcount 15
      if @i_modo = 0
        select
          'Sec.' = ob_secuencial,
          'Texto' = ob_linea
        from   cl_objeto_com
        where  ob_compania = @i_compania
      else
        select
          'Sec' = ob_secuencial,
          'Texto' = ob_linea
        from   cl_objeto_com
        where  ob_compania   = @i_compania
           and ob_secuencial > isnull(@i_ultimo,
                                      0)
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

