use cob_pac
go
IF OBJECT_ID ('dbo.sp_address_type_busin') IS NOT NULL
	DROP PROCEDURE dbo.sp_address_type_busin
GO

CREATE PROCEDURE 	sp_address_type_busin (
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(30) = NULL,
	@s_date			datetime = NULL,
	@s_srv			varchar(30) = NULL,
	@s_lsrv			varchar(30) = NULL, 
	@s_rol			smallint = NULL,
	@s_ofi			smallint = NULL,
	@s_org_err		char(1) = NULL,
	@s_error		int = NULL,
	@s_sev			tinyint = NULL,
	@s_msg			descripcion = NULL,
	@s_org			char(1) = NULL,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(32) = null,
	@t_trn			smallint =NULL,
    @i_operacion	varchar(1) = null
)
as
declare @w_today	datetime,
	@w_sp_name	varchar(32)

select @w_sp_name = 'sp_address_type_busin'

/* ** Insert ** */
if @i_operacion = 'H'
begin
if @t_trn = 599
BEGIN
SELECT 
  'codigo'= cat.codigo,
  'valor'=cat.valor
 FROM cobis..cl_catalogo AS cat, cobis..cl_tabla AS tab 
	WHERE tab.tabla="cl_tdireccion" 
	AND cat.tabla=tab.codigo 
	AND cat.codigo NOT IN('CE','SI')
RETURN 0
END
 
else
begin
	exec cobis..sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
	   /*  'No corresponde codigo de transaccion' */
	return 1
end


end


GO

