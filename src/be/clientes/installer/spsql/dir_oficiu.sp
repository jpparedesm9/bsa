/************************************************************************/
/*  Archivo:            dir_oficiu.sp                                   */
/*  Stored procedure:   sp_oficinaciudad                                */
/*  Base de datos:      cobis                                           */
/*  Producto: Clientes                                                  */
/*  Disenado por:       Wilson Romero                                   */
/*  Fecha de escritura: 16 Abril 2008                                   */
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
/*  Este programa procesa las transacciones de consultas de             */
/*  direcciones                                                         */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  16/Abr/2008     wro     retornar todas las oficinas que estan       */
/*                          asociadas a una determinada ciudad          */
/*  May-15-08   MRoa        Adicion de la opcion tipo 'C'               */
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
           where  name = 'sp_oficinaciudad')
           drop proc sp_oficinaciudad
go

create proc sp_oficinaciudad
(
  @i_tipo          char(1) = null,
  @i_ciudad        int = 1,
  @i_oficina       smallint = null,
  @i_codigo        varchar(10) = null,
  @i_direccion     descripcion = null,
  @t_trn           smallint = null,
  @t_show_version  bit = 0
)
as
  declare @w_sp_name varchar(32)
  select
    @w_sp_name = 'sp_oficinaciudad'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn = 1140
  begin
    if @i_tipo = 'A'
    begin
      if @i_oficina is null
        select
          @i_oficina = 0

      select
        'Codigo' = of_oficina,
        'Nombre' = convert(varchar(48), of_nombre)
      from   cl_oficina
      where  of_ciudad  = @i_ciudad
         and of_subtipo = 'O'
         and of_oficina > @i_oficina
      order  by of_oficina
    end
    else
    begin
      if @i_tipo = 'V'
      begin
        if @i_oficina is null
          select
            @i_oficina = 0

        select
          'Codigo' = of_oficina,
          'Nombre' = convert(varchar(48), of_nombre)
        from   cl_oficina
        where  of_ciudad  = @i_ciudad
           and of_subtipo = 'O'
           and of_oficina = @i_codigo
        order  by of_oficina
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_from = @w_sp_name,
            @i_num  = 101001
          /*'No Existen Registros'*/
          return 101001
        end

      end
      if @i_tipo = 'C'
      begin
        if @i_oficina is null
          select
            @i_oficina = 0

        select
          'Codigo' = of_ciudad,
          'Nombre' = ci_descripcion
        from   cl_oficina,
               cl_ciudad
        where  of_oficina = @i_oficina
           and ci_ciudad  = of_ciudad
        order  by of_oficina
      end
    end
    if @i_tipo = 'B'
    begin
      if @i_oficina is null
        select
          @i_oficina = 0

      select
        'Codigo' = of_oficina,
        'Nombre' = convert(varchar(48), of_nombre)
      from   cl_oficina
      where  of_oficina >= @i_oficina
         and of_nombre like @i_codigo
         and of_ciudad  = @i_ciudad
      order  by of_oficina
    end
  end
	
	-- Operacion para consultar colectivos en base a
	-- Oficinas virtuales
	if @i_tipo = 'R'
    begin
		SELECT 'ID' = of_oficina, 
			   'Nombre' = of_nombre 
		FROM cl_oficina 
		WHERE of_direccion = @i_direccion
		--Cambiar codigo de error
		if @@rowcount = 0
        begin
          exec sp_cerror
            @t_from = @w_sp_name,
            @i_num  = 101001
          /*'No Existen Registros'*/
          return 101001
        end
	end
  
  return 0

go

