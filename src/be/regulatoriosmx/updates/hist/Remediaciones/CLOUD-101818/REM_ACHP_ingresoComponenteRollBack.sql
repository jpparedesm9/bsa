use cobis
go

print 'Eliminar componente para eliminar integrantes'
IF EXISTS (SELECT 1 FROM an_component WHERE co_class = 'VC_GROUPCOMOS_387974_TASK.html?mode=2&Etapa=ELIMINAR')
begin
    DELETE an_component WHERE co_class = 'VC_GROUPCOMOS_387974_TASK.html?mode=2&Etapa=ELIMINAR'
end

print 'Eliminar componente para Aprobar Prestamo'
IF EXISTS (SELECT 1 FROM an_component WHERE co_class = 'VC_GROUPCOMOS_387974_TASK.html?mode=2&Etapa=APROBAR')
begin
    DELETE an_component WHERE co_class = 'VC_GROUPCOMOS_387974_TASK.html?mode=2&Etapa=APROBAR'
end

print 'Eliminar de registro para error - 208936'
if exists (select 1 from cobis..cl_errores where numero = 208936)
begin
    DELETE cobis..cl_errores where numero = 208936
end
go
