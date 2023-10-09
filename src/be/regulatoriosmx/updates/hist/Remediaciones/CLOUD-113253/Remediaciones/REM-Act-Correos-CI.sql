/*********************************OAB REMEDIACION *****************************************/
/* Al realizar 2 solicitudes para Contrato Individual se equivocó el asesor al escribir   */ 
/* el correo electrónico, por lo que el mail se envío al correo registrado. Se realizo la */
/* corrección de los correos a los clientes.                                              */
/*                                                                                        */
/* Se solicita renvíar el correo a los clientes nuevamente para que sigan con el proceso  */
/* de registro.                                                                           */
/*                                                                                        */
/* Los clientes con los correos correctos son:                                            */
/*                                                                                        */
/* 12305 MINERVA GARCIA GARCIA (garciaminerva806@gmail.com)                               */
/* 12295 SUSANA VAZQUEZ GARCIA (susanavg1903@gmail.com)                                   */
/******************************************************************************************/

use cob_credito
go

update cr_ns_creacion_lcr set 
nc_correo = 'susanavg1903@gmail.com',
nc_estado = 'P'
where nc_tramite = (select tr_tramite 
from cr_tramite 
where tr_cliente = 12295
and tr_toperacion = 'REVOLVENTE')

update cr_ns_creacion_lcr set 
nc_correo = 'garciaminerva806@gmail.com',
nc_estado = 'P'
where nc_tramite = (select tr_tramite 
from cr_tramite 
where tr_cliente = 12305
and tr_toperacion = 'REVOLVENTE')

update cr_tramite set 
tr_producto = 'CCA'
where tr_toperacion = 'REVOLVENTE'

go