/************************************************************************/
/*    Base de datos:            cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           Sonia Rojas                             */
/*      Fecha de escritura:     13/09/2017                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA'.                                                       */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/  
/*                         PROPOSITO                                    */
/*      Tiene como propósito procesar los pagos de los corresponsales   */
/************************************************************************/
/*                        MOFICACIONES                                  */
/*   FECHA        AUTOR                     RAZON                       */
/* 24/07/2018    SRO      Validaciones referencias SANTANDER            */
/* 26/04/2019    PXSG     se aumenta validacion para devolver error     */
/*                        cuando viene por pagos masivos                */
/* 16/06/2022    ACH      REQ#185234, se agrega opcion GI               */
/************************************************************************/  
use cob_cartera
go


if exists(select 1 from sysobjects where name ='sp_santander_val_ref')
	drop proc sp_santander_val_ref
GO


CREATE proc sp_santander_val_ref(
    @s_ssn              int                = null,
    @s_user             login              = null,
    @s_sesn             int                = null,
    @s_term             varchar(30)        = null,
    @s_date             datetime           = null,
    @s_srv              varchar(30)        = null,
    @s_lsrv             varchar(30)        = null,
    @s_ofi              smallint           = null,
    @s_servicio         int                = null,
    @s_cliente          int                = null,
    @s_rol              smallint           = null,
    @s_culture          varchar(10)        = null,
    @s_org              char(1)            = null,
    @i_referencia       varchar(255)       = null, -- Obligatorio 
	@i_fecha_pago       varchar(8)         = null, -- Fecha de Pago
    @i_monto_pago       varchar(14)        = null, -- Monto de Pago
    @i_archivo_pago     varchar(255)	   = null, -- Archivo de Pago, opcional
    @i_pagos_masivos    CHAR(1)            = 'N',  -- Para ejecucion desde pantalla de pagos masivos
	@i_es_conciliacion  char(1)			   = 'N',  -- La ejecucion es para conciliacion
	@i_id_trn_corresp   int                = null, -- Transaccion del corresponsal
    @o_tipo             char(2)            = null out,    -- Tipo de transacción
    @o_codigo_interno   varchar(10)        = null out,    -- C?digo interno
    @o_fecha_pago       datetime           = null out,    -- Fecha de pago
    @o_monto_pago       money              = null out,    -- Monto de pago
	@o_trn_corresponsal	varchar(20)		   = null out    -- Transaccion del corresponsal
)
as
declare 
   @w_sp_name                 varchar(30),
   @w_tipo_tran               char(2),             -- Obligatorio si operacion = 'G', (GL) Garantia Líquida, (PG) Prétamo Grupal, (PI) Préstamo Individual, 
                                                  -- (CG)Cancelacción de Crédito Grupal, (CI)Cancelación de Crédito Individual
   @w_codigo_int              int,
   @w_error                   int,
   @w_msg                     varchar(255),
   @w_tipo_tran_corresp       char(2)
   
   select @w_sp_name  = 'sp_santander_val_ref'
   
   select @w_tipo_tran_corresp = substring(@i_referencia,1,2) 
   
   select @w_tipo_tran =  ctr_tipo_cobis from cob_cartera..ca_corresponsal_tipo_ref 
   where ctr_co_id = (select co_id from cob_cartera..ca_corresponsal where co_nombre = 'SANTANDER')
   and   ctr_tipo  = @w_tipo_tran_corresp
   
   /*Compatibilidad hacia atras*/
   if @@rowcount = 0 
   begin
       select @w_tipo_tran = case when @w_tipo_tran_corresp in ('GL','00') then 'GL'                      
                                  when @w_tipo_tran_corresp in ('PG','01','20') then 'PG' -- '20' se anade por caso 115813
                                  when @w_tipo_tran_corresp in ('CG','02') then 'CG'
                                  when @w_tipo_tran_corresp in ('PI','03') then 'PI'
							      when @w_tipo_tran_corresp in ('PR','04') then 'CI'
								  when @w_tipo_tran_corresp in ('GI','11') then 'GI' --porCaso#185234
                                  else @w_tipo_tran_corresp 
                             end
   end
   
   if  @w_tipo_tran <> 'GL'
   and @w_tipo_tran <> 'PG'
   and @w_tipo_tran <> 'PI'
   and @w_tipo_tran <> 'CG'
   and @w_tipo_tran <> 'CI'
   and @w_tipo_tran <> 'GI' begin --porCaso#185234
      select @w_error = 70204,
             @w_msg   = 'ERROR: TIPO DE TRANSACCIÓN NO VÁLIDA'
      goto ERROR_FIN
   end
   
   
   select @w_codigo_int = substring(@i_referencia,3,12)

   exec @w_error    	= sp_validar_pagos 
   @i_referencia    	= @i_referencia,   
   @i_fecha_pago    	= @i_fecha_pago,
   @i_monto_pago    	= @i_monto_pago,
   @i_archivo_pago  	= @i_archivo_pago,
   @i_tipo          	= @w_tipo_tran,
   @i_codigo_int    	= @w_codigo_int,
   @i_es_conciliacion	= @i_es_conciliacion,
   @o_tipo          	= @o_tipo           out ,
   @o_codigo_int    	= @o_codigo_interno out,
   @o_monto_pago    	= @o_monto_pago     out ,
   @o_fecha_pago    	= @o_fecha_pago     out 
   
   
   if @w_error <> 0 begin
      select @w_error = @w_error,
             @w_msg = 'ERROR AL VALIDAR LA REFERENCIA SANTANDER'	  
      goto ERROR_FIN
   end
   
   if @i_es_conciliacion = 'S'
   begin
		select @o_trn_corresponsal =cob_cartera.dbo.LlenarI(convert(varchar(20),@i_id_trn_corresp), '0', 8)
   end 

return 0


ERROR_FIN:
if(@i_pagos_masivos='S')
begin
PRINT'@i_pagos_masivos'+@i_pagos_masivos
return @w_error
end
else
begin

exec cobis..sp_cerror 
    @t_from = @w_sp_name, 
    @i_num  = @w_error, 
    @i_msg  = @w_msg
return @w_error

end
go
