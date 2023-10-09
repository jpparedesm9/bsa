---eliminacion de Indices
use cob_conta_super
go
    
if exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'es_cu_banco_coutas_mes'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
   drop index sb_ns_estado_cuenta.es_cu_banco_coutas_mes	
end


if exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'es_cu_banco_coutas_folio_mes_his'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
   drop index sb_ns_estado_cuenta_hist.es_cu_banco_coutas_folio_mes_his
end

-----------------
if exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'es_cu_banco_mes'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
   drop index sb_ns_estado_cuenta.es_cu_banco_mes	
end


if exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'es_cu_banco_mes_his'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
	drop index sb_ns_estado_cuenta_hist.es_cu_banco_mes_his	
end

--------
if exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'es_cu_banco'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
   drop index sb_ns_estado_cuenta.es_cu_banco	
end


if  exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'es_cu_banco_his'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
   drop index sb_ns_estado_cuenta_hist.es_cu_banco_his	
end


--Tablas de Reporte Grupal

use cob_conta_super
go
if exists (SELECT 1  FROM sys.columns WHERE Name = N'in_estd_timb'  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'B'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   drop column in_estd_timb  
end
go

use cob_conta_super
go
if exists (SELECT 1  FROM sys.columns WHERE Name = N'in_estd_timb_hist'  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'B'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   drop column in_estd_timb_hist
end
go



use cob_conta_super
go
if exists (SELECT 1  FROM sys.columns 
                WHERE Name = N'ec_rfc_emisor'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_estcta_cab_tmp'))
begin
print 'C'
   ALTER TABLE cob_conta_super..sb_estcta_cab_tmp
   drop column ec_rfc_emisor 
end
go


use cob_conta_super
go
if exists (SELECT 1 FROM sys.columns 
                WHERE Name = N'ec_monto_factura'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_estcta_cab_tmp'))
begin
print 'C'
   ALTER TABLE cob_conta_super..sb_estcta_cab_tmp
   drop column ec_monto_factura 
end
go

--Tablas de Reporte Revolvente

use cob_conta_super
go
if exists (SELECT 1 FROM sys.columns 
                WHERE Name = N'ec_rfc_emisor'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_estcta_cab_tmp_lcr'))
begin
print 'C'
   ALTER TABLE cob_conta_super..sb_estcta_cab_tmp_lcr
   drop column ec_rfc_emisor 
end
go


use cob_conta_super
go
if exists (SELECT 1 FROM sys.columns 
                WHERE Name = N'ec_monto_factura'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_estcta_cab_tmp_lcr'))
begin
print 'C'
   ALTER TABLE cob_conta_super..sb_estcta_cab_tmp_lcr
   drop column ec_monto_factura 
end
go

-------------

use cob_conta_super
go
if exists (SELECT 1 FROM sys.columns 
                WHERE Name = N'in_toperacion'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   drop column in_toperacion 
end
go

use cob_conta_super
go
if exists (SELECT 1 FROM sys.columns 
                WHERE Name = N'in_toperacion_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   drop column in_toperacion_hist 
end
go


--------

use cob_conta_super
go
if exists (SELECT 1 FROM sys.columns 
                WHERE Name = N'in_met_fact'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   drop column in_met_fact 
end
go

use cob_conta_super
go
if exists (SELECT 1 FROM sys.columns 
                WHERE Name = N'in_met_fact_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   drop column in_met_fact_hist 
end
go
--------

use cob_conta_super
go
if exists (SELECT 1 FROM sys.columns 
                WHERE Name = N'in_estado_pdf'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   drop column in_estado_pdf 
end
go

use cob_conta_super
go
if exists (SELECT 1 FROM sys.columns 
                WHERE Name = N'in_estado_pdf_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   drop column in_estado_pdf_hist  
end
go


use cob_conta_super
go
if exists (SELECT 1 FROM sys.columns 
                WHERE Name = N'in_estado_correo'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   drop column in_estado_correo  
end
go

use cob_conta_super
go
if exists (SELECT 1 FROM sys.columns 
                WHERE Name = N'in_estado_correo_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   drop column in_estado_correo_hist  
end
go


use cob_conta_super
go
if exists (SELECT 1 FROM sys.columns 
                WHERE Name = N'in_nombre_pdf'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   drop column in_nombre_pdf 
end
go

use cob_conta_super
go
if exists (SELECT 1 FROM sys.columns 
                WHERE Name = N'in_nombre_pdf_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   drop column in_nombre_pdf_hist   
end
go


-------

use cob_conta_super
go
if exists (SELECT 1 FROM sys.columns 
                WHERE Name = N'in_estd_clv_co'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   drop column in_estd_clv_co 
end
go

use cob_conta_super
go
if exists (SELECT 1 FROM sys.columns 
                WHERE Name = N'in_estd_clv_co_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   drop column in_estd_clv_co_hist 
end
go

use cob_conta_super
go
if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_grupo'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   drop column in_grupo
end
go

use cob_conta_super
go
if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_grupo_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   drop column in_grupo_hist 
end
go


use cob_conta_super
go
if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_nombre_cli'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   drop column in_nombre_cli
end
go

use cob_conta_super
go
if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_nombre_cli_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   drop column in_nombre_cli_hist
end
go


use cob_conta_super
go
if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_cuota_desde'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   drop column in_cuota_desde  
end
go

use cob_conta_super
go
if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_cuota_desde_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   drop column in_cuota_desde_hist
end
go



use cob_conta_super
go
if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_cuota_hasta'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   drop column in_cuota_hasta  
end
go

use cob_conta_super
go
if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_cuota_hasta_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   drop column in_cuota_hasta_hist
end
go

use cob_conta_super
go
if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_folio_ref'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   drop column in_folio_ref
end
go

use cob_conta_super
go
if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_folio_ref_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   drop column in_folio_ref_hist
end
go
---
use cob_conta_super
go
if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_fecha_fin_mes'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   drop column in_fecha_fin_mes  
end
go

use cob_conta_super
go
if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_fecha_fin_mes_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   drop column in_fecha_fin_mes_hist
end
go
