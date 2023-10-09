

use cob_cartera 
go 


IF OBJECT_ID ('dbo.ca_onboard_seguro_ext') IS NOT NULL
	DROP TABLE dbo.ca_onboard_seguro_ext
GO

create table ca_onboard_seguro_ext (
   se_tramite      int not null,
   se_cliente      int not null,
   se_beneficiario varchar(400) null,
   se_porcentaje   float null,
   se_parentesco   int null,
   se_acepto       int null,
   se_otorgo       int null,
   se_fecha_ing    datetime null,
   se_usuario      login
   
)


CREATE NONCLUSTERED INDEX cseg1
	ON dbo.ca_onboard_seguro_ext (se_tramite,se_cliente,se_beneficiario)
GO



--CREACION DE CAMPO PRODUCTO PARA LOS SEGUROS

if not exists (select 1 from sys.columns 
           where Name = N'se_producto'
           and Object_ID = Object_ID(N'ca_param_seguro_externo')) begin
   alter table ca_param_seguro_externo
   add  se_producto varchar(10) null
end  




--CREACION DE CATALOGO PARA PRODUCTOS DE SEGURO --PARA PARAMETRIA 

delete cobis..cl_catalogo from cobis..cl_tabla  where cl_tabla.tabla in ('ca_producto_seguro')  and cl_tabla.codigo = cl_catalogo.tabla
go                                      
delete cobis..cl_tabla where cl_tabla.tabla in  ('ca_producto_seguro')                                    
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cobis..cl_tabla

insert into cobis..cl_tabla values (@w_tabla, 'ca_producto_seguro', 'Productos para la parametria de seguro')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'GRUPAL', 'CREDITO GRUPAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'ONBOARD-S', 'ONBOARD-SIMPLE', 'V')



--SE AGREGAN NUEVOS VALORES PARA LA PARAMETRIS DEL SEGURO POR PRODUCTO 


update ca_param_seguro_externo set  se_producto = 'GRUPAL' where se_id in(1,2,3)



delete ca_param_seguro_externo where se_id in ( 4,5,6)

insert into dbo.ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria, se_producto)
values (4, 'BASICO', 'Seguro de vida', 'Seguro de vida', 12, 80, 'V', 0.5,'ONBOARD-S')
go

insert into dbo.ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria,se_producto)
values (5, 'EXTENDIDO', 'Seguro de Vida y Complementario', 'Seguro Complementario', 180, 80, 'V', 0,'ONBOARD-S')
go

insert into dbo.ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria,se_producto)
values (6, 'NINGUNO', 'Sin Seguro', 'Ninguno', 0, 99, 'V', 0,'ONBOARD-S')
go



