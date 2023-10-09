use cob_conta_super
go

if OBJECT_ID('sb_est_cuenta_xml') is not null begin
   drop table sb_est_cuenta_xml
end
go

if OBJECT_ID('sb_est_rubro_ope') is not null begin
   drop table sb_est_rubro_ope
end
go


use cob_conta_super
go

if OBJECT_ID('sb_secuenciales') is not null begin
   drop table sb_secuenciales
end
go


if OBJECT_ID('sb_valores_anticipados') is not null begin
   drop table sb_valores_anticipados
end

