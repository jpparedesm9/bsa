@echo off
if "%1"=="" goto ayuda
if "%2"=="" goto ayuda
if "%3"=="" goto ayuda
if "%4"=="" goto ayuda
if "%5"=="" goto ayuda
if "%6"=="" goto ayuda

cd

echo Inicia Internacionalizacion

echo param.sql
   sqlcmd  -U%1 -P%2 -S%3   -i %5\param.sql     -o %6\param.out
echo errores.sql
   sqlcmd  -U%1 -P%2 -S%3   -i %5\errores.sql   -o %6\errores.out
echo catalogo.sql
   sqlcmd  -U%1 -P%2 -S%3   -i %5\catalogo.sql  -o %6\catalogo.out
echo bv_view.sql
   sqlcmd  -U%1 -P%2 -S%3   -i %5\bv_view.sql   -o %6\bv_view.out
  
echo Termina Internacionalizacion
	
echo ad_fkey.sql      
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_fkey.sql   -o %6\ad_fkey.out
echo ad_trser.sql      
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_trser.sql   -o %6\ad_trser.out
echo ad_ins.sql        
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_ins.sql     -o %6\ad_ins.out
echo ad_err.sql        
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_err.sql     -o %6\ad_err.out
echo ad_err_seg.sql        
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_err_seg.sql     -o %6\ad_err_seg.out
	
echo ad_error_con.sql        
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_error_con.sql     -o %6\ad_error_con.out
echo ad_segur.sql        
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_segur.sql     -o %6\ad_segur.out
echo ad_segurvk.sql        
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_segurvk.sql     -o %6\ad_segurvk.out
echo ad_segur_con.sql        
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_segur_con.sql     -o %6\ad_segur_con.out
echo ad_vistas_trnser.sql        
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_vistas_trnser.sql     -o %6\ad_vistas_trnser.out
	
REM echo ad_interceptores.sql        
REM	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_interceptores.sql     -o %6\ad_interceptores.out
REM echo ad_ex_drop.sql
REM	sqlcmd  -U%1 -P%2 -S%3   -i %5\ad_ex_drop.sql     -o %6\ad_ex_drop.out
echo cat_ex_table.sql
	sqlcmd  -U%1 -P%2 -S%3   -i %5\cat_ex_table.sql     -o %6\cat_ex_table.out
echo ve_table.sql
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ve_table.sql  -o %6\ve_table.out
echo ve_pkey.sql
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ve_pkey.sql  -o %6\ve_pkey.out
	
echo ve_catlo.sql
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ve_catlo.sql  -o %6\ve_catlo.out
echo ve_error.sql
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ve_error.sql  -o %6\ve_error.out
echo ve_produ.sql
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ve_produ.sql  -o %6\ve_produ.out
echo ve_segu.sql
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ve_segu.sql   -o %6\ve_segu.out
echo ve_traut.sql
	sqlcmd  -U%1 -P%2 -S%3   -i %5\ve_traut.sql  -o %6\ve_traut.out



rem echo exec %6...sp_droplogin admuser > %5\temp.cobis
rem echo exec %6...sp_addlogin admuser,"Z~if701" >> %5\temp.cobis
rem echo go >> %5\temp.cobis

echo %6...rp_tr_droplogin @i_loginame = 'admuser' > %5\temp.cobis
echo go >> %5\temp.cobis
echo %6...rp_tr_addlogin @i_loginame = 'admuser', @i_password = 'Z~if701' >> %5\temp.cobis
echo go >> %5\temp.cobis

echo use cobis >> %5\temp.cobis
echo go >> %5\temp.cobis
echo truncate table ad_nodo_oficina >> %5\temp.cobis
echo go >> %5\temp.cobis
echo insert into ad_nodo_oficina	(nl_filial, nl_oficina, nl_nodo,  >> %5\temp.cobis
echo				 nl_sis_operativo, nl_nombre, nl_fecha_reg, >> %5\temp.cobis
echo				 nl_registrador, nl_fecha_habil, nl_terminal, >> %5\temp.cobis
echo				 nl_estado, nl_secuencial, nl_fecha_ult_mod, >> %5\temp.cobis
echo			 	 nl_x, nl_y) >> %5\temp.cobis
echo			values	(1, 1, 1, >> %5\temp.cobis
echo				 1, "%6", getdate(), >> %5\temp.cobis
echo				 1, getdate(), 0, >> %5\temp.cobis
echo				 "V", 1, getdate(),  >> %5\temp.cobis
echo				 0, 0) >> %5\temp.cobis
echo go >> %5\temp.cobis

echo update	cl_seqnos >> %5\temp.cobis
echo set	siguiente = 1 >> %5\temp.cobis
echo where	tabla = "ad_nodo_oficina" >> %5\temp.cobis
echo go >> %5\temp.cobis

sqlcmd  -U%1 -P%2 -S%3 -i %5\temp.cobis -o %5\nodo_oficina.out

rem JHI: Se comenta insercion de parametrizacion porque no aplica (personalizacion Globalbank)
rem echo ad_ins.sql        
rem 	isql -U%1 -P%2 -S%3   -i %4\ad_ins_up_fun.sql     -o %5\ins_up_fun.out

echo Fin.

goto fin

:ayuda
echo full.cmd [parametro 1] [parametro 2] [parametro 3] [parametro 4] [parametro 5] [parametro 6] 
echo donde:
echo [parametro 1]: usuario de SQL
echo [parametro 2]: password del usuario de SQL
echo [parametro 3]: nombre del servidor SQL
echo [parametro 4]: directorio de los fuentes
echo [parametro 5]: directorio del log de instalacion
echo [parametro 6]: Nombre del TranServer Cobis
:fin
