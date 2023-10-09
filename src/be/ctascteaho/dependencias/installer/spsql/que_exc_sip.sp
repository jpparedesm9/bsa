use cob_cuentas
go

go
IF OBJECT_ID('dbo.sp_query_excep_sipla') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.sp_query_excep_sipla
    IF OBJECT_ID('dbo.sp_query_excep_sipla') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.sp_query_excep_sipla >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.sp_query_excep_sipla >>>'
END
go
create proc sp_query_excep_sipla (
	@t_debug	char(1) = 'N',
	@t_file		char(1) =  null,
	@i_operacion	char(1) =  null,
	@i_producto	char(3) =  null,
	@i_cta		cuenta,
	@i_mon		tinyint = null
)
as

declare
	@w_exc_sipla char(1),
	@w_cliente   int

if @i_operacion = 'Q'
begin
   if @i_producto = 'CTE'
   begin
	select @w_cliente = cc_cliente
          from cob_cuentas..cc_ctacte
         where cc_cta_banco = @i_cta
   end
   else
   begin

	select @w_cliente = ah_cliente
          from cob_ahorros..ah_cuenta 
         where ah_cta_banco = @i_cta

   end
   select @w_exc_sipla = isnull(en_exc_sipla,'N')
     from cobis..cl_ente
    where en_ente =  @w_cliente
end
select @w_exc_sipla
go
IF OBJECT_ID('dbo.sp_query_excep_sipla') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.sp_query_excep_sipla >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.sp_query_excep_sipla >>>'
go

