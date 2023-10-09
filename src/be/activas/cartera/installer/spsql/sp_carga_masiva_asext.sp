/************************************************************************/
/*   Stored procedure:     sp_carga_masiva_asext                         */
/*   Base de datos:        cob_cartera                                  */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                            PROPOSITO                                 */
/************************************************************************/
/*                            CAMBIOS                                   */
/************************************************************************/
/*      FECHA           AUTOR             RAZON                         */
/*      04-09-2010      PXSG              Version inicial caso 119772   */
/*      04-09-2010      AGO               REESCRITURA DE CODIGO         */
/*      26-09-2010      SRO               CORRECCIONES                  */
/*      01-06-2020      SRO               140200                        */
/************************************************************************/

use cob_cartera
go

if object_id ('sp_carga_masiva_asext') is not null
    drop procedure sp_carga_masiva_asext
go

CREATE proc sp_carga_masiva_asext (
@s_sesn           int          = NULL,
@s_ssn            int          = null,
@s_user           login        = NULL,
@s_date           datetime     = NULL,
@s_ofi            smallint     = NULL,
@s_term           varchar (30) = NULL,
@s_srv            varchar (30) = '',
@s_lsrv           varchar (30) = null,
@i_operacion	  char(1),
@t_show_version   bit         = 0,
@t_debug          char(1)     = 'N',
@t_file           varchar(10) = null,
@i_en_linea       char(1)     = 'S',
@i_secuencial     int         = 0 ,
@i_colectivo      varchar(255) = null,
@i_nombre         varchar(255) = null,
@i_cliente        varchar(255) = null,
@i_direccion      varchar(255) = null,
@i_celular        varchar(255) = null,               
@i_email          varchar(255) = null,
@i_asesor         varchar(255) = null,
@o_msg            varchar(3000) = null out ,
@o_sev            int          = 0    out              
	
)as
declare
@w_sp_name           varchar(32),
@w_error             int,
@w_msg               varchar (1000),
@w_etapa_ase_ext     varchar (1000),
@w_actividad         varchar(255),
@w_param_etapa      varchar(255),
@w_id_inst_proc		int,
@w_id_inst_act		int,
@w_id_asig_act		int,
@w_id_paso			int,
@w_codigo_res		int,
@w_id_empresa		int,
@w_codigo_act		int,
@w_nombre_act		varchar(30),
@w_tramite          INT,
@w_funcionario      INT,
@w_trancount        int

select 
@w_etapa_ase_ext  =  'ESPERAR ASIGNACIÓN DE ASESOR E',--'ESPERA DE ASIGNACION DE ASESOR EXTERNO', 
@w_sp_name        =  'sp_carga_masiva_asext',
@w_param_etapa    =  'ESASEX'   --ESPERA DE ASIGNACION ASESOR  



select @w_actividad = pa_char
from cobis..cl_parametro 
where pa_nemonico = @w_param_etapa
and pa_producto = 'CCA'



if @t_show_version = 1 begin
    print 'Stored procedure sp_carga_masiva_asext, Version 1.0.0'
    return 0
end

print @w_sp_name 
if @i_operacion = 'B'  begin 


   delete ca_asesor_colectivo where co_user = @s_user 
   
   insert into ca_asesor_colectivo    
   select 
   co_colectivo  =convert(varchar(255) ,null),
   co_nombre     =convert(varchar(255),null),
   co_cliente    =io_campo_1                ,
   co_direccion  =convert(varchar(255),null),
   co_celular    =convert(varchar(255) ,null),
   co_email      =convert(varchar(255) ,null),
   co_asesor     =convert(varchar(255) ,null),
   co_user       = @s_user 
   from cob_workflow..wf_inst_proceso,
   cob_workflow..wf_inst_actividad
   where  ia_id_inst_proc = io_id_inst_proc
   and io_estado          = 'EJE'
   AND ia_estado          = 'ACT'
   and ia_nombre_act      = @w_etapa_ase_ext
   
   --COLECTIVO
   update ca_asesor_colectivo set 
   co_colectivo = ea_colectivo 
   from cobis..cl_ente_aux 
   where ea_ente =co_cliente
   --NOMBRE 
   update ca_asesor_colectivo set
   co_nombre	  = isnull(en_nombre,'')+' '+isnull(p_s_nombre,'') +' '+isnull(p_p_apellido,'')+' '+isnull(p_s_apellido,'')
   from cobis..cl_ente 
   where en_ente=co_cliente
   
   
   --DIRECCIONES
   update ca_asesor_colectivo set
   co_direccion =  pv_descripcion+' / '+pq_descripcion+' / '+di_calle+' / '+ convert(varchar(50),di_nro)+' / '+ convert(varchar(50),di_nro_interno)
   from cobis..cl_direccion,cobis..cl_provincia,cobis..cl_parroquia
   where di_ente=co_cliente
   and di_provincia = pv_provincia
   and di_parroquia = pq_parroquia
   and di_tipo='RE'
   
   
   update ca_asesor_colectivo set
   co_direccion =  case  when co_direccion is null then pv_descripcion+' / '+pq_descripcion+' / '+di_calle+' / '+ convert(varchar(50),di_nro)+' / '+ convert(varchar(50),di_nro_interno)
   else co_direccion end 
   from cobis..cl_direccion,cobis..cl_provincia,cobis..cl_parroquia
   where co_cliente = di_ente
   and di_provincia = pv_provincia
   and di_parroquia = pq_parroquia
   and di_tipo='AE'
   
   update ca_asesor_colectivo set 
   co_celular =  te_valor 
   from cobis..cl_telefono,cobis..cl_direccion
   where te_direccion=di_direccion
   and co_cliente = te_ente
   and te_ente=di_ente
   and te_tipo_telefono='C'
   and di_tipo='RE'
   
   update ca_asesor_colectivo set 
   co_celular = case  when co_celular is null then te_valor else co_celular end
   from cobis..cl_telefono,cobis..cl_direccion
   where te_direccion=di_direccion
   and co_cliente = te_ente
   and te_ente =di_ente
   and te_tipo_telefono='C'
   and di_tipo='AE'
   
   update ca_asesor_colectivo set  
   co_email = di_descripcion 
   from cobis..cl_direccion
   where  di_ente=co_cliente
   and di_tipo='CE'

	  
   select 
   'id'         = co_id,
   'Colectivo'  = co_colectivo,
   'Nombres'    = co_nombre, 
   'Id_Cliente' = co_cliente,
   'Direccion'  = co_direccion,
   'Celular'    = co_celular,
   'Email'      = co_email,
   'Asesor'     = co_asesor
   from  ca_asesor_colectivo 
   where  co_user = @s_user  
   order by co_cliente asc 
   
   

end 


if @i_operacion = 'I' begin 
   
   BEGIN tran
   select	@o_msg = '|',@o_sev   = 0
   
   select top 1 
   @w_tramite      = io_campo_3,
   @w_id_inst_proc = io_id_inst_proc,
   @w_id_inst_act  = ia_id_inst_act,
   @w_id_paso      = ia_id_paso,
   @w_nombre_act   = ia_nombre_act  
   from cob_workflow..wf_inst_proceso, cob_workflow..wf_inst_actividad
   where  ia_id_inst_proc = io_id_inst_proc
   and io_estado     = 'EJE'
   AND ia_estado     = 'ACT'
   and ia_nombre_act = @w_etapa_ase_ext
   and io_campo_1    = @i_cliente
   
   if  @@rowcount = 0 begin       
      select
      @o_msg = @o_msg  +'ALERTA: El cliente no tiene un proceso de otorgamiento de LCR en espera de asignación de asesor externo|',
      @o_sev = @o_sev  +1
           
   end 
    

   if isnumeric(@i_asesor) = 0 begin
      select
      @o_msg = @o_msg + 'ALERTA: El ASESOR EXTERNO no es válido|' ,
      @o_sev = @o_sev  +1  
      return 0
   end

   if (@i_asesor = '' or  @i_asesor is null)  begin        
      select
      @o_msg = @o_msg + 'ALERTA: No se asignó un asesor externo al proceso de otorgamiento de LCR|' ,
      @o_sev = @o_sev  +1  
   
   end 
   
   if @i_asesor is not null or rtrim(ltrim(@i_asesor)) <> '' begin
      SELECT @w_funcionario = fu_funcionario
      from cobis..cl_funcionario
      WHERE fu_nomina = convert(INT,@i_asesor)
	  and   fu_estado = 'V'
      
      if @@rowcount = 0  begin         
         select
         @o_msg = @o_msg + 'ALERTA: El asesor asignado no es un funcionario|' ,
         @o_sev = @o_sev  +1  
      
      end   
   end
        
   if @o_sev   = 0 begin 
        
      UPDATE cobis..cl_ente_aux SET
      ea_asesor_ext = @w_funcionario
      WHERE ea_ente = @i_cliente
            
      exec @w_error       =   cob_cartera..sp_ruteo_actividad_wf  
      @s_ssn              =   @s_ssn, 
      @s_user             =   @s_user,
      @s_sesn             =   @s_sesn,
      @s_term             =   @s_term,
      @s_date             =   @s_date,
      @s_srv              =   @s_srv,
      @s_lsrv             =   @s_lsrv,
      @s_ofi              =   @s_ofi,     
      @i_tramite          =   @w_tramite, 
      @i_param_etapa      =   @w_param_etapa
	  
	  if @w_error <> 0 begin
	     goto ERROR
	  end 
		 
	  
	  COMMIT tran
   end ELSE BEGIN
   
     SELECT @w_trancount = @@TRANCOUNT
  
     IF @w_trancount> 0 BEGIN
        ROLLBACK tran
     end   
   end      
     
end 


if @i_operacion='Q' begin

   --UNIVERSO DE ASESORES EN LA ETAPA
   
   if @i_secuencial = 0 begin 
         
      delete ca_qry_asesor_colectivo where co_user = @s_user 
      
      insert into ca_qry_asesor_colectivo    
      select 
      co_colectivo  =convert(varchar(255) ,null),
      co_nombre     =convert(varchar(255),null),
      co_cliente    =io_campo_1                ,
      co_direccion  =convert(varchar(255),null),
      co_celular    =convert(varchar(255) ,null),
      co_email      =convert(varchar(255) ,null),
      co_asesor     =convert(varchar(255) ,null),
      co_user       = @s_user 
      from cob_workflow..wf_inst_proceso,
      cob_workflow..wf_inst_actividad
      where  ia_id_inst_proc = io_id_inst_proc
      and io_estado = 'EJE'
      AND ia_estado = 'ACT'
      and ia_nombre_act = @w_etapa_ase_ext
      
	  --COLECTIVO
      update ca_qry_asesor_colectivo set 
      co_colectivo = ea_colectivo 
      from cobis..cl_ente_aux 
      where ea_ente =co_cliente
	  
      --NOMBRE 
      update ca_qry_asesor_colectivo set
      co_nombre	  = isnull(en_nombre,'')+' '+isnull(p_s_nombre,'') +' '+isnull(p_p_apellido,'')+' '+isnull(p_s_apellido,'')
      from cobis..cl_ente 
      where en_ente=co_cliente
      
 
      --DIRECCIONES
      update ca_qry_asesor_colectivo set
      co_direccion =  isnull(pv_descripcion,'')+' / '+isnull(pq_descripcion,'') +' / '+isnull(di_calle,'')+' / '+ convert(varchar(50),isnull(di_nro,''))+' / '+ 
	                  convert(varchar(50),isnull(di_nro_interno,''))
      from cobis..cl_direccion,cobis..cl_provincia,cobis..cl_parroquia
      where di_ente=co_cliente
      and di_provincia = pv_provincia
      and di_parroquia = pq_parroquia
      and di_tipo='RE'
      
   
      update ca_qry_asesor_colectivo set
      co_direccion =  case  when co_direccion is null then isnull(pv_descripcion,'')+' / '+isnull(pq_descripcion,'') +' / '+isnull(di_calle,'')+' / '+ 
	                                                       convert(varchar(50),isnull(di_nro,''))+' / '+ convert(varchar(50),isnull(di_nro_interno,''))
  	   	              else co_direccion end 
      from cobis..cl_direccion,cobis..cl_provincia,cobis..cl_parroquia
      where co_cliente = di_ente
      and di_provincia = pv_provincia
      and di_parroquia = pq_parroquia
      and di_tipo='AE'
      	  
      update ca_qry_asesor_colectivo set 
      co_celular =  te_valor 
      from cobis..cl_telefono,cobis..cl_direccion
      where te_direccion=di_direccion
      and co_cliente = te_ente
      and te_ente=di_ente
      and te_tipo_telefono='C'
      and di_tipo='RE'
      	  
      update ca_qry_asesor_colectivo set 
      co_celular = case  when co_celular is null then te_valor else co_celular end
      from cobis..cl_telefono,cobis..cl_direccion
      where te_direccion=di_direccion
      and co_cliente = te_ente
      and te_ente =di_ente
      and te_tipo_telefono='C'
      and di_tipo='AE'
      	  
      update ca_qry_asesor_colectivo set  
      co_email = di_descripcion 
      from cobis..cl_direccion
      where  di_ente=co_cliente
      and di_tipo='CE'
      
	  
   end 

   set rowcount 0
   
   select 
   'id'         = co_id,
   'Colectivo'  = co_colectivo,
   'Nombres'    = co_nombre, 
   'Id_Cliente' = co_cliente,
   'Direccion'  = co_direccion,
   'Celular'    = co_celular,
   'Email'      = co_email,
   'Asesor'     = co_asesor
   from  ca_qry_asesor_colectivo
   where co_id > @i_secuencial 
   and  co_user = @s_user  
   order by co_id asc 


end

if @i_operacion='X' begin 
   delete ca_qry_asesor_colectivo where co_user = @s_user
   delete ca_asesor_colectivo     where co_user = @s_user

end  

return 0

ERROR:

SELECT @w_trancount =@@TRANCOUNT 
IF  @w_trancount>0 BEGIN
   ROLLBACK tran
end
if @i_en_linea = 'S' begin 
   exec cobis..sp_cerror
   @t_debug = 'N',
   @t_from  = @w_sp_name,
   @i_num   = @w_error,
   @i_msg   = @w_msg

end else begin 
   exec sp_errorlog 
   @i_fecha     = @s_date,
   @i_error     = @w_error,
   @i_usuario   = @s_user,
   @i_tran      = 7999,
   @i_tran_name = @w_sp_name,
   @i_rollback  = 'N',
   @i_descripcion = @w_msg
end   

return @w_error

GO

