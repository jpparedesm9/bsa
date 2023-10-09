/************************************************************************/
/*  Archivo:                sp_carga_cobis_mc.sp                       */
/*  Stored procedure:       sp_carga_cobis_mc                          */
/*  Base de Datos:          cob_conta_super                             */
/*  Producto:               cob_conta_super                             */
/*  Disenado por:           PXSG                                        */
/*  Fecha de Documentacion: 06/01/2019                                  */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/* Devuelve la fecha para Eliminar las carpetas del FTP de Interfactura */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/*06/01/2019    PXSG                  Emision Inicial                   */
/* **********************************************************************/
use cob_conta_super
go


if exists(select 1 from sysobjects where name ='sp_carga_cobis_mc')
	drop proc sp_carga_cobis_mc
go

create proc sp_carga_cobis_mc (
@i_nombre_archivo     varchar(200) = null,
@t_show_version	bit             = 0
	
)

AS

Declare
	@w_cobismc_file_path VARCHAR(30),
	@w_cobismc_file_file VARCHAR(200),
	@w_command NVARCHAR(MAX),
	@w_total_rows INT,
	@w_fecha_proceso datetime,
	@w_error_code int,
	@w_sp_name          varchar(32)

if @t_show_version = 1
begin
    print 'Stored procedure sp_carga_cobis_mc, Version 1.0.0'
    return 0
end
--------------------------------------------------------------------------------------

/*  Inicializacion de Variables  */
select  @w_sp_name = 'sp_carga_cobis_mc'
SELECT @w_error_code = 0

select @w_cobismc_file_path=pa_char from cobis..cl_parametro
where pa_producto='REC'
and pa_nemonico='PHCMCC'

SELECT @w_fecha_proceso = fp_fecha FROM cobis..ba_fecha_proceso

IF @w_cobismc_file_path IS NULL
BEGIN
    RAISERROR ('No se ha definido el parámetro PHCMCC (Ruta del archivo de Cobis Mc Collect)', 13, 1);
	return -1;
END

SELECT @w_cobismc_file_file = @i_nombre_archivo

IF @w_cobismc_file_file IS NULL
BEGIN
	RAISERROR ('No se ha definido Nombre del archivo de Cobis Mc Collect)', 13, 1);
	return -1;
END

   -- TRUNCATE TABLE cob_conta_super..sb_rep_ini_cobis_collect  
   --DBCC CHECKIDENT ('sb_rep_ini_cobis_collect', RESEED, 1)
    
   SELECT @w_command =
    'INSERT INTO 	 cob_conta_super..sb_rep_ini_cobis_collect		(
	oficina,                           region,                            cc,                                contrato,                          id_grupo,                          
	nombre_grupo,                      ciclo_grupal,                      numero_integrantes,                rfc,                               curp,                              
	cliente_cobis,                     apellido_paterno,                  apellido_materno,                  nombre1,                           nombre2,                           
	ciclo_individual,                  genero,                            edad,                              dom_telefono,                      dom_direccion,                     
	estado,                            municipio,                         localidad,                         c_p,                               coordenadas_domicilio,             
	neg_telefono,                      neg_direccion,                     neg_estado,                        neg_municipio,                     neg_localidad,                     
	neg_cp,                            neg_tipo_local,                    actividad_economica,               correo_electronico_cliente,        nombre_gerente,                    
	nombre_coordinador,                nombre_asesor,                     correo_electronico_asesor,         telefono_asesor,                   estatus_asesor,                   
	producto_prestamos,                subproducto_prestamo,              monto_credito,                     fecha_solicitud,                   fecha_aprobacion_montos,           
	fecha_vencimiento_prestamo,        numero_contrato,                   plazo,                             numero_cuotas,                     dia_pago,                          
	plazo_dias,                        plazo_mes,                         valor_cuota,                       capital_cuota,                     intereses_cuota,                   
	iva_cuota,                         tasa_interes_anual,                cuotas_pendientes,                 cuotas_vencidas,                   capital_vigente_exigible,          
	capital_vencido_exigible,          saldo_cap,                         interes_vigente_exigible,          interes_suspendido,                iva_interes_exigible,              
	iva_interes_no_exigible,           comisiones,                        iva_comision,                      saldo_intereses,                   saldo_real_exigible,               
	saldo_total,                       saldo_total_mora,                  importe_liquida_con,               dias_max_atraso_act,               semanas_atraso,                    
	dias_mora,                         fecha_recibo_antiguo_imp,          fecha_ultima_situacion_deuda,      porcentaje_reserva,                cartera_riesgo,                    
	nivel_riesgo,                      puntaje_riesgo,                    rol_mesa_directiva,                indicador_reunion,                 numero_empleado_asesor,            
	numero_empleado_coordinador,       numero_empleado_gerente,           dia_reunion_semanal,               hora_reunion_semanal,              coordenadas_negocio,               
	nro_operacion_grupal,              nvo_dom_direccion,                 nvo_estado,                        nvo_municipio,                     nvo_localidad,                     
   nvo_c_p,                           nvas_coordenadas_dom,              foto_domicilio,                    entre_calle_1_dom,                 entre_calle_2_dom,                 
   entre_calle_3_dom,                 entre_calle_4_dom,                 foto_negocio,                      foto_negocio_2,                    entre_calle_1_neg,                 
   entre_calle_2_neg,                 entre_calle_3_neg,                 entre_calle_4_neg,                 foto_domicilio_alterno,            entre_calle_1_dom_alterno,         
   entre_calle_2_dom_alterno,         entre_calle_3_dom_alterno,         entre_calle_4_dom_alterno,			asesor_login,							  asesor_cargo                                                                           --113                     
	)
SELECT 
	oficina,                           region,                            cc,                                contrato,                          id_grupo,                          
	nombre_grupo,                      ciclo_grupal,                      numero_integrantes,                rfc,                               curp,                              
	cliente_cobis,                     apellido_paterno,                  apellido_materno,                  nombre1,                           nombre2,                           
	ciclo_individual,                  genero,                            edad,                              dom_telefono,                      dom_direccion,                     
	estado,                            municipio,                         localidad,                         c_p,                               coordenadas_domicilio,             
	neg_telefono,                      neg_direccion,                     neg_estado,                        neg_municipio,                     neg_localidad,                     
	neg_cp,                            neg_tipo_local,                    actividad_economica,               correo_electronico_cliente,        nombre_gerente,                    
	nombre_coordinador,                nombre_asesor,                     correo_electronico_asesor,         telefono_asesor,                   estatus_asesor,                   
	producto_prestamos,                subproducto_prestamo,              monto_credito,                     fecha_solicitud,                   fecha_aprobacion_montos,           
	fecha_vencimiento_prestamo,        numero_contrato,                   plazo,                             numero_cuotas,                     dia_pago,                          
	plazo_dias,                        plazo_mes,                         valor_cuota,                       capital_cuota,                     intereses_cuota,                   
	iva_cuota,                         tasa_interes_anual,                cuotas_pendientes,                 cuotas_vencidas,                   capital_vigente_exigible,          
	capital_vencido_exigible,          saldo_cap,                         interes_vigente_exigible,          interes_suspendido,                iva_interes_exigible,              
	iva_interes_no_exigible,           comisiones,                        iva_comision,                      saldo_intereses,                   saldo_real_exigible,               
	saldo_total,                       saldo_total_mora,                  importe_liquida_con,               dias_max_atraso_act,               semanas_atraso,                    
	dias_mora,                         fecha_recibo_antiguo_imp,          fecha_ultima_situacion_deuda,      porcentaje_reserva,                cartera_riesgo,                    
	nivel_riesgo,                      puntaje_riesgo,                    rol_mesa_directiva,                indicador_reunion,                 numero_empleado_asesor,            
	numero_empleado_coordinador,       numero_empleado_gerente,           dia_reunion_semanal,               hora_reunion_semanal,              coordenadas_negocio,               
	nro_operacion_grupal,              nvo_dom_direccion,                 nvo_estado,                        nvo_municipio,                     nvo_localidad,                     
   nvo_c_p,                           nvas_coordenadas_dom,              foto_domicilio,                    entre_calle_1_dom,                 entre_calle_2_dom,                 
   entre_calle_3_dom,                 entre_calle_4_dom,                 foto_negocio,                      foto_negocio_2,                    entre_calle_1_neg,                 
   entre_calle_2_neg,                 entre_calle_3_neg,                 entre_calle_4_neg,                 foto_domicilio_alterno,            entre_calle_1_dom_alterno,         
   entre_calle_2_dom_alterno,         entre_calle_3_dom_alterno,         entre_calle_4_dom_alterno,			asesor_login,							  asesor_cargo               
    	  FROM  OPENROWSET (BULK ''' + @w_cobismc_file_path + @w_cobismc_file_file + ''',
    	  FORMATFILE = ''' + @w_cobismc_file_path + 'cobranzaini_mc_collect_format.xml''
    	   ) AS ln;'
    
    EXEC sp_executesql @w_command;

Update cob_conta_super..sb_rep_ini_cobis_collect
set 
fecha_carga_real       = getdate(),
fecha_carga_proceso    = @w_fecha_proceso,
nombre_archivo         = @w_cobismc_file_file,
estado_nombre_archivo  = 'S'
where estado_nombre_archivo='N'

return @w_error_code
go
