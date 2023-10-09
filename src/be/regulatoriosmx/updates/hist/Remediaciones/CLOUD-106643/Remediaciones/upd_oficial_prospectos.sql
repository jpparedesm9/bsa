use cobis
go

declare @w_oficial     int


select @w_oficial = oc_oficial
from cobis..cc_oficial, 
cobis..cl_funcionario
where oc_funcionario = fu_funcionario
and fu_login = 'jafloreshe'


if @@rowcount = 0 begin 
   print 'NO EXISTE EL OFICIAL jafloreshe'

end
else begin
   if exists (select 1 from cobis..cl_ente_aux where ea_ente = 14599 and ea_estado = 'P') begin
      update cobis..cl_ente
      set en_oficial = @w_oficial
      where en_ente = 14599
   end 
   if exists (select 1 from cobis..cl_ente_aux where ea_ente = 14592 and ea_estado = 'P') begin
      update cobis..cl_ente
      set en_oficial = @w_oficial
      where en_ente =14592
   end
   if exists (select 1 from cobis..cl_ente_aux where ea_ente = 14593 and ea_estado = 'P') begin
      update cobis..cl_ente
      set en_oficial = @w_oficial
      where en_ente =14593
   end
end
go 
