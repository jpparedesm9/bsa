/************************************************************************/
/*  Archivo:        esta_tmp.sp                                         */
/*  Stored procedure:   sp_estatuto_tmp                                 */
/*  Base de datos:      cobis                                           */
/*  Producto:       Clientes                                            */
/*  Disenado por:       Carlos Rodriguez                                */
/*  Fecha de escritura: 10-May-1994                                     */
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
/*  Este programa procesa las transacciones de:                         */
/*  Insercion de estatutos de una compania en la tabla temporal         */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA         AUTOR       RAZON                                     */
/*  04/May/2016   T. Baidal   Migracion a CEN                           */
/************************************************************************/
use cobis
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

if exists (select * from sysobjects where name = 'sp_estatuto_tmp')
    drop proc sp_estatuto_tmp
go

create proc sp_estatuto_tmp (
        @s_ssn      int = null,
        @s_user     login = null,
        @s_term     varchar(30) = null,
        @s_date     datetime = null,
        @s_srv      varchar(30) = null,
        @s_lsrv     varchar(30) = null,
        @s_rol      smallint = NULL,
        @s_ofi      smallint = NULL,
        @s_org_err  char(1) = NULL,
        @s_error    int = NULL,
        @s_sev      tinyint = NULL,
        @s_msg      descripcion = NULL,
        @s_org      char(1) = NULL,
        @t_debug    char(1) = 'N',
        @t_file     varchar(14) = null,
        @t_from     varchar(32) = null,
        @t_trn      smallint = null,
        @t_show_version bit      = 0,
        @i_operacion    char(1),
        @i_compania     int,
        @i_linea    varchar(255) = NULL
)
as
declare
    @w_return       int,
    @w_codigo       int,
    @w_siguiente        int,
    @w_sp_name      varchar(32)

select @w_sp_name = 'sp_estatuto_tmp'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
end

if @i_operacion = 'D'
    begin

if @t_trn = 1233
begin

        begin tran
            if exists (select * from cl_estatuto_tmp
                    where et_usuario = @s_user
                      and et_terminal = @s_term)
                begin
                    delete cl_estatuto_tmp
                     where et_usuario = @s_user
                       and et_terminal = @s_term

                    if @@error <> 0
                    begin
                        /*  Error en la eliminacion del estatuto de la compania */
                        exec cobis..sp_cerror
                            @t_debug= @t_debug,
                            @t_file = @t_file,
                            @t_from = @w_sp_name,
                            @i_num  = 107061
                        return 1
                    end
                end
        commit tran
        return 0

end
else
begin
    exec sp_cerror
       @t_debug  = @t_debug,
       @t_file   = @t_file,
       @t_from   = @w_sp_name,
       @i_num    = 151051
       /*  'No corresponde codigo de transaccion' */
    return 1
end

end



if @t_trn = 1183
begin

    /*  Verificacion de existencias  */

    select  @w_codigo = en_ente
      from  cl_ente
     where  en_ente = @i_compania
       and  en_subtipo = 'C'

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

  begin tran

    select @w_siguiente = count(*) + 1
      from cl_estatuto_tmp
     Where et_compania = @i_compania
       and et_usuario = @s_user
       and et_terminal = @s_term

    if @@error <> 0
    begin
    /*  'Error en insercion en Tabla Temporal'  */
    exec sp_cerror
       @t_debug  = @t_debug,
       @t_file   = @t_file,
       @t_from   = @w_sp_name,
       @i_num    = 103067
        return 1
    end

    /*  Insercion en la Tabla Temporal  */
    insert into cl_estatuto_tmp (et_compania, et_secuencial,
                     et_linea, et_usuario,
                 et_terminal)
            values  (@i_compania, @w_siguiente,
                 @i_linea, @s_user,
                 @s_term)
    if @@error <> 0
    begin
    /*  'Error en insercion en Tabla Temporal'  */
    exec sp_cerror
       @t_debug  = @t_debug,
       @t_file   = @t_file,
       @t_from   = @w_sp_name,
       @i_num    = 103067
        return 1
    end
  commit tran
 return 0

end
else
begin
    exec sp_cerror
       @t_debug  = @t_debug,
       @t_file   = @t_file,
       @t_from   = @w_sp_name,
       @i_num    = 151051
       /*  'No corresponde codigo de transaccion' */
    return 1
end


go

