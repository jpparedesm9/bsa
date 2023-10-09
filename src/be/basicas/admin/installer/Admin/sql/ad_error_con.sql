/************************************************************************/
/*    Archivo:        ad_err_con.sql                                    */
/*    Base de datos:  cobis                                             */
/*    Producto:       Controlador                                       */
/************************************************************************/
/*                IMPORTANTE                                            */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    'COBISCORP'                                                       */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de COBISCORP o su representante.            */
/************************************************************************/
/*                PROPOSITO                                             */
/*    Este script crea los numeros de error del CONTROLADOR             */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*    FECHA         AUTOR       RAZON                                   */
/*    14-04-2016    BBO         Migracion SYB-SQL FAL                   */
/************************************************************************/

use cobis
go

print '** Mensajes de Errores en el Controlador **'
go
print '====> Errores de Existencia '
go
/********************/
/* ADMINISTRACION   */
/********************/
--Validacion agregada por Migracion SYB-SQL FAL
if exists (select 1 from cl_errores
            where numero between 151077 and 151088)
begin            
    delete cl_errores
    where numero between 151077 and 151088
end
go

insert into cl_errores values (151077, 0, 'No existe icono')         
insert into cl_errores values (151078, 0, 'No existe nodo nivel')         
insert into cl_errores values (151079, 0, 'No existe nodo oficina')         
insert into cl_errores values (151080, 0, 'No existe nivel mapa')         
insert into cl_errores values (151081, 0, 'No existe Producto Moneda')         
insert into cl_errores values (151082, 0, 'No existe Procedimiento Logger')
insert into cl_errores values (151083, 0, 'No existe Alias')         
insert into cl_errores values (151084, 0, 'No existe Procedimiento Reentry')
insert into cl_errores values (151085, 0, 'No existe tipo de ejecucion')
insert into cl_errores values (151086, 0, 'No existe tabla en re_seqnos')
insert into cl_errores values (151087, 0, 'No existe nivel')         
insert into cl_errores values (151088, 0, 'No existe mapa')         
go

print '====>Errores de Actualizacion '
go
/********************/
/* ADMINISTRACION   */
/********************/
--Validacion agregada por Migracion SYB-SQL FAL
if exists (select 1 from cl_errores
            where numero between 155028 and 155041)
begin            
    delete cl_errores
    where numero between 155028 and 155041
end
go

insert into cl_errores values (155028, 1, 'Error en actualizacion de icono')
insert into cl_errores values (155029, 1, 'Error en actualizacion de nivel')
insert into cl_errores values (155030, 1, 'Error en actualizacion de mapa')
insert into cl_errores values (155031, 1, 'Error en actualizacion de nodo nivel')
insert into cl_errores values (155032, 1, 'Error en actualizacion de Catalogo Icono')
insert into cl_errores values (155033, 1, 'Error en actualizacion de la tabla lo_procedure')
insert into cl_errores values (155034, 1, 'Error en actualizacion de la tabla lo_parametro')
insert into cl_errores values (155035, 1, 'Error en actualizacion de la tabla lo_mensaje')
insert into cl_errores values (155036, 1, 'Error en actualizacion de la tabla lo_alias')
insert into cl_errores values (155037, 1, 'Error en actualizacion de la tabla re_procedure')
insert into cl_errores values (155038, 1, 'Error en actualizacion de la tabla re_parametro')
insert into cl_errores values (155039, 1, 'Error en actualizacion de la tabla re_server')
insert into cl_errores values (155040, 1, 'Error en actualizacion de la tabla re_tipoejec')
insert into cl_errores values (155041, 1, 'Error en actualizacion de la tabla re_seqnos')
go

print '====> Errores de Creacion / Insercion '
go
/********************/
/* ADMINISTRACION   */
/********************/
--Validacion agregada por Migracion SYB-SQL FAL
if exists (select 1 from cl_errores
            where numero between 153032 and 153037)
begin            
    delete cl_errores
    where numero between 153032 and 153037
end
go

insert into cl_errores values (153032, 1, 'Error en insercion de nivel')
insert into cl_errores values (153033, 1, 'Error en insercion de mapa')
insert into cl_errores values (153034, 1, 'Error en insercion de nodo_nivel')
insert into cl_errores values (153035, 1, 'Error en insercion de icono')
insert into cl_errores values (153036, 1, 'Error en insercion de Nivel Mapa')
insert into cl_errores values (153037, 1, 'Error en insercion de Catalogo Icono')
go


print '====> Errores de Eliminacion '
go
/********************/
/* ADMINISTRACION   */
/********************/
--Validacion agregada por Migracion SYB-SQL FAL
if exists (select 1 from cl_errores
            where numero between 157051 and 157067)
begin            
    delete cl_errores
    where numero between 157051 and 157067
end
go

insert into cl_errores values (157051, 1, 'Error en eliminacion de icono')
insert into cl_errores values (157052, 1, 'Error en eliminacion de nivel')
insert into cl_errores values (157053, 1, 'Error en eliminacion de mapa')
insert into cl_errores values (157054, 1, 'Error en eliminacion de nodo nivel')
insert into cl_errores values (157055, 1, 'Existe referencia en la tabla nivel mapa')
insert into cl_errores values (157056, 1, 'Existe referencia en la tabla icono')
insert into cl_errores values (157057, 1, 'Existe referencia en la tabla nodo nivel')
insert into cl_errores values (157058, 1, 'Error en la eliminacion de nivel mapa')
insert into cl_errores values (157059, 1, 'Error en la eliminacion de registros de la tabla lo_procedure')
insert into cl_errores values (157060, 1, 'Error en la eliminacion de registros de la tabla lo_parametro')
insert into cl_errores values (157061, 1, 'Error en la eliminacion de registros de la tabla lo_mensaje')
insert into cl_errores values (157062, 1, 'Error en la eliminacion de registros de la tabla lo_alias')
insert into cl_errores values (157063, 1, 'Error en la eliminacion de registros de la tabla re_procedure')
insert into cl_errores values (157064, 1, 'Error en la eliminacion de registros de la tabla re_parametro')
insert into cl_errores values (157065, 1, 'Error en la eliminacion de registros de la tabla re_server')
insert into cl_errores values (157066, 1, 'Error en la eliminacion de registros de la tabla re_tipoejec')
insert into cl_errores values (157067, 1, 'Error en la eliminacion de registros de la tabla re_seqnos')
go
