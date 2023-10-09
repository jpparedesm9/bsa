/************************************************************************/
/* Archivo:                sp_ba_error_his.sp                           */
/* Stored procedure:       sp_ba_error_his                              */
/* Base de datos:          cobis                                        */
/* Producto:               cobis                                        */
/* Disenado por:                                                        */
/* Fecha de escritura:     12-MAY-2011                                  */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    "MACOSA", representantes exclusivos para el Ecuador de la         */
/*    "NCR CORPORATION".                                                */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de MACOSA o su representante.               */
/************************************************************************/
/*                          PROPOSITO                                   */
/*    Este programa realiza el paso a historicos de la tabla diaria     */
/*    cobis..ba_error_batch a la tabla cobis..ba_error_batch_his        */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    12-MAY-2011    P. Jarrin       Emision Inicial                    */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_ba_error_his')
   drop proc sp_ba_error_his

go

create proc sp_ba_error_his   (
    @s_ssn           int               = null,
    @s_date          datetime          = null,
    @s_user          login             = null,
    @s_term          descripcion       = null,
    @s_corr          char(1)           = null,
    @s_ssn_corr      int               = null,
    @s_ofi           smallint          = null,
    @t_rty           char(1)           = null,
    @t_trn           smallint          = null,
    @t_debug         char(1)           = 'N',
    @t_file          varchar(14)       = null,
    @t_from          varchar(30)       = null,
    @i_fecha_proceso datetime          = null,
    -- Parametros para registro de log de ejecucion
    @i_sarta         int               = null,
    @i_batch         int               = null,
    @i_secuencial    int               = null,
    @i_corrida       int               = null,
    @i_intento       int               = null

)
as 
declare
    @w_today         datetime, 
    @w_return        int,  
    @w_sp_name       varchar(32), 
    @w_sec_error     int ,
    @w_fecha_proceso datetime,
    @w_user          login


select @w_today = getdate()
select @w_sp_name = 'sp_ba_error_his'

select @w_fecha_proceso = @i_fecha_proceso

select @w_user = lo_operador
  from cobis..ba_log
 where lo_sarta      = @i_sarta
   and lo_batch      = @i_batch
   and lo_secuencial = @i_secuencial
   and lo_corrida    = @i_corrida    
 order 
    by lo_intento


if exists(select 1 
            from cobis..ba_error_batch_his
           where er_fecha_proceso = @w_fecha_proceso)

begin
   delete cobis..ba_error_batch_his
    where er_fecha_proceso = @w_fecha_proceso
    
   if @@error > 0
   begin
      -- Error, en la eliminacion de registros de errores de procesamiento historicos
        exec @w_return = sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808075,
             @i_detalle       = 'ERROR EN ELIMINACION DE REGISTROS'

        if @w_return > 0
        begin        
            return @w_return 
        end       
    end
end 

begin tran 
    insert into cobis..ba_error_batch_his 
    (
        er_secuencial_error, 
        er_fecha_proceso, 
        er_sarta, 
        er_batch, 
        er_secuencial, 
        er_corrida, 
        er_intento, 
        er_fecha_error, 
        er_error,
        er_tran,
        er_operacion,
        er_detalle,
        er_fecha_depura,
        er_usuario_depura
    )
    
    select 
        er_secuencial_error,
        er_fecha_proceso,
        er_sarta,
        er_batch,
        er_secuencial,
        er_corrida,
        er_intento,
        er_fecha_error,
        er_error,
        er_tran,
        er_operacion,
        er_detalle,
        @w_today,
        @w_user 
     from cobis..ba_error_batch 
    where er_fecha_proceso = @w_fecha_proceso  
    

   if @@error > 0
   begin
        -- Error, en la insercion de registros diarios al historico
        rollback tran   
        exec @w_return = sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808076,
             @i_detalle       = 'ERROR EN INSERCION DE REGISTROS'

        if @w_return > 0
        begin        
            return @w_return 
        end       
    end

    
    
    delete cobis..ba_error_batch    
     where er_fecha_proceso = @w_fecha_proceso  
        
    if @@error > 0
    begin
        -- Error, en la eliminacion de registros de errores de procesamiento diario
        rollback tran          
        exec @w_return = sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808077,
             @i_detalle       = 'ERROR EN ELIMINACION DE REGISTROS'
        
        if @w_return > 0
        begin        
            return @w_return 
        end       
    end

       
commit tran       
return 0
go


