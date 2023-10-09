/************************************************************************/
/*  Archivo:                sp_reporte_kyc.sp                           */
/*  Stored procedure:       sp_reporte_kyc                              */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           P. Ortiz                                    */
/*  Fecha de Documentacion: 01/Nov/2017                                 */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*                         PROPOSITO                                    */
/* Permite generar la informacion requerida para el reporte KYC         */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/*  FECHA          AUTOR          RAZON                                 */
/*  01/Nov/2017    P. Ortiz    Emision Inicial                          */
/*  06/JUN/2019      ACHP      Envio decimales #118579                  */
/*  07/JUN/2022      ACHP      REQ#185412, telefono para prod <> Grupal */
/*  02/Ago/2022      ACHP      E#191735 Impresión de documento LCR no...*/
/*  23/NOV/2022      KVI       Req.197007 - Flujo B2B Gr.Paperless F1   */
/* **********************************************************************/

use cobis
go

if exists(select 1 from sysobjects where name ='sp_reporte_kyc')
	drop proc sp_reporte_kyc
go

create proc sp_reporte_kyc (
   @s_ssn             int         = null,
   @s_user            login       = null,
   @s_term            varchar(32) = null,
   @s_date            datetime    = null,
   @s_sesn            int         = null,
   @s_culture         varchar(10) = null,
   @s_srv             varchar(30) = null,
   @s_lsrv            varchar(30) = null,
   @s_ofi             smallint    = null,
   @s_rol             smallint    = null,
   @s_org_err         char(1)     = null,
   @s_error           int         = null,
   @s_sev             tinyint     = null,
   @s_msg             descripcion = null,
   @s_org             char(1)     = null,
   @t_debug           char(1)     = 'N',
   @t_file            varchar(10) = null,
   @t_from            varchar(32) = null,
   @t_trn             int         = null,
   @t_show_version    bit         = 0,
   @i_tramite         int         = null,
   @i_operacion       char(1) = null,
   @i_notificador     char(1)     = 'N', -- Req.197007
   @i_cliente         int         = null -- Req.197007
)as
declare 
   @w_num_error       int,
   @w_sp_name         varchar(32),
   @w_grupal          varchar(10),
   @w_login           login
   
select @w_sp_name = 'sp_reporte_kyc'

   -- Validar codigo de transacciones --
if ((@t_trn <> 1718 and @i_operacion = 'S'))
begin
   select @w_num_error = 151051 --Transaccion no permitida
   goto errores
end


if @i_operacion = 'S'
begin
	
    
	PRINT 'Tramite ' + convert(varchar(20), @i_tramite)
	select @w_grupal = io_campo_4 from cob_workflow..wf_inst_proceso where io_campo_3 = @i_tramite
	
	PRINT 'Tramite ' + convert(varchar(20), @w_grupal)
	
    if (@w_grupal = 'GRUPAL')
    begin
		if @i_notificador = 'N'  -- Req.197007
		begin
    	    select 
	        'fechaProceso'          = (select convert(varchar(10), fp_fecha, 103)from cobis..ba_fecha_proceso), 
	        'nombre'            	= isnull(en_nombre,'')+ ' ' +isnull(p_s_nombre,'')+ ' ' +isnull(p_p_apellido,'') +' ' +isnull(p_s_apellido,''),
	        'genero'            	= (select valor from cl_catalogo where codigo = p_sexo
	                                         and tabla = (select codigo from cl_tabla where tabla = 'cl_sexo')),
	        'rfcHomoclave'          = en_nit,
	        'ciudadNac'				= (select valor from cl_catalogo where codigo = convert(varchar(10), p_depa_nac)
	                                         and tabla = (select codigo from cl_tabla where tabla = 'cl_provincia')),
	        'fechaNac'    			= convert(varchar(10), p_fecha_nac, 103),
	        'paisNac'    			= (select pa_descripcion from cl_pais where pa_pais = p_pais_emi),
	        'nacionalidad'      	= (select valor from cl_catalogo where codigo = en_nac_aux
	                                         and tabla = (select codigo from cl_tabla where tabla = 'cl_nacionalidad')),	                                	
	        'calleNumero'   		=  (select TOP 1 convert(varchar(40),isnull(di_calle, '')) + ' ' + convert(varchar(10),isnull(di_nro, '')) 
	                                        + (CASE di_nro_interno when -1 then null ELSE (' (' + convert(varchar(10), di_nro_interno) + ')') END)  
	                                           from cl_direccion where di_ente = en_ente and di_tipo = 'RE'),	        							
	        'colonia'               = (select pq_descripcion from cl_parroquia where pq_parroquia = (select TOP 1 convert(varchar(10), di_parroquia) 
	                                                                        from cl_direccion where di_ente = en_ente and di_tipo = 'RE')),
	        'municipio'             = (select ci_descripcion from cl_ciudad where ci_ciudad = (select TOP 1 convert(varchar(10), di_ciudad) 
	                                                                        from cl_direccion where di_ente = en_ente and di_tipo = 'RE')),
			'estado'               	= (select pv_descripcion from cl_provincia where pv_provincia = (select TOP 1 convert(varchar(10), di_provincia) 
	        																from cl_direccion where di_ente = en_ente and di_tipo = 'RE')),
	        'codPostal'             = (select TOP 1 di_codpostal from cl_direccion where di_ente = en_ente and di_tipo = 'RE'),
	        'pais'               	= (select pa_descripcion from cl_pais where pa_pais = (select TOP 1 di_pais from cl_direccion where di_ente = en_ente and di_tipo = 'RE')),
	        'ocupacion'             = (select valor from cl_catalogo where codigo = p_profesion
	                                         and tabla = (select codigo from cl_tabla where tabla = 'cl_profesion')), 
	        'actEcoGenerica'        = (select acg_actividad_generica from cl_actividad_generica 
	        							where acg_codigo_actividad = (select TOP 1 nc_actividad_ec from cobis..cl_negocio_cliente where nc_ente = en_ente and 
										                              ltrim(rtrim(nc_estado_reg)) = 'V' order by nc_fecha_apertura)), 
	        'actEcoEspecifica'      = (select acg_actividad_especifica from cl_actividad_generica 
	        							where acg_codigo_actividad = (select TOP 1 nc_actividad_ec from cobis..cl_negocio_cliente where nc_ente = en_ente and 
										                              ltrim(rtrim(nc_estado_reg)) = 'V' order by nc_fecha_apertura)), 
	        'curp'                  = en_ced_ruc,
	        'telefono'              = (select TOP 1 isnull(te_valor, '') from cobis..cl_telefono where te_ente = en_ente and te_tipo_telefono = 'D'
										and te_direccion = (select TOP 1 di_direccion from cl_direccion where di_ente = en_ente and di_tipo = 'RE') )
	        								 + (select TOP 1 isnull('; ' + te_valor, '') from cobis..cl_telefono where te_ente = en_ente and te_tipo_telefono = 'C'
                                                     and te_direccion = (select TOP 1 di_direccion from cl_direccion where di_ente = en_ente and di_tipo = 'RE') ), 
	        'email'					= (select TOP 1 di_descripcion from cobis..cl_direccion 
	                                         where di_ente = en_ente and di_tipo = 'CE'),
	        'firmaElecAvanzada'     = 'FIRMA ELECTRONICA AVANZADA', 
	        'origenRecursos'        = (select valor from cl_catalogo where codigo = (select TOP 1 nc_recurso from cobis..cl_negocio_cliente where nc_ente = en_ente and 
										                                             ltrim(rtrim(nc_estado_reg)) = 'V' order by nc_fecha_apertura)
	                                         and tabla = (select codigo from cl_tabla where tabla = 'cl_recursos_credito')),
	        'destinoRecursos'       = (select valor from cl_catalogo where codigo = (select TOP 1 nc_destino_credito from cobis..cl_negocio_cliente where nc_ente = en_ente and 
										                                             ltrim(rtrim(nc_estado_reg)) = 'V' order by nc_fecha_apertura)
	                                         and tabla = (select codigo from cl_tabla where tabla = 'cl_destino_credito')),
	        'respA'              	= 'NO',
	        'respB'              	= 'NO',
	        'respC'              	= 'NO',
	        'numEstOperEnv'         = isnull((select mnr_num_op_env from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<50'), 
	        'montoEstOperEnv'       = isnull((select convert(varchar,format(convert(money,mnr_mont_op_env),'N')) from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<150,000'),  
	        'numEstOperRec'         = isnull((select mnr_num_op_rec from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<50'),  
	        'montoEstOperRec'       = isnull((select convert(varchar,format(convert(money,mnr_mont_op_rec),'N'))  from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<150,000'),  
	        'numEstOperEfe'         = isnull((select mnr_num_dep_efec from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<50'),  
	        'montoEstOperEfe'       = isnull((select convert(varchar,format(convert(money,mnr_mont_dep_efec),'N')) from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<150,000'),  
	        'numEstOperNoEfe'       = isnull((select mnr_num_dep_noefec from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<50'),  
	        'montoEstOperNoEfe'     = isnull((select convert(varchar,format(convert(money,mnr_mont_dep_noefec),'N')) from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<150,000'), 
	        'nombreEjecutivo'       = (select fu_nombre from cobis..cl_funcionario, cobis..cc_oficial, cob_credito..cr_tramite 
	                                        where fu_funcionario = oc_oficial and oc_oficial = tr_oficial and tr_tramite = tg_tramite),
	        'codigo'            	= en_ente,
			'numContraparte'        = (select top 1 mnr_contrapartes FROM cob_credito..cr_monto_num_riesgo 
			                           where mnr_ente = en_ente),
	        'canalContratacion'     = (select top 1 mnr_canal_contratacion FROM cob_credito..cr_monto_num_riesgo 
			                           where mnr_ente = en_ente),
			'fechaNacConst'         = (select top 1 mnr_fecha_nac FROM cob_credito..cr_monto_num_riesgo 
			                           where mnr_ente = en_ente)
			from cob_credito..cr_tramite_grupal, cobis..cl_ente, cobis..cl_ente_aux   
			where tg_tramite = @i_tramite
			and tg_participa_ciclo = 'S'
			and tg_monto > 0
			and tg_cliente = en_ente
			and en_ente = ea_ente
			order by tg_cliente asc    	
		end 
		else  
		begin
		    select 
	            'fechaProceso'          = (select convert(varchar(10), fp_fecha, 103)from cobis..ba_fecha_proceso), 
	            'nombre'            	= isnull(en_nombre,'')+ ' ' +isnull(p_s_nombre,'')+ ' ' +isnull(p_p_apellido,'') +' ' +isnull(p_s_apellido,''),
	            'genero'            	= (select valor from cl_catalogo where codigo = p_sexo
	                                             and tabla = (select codigo from cl_tabla where tabla = 'cl_sexo')),
	            'rfcHomoclave'          = en_nit,
	            'ciudadNac'				= (select valor from cl_catalogo where codigo = convert(varchar(10), p_depa_nac)
	                                             and tabla = (select codigo from cl_tabla where tabla = 'cl_provincia')),
	            'fechaNac'    			= convert(varchar(10), p_fecha_nac, 103),
	            'paisNac'    			= (select pa_descripcion from cl_pais where pa_pais = p_pais_emi),
	            'nacionalidad'      	= (select valor from cl_catalogo where codigo = en_nac_aux
	                                             and tabla = (select codigo from cl_tabla where tabla = 'cl_nacionalidad')),	                                	
	            'calleNumero'   		=  (select TOP 1 convert(varchar(40),isnull(di_calle, '')) + ' ' + convert(varchar(10),isnull(di_nro, '')) 
	                                            + (CASE di_nro_interno when -1 then null ELSE (' (' + convert(varchar(10), di_nro_interno) + ')') END)  
	                                               from cl_direccion where di_ente = en_ente and di_tipo = 'RE'),	        							
	            'colonia'               = (select pq_descripcion from cl_parroquia where pq_parroquia = (select TOP 1 convert(varchar(10), di_parroquia) 
	                                                                            from cl_direccion where di_ente = en_ente and di_tipo = 'RE')),
	            'municipio'             = (select ci_descripcion from cl_ciudad where ci_ciudad = (select TOP 1 convert(varchar(10), di_ciudad) 
	                                                                            from cl_direccion where di_ente = en_ente and di_tipo = 'RE')),
		    	'estado'               	= (select pv_descripcion from cl_provincia where pv_provincia = (select TOP 1 convert(varchar(10), di_provincia) 
	            																from cl_direccion where di_ente = en_ente and di_tipo = 'RE')),
	            'codPostal'             = (select TOP 1 di_codpostal from cl_direccion where di_ente = en_ente and di_tipo = 'RE'),
	            'pais'               	= (select pa_descripcion from cl_pais where pa_pais = (select TOP 1 di_pais from cl_direccion where di_ente = en_ente and di_tipo = 'RE')),
	            'ocupacion'             = (select valor from cl_catalogo where codigo = p_profesion
	                                             and tabla = (select codigo from cl_tabla where tabla = 'cl_profesion')), 
	            'actEcoGenerica'        = (select acg_actividad_generica from cl_actividad_generica 
	            							where acg_codigo_actividad = (select TOP 1 nc_actividad_ec from cobis..cl_negocio_cliente where nc_ente = en_ente)), 
	            'actEcoEspecifica'      = (select acg_actividad_especifica from cl_actividad_generica 
	            							where acg_codigo_actividad = (select TOP 1 nc_actividad_ec from cobis..cl_negocio_cliente where nc_ente = en_ente)), 
	            'curp'                  = en_ced_ruc,
	            'telefono'              = (select TOP 1 isnull(te_valor, '') from cobis..cl_telefono where te_ente = en_ente and te_tipo_telefono = 'D'
		    								and te_direccion = (select TOP 1 di_direccion from cl_direccion where di_ente = en_ente and di_tipo = 'RE') )
	            								 + (select TOP 1 isnull('; ' + te_valor, '') from cobis..cl_telefono where te_ente = en_ente and te_tipo_telefono = 'C'
                                                         and te_direccion = (select TOP 1 di_direccion from cl_direccion where di_ente = en_ente and di_tipo = 'RE') ), 
	            'email'					= (select TOP 1 di_descripcion from cobis..cl_direccion 
	                                             where di_ente = en_ente and di_tipo = 'CE'),
	            'firmaElecAvanzada'     = 'FIRMA ELECTRONICA AVANZADA', 
	            'origenRecursos'        = (select valor from cl_catalogo where codigo = (select TOP 1 nc_recurso from cobis..cl_negocio_cliente where nc_ente = en_ente)
	                                             and tabla = (select codigo from cl_tabla where tabla = 'cl_recursos_credito')),
	            'destinoRecursos'       = (select valor from cl_catalogo where codigo = (select TOP 1 nc_destino_credito from cobis..cl_negocio_cliente where nc_ente = en_ente)
	                                             and tabla = (select codigo from cl_tabla where tabla = 'cl_destino_credito')),
	            'respA'              	= 'NO',
	            'respB'              	= 'NO',
	            'respC'              	= 'NO',
	            'numEstOperEnv'         = isnull((select mnr_num_op_env from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<50'), 
	            'montoEstOperEnv'       = isnull((select convert(varchar,format(convert(money,mnr_mont_op_env),'N')) from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<150,000'),  
	            'numEstOperRec'         = isnull((select mnr_num_op_rec from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<50'),  
	            'montoEstOperRec'       = isnull((select convert(varchar,format(convert(money,mnr_mont_op_rec),'N'))  from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<150,000'),  
	            'numEstOperEfe'         = isnull((select mnr_num_dep_efec from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<50'),  
	            'montoEstOperEfe'       = isnull((select convert(varchar,format(convert(money,mnr_mont_dep_efec),'N')) from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<150,000'),  
	            'numEstOperNoEfe'       = isnull((select mnr_num_dep_noefec from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<50'),  
	            'montoEstOperNoEfe'     = isnull((select convert(varchar,format(convert(money,mnr_mont_dep_noefec),'N')) from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<150,000'), 
	            'nombreEjecutivo'       = (select fu_nombre from cobis..cl_funcionario, cobis..cc_oficial, cob_credito..cr_tramite 
	                                            where fu_funcionario = oc_oficial and oc_oficial = tr_oficial and tr_tramite = tg_tramite),
	            'codigo'            	= en_ente,
		    	'numContraparte'        = (select top 1 mnr_contrapartes FROM cob_credito..cr_monto_num_riesgo 
		    	                           where mnr_ente = en_ente),
	            'canalContratacion'     = (select top 1 mnr_canal_contratacion FROM cob_credito..cr_monto_num_riesgo 
		    	                           where mnr_ente = en_ente),
		    	'fechaNacConst'         = (select top 1 mnr_fecha_nac FROM cob_credito..cr_monto_num_riesgo 
		    	                           where mnr_ente = en_ente)
	        from cob_credito..cr_tramite_grupal, cobis..cl_ente, cobis..cl_ente_aux   
	        where tg_tramite = @i_tramite
	        and tg_participa_ciclo = 'S'
	        and tg_monto > 0
	        and tg_cliente = en_ente
	        and en_ente = ea_ente
	        and en_ente = @i_cliente
		end
    end
    else
    begin
		
    	select 
	        'fechaProceso'          = (select convert(varchar(10), fp_fecha, 103)from cobis..ba_fecha_proceso), 
	        'nombre'            	= isnull(en_nombre,'')+ ' ' +isnull(p_s_nombre,'')+ ' ' +isnull(p_p_apellido,'') +' ' +isnull(p_s_apellido,''),
	        'genero'            	= (select valor from cl_catalogo where codigo = p_sexo
	                                         and tabla = (select codigo from cl_tabla where tabla = 'cl_sexo')),
	        'rfcHomoclave'          = en_nit,
	        'ciudadNac'				= (select valor from cl_catalogo where codigo = convert(varchar(10), p_depa_nac)
	                                         and tabla = (select codigo from cl_tabla where tabla = 'cl_provincia')),
	        'fechaNac'    			= convert(varchar(10), p_fecha_nac, 103),
	        'paisNac'    			= (select pa_descripcion from cl_pais where pa_pais = p_pais_emi),
	        'nacionalidad'      	= (select valor from cl_catalogo where codigo = en_nac_aux
	                                         and tabla = (select codigo from cl_tabla where tabla = 'cl_nacionalidad')),	                                	
	        'calleNumero'   		=  (select TOP 1 convert(varchar(40),isnull(di_calle, '')) + ' ' + convert(varchar(10),isnull(di_nro, '')) 
	                                        + (CASE di_nro_interno when -1 then null ELSE (' (' + convert(varchar(10), di_nro_interno) + ')') END)  
	                                           from cl_direccion where di_ente = en_ente and di_tipo = 'RE'),	        							
	        'colonia'               = (select pq_descripcion from cl_parroquia where pq_parroquia = (select TOP 1 convert(varchar(10), di_parroquia) 
	                                                                        from cl_direccion where di_ente = en_ente and di_tipo = 'RE')),
	        'municipio'             = (select ci_descripcion from cl_ciudad where ci_ciudad = (select TOP 1 convert(varchar(10), di_ciudad) 
	                                                                        from cl_direccion where di_ente = en_ente and di_tipo = 'RE')),
			'estado'               	= (select pv_descripcion from cl_provincia where pv_provincia = (select TOP 1 convert(varchar(10), di_provincia) 
	        																from cl_direccion where di_ente = en_ente and di_tipo = 'RE')),
	        'codPostal'             = (select TOP 1 di_codpostal from cl_direccion where di_ente = en_ente and di_tipo = 'RE'),
	        'pais'               	= (select pa_descripcion from cl_pais where pa_pais = (select TOP 1 di_pais from cl_direccion where di_ente = en_ente and di_tipo = 'RE')),
	        'ocupacion'             = (select valor from cl_catalogo where codigo = p_profesion
	                                         and tabla = (select codigo from cl_tabla where tabla = 'cl_profesion')), 
	        'actEcoGenerica'        = (select acg_actividad_generica from cl_actividad_generica 
	        							where acg_codigo_actividad = (select TOP 1 nc_actividad_ec from cobis..cl_negocio_cliente where nc_ente = en_ente and 
										                              ltrim(rtrim(nc_estado_reg)) = 'V' order by nc_fecha_apertura)), 
	        'actEcoEspecifica'      = (select acg_actividad_especifica from cl_actividad_generica 
	        							where acg_codigo_actividad = (select TOP 1 nc_actividad_ec from cobis..cl_negocio_cliente where nc_ente = en_ente
										                              and ltrim(rtrim(nc_estado_reg)) = 'V' order by nc_fecha_apertura)),
	        'curp'                  = en_ced_ruc,
	        'telefono'              = isnull((select TOP 1 isnull(te_valor, '') from cobis..cl_telefono where te_ente = en_ente and te_tipo_telefono = 'D'
			                                 and te_direccion = (select TOP 1 di_direccion from cl_direccion where di_ente = en_ente and di_tipo = 'RE') ),'')
			
    		                          + case when (select TOP 1 isnull(te_valor, '') from cobis..cl_telefono where te_ente = en_ente and te_tipo_telefono = 'D'
			                                      and te_direccion = (select TOP 1 di_direccion from cl_direccion where di_ente = en_ente and di_tipo = 'RE') ) is not null 
										     and 
											      (select TOP 1 isnull(te_valor, '') from cobis..cl_telefono where te_ente = en_ente and te_tipo_telefono = 'C'
                                                   and te_direccion = (select TOP 1 di_direccion from cl_direccion where di_ente = en_ente and di_tipo = 'RE') ) is not null
			                            then '; ' else '' end + 
			                            
			                            isnull((select TOP 1 isnull(te_valor, '') from cobis..cl_telefono where te_ente = en_ente and te_tipo_telefono = 'C'
                                        and te_direccion = (select TOP 1 di_direccion from cl_direccion where di_ente = en_ente and di_tipo = 'RE') ),''),
	        'email'					= (select TOP 1 di_descripcion from cobis..cl_direccion 
	                                         where di_ente = en_ente and di_tipo = 'CE'),
	        'firmaElecAvanzada'     = 'FIRMA ELECTRONICA AVANZADA', 
	        'origenRecursos'        = (select valor from cl_catalogo where codigo = (select TOP 1 nc_recurso from cobis..cl_negocio_cliente where nc_ente = en_ente and 
										                                             ltrim(rtrim(nc_estado_reg)) = 'V' order by nc_fecha_apertura)
	                                         and tabla = (select codigo from cl_tabla where tabla = 'cl_recursos_credito')),
	        'destinoRecursos'       = (select valor from cl_catalogo where codigo = (select TOP 1 nc_destino_credito from cobis..cl_negocio_cliente where nc_ente = en_ente and 
										                                             ltrim(rtrim(nc_estado_reg)) = 'V' order by nc_fecha_apertura)
	                                         and tabla = (select codigo from cl_tabla where tabla = 'cl_destino_credito')),
	        'respA'              	= 'NO',
	        'respB'              	= 'NO',
	        'respC'              	= 'NO',
	        'numEstOperEnv'         = isnull((select mnr_num_op_env from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<50'), 
	        'montoEstOperEnv'       = isnull((select convert(varchar,format(convert(money,mnr_mont_op_env),'N')) from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<150,000'),  
	        'numEstOperRec'         = isnull((select mnr_num_op_rec from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<50'),  
	        'montoEstOperRec'       = isnull((select convert(varchar,format(convert(money,mnr_mont_op_rec),'N')) from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<150,000'),  
	        'numEstOperEfe'         = isnull((select mnr_num_dep_efec from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<50'),  
	        'montoEstOperEfe'       = isnull((select convert(varchar,format(convert(money,mnr_mont_dep_efec),'N')) from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<150,000'),  
	        'numEstOperNoEfe'       = isnull((select mnr_num_dep_noefec from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<50'),  
	        'montoEstOperNoEfe'     = isnull((select convert(varchar,format(convert(money,mnr_mont_dep_noefec),'N')) from cob_credito..cr_monto_num_riesgo where mnr_ente = en_ente), '=<150,000'), 
	        'nombreEjecutivo'       = (select fu_nombre from cobis..cl_funcionario, cobis..cc_oficial, cob_credito..cr_tramite 
	                                        where fu_funcionario = oc_oficial and oc_oficial = tr_oficial and tr_tramite = @i_tramite),
	        'codigo'            	= en_ente,
			'numContraparte'        = (select top 1 mnr_contrapartes FROM cob_credito..cr_monto_num_riesgo 
			                           where mnr_ente = en_ente),
	        'canalContratacion'     = (select top 1 mnr_canal_contratacion FROM cob_credito..cr_monto_num_riesgo 
			                           where mnr_ente = en_ente),
			'fechaNacConst'         = (select top 1 mnr_fecha_nac FROM cob_credito..cr_monto_num_riesgo 
			                           where mnr_ente = en_ente)
	    from cobis..cl_ente, cobis..cl_ente_aux   
	    where en_ente = (select top 1 de_cliente from cob_credito..cr_deudores
	    								where de_tramite = @i_tramite)
	    and en_ente = ea_ente
    	
    end
    
    
goto fin
end



--Control errores
errores:
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_num_error
   return @w_num_error
fin:
   return 0

go
