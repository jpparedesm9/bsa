/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : Requerimiento 117291: Mejoras al kit de crédito
--Fecha                      : 04/05/2018
--Descripción del Problema   : Se debe modificar catalogos
--Descripción de la Solución : Crear scripts de instalación
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- INSERTAR PARAMETROS
--------------------------------------------------------------------------------------------

delete cobis..cl_parametro where pa_nemonico in ('WPPCOM', 'WPPBRN', 'WPPUSR', 'WPPPWD', 'WPPDAT',
                                                 'WPPCAN', 'WPPEVN', 'WPPSOC', 'WPPENA', 'WPPSIM', 
                                                 'WPPPRO', 'WPPDOM', 'WPPPRT', 'WPPUBO', 'WPPKE1', 
                                                 'WPPKE2')

insert into cobis..cl_parametro values ('WEB PAY PLUS COMPANY', 'WPPCOM', 'C', '849A', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('WEB PAY PLUS BRANCH', 'WPPBRN', 'C', '0003', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('WEB PAY PLUS USER', 'WPPUSR', 'C', '849ASIUS1', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('WEB PAY PLUS PASSWORD', 'WPPPWD', 'C', '0D7IHKFH9Z', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('WEB PAY PLUS DATA0', 'WPPDAT', 'C', '9265655290', null, null, null, null, null, null, 'CLI')

insert into cobis..cl_parametro values ('WEB PAY PLUS CANAL', 'WPPCAN', 'C', 'W', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('WEB PAY PLUS ENVIAR NOTIFICACION', 'WPPEVN', 'T', null, 0, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('WEB PAY PLUS SOLICITAR CORREO', 'WPPSOC', 'T', null, 1, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('WEB PAY PLUS ENROLAMIENTO AUTOMATICO', 'WPPENA', 'C', 'M', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('WEB PAY PLUS SIMULACION NO PRESENTE', 'WPPSIM', 'T', null, 0, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('WEB PAY PLUS PROTOCOLO', 'WPPPRO', 'C', 'https://', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('WEB PAY PLUS DOMINIO', 'WPPDOM', 'C', 'bc.mitec.com.mx:', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('WEB PAY PLUS PUERTO', 'WPPPRT', 'I', null, null, null, 6545, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('WEB PAY PLUS URL BODY', 'WPPUBO', 'C', '/p/gen', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('WEB PAY PLUS KEY', 'WPPKE1', 'C', '77DA0C7448A84C0B48290D68C0FB1', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('WEB PAY PLUS KEY', 'WPPKE2', 'C', '6B3', null, null, null, null, null, null, 'CLI')

go
