/************************************************************************/
/*  Archivo:                sp_reporte_consentimiento.sp                */
/*  Stored procedure:       sp_reporte_consentimiento                   */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           P. Ortiz                                    */
/*  Fecha de Documentacion: 07/May/2018                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "COBISCORP",representantes exclusivos para el Ecuador de la         */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/*   Extrae la informacion para generar los reportes del kit de credito */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/*07/May/2018   P. Ortiz             Emision Inicial                    */
/*15/Nov/2018   M. Taco              Agregar validacion al traer datos  */
/*                                   del grupo                          */
/*20/04/2020    SRO                  REQ 138247                         */
/*06/11/2020    JCASTRO              REQ 148923                         */
/*17/06/2022    KVI                  Req.185234-Op.Q.-Sol.Individual    */
/*01/12/2022    KVI                  Req.197007-Op.A.-B2B Grupal        */
/* **********************************************************************/

use cobis
go

if exists(select 1 from sysobjects where name ='sp_reporte_consentimiento')
	drop proc sp_reporte_consentimiento
go

create proc sp_reporte_consentimiento (
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
   @i_operacion       char(1)     = 'S',
   @i_nem_reporte     varchar(50) = null,
   @i_cliente         int         = null -- Req.197007
)as
declare 
@w_num_error           int,
@w_sp_name             varchar(32),
@w_grupal              varchar(10),
@w_grupo               int,  
@w_login               login,
@w_ente                int,
@w_poliza              varchar(30),
@w_formato_fecha       int,
@w_importe_seguro      varchar(10),
@w_meses_expiracion    int,
@w_op_fecha_liq        datetime,
@w_operacion           int,
@w_fecha_fin           datetime,
@w_fecha_vencimiento   datetime,
@w_mes                 int     ,
@w_dividendo           int     ,
@w_dividendo_lim       int,
@w_meses_reporte_cons  int  
   
select @w_sp_name = 'sp_reporte_consentimiento'

   -- Validar codigo de transacciones --
if ((@t_trn <> 1718 and @i_operacion = 'S'))
begin
   select @w_num_error = 151051 --Transaccion no permitida
   goto errores
end

--select @w_dividendo_lim = isnull(pa_int,8)  from cobis..cl_parametro where pa_nemonico='DIVLIM' and pa_producto='CCA'
select @w_meses_reporte_cons = isnull(pa_int,4)  from cobis..cl_parametro where pa_nemonico='MERECO' and pa_producto='CCA'
/* Extraccion de Parametros */
select @w_poliza = pa_char from cobis..cl_parametro where pa_nemonico = 'NROPOL'
select @w_importe_seguro = convert(varchar(10),pa_float) from cobis..cl_parametro where pa_nemonico = 'IMPSEG'
select @w_formato_fecha = 103

if @i_operacion = 'S'
begin
	
    
	PRINT 'Tramite ' + convert(VARCHAR(20), @i_tramite)
	select  @w_grupal = io_campo_4,
	        @w_grupo  = io_campo_1
	from cob_workflow..wf_inst_proceso 
	where io_campo_3 = @i_tramite
	
	select @w_op_fecha_liq = op_fecha_liq,
	       @w_operacion    = op_operacion,
	       @w_fecha_fin    = op_fecha_fin,
	       @w_mes          = datediff(mm,op_fecha_ini, op_fecha_fin)
    from cob_cartera..ca_operacion
    where op_tramite       = @i_tramite
	
	select 
	@w_meses_expiracion  = 4,	
	@w_fecha_vencimiento = dateadd(mm, @w_meses_reporte_cons, @w_op_fecha_liq)
		
    if @i_nem_reporte = 'CERCON2' begin  
       select @w_op_fecha_liq = @w_fecha_vencimiento + 1	   
	   select @w_fecha_vencimiento = dateadd(mm,@w_meses_reporte_cons ,@w_op_fecha_liq)
	end
		
    if (@w_grupal = 'GRUPAL')
    begin
       
        select se_cliente
        into #clientes_pagado_seguro
        from cob_cartera..ca_seguro_externo
        where se_tramite = @i_tramite
        and   se_monto   >= 0
        and   isnull(se_monto_pagado ,0) - isnull(se_monto_devuelto ,0) >= se_monto
		
		if @@rowcount = 0 begin
		   select @w_num_error = 720333 
           goto errores
		end    	
	
    	select  'poliza'                = @w_poliza + convert(varchar,year(fp_fecha)) +'-'+ 
    	                                    case when len(convert(varchar,month(fp_fecha))) > 1 
    	                                        then convert(varchar,month(fp_fecha)) else  '0' + convert(varchar,month(fp_fecha)) end,
    	        'nroCertificado'        = tg_prestamo,
    	        'nombre'                = upper(isnull(en_nombre,'') + ' ' + isnull(p_s_nombre,'') 
    	                                    + ' ' + isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,'')),
    	        'fechaNacimiento'       = convert(varchar(10),p_fecha_nac, 103),
    	        'direccion'             = upper(isnull(di_calle,'') + ' ' + isnull(convert(varchar(10),di_nro),'') + ' ' +
    	                                    isnull((select top 1 pq_descripcion from cl_parroquia where pq_parroquia = di_parroquia ),'')  + ' ' + --Colonia
    	                                    isnull((select top 1 ci_descripcion from cl_ciudad where ci_ciudad = di_ciudad ),'')  + ' ' + --municipio
			                                isnull((select top 1 pv_descripcion from cl_provincia where pv_provincia = di_provincia ),'') + ' ' + --estado
                                            isnull(di_codpostal,'')),
    	        'rfc'                   = isnull(en_rfc, en_nit),
    	        
    	        'diaInicio'             = case when len(convert(varchar,day(@w_op_fecha_liq))) > 1 
    	                                    then convert(varchar,day(@w_op_fecha_liq)) else  '0' + convert(varchar,day(@w_op_fecha_liq)) end, 
    	        'mesInicio'             = case when len(convert(varchar,month(@w_op_fecha_liq))) > 1 
    	                                    then convert(varchar,month(@w_op_fecha_liq)) else  '0' + convert(varchar,month(@w_op_fecha_liq)) end, 
    	        'anioInicio'            = convert(varchar,year(@w_op_fecha_liq)),
    	        
    	        'diaFin'                = case when len(convert(varchar,day(@w_fecha_vencimiento))) > 1 
    	                                    then convert(varchar,day(@w_fecha_vencimiento)) else  '0' + convert(varchar,day(@w_fecha_vencimiento)) end, 
    	        'mesFin'                = case when len(convert(varchar,month(@w_fecha_vencimiento))) > 1 
    	                                    then convert(varchar,month(@w_fecha_vencimiento)) else  '0' + convert(varchar,month(@w_fecha_vencimiento)) end,  
    	        'anioFin'               = convert(varchar,year(@w_fecha_vencimiento)),
    	        
    	        'dia'                   = case when len(convert(varchar,day(fp_fecha))) > 1 
    	                                    then convert(varchar,day(fp_fecha)) else  '0' + convert(varchar,day(fp_fecha)) end, 
    	        'mes'                   = case when len(convert(varchar,month(fp_fecha))) > 1 
    	                                    then convert(varchar,month(fp_fecha)) else  '0' + convert(varchar,month(fp_fecha)) end, 
    	        'anio'                  = convert(varchar,year(fp_fecha)),
    	        'inicioVigencia'        = convert(varchar,@w_op_fecha_liq, @w_formato_fecha),
    	        'terminoVigencia'       = convert(varchar,@w_fecha_vencimiento, @w_formato_fecha),
    	        'costoSeguro'           = @w_importe_seguro,
    	        'nroCuenta'             = '*****' + substring(ea_cta_banco, 6, len(ea_cta_banco)),
				'temporalidad'          = @w_meses_expiracion
    	from cobis..cl_ente, cobis..cl_ente_aux, cobis..cl_direccion, cob_cartera..ca_operacion, 
    	        cob_credito..cr_tramite_grupal, cobis..ba_fecha_proceso
    	where en_ente in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_grupo) --(4,5) --
        and   en_ente in (select se_cliente from #clientes_pagado_seguro)
        and en_ente = ea_ente
        and di_ente = en_ente
        and op_tramite = @i_tramite
        and tg_tramite = op_tramite
        and tg_cliente = en_ente
        and tg_participa_ciclo = 'S'
        and tg_monto   > 0
        and di_direccion = (case when exists (select 1 di_direccion from cobis..cl_direccion 
                                where di_ente = en_ente and di_tipo = 'RE')
                             then
                                (select top 1 di_direccion from cobis..cl_direccion 
                                where di_ente = en_ente and di_tipo = 'RE')
                             else
                                (select top 1 di_direccion from cobis..cl_direccion 
                                where di_ente = en_ente and di_tipo != 'AE')
                             end                            
                             )
      
    end
    else
    begin
    	
    	/* Se aigna el cliente */
    	select @w_ente = @w_grupo  
    	
    	select  'poliza'                = @w_poliza + convert(varchar,year(fp_fecha)) +'-'+ 
    	                                    case when len(convert(varchar,month(fp_fecha))) > 1 
    	                                        then convert(varchar,month(fp_fecha)) else  '0' + convert(varchar,month(fp_fecha)) end,
    	        'nroCertificado'        = tg_prestamo,
    	        'nombre'                = upper(isnull(en_nombre,'') + ' ' + isnull(p_s_nombre,'') 
    	                                    + ' ' + isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,'')),
    	        'fechaNacimiento'       = convert(varchar(10),p_fecha_nac, 103),
    	        'direccion'             = upper(isnull(di_calle,'') + ' ' + isnull(convert(varchar(10),di_nro),'') + ' ' +
    	                                    isnull((select top 1 pq_descripcion from cl_parroquia where pq_parroquia = di_parroquia ),'')  + ' ' + --Colonia
    	                                    isnull((select top 1 ci_descripcion from cl_ciudad where ci_ciudad = di_ciudad ),'')  + ' ' + --municipio
			                                isnull((select top 1 pv_descripcion from cl_provincia where pv_provincia = di_provincia ),'') + ' ' + --estado
                                            isnull(di_codpostal,'')),
    	        'rfc'                   = isnull(en_rfc, en_nit),
    	        
    	        'diaInicio'             = case when len(convert(varchar,day(@w_op_fecha_liq))) > 1 
    	                                    then convert(varchar,day(@w_op_fecha_liq)) else  '0' + convert(varchar,day(@w_op_fecha_liq)) end, 
    	        'mesInicio'             = case when len(convert(varchar,month(@w_op_fecha_liq))) > 1 
    	                                    then convert(varchar,month(@w_op_fecha_liq)) else  '0' + convert(varchar,month(@w_op_fecha_liq)) end, 
    	        'anioInicio'            = convert(varchar,year(@w_op_fecha_liq)),
    	        
    	        'diaFin'                = case when len(convert(varchar,day(DATEADD(month, @w_meses_expiracion, @w_op_fecha_liq)))) > 1 
    	                                    then convert(varchar,day(DATEADD(month, @w_meses_expiracion, @w_op_fecha_liq))) else  '0' + convert(varchar,day(DATEADD(month, @w_meses_expiracion, @w_op_fecha_liq))) end, 
    	        'mesFin'                = case when len(convert(varchar,month(DATEADD(month, @w_meses_expiracion, @w_op_fecha_liq)))) > 1 
    	                                    then convert(varchar,month(DATEADD(month, @w_meses_expiracion, @w_op_fecha_liq))) else  '0' + convert(varchar,month(DATEADD(month, @w_meses_expiracion, @w_op_fecha_liq))) end,  
    	        'anioFin'               = convert(varchar,year(DATEADD(month, @w_meses_expiracion, @w_op_fecha_liq))),
    	        
    	        'dia'                   = case when len(convert(varchar,day(fp_fecha))) > 1 
    	                                    then convert(varchar,day(fp_fecha)) else  '0' + convert(varchar,day(fp_fecha)) end, 
    	        'mes'                   = case when len(convert(varchar,month(fp_fecha))) > 1 
    	                                    then convert(varchar,month(fp_fecha)) else  '0' + convert(varchar,month(fp_fecha)) end, 
    	        'anio'                  = convert(varchar,year(fp_fecha)),
    	        'inicioVigencia'        = convert(varchar,@w_op_fecha_liq, @w_formato_fecha),
    	        'terminoVigencia'       = convert(varchar,DATEADD(month, @w_meses_expiracion, @w_op_fecha_liq), @w_formato_fecha),
    	        'costoSeguro'           = @w_importe_seguro,
    	        'nroCuenta'             = '*****' + substring(ea_cta_banco, 6, len(ea_cta_banco)),
				'temporalidad'          = @w_meses_expiracion
    	from cobis..cl_ente, cobis..cl_ente_aux, cobis..cl_direccion, cob_cartera..ca_operacion, 
    	        cob_credito..cr_tramite_grupal, cobis..ba_fecha_proceso
    	where en_ente = @w_ente
        and di_ente = en_ente
        and en_ente = ea_ente
        and op_tramite = @i_tramite
        and tg_tramite = op_tramite
        and tg_cliente = en_ente
        and di_direccion = (case when exists (select 1 di_direccion from cobis..cl_direccion 
                                where di_ente = en_ente and di_tipo = 'RE')
                             then
                                (select top 1 di_direccion from cobis..cl_direccion 
                                where di_ente = en_ente and di_tipo = 'RE')
                             else
                                (select top 1 di_direccion from cobis..cl_direccion 
                                where di_ente = en_ente and di_tipo != 'AE')
                             end                            
                             )
    	
    end
    
    
goto fin
end

if @i_operacion = 'Q' -- Req.185234
begin	
    
	PRINT 'Tramite ' + convert(VARCHAR(20), @i_tramite)
	select @w_ente  = io_campo_1
	from cob_workflow..wf_inst_proceso 
	where io_campo_3 = @i_tramite
	
	select @w_op_fecha_liq = op_fecha_liq,
	       @w_operacion    = op_operacion,
	       @w_fecha_fin    = op_fecha_fin,
	       @w_mes          = datediff(mm,op_fecha_ini, op_fecha_fin)
    from cob_cartera..ca_operacion
    where op_tramite       = @i_tramite
	
	select 
	       @w_meses_expiracion  = 4,	
	       @w_fecha_vencimiento = dateadd(mm, @w_meses_reporte_cons, @w_op_fecha_liq)
			    	
    select  'poliza'                = @w_poliza + convert(varchar,year(fp_fecha)) +'-'+ 
                                        case when len(convert(varchar,month(fp_fecha))) > 1 
                                            then convert(varchar,month(fp_fecha)) else  '0' + convert(varchar,month(fp_fecha)) end,
            'nroCertificado'        = op_banco,
            'nombre'                = upper(isnull(en_nombre,'') + ' ' + isnull(p_s_nombre,'') 
                                        + ' ' + isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,'')),
            'fechaNacimiento'       = convert(varchar(10),p_fecha_nac, 103),
            'direccion'             = upper(isnull(di_calle,'') + ' ' + isnull(convert(varchar(10),di_nro),'') + ' ' +
                                        isnull((select top 1 pq_descripcion from cl_parroquia where pq_parroquia = di_parroquia ),'')  + ' ' + --Colonia
                                        isnull((select top 1 ci_descripcion from cl_ciudad where ci_ciudad = di_ciudad ),'')  + ' ' + --municipio
		                                isnull((select top 1 pv_descripcion from cl_provincia where pv_provincia = di_provincia ),'') + ' ' + --estado
                                           isnull(di_codpostal,'')),
            'rfc'                   = isnull(en_rfc, en_nit),
            
            'diaInicio'             = case when len(convert(varchar,day(@w_op_fecha_liq))) > 1 
                                        then convert(varchar,day(@w_op_fecha_liq)) else  '0' + convert(varchar,day(@w_op_fecha_liq)) end, 
            'mesInicio'             = case when len(convert(varchar,month(@w_op_fecha_liq))) > 1 
                                        then convert(varchar,month(@w_op_fecha_liq)) else  '0' + convert(varchar,month(@w_op_fecha_liq)) end, 
            'anioInicio'            = convert(varchar,year(@w_op_fecha_liq)),
            
            'diaFin'                = case when len(convert(varchar,day(DATEADD(month, @w_meses_expiracion, @w_op_fecha_liq)))) > 1 
                                        then convert(varchar,day(DATEADD(month, @w_meses_expiracion, @w_op_fecha_liq))) else  '0' + convert(varchar,day(DATEADD(month, @w_meses_expiracion, @w_op_fecha_liq))) end, 
            'mesFin'                = case when len(convert(varchar,month(DATEADD(month, @w_meses_expiracion, @w_op_fecha_liq)))) > 1 
                                        then convert(varchar,month(DATEADD(month, @w_meses_expiracion, @w_op_fecha_liq))) else  '0' + convert(varchar,month(DATEADD(month, @w_meses_expiracion, @w_op_fecha_liq))) end,  
            'anioFin'               = convert(varchar,year(DATEADD(month, @w_meses_expiracion, @w_op_fecha_liq))),
            
            'dia'                   = case when len(convert(varchar,day(fp_fecha))) > 1 
                                        then convert(varchar,day(fp_fecha)) else  '0' + convert(varchar,day(fp_fecha)) end, 
            'mes'                   = case when len(convert(varchar,month(fp_fecha))) > 1 
                                        then convert(varchar,month(fp_fecha)) else  '0' + convert(varchar,month(fp_fecha)) end, 
            'anio'                  = convert(varchar,year(fp_fecha)),
            'inicioVigencia'        = convert(varchar,@w_op_fecha_liq, @w_formato_fecha),
            'terminoVigencia'       = convert(varchar,DATEADD(month, @w_meses_expiracion, @w_op_fecha_liq), @w_formato_fecha),
            'costoSeguro'           = @w_importe_seguro,
            'nroCuenta'             = '*****' + substring(ea_cta_banco, 6, len(ea_cta_banco)),
			'temporalidad'          = @w_meses_expiracion
    from cobis..cl_ente, cobis..cl_ente_aux, cobis..cl_direccion, cob_cartera..ca_operacion, 
            cob_credito..cr_tramite, cobis..ba_fecha_proceso
    where en_ente = @w_ente
       and di_ente = en_ente
       and en_ente = ea_ente
       and op_tramite = @i_tramite
       and tr_tramite = op_tramite
       and tr_cliente = en_ente
       and di_direccion = (case when exists (select 1 di_direccion from cobis..cl_direccion 
                                             where di_ente = en_ente and di_tipo = 'RE')
                            then
                               (select top 1 di_direccion from cobis..cl_direccion 
                                where di_ente = en_ente and di_tipo = 'RE')
                            else
                               (select top 1 di_direccion from cobis..cl_direccion 
                                where di_ente = en_ente and di_tipo != 'AE')
                            end                            
                           )    
goto fin
end

--Inicio Req.197007
if @i_operacion = 'A' -- Cerificado de Asistencia Funeraria Grupal por Cliente 
begin    
	print 'Tramite ' + convert(VARCHAR(20), @i_tramite)
	select  @w_grupal = io_campo_4,
	        @w_grupo  = io_campo_1
	from cob_workflow..wf_inst_proceso 
	where io_campo_3 = @i_tramite
	
	select @w_op_fecha_liq = op_fecha_liq,
	       @w_operacion    = op_operacion,
	       @w_fecha_fin    = op_fecha_fin,
	       @w_mes          = datediff(mm,op_fecha_ini, op_fecha_fin)
    from cob_cartera..ca_operacion
    where op_tramite       = @i_tramite
	
	select 
	    @w_meses_expiracion  = 4,	
	    @w_fecha_vencimiento = dateadd(mm, @w_meses_reporte_cons, @w_op_fecha_liq)
		
    if @i_nem_reporte = 'CERCON2' begin  
       select @w_op_fecha_liq = @w_fecha_vencimiento + 1	   
	   select @w_fecha_vencimiento = dateadd(mm,@w_meses_reporte_cons ,@w_op_fecha_liq)
	end
		
    if (@w_grupal = 'GRUPAL')
    begin       
        select se_cliente
        into #clientes_pagado_seguro_a
        from cob_cartera..ca_seguro_externo
        where se_tramite = @i_tramite
        and   se_monto  >= 0
        and   isnull(se_monto_pagado,0) - isnull(se_monto_devuelto, 0) >= se_monto
		
		if @@rowcount = 0 begin
		   select @w_num_error = 720333 
           goto errores
		end    	
	
    	select  'poliza'                = @w_poliza + convert(varchar,year(fp_fecha)) +'-'+ 
    	                                    case when len(convert(varchar,month(fp_fecha))) > 1 
    	                                        then convert(varchar,month(fp_fecha)) else  '0' + convert(varchar,month(fp_fecha)) end,
    	        'nroCertificado'        = tg_prestamo,
    	        'nombre'                = upper(isnull(en_nombre,'') + ' ' + isnull(p_s_nombre,'') 
    	                                    + ' ' + isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,'')),
    	        'fechaNacimiento'       = convert(varchar(10),p_fecha_nac, 103),
    	        'direccion'             = upper(isnull(di_calle,'') + ' ' + isnull(convert(varchar(10),di_nro),'') + ' ' +
    	                                    isnull((select top 1 pq_descripcion from cl_parroquia where pq_parroquia = di_parroquia ),'')  + ' ' + --Colonia
    	                                    isnull((select top 1 ci_descripcion from cl_ciudad where ci_ciudad = di_ciudad ),'')  + ' ' + --municipio
			                                isnull((select top 1 pv_descripcion from cl_provincia where pv_provincia = di_provincia ),'') + ' ' + --estado
                                            isnull(di_codpostal,'')),
    	        'rfc'                   = isnull(en_rfc, en_nit),
    	        
    	        'diaInicio'             = case when len(convert(varchar,day(@w_op_fecha_liq))) > 1 
    	                                    then convert(varchar,day(@w_op_fecha_liq)) else  '0' + convert(varchar,day(@w_op_fecha_liq)) end, 
    	        'mesInicio'             = case when len(convert(varchar,month(@w_op_fecha_liq))) > 1 
    	                                    then convert(varchar,month(@w_op_fecha_liq)) else  '0' + convert(varchar,month(@w_op_fecha_liq)) end, 
    	        'anioInicio'            = convert(varchar,year(@w_op_fecha_liq)),
    	        
    	        'diaFin'                = case when len(convert(varchar,day(@w_fecha_vencimiento))) > 1 
    	                                    then convert(varchar,day(@w_fecha_vencimiento)) else  '0' + convert(varchar,day(@w_fecha_vencimiento)) end, 
    	        'mesFin'                = case when len(convert(varchar,month(@w_fecha_vencimiento))) > 1 
    	                                    then convert(varchar,month(@w_fecha_vencimiento)) else  '0' + convert(varchar,month(@w_fecha_vencimiento)) end,  
    	        'anioFin'               = convert(varchar,year(@w_fecha_vencimiento)),
    	        
    	        'dia'                   = case when len(convert(varchar,day(fp_fecha))) > 1 
    	                                    then convert(varchar,day(fp_fecha)) else  '0' + convert(varchar,day(fp_fecha)) end, 
    	        'mes'                   = case when len(convert(varchar,month(fp_fecha))) > 1 
    	                                    then convert(varchar,month(fp_fecha)) else  '0' + convert(varchar,month(fp_fecha)) end, 
    	        'anio'                  = convert(varchar,year(fp_fecha)),
    	        'inicioVigencia'        = convert(varchar,@w_op_fecha_liq, @w_formato_fecha),
    	        'terminoVigencia'       = convert(varchar,@w_fecha_vencimiento, @w_formato_fecha),
    	        'costoSeguro'           = @w_importe_seguro,
    	        'nroCuenta'             = '*****' + substring(ea_cta_banco, 6, len(ea_cta_banco)),
				'temporalidad'          = @w_meses_expiracion
    	from cobis..cl_ente, cobis..cl_ente_aux, cobis..cl_direccion, cob_cartera..ca_operacion, 
    	        cob_credito..cr_tramite_grupal, cobis..ba_fecha_proceso
    	where en_ente in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_grupo) --(4,5) --
        and   en_ente in (select se_cliente from #clientes_pagado_seguro_a)
        and en_ente = ea_ente
        and di_ente = en_ente
        and op_tramite = @i_tramite
        and tg_tramite = op_tramite
        and tg_cliente = en_ente
        and tg_participa_ciclo = 'S'
        and tg_monto   > 0
        and di_direccion = (case when exists (select 1 di_direccion from cobis..cl_direccion 
                                where di_ente = en_ente and di_tipo = 'RE')
                             then
                                (select top 1 di_direccion from cobis..cl_direccion 
                                where di_ente = en_ente and di_tipo = 'RE')
                             else
                                (select top 1 di_direccion from cobis..cl_direccion 
                                where di_ente = en_ente and di_tipo != 'AE')
                             end                            
                             )
        and en_ente = @i_cliente							 
    end    
goto fin
end
--Fin Req.197007


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
