--Tablas Fisicas
use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_rfc_emisor'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   add in_rfc_emisor varchar(30) 
end
go

use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_monto_fac'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta'))
begin
print 'B'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta
   add in_monto_fac varchar(30) 
end
go

--Tablas Historicas
use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_rfc_emisor_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'A'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   add in_rfc_emisor_hist varchar(30) 
end
go


use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'in_monto_fac_hist'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_ns_estado_cuenta_hist'))
begin
print 'B'
   ALTER TABLE cob_conta_super..sb_ns_estado_cuenta_hist
   add in_monto_fac_hist varchar(30) 
end
go
