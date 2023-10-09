/************************************************************************/
/*   Stored procedure:     sp_despacho_sms_ins                      	*/
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         Alexander Inca	                            */
/*   Fecha de escritura:   Ago. 2020                                    */
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
/* Procedimiento que obtiene la información del cliente para el envío   */
/* del sms																*/
/************************************************************************/
/*                              CAMBIOS                                 */
/*      FECHA         AUTOR         CAMBIO                              */
/*   AGO-11-2020      AIN           Versión incial                      */
/*   FEB-17-2022      SRO           Requerimiento 158566                */
/************************************************************************/
use cobis
go

if exists (select 1 from sysobjects where name = 'sp_despacho_sms_ins')
   drop proc sp_despacho_sms_ins
go

create proc sp_despacho_sms_ins
   @i_id_plantilla       varchar(10),
   @i_operacion          char(1),
   @i_cliente            varchar(70) = null,
   @i_bloque             int = null,
   @i_valid_buc          char(1)='S'

as

declare
@w_sp_name               varchar(64),
@w_fecha_envio           datetime,
@w_id_customer_vendor    int,
@w_id_subtp_evento       int,
@w_error                 int,
@w_msg                   varchar(150),
@w_total_registros       int,
@w_codigo_variable       varchar(10),
@w_base                  varchar(20), 
@w_tabla                 varchar(20),
@w_columna               varchar(20),
@w_condicion             varchar(20),
@w_respuesta             varchar(50),
@sql                     varchar(1000),
@w_key_tabla             varchar(25),
@w_tipo_tabla            varchar(25),
@w_buc_cliente           varchar(20),
@w_eliminar              char(1)

select @w_sp_name = 'sp_despacho_sms_ins'
print 'se ejecuto el sp' + @w_sp_name

if @i_operacion = 'P' -- Operacion para obtener los datos de la plantilla
begin
   print  'Ingreso a la operacion P'
   -- Se obtiene los datos de la plantilla
   if(@i_valid_buc = 'S')
   begin 
      select @w_buc_cliente = (select en_banco from cobis..cl_ente where en_ente = @i_cliente) 
   end
   else
   begin
      select @w_buc_cliente = '-1'
   end

   select 'PLANTILLA'   = ps_id_plantilla,
          'VENDOR'      = ps_id_customer_vendor,
          'EVENTO'      = ps_id_subtp_evento,
          'NOTIFICACION'= ps_id_notificacion,
          'BUC'         = convert(varchar(20),@w_buc_cliente)
   from ns_plantilla_sms 
   where ps_id_plantilla = @i_id_plantilla
   if @@rowcount = 0  
   begin
      select @w_error = 70011018
      select @w_msg = 'No existe datos para la plantilla'
      goto ERROR
   end
    
   return 0 
end
 
if @i_operacion='Q' -- Operacion para obtener las variables 
begin
   print 'Ingreso a la operacion Q'
   if @i_cliente is not null and @i_bloque is not null and @i_id_plantilla is not null
   begin
      -- Se crea tabla temporal para guardar la información del select dinámico
      CREATE TABLE #ns_variables (v_key varchar(25), v_valor varchar(150),v_tipo varchar(25))
      
      select dp_codigo
      into #ns_detalle_plantilla
      from ns_detalle_plantilla
      where dp_id_plantilla = @i_id_plantilla   
      and   dp_id_bloque    = @i_bloque
      
      select @w_total_registros = count(1) 
      from #ns_detalle_plantilla
   
      while @w_total_registros > 0
      begin
         select top 1 @w_codigo_variable = dp_codigo 
         from #ns_detalle_plantilla
         
         select 
		 @w_base       = dmd_base,    
         @w_tabla      = dmd_tabla, 
         @w_columna    = dmd_columna,
         @w_condicion  = dmd_condicion,
	     @w_eliminar   = dmd_eliminar			
         from ns_datos_mensaje_detalle       
         where dmd_codigo =  @w_codigo_variable
         
         select @w_key_tabla = dm_item, 
                @w_tipo_tabla = dm_tipo
         from ns_datos_mensaje
         where dm_codigo = @w_codigo_variable
         
         select @sql = 'declare @w_key varchar(25), 
                       @w_tipo varchar(25),
                       @w_valor nvarchar(150)
         select @w_key = ''' +  @w_key_tabla+'''
         select @w_tipo = ''' +  @w_tipo_tabla+''''
         select @sql = @sql + ' select top 1 @w_valor = '+ @w_columna +' from ' +@w_base +'..'+ @w_tabla+ ' where ' + @w_condicion + ' = '+  convert(varchar,'''' + @i_cliente + '''') + ' and ' + @w_condicion + ' is not null'
         select @sql = @sql + ' insert into #ns_variables (v_key,v_valor,v_tipo) values (@w_key,@w_valor,@w_tipo)'
         --print @sql
         exec (@sql)
         if @@error <> 0
         begin
            print 'Error al insertar en la tabla'
            return @@error
         end
         
		 
		 if @w_eliminar = 'S' begin
		    declare @w_eliminar_sql varchar(1000)
			select @w_eliminar_sql = 'delete '+ @w_base +'..'+ @w_tabla + ' where ' + @w_condicion + ' = '+ convert(varchar,'''' + @i_cliente + '''')
			exec (@w_eliminar_sql)
			
			if @@error <> 0
            begin
               print 'Error al eliminar los datos de la tabla '+@w_base +'..'+ @w_tabla
               return @@error
            end
		 end
		 
         delete from #ns_detalle_plantilla 
         where dp_codigo = @w_codigo_variable
         
         select @w_total_registros = count(1) 
         from #ns_detalle_plantilla
               
   end
   select 'KEY'   = v_key,
          'VALOR' = v_valor,
          'TIPO'  = v_tipo
   from #ns_variables
   
end
   
   return 0
end


ERROR:
exec cobis..sp_cerror 
@t_debug = 'N', 
@t_file = null,
@t_from = @w_sp_name,
@i_num  = @w_error,
@i_msg  = @w_msg
return @w_error      

go