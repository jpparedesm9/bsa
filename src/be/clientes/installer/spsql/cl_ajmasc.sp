/************************************************************************/
/*      Archivo:                cl_ajmasc.sp                            */
/*      Stored procedure:       sp_quita_mascara                        */
/*      Base de datos:          COBIS                                   */
/*      Producto:               CLIENTES                                */
/*      Disenado por:           Etna Laguna                             */
/*      Fecha de escritura:     08/24/2007                              */
/************************************************************************/
/*                            IMPORTANTE                                */
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
/*                             PROPOSITO                                */
/*    Este programa toma la data del campo identificacion tabla cl_hijos*/
/*    y la modifica quitando los caracteres diferentes a numero         */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR               RAZON                       */
/*      24/08/2007    Etna Laguna    Correccion defecto 8661            */
/*      02/05/2016    DFu            Migracion CEN                      */
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
           where  name = 'sp_quita_mascara')
  drop proc sp_quita_mascara
go

create proc sp_quita_mascara
(
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(30) = null,
  @t_show_version bit = 0
)
as
  declare
    @w_return       int,
    @w_error        int,
    @w_sp_name      varchar(32),/* NOMBRE STORED PROC */
    @w_documento    varchar(30),
    @w_cadena_nueva varchar(30),
    @w_ente         int,
    @w_hijo         int,
    @w_letra        char(1),
    @w_contador     smallint,
    @w_letra_asc    smallint,
    @w_lon_cadena   smallint,
    @w_ascii_46     smallint,
    @w_ascii_64     smallint

  /*ASIGNACIONES*/
  select
    @w_sp_name = 'sp_quita_mascara'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  declare cursor_quita_mascara cursor for
    select
      hi_ente,
      hi_hijo,
      hi_documento
    from   cobis..cl_hijos
    order  by hi_ente
    for read only

  open cursor_quita_mascara

  fetch cursor_quita_mascara into @w_ente, @w_hijo, @w_documento

  while (@@fetch_status <> -1)
  begin
    -- Control del estado del cursor
    if @@fetch_status = -2
    begin
      close cursor_quita_mascara
      deallocate cursor_quita_mascara
      print 'Aborta ... cursor_quita_mascara'
      return 2
    end

    print 'procesando cedula ' + @w_documento

    if @w_ente > 0
       and @w_hijo > 0
    begin
      select
        @w_cadena_nueva = null
      select
        @w_contador = 1
      select
        @w_lon_cadena = datalength(ltrim(rtrim(@w_documento)))

      while (@w_contador <= @w_lon_cadena)
      begin
        select
          @w_letra = substring(@w_documento,
                               @w_contador,
                               1)
        select
          @w_letra_asc = ascii(@w_letra)
        select
          @w_contador = @w_contador + 1

        if (@w_letra_asc < 48
             or @w_letra_asc > 57)
        begin
          print 'tiene caracteres especiales  ' + @w_letra
        end -- if not exist
        else
        begin
          select
            @w_cadena_nueva = @w_cadena_nueva + @w_letra
          print 'cadena Nueva ' + @w_cadena_nueva
        end

      end

      print 'ente  actualizado ' + @w_ente + @w_documento + @w_cadena_nueva

      if @w_documento <> @w_cadena_nueva
      begin
        update cobis..cl_hijos
        set    hi_documento = @w_cadena_nueva
        where  hi_ente = @w_ente
           and hi_hijo = @w_hijo

        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105026
          /* 'Error en actualizacion de persona'*/
          return 1
        end

        --1302        ACTUALIZACION DE HIJOS DE UN CLIENTE                             
        insert into cobis..cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
        values      (@w_ente,getdate(),'cl_hijos','hi_documento',@w_documento,
                     @w_cadena_nueva,'U',1,1)

      end
      goto SIGUIENTE

    end --@w_ente > 0 and @w_hijo > 0   

    ------                 
    SIGUIENTE:
    fetch cursor_quita_mascara into @w_ente, @w_hijo, @w_documento
  end -- while 
  close cursor_quita_mascara
  deallocate cursor_quita_mascara
  return 0
--end

go

