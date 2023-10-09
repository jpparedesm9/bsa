
--Tablas de Reporte Grupal

use cob_conta_super
go
if not exists (SELECT 1  FROM sys.columns WHERE Name = N'in_estd_timb'  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'B'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   add in_estd_timb char(1) 
end
go

use cob_conta_super
go
if not exists (SELECT 1  FROM sys.columns WHERE Name = N'in_estd_timb_hist'  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'B'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   add in_estd_timb_hist char(1) 
end
go



use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'ec_rfc_emisor'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_estcta_cab_tmp'))
begin
print 'C'
   ALTER TABLE cob_conta_super..sb_estcta_cab_tmp
   add ec_rfc_emisor varchar(30) 
end
go


use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'ec_monto_factura'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_estcta_cab_tmp'))
begin
print 'C'
   ALTER TABLE cob_conta_super..sb_estcta_cab_tmp
   add ec_monto_factura varchar(30) 
end
go

--Tablas de Reporte Revolvente

use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'ec_rfc_emisor'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_estcta_cab_tmp_lcr'))
begin
print 'C'
   ALTER TABLE cob_conta_super..sb_estcta_cab_tmp_lcr
   add ec_rfc_emisor varchar(30) 
end
go


use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'ec_monto_factura'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_estcta_cab_tmp_lcr'))
begin
print 'C'
   ALTER TABLE cob_conta_super..sb_estcta_cab_tmp_lcr
   add ec_monto_factura varchar(30) 
end
go

-------------

use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_toperacion'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   add in_toperacion varchar(10) 
end
go

use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_toperacion_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   add in_toperacion_hist varchar(10) 
end
go


--------

use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_met_fact'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   add in_met_fact varchar(5) 
end
go

use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_met_fact_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   add in_met_fact_hist varchar(5) 
end
go
--------

use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_estado_pdf'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   add in_estado_pdf char(1) 
end
go

use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_estado_pdf_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   add in_estado_pdf_hist char(1)  
end
go


use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_estado_correo'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   add in_estado_correo char(1) 
end
go

use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_estado_correo_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   add in_estado_correo_hist char(1)  
end
go


use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_nombre_pdf'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   add in_nombre_pdf varchar(200) 
end
go

use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_nombre_pdf_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   add in_nombre_pdf_hist varchar (200)  
end
go


-------

use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_estd_clv_co'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   add in_estd_clv_co char(1) 
end
go

use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_estd_clv_co_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   add in_estd_clv_co_hist char (1)  
end
go

use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_grupo'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   add in_grupo int 
end
go

use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_grupo_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   add in_grupo_hist int 
end
go


use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_nombre_cli'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   add in_nombre_cli varchar(255)  
end
go

use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_nombre_cli_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   add in_nombre_cli_hist varchar(255) 
end
go


use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_cuota_desde'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   add in_cuota_desde int  
end
go

use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_cuota_desde_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   add in_cuota_desde_hist int
end
go



use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_cuota_hasta'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   add in_cuota_hasta int  
end
go

use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_cuota_hasta_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   add in_cuota_hasta_hist int
end
go

use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_folio_ref'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   add in_folio_ref varchar(50)  
end
go

use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_folio_ref_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   add in_folio_ref_hist varchar(50)
end
go
---
use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_fecha_fin_mes'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   add in_fecha_fin_mes datetime  
end
go

use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_fecha_fin_mes_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   add in_fecha_fin_mes_hist datetime
end
go
---Creacion de Indices
    
if not exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'es_cu_banco_coutas_mes'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin

create index es_cu_banco_coutas_mes
on cob_conta_super..sb_ns_estado_cuenta (nec_banco,in_cuota_desde,in_cuota_hasta,nec_fecha,in_folio_ref)
	
end


if not exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'es_cu_banco_coutas_folio_mes_his'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin

create index es_cu_banco_coutas_folio_mes_his
on cob_conta_super..sb_ns_estado_cuenta_hist (nec_banco_hist,in_cuota_desde_hist,in_cuota_hasta_hist,nec_fecha_hist,in_folio_ref_hist)
	
end

-----------------
if not exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'es_cu_banco_mes'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin

create index es_cu_banco_mes
on cob_conta_super..sb_ns_estado_cuenta (nec_banco,nec_fecha)
	
end


if not exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'es_cu_banco_mes_his'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin

create index es_cu_banco_mes_his
on cob_conta_super..sb_ns_estado_cuenta_hist (nec_banco_hist,nec_fecha_hist)
	
end

--------
if not exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'es_cu_banco'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin

create index es_cu_banco
on cob_conta_super..sb_ns_estado_cuenta (nec_banco)
	
end


if not exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'es_cu_banco_his'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin

create index es_cu_banco_his
on cob_conta_super..sb_ns_estado_cuenta_hist (nec_banco_hist)
	
end

update statistics cob_conta_super..sb_ns_estado_cuenta
go

update statistics cob_conta_super..sb_ns_estado_cuenta_hist
go


