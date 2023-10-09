/************************************************************************/
/*      Archivo:                casilla.sp                              */
/*      Stored procedure:       sp_casilla                              */
/*      Base de datos:          cob_cuentas                             */
/*      Producto:               Cuentas Corrientes                      */
/*      Disenado por:           Mauricio Bayas/Sandra Ortiz             */
/*      Fecha de escritura:     18-Jul-20106                            */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa realiza la consulta de direccion de Cliente       */
/*      de ahorros.                                                     */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA        AUTOR            RAZON                             */
/*      18/Jul/2016  Walther Toledo   Migracion de CEN - COBISCLOUD     */
/************************************************************************/
use cob_cuentas
go

set ANSI_NULLS on
GO
set QUOTED_IDENTIFIER on
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_casilla')
  drop proc sp_casilla

go
create proc sp_casilla (
	@t_debug	char(1) = 'N',
	@t_file		char(1) =  null,
	@t_trn		smallint,
	@i_help		char(1),
	@i_cli		int,
	@i_casi		tinyint = null,
	@i_tipo 	char(1) = null
)
as
declare @w_row		tinyint,
	@w_row1		tinyint

if @i_tipo = 'A'
begin
  if @i_help = 'A'
  begin 
   	select di_direccion,di_descripcion from cobis..cl_direccion
	 where di_ente = @i_cli
	   and di_tipo in (select c.codigo 
		      	     from cobis..cl_tabla t, cobis..cl_catalogo c
		            where t.codigo = c.tabla 
		   	      and t.tabla  = 'cl_tdireccion'
			      and c.valor  = 'APARTADO AEREO')
  end
  else
  begin
    select di_descripcion from cobis..cl_direccion
     where di_ente = @i_cli
       and di_direccion = @i_casi
       and di_tipo in (select c.codigo 
	 	      	 from cobis..cl_tabla t, cobis..cl_catalogo c
		        where t.codigo = c.tabla 
		   	  and t.tabla  = 'cl_tdireccion'
			  and c.valor  = 'APARTADO AEREO')
	if @@rowcount = 0
	begin
		exec cobis..sp_cerror
			@t_debug	= @t_debug,
			@t_file		= @t_file,
			@t_from		= 'sp_casilla',
			@i_num		= 101106
		return 101106	
	end
  end
end
else
begin
if @i_tipo = 'D'
  if @i_help = 'A'
  begin 
   	select di_direccion,di_descripcion from cobis..cl_direccion
	 where di_ente = @i_cli
	   and di_tipo in (select c.codigo 
		      	     from cobis..cl_tabla t, cobis..cl_catalogo c
		            where t.codigo = c.tabla 
		   	      and t.tabla  = 'cl_tdireccion'
			      and c.valor  != 'APARTADO AEREO')
  end
  else
  begin
    select di_descripcion from cobis..cl_direccion
     where di_ente = @i_cli
       and di_direccion = @i_casi
       and di_tipo in (select c.codigo 
	 	      	 from cobis..cl_tabla t, cobis..cl_catalogo c
		        where t.codigo = c.tabla 
		   	  and t.tabla  = 'cl_tdireccion'
			  and c.valor  != 'APARTADO AEREO')
	if @@rowcount = 0
	begin
	 exec cobis..sp_cerror
	   @t_debug  = @t_debug,
	   @t_file   = @t_file,
	   @t_from   = 'sp_casilla',
	   @i_num    = 101001
	  /* 'No existe dato solicitado'*/
	 return 101001
	end
  end
end

return 0
go
IF OBJECT_ID('sp_casilla') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE sp_casilla >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE sp_casilla >>>'
go

go
use cob_cuentas
go
