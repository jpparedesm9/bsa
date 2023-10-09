/************************************************************************/
/*    ARCHIVO:         reg_errores.sql                                  */
/*    NOMBRE LOGICO:   reg_errores.sql                                  */
/*    PRODUCTO:        REGULATORIOS                                     */
/************************************************************************/
/*                     IMPORTANTE                                       */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                     PROPOSITO                                        */
/*   Script de creacion de errores                                      */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      25/08/2016      Ignacio Yupa            Emision Inicial         */  
/*      03/12/2016      PXSG            Req. 129681 Cobranza Mc Collect */  
/************************************************************************/

use cobis
go

DELETE cl_errores where numero in (3600000,3600001)
GO

INSERT INTO dbo.cl_errores (numero, severidad, mensaje)
VALUES (3600001, 1, 'ERROR AL MOMENTO DE ACTUALIZAR REGISTRO')
GO


INSERT INTO dbo.cl_errores (numero, severidad, mensaje)
VALUES (3600000, 1, 'NO EXISTE TRANSACCION')
GO

insert into cobis..cl_errores (numero, severidad, mensaje)
values (3600002, 1, 'EL PRESTAMO NO TIENE UN CICLO VIGENTE')
go

insert into cobis..cl_errores (numero, severidad, mensaje)
values (3600003, 1, 'EL PRESTAMO NO SE ENCUENTRA VIGENTE')
go
DELETE cl_errores where numero in (70011010,70011011,70011012,70011014,70011015,70011017)
insert into cl_errores values(70011010, 0, 'ERROR AL INSERTAR DATOS EN LA TABLA SB_REPORTE_BURO_CUENTAS')
insert into cl_errores values(70011011, 0, 'ERROR AL INSERTAR DATOS EN LA TABLA SB_BURO_CLIENTE')
insert into cl_errores values(70011012, 0, 'ERROR AL INSERTAR DATOS EN LA TABLA SB_BURO_DIRECCION')
insert into cl_errores values(70011014, 0, 'ERROR AL INSERTAR DATOS EN LA TABLA SB_BURO_EMPLEO')
insert into cl_errores values(70011015, 0, 'ERROR AL INSERTAR DE LA FECHA PROCESO EN LA TABLA SB_BURO_FC_FECHA_ULT_PROC- INTF FORMATO CORTO')
insert into cl_errores values(70011017, 0, 'ERROR NO HAY REGISTRO EN TABLA SB_BURO_FC_FECHA_ULT_PROC')

delete from cobis..cl_errores where numero in (601315,601316, 601317, 601318 , 601319, 601320, 601321)

insert into  cl_errores(numero, severidad, mensaje) values (601315, 0, 'Proceso de cierre fuera del mes de ENERO')
insert into  cl_errores(numero, severidad, mensaje) values (601316, 0, 'El parametro MESFPE, que controla el mes de ingreso del comprobante contable de fin de periodo debe ser 1 o 12')      
insert into  cl_errores(numero, severidad, mensaje) values (601317, 0, 'El corte de la fecha de ingreso del comprobante de fin de periodo está cerrado')      
insert into  cl_errores(numero, severidad, mensaje) values (601318, 0, 'El corte de la fecha de fin de año está abierto')      
insert into  cl_errores(numero, severidad, mensaje) values (601319, 0, 'Error al calcular la feha habil')      
insert into  cl_errores(numero, severidad, mensaje) values (601320, 0, 'Error no tiene provisiones para la fecha de comprobante')     
insert into  cl_errores(numero, severidad, mensaje) values (601321, 0, 'ERROR: No existen equivalencias para el catálogo consultado.')  

--Error.191254
delete from cobis..cl_errores where numero in (70011020)
insert into  cobis..cl_errores values (70011020, 0, 'CLIENTE NO CUENTA CON DIRECCION DE DOMICILIO')

go
