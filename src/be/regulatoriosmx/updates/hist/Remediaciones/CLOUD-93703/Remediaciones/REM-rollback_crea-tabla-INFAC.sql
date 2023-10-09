--Rollback tabla interfactura
use cob_conta_super
go
if exists(select 1 from sysobjects where name = 'sb_xml_interfactura')
    drop table sb_xml_interfactura
go

if exists(select 1 from sysobjects where name = 'tmp_sb_xml_interfactura')
    drop table tmp_sb_xml_interfactura
go