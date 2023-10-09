/************************************************************/
/*   CARGA DE DATOS INICIALES                               */
/*  20-04-2016      BBO     Migracion SYB-SQL FAL           */
/************************************************************/

use cobis
go


/* Catalogos */

print 'Insercion de catalogos...'
go

declare @w_sig_tabla int

if exists (select 1 from cl_tabla where tabla = 'ba_lenguaje')
begin
  select @w_sig_tabla = codigo from cl_tabla where tabla = 'ba_lenguaje'

  delete from cl_catalogo where tabla = @w_sig_tabla 
  delete from cl_catalogo_pro where cp_tabla = @w_sig_tabla 
  delete from cl_tabla where codigo = @w_sig_tabla 

end


select @w_sig_tabla = max (codigo) + 1 from cl_tabla

select @w_sig_tabla 

insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_sig_tabla, 'ba_lenguaje', 'Tipos de lenguajes o programas para el batch')
insert into cl_catalogo	(tabla, codigo, valor, estado)
		values	(@w_sig_tabla, 'CM', 'LENGUAJE DE COMANDO DOS', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado)
		values	(@w_sig_tabla, 'EX', 'EJECUTABLE WINDOWS / BINARIO', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado)
		values	(@w_sig_tabla, 'QL', 'SCRIPT SQL', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado)
		values	(@w_sig_tabla, 'QR', 'PROGRAMA SQR', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado)
		values	(@w_sig_tabla, 'SH', 'SHELL DE UNIX', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado)
		values	(@w_sig_tabla, 'SP', 'STORED PROCEDURE', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado)
		values	(@w_sig_tabla, 'EP', 'EJECUTABLE WINDOWS CON PARAMETROS', 'V')

insert into cl_catalogo_pro (cp_producto, cp_tabla)
		values	('BAT', @w_sig_tabla) 

if exists (select 1 from cl_tabla where tabla = 'ba_protocolo')
begin
  select @w_sig_tabla = codigo from cl_tabla where tabla = 'ba_protocolo'

  print 'Codigo Actual: ' + convert(varchar, @w_sig_tabla )

  delete from cl_catalogo where tabla = @w_sig_tabla 
  delete from cl_catalogo_pro where cp_tabla = @w_sig_tabla 
  delete from cl_tabla where codigo = @w_sig_tabla 

end

select @w_sig_tabla = max (codigo) + 1 from cl_tabla

select @w_sig_tabla 

insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_sig_tabla, 'ba_protocolo', 'Protocolos de conexión')
insert into cl_catalogo	(tabla, codigo, valor, estado)
		values	(@w_sig_tabla, 'FTP', 'Conexión FTP', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado)
		values	(@w_sig_tabla, 'SFTP', 'Conexión SFTP', 'V')
insert into cl_catalogo_pro (cp_producto, cp_tabla)
		values	('BAT', @w_sig_tabla) 

print 'Actualizacion de cl_seqnos'
update cl_seqnos
set siguiente=@w_sig_tabla
from cl_seqnos
where tabla ='cl_tabla'


go


/* Parametro para el cambio de fecha de acuerdo a la plataforma CTS y/o Kernel */

if exists(select 1 from cl_parametro where pa_nemonico = 'PTFCOB' and pa_producto = 'BAT')
	delete  cl_parametro where pa_nemonico = 'PTFCOB' and pa_producto = 'BAT'
go
/* Insercion de Parametro CTS para el Producto BATCH */
insert into cl_parametro 
	(pa_nemonico, pa_parametro, pa_tipo, pa_char, pa_producto)
values ('PTFCOB', 'INDICADOR DE PLATAFORMA COBIS PARA EL CAMBIO DE FECHA BATCH', 'C', 'KRN' , 'BAT')  --KRN: Solo Kernel, CTS: Solo CTS, CON: Convivencia Kernel y CTS
go


/* Insertcion de nuevo parametro SRVCFP */
if exists(select 1 from cl_parametro where pa_nemonico = 'SRVCFP' and pa_producto = 'BAT')
	delete  cl_parametro where pa_nemonico = 'SRVCFP' and pa_producto = 'BAT'
go
/* Insercion de Parametro CTSSRV para el Producto BATCH */
insert into cl_parametro 
	(pa_nemonico, pa_parametro, pa_tipo, pa_char, pa_producto)
values ('SRVCFP', 'NOMBRE DE SERVIDOR CTS PARA CAMBIO FECHA PROCESO', 'C', 'CTSSRV' , 'BAT')  
go

 /* Insert en ba_habilita */
if exists (select 1 from ba_habilita where ha_producto in (1,8)) 
  delete ba_habilita where ha_producto in (1,8)
go  
insert into ba_habilita values (1, 'ADMIN')
go
insert into ba_habilita values (8, 'BATCH')
go

/* Insert en ad_respaldo */
if exists (select 1 from ad_respaldo where re_codigo = 1) 
  delete ad_respaldo where re_codigo = 1
go  
insert into ad_respaldo values (1,'c:\tmp\prueba_resp')
go
