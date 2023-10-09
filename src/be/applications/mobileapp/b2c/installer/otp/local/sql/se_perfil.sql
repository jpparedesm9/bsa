use cob_bvirtual
go
set nocount on
go

declare @w_perfil_1 int

--Creacion de Perfiles
select @w_perfil_1 = pe_perfil from bv_perfil where pe_nombre = 'PERFIL PERSONAL BM'
if @w_perfil_1 is null
begin
print 'Se crea el perfil PERFIL PERSONAL BM'
  exec cobis..sp_cseqnos @i_tabla = 'bv_perfil', @o_siguiente = @w_perfil_1 out
  insert into bv_perfil (pe_perfil, pe_nombre, pe_tipo, pe_servicio, pe_estado, pe_fecha_reg, pe_fecha_mod, pe_tipo_cliente, pe_full, pe_cod_alterno)
  values( @w_perfil_1, 'PERFIL PERSONAL BM', 'E', 8, 'V', getdate(), getdate(), 'P', null, 'G')
end

--permiso para el servicio de generación de token
if not exists (select 1 from cob_bvirtual..bv_perfil_transaccion
    where pt_transaccion = 1875900
    and pt_perfil = @w_perfil_1)
begin
    insert into cob_bvirtual..bv_perfil_transaccion values(@w_perfil_1,18,1875900,'V')
end

--permiso para el servicio de verificación de token
if not exists (select 1 from cob_bvirtual..bv_perfil_transaccion
    where pt_transaccion = 1875901
    and pt_perfil = @w_perfil_1)
begin
    insert into cob_bvirtual..bv_perfil_transaccion values(@w_perfil_1,18,1875901,'V')
end
go