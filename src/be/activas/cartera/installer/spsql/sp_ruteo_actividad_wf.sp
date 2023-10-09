/************************************************************************/
/*      Base de datos:          cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           Sonia Rojas                             */
/*      Fecha de escritura:     Noviembre 2017                          */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA'                                                        */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Rutina para paso de actividades en el WorkFlow                  */
/*      de estacion en espera.                                          */
/************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_ruteo_actividad_wf')
   drop proc sp_ruteo_actividad_wf
go

create proc sp_ruteo_actividad_wf 
   @s_sesn                    int          = NULL,
   @s_ssn                     int          = null,
   @s_user                    login        = NULL,
   @s_date                    datetime     = NULL,
   @s_ofi                     smallint     = NULL,
   @s_term                    varchar (30) = NULL,
   @s_srv                     varchar (30) = '',
   @s_lsrv                    varchar (30) = null,
   @i_tramite				  int          = null,   
   @i_param_etapa			  varchar(10),
   @i_tramite_ant			  int          = null,
   @i_pa_producto             char(3)      = 'CCA',
   @i_actualiza_var           char(1)      = 'N'
as
declare @w_id_inst_proc		int,
		@w_id_inst_act		int,
		@w_id_asig_act		int,
		@w_id_paso			int,
		@w_codigo_res		int,
		@w_id_empresa		int,
		@w_codigo_act		int,
		@w_nombre_act		varchar(30),
		@w_actividad		varchar(30),
		@w_error			int,
        @w_error_reverso    int
		
select @w_codigo_res = 1 --OK
select @w_id_empresa = 1 

select @w_actividad = pa_char 
  from cobis..cl_parametro 
 where pa_nemonico = @i_param_etapa
   and pa_producto = @i_pa_producto
      
if @@rowcount = 0
begin
	print 'ERROR: NO EXISTE PARAMETRO '+ @i_param_etapa
	select @w_error = 101254
	return @w_error
end

if @i_tramite is null
begin
	
	select @w_id_inst_proc = io_id_inst_proc
      from cob_workflow..wf_inst_proceso 
     where io_campo_5 = @i_tramite_ant

end
else 
begin
	select @w_id_inst_proc = io_id_inst_proc
	  from cob_workflow..wf_inst_proceso
	 where io_campo_3 =  @i_tramite 
end
 
if @w_id_inst_proc is null
	return 0
	
--Instancia de la actividad
select @w_id_inst_act = ia_id_inst_act,
       @w_id_paso	  = ia_id_paso,
	   @w_nombre_act  = ia_nombre_act
  from cob_workflow..wf_inst_actividad
 where ia_id_inst_proc = @w_id_inst_proc
   and ia_estado 	in ('ACT', 'INA')
   and ia_tipo_dest is null
   
--Asignaci�n actividad
select @w_id_asig_act = aa_id_asig_act
  from cob_workflow..wf_asig_actividad
 where aa_id_inst_act = @w_id_inst_act


 
if @w_nombre_act = @w_actividad
begin

   begin try 
      exec @w_error = cob_workflow..sp_resp_actividad_wf 
      @s_ssn  			    = @s_ssn, 
      @s_user              = @s_user,
      @s_sesn              = @s_sesn,
      @s_term              = @s_term,
      @s_date              = @s_date,
      @s_srv               = @s_srv,
      @s_lsrv              = @s_lsrv,
      @s_ofi               = @s_ofi,		
      @t_trn 				= 73505,
      @i_operacion 		= 'C',
      @i_actualiza_var 	= @i_actualiza_var,
      @i_asig_manual 		= 0,
      @i_id_inst_proc 	    = @w_id_inst_proc,
      @i_id_inst_act 		= @w_id_inst_act,
      @i_id_asig_act 		= @w_id_asig_act,
      @i_id_paso 			= @w_id_paso,
      @i_codigo_res 		= @w_codigo_res,
      @i_id_empresa 		= @w_id_empresa
      
      if @w_error <> 0 or @@error <> 0 begin
         print 'TRANCOUNT sp_ruteo_actividad_wf'+ convert(varchar,@@trancount)
         if @w_error <> 3107543 and @w_error <> 3107619 begin
            exec @w_error_reverso = cob_workflow..sp_reverso_automatico_wf 
            @i_opcion = 'L', 
            @i_id_inst_proc = @w_id_inst_proc, 
            @i_id_inst_act = @w_id_inst_act
            
            if @w_error <> 0 begin
               print 'Error en el reverso del proceso '+ convert(varchar,@w_id_inst_proc) + ' error: ' +  convert(varchar,@w_error_reverso)
            end
         end
         return @w_error
      end   
   end try
   begin catch
      print 'CATCH RUTEO ACTIVIDAD'
        
      IF (XACT_STATE()) = -1
      BEGIN
         PRINT N'The transaction is in an uncommittable state.' +
            'Rolling back transaction.'
         ROLLBACK TRANSACTION;
      END;
       
      begin tran 
         print 'INICIA sp_reverso_automatico_wf' 
         exec @w_error_reverso = cob_workflow..sp_reverso_automatico_wf 
         @i_opcion = 'L', 
         @i_id_inst_proc = @w_id_inst_proc, 
         @i_id_inst_act = @w_id_inst_act
         if @w_error <> 0 begin
            print 'Error en el reverso del proceso '+ convert(varchar,@w_id_inst_proc) + ' error: ' +  convert(varchar,@w_error_reverso)
         end
         print 'FINALIZA sp_reverso_automatico_wf' 
      commit
       
      return @@error 
   end catch
   
end
/*else
begin
	select @w_error = 724674 --COMENTADO HASTA RESOLVER INC.
	return @w_error
end*/

return 0
go

