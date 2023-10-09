/************************************************************************/
/* Archivo:                supervisor.sp                                */
/* Stored procedure:       sp_auteje_forzada                            */
/* Base de datos:          cobis                                        */
/* Producto:               COBIS Visual Batch                           */
/* Disenado por:           Francisco Lopez                              */
/* Fecha de escritura:     11-Ene-2005                                  */
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
/*    Verifica que un usuario q se ha loggeado tenga asociado el rol    */
/*    de Supervisor Visual Batch a fin de autorizar la ejecucion        */                  
/*    forzada de un proceso y a su vez registrar dicha autorizacion     */                  
/*    en la ba_log.                                                     */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR            RAZON                             */
/*    11-Ene-2005    F. Lopez         Emision inicial                   */
/*    13-Ene-2011    S. Soto          Ajustes a Terminacion forzada     */
/************************************************************************/

use cobis
go

if exists (select 1 from sysobjects where id = object_id('sp_auteje_forzada'))
  drop procedure sp_auteje_forzada
GO

Create Procedure sp_auteje_forzada (
  @s_ssn             int            =  NULL,
  @s_user            varchar(30)    =  NULL,
  @s_sesn            int            =  NULL,
  @s_term            varchar(30)    =  NULL,
  @s_date            datetime       =  NULL,
  @s_srv             varchar(30)    =  NULL,
  @s_lsrv            varchar(30)    =  NULL, 
  @s_rol             smallint       =  NULL,
  @s_ofi             smallint       =  NULL,
  @s_org_err         char(1)        =  NULL,
  @s_error           int            =  NULL,
  @s_sev             tinyint        =  NULL,
  @s_msg             varchar(64)    =  NULL,
  @s_org             char(1)        =  NULL,
  @t_online          char(1)        =  NULL,  
  @t_trn             smallint       =  802,
  @t_debug           char(1)        =  'N',
  @t_file            varchar(14)    =  NULL,
  @t_from            varchar(30)    =  NULL,
  @i_autorizante     varchar(30)    =  NULL,
  @i_sarta           int            =  NULL,
  @i_batch           int            =  NULL,
  @i_secuencial      int            =  NULL,
  @i_corrida         int            =  -1,
  @i_fecha_proceso   datetime       =  NULL,
  @i_operacion       char           =  NULL
)
as
declare 
  @w_sp_name         varchar(64),
  @w_intento	     smallint,
  @w_rol             tinyint 

  
select @w_sp_name = 'sp_auteje_forzada'


if (@t_trn <> 8114 and @i_operacion = 'V') 
begin
   /* Tipo de transaccion no corresponde */
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 801077
   return 1
end


if @i_operacion = 'V' -- verificacion de permisos para la autorizacion
begin    
     select @w_rol = pa_tinyint
       from cobis..cl_parametro
      where pa_nemonico = 'SOB'
        and pa_producto = 'ADM'

     if exists(select 1
                 from  cobis..ad_usuario_rol,cobis..cl_funcionario
                where ur_login = fu_login    
                  and ur_rol = @w_rol 
                  and ur_login = @i_autorizante
                  and ur_estado = 'V'
      )
      begin            

	if @i_corrida = 0 or @i_corrida is null
	begin
                 /* 'Error en Insercion de LOG' */
                 exec cobis..sp_cerror
                     @t_debug = @t_debug,
                     @t_file   = @t_file,
                     @t_from   = @w_sp_name,
                     @i_num    = 143040,
                     @i_msg   = 'NO existe una corrida en curso en la que pueda aplicarse esta actualización'
                 return 1
	end

         insert into ba_log (lo_sarta,lo_batch,lo_secuencial,lo_corrida,lo_operador,lo_fecha_inicio,lo_fecha_terminacion,
                            lo_num_reg_proc,lo_estatus,lo_razon,lo_fecha_proceso,lo_proceso,lo_parametro,lo_intento)
                     values (@i_sarta,@i_batch,(@i_secuencial),(@i_corrida),@i_autorizante,getdate(),null,
                             null,'X','Autorizacion para Ejecucion Forzada del Proceso',@i_fecha_proceso,null,null,-1)
              if @@error <> 0 
              begin
                 /* 'Error en Insercion de LOG' */
                 exec cobis..sp_cerror
                     @t_debug = @t_debug,
                     @t_file   = @t_file,
                     @t_from   = @w_sp_name,
                     @i_num    = 143040,
                     @i_msg   = 'Error al Registrar la Autorizaci¢n, Comun¡quese con el Administrador del Sistema'
                 return 1
              end
         select 0  -- indica que SI esta autorizado
      end
     else         
     begin
        select 1  -- indica que NO esta autorizado    
     end  
end


if @i_operacion = 'K' -- verificacion de permisos para Finalizar un Proceso
begin    
     select @w_rol = pa_tinyint
       from cobis..cl_parametro
      where pa_nemonico = 'SOB'
        and pa_producto = 'ADM'
    
   if exists(select 1
               from  cobis..ad_usuario_rol,cobis..cl_funcionario
              where ur_login = fu_login    
                and ur_rol = @w_rol 
                and ur_login = @i_autorizante
                and ur_estado = 'V')
   begin
      select @w_intento = max(lo_intento)
        from ba_log 
       where lo_sarta = @i_sarta and lo_batch = @i_batch  
         and lo_secuencial = @i_secuencial 
         and lo_corrida=@i_corrida
      
      --Almacena en la ba_log un registro q contiene la autorizacion de la ejecucion forzada de un proceso
      insert into ba_log (lo_sarta,lo_batch,lo_secuencial,lo_corrida,lo_operador,lo_fecha_inicio,lo_fecha_terminacion,
                          lo_num_reg_proc,lo_estatus,lo_razon,lo_fecha_proceso,lo_proceso,lo_parametro,lo_intento)
             values (@i_sarta,@i_batch,(@i_secuencial),(@i_corrida),@i_autorizante,getdate(),getdate(),
                     null,'T','Autorizacion de Finalizacion incondicional de Proceso en Ejecucion (KILL)',@i_fecha_proceso,null,null,-1*@w_intento)

      if @@error <> 0 
      begin
         /* 'Error en Insercion de LOG' */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file   = @t_file,
            @t_from   = @w_sp_name,
            @i_num    = 143040,
            @i_msg   = 'Error al Registrar la Autorizaci¢n, Comun¡quese con el Administrador del Sistema'
         return 1
      end
      select 0  -- indica que SI esta autorizado
   end     
   else       
   begin
      select 1  -- indica que NO esta autorizado    
   end  
end

return 0
go


