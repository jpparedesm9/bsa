/* ************************************************************************** */
/*  Archivo:            se_index.sql                                          */
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
/*  Creacion de indices de las tablas para funcionalidad de Token             */
/* ************************************************************************** */
/*              MODIFICACIONES                                                */
/* ************************************************************************** */
/* FECHA        VERSION       AUTOR              RAZON                        */
/* ************************************************************************** */
/* 26-Oct-2016                GRO            Emision Inicial OTP              */
/* ************************************************************************** */

use cobis
go

print 'Crea indices'

if exists (select 1 from sysindexes where name = 'i_se_token')
   drop index se_token.i_se_token
go
create nonclustered index i_se_token on se_token (to_servicio,to_usuario,to_token_value,to_fecha_cre)
go

if exists (select 1 from sysindexes where name = 'i_se_token_his')
   drop index se_token_his.i_se_token_his
go
create nonclustered index i_se_token_his on se_token_his (hto_servicio,hto_usuario,hto_token_value,hto_fecha_cre)
go


