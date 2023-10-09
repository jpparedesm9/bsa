
use cobis
GO

declare @w_tabla int

if exists (select 1 from cobis..cl_tabla where tabla = 'ns_plantilla_sms')
begin 
   delete from cobis..cl_tabla where tabla = 'ns_plantilla_sms'
   select @w_tabla = max(codigo) + 1 from cobis..cl_tabla
   INSERT INTO cobis..cl_tabla (codigo,tabla,descripcion) VALUES(@w_tabla,'ns_plantilla_sms','Plantillas SMS')
end
else
begin
   select @w_tabla = max(codigo) + 1 from cobis..cl_tabla
   INSERT INTO cobis..cl_tabla (codigo,tabla,descripcion) VALUES(@w_tabla,'ns_plantilla_sms','Plantillas SMS')
end

update cobis..cl_seqnos
set siguiente = @w_tabla + 1
where tabla = 'cl_tabla'
and bdatos = 'cobis'


delete from cl_catalogo where tabla = @w_tabla

INSERT INTO cl_catalogo (tabla,codigo,valor,estado,culture,equiv_code,type) 
VALUES(@w_tabla,'50464','Tuiio_Cuida_Situacion_Financiera','V',null,null,null)

INSERT INTO cl_catalogo (tabla,codigo,valor,estado,culture,equiv_code,type) 
VALUES(@w_tabla,'50463','Tuiio_Pago_Grupal_Proximo','V',null,null,null)

INSERT INTO cl_catalogo (tabla,codigo,valor,estado,culture,equiv_code,type) 
VALUES(@w_tabla,'50465','Tuiio_Autorizacion_Biometrica','V',null,null,null)
GO


use cobis
GO

declare @w_tabla int

if exists (select 1 from cobis..cl_tabla where tabla = 'ns_bloque_sms')
begin 
   delete from cobis..cl_tabla where tabla = 'ns_bloque_sms'
   select @w_tabla = max(codigo) + 1 from cobis..cl_tabla
   INSERT INTO cobis..cl_tabla (codigo,tabla,descripcion) VALUES(@w_tabla,'ns_bloque_sms','Bloque de plantilla sms')
end
else
begin
   select @w_tabla = max(codigo) + 1 from cobis..cl_tabla
   INSERT INTO cobis..cl_tabla (codigo,tabla,descripcion) VALUES(@w_tabla,'ns_bloque_sms','Bloque de plantilla sms')
end

update cobis..cl_seqnos
set siguiente = @w_tabla + 1
where tabla = 'cl_tabla'
and bdatos = 'cobis'


delete from cl_catalogo where tabla = @w_tabla

INSERT INTO cl_catalogo (tabla,codigo,valor,estado,culture,equiv_code,type) 
VALUES(@w_tabla,'-1','NA','V',null,null,null)

INSERT INTO cl_catalogo (tabla,codigo,valor,estado,culture,equiv_code,type) 
VALUES(@w_tabla,'0','RECORDATORIO','V',null,null,null)

INSERT INTO cl_catalogo (tabla,codigo,valor,estado,culture,equiv_code,type) 
VALUES(@w_tabla,'1','COBRANZAS','V',null,null,null)

INSERT INTO cl_catalogo (tabla,codigo,valor,estado,culture,equiv_code,type) 
VALUES(@w_tabla,'2','BIOMETRICOS','V',null,null,null)


