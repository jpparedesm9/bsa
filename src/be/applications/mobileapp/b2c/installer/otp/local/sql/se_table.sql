/* ************************************************************************** */
/*  Archivo:            se_table.sql                                          */
/*  Base de datos:      cobis                                                 */
/*  Producto:           Seguridad                                             */
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
/*  Creacion Tablas para funcionalidad de Token                               */
/* ************************************************************************** */
/*              MODIFICACIONES                                                */
/* ************************************************************************** */
/* FECHA        VERSION       AUTOR              RAZON                        */
/* ************************************************************************** */
/* 20-Oct-2016                DJA            Emision Inicial OTP              */
/* ************************************************************************** */

print 'Tabla para OTP'
use cobis
go

print 'se_token'
if object_id('se_token') is not null
    drop table se_token
go
create table se_token (
  to_servicio        int           not null,
  to_usuario         varchar(128)  not null,
  to_token_value     varchar(256)  not null,
  to_fecha_cre       datetime not null
)
go
if object_id('se_token_his') is not null
    drop table se_token_his
go
	
create table se_token_his (
  hto_servicio        int           not null,
  hto_usuario         varchar(128)  not null,
  hto_token_value     varchar(256)  not null,
  hto_fecha_cre       datetime not null
)
go



