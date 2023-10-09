---------------------------------------------------*******************---------------------------------------------------
---------------------------------------------------*******************---------------------------------------------------
--------------***JUNIO---JULIO--AGOSTO
--Consultar des pues del script: 10001_REM_152243_152490_insertar_actualizar_1_junio_2019.sql
select '#registrosIni' = count(*) from sb_operacion_tmp   -- #registrosIni: 29166

--Consultar despues de ejeccutar el script: 10002_REM_152243_152490_generar_estados_cuenta.sql
--Generar archivos Junio:Jan 14 2021  9:21PM - Jan 14 2021 10:19PM  -- 1 hora
--Generar archivos Julio:Jan 14 2021 10:43PM - Jan 15 2021 12:21AM  -- 2 horas
--Generar archivos Agosto:Jan 15 2021 12:33AM - Jan 15 2021 12:54AM -- 1/2 hora
select '#reg_para_generar_arch' = count(*) from cob_credito..cr_resultado_xml WHERE status = 'P' --- Debe ser el #registrosIni

--Consultar despues de ejecutar el script 10004_REM_152243_152490_Interfactura_Reproceso_GXMLCI.sql
--y activar el job: <jobName>GXMLCI</jobName> cada hora al minuto 17
--Debe llegar al #registrosIni
select '#reg_de_archivos_generados' = count(1) FROM cob_credito..cr_resultado_xml WHERE status = 'F' -- Debe ser el #registrosIni

--Obtener respuesta de Interfactura: Ideal 0%, peor de los casos 10%
declare @w_faltan int,  @w_total int
select @w_total = count(*) from cob_credito..cr_resultado_xml
select @w_faltan = count(*) from cob_credito..cr_resultado_xml
where num_operation not in (select nec_banco from cob_conta_super..sb_ns_estado_cuenta)

select 'porc_q_falta' = (@w_faltan * 100 / @w_total) --Ideal 0%, peor de los casos 10%
go


