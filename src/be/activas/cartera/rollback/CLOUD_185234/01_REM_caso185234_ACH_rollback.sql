----------->>>>>>>>>>>COLUMNAS
use cob_cartera
go

if exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'se_mes_inicial'
              and  c1.table_name = 'ca_param_seguro_externo')
begin 
    alter table ca_param_seguro_externo
    drop column se_mes_inicial
end 

if exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'se_mes_final'
              and  c1.table_name = 'ca_param_seguro_externo')
begin 
    alter table ca_param_seguro_externo
    drop column  se_mes_final
end 
go

----------->>>>>>>>>>>PARAMETRIZACION SEGURO
use cob_cartera
go

declare @w_id int, @w_producto varchar(256)

select @w_producto = 'INDIVIDUAL'
select * from ca_param_seguro_externo where se_producto = @w_producto
delete ca_param_seguro_externo where se_producto = @w_producto
go

----------->>>>>>>>>>>REGISTRO EN CATALOGO -- VALIDAR CODIGO
--CATALOGOS ACTIVIDADES DEPUES DE ESPERA DE GARANTIAS
use cobis
go

declare @w_id_tabla int, @w_tabla char(30)
select  @w_tabla = 'cr_activ_desp_gar_liq'

select @w_id_tabla = codigo from cl_tabla where tabla = @w_tabla

select * from cl_catalogo where tabla = @w_id_tabla and codigo = 'INDIVIDUAL'

delete cl_catalogo where tabla = @w_id_tabla and codigo = 'INDIVIDUAL'

select * from cl_catalogo where tabla = @w_id_tabla and codigo = 'INDIVIDUAL'

go

----------->>>>>>>>>>>COLUMNA FICHA DE PAGO
use cob_cartera
go

if exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'ind_tramite'
              and  c1.table_name = 'ca_infogaragrupo_det')
begin 
    alter table ca_infogaragrupo_det
    drop column ind_tramite
end 
go

----------->>>>>>>>>>>NUEVAS TABLAS PARA REPORTES FICHA DE PAGO
IF OBJECT_ID ('dbo.ca_infogaracliente_det') IS NOT NULL
	DROP TABLE dbo.ca_infogaracliente_det
GO

------->>>>
IF OBJECT_ID ('dbo.ca_infosegurocliente_det') IS NOT NULL
	DROP TABLE dbo.ca_infosegurocliente_det
GO

------>>>
IF OBJECT_ID ('dbo.ca_infogaracliente') IS NOT NULL
	DROP TABLE dbo.ca_infogaracliente
GO


----------->>>>>>>>>>>COLUMNA OPERACION en garantias liquidas
use cob_cartera
go

if exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'ngl_operacion'
              and  c1.table_name = 'ca_ns_garantia_liquida')
begin 
    alter table ca_ns_garantia_liquida
    drop column ngl_operacion 

end 
go
----------->>>>>>>>>>>SE AGREGA PARAMETROS
use cobis
go

declare @w_cod_tabla int

select @w_cod_tabla = codigo from cobis..cl_tabla where tabla = 'ca_param_notif'

select * from cobis..cl_catalogo where tabla = @w_cod_tabla and codigo like 'PFGLI_%'

delete cobis..cl_catalogo where tabla = @w_cod_tabla and codigo like 'PFGLI_%'

select * from cobis..cl_catalogo where tabla = @w_cod_tabla and codigo like 'PFGLI_%'
go
