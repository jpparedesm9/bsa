/* SCRIPT DE CREACION DE SARTAS DE GARANTIAS */
/* AUTOR: GABRIEL ALVIS */
/* FECHA: 13/ABR/2009   */

use cobis
go


/* ELIMINACION DE SARTAS MANEJADAS */
delete ba_sarta
where sa_producto = 19
and sa_sarta = 19201
go


/* INSERCION DE SARTAS */
insert into ba_sarta values(19201,'MENSUAL DE GARANTIAS','MENSUAL DE GARANTIAS',getdate(),'sa',19,NULL,NULL)
go
