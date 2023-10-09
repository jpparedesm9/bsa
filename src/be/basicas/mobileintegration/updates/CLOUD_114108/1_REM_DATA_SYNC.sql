use cob_sincroniza
go


IF OBJECT_ID ('dbo.ts_sincroniza') IS  NULL begin

   create table ts_sincroniza(
   ts_secuencial  INT NOT NULL,
   ts_cod_entidad VARCHAR (10) NOT NULL,
   ts_des_entidad VARCHAR (64) NOT NULL,
   ts_usuario     VARCHAR (20) NOT NULL,
   ts_estado      VARCHAR (10) NOT NULL,
   ts_fecha_ing   DATETIME NOT NULL,
   ts_fecha_sin   DATETIME NULL,
   ts_num_reg     INT NOT NULL
   )

end

IF OBJECT_ID ('dbo.ts_sincroniza_det') IS  NULL begin
   create table ts_sincroniza_det(
   ts_id          INT IDENTITY NOT NULL,
   ts_secuencial  INT NOT NULL,
   ts_id_entidad  INT NOT NULL,
   ts_id_1        INT NOT NULL,
   ts_id_2        INT NOT NULL,
   ts_xml         XML NOT NULL,
   ts_accion      VARCHAR (255) NOT NULL,
   ts_observacion VARCHAR (255) NOT NULL,
   ts_descargado  BIT DEFAULT ((0)) NULL,
   CONSTRAINT PK_ts_id PRIMARY KEY (ts_id))

end
go

use cob_sincroniza
go

declare 
@w_fecha            datetime,
@w_error            int


declare @w_sync_repetidos table (
secuencial          int
)

declare @w_sincronizacion table(
si_codigo           int identity,
si_secuencial       int,
si_cod_entidad      int,
si_usuario          varchar(30)
)

select @w_fecha = dateadd(mi,-10, getdate())

update si_sincroniza
set si_estado = 'E' --Error
where si_fecha_ing < @w_fecha
and si_estado in ('D','P')

insert into @w_sync_repetidos
select  si_secuencial
from si_sincroniza
group by si_secuencial
having count(si_secuencial) > 1

insert into ts_sincroniza
select * from si_sincroniza  
where si_secuencial in (select  secuencial from @w_sync_repetidos)

delete si_sincroniza  
where si_secuencial in (select  secuencial from @w_sync_repetidos)


SELECT * FROM ts_sincroniza

insert into ts_sincroniza_det (     
ts_secuencial, 
ts_id_entidad, 
ts_id_1 ,      
ts_id_2  ,     
ts_xml,        
ts_accion ,    
ts_observacion)
select 
sid_secuencial, 
sid_id_entidad, 
sid_id_1,       
sid_id_2,       
sid_xml ,       
sid_accion,     
sid_observacion
from si_sincroniza_det 
WHERE sid_secuencial in (select  secuencial from @w_sync_repetidos)

delete si_sincroniza_det
where sid_secuencial in (select  secuencial from @w_sync_repetidos)

SELECT TOP 10 * FROM ts_sincroniza_det
go