use cob_conta_super
go

IF OBJECT_ID ('dbo.sp_conciliar_corresponsal', 'P') IS NOT NULL
	DROP PROCEDURE dbo.sp_conciliar_corresponsal
GO

/************************************************************************/
/*   Archivo:             conciliar_corresponsal.sp                     */
/*   Stored procedure:    sp_conciliar_corresponsal                     */
/*   Base de datos:       cob_conta_super                               */
/*   Producto:            Cartera                                       */
/*   Disenado por:        Raymundo Picazo                               */
/*   Fecha de escritura:  Abr.09.                                       */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Etracion de informacion de los diferentescorresponsales para       */
/*    para obtener una consiliacion                                     */
/************************************************************************/
/*                               MODIFICACIONES                         */
/*  FECHA              AUTOR          CAMBIO                            */
/*  MAR-2019       Raymundo Picazo                                      */
/*  ABR-2019       Jose Sanchez    Validacion: Si el registro existe    */
/* 				no procesar, continuar el flujo  	                    */
/*  JUL-2019       Ma. Jose Taco   Validar archivos huerfanos y cobis   */
/*                                                                      */
/************************************************************************/ 


CREATE proc sp_conciliar_corresponsal (    
   @t_show_version   		bit 		= 0,
   @s_ssn					int 		= null, 
   @s_sesn					int 		= null,
   @s_term					varchar(32)	= null, 
   @s_date					datetime	= null, 
   @s_srv					varchar(30) = null, 
   @s_lsrv					varchar(30) = null, 
   @s_rol					smallint    = null, 
   @s_ofi					smallint	= null, 
   @s_culture				varchar(10)	= null, 
   @s_org					char(1)		= null, 
   @s_user                  login,
   @i_corresponsal   		varchar(25) = null, 	--CORRESPONSAL: SANTANDER,OXXO, SEVEN ELEVEN. ca_corresponsal.co_nombre   
   @i_id_trn_corresp  		int			= null, 	-- ID TRANSACCION DE CORRESPONSAL
   @i_referencia_pago 		varchar(25)	= null,		-- REFERENCIA DE PAGOS
   @i_fecha_valor    		datetime	= null,		-- FECHA EN QUE SE EJECUTO EL PAGO
   @i_monto         		money		= null,    	-- MONTO DEL PAGO
   @i_reverso         		char(1) 	= null, 	-- INDICADOR DE REVERSO Si/NO (S/N)
   @i_trn_reverso     		int     	= null,		-- ID DE TRANSACCION DE REVERSO  
   @i_archivo		  		varchar(50)	= null, 	--NOMBRE DE ARCHIVO
   @i_fecha_archivo 		datetime 	= null, 	-- FECHA DEL ARCHIVO
   @i_linea			  		int		 	= null, 	--NUMERO DE LINEA DEL ARCHIVO QUE SE PROCESA 
   @i_texto_linea	 		varchar(500)= null,		--TEXTO COMPLETO DE LA LINEA
   @i_ultima_linea	  		char(1)  	= null		-- INDICADOR DE ULTIMA LINEA DEL ARCHIVO Si/NO (S/N)
)
AS
BEGIN
DECLARE
	@w_error                int,
	@w_sp_name              varchar(64),
	@w_msg                  varchar(64),
	@w_mensaje              varchar(150),	
	@w_tipo					varchar(64),
	@w_estado				varchar(2),
	@w_codigo_interno		int,
	@w_cliente				int,
	@w_accion				char(1),
	@w_conciliado			char(1),
	@w_login				login,
	@w_fecha_conci			datetime,
	@w_sp_val_corresponsal  varchar(255),
	@w_aplicativo           int,
	@w_id_cobis_trn         int, 
	@w_huerfano             char(2),
	@w_grupo                int,
	@w_fecha_pago           datetime,
	@w_monto_pago           money,
	@w_corresponsal			varchar(30),
	@w_fecha_s			    varchar(15),
	@w_fecha_s1			    varchar(15),
	@w_fecha_fin			datetime,
	@w_fecha_valor			varchar(10),
	@w_reverso				char(1),
	@w_archivo				varchar(50),
	@w_archivo_sub			varchar(50),
	@w_trn_corresponsal		varchar(20),
	@w_s_date_hour			datetime,
	@w_fecha_ini  DATETIME, --conciliacion
    @w_fecha_fin1  DATETIME,
    @w_fecha_fin2 DATETIME,
    @w_fecha_proceso DATETIME
	
    --Inicializa el nombre del sp
    select @w_sp_name = 'sp_conciliar_corresponsal'
    select @w_aplicativo = 0
    
    --Versionamiento del Programa --
    if @t_show_version = 1
    begin
          print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
          return 0
    end
	
	select @w_archivo = SUBSTRING(@i_archivo,1,36)
	select @w_archivo_sub =  SUBSTRING(@w_archivo,1,21)
    
    --Obtiene el corresponsal con el que se procesará el archivo
    select @w_corresponsal = valor 
    from cobis..cl_catalogo 
    where @i_archivo like '%'+RTRIM(codigo)+'%'
    and tabla = (select codigo 
                from cobis..cl_tabla 
                where tabla = 'sb_corresponsal_archivo')

    --Valida si se ingresa en el proceso la última línea
    --Este proceso es para obtener los huérfanos de cobis
    SELECT @w_fecha_ini = dateadd(dd, -1 , convert(DATETIME, substring(@i_archivo, 14, 8),103)) --mta   
    if @i_ultima_linea = 'S'
    begin        
       SELECT @w_fecha_proceso = convert(DATETIME, substring(@i_archivo, 14, 8),103)
       SELECT @w_fecha_ini = @w_fecha_proceso
       SELECT @w_fecha_fin = @w_fecha_proceso
	   
       SELECT @w_fecha_ini = dateadd(dd, -1 , @w_fecha_ini)
	   
       WHILE 1=1
       BEGIN
          IF EXISTS(SELECT 1 FROM cobis..cl_dias_feriados WHERE df_ciudad = 9999
                    AND df_fecha = @w_fecha_ini)
             SELECT @w_fecha_ini = dateadd(dd, -1 , @w_fecha_ini)
          ELSE
             break
       END
     
       SELECT @w_fecha_ini  , @w_fecha_fin
     
       SELECT
              corresponsal = co_corresponsal ,
              trn_id_corresp = co_id_trn_corresp ,
              referencia   = co_referencia_pago,
              fecha_valor  = co_fecha_valor  ,
              monto        = co_monto ,
              archivo      = co_archivo ,
              secuencial   = co_id_cobis_trn 
       INTO #conci
       FROM sb_conciliacion_corresponsal
       WHERE co_archivo = @w_archivo
     
       SELECT  
              cot_corresponsal   = co_corresponsal,
              cot_trn_id_corresp = co_trn_id_corresp,
              cot_referencia     = co_referencia,
              cot_fecha_valor    = co_fecha_valor,
              cot_monto          = co_monto,
              cot_archivo_ref = co_archivo_ref,
              cot_secuencial     = co_secuencial    
       INTO #corresp
       FROM cob_cartera..ca_corresponsal_trn
       WHERE co_fecha_proceso = @w_fecha_ini
       AND co_archivo_ref LIKE 'H2H_43%'
       union
       SELECT
              'cot_corresponsal'   = co_corresponsal,
              'cot_trn_id_corresp' = co_trn_id_corresp,
              'cot_referencia'     = co_referencia,
              'cot_fecha_valor'    = co_fecha_valor,
              'cot_monto'          = co_monto,
              'cot_archivo_ref' = co_archivo_ref,
              'cot_secuencial'     = co_secuencial
       FROM cob_cartera..ca_corresponsal_trn
       WHERE co_fecha_proceso= @w_fecha_fin       
       AND co_archivo_ref LIKE @w_archivo_sub + '_01'+'%'

       DELETE FROM #corresp WHERE cot_archivo_ref LIKE 'H2H_43%' + convert(VARCHAR, @w_fecha_ini, 112)+'_01'+'%'

     
       DELETE #corresp
       FROM #conci
       WHERE cot_corresponsal = corresponsal
       AND cot_trn_id_corresp = trn_id_corresp
       AND cot_referencia     = referencia
       AND cot_fecha_valor    = fecha_valor
       AND cot_monto          = monto

       --Inserta en la tabla de conciliaciones los huerfanos de COBIS
       insert into cob_conta_super..sb_conciliacion_corresponsal (
            co_aplicativo, 
            co_corresponsal, 
            co_secuencial, 
            co_relacionados, 
            co_id_trn_corresp, 
            co_id_cobis_trn, 
            co_tipo_trn, 
            co_referencia_pago,
            co_fecha_registro,
            co_usuario_trn,
            co_fecha_valor,
            co_monto,
            co_reverso,
            co_trn_reverso,
            co_cliente,
            co_grupo,
            co_estado_trn,
            co_estado_conci,
            co_usuario_conci,
            co_razon_no_conci,
            co_fecha_conci,
            co_accion_conci,
            co_observaciones,
            co_archivo,
            co_linea,
            co_texto_linea)
       select   
           co_aplicativo                = 7,                -- 7 - Cartera
           co_corresponsal         		= co_corresponsal,
           co_secuencial                = 0,
           co_relacionados              = 0,                -- ocupamos este campo para la opcion conciliar sin accion 
           co_id_trn_corresp            = co_trn_id_corresp,
           co_id_cobis_trn              = co_secuencial, -- Secuencial de ca_corresponsal_trn
           co_tipo_trn                  = co_tipo, -- Esto indica si es pago grupal(pg),pago garantía(pg), pi, cg, 
           co_referencia_pago           = co_referencia, 
           co_fecha_registro            = @w_fecha_ini, --co_fecha_proceso,
           co_usuario_trn               = '',
           co_fecha_valor               = co_fecha_valor,
           co_monto                     = co_monto,
           co_reverso                   = case 
                                             when co_accion = 'R' THEN 'S'
                                             else 'N'
                                          end,
           co_trn_reverso               = case 
                                             when  co_accion = 'R' THEN co_referencia
     else null
                                          end,
           co_cliente                   = case
											when co_tipo in ('PI','CI') then 
											(select op_cliente
											from cob_cartera..ca_operacion
											where op_operacion = co_codigo_interno)
											else null
										   end,
           co_grupo                     = case
											when co_tipo in ('PG','CG','GL') then
											(select op_cliente
											from cob_cartera..ca_operacion
											where op_operacion = co_codigo_interno)
										  else null
										  end,
           co_estado_trn                = co_estado,
           co_estado_conci	            = 'N',
           co_usuario_conci             = null,
           co_razon_no_conci            = 'C',
           co_fecha_conci               = null,
           co_accion_conci              = null,
           co_observaciones 			= null,
           co_archivo		            = co_archivo_ref,
           co_linea		                = 0,
           co_texto_linea	            = ''
        from cob_cartera..ca_corresponsal_trn as ct   ,
             #corresp
        WHERE co_corresponsal = cot_corresponsal
        AND co_trn_id_corresp = cot_trn_id_corresp
        AND co_referencia     = cot_referencia
        AND co_fecha_valor    = cot_fecha_valor
        AND co_monto          = cot_monto
        
        return 0
    end
	
	select @w_fecha_conci = @s_date
	
    select @w_s_date_hour=dateadd(HOUR,DATEPART(HOUR, GETDATE()),@s_date)
	select @w_s_date_hour=dateadd(MINUTE,DATEPART(MINUTE, GETDATE()),@w_s_date_hour)
	
	
	--TRANSFORMA LA FECHA AL FORMATO SOLICITADO POR EL SP VALIDA PAGOS
    select @w_fecha_valor = convert(varchar(10),@i_fecha_valor,101)
    select @w_fecha_valor = replace(@w_fecha_valor,'/','')
    
    select @i_referencia_pago = RTRIM(@i_referencia_pago)
    
    --Obtiene el sp que valida la referencia
    select @w_sp_val_corresponsal = co_sp_validacion_ref    
    from  cob_cartera..ca_corresponsal 
    where co_nombre = @w_corresponsal

    --Verifica si se realizara un reverso 
    if(@i_reverso in ('S','-'))
    begin
        select @w_accion = 'R'
        select @w_reverso = 'S'
		select @i_trn_reverso = @i_id_trn_corresp
    end
    else
    begin
        select @w_accion = 'I'
        select @w_reverso = 'N'
    end

    --Realiza la validacion de la referencia de pago
    exec @w_error     	  	= @w_sp_val_corresponsal
        @i_referencia     	= @i_referencia_pago,   
        @i_fecha_pago     	= @w_fecha_valor,
        @i_monto_pago     	= @i_monto,
        @i_archivo_pago   	= @w_archivo,
		@i_es_conciliacion	= 'S',
		@i_id_trn_corresp	= @i_id_trn_corresp,
        @o_tipo           	= @w_tipo           	out,
        @o_codigo_interno 	= @w_codigo_interno 	out,
        @o_fecha_pago     	= @w_fecha_pago     	out,
        @o_monto_pago     	= @w_monto_pago     	out,
		@o_trn_corresponsal = @w_trn_corresponsal 	out

    --En caso de error no hacer nada
    if @w_error <> 0 
        return 0
   
    --Valida el tipo de opeación a realizar para inicializar la variable de aplicativo
    if(@w_tipo in ('PG','CG','PI','CI','GL'))
        select @w_aplicativo = 7

    select @w_conciliado = 'S'
    select @w_fecha_conci = @s_date --mta 
    --Verifica si el pago está procesado por el proceso de pagos referenciados
    select @w_id_cobis_trn 	= co_secuencial,
           @w_estado		= co_estado,
           @w_login			= co_login
    from cob_cartera..ca_corresponsal_trn 
    where co_corresponsal = @w_corresponsal
        and co_referencia	  = @i_referencia_pago
        and co_trn_id_corresp = @w_trn_corresponsal
        and co_monto 		  = @w_monto_pago
        and co_fecha_valor	  = @i_fecha_valor
        and co_accion		  = @w_accion

    --Si no encuentra informacion es un huérfano de archivo
    if(@@rowcount = 0)
    begin
        select @w_conciliado = 'N',
               @w_huerfano   = 'A',
         @w_fecha_conci = null
    end
    --Verifica el tipo de pago para obtener el número de cliente o grupo
    if(@w_tipo in ('PI','CI'))
	begin
        select @w_cliente = op_cliente
        from cob_cartera..ca_operacion
        where op_operacion = @w_codigo_interno
	end
    else if(@w_tipo in ('PG','CG'))
	begin
       select @w_grupo = op_cliente
        from cob_cartera..ca_operacion
        where op_operacion = @w_codigo_interno
	 end
	 else if(@w_tipo ='GL')
	 begin
		select @w_grupo = @w_codigo_interno
	 end
   
    -- valida si existe registro por co_corresponsal, co_id_trn_corresp, co_id_cobis_trn, co_referencia_pago, co_fecha_valor y co_archivo
	-- si no existe, guarda el registro en la tabla sb_conciliacion_corresponsal.
	-- si existe no hace nada.
        select  
	co_corresponsal,
	co_id_trn_corresp,
	co_id_cobis_trn,
	co_referencia_pago,
	co_fecha_valor,
	co_archivo
	from sb_conciliacion_corresponsal 
	where co_corresponsal  = @w_corresponsal 
	and co_id_trn_corresp  = @i_id_trn_corresp 
    and co_referencia_pago = @i_referencia_pago
    and co_fecha_valor 	   = @i_fecha_valor   
    and co_archivo 		 like  @w_archivo_sub +'%'
			
	if @@ROWCOUNT = 0 
	begin
		-- No existe, inserta la información del pago a conciliar en la tabla de conciliaciones
		insert into sb_conciliacion_corresponsal (
		co_aplicativo,			co_corresponsal, 			co_secuencial,
		co_relacionados,        co_id_trn_corresp,          co_id_cobis_trn,
		co_tipo_trn,            co_referencia_pago,         co_fecha_registro, 
		co_usuario_trn,      	co_fecha_valor,				co_monto,
		co_reverso,				co_trn_reverso,				co_cliente,
		co_grupo,				co_estado_trn,	 	    	co_estado_conci,
		co_usuario_conci,		co_razon_no_conci,	     	co_fecha_conci,
		co_accion_conci,		co_observaciones,			co_archivo,					
		co_linea, 				co_texto_linea)
		values (
		@w_aplicativo, 	        @w_corresponsal,		    0,
		0,                      @i_id_trn_corresp,          @w_id_cobis_trn, 
		@w_tipo,				@i_referencia_pago,         @w_fecha_ini, --@w_s_date_hour,
		@s_user,         		@w_fecha_pago,				@w_monto_pago,
		@w_reverso,				@i_trn_reverso, 			@w_cliente,
		@w_grupo,				@w_estado,				 	@w_conciliado,				
		@w_login,				@w_huerfano,	     		@w_fecha_conci,							
		'',						'',							@w_archivo,	
		@i_linea,				@i_texto_linea)

		--En caso de error, devuelve el proceso
		if (@@error <> 0)
		begin
			select @w_msg = 'ERROR AL INSERTAR REGISTRO EN SB_CONCILIACION_CORRESPONSAL'
			GOTO ERROR_FIN
		end
	end
    
    return 0
    
    ERROR_FIN: 
    exec cobis..sp_cerror 
          @t_from = @w_sp_name, 
          @i_num = @w_error, 
          @i_msg = @w_msg
     
    return @w_error
END

GO

