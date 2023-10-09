use cob_sincroniza
go


PRINT '<<<<< DROPPING TABLES >>>>>'

IF EXISTS (SELECT 1 FROM sysobjects o, sysusers u WHERE o.uid=u.uid AND o.name = 'mo_device' AND u.name = 'dbo' AND o.type = 'U')
    DROP TABLE mo_device
go

PRINT '<<<<< CREATING TABLE "cob_sincroniza..mo_device" >>>>>'
go

create table mo_device(
  de_alias varchar(45) null, -- alias del device
  de_device_id varchar(45)  not null, --  imei del dispositivo
  de_login varchar(25) not null, -- correspondiente al cl_funcionario
  de_status char not null, --catalogo device status del device
  PRIMARY KEY CLUSTERED (de_device_id)
)
go

