USE cob_pac
go

IF OBJECT_ID ('dbo.sp_consulta_cliente_busin') IS NOT NULL
	DROP PROCEDURE dbo.sp_consulta_cliente_busin
GO

create proc sp_consulta_cliente_busin (
       @t_debug            	char(1)     = 'N',
       @t_file             	varchar(14) = null,
       @t_from             	varchar(30) = null,
       @i_cliente         	int         = null,
       @i_operacion			char(1)     = null
)
as


/***Consultar vinculación cliente***/
if @i_operacion = 'V' and @i_cliente is not null
begin

	select e.en_vinculacion 
	from cobis..cl_ente e
	where e.en_ente = @i_cliente
	
end

return 0

GO

