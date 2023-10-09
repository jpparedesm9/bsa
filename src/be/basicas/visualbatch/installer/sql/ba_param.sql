/************************************************************************/
/*	Archivo:		ba_param.sql			                            */
/*	Base de datos:	cobis					                            */
/*	Producto:		Batch					                            */
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
/*  10/05/2012  Isaac Torres           Emision Inicial                  */
/*  17/07/2013  Juan Tagle             Se agrega 8004 en lote 8002      */
/*  12/11/2013  Jairo Reyes            Sarta nueva 8006                 */
/*  20/04/2016  BBO                    Migracion SYB-SQL FAL            */
/************************************************************************/

use cobis
go

print '----->  ba_param'
go

if exists (select * from ba_parametro
	       where pa_batch between 8001 and 8999)
	delete ba_parametro where pa_batch between 8001 and 8999
go
print 'REGISTRO DE PARAMETROS DEFAULT DE PROGRAMAS BATCH - BATCH'
go

declare @w_fecha_proceso datetime		
select @w_fecha_proceso = fp_fecha from ba_fecha_proceso

insert into ba_parametro (pa_sarta,pa_batch,pa_ejecucion,pa_parametro,pa_nombre,pa_tipo,pa_valor)
	values(0,8003,0,1,'@i_fecha_proceso','D',@w_fecha_proceso)
insert into ba_parametro (pa_sarta,pa_batch,pa_ejecucion,pa_parametro,pa_nombre,pa_tipo,pa_valor)
	values(8003,8003,1,1,'@i_fecha_proceso','D',@w_fecha_proceso)
go

/* COMENTADO PARA FALABELLA
--insert into ba_parametro (pa_sarta,pa_batch,pa_ejecucion,pa_parametro,pa_nombre,pa_tipo,pa_valor)
--	values(0,8004,0,1,'@i_tipo','I','0')
--insert into ba_parametro (pa_sarta,pa_batch,pa_ejecucion,pa_parametro,pa_nombre,pa_tipo,pa_valor)
--	values(8002,8004,2,1,'@i_tipo','I','0')
--go

--insert into ba_parametro (pa_sarta,pa_batch,pa_ejecucion,pa_parametro,pa_nombre,pa_tipo,pa_valor)
--	values(0,8006,0,1,'@i_codigo','I','0')
--insert into ba_parametro (pa_sarta,pa_batch,pa_ejecucion,pa_parametro,pa_nombre,pa_tipo,pa_valor)
--	values(8005,8006,2,1,'@i_codigo','I','0')
--go
--insert into ba_parametro (pa_sarta,pa_batch,pa_ejecucion,pa_parametro,pa_nombre,pa_tipo,pa_valor)
--	values(8006,8006,1,1,'@i_codigo','I','1')
--go
--
--INSERT INTO dbo.ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
--		 VALUES ( 0, 8010, 0, 1, '@i_fecha', 'D', '02/04/2015' ) 
--INSERT INTO dbo.ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
--		 VALUES ( 0, 8010, 0, 2, '@i_sarta12', 'I', '18018' ) 
--INSERT INTO dbo.ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
--		 VALUES ( 0, 8010, 0, 3, '@i_batch12', 'I', '18252' ) 
--
--INSERT INTO dbo.ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
--		 VALUES ( 8005, 8010, 1, 1, '@i_fecha', 'D', '02/04/2015' ) 
--INSERT INTO dbo.ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
--		 VALUES ( 8005, 8010, 1, 2, '@i_sarta12', 'I', '18018' ) 
--INSERT INTO dbo.ba_parametro ( pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor ) 
--		 VALUES ( 8005, 8010, 1, 3, '@i_batch12', 'I', '18252' ) 
--go
*/