

use cob_conta_super
go
/*************************************************************/
/*   ARCHIVO:         	sp_in_fac.sp                         */
/*   NOMBRE LOGICO:   	sp_lee_inter_factura                 */
/*   PRODUCTO:        		CARTERA                          */
/*************************************************************/
/*                     IMPORTANTE                            */
/*   Esta aplicacion es parte de los  paquetes bancarios     */
/*   propiedad de MACOSA S.A.                                */
/*   Su uso no autorizado queda  expresamente  prohibido     */
/*   asi como cualquier alteracion o agregado hecho  por     */
/*   alguno de sus usuarios sin el debido consentimiento     */
/*   por escrito de MACOSA.                                  */
/*   Este programa esta protegido por la ley de derechos     */
/*   de autor y por las convenciones  internacionales de     */
/*   propiedad intelectual.  Su uso  no  autorizado dara     */
/*   derecho a MACOSA para obtener ordenes  de secuestro     */
/*   o  retencion  y  para  perseguir  penalmente a  los     */
/*   autores de cualquier infraccion.                        */
/*************************************************************/
/*                     PROPOSITO                             */
/*   Este procedimiento permite los datos del xml            */
/*   de Interfactura  							             */
/*************************************************************/
/*                     MODIFICACIONES                        */
/*   FECHA         AUTOR               RAZON                 */
/*   08-Marz-2018  PXSG                Emision Inicial.      */
/*   06-Junio-2019 PXSG                Se realiza cambios a  */    
/*                                     la fecha del estado   */ 
/*                                     cuenta caso 118918.   */
/*   15-Julio-2019                     Se realiza cambios    */
/*                                     para estados de cuenta*/
/*                                     LCR req 115931        */
/* 12/Mar/2020    AGO             #123672 --FASE 2           */
/* 05/Jul/2021    DCU                  Ajuste Req. 123672    */  
/*************************************************************/


IF OBJECT_ID ('dbo.sp_lee_inter_factura') IS NOT NULL
	DROP PROCEDURE dbo.sp_lee_inter_factura
GO

CREATE PROCEDURE sp_lee_inter_factura (	
	@i_operacion		        varchar(60)		= null,
	@i_in_fecha  		        DATETIME		= null,
    @i_in_banco                 varchar(15)		= null,
    @i_in_cliente_rfc           varchar(30)		= null,
    @i_in_email                 varchar(254)	= null,
    @i_in_folio_fiscal          varchar(60)		= null,
    @i_in_certificado           varchar (30)	= null,
    @i_in_sello_digital         varchar(1500)	= null,
    @i_in_sello_sat             varchar(1500)	= null,
    @i_in_num_se_certificado    varchar(30)		= null,
    @i_in_fecha_certificacion   DATETIME	    = null,
    @i_in_cadena_cer_dig_sat    varchar(1500)	= null,
    @i_in_nombre_archivo        varchar(100)	= null,
    @i_in_get_process_Date      varchar(300)	= null,
	@i_in_rfc_emisor            varchar (30)    = null,
	@i_in_estd_timb             char (1)        = null,
	@i_in_monto_fac             varchar (30)    = null,
	@i_in_met_fact              varchar(5)      = null,
	@t_debug                    char(1) 		= 'N',
	@t_file                     varchar(14)		= null,
	@t_from                     varchar(32) 	= null,
	@t_show_version             bit             = 0
)
as 

DECLARE
    @w_sp_name           		      varchar(32),
    @w_ente              		      int,
    @w_mail_cliente      		      varchar(254),
    @w_codigo            		      int,
    @w_num_error         		      int,
    @w_error             		      int,
    @w_observacion       		      varchar(300),
    @w_fin_mes	   		 		      datetime,
    @w_fecha_Timbre				      datetime,
    @w_s_app                          varchar(40),
    @w_path                           varchar(255),
    @w_cmd                            varchar(5000),
    @w_destino                        varchar(255),
    @w_errores                        varchar(255),
    @w_destino2                       varchar(255),
    @w_comando                        varchar(6000),
    @w_mensaje                        varchar(100),
    @w_columna                        varchar(50),
    @w_col_id                         int,
    @w_cabecera                       varchar(5000),
    @w_ano                            int ,
    @w_correo_rfc_error               varchar(64),
    @w_fecha_proceso                  datetime,
    @w_primer_dia_mes                 datetime,
    @w_fecha_generacion_estado_cuenta datetime,
    @w_buc_cliente                    varchar(20),
    @w_rfc_generico                   varchar(30),
    @w_feriado                        char(1),
    @w_fecha_hab                      datetime,
    @w_ciudad                         smallint,
    @w_estado                         char(1),
    @w_toperacion                     varchar(10),
    @w_msg                            varchar(100),
	@w_nombre_archivo                 varchar(100)

-------------------------------- VERSIONAMIENTO DE SP --------------------------------
if @t_show_version = 1
begin
    print 'Stored procedure sp_lee_inter_factura, Version 1.0.0'
    return 0
end
--------------------------------------------------------------------------------------

/*  Inicializacion de Variables  */
select  @w_sp_name = 'sp_lee_inter_factura'



SET @w_feriado='S'
SET @w_fecha_hab=format(dateadd(ss,-86399,@i_in_fecha), 'yyyy-MM-ddTHH:mm:ss')--PXSG
set @w_estado='P'

 --obtiene parametro DISTRITO FERIADO NACIONAL
select @w_ciudad = pa_smallint 
	from cobis..cl_parametro 
	where pa_nemonico = 'CFN' 
	AND pa_producto = 'ADM'

while @w_feriado = 'S'
BEGIN

if exists (select 1 from cobis..cl_dias_feriados where df_fecha = @w_fecha_hab and df_ciudad = @w_ciudad)
    BEGIN
    PRINT '@w_fecha_feriado'+convert (varchar(50),@w_fecha_hab)
        select @w_fecha_hab = dateadd(dd,-1, @w_fecha_hab)    
    END 
ELSE
     BEGIN
       select @w_feriado = 'N'
     END

END
 
 PRINT '@w_fecha_hab'+convert (varchar(50),@w_fecha_hab)
 
 
 select top 1 @w_correo_rfc_error   = valor  
        from cobis..cl_catalogo 
        where tabla = (select codigo 
                        from cobis..cl_tabla 
                        where tabla = 'cr_correo_rfc_Global')
-- Parametro rfc Generico                         
select @w_rfc_generico = pa_char
from cobis..cl_parametro
where pa_producto = 'REC'
and pa_nemonico = 'RFCGEN' 

if @i_operacion = 'I'
BEGIN
     print 'Ingreso a la operacion I'
     -- se busca ultimo secuencial
     /*exec @w_num_error = cobis..sp_cseqnos
     @t_debug     = @t_debug,
     @t_file      = @t_file,
     @t_from      = @w_sp_name,
     @i_tabla     = 'sb_ns_estado_cuenta',
     @o_siguiente = @w_codigo out
        
       if @w_num_error <> 0
        begin
            select @w_error = 2101007 
            goto ERROR
        end*/
          
   set @w_observacion=''

    set @w_fin_mes      = @w_fecha_hab
    
    set @w_fecha_Timbre = format(@i_in_fecha_certificacion, 'yyyy-MM-ddTHH:mm:ss')
    
    --Obtengo el ente y buc del cliente
    select top 1  
           @w_ente        = en_ente,
           @w_buc_cliente = en_banco 
    from   cobis..cl_ente 
    where  en_nit=@i_in_cliente_rfc
	
	print @w_ente
	print @w_buc_cliente
  
--Obtengo el correo del cliente
    select top 1 
           @w_mail_cliente=di_descripcion 
    from   cobis..cl_direccion 
    where  di_ente=@w_ente  
    and    di_tipo='CE'
    
    --Obtengo validacion para rfc Generico
    if(rtrim(@i_in_cliente_rfc)=rtrim(@w_rfc_generico))
    begin
       select @w_ente        = isnull(en_ente,0) , 
              @w_buc_cliente = isnull( en_banco,0)
       from cob_cartera..ca_operacion,cobis..cl_ente
       where op_banco=@i_in_banco
       and op_cliente=en_ente
    
        select top 1 
               @w_mail_cliente=isnull(di_descripcion,'irios@santander.com.mx') 
        from   cobis..cl_direccion 
        where  di_ente=@w_ente  
        and    di_tipo='CE'
       /*set @i_in_banco='000000000000'
       select @w_fecha_proceso=fp_fecha FROM cobis..ba_fecha_proceso
       print  '@w_fecha_proceso.. '+ convert(VARCHAR(50),@w_fecha_proceso)
       select @w_primer_dia_mes = dateadd(dd, 1-datepart(dd, @w_fecha_proceso  ), @w_fecha_proceso )
       print  '@w_primer_dia_mes.. '+ convert(VARCHAR(50),@w_primer_dia_mes) 
       select @w_fecha_generacion_estado_cuenta=max(do_fecha) FROM  cob_conta_super..sb_dato_operacion WHERE  do_fecha < @w_primer_dia_mes 
       print  '@w_primer_dia_mes.. '+ convert(VARCHAR(50),@w_fecha_generacion_estado_cuenta)
       set  @i_in_fecha=isnull(@w_fecha_generacion_estado_cuenta,@w_fecha_proceso)
       set @w_fin_mes= format(@i_in_fecha, 'yyyy-MM-ddTHH:mm:ss')*/
    end
    
    select @w_toperacion=op_toperacion 
          from cob_cartera..ca_operacion 
          where op_banco=@i_in_banco
    if(@w_toperacion='REVOLVENTE') 
    begin
    set @w_estado='X'
    end     
 
    --Validaciones de Campos
    
   -- SET @w_mail_cliente='irios@santander.com.mx'
    
    if((@w_mail_cliente IS  NULL) OR (@w_mail_cliente=''))
    begin
        set  @w_observacion='No existe Mail.'
    end
    
    if((@i_in_banco IS  NULL) OR (@i_in_banco=''))
    begin
        set @w_observacion=@w_observacion+'No existe op Banco.'
    end
    
    if((@i_in_fecha IS  NULL) OR (@i_in_fecha=''))
    begin
        set  @w_observacion=@w_observacion+'No existe Fecha.'
    end
    
    if((@i_in_folio_fiscal IS  NULL) OR (@i_in_folio_fiscal=''))
    begin
        set @i_in_folio_fiscal='No existe Dato Folio Fiscal.'
    end
    
    if((@i_in_certificado IS  NULL) OR (@i_in_certificado=''))
    begin
        set @i_in_certificado='No existe Dato Certificado.'
    end
    
    if((@i_in_sello_digital IS  NULL) OR (@i_in_sello_digital=''))
    begin
        set @i_in_sello_digital='No existe Dato Sello Digital.'
    end
    
    if((@i_in_sello_sat IS  NULL) OR (@i_in_sello_sat=''))
    begin
        set @i_in_sello_sat='No existe Dato Sello de SAT. '
    end
    
    if((@i_in_num_se_certificado IS  NULL) OR (@i_in_num_se_certificado=''))
    begin
        set @i_in_num_se_certificado='No existe Dato Num Serie Certificado'
    end
    
    if((@i_in_cadena_cer_dig_sat IS  NULL) OR (@i_in_cadena_cer_dig_sat=''))
    begin
        set @i_in_cadena_cer_dig_sat='No existe Dato Cadena Original Certificado Digital SAT'
    end
	
	if((@w_mail_cliente  IS NULL) OR (@w_mail_cliente=''))
	begin
	   -- Se debe agregar el correo como parametro
	   set @w_mail_cliente='normatividad_tuiio@gmail.com'
	end
	
	print 'correo: ' + @w_mail_cliente
    
     if((@i_in_banco is null ) OR (@i_in_banco ='' )  OR (@i_in_fecha IS null) OR (@i_in_fecha =''))
        begin
		
		    print @w_mail_cliente
			print @i_in_banco
			print @i_in_fecha
			
            select @w_error = 70201 -- ERROR EN INGRESO DE ESTADO DE CUENTA
            select @w_error
            goto ERROR
            
        end
    select @w_nombre_archivo = @i_in_nombre_archivo
	print 'Nombre archivo: ' + @w_nombre_archivo 
	
	-- Quitar extensión del nombre del archivo
	select @i_in_nombre_archivo = substring(@i_in_nombre_archivo,0,charindex('.',@i_in_nombre_archivo))
	
	print 'Nombre archivo para actualización: ' + @i_in_nombre_archivo 
	
	if exists (select 1 from  sb_ns_estado_cuenta,
                              cob_credito..cr_resultado_xml	
	                          where num_operation = nec_banco
				              and   rx_folio_ref = in_folio_ref
	                          and   nec_banco = @i_in_banco
                              and   file_name = @i_in_nombre_archivo
				              ) 
	begin
	   print 'Ingreso a actualizar'
	
       update sb_ns_estado_cuenta set 		
	   in_fecha_xml                 = @i_in_fecha                 ,
       nec_banco                    = @i_in_banco                 ,
       nec_fecha                    = @w_fecha_hab                ,
       in_cliente_rfc               = @i_in_cliente_rfc           ,
       nec_correo                   = @w_mail_cliente             ,
       nec_estado                   = @w_estado                   ,
       in_folio_fiscal              = @i_in_folio_fiscal          ,
       in_certificado               = @i_in_certificado           ,
       in_sello_digital             = @i_in_sello_digital         ,
       in_sello_sat                 = @i_in_sello_sat             ,
       in_num_se_certificado        = @i_in_num_se_certificado    ,
       in_fecha_certificacion       = @w_fecha_Timbre             ,
       in_cadena_cer_dig_sat        = @i_in_cadena_cer_dig_sat    ,
       in_nombre_archivo            = @w_nombre_archivo           ,
       in_rfc_emisor                = @i_in_rfc_emisor            ,   
	   in_estd_timb                 = @i_in_estd_timb             ,
	   in_monto_fac                 = @i_in_monto_fac             ,
	   in_met_fact                  = @i_in_met_fact              ,
	   in_estado_pdf                = 'P'                         ,
	   in_estado_correo             = 'P'                         ,
	   in_estd_clv_co               = 'P'                         ,
	   in_fecha_procesamiento       = getdate()
       from cob_credito..cr_resultado_xml	   
	   where num_operation = nec_banco
	   and   rx_folio_ref = in_folio_ref
	   and   nec_banco = @i_in_banco
       and   file_name = @i_in_nombre_archivo
        
	   
       if @@error <> 0 begin 
          select 
		  @w_error = 702019,
          @w_msg   = 'ERROR EN ACTUALIZACION  DE ESTADO DE CUENTA'
          goto ERROR
       end
	

    end else begin 
	
	   	insert into cob_conta_super..sb_ns_estado_cuenta (
		 nec_banco            , nec_fecha              , nec_correo            ,  nec_estado          ,
         in_cliente_rfc       , in_cliente_buc         , in_folio_fiscal       , in_certificado       ,     in_sello_digital,
         in_sello_sat         , in_num_se_certificado  , in_fecha_certificacion, in_cadena_cer_dig_sat,     in_nombre_archivo, 
         in_observacion       , in_fecha_procesamiento , in_fecha_xml          , in_rfc_emisor        ,     in_estd_timb,
         in_monto_fac         , in_met_fact            , in_estado_pdf         , in_estado_correo     ,     in_estd_clv_co,
         in_grupo             ,in_nombre_cli           , in_cuota_desde        ,in_cuota_hasta        ,     in_folio_ref, 
         in_fecha_fin_mes)
         
         values 
          
   	     (@i_in_banco        ,  @w_fin_mes              , @w_mail_cliente   ,	 @w_estado,
   	      @i_in_cliente_rfc  ,  @w_buc_cliente          , @i_in_folio_fiscal ,   @i_in_certificado       ,   @i_in_sello_digital,	
   	      @i_in_sello_sat    ,  @i_in_num_se_certificado, @w_fecha_Timbre    ,   @i_in_cadena_cer_dig_sat,   @i_in_nombre_archivo, 
          @w_observacion     ,  getdate()               , @i_in_fecha        ,   @i_in_rfc_emisor        ,   @i_in_estd_timb,      
            @i_in_monto_fac    ,  @i_in_met_fact		    , 'P'                ,   'P'                     ,   'P',
            0                  ,  ''                      , 0                  , 0                         , '',
   	      @w_fecha_hab)
   	    
		
        if @@error <> 0 begin 
           select 
           @w_error = 702019,
           @w_msg   = 'ERROR EN ACTUALIZACION  DE ESTADO DE CUENTA'
           goto ERROR
        end
	
	
	end 
        
     if((@w_mail_cliente  is null) or (@w_mail_cliente='') or 
	     (@i_in_banco is null ) or (@i_in_banco ='' )  or (@i_in_fecha is null) or (@i_in_fecha =''))
       
      begin
        
        truncate table cob_conta_super..tmp_sb_xml_interfactura 
        
		insert into tmp_sb_xml_interfactura 
		values(getdate(),@i_in_nombre_archivo,@w_observacion)	  
		   
  
		   
		----------------------------------------
   		--	Generar Archivo Plano
		----------------------------------------
	
	  	select @w_s_app = pa_char
	  	from cobis..cl_parametro
	  	where pa_producto = 'ADM'
	  	and   pa_nemonico = 'S_APP'
	
	    select @w_path = pp_path_destino+'estctahist\'+ @i_in_get_process_Date+'\'+'XMLError'+'\'
	     from cobis..ba_path_pro
	     where pp_producto = 21 
	     
	    if (@@error != 0 or @@rowcount != 1)
	     begin
	        select 
	           @w_error = 724627,
	           @w_mensaje = 'ERROR CONSULTAR PATH PARA MOVER ARCHIVOS'
	     	goto ERROR
	     end 
	    	
	    select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_conta_super..tmp_sb_xml_interfactura out '
	    
	    select @w_destino  = @w_path + 'log_error_' +REPLACE(@i_in_nombre_archivo, ' ', '')+ '.txt',
	           @w_destino2 = @w_path + 'log_error_lineas_'+ REPLACE(@i_in_nombre_archivo, ' ', '')+ '.txt',
	           @w_errores  = @w_path + 'log_error__' + REPLACE(@i_in_nombre_archivo, ' ', '')+'.err'
	    
	    select @w_comando = @w_cmd + @w_path + 'log_error_contenido -b5000 -c -T -e ' + @w_errores + ' -t"\t" ' + '-config ' + @w_s_app + 's_app.ini'
        
	    exec @w_error = xp_cmdshell @w_comando
	    
	    if @w_error <> 0 
	     begin
	        select
	        @w_error = 2108046,
	        @w_mensaje = 'Error generando Log'
	        goto ERROR
	     end

       --Creacion de Archivos txt
       
       select @w_comando = 'copy ' +@w_path + 'log_error_contenido ' + @w_destino
       
          	PRINT '@w_comando'+ convert(VARCHAR(300),@w_comando)
       	
       	exec @w_error = xp_cmdshell @w_comando
       	
       	if @w_error <> 0 
       	 begin
       	    select
       	    @w_error = 2108049,
       	    @w_mensaje = 'Error Al crear Archivo txt'
       	    goto ERROR
         END

          --Fin Generacion de Archivo de Error
     END
       
    
   
END --Fin opcion I


return 0

ERROR:
    begin --Devolver mensaje de Error
       
       
       --select @w_error
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = @w_error,
			 @i_msg   = @w_msg 

        return @w_error
    end
go

