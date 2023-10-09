
use cobis
go
declare @w_sgt int=0, @w_rol_desc varchar(20) = 'SOCIO COMERCIAL'
select @w_sgt = siguiente + 1 from cobis..cl_seqnos where tabla = 'ad_rol'

if not exists (select 1 from cobis..ad_rol where ltrim(rtrim(ro_descripcion)) = @w_rol_desc)
begin
	INSERT INTO ad_rol(ro_rol,ro_filial,ro_descripcion,ro_fecha_crea,ro_creador,ro_estado,
	ro_fecha_ult_mod,ro_time_out,ro_admin_seg,ro_departamento
	,ro_oficina,ro_canal)
	VALUES
	(@w_sgt, 1, @w_rol_desc, getdate(), 1,	'V', 
	getdate(), 900, 'N', null, null, null)
	
	update cl_seqnos
      set siguiente = @w_sgt
    where tabla = 'ad_rol'
end


GO

