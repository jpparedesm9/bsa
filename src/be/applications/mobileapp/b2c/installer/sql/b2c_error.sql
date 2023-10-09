/********************************************************************************/
/*   Archivo:                b2c_error.sql                                       */
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
/*  Ingreso de errores para Modulos ADMINBV - IB                                */
/********************************************************************************/
/* SCRIPT PARA EJECUTARSE EN EL SERVIDOR CENTRAL                                */
/*                                                                              */
/********************************************************************************/
/*                           MODIFICACIONES                                     */
/********************************************************************************/
/* FECHA         VERSION    AUTOR           RAZON                               */
/********************************************************************************/
/* 23/Nov/2018   4.1.0.5    Estefania Ramirez  Emision Inicial Instalador B2C   */
/********************************************************************************/

use cobis
go

/* --- TCS --- */
print 'Eliminar datos de cl_errores para AdminBV'
go
delete from cl_errores  where numero between 1800000 and 1890025
delete from cl_errores  where numero between 17000 and 17046
go


go
insert into cl_errores values( 17000, 0, 'El dispositivo no ha sido activado')
go
insert into cl_errores values( 17001, 0, 'Error en el código de la transacción')
go
insert into cl_errores values( 17020, 0, 'Error no hay un registro en bv_login con esas credenciales para canal Banca Móvil')
go
insert into cl_errores values( 17024, 0, 'Error al consultar clave temporal')
go
insert into cl_errores values( 17025, 0, 'Clave incorrecta')
go
insert into cl_errores values( 17041, 0, 'Error al actualizar la tabla bv_login')
go
insert into cl_errores values( 17042, 0, 'Error al actualizar la tabla bv_login_devices')
go
insert into cl_errores values( 17043, 0, 'El usuario no dispone de acceso biometrico')
go
insert into cl_errores values( 17044, 0, 'El usuario no dispone de dispositivos biométricos activados')
go
insert into cl_errores values( 17046, 0, 'No hay registros en tabla bv_login_devices')
go
insert into cl_errores values (1802146, 1,'ERROR AL ESTABLECER LA CLAVE TEMPORAL')
go
insert into cl_errores values (1802154, 1,'EL USUARIO NO ESTA ACTIVO')
go
insert into cl_errores values( 1850030, 1, 'Error en la inserción de cliente')
go
insert into cl_errores values( 1850031, 1, 'Error en la actualización de cliente')
go
insert into cl_errores values( 1850034, 1, 'Error en la inserción en transaccion de servicio')
go
insert into cl_errores values( 1850064, 1, 'Error en la inserción de logines')
go
insert into cl_errores values( 1850065, 1, 'Usuario/user ya existe')
go
insert into cl_errores values( 1850067, 1, 'Error en la actualización de login')
go
insert into cl_errores values( 1850069, 1, 'Error al eliminar registros')
go
insert into cl_errores values( 1850070, 1, 'No existen datos de las operaciones')
go
insert into cl_errores values( 1850071, 1, 'Error en inserción de registro')
go
insert into cl_errores values( 1850072, 1, 'Se ha superado el número máximo de intentos')
go
insert into cl_errores values( 1850068, 1, 'Error en la eliminación del login')
go
insert into cl_errores values( 1850119, 0, 'Ente ya registrado en el sistema BV')
go
insert into cl_errores values( 1850125, 1, 'Canal Deshabilitado. Por favor intente más tarde')
go
insert into cl_errores values( 1875000, 1, 'LOGIN NO AUTORIZADO O NO EXISTE')
go
insert into cl_errores values( 1875001, 1, 'CLAVE INCORRECTA(O)')
go
insert into cl_errores values( 1875005, 1, 'SU PASSWORD HA SIDO CADUCADO, DEBE INGRESAR A: ACTUALIZACION DE CLAVE')
go
insert into cl_errores values( 1875022, 1, 'ERROR EN EL REGISTRO DE USUARIO')
go
insert into cl_errores values( 1875023, 1, 'USUARIO YA SE ENCUENTRA CONECTADO DESDE OTRO COMPUTADOR')
go
insert into cl_errores values( 1875024, 1, 'ERROR EN LA ELIMINACIÓN DE LA TABLA bv_in_login')
go
insert into cl_errores values( 1875066, 0, 'EL USUARIO SE ENCUENTRA BLOQUEADO O INACTIVO, ACERQUESE A UNA OFICINA DEL BANCO PARA ACTIVARLA')
go
insert into cl_errores values (1875125, 1, 'ACCESO NO PERMITIDO POR EL MOMENTO. POR FAVOR INTENTE NUEVAMENTE DENTRO DE UNOS MINUTOS')
go
insert into cl_errores values( 1875145, 1, 'SU CLAVE TEMPORAL ESTÁ CADUCADA')
GO
INSERT INTO cl_errores VALUES (1875228, 0, 'DEBE INICIAR SESIÓN UTILIZANDO EL MÉTODO DE AUTENTICACIÓN POR TOKEN')
GO
INSERT INTO cl_errores VALUES (1875268, 1, 'EL CLIENTE NO TIENE AUTORIZADO EL METODO DE AUTENTICACIÓN')
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
insert into cl_errores values (1890006, 1, 'Error en actualización de registro')
go
insert into cl_errores values (1890007, 1, 'MENSAJE NO ENVIADO A ESTE CLIENTE')
go
insert into cl_errores values (1890008, 1, 'MENSAJE NO REQUIERE EJECUCIÓN')
go
insert into cl_errores values (1890009, 1, 'MENSAJE NO REQUIERE EJECUCIÓN')
go
insert into cl_errores values (1890010, 1, 'El usuario no se encuentra bloqueado temporalmente')
go
insert into cl_errores values (1890011, 1, 'El usuario se encuentra bloqueado temporalmente')
go
insert into cl_errores values (1890012, 0, 'EL MENSAJE NO ESTA VIGENTE A LA FECHA')
go
insert into cl_errores values (1890013, 0, 'EL MENSAJE YA FUE RESPONDIDO CON UNA RESPUESTA DIFERENTE')
go
insert into cl_errores values (1890014, 0, 'RESPUESTA NO VALIDA')
go
insert into cl_errores values (1890015, 0, 'El login ya se encuentra asignado a otro cliente del banco')
go
insert into cl_errores values (1890016, 0, 'El teléfono ingresado no es válido ')

insert into cl_errores values (1890017, 0, 'ERROR: NO SE INGRESO UN NÚMERO DE CELULAR')
go
insert into cl_errores values (1890018, 0, 'ERROR: NO SE INGRESO UN CORREO ELECTRÓNICO')
go
insert into cl_errores values (1890019, 0, 'El número de celular ingresado no está registrado para un cliente de este servicio')
go
insert into cl_errores values (1890020, 0, 'El cliente no tiene operaciones activas')
go
insert into cl_errores values (70011019, 0, 'El número celular capturado ya existe, por favor ingrese uno nuevo')
go
insert into cobis..cl_errores values(70011021, 0,'No se encuentra dentro del rango de edad permitido')
go

-- -------------------------------------------------------------------------
INSERT INTO cobis..cl_errores (numero,severidad,mensaje) VALUES(1890020,0,'ERROR: El número de celular ya se encuentra registrado para este proceso')
GO
INSERT INTO cobis..cl_errores (numero,severidad,mensaje) VALUES(1890021,0,'ERROR: No se pueden registrar los datos')
GO
INSERT INTO cobis..cl_errores (numero,severidad,mensaje) VALUES(1890022,0,'ERROR: No se puede enviar el código OTP')
GO

INSERT INTO cobis..cl_errores (numero,severidad,mensaje) VALUES(1890023,0,'ERROR: Tipo de envío no es admitido')
GO
INSERT INTO cobis..cl_errores (numero,severidad,mensaje) VALUES(1890024,0,'ERROR: El codigo OTP no existe')
GO
INSERT INTO cobis..cl_errores (numero,severidad,mensaje) VALUES(1890025,0,'ERROR: EL codigo OTP ha caducado')


go

