use cob_conta
go

declare	@w_empresa	int,
         @w_modulo	int,
         @w_fecha	datetime

if exists (select 1 from cob_conta..sysobjects where name = 'cb_producto')
begin
    select @w_modulo = 7
	select @w_fecha = isnull(fp_fecha,getdate()) from cobis..ba_fecha_proceso
	if @w_fecha is null
		select @w_fecha = getdate()
		
	select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'
	
	delete from cob_conta..cb_producto where pr_empresa = @w_empresa and pr_producto = @w_modulo
	
	INSERT INTO cob_conta..cb_producto (pr_empresa, pr_producto, pr_online, pr_estado, pr_resumen, pr_fecha_mod)
	VALUES (@w_empresa, @w_modulo, 'N', 'V', 'S', @w_fecha)
end
else
	print 'NO EXISTE TABLA cb_producto'
go

