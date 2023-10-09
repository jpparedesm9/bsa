use cob_pac
go

IF OBJECT_ID ('dbo.sp_buscar_custodia_busin') IS NOT NULL
	DROP PROCEDURE dbo.sp_buscar_custodia_busin
go

CREATE PROCEDURE [dbo].[sp_buscar_custodia_busin] (
   @s_ssn                int      		= null,
   @s_date               datetime 		= null,
   @s_user               login    		= null,
   @s_term               descripcion 	= null,
   @s_corr               char(1)  		= null,
   @s_ssn_corr           int      		= null,
   @s_ofi                smallint  		= null,
   @t_rty                char(1)  		= null,
   @t_trn                smallint 		= null,
   @t_debug              char(1)  		= 'N',
   @t_file               varchar(14) 	= null,
   @t_from               varchar(30) 	= null,
   @i_operacion          char(1)  		= null,
   @i_modo               smallint 		= null,
   @i_filial             tinyint  		= null,
   @i_sucursal           smallint  		= null,
   @i_tipo               varchar(64)  	= null,
   @i_estado             catalogo  		= null,
   @i_formato_fecha      int 			= null,
   @i_fecha_ingreso1     datetime 		= null,
   @i_fecha_ingreso2     datetime 		= null,
   @i_cliente            int 			= null,
   @i_oficial            smallint 		= null,
   @i_codigo_externo     varchar(64) 	= null,
   @i_codigo_externo2    varchar(64) 	= '',
   @i_moneda			 INT			= NULL,
   @i_cuantia			 varchar(1)		= NULL,
   @i_caracter			 VARCHAR(1)		= NULL,
   @i_admisibilidad		 VARCHAR(1)		= NULL,
   @i_compartida		 VARCHAR(1)		= NULL	
)
as

declare
   @w_today              datetime,
   @w_sp_name            varchar(32),
   @w_fecha_ingreso1     datetime,  
   @w_fecha_ingreso2     datetime,
   @w_tipo_personal      char(10)

select @w_today   = convert(varchar(10),getdate(),101),
       @w_sp_name = 'sp_buscar_custodia_busin'

/* Codigos de Transacciones                                */
if (@t_trn <> 19767 and @i_operacion = 'Q') --Se aumenta para la Policia Nacional
begin
   /* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
END

IF @i_oficial = 0 SELECT @i_oficial = NULL
IF @i_tipo = '0' SELECT @i_tipo = null

if @i_operacion = 'Q'
begin

     SELECT @i_formato_fecha = isnull(@i_formato_fecha, 103)

     select @i_codigo_externo = isnull(@i_codigo_externo, ' '),		
			@w_fecha_ingreso1 = isnull(@i_fecha_ingreso1,'01/01/1900'),
			@w_fecha_ingreso2 = isnull(@i_fecha_ingreso2,'01/01/2200')

     select @w_tipo_personal = pa_char
       from cobis..cl_parametro
      where pa_producto = 'GAR'
        and pa_nemonico = 'GPE' 
       		
     set rowcount 15
     if @i_cliente is null
     begin
          select  	'codigo_externo' 	=  cu_codigo_externo,
					'tipo' 				=  cu_tipo,
					'descripcion'    	=  substring(tc_descripcion,1,35),
					'abierta_cerrada'	=  cu_abierta_cerrada,
					'id_garante' 		=  cu_garante,
					'id_cliente' 		=  cg_ente,
					'nombre_gar' 		=  isnull(substring(b.en_nomlar,1,datalength(b.en_nomlar)),''), 		  
					'custodia' 			=  cu_custodia,
					'sucursal' 			=  cu_sucursal,
					'nombre_of'      	=  of_nombre,
					'moneda' 			=  cu_moneda,
					'valor_actual' 		=  cu_valor_actual,
					'valor_inicial' 	=  cu_valor_inicial, 	
					'fecha_avaluo' 		=  convert(varchar(10), cu_fecha_avaluo,@i_formato_fecha),	
					'estado' 			=  cu_estado,
						--'usuario_crea'		=  cu_usuario_crea,
					'usuario_crea' = (select  fu_nombre
   										from cobis..cl_funcionario,
        									cobis..cc_oficial
   									where oc_funcionario = fu_funcionario
									AND oc_funcionario = cg_oficial),
					'esPersonal'    	=  case when cu_tipo = @w_tipo_personal then 'S' else  'N' end,
					'nombre_cli'        =  isnull(substring(a.en_nomlar,1,datalength(a.en_nomlar)),''),
					'fecha_vencimiento'	=  convert(varchar(10), cu_fecha_vencimiento,@i_formato_fecha)
		   from  cob_custodia..cu_custodia WITH (index (cu_custodia_Key))LEFT JOIN cobis..cl_ente b ON cu_garante = b.en_ente  ,
				 cob_custodia..cu_cliente_garantia with(index (cu_cliente_garantia_Key)) LEFT JOIN cobis..cl_ente a ON cg_ente = a.en_ente ,
                 cob_custodia..cu_tipo_custodia,
                 cobis..cl_oficina
				-- cobis..cl_ente a,				
				 --cobis..cl_ente b
           where (cu_filial   = isnull(@i_filial,cu_filial)) 
             and (cu_sucursal = @i_sucursal or @i_sucursal is null)
             and (cu_sucursal = of_oficina) 
             and (cu_tipo     = @i_tipo or @i_tipo is null) 
             and (cu_tipo     = tc_tipo) 
			 and (cu_estado   = @i_estado or @i_estado is null) 
             and (cg_oficial  = @i_oficial or @i_oficial is null)       
			 and (cu_fecha_ingreso >= @w_fecha_ingreso1) 
			 and (cu_fecha_ingreso <= @w_fecha_ingreso2) 
             and (cg_codigo_externo = cu_codigo_externo)
			 and (cu_codigo_externo like '%'+@i_codigo_externo2+'%')
             and cu_codigo_externo > @i_codigo_externo
             AND (cu_moneda	= @i_moneda OR @i_moneda IS null)
             AND (cu_abierta_cerrada = @i_caracter OR @i_caracter IS NULL)
             AND (cu_cuantia = @i_cuantia OR @i_cuantia IS NULL)             
             AND (cu_clase_custodia = @i_admisibilidad OR @i_admisibilidad IS NULL)
             AND (cu_compartida = @i_compartida OR @i_compartida IS null)
             AND cg_principal = 'D'             
             --AND cu_valor_actual > 0
			 --and cu_garante *= b.en_ente 
             --and cg_ente *= a.en_ente
        order by cg_codigo_externo
     if @@rowcount = 0
     begin
          exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file, 
               @t_from  = @w_sp_name,
               @i_num   = 1901003
          return 1 
     end
     end
     else
     begin	
          select  	'codigo_externo' 	=  cu_codigo_externo,
					'tipo' 			    =  cu_tipo,
					'descripcion'    	=  substring(tc_descripcion,1,35),
					'abierta_cerrada'	=  cu_abierta_cerrada,
					'id_garante' 		=  cu_garante,
					'id_cliente' 		=  cg_ente,
					'nombre_gar' 		=  isnull(substring(b.en_nomlar,1,datalength(b.en_nomlar)),''), 		  
					'custodia' 			=  cu_custodia,
					'sucursal' 			=  cu_sucursal,
					'nombre_of'      	=  of_nombre,
					'moneda' 			=  cu_moneda,
					'valor_actual' 		=  cu_valor_actual,
					'valor_inicial' 	=  cu_valor_inicial, 	
					'fecha_avaluo' 		=  convert(varchar(10), cu_fecha_avaluo,@i_formato_fecha),	
					'estado' 			=  cu_estado,
					--'usuario_crea'		=  cu_usuario_crea,
					'usuario_crea' = (select  fu_nombre
   										from cobis..cl_funcionario,
        									cobis..cc_oficial
   									where oc_funcionario = fu_funcionario
									AND oc_funcionario = cg_oficial),
					'esPersonal'    	=  case when cu_tipo = @w_tipo_personal then 'S' else  'N' end,
					'nombre_cli'        =  isnull(substring(a.en_nomlar,1,datalength(a.en_nomlar)),''),
					'fecha_vencimiento'	=  convert(varchar(10), cu_fecha_vencimiento,@i_formato_fecha)
			from cob_custodia..cu_cliente_garantia WITH (index (i_cu_cliente_i2)) LEFT JOIN  cobis..cl_ente a ON  cg_ente = a.en_ente   ,
				 cob_custodia..cu_custodia WITH (index (cu_custodia_Key))LEFT JOIN   cobis..cl_ente b ON cu_garante = b.en_ente ,
				 cob_custodia..cu_tipo_custodia,
                 cobis..cl_oficina
				-- cobis..cl_ente a,				
			     --cobis..cl_ente b
           where (cg_ente = isnull(@i_cliente,cg_ente)) 
             and (cu_filial   = isnull(@i_filial,cu_filial))              
             and (cu_sucursal = @i_sucursal or @i_sucursal is null) 
             and (cu_sucursal = of_oficina) 
             and (cu_tipo = @i_tipo or @i_tipo is null) 
             and (cu_tipo = tc_tipo) 
			 and (cu_estado   = @i_estado or @i_estado is null) 
             and (cg_oficial  = @i_oficial or @i_oficial is null)              
			 and (cu_fecha_ingreso >= @w_fecha_ingreso1) 
			 and (cu_fecha_ingreso <= @w_fecha_ingreso2) 
       and (cg_codigo_externo = cu_codigo_externo)
			 and (cu_codigo_externo like '%'+@i_codigo_externo2+'%')
			 and cg_codigo_externo > @i_codigo_externo 
			 AND (cu_moneda	= @i_moneda OR @i_moneda IS null)
             AND (cu_abierta_cerrada = @i_caracter OR @i_caracter IS NULL)
             AND (cu_cuantia = @i_cuantia OR @i_cuantia IS NULL)             
             AND (cu_clase_custodia = @i_admisibilidad OR @i_admisibilidad IS NULL)
             AND (cu_compartida = @i_compartida OR @i_compartida IS null)
             --AND cg_principal = 'D'             
             --AND cu_valor_actual > 0
			-- and cu_garante *= b.en_ente 
            -- and cg_ente *= a.en_ente 
             order by cg_codigo_externo
			
			if @@rowcount = 0
			begin
         exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file, 
                    @t_from  = @w_sp_name,
                    @i_num   = 1901003
               return 1 
			end
     end
end

return 0
GO

