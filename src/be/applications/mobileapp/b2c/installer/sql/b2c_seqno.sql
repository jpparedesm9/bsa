/************************************************************************/
/*  Archivo:            b2c_seqno.sql                                    */
/*  Base de datos:      cobis                                           */
/*  Producto:           Banca Virtual                                   */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "Cobiscorp".                                                        */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.              */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Seqnos BV AdminBV                                                   */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA               AUTOR           RAZON                           */
/*  22-Nov-2018         ERA             Instalador Bussiness to custumer*/
/************************************************************************/
use cobis
go

delete from cl_seqnos
where bdatos = 'cob_bvirtual'
go

print 'Insercion de entradas en cl_seqnos para B2C'
go
declare @w_sig int
select @w_sig = max(en_ente) from cob_bvirtual..bv_ente
if EXISTS (SELECT 1 FROM cl_seqnos WHERE tabla = 'bv_ente')
update cl_seqnos set bdatos = 'cob_bvirtual', siguiente = @w_sig + 1, pkey = 'en_ente' where tabla = 'bv_ente'
else
	insert into cl_seqnos values ('cob_bvirtual','bv_ente',@w_sig + 1,'en_ente')

-- -----
if EXISTS (SELECT 1 FROM cl_seqnos WHERE tabla = 'bv_log')
update cl_seqnos set bdatos = 'cob_bvirtual', siguiente = 0, pkey = 'bv_log' where tabla = 'lo_secuencial'
else
insert into cl_seqnos values ('cob_bvirtual','bv_log',0,'lo_secuencial')

-- -----
select @w_sig = max(tp_id) from cob_bvirtual..bv_trans_procesos
if exists (SELECT 1 from cobis..cl_seqnos where tabla = 'bv_trans_procesos')
	update cl_seqnos set bdatos = 'cob_bvirtual', siguiente = @w_sig + 1, pkey = 'tp_id' where tabla = 'bv_trans_procesos'
else
	insert into cobis..cl_seqnos values ('cob_bvirtual','bv_trans_procesos',1,'tp_id')
	
go