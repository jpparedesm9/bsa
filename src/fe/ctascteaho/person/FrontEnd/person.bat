ss create "$/COBIS Rel 3"
ss cp "$/COBIS Rel 3"
ss create "COBIS Ctas Ctes y Ahorros" -i- 
SS Create "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion" -i- 
SS cp "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS Create "CONEXION" -i- 
SS cp "CONEXION"
SS Create "LOG ON" -i- 
SS Create "LOG OFF" -i- 
SS Create "CAMBIAR PASSWORD" -i- 
SS Create "PREFERENCIAS" -i- 
SS Create "BLOQUEAR TERMINAL" -i- 
SS Create "SALIR" -i- 
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS Create "PRODUCTOS" -i- 
SS cp "PRODUCTOS"
SS Create "PRODUCTOS BANCARIOS" -i- 
SS Create "MERCADO" -i- 
SS Create "PRODUCTOS FINALES" -i- 
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS Create "RANGOS" -i- 
SS cp "RANGOS"
SS Create "TIPO RANGO" -i- 
SS Create "RANGO" -i- 
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS Create "SERVICIOS" -i- 
SS cp "SERVICIOS"
SS Create "SERVICIOS DISPONIBLES" -i- 
SS Create "SERVICIOS BASICOS" -i- 
SS Create "SERVICIOS CONTRATADOS" -i- 
SS Create "RUBROS DE SERVICIOS" -i- 
SS Create "SERVICIOS PERSONALIZABLES" -i- 
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS Create "VALORES" -i- 
SS cp "VALORES"
SS Create "VALOR DE SERVICIO" -i- 
SS cp "VALOR DE SERVICIO"
SS Create "MANTENIMIENTO" -i- 
SS Create "MANTENIMIENTO EN LINEA" -i- 
SS Create "MANTENIMIENTO MASIVO" -i- 
SS Create "CONSULTA DE VALORES VIGENTES" -i- 
SS Create "CONSULTA DE PROXIMOS VALORES VIGENTES" -i- 
SS Create "CONSULTA DE VALORES EN LINEA" -i- 
SS Create "CONSULTA DE PROXIMOS VALORES EN LINEA" -i- 
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "VALORES"
SS Create "PERSONALIZACION DE VALORES" -i- 
SS cp "PERSONALIZACION DE VALORES"
SS Create "CONTRATACION DE SERVICIOS" -i- 
SS Create "PERSONALIZACION DE CUENTA" -i- 
SS Create "CONSULTA DE PERSONALIZACION" -i- 
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS Create "VENTANAS" -i- 
SS cp "VENTANAS"
SS Create "BARRA DE AYUDA" -i- 
SS Create "BARRA DE MENSAJES" -i- 
SS Create "CASCADA" -i- 
SS Create "HORIZONTAL" -i- 
SS Create "VERTICAL" -i- 
SS Create "ICONOS" -i- 
SS Create "AJUSTAR VENTANA" -i- 
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS Create "AYUDA" -i- 
SS cp "AYUDA"
SS Create "CONTENIDO" -i- 
SS Create "ACERCA DE ..." -i- 
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CREATE backend -i- 
SS CP backend
SS CREATE sybase -i- 
SS CP sybase
SS CREATE spsql -i- 
SS CP spsql
ss add e:\cobis3\person\spsql\full.cmd -i-
ss add e:\cobis3\person\spsql\full_nex.cmd -i-
ss add e:\cobis3\person\spsql\hpsucur.sp -C"SP_HP_SUCURSAL"
ss add e:\cobis3\person\spsql\laboral.sp -C"SP_LABORAL"
ss add e:\cobis3\person\spsql\pe_atrib.sp -C"SP_CREA_ATRIB"
ss add e:\cobis3\person\spsql\pe_conva.sp -C"SP_CONS_PERSONALIZACION"
ss add e:\cobis3\person\spsql\pe_corub.sp -C"SP_CORUBROS"
ss add e:\cobis3\person\spsql\pe_cosub.sp -C"SP_COSUB"
ss add e:\cobis3\person\spsql\pe_creat.sp -C"SP_CREA_TEMP"
ss add e:\cobis3\person\spsql\pe_genva.sp -C"SP_PERSONALIZA_COSTOS"
ss add e:\cobis3\person\spsql\pe_merca.sp -C"SP_MERCADO"
ss add e:\cobis3\person\spsql\pe_pro_b.sp -C"SP_PROD_BANCARIO"
ss add e:\cobis3\person\spsql\pe_profi.sp -C"SP_PRODFIN"
ss add e:\cobis3\person\spsql\pe_promo.sp -C"SP_PROMON"
ss add e:\cobis3\person\spsql\pe_rango.sp -C"SP_RANGO_TRAN"
ss add e:\cobis3\person\spsql\pe_rubro.sp -C"SP_RUBROS"
ss add e:\cobis3\person\spsql\pe_serv_.sp -C"SP_SERV_CONTRATADO"
ss add e:\cobis3\person\spsql\pebasico.sp -C"SP_BASICO_PE"
ss add e:\cobis3\person\spsql\pecocost.sp -C"SP_CON_COSTOT_LINEA"
ss add e:\cobis3\person\spsql\peconcos.sp -C"SP_CONSULTA_COSTOS"
ss add e:\cobis3\person\spsql\peconoli.sp -C"SP_CON_COSTOT_NO_LINEA"
ss add e:\cobis3\person\spsql\peconval.sp -C"SP_VALOR_CONTRATADO"
ss add e:\cobis3\person\spsql\pecorang.sp -C"SP_CORANGO_PE"
ss add e:\cobis3\person\spsql\pecoranm.sp -C"SP_CORANGO_MA"
ss add e:\cobis3\person\spsql\pecorubr.sp -C"SP_HELP_RUBROS"
ss add e:\cobis3\person\spsql\pecostos.sp -C"SP_TR_COSTOS"
ss add e:\cobis3\person\spsql\pecostot.sp -C"SP_COSTOS_TOTAL"
ss add e:\cobis3\person\spsql\pecosubs.sp -C"SP_HELP_COSUB"
ss add e:\cobis3\person\spsql\pegenera.sp -C"SP_GENERA_COSTOS"
ss add e:\cobis3\person\spsql\pehecos.sp -C"SP_HELP_COSTOS"
ss add e:\cobis3\person\spsql\pehecos2.sp -C"SP_HELP2_COSTOS"
ss add e:\cobis3\person\spsql\peheprmo.sp -C"SP_HELP_PROMO_PE"
ss add e:\cobis3\person\spsql\peherang.sp -C"SP_HELP_RANGO_PE"
ss add e:\cobis3\person\spsql\peheserv.sp -C"SP_HELP_SERV_PE"
ss add e:\cobis3\person\spsql\pehesubs.sp -C"SP_HELP_SUBS"
ss add e:\cobis3\person\spsql\peinacsu.sp -C"SP_DET_SERV_PE"
ss add e:\cobis3\person\spsql\peinser.sp -C"SP_INS_SERV_PE"
ss add e:\cobis3\person\spsql\pelimite.sp -C"SP_LIMITE"
ss add e:\cobis3\person\spsql\pelogcos.sp -C"SP_REG_CAMBIOS_COSTOS"
ss add e:\cobis3\person\spsql\pelogvar.sp -C"SP_REG_PERSONALIZACION"
ss add e:\cobis3\person\spsql\pepercta.sp -C"SP_PERSONALIZA_CUENTA"
ss add e:\cobis3\person\spsql\peprocos.sp -C"SP_PROCESO_COSTOS"
ss add e:\cobis3\person\spsql\perango.sp -C"SP_RANGO_PE"
ss add e:\cobis3\person\spsql\petirang.sp -C"SP_TIP_RNG_PE"
ss add e:\cobis3\person\spsql\pevalcon.sp -C"SP_CONTRATO_SERVICIOS"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CREATE frontend -i- 
SS CP frontend
ss add e:\cobis3\person\frontend\facerca.frm -i- 
ss add e:\cobis3\person\frontend\facerca.frx -i- 
ss add e:\cobis3\person\frontend\fbuscli.frm -i- 
ss add e:\cobis3\person\frontend\fbuscli.frx -i- 
ss add e:\cobis3\person\frontend\fbusgrp.frm -i- 
ss add e:\cobis3\person\frontend\fbusgrp.frx -i- 
ss add e:\cobis3\person\frontend\fbuslab.frm -i- 
ss add e:\cobis3\person\frontend\fbuslab.frx -i- 
ss add e:\cobis3\person\frontend\fcatalog.frm -i- 
ss add e:\cobis3\person\frontend\fcatalog.frx -i- 
ss add e:\cobis3\person\frontend\fcatserv.frm -i- 
ss add e:\cobis3\person\frontend\fcatserv.frx -i- 
ss add e:\cobis3\person\frontend\fconcos.frm -i- 
ss add e:\cobis3\person\frontend\fconcos.frx -i- 
ss add e:\cobis3\person\frontend\fconcta1.frm -i- 
ss add e:\cobis3\person\frontend\fconcta1.frx -i- 
ss add e:\cobis3\person\frontend\fconmas.frm -i- 
ss add e:\cobis3\person\frontend\fconmas.frx -i- 
ss add e:\cobis3\person\frontend\fconmas2.frm -i- 
ss add e:\cobis3\person\frontend\fconmas2.frx -i- 
ss add e:\cobis3\person\frontend\fconper.frm -i- 
ss add e:\cobis3\person\frontend\fconper.frx -i- 
ss add e:\cobis3\person\frontend\fconsval.frm -i- 
ss add e:\cobis3\person\frontend\fconsval.frx -i- 
ss add e:\cobis3\person\frontend\fcontra.frm -i- 
ss add e:\cobis3\person\frontend\fcontra.frx -i- 
ss add e:\cobis3\person\frontend\fcontrol.frm -i- 
ss add e:\cobis3\person\frontend\fcontrol.frx -i- 
ss add e:\cobis3\person\frontend\fcrbas.frm -i- 
ss add e:\cobis3\person\frontend\fcrbas.frx -i- 
ss add e:\cobis3\person\frontend\fcuenta1.frm -i- 
ss add e:\cobis3\person\frontend\fcuenta1.frx -i- 
ss add e:\cobis3\person\frontend\fgeneral.frm -i- 
ss add e:\cobis3\person\frontend\fgeneral.frx -i- 
ss add e:\cobis3\person\frontend\fhelpfi.frm -i- 
ss add e:\cobis3\person\frontend\fhelpfi.frx -i- 
ss add e:\cobis3\person\frontend\fhelpg.frm -i- 
ss add e:\cobis3\person\frontend\fhelpg.frx -i- 
ss add e:\cobis3\person\frontend\fhlpsub.frm -i- 
ss add e:\cobis3\person\frontend\fhlpsub.frx -i- 
ss add e:\cobis3\person\frontend\fhlpsub2.frm -i- 
ss add e:\cobis3\person\frontend\fhlpsub2.frx -i- 
ss add e:\cobis3\person\frontend\flogin.frm -i- 
ss add e:\cobis3\person\frontend\flogin.frx -i- 
ss add e:\cobis3\person\frontend\fmancos.frm -i- 
ss add e:\cobis3\person\frontend\fmancos.frx -i- 
ss add e:\cobis3\person\frontend\fmanlin1.frm -i- 
ss add e:\cobis3\person\frontend\fmanlin1.frx -i- 
ss add e:\cobis3\person\frontend\fmanlin2.frm -i- 
ss add e:\cobis3\person\frontend\fmanlin2.frx -i- 
ss add e:\cobis3\person\frontend\fpantall.frm -i- 
ss add e:\cobis3\person\frontend\fpantall.frx -i- 
ss add e:\cobis3\person\frontend\fpasswd.frm -i- 
ss add e:\cobis3\person\frontend\fpasswd.frx -i- 
ss add e:\cobis3\person\frontend\fprbaen.frm -i- 
ss add e:\cobis3\person\frontend\fprbaen.frx -i- 
ss add e:\cobis3\person\frontend\fprefere.frm -i- 
ss add e:\cobis3\person\frontend\fprefere.frx -i- 
ss add e:\cobis3\person\frontend\fpresent.frm -i- 
ss add e:\cobis3\person\frontend\fpresent.frx -i- 
ss add e:\cobis3\person\frontend\fprincip.frm -i- 
ss add e:\cobis3\person\frontend\fprincip.frx -i- 
ss add e:\cobis3\person\frontend\fproban.frm -i- 
ss add e:\cobis3\person\frontend\fproban.frx -i- 
ss add e:\cobis3\person\frontend\fprofin.frm -i- 
ss add e:\cobis3\person\frontend\fprofin.frx -i- 
ss add e:\cobis3\person\frontend\frango1.frm -i- 
ss add e:\cobis3\person\frontend\frango1.frx -i- 
ss add e:\cobis3\person\frontend\fregist.frm -i- 
ss add e:\cobis3\person\frontend\fregist.frx -i- 
ss add e:\cobis3\person\frontend\frubros2.frm -i- 
ss add e:\cobis3\person\frontend\frubros2.frx -i- 
ss add e:\cobis3\person\frontend\fserbac.frm -i- 
ss add e:\cobis3\person\frontend\fserbac.frx -i- 
ss add e:\cobis3\person\frontend\fsrvcon1.frm -i- 
ss add e:\cobis3\person\frontend\fsrvcon1.frx -i- 
ss add e:\cobis3\person\frontend\ftipran1.frm -i- 
ss add e:\cobis3\person\frontend\ftipran1.frx -i- 
ss add e:\cobis3\person\frontend\fvarser.frm -i- 
ss add e:\cobis3\person\frontend\fvarser.frx -i- 
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "CONEXION"
SS CP  "LOG ON"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/flogin.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/flogin.frx"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "CONEXION"
SS CP  "LOG OFF"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprincip.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprincip.frx"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "CONEXION"
SS CP  "CAMBIAR PASSWORD"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fpasswd.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fpasswd.frx"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "CONEXION"
SS CP  "PREFERENCIAS"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprefere.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprefere.frx"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "CONEXION"
SS CP  "BLOQUEAR TERMINAL"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprincip.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprincip.frx"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "CONEXION"
SS CP  "SALIR"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprincip.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprincip.frx"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "PRODUCTOS"
SS CP  "PRODUCTOS BANCARIOS"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fproban.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fproban.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_pro_b.sp"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "PRODUCTOS"
SS CP  "MERCADO"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprbaen.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprbaen.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_conva.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_merca.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_pro_b.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_profi.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peconval.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pegenera.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorang.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorubr.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecosubs.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pehecos.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peheserv.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_merca.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_pro_b.sp"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "PRODUCTOS"
SS CP  "PRODUCTOS FINALES"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprofin.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprofin.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_conva.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_merca.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_pro_b.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_profi.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peconval.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pegenera.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorang.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorubr.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecosubs.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pehecos.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peheserv.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/hpsucur.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_profi.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "RANGOS"
SS CP  "TIPO RANGO"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/ftipran1.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/ftipran1.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_conva.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_merca.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_pro_b.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_profi.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peconval.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pegenera.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorang.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorubr.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecosubs.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pehecos.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peheserv.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/petirang.sp"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "RANGOS"
SS CP  "RANGO"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/frango1.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/frango1.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_conva.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_merca.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_pro_b.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_profi.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peconval.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pegenera.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorang.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorubr.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecosubs.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pehecos.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peheserv.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peherang.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/perango.sp"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "SERVICIOS"
SS CP  "SERVICIOS DISPONIBLES"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fserbac.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fserbac.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peinser.sp"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "SERVICIOS"
SS CP  "SERVICIOS BASICOS"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fcrbas.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fcrbas.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_conva.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_merca.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_pro_b.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_profi.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peconval.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pegenera.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorang.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorubr.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecosubs.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pehecos.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peheserv.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_profi.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pebasico.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peheserv.sp"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "SERVICIOS"
SS CP  "SERVICIOS CONTRATADOS"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fsrvcon1.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fsrvcon1.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_conva.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_merca.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_pro_b.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_profi.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peconval.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pegenera.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorang.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorubr.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecosubs.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pehecos.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peheserv.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_serv_.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peheserv.sp"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "SERVICIOS"
SS CP  "RUBROS DE SERVICIOS"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fvarser.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fvarser.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_conva.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_merca.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_pro_b.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_profi.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peconval.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pegenera.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorang.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorubr.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecosubs.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pehecos.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peheserv.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_cosub.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peheserv.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peinacsu.sp"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "SERVICIOS"
SS CP  "SERVICIOS PERSONALIZABLES"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/frubros2.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/frubros2.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fhlpsub.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fhlpsub.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecosubs.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_conva.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_merca.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_pro_b.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_profi.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peconval.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pegenera.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorang.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorubr.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecosubs.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pehecos.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peheserv.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/hpsucur.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_corub.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_merca.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_profi.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_rubro.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peherang.sp"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "VALORES"
SS CP  "VALOR DE SERVICIO"
SS CP  "MANTENIMIENTO"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fmancos.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fmancos.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_conva.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_merca.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_pro_b.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_profi.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peconval.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pegenera.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorang.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorubr.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecosubs.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pehecos.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peheserv.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/hpsucur.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorang.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorubr.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pehecos2.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peherang.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pelogcos.sp"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "VALORES"
SS CP  "VALOR DE SERVICIO"
SS CP  "MANTENIMIENTO EN LINEA"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fmanlin1.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fmanlin1.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_conva.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_merca.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_pro_b.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_profi.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peconval.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pegenera.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorang.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorubr.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecosubs.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pehecos.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peheserv.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/hpsucur.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorang.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorubr.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecostos.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pehecos2.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peherang.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pelogcos.sp"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "VALORES"
SS CP  "VALOR DE SERVICIO"
SS CP  "MANTENIMIENTO MASIVO"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fmanlin2.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fmanlin2.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fhlpsub2.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fhlpsub2.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecosubs.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_conva.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_merca.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_pro_b.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_profi.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peconval.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pegenera.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorang.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorubr.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecosubs.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pehecos.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peheserv.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_pro_b.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecoranm.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecostot.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peherang.sp"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "VALORES"
SS CP  "VALOR DE SERVICIO"
SS CP  "CONSULTA DE VALORES VIGENTES"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fconcos.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fconcos.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_conva.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_merca.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_pro_b.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_profi.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peconval.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pegenera.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorang.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorubr.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecosubs.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pehecos.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peheserv.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/hpsucur.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peconcos.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pehecos.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peherang.sp"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "VALORES"
SS CP  "VALOR DE SERVICIO"
SS CP  "CONSULTA DE PROXIMOS VALORES VIGENTES"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fconsval.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fconsval.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_conva.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_merca.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_pro_b.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_profi.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peconval.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pegenera.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorang.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorubr.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecosubs.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pehecos.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peheserv.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/hpsucur.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pehecos2.sp"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "VALORES"
SS CP  "VALOR DE SERVICIO"
SS CP  "CONSULTA DE VALORES EN LINEA"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fconmas.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fconmas.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fhlpsub2.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fhlpsub2.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecosubs.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_conva.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_merca.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_pro_b.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_profi.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peconval.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pegenera.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorang.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorubr.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecosubs.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pehecos.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peheserv.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/hpsucur.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_pro_b.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecocost.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peherang.sp"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "VALORES"
SS CP  "VALOR DE SERVICIO"
SS CP  "CONSULTA DE PROXIMOS VALORES EN LINEA"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fconmas2.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fconmas2.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fhlpsub2.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fhlpsub2.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecosubs.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_conva.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_merca.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_pro_b.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_profi.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peconval.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pegenera.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorang.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorubr.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecosubs.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pehecos.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peheserv.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/hpsucur.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_pro_b.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peconoli.sp"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "VALORES"
SS CP  "PERSONALIZACION DE VALORES"
SS CP  "CONTRATACION DE SERVICIOS"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fcontra.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fcontra.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fbuscli.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fbuscli.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fbusgrp.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fbusgrp.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_conva.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_merca.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_pro_b.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_profi.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peconval.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pegenera.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorang.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorubr.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecosubs.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pehecos.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peheserv.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/hpsucur.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_profi.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pevalcon.sp"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "VALORES"
SS CP  "PERSONALIZACION DE VALORES"
SS CP  "PERSONALIZACION DE CUENTA"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fcuenta1.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fcuenta1.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fbuscli.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fbuscli.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fbusgrp.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fbusgrp.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fbuslab.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fbuslab.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/laboral.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fconcta1.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fconcta1.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pevalcon.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/laboral.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pepercta.sp"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "VALORES"
SS CP  "PERSONALIZACION DE VALORES"
SS CP  "CONSULTA DE PERSONALIZACION"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fconper.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fconper.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fregist.frx"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_conva.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_merca.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_pro_b.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_profi.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pe_promo.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peconval.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pegenera.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorang.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecorubr.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pecosubs.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pehecos.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peheserv.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peconval.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/pegenera.sp"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/backend/sybase/spsql/peheserv.sp"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "VENTANAS"
SS CP  "BARRA DE AYUDA"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprincip.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprincip.frx"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "VENTANAS"
SS CP  "BARRA DE MENSAJES"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprincip.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprincip.frx"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "VENTANAS"
SS CP  "CASCADA"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprincip.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprincip.frx"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "VENTANAS"
SS CP  "HORIZONTAL"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprincip.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprincip.frx"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "VENTANAS"
SS CP  "VERTICAL"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprincip.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprincip.frx"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "VENTANAS"
SS CP  "ICONOS"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprincip.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprincip.frx"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "VENTANAS"
SS CP  "AJUSTAR VENTANA"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprincip.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprincip.frx"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "AYUDA"
SS CP  "CONTENIDO"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprincip.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/fprincip.frx"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "AYUDA"
SS CP  "ACERCA DE ..."
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/facerca.frm"
ss share "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion/frontend/facerca.frx"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CREATE backend -i- 
SS CP backend
SS CREATE sybase -i- 
SS CP sybase
SS CREATE sqr -i- 
SS CP sqr
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CREATE backend -i- 
SS CP backend
SS CREATE sybase -i- 
SS CP sybase
SS CREATE sql -i- 
SS CP sql
ss add e:\cobis3\person\sql\full.cmd -i-
ss add e:\cobis3\person\sql\fullseg.cmd -i-
ss add e:\cobis3\person\sql\pe_catlg.sql -i- 
ss add e:\cobis3\person\sql\pe_dat.sql -i- 
ss add e:\cobis3\person\sql\pe_dropf.sql -i- 
ss add e:\cobis3\person\sql\pe_dropp.sql -i- 
ss add e:\cobis3\person\sql\pe_dropt.sql -i- 
ss add e:\cobis3\person\sql\pe_dropv.sql -i- 
ss add e:\cobis3\person\sql\pe_dtype.sql -i- 
ss add e:\cobis3\person\sql\pe_error.sql -i- 
ss add e:\cobis3\person\sql\pe_fkey.sql -i- 
ss add e:\cobis3\person\sql\pe_pkey.sql -i- 
ss add e:\cobis3\person\sql\pe_proc.sql -i- 
ss add e:\cobis3\person\sql\pe_proin.sql -i- 
ss add e:\cobis3\person\sql\pe_protr.sql -i- 
ss add e:\cobis3\person\sql\pe_segur.sql -i- 
ss add e:\cobis3\person\sql\pe_table.sql -i- 
ss add e:\cobis3\person\sql\pe_tran.sql -i- 
ss add e:\cobis3\person\sql\pe_traut.sql -i- 
ss add e:\cobis3\person\sql\pe_trser.sql -i- 
ss add e:\cobis3\person\sql\pe_trun.sql -i- 
ss add e:\cobis3\person\sql\pe_upsta.sql -i- 
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
ss add e:\cobis3\person\map.bas -i- 
ss add e:\cobis3\person\mformato.bas -i- 
ss add e:\cobis3\person\mhelpg.bas -i- 
ss add e:\cobis3\person\modglb.bas -i- 
ss add e:\cobis3\person\modimg.bas -i- 
ss add e:\cobis3\person\modini.bas -i- 
ss add e:\cobis3\person\modseg.bas -i- 
ss add e:\cobis3\person\perso.exe -i- 
ss add e:\cobis3\person\perso.mak -i- 
ss add e:\cobis3\person\person.ini -i- 
ss add e:\cobis3\person\person.bat -i- 
ss add e:\cobis3\person\shuffle.bas -i- 
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CREATE vbxdll -i-
SS CP vbxdll
ss share "$/Cobis Software Basico/vbxdll-all/GRID.VBX"
ss share "$/Cobis Software Basico/vbxdll-all/MSMASKED.VBX"
ss share "$/Cobis Software Basico/vbxdll-all/THREED.VBX"
ss share "$/Cobis Software Basico/vbxdll-all/W3DBLIB.DLL"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
SS CP  "$/COBIS Rel 3/COBIS Ctas Ctes y Ahorros/Personalizacion"
ss add e:\cobis3\person\perso.mak -i- 
ss add e:\cobis3\person\perso.exe -i- 
ss label perso.exe -l3.0.0 -i- 
SS label -l3.0.0 -i- 
