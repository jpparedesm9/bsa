use cobis
go


declare @w_tabla    int

select @w_tabla = codigo
from cl_tabla
where tabla = 'ca_param_notif'

if @@rowcount > 0 begin

   if not exists(select 1 from cl_catalogo where codigo = 'PFPCV_NJAS') begin
      INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
      VALUES (@w_tabla, 'PFPCV_NJAS', 'PagoCorresponsal.jasper', 'V', NULL, NULL, NULL)
   end
   
   if not exists(select 1 from cl_catalogo where codigo = 'PFPCV_NPDF') begin
      INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
      VALUES (@w_tabla, 'PFPCV_NPDF', 'PagoCorresponsal_', 'V', NULL, NULL, NULL)
   end
   
   if not exists(select 1 from cl_catalogo where codigo = 'PFPCV_NXML') begin
      INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
      VALUES (@w_tabla, 'PFPCV_NXML', 'PagoCorresponsal.xml', 'V', NULL, NULL, NULL)
   end
end

go