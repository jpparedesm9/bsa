USE cob_credito
go
/*************************************************************/
/*   ARCHIVO:         	sp_rfc_int_error.sp                  */
/*   NOMBRE LOGICO:   	sp_rfc_int_error                     */
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
/*   Este procedimiento inserta los rfc de los archvos       */
/*   rechazados por interfactura							 */
/*************************************************************/
/*                     MODIFICACIONES                        */
/*   FECHA         AUTOR               RAZON                 */
/*   14-Sep-2018  PXSG                Emision Inicial.       */
/*   06-Feb-2019  PXSG                Se inserta nuevas      */
/*                                    columnas en la tabla   */
/*   13-Ago-2019  MTA                Aumenta tamaño del campo*/
/*   15-Jun-2020  AIN          Cambio de @i_rfc a @w_rfc_ente*/
/*************************************************************/

IF OBJECT_ID ('dbo.sp_rfc_int_error') IS NOT NULL
	DROP PROCEDURE dbo.sp_rfc_int_error
GO

SET QUOTED_IDENTIFIER ON
GO

create proc sp_rfc_int_error (	
	@i_operacion		char(1),
	@i_file_name     	varchar(60) = null

)
as


declare 
@w_rfc_generico         varchar(30),
@w_rfc_ente 	        varchar(30),
@w_xml                  XML,
@w_file_name            varchar(100),
@w_cod_cliente          int,
@w_rfc                  varchar(30),
@w_banco                varchar(32),
@w_insert_date          datetime,
@num_codigo_rfc         int,
@num_operacion_rfc      varchar(24),
@w_rx_cuota_desde       int,
@w_rx_cuota_hasta       int,
@w_rx_int_rep           money,
@w_rx_com_rep           money,
@w_rx_int_ant           money,
@w_rx_iva               money,
@w_rx_met_fact          varchar (3),
@w_rx_form_pag          varchar (2),
@w_rx_fecha_ult_compl   date,
@w_rx_fecha_env_email   date,
@w_rx_tipo_operacion    varchar (10),
@w_rx_pago_compl        money,
@w_rx_folio_ref         varchar (50),
@w_rx_total_saldo_ant   money,
@w_rx_fecha_fin_mes     datetime,
@w_rx_pago_mes          money,
@w_rx_pago_mes_ant      money,
@w_rx_deuda_pagar       money,
@w_rx_pag_compl_ant     money,
@w_rx_total_saldo       money,
@w_rx_com_acum          money,
@w_rx_sec_id            int,
@w_rx_pago_compl_fin    money,
@w_rx_genera_cmpl       char (1),
@w_fecha_proceso        datetime

--Obtiene el parametro para el RFC Generico
select @w_rfc_generico = pa_char
from cobis..cl_parametro
where pa_producto = 'REC'
and pa_nemonico = 'RFCGEN'

select @w_fecha_proceso=fp_fecha from cobis..ba_fecha_proceso

select @w_insert_date=getdate()
--Tabla temporal para almacenar las operaciones del rfc 
declare @operaciones_rfc
table(
    codigo              int identity,
    operation           varchar(24),
    rfc_ente            varchar(30) 

    )

--Inserccion de Datos
if @i_operacion = 'I'
begin
   -- Busqueda del RCF por el documento que fallo
   select @w_rfc_ente =  rfc_ente
   from cob_credito..cr_resultado_xml 
   where file_name=@i_file_name
   
   --Validacion de que el rfc no exista en la tabla cr_rfc_int_error
   IF NOT EXISTS( SELECT 1  
                  FROM  cob_credito..cr_rfc_int_error
                  WHERE  rfc_int_error  =@w_rfc_ente
                  AND    status_rfc_err = 'F')
   begin
   
      --Inserccion en la tabla cr_rfc_int_error
      insert into cob_credito..cr_rfc_int_error ( rfc_int_error, status_rfc_err, insert_date_rfc_err)
      values                                    ( @w_rfc_ente,        'P',            @w_insert_date  )
      if @@error != 0
      begin
          return 1
      end
      --Inserto el numero de operaciones para el rfc en la tabla temporal @operaciones_rfc
      insert into @operaciones_rfc
      select DISTINCT num_operation,rfc_ente 
      from cob_credito..cr_resultado_xml 
      where rfc_ente=@w_rfc_ente
        
      select @num_codigo_rfc = 0
	   
	  while (1 = 1) 
	  begin
         select  TOP 1 @num_operacion_rfc = operation ,
                       @num_codigo_rfc    = codigo  
	     from @operaciones_rfc 
	     where codigo > @num_codigo_rfc 
	     order by codigo asc
	 
         if @@rowcount = 0 BREAK
	
         --Continua para insertar en la tabla   cr_resultado_xml 
         if exists(select 1 from cob_credito..cr_resultado_xml where rfc_ente=@w_rfc_ente and num_operation=@num_operacion_rfc )
		 begin
    
            select top 1 @w_xml                 =  linea,
                         @w_file_name           =  file_name,
                         @w_cod_cliente         =  id_ente,
                         @w_rfc                 =  rfc_ente,
                         @w_banco               =  num_operation,
                         @w_rx_cuota_desde      =  rx_cuota_desde ,
                         @w_rx_cuota_hasta      =  rx_cuota_hasta,
                         @w_rx_int_rep          =  rx_int_rep,
                         @w_rx_com_rep          =  rx_com_rep,
                         @w_rx_int_ant          =  rx_int_ant,
                         @w_rx_iva              =  rx_iva,
                         @w_rx_met_fact         =  rx_met_fact,
                         @w_rx_form_pag         =  rx_form_pag,
                         @w_rx_fecha_ult_compl  =  rx_fecha_ult_compl,
                         @w_rx_fecha_env_email  =  rx_fecha_env_email,
                         @w_rx_tipo_operacion   =  rx_tipo_operacion,
                         @w_rx_folio_ref        =  rx_folio_ref,
                         @w_rx_total_saldo_ant  =  rx_total_saldo_ant,
                         @w_rx_fecha_fin_mes    =  rx_fecha_fin_mes,
                         @w_rx_pago_compl       =  rx_pago_compl,
                         @w_rx_pago_mes         =  rx_pago_mes,
                         @w_rx_pago_mes_ant     =  rx_pago_mes_ant,
                         @w_rx_total_saldo      =  rx_total_saldo,
                         @w_rx_deuda_pagar      =  rx_deuda_pagar,
                         @w_rx_pago_compl_fin   =  rx_pago_compl_fin
            from cob_credito..cr_resultado_xml 
            where rfc_ente=@w_rfc_ente
            and   num_operation= @num_operacion_rfc
            and insert_date=(select min(insert_date)
                             from cob_credito..cr_resultado_xml 
                             where rfc_ente=@w_rfc_ente
                             and   num_operation = @num_operacion_rfc)
                
		    
		    set @w_xml.modify('
                           replace value of(/FacturaInterfactura/Receptor/@RFC)[1]
                           with sql:variable("@w_rfc_generico")
                         ')
                         
            --Inserccion en la tabla cr_resultado_xml
	        
            insert into cob_credito..cr_resultado_xml(
              linea              , file_name         ,      id_ente           ,      status         , 
              rfc_ente           , num_operation      ,     insert_date       ,      
              rx_cuota_desde     , rx_cuota_hasta     ,     rx_int_rep        ,      rx_com_rep    , 
              rx_int_ant         , rx_iva             ,     rx_met_fact       ,      rx_form_pag   , 
              rx_fecha_ult_compl , rx_fecha_env_email ,     rx_tipo_operacion ,      rx_folio_ref  , 
              rx_total_saldo_ant , rx_fecha_fin_mes   ,     rx_pago_compl     ,      rx_pago_mes   , 
              rx_pago_mes_ant    , rx_total_saldo     ,     rx_deuda_pagar    ,      rx_sec_id     ,
              rx_pago_compl_fin  , rx_genera_cmpl)  
            values (
              @w_xml               , @w_file_name         ,	    @w_cod_cliente      ,     'P'               ,
              @w_rfc               , @w_banco             ,     @w_fecha_proceso    , 
              @w_rx_cuota_desde    , @w_rx_cuota_hasta    ,     @w_rx_int_rep       ,      @w_rx_com_rep    , 
              @w_rx_int_ant        , @w_rx_iva            ,     @w_rx_met_fact      ,      @w_rx_form_pag   , 
              @w_rx_fecha_ult_compl, @w_rx_fecha_env_email,     @w_rx_tipo_operacion,      @w_rx_folio_ref  , 
              @w_rx_total_saldo_ant, @w_rx_fecha_fin_mes  ,     @w_rx_pago_compl    ,      @w_rx_pago_mes   , 
              @w_rx_pago_mes_ant   , @w_rx_total_saldo    ,     @w_rx_deuda_pagar   ,      -1               ,
              @w_rx_pago_compl_fin , 'N') 
		    
            if @@error != 0
            begin
               return 1
            end
          end  
      end      
      --Actualización del estado de la tabla con rfc de error    
      update cob_credito..cr_rfc_int_error 
      set status_rfc_err       = 'F',
          process_date_rfc_err = getdate() 
      where rfc_int_error       = @w_rfc_ente
      and   insert_date_rfc_err = @w_insert_date
    
  end  
	
end

return 0
go
