/************************************************************************/
/*      Archivo:                cl_ajnatjur.sp                          */
/*      Stored procedure:       sp_aj_natjurP                           */
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
/*   Este programa actualiza la naturaleza juridica de P = PA si es null*/
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR               RAZON                       */
/*      09/10/2007    Etna Laguna    Correccion defecto 8875            */
/*      02/05/2016    DFu             Migracion CEN                     */
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
           where  name = 'sp_aj_natjurP')
  drop proc sp_aj_natjurP
go

create proc sp_aj_natjurP
(
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(30) = null,
  @t_show_version bit = 0
)
as
  declare
    @w_return        int,
    @w_error         int,
    @w_sp_name       varchar(32),/* NOMBRE STORED PROC */
    @w_ente          int,
    @w_tipo_compania char(2)

  /*ASIGNACIONES*/
  select
    @w_sp_name = 'sp_aj_natjurP'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  declare cursor_updNatjurP cursor for
    select
      en_ente,
      c_tipo_compania
    from   cobis..cl_ente
    where  en_subtipo = 'P'
    order  by en_ente
    for read only

  open cursor_updNatjurP

  fetch cursor_updNatjurP into @w_ente, @w_tipo_compania

  while (@@fetch_status != -1)
  begin
    -- Control del estado del cursor
    if @@fetch_status = -2
    begin
      close cursor_updNatjurP
      deallocate cursor_updNatjurP
      print 'Aborta ... cursor_updNatjurP'
      return 2
    end

    print 'procesando ente  ' + @w_ente

    if @w_ente > 0
    begin
      print 'ente  actualizado ' + @w_ente

      if @w_ente > 0
         and @w_tipo_compania is null
      begin
        update cobis..cl_ente
        set    c_tipo_compania = 'PA'
        where  en_ente = @w_ente

        if @@error != 0
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
        values      (@w_ente,getdate(),'cl_ente','c_tipo_compania',null,
                     'PA','U',1,100)

      end
      goto SIGUIENTE

    end --@w_ente > 0 

    ------                 
    SIGUIENTE:
    fetch cursor_updNatjurP into @w_ente, @w_tipo_compania
  end -- while 
  close cursor_updNatjurP
  deallocate cursor_updNatjurP
  return 0
--end

go

