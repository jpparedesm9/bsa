use cobis
go


declare 
@w_grupo       int,
@w_ente        int,
@w_oficial     int

select @w_ente = 9198
select 
@w_grupo     = gr_grupo,
@w_oficial   = gr_oficial
from cl_grupo
where gr_nombre = 'FLORES DE SAN MARCOS'
 
if @w_grupo is not null begin
   update cobis..cl_cliente_grupo set
   cg_estado              = 'C',
   cg_rol                 = 'M'
   where cg_ente = @w_ente
   and cg_grupo = @w_grupo
   
   update cobis..cl_ente set
   en_oficial = @w_oficial
   where en_ente = @w_ente  
   
   
end

go