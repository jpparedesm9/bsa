/* ************************************************************************** */
/*  Archivo:            1.CreateTable.sql                                     */
/*  Base de datos:      1.CreateTable.sql                                     */
/* ************************************************************************** */
/*              IMPORTANTE                                                    */
/*  Este programa es parte de los paquetes bancarios propiedad de             */
/*  "Cobiscorp".                                                              */
/*  Su uso no autorizado queda expresamente prohibido asi como                */
/*  cualquier alteracion o agregado hecho por alguno de sus                   */
/*  usuarios sin el debido consentimiento por escrito de la                   */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.                    */
/* ************************************************************************** */
/*              PROPOSITO                                                     */
/*  Creacion Tablas Bussiness to custumer                                     */
/* ************************************************************************** */
/*              MODIFICACIONES                                                */
/* ************************************************************************** */
/* FECHA        VERSION       AUTOR              RAZON                        */
/* ************************************************************************** */
/* 12-AGO-2019                JHCH            Emision Inicial B2C             */
/* ************************************************************************** */
use cob_bvirtual
go
------------------------------------------------------------------------------------------
-- CLOUD DESARROLLO 117291
-- Creacion de tabla bv_info_device para informacion de dispositivos
------------------------------------------------------------------------------------------
if exists (select 1 from sysobjects where name = 'bv_info_device')
begin
	drop table  cob_bvirtual..bv_info_device
end
print 'Creando tabla bv_info_device'
create table cob_bvirtual..bv_info_device (
    in_sequential		int,
	in_ente_cli			int,
	in_login			varchar(64) not null,
	in_brand_device     varchar(255),
	in_model_device     varchar(255),
	in_version_os       varchar(255),
	in_carrier          varchar(255),
	in_date_register    datetime
)
print 'Creando indice-->bv_info_device.bv_info_device_Key'
if exists (select 1 from sysindexes where name = 'bv_info_device_Key')
begin
	drop index bv_info_device_Key on cob_bvirtual..bv_info_device
end
create index bv_info_device_Key
on bv_info_device(
    in_login,
	in_sequential,
	in_ente_cli	
)
go




