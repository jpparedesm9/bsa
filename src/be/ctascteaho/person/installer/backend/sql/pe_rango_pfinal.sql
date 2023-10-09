use cob_remesas
go
  
/*************************************************/
--Fecha Creación del Script: 
--JSA         07/15/2016    TABLA pe_pro_rango_edad
/***************************************************/  

/* pe_pro_rango_edad */
print '=====> pe_pro_rango_edad'
go
if exists (select 1 from sysobjects where name = 'pe_pro_rango_edad') 
   drop table pe_pro_rango_edad
go

CREATE TABLE pe_pro_rango_edad
(
    re_codigo       smallint      not null,
    re_descripcion   descripcion   not null,
    re_rango_ini    int      not null,
    re_rango_fin    int      not null
)
go
print '=====> Insercion pe_pro_rango_edad'
delete from pe_pro_rango_edad where re_codigo IN (1,2,3)
go
insert into pe_pro_rango_edad values (1,'MENOR DE EDAD',0,17)
insert into pe_pro_rango_edad values (2,'MAYOR DE EDAD',18,100)
insert into pe_pro_rango_edad values (3,'TODOS',0,100)

go

