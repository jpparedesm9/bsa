/************************************************************************/
/*   Archivo:              sp_batch_lista_negra.sp                       */
/*   Stored procedure:     sp_batch_lista_negra                          */
/*   Base de datos:        cobis                                         */
/*   Producto:             Clientes                                      */
/*   Disenado por:         PXSG                                         */
/*   Fecha de escritura:   24/11/2017                                   */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                                PROPOSITO                             */
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*      24/11/2017     PXSG             Emision Inicial                 */
/*                                                                      */
/************************************************************************/
USE cobis 

GO

IF OBJECT_ID ('dbo.sp_batch_lista_negra') IS NOT NULL
	DROP PROCEDURE dbo.sp_batch_lista_negra
GO

create proc sp_batch_lista_negra (
   -----------------------------------------
   --Variables de la info del cliente
   -----------------------------------------
   @i_param1                      VARCHAR(255) = null,
   @i_param2                      VARCHAR(255) = null,
   @i_param3                      DATETIME     = null,
   @i_operacion                   char(1)       = null,
   @i_modo                        char(1)       = null,  -- modo en la que quiero que se llena la tabla temporal de clientes  
   @i_fecha_proceso               DATETIME     = null,
   @s_ssn                         int           = null,
   @s_user                        login         = null,
   @s_sesn                        int           = null,
   @s_term                        varchar(30)   = null,
   @s_date                        datetime      = null,
   @s_srv                         varchar(30)   = null,
   @s_lsrv                        varchar(30)   = null,
   @s_rol                         smallint      = null,
   @s_ofi                         smallint      = null,
   @s_org                         char(1)       = null,
   @t_debug                       char(1)       = 'N',
   @t_file                        varchar(14)   = null,
   @t_from                        varchar(32)   = null,
   @t_trn                         int           = null,
   @i_transaccion                 char(1)       = 'S',   -- Transaccion que se va a aplicar
   @i_oficial                     int           = NULL,
   @o_resultado1                  smallint    = NULL 

   
)
as
declare
   -----------------------------------------
   --Variables de info del cliente
   -----------------------------------------              
   @w_sp_name                       varchar(32),          -- Nombre del store procedure de la info del cliente
   @w_datetime                      datetime,             -- Variable para insertar la fecha
   @w_num_error                     int , -- Numero de error que se envia al store procedure sp_cerror
   @w_en_ente                       INT,    -- codigo del cliente 
   @w_cli_nombres                   VARCHAR(100),
   @w_cli_apellidos                 VARCHAR(100),
   @w_cli_fecha_nac                 DATETIME,
   @w_cli_fecha_nac_char            VARCHAR(10),         
   @w_n_conicidencias               INT,
   @w_ln_tipo_lista                 VARCHAR(10),
   @w_path_destino                  varchar(200),
   @w_mes                           varchar(2),
   @w_dia                           varchar(2),
   @w_anio                          varchar(4),
   @w_fecha_r                       varchar(10),
   @w_file_cl_in                    varchar(140),
   @w_file_cl                       varchar(40),
   @w_s_app                         varchar(40),
   @w_bcp                           varchar(2000),
   @w_file_cl_log                   varchar(140),
   @w_origen                        VARCHAR(32),
   @w_return                        INT,
   @w_msg                           varchar(1200),
   @w_cmd                           varchar(5000),
   @w_destino                       varchar(255),
   @w_errores                       varchar(255),
   @w_comando                       varchar(6000),
   @w_columna                       varchar(50),
   @w_col_id                        int,
   @w_cabecera                      varchar(5000),
   @w_error                          int, 
   @w_destino2                     varchar(255),
   @w_path                         varchar(255),
   @w_mensaje                      varchar(100),
   @w_date_proceso                  varchar(10),
   @w_mes_cli                       varchar(2),
   @w_dia_cli                       varchar(2),
   @w_anio_cli                      varchar(4),
   @w_fecha_r_cli                   varchar(10)
   
	

 
   
-----------------------------------------
--Inicializacion de Variables
-----------------------------------------
select @w_sp_name               = 'sp_batch_lista_negra',
       @w_datetime              = convert(varchar,@s_date,101) + ' ' + convert(varchar,getdate(),108)     

SELECT 
   @i_operacion                   = @i_param1,
   @i_modo                        = @i_param2,
   @i_fecha_proceso               = @i_param3
   
   
if @i_fecha_proceso is null return 0   

select @w_date_proceso = convert(VARCHAR(30),@i_fecha_proceso,103)
select @w_dia  = substring(@w_date_proceso,1,2)
select @w_mes  = substring(@w_date_proceso,4,2)
select @w_anio = substring(@w_date_proceso,7,4)
select @w_fecha_r  = @w_dia+'/'+  @w_mes +'/'+@w_anio 
   
if @i_operacion = 'Q'
BEGIN

 create table #tabla_cli_lista_negra_info(
 				   w_fecha_proceso  VARCHAR(10),
                   w_nombres_completos	 	VARCHAR(300),
                   w_fecha_nac        VARCHAR(10),
                   w_tipo_lista       VARCHAR(10)
                   )
                   
 IF(@i_modo ='1')-- bacth para todos los clientes 
	 BEGIN
		 declare Cursor_Clientes cursor FOR
		 	 SELECT  en_ente
					 from cobis..cl_ente 
				 --    WHERE en_ente IN (1723,1724,1,2)
					order by en_ente	   
						
			open Cursor_Clientes  
			fetch next from Cursor_Clientes into @w_en_ente	
			while @@fetch_status = 0
			   BEGIN
			   
			     PRINT'ENTE'+convert(VARCHAR(50),@w_en_ente)
			     
			    EXEC cob_credito..sp_li_negra_cliente @i_ente=@w_en_ente, @o_resultado=@o_resultado1 OUT
			    
			    SELECT @o_resultado1
                PRINT'---+++'+ convert(VARCHAR(50),@o_resultado1)
                 
                IF(@o_resultado1=3)
                BEGIN
                SELECT
		         @w_cli_nombres   =lower(replace(isnull(en_nombre,'')+' '+isnull( p_s_nombre,''),' ', '')),
		         @w_cli_apellidos =lower(replace(isnull(p_p_apellido,'')+' '+isnull(p_s_apellido,''),' ', '')),
		         @w_cli_fecha_nac =p_fecha_nac
		        FROM cobis..cl_ente  WHERE en_ente=@w_en_ente
		        
		          SELECT @w_cli_fecha_nac_char  = CONVERT(VARCHAR(30), @w_cli_fecha_nac, 103)

                  PRINT 'fechanac-varchar:'+@w_cli_fecha_nac_char
 				  select @w_dia_cli  = substring(@w_cli_fecha_nac_char,1,2)
 				  select @w_mes_cli  = substring(@w_cli_fecha_nac_char,4,2)
 				  select @w_anio_cli = substring(@w_cli_fecha_nac_char,7,4)
 				  select @w_fecha_r_cli  = @w_dia_cli+'/'+  @w_mes_cli +'/'+@w_anio_cli 
		        
		        SELECT @w_ln_tipo_lista=ln_tipo_lista FROM cob_credito..cr_lista_negra 
                WHERE lower(replace(ln_nombre,' ', ''))              =@w_cli_nombres
                AND   lower(replace(isnull(ln_apellidos,''),' ', ''))=isnull( @w_cli_apellidos,'')
                
                insert into #tabla_cli_lista_negra_info
	     		select 
	     		 'fecha de proceso' = @w_fecha_r,
	     		 'nombres_completos'=isnull(en_nombre,'')+' '+isnull( p_s_nombre,'')+' '+isnull(p_p_apellido,'')+' '+isnull(p_s_apellido,''),
	     		 'fecha nac'=isnull(@w_fecha_r_cli,''),
	     		 'tipo lista'=isnull(@w_ln_tipo_lista,'')
	     		 FROM cobis..cl_ente WHERE en_ente =@w_en_ente 
	     		 
                
                END
                
			    
			     fetch next from Cursor_Clientes into @w_en_ente								
			   END	 
			   			
		    close Cursor_Clientes
		        
		    deallocate Cursor_Clientes  
   
		    
		 PRINT 'lista #tabla_cli_lista_negra_info'
         
		 SELECT * FROM #tabla_cli_lista_negra_info
         
   --Elimino datos de la tabla temporal
    TRUNCATE TABLE cobis..cl_listas_negras_tmp   
     --copio los datos de la tabla temporal tempral a la temporal fisica 
    INSERT INTO cobis..cl_listas_negras_tmp (fecha_proceso, nombres_completos, fecha_nac, tipo_lista)
    SELECT w_fecha_proceso, w_nombres_completos, w_fecha_nac, w_tipo_lista FROM #tabla_cli_lista_negra_info
    
   
	----------------------------------------
   --	Generar Archivo Plano
	----------------------------------------
	
	select @w_s_app = pa_char
	 from cobis..cl_parametro
	 where pa_producto = 'ADM'
	 and   pa_nemonico = 'S_APP'
	
	
	SELECT @w_path = pp_path_destino
	 from cobis..ba_path_pro
	 where pp_producto = 2   
		
	select @w_cmd = @w_s_app + 's_app bcp -auto -login cobis..cl_listas_negras_tmp out '
	
	select @w_destino  = @w_path + 'listas_negras_' + replace(convert(varchar, @i_fecha_proceso, 102), '.', '') + '_' + replace(convert(varchar, getdate(), 108), ':', '') + '.txt',
	       @w_destino2 = @w_path + 'lineas_listas_negras_'      + replace(convert(varchar, @i_fecha_proceso, 102), '.', '') + '_' + replace(convert(varchar, getdate(), 108), ':', '') + '.txt',
	       @w_errores  = @w_path + 'listas_negras__' + replace(convert(varchar, @i_fecha_proceso, 102), '.', '') + '_' + replace(convert(varchar, getdate(), 108), ':', '') + '.err'
	
	select @w_comando = @w_cmd + @w_path + 'listas_negras -b5000 -c -T -e ' + @w_errores + ' -t"\t" ' + '-config ' + @w_s_app + 's_app.ini'

	exec @w_error = xp_cmdshell @w_comando
	
	if @w_error <> 0 begin
	   select
	   @w_error = 2108046,
	   @w_mensaje = 'Error generando Reporte de Provisiones'
	   goto ERROR
	end
	
	
	----------------------------------------
	--Generar Archivo de Cabeceras
	----------------------------------------
	select @w_col_id   = 0,
	       @w_columna  = '',
	       @w_cabecera = ''
	       
	while 1 = 1 begin
	   set rowcount 1
	    select @w_columna = replace(c.name, 'listas_negras', ''),
	         @w_col_id  = c.colid
	  	 from cobis..sysobjects o, cobis..syscolumns c
	  	 where o.id    = c.id
	  	 and   o.name  = 'cl_listas_negras_tmp'
	  	 and   c.colid > @w_col_id
	  	 order by c.colid
	    
	   if @@rowcount = 0 begin
	      set rowcount 0
	      break
	   end
	
	   select @w_cabecera = @w_cabecera + @w_columna + char(9)
	end
	
	--Escribir Cabecera
	select @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_destino2
	PRINT '@w_comando'+ convert(VARCHAR(300),@w_comando)
	
	exec @w_error = xp_cmdshell @w_comando
	
	if @w_error <> 0 begin
	   select
	   @w_error = 2108048,
	   @w_mensaje = 'Error generando Archivo de Cabeceras'
	   goto ERROR
	end
	
	select @w_comando = 'copy ' + @w_destino2 + ' + ' + @w_path + 'listas_negras ' + @w_destino
	PRINT '@w_comando'+ convert(VARCHAR(300),@w_comando)
	
	exec @w_error = xp_cmdshell @w_comando
	
	if @w_error <> 0 begin
	   select
	   @w_error = 2108049,
	   @w_mensaje = 'Error generando Archivo de Lineas mas cabeceras'
	   goto ERROR
	end
	     	      
		  return 0   
	    			    
	 END-- fin @i_modo = '1'
END	 --fin @i_operacion = 'Q'
 
return 0  
 
ERROR:
     exec cobis..sp_errorlog 
     @i_fecha        = @i_fecha_proceso,
     @i_error        = @w_error,
     @i_usuario      = @s_user ,
     @i_tran         = 26004,
     @i_descripcion  = @w_mensaje,
     @i_tran_name    =null,
     @i_rollback     ='S'
      return @w_error


GO
