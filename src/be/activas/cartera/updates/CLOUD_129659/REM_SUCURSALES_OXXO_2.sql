use cob_cartera
go


IF OBJECT_ID ('dbo.ca_corresponsal_oficina') IS NOT NULL
	DROP TABLE dbo.ca_corresponsal_oficina
GO

create table ca_corresponsal_oficina(
   co_id                     int not null identity,
   co_oficina_id             int not null,
   co_oficina_desc           varchar(255) not null,
   co_co_id                  varchar(10) not null,
   CONSTRAINT pk_corresponsal_oficina PRIMARY KEY (co_id),
   FOREIGN KEY (co_co_id) REFERENCES ca_corresponsal(co_id)
)

go

use cob_cartera
go

declare
@w_co_id          int

select @w_co_id = co_id from ca_corresponsal where co_nombre = 'OXXO'


if @w_co_id is not null begin
   --OFICINAS
   insert into ca_corresponsal_oficina 
   select of_oficina, of_nombre, @w_co_id
   from cobis..cl_oficina
   where upper(of_nombre) = 'OFICINA CUERNAVACA'
   
   --OFICINAS PERTENECIENTES A REGIONALES
   insert into ca_corresponsal_oficina 
   select of_oficina, of_nombre, @w_co_id
   from cobis..cl_oficina 
   where of_regional in (select of_oficina 
                        from cobis..cl_oficina 
   					    where upper(of_nombre) in ('REGION HIDALGO', 'REGION CHIAPAS','REGIONAL TOLUCA','REGION COATZACOALCOS',
                        'REGION CDMX',  'REGION CHIAPAS SOCONUSCO','REGION MERIDA','REGION CANCUN','REGION VERACRUZ PUERTO',
                       'REGION OAXACA ISTMO','REGION MORELIA','REGION QUERETARO','REGION GUADALAJARA'))
   AND upper(of_nombre) LIKE '%OFICINA%'
   ORDER BY of_regional
end
go