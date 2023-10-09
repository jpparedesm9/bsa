/************************************************************************/
/*  Archivo:        an_error.sql                                        */
/*  Base de datos:  cobis                                               */
/*  Producto:       Admin CEN                                           */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  Cobiscorp.                                                          */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.              */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Insercion de datos iniciales de errores del Admin para el manejor   */
/*  de las estrucuturas de Cobis Explorer .net                          */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/* 11/Mar/2010  S. Soto     Emision Inicial                             */
/************************************************************************/

use cobis
go

/*************************************/
/* REGISTRO DE ERRORES EN cl_errores */
/*************************************/

delete cl_errores where 
 numero in (151165, 151166,151167,151168,153069,151169,153070,155071,157142,157093,157098,157923,157924) or
 numero between 157099 and 157210
go    

print 'Registro de Errores para CEN'
go
insert into cl_errores values (151165, 0, 'No existe la pagina referenciada')
insert into cl_errores values (151166, 0, 'No existe asociacion entre el rol y la pagina')
insert into cl_errores values (151167, 0, 'No existe la cultura referenciada')
insert into cl_errores values (151168, 0, 'No existe la etiqueta referenciada')
insert into cl_errores values (151169, 0, 'Error inesperado de BDD consulte a su Administrador')
insert into cl_errores values (153069, 0, 'Error en insercion de la pagina por rol')
insert into cl_errores values (153070, 0, 'Error en insercion de la etiqueta')
insert into cl_errores values (155071, 0, 'Error en actualizacion de la etiqueta')
insert into cl_errores values (157142, 0, 'Error en eliminacion de pagina por rol')
insert into cl_errores values (157093, 0, 'Error en eliminacion de la etiqueta')
insert into cl_errores values (157098, 0, 'No existen roles asociados al usuario y app ejecutable')
go

print ' Registro de Errores de Admin NET'
go
--OJO: Falta definir la severidad!
insert into cl_errores values (157099, 0,'Existio un error al registrar el Grupo de Modulos')
insert into cl_errores values (157100, 0,'Ya existe un Grupo de Modulos con este codigo')
insert into cl_errores values (157101, 0,'El Grupo de Modulos no se encuentra registrado')
insert into cl_errores values (157102, 0,'Existio un error al actualizar el Grupo de Modulos')
insert into cl_errores values (157103, 0,'No es posible eliminar, existen Modulos asociados al Grupo de Modulos')
insert into cl_errores values (157104, 0,'Existio un error en la eliminacion del Grupo de Modulos')
insert into cl_errores values (157105, 0,'No existen mas registros de Grupos de Modulos')
insert into cl_errores values (157106, 0,'El Tipo de Componente no se encuentra registrado')
insert into cl_errores values (157107, 0,'Existio un error al registrar el Componente')
insert into cl_errores values (157108, 0,'Ya existe un registro de Componente con este codigo')
insert into cl_errores values (157109, 0,'El Componente no se encuentra registrado')
insert into cl_errores values (157110, 0,'Existio un error al actualizar el Componente')
insert into cl_errores values (157111, 0,'El Componente no esta asociado al Modulo')
insert into cl_errores values (157112, 0,'No es posible eliminar, el Componente se encuentra asociado a una Zona de Pagina')
insert into cl_errores values (157113, 0,'No es posible eliminar, el Componente se encuentra asociado a una Zona de Navegacion')
insert into cl_errores values (157114, 0,'No es posible elminar, el Componente se encuentra autorizado a un Rol ')
insert into cl_errores values (157115, 0,'Existio un error al eliminar el Componente')
insert into cl_errores values (157116, 0,'No existen registros de Componentes')
insert into cl_errores values (157117, 0,'El Modulo no se encuentra registrado')
insert into cl_errores values (157118, 0,'El Modulo Padre no se encuentra registrado')
insert into cl_errores values (157119, 0,'Existio un error al registrar de modulo')
insert into cl_errores values (157120, 0,'Ya existe un registro de Modulo con ese codigo')
insert into cl_errores values (157121, 0,'El codigo del Modulo Padre no puede ser el mismo ')
insert into cl_errores values (157122, 0,'Existio un error en la actualizacion del Modulo')
insert into cl_errores values (157123, 0,'No es posible eliminar, el Modulo es padre de otro modulo')
insert into cl_errores values (157124, 0,'No es posible eliminar, el Modulo esta autorizado para un rol')
insert into cl_errores values (157125, 0,'Existio un error al eliminar el Modulo')
insert into cl_errores values (157126, 0,'No existen mas registros de Modulos')
insert into cl_errores values (157127, 0,'La Cultura no se encuentra registrada')
insert into cl_errores values (157128, 0,'Existio un error al registrar la Etiqueta')
insert into cl_errores values (157129, 0,'Ya existe un registro de Etiqueta para la Cultura')
insert into cl_errores values (157130, 0,'La Etiqueta no se encuentra registrada en la Cultura')
insert into cl_errores values (157131, 0,'Existio un error en la actualizacion de la Etiqueta')
insert into cl_errores values (157132, 0,'No es posible eliminar, la Etiqueta se encuentra asociada en una pagina')
insert into cl_errores values (157133, 0,'No es posible eliminar, la Etiqueta se encuentra asociada en una zona de pagina')
insert into cl_errores values (157134, 0,'No es posible eliminar, la Etiqueta se encuentra asociada en una zona de navegacion')
insert into cl_errores values (157135, 0,'No es posible eliminar, a Etiqueta se encuentra asociada en un modulo')
insert into cl_errores values (157136, 0,'Existio un error al eliminar la Etiqueta')
insert into cl_errores values (157137, 0,'No existen mas registros de Etiqueta')
insert into cl_errores values (157138, 1,'Existió un error al autorizar el módulo')
insert into cl_errores values (157139, 0,'El Modulo no se encuentra autorizado al Rol')
insert into cl_errores values (157140, 1,'Existió un error al desautorizar el módulo')
insert into cl_errores values (157141, 0,'No existen mas Modulos autorizados al Rol')
--insert into cl_errores values (157142, 0,'Busqueda de componentes ha finalizado')
insert into cl_errores values (157143, 0,'Existio un error al autorizar La Zona de Navegacion al Rol')
insert into cl_errores values (157144, 0,'La Zona de Navegacion no se encuentra autorizada al Rol')
insert into cl_errores values (157145, 1,'Existió un error al desautorizar la zona de navegación')
insert into cl_errores values (157146, 0,'No existen mas Zonas de Navegacion autorizadas al rol')
insert into cl_errores values (157147, 0,'La Pagina Superior no se encuentra registrada')
insert into cl_errores values (157148, 0,'El Producto CEN no se encuentra registrado')
insert into cl_errores values (157149, 1,'Existio un error al registrar la Pagina')
insert into cl_errores values (157150, 0,'Ya existe un registro de Pagina con ese codigo')
insert into cl_errores values (157151, 0,'La Pagina no se encuentra registrada')
insert into cl_errores values (157152, 0,'Existio un error en la actualizacion de la Pagina')
insert into cl_errores values (157153, 0,'No es posible eliminar, pues esta pagina es superior a otra pagina')
insert into cl_errores values (157154, 0,'No es posible eliminar pues la pagina esta asociada a un rol')
insert into cl_errores values (157155, 1,'Existio un error al eliminar las zonas asociadas a la pagina')
insert into cl_errores values (157156, 1,'Existio un error al eliminar la Pagina')
insert into cl_errores values (157157, 0,'No existen mas registros de Paginas')
insert into cl_errores values (157158, 0,'La Zona no se encuentra registrada')
insert into cl_errores values (157159, 0,'La Zona de Pagina Superior no se encuentra registrada')
insert into cl_errores values (157160, 0,'Ya existe una Pagina con el mismo orden dentro de la Pagina Superior')
insert into cl_errores values (157161, 0,'Ya existe un registro de Zona de Pagina con ese codigo')
insert into cl_errores values (157162, 1,'Existio un error al registrar la de Zona de Pagina')
insert into cl_errores values (157163, 0,'Ya existe un registro de Zona de Pagina con ese codigo')
insert into cl_errores values (157164, 0,'La Zona de Pagina no se encuentra registrada')
insert into cl_errores values (157165, 0,'Existio un error en la actualizacion de la Zona de Pagina')
insert into cl_errores values (157166, 0,'No es posible eliminar, pues esta Zona de Pagina es superior a otra ')
insert into cl_errores values (157167, 0,'Existio un error al eliminar la Zona de Pagina')
insert into cl_errores values (157168, 0,'No existen mas Zonas de Pagina')

insert into cl_errores values (157170, 1,'Existió un error al autorizar el componente')
insert into cl_errores values (157171, 0,'El Componente ya se encuentra autorizado para el Rol')
insert into cl_errores values (157172, 0,'El Componente no se encuentra autorizado al Rol')
insert into cl_errores values (157173, 0,'Este nombre de Pagina ya ha sido utilizado')
insert into cl_errores values (157174, 1,'Existió un error al desautorizar el componente')
insert into cl_errores values (157175, 0,'No existen Componentes autorizados al Rol')
insert into cl_errores values (157176, 0,'Ya existe una zona de navegación con el mismo orden')
insert into cl_errores values (157177, 0,'Existio un error al insertar el registro de Zona de Navegacion')
insert into cl_errores values (157178, 0,'Ya existe un registro de Zona de Navegacion con este codigo')
insert into cl_errores values (157179, 0,'La Zona de Navegacion no se encuentra registrada')
insert into cl_errores values (157180, 0,'Existio un error al actualizar la Zona de Navegacion')
insert into cl_errores values (157181, 0,'No es posible eliminar, la Zona de Navegacion se encuentra autorizada a un Rol')
insert into cl_errores values (157182, 0,'Existio un error al eliminar la Zona de Navegacion')
insert into cl_errores values (157183, 0,'No existen mas Zonas de Navegacion')

insert into cl_errores values (157185, 0,'Existio un error al asociar el Prerequisitos para la Pagina')
insert into cl_errores values (157186, 0,'Ya existe el Prerequisisto para la Pagina')
insert into cl_errores values (157187, 0,'El Prerequisito de la Pagina no esta registrado')

insert into cl_errores values (157189, 0,'Existio un error al eliminar el Prerequisito de la Pagina')
insert into cl_errores values (157190, 0,'No existen mas Prerequsitos de Pagina')

insert into cl_errores values (157192, 1,'Existió un error al autorizar la página')
insert into cl_errores values (157193, 0,'La Pagina ya se encuentra autorizada al Rol')
insert into cl_errores values (157194, 0,'La Pagina no se encuentra autorizada para el Rol')

insert into cl_errores values (157196, 1,'Existió un error al desautorizar la página')
insert into cl_errores values (157197, 0,'No existen mas Paginas autorizadas al Rol')

insert into cl_errores values (157199, 0,'Existio un error al autorizar el Modulo para el Usuario - Rol')
insert into cl_errores values (157200, 0,'El Modulo ya se encuentra autorizado al Usuario - Rol')
insert into cl_errores values (157201, 0,'El Modulo no se encuentra autorizado al Usuario - Rol')
insert into cl_errores values (157202, 0,'Existio un error al eliminar la autorizacion del Modulo al Usuario - Rol')
insert into cl_errores values (157203, 0,'No existen mas Modulos autorizados al Usuario - Rol')


insert into cl_errores values (157206, 0,'La Zona de Navegacion no se encuentra registrada')
insert into cl_errores values (157207, 1,'Existió un error al autorizar la zona de navegación')
insert into cl_errores values (157208, 0,'La Zona de Navegacion no se encuentra asociada al rol')
insert into cl_errores values (157209, 0,'Existio un error al eliminar la asociacion Rol - Zona de Navegacion')
insert into cl_errores values (157210, 0,'No existen mas registros de Zonas de Navegacion asociadas al rol')

insert into cl_errores values (157923, 1,'No existe la etiqueta')
insert into cl_errores values (157924, 1,'Error en la actualización de la etiqueta')
go
print 'Fin de Registro de Errores'
go

