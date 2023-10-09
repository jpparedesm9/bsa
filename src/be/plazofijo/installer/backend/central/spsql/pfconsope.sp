/************************************************************************/
/*  Archivo:            pfconsope.sp                                    */
/*  Stored procedure:   sp_consulta_operacion_cli			*/
/*  Base de datos:      cob_pfijo					*/
/*  Producto:           Branch                                          */
/*  Disenado por:       Raul Altamirano                                 */
/*  Fecha de escritura: 02-Mar-2010                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*              PROPOSITO                                               */
/*  Este programa implementa la busqueda de operaciones de plazo fijo 	*/
/*  de un cliente para la trasaccion 701 de caja			*/
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR           RAZON                                   */
/*  02/Mar/10	Raul Altamirano Emision Inicial				*/	
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_consulta_operacion_cli')
   drop proc sp_consulta_operacion_cli
go

create proc sp_consulta_operacion_cli(
        @s_ssn             int         = null,
        @s_user            login       = null,
        @s_term            varchar(30) = null,
        @s_date            datetime    = null,
        @s_srv             varchar(30) = null,
        @s_lsrv            varchar(30) = null,
        @s_rol             smallint    = null,
        @s_ofi             smallint    = null,
        @s_org_err         char(1)     = null,
        @s_error           int         = null,
        @s_sev             tinyint     = null,
        @s_msg             descripcion = null,
        @s_org             char(1)     = null,
        @t_trn             smallint    = null,
        @i_cliente         int         = null
)
with encryption
as
declare @w_sp_name       varchar(32),
        @w_cuenta        varchar(24),
        @w_rol           varchar(10),
        @w_tperacion	 varchar(10)

select @w_sp_name = 'sp_consulta_operacion_cli'

declare operaciones cursor
for   
select dp_cuenta, cl_rol
from   cobis..cl_det_producto,
       cobis..cl_cliente
where  dp_det_producto = cl_det_producto
and    dp_producto     = 14
and    dp_estado_ser   = 'V'
and    cl_cliente      = @i_cliente

/* Abrir el cursor para productos del cliente */  
open operaciones
   
/*Ubicar el primer registro para el cursor*/
fetch operaciones into
      @w_cuenta,
      @w_rol
         
if @@fetch_status = -2
begin
	/* Error en lectura del cursor */ 
	exec cobis..sp_cerror
	@i_num      = 351037,
	@i_sev      = 1
   
	/* Cerrar y liberar cursor */
	close operaciones
	deallocate operaciones
	return 351037
end
         
/*Barrer los registros para las operaciones del cliente */
while @@fetch_status = 0
begin
	select @w_tperacion = op_toperacion 
	from  cob_pfijo..pf_operacion
	where op_num_banco = @w_cuenta

	if @@rowcount > 0
	begin
		insert into #cuenta
		       (cu_banco,  cu_rol, cu_producto)
		values (@w_cuenta, @w_rol, @w_tperacion)
		
		if @@error <> 0
		begin
			exec cobis..sp_cerror
			@i_num  = 351037,
			@i_sev  = 1
		 
		 	/* Cerrar y liberar cursor */
			close operaciones
			deallocate operaciones
			return 351037
		end
	end

	--Lee siguiente registro
	fetch operaciones into
	      @w_cuenta,
	      @w_rol
end

/* Cerrar y liberar cursor */
close operaciones
deallocate operaciones
   
return 0
go
