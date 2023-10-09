/************************************************************************/
/*	Archivo:		ad_param.sql			                            */
/*	Base de datos:	cobis					                            */
/*	Producto:		Admin					                            */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  Cobiscorp. Su uso no autorizado queda expresamente prohibido        */
/*  asi como cualquier alteracion o agregado hecho por alguno de        */
/*  sus usuarios sin el debido consentimiento por escrito de la         */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.              */
/************************************************************************/
/*				MODIFICACIONES				                            */
/*	FECHA		AUTOR		           RAZON				            */
/*  05/29/2012  Edison Andrade         Emision Inicial                  */
/*  03/14/2013  Juan Tagle             Inc. 19659 - quitar batch 1002   */
/************************************************************************/

use cobis
go

print '----->  ad_param'
go

if exists (select * from ba_parametro
	       where pa_batch between 1001 and 1999)
	delete ba_parametro where pa_batch between 1001 and 1999

print 'REGISTRO DE PARAMETROS DEFAULT DE PROGRAMAS BATCH - ADMIN'
go


/*******************************/
PRINT 'INSERCION: ba_parametro default'

insert into ba_parametro values(0,1003,0,1,'@i_filial','I','1')
insert into ba_parametro values(0,1003,0,2,'@i_fecha','D','01/01/2012')

-- insert into ba_parametro values(0,1002,0,1,'@i_filial','I','1')
-- insert into ba_parametro values(0,1002,0,2,'@i_fecha','D','01/01/2012')

insert into ba_parametro values(0,1001,0,1,'@i_filial','I','1')
insert into ba_parametro values(0,1001,0,2,'@i_fecha','D','01/01/2012')

insert into ba_parametro values(0,1005,0,1,'@i_fecha_proceso','D','01/01/2012')

insert into ba_parametro values(0,1006,0,1,'@i_fecha_proceso','D','01/01/2012')

insert into ba_parametro values(0,1007,0,1,'@i_fecha','D','01/01/2012')
insert into ba_parametro values(0,1007,0,2,'@i_tabla_fuente','C',' ')

insert into ba_parametro values(0,1008,0,1,'@i_module','I','1')
insert into ba_parametro values(0,1008,0,2,'@i_table','C','cobis')
insert into ba_parametro values(0,1008,0,3,'@i_path_sapp','C','C:\ ')
insert into ba_parametro values(0,1008,0,4,'@i_base','C','cobis')

insert into ba_parametro values(0,1010,0,1,'@i_pathdefinicionrdl','C','http://vms01tec15/ADMIN/Reportes Admin/')
insert into ba_parametro values(0,1010,0,2,'@i_carpetaservidor','C','N')
insert into ba_parametro values(0,1010,0,3,'@i_bibliotecasharepoint','C','Reportes Core')
insert into ba_parametro values(0,1010,0,4,'@i_reporte','C','roles_eliminados')
insert into ba_parametro values(0,1010,0,5,'@i_nombresugerido','C','Reportes de Roles Eliminados')
insert into ba_parametro values(0,1010,0,6,'@i_formato','C','EXCEL')
insert into ba_parametro values(0,1010,0,7,'@i_fecha','D','21/08/2012')
insert into ba_parametro values(0,1010,0,8,'@i_fecha_proceso','D','26/04/2013')
insert into ba_parametro values(0,1010,0,9,'@i_modulo','I','1')
go

/*******************************/
PRINT 'INSERCION: ba_parametro'

insert into ba_parametro values(1001,1003,1,1,'@i_filial','I','1')
insert into ba_parametro values(1001,1003,1,2,'@i_fecha','D','01/01/2012')

-- insert into ba_parametro values(1001,1002,2,1,'@i_filial','I','1')
-- insert into ba_parametro values(1001,1002,2,2,'@i_fecha','D','01/01/2012')

insert into ba_parametro values(1001,1001,2,1,'@i_filial','I','1')
insert into ba_parametro values(1001,1001,2,2,'@i_fecha','D','01/01/2012')

insert into ba_parametro values(1001,1005,5,1,'@i_fecha_proceso','D','01/01/2012')

insert into ba_parametro values(1001,1006,6,1,'@i_fecha_proceso','D','01/01/2012')

insert into ba_parametro values(1001,1007,7,1,'@i_fecha','D','01/01/2012')
insert into ba_parametro values(1001,1007,7,2,'@i_tabla_fuente','C',' ')

insert into ba_parametro values(1001,1008,8,1,'@i_module','I','1')
insert into ba_parametro values(1001,1008,8,2,'@i_table','C','cobis')
insert into ba_parametro values(1001,1008,8,3,'@i_path_sapp','C','C:\ ')
insert into ba_parametro values(1001,1008,8,4,'@i_base','C','cobis')

insert into ba_parametro values(1001,1010,9,1,'@i_pathdefinicionrdl','C','http://vms01tec15/ADMIN/Reportes Admin/')
insert into ba_parametro values(1001,1010,9,2,'@i_carpetaservidor','C','N')
insert into ba_parametro values(1001,1010,9,3,'@i_bibliotecasharepoint','C','Reportes Core')
insert into ba_parametro values(1001,1010,9,4,'@i_reporte','C','roles_eliminados')
insert into ba_parametro values(1001,1010,9,5,'@i_nombresugerido','C','Reportes de Roles Eliminados')
insert into ba_parametro values(1001,1010,9,6,'@i_formato','C','EXCEL')
insert into ba_parametro values(1001,1010,9,7,'@i_fecha','D','21/08/2012')
insert into ba_parametro values(1001,1010,9,8,'@i_fecha_proceso','D','26/04/2013')
insert into ba_parametro values(1001,1010,9,9,'@i_modulo','I','1')
insert into ba_parametro values(1001,1010,9,10,'@i_tiempomaximoespera','C','5')
go

