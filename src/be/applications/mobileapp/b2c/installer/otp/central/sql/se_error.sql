/********************************************************************************/
/*   Archivo:                se_error.sql                                       */
/*   Base de datos:          cobis                                              */
/*   Producto:               Internet Banking                                   */
/********************************************************************************/
/*                                 IMPORTANTE                                   */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.     */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier         */
/* alteracion o agregado hecho por alguno de usuarios sin el debido             */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp          */
/* o su representante.                                                          */
/********************************************************************************/
/*              PROPOSITO                                                       */
/*  Ingreso de errores para Modulos                                             */
/********************************************************************************/
/* SCRIPT PARA EJECUTARSE EN EL SERVIDOR CENTRAL                                */
/*                                                                              */
/********************************************************************************/
/*                           MODIFICACIONES                                     */
/********************************************************************************/
/* FECHA         VERSION    AUTOR           RAZON                               */
/********************************************************************************/
/* 20-Oct-2016               GRO            Emision Inicial Instalador Unico    */
/* 07-Nov-2017               GQU            Se define rango 1890000-1891000     */
/*                                          para los errores de OTP Banca Móvil */
/********************************************************************************/

use cobis
go


delete from cl_errores  where numero between 1890000 and 1890005
go
insert into cl_errores values (1890000, 0,'No existe token')
go
insert into cl_errores values (1890001, 1,'Error en la inserción de datos')
go
insert into cl_errores values (1890002, 1,'Error longitud del token incorrecto')
go
insert into cl_errores values (1890003, 0,' Tipo de transaccion no corresponde')
go
insert into cl_errores values (1890004, 1,'Error Token incorrecto')
go
insert into cl_errores values (1890005, 0,'No existe la plantilla')
go