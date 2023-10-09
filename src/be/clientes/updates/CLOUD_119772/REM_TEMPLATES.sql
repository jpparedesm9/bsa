-----------------------------------------------------------------------------------
-- REMEDIACIONES COLECTIVOS - 
-----------------------------------------------------------------------------------
use cobis
go
declare @w_secuencial int


if not exists(select 1 from ns_template where te_nombre = 'NotifRechazoTipo1.xslt')
begin  
   select @w_secuencial = isnull(max(te_id),0) + 1
   from ns_template
     
   INSERT INTO cobis..ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
   VALUES (@w_secuencial, 'XSLT', '', 'NotifRechazoTipo1.xslt', 'A', '1.0.0')
end

if not exists(select 1 from ns_template where te_nombre = 'NotifRechazoTipo2.xslt')
begin     
   select @w_secuencial = isnull(max(te_id),0) + 1
   from ns_template
     
   INSERT INTO cobis..ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
   VALUES (@w_secuencial, 'XSLT', '', 'NotifRechazoTipo2.xslt', 'A', '1.0.0')
end

if not exists(select 1 from ns_template where te_nombre = 'NotifRechazoTipo3.xslt')
begin
   select @w_secuencial = isnull(max(te_id),0) + 1
   from ns_template
     
   INSERT INTO cobis..ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
   VALUES (@w_secuencial, 'XSLT', '', 'NotifRechazoTipo3.xslt', 'A', '1.0.0')
end

if not exists(select 1 from ns_template where te_nombre = 'NotifNoCtaSantander.xslt')
begin      
   select @w_secuencial = isnull(max(te_id),0) + 1
   from ns_template
     
   INSERT INTO cobis..ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
   VALUES (@w_secuencial, 'XSLT', '', 'NotifNoCtaSantander.xslt', 'A', '1.0.0')
end


if not exists(select 1 from ns_template where te_nombre = 'NotifOtorgamiento.xslt')
begin      
   select @w_secuencial = isnull(max(te_id),0) + 1
   from ns_template
     
   INSERT INTO cobis..ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
   VALUES (@w_secuencial, 'XSLT', '', 'NotifOtorgamiento.xslt', 'A', '1.0.0')
end


go

