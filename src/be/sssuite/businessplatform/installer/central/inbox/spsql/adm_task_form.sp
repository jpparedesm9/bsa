use cob_pac
go

if object_id('sp_adm_task_form') is not null
begin
  drop procedure sp_adm_task_form
  if object_id('sp_adm_task_form') is not null
    print 'FAILED DROPPING PROCEDURE sp_adm_task_form'
end
go
create procedure  sp_adm_task_form
(
/*******************************************************************/
/*   ARCHIVO:         adm_task_form.sp                             */
/*   NOMBRE LOGICO:   sp_adm_task_form                             */
/*   PRODUCTO:        BPL                                          */
/*******************************************************************/
/*   IMPORTANTE                                                    */
/*   Esta aplicacion es parte de los  paquetes bancarios           */
/*   propiedad de MACOSA S.A.                                      */
/*   Su uso no autorizado queda  expresamente  prohibido           */
/*   asi como cualquier alteracion o agregado hecho  por           */
/*   alguno de sus usuarios sin el debido consentimiento           */
/*   por escrito de MACOSA.                                        */
/*   Este programa esta protegido por la ley de derechos           */
/*   de autor y por las convenciones  internacionales de           */
/*   propiedad intelectual.  Su uso  no  autorizado dara           */
/*   derecho a MACOSA para obtener ordenes  de secuestro           */
/*   o  retencion  y  para  perseguir  penalmente a  los           */
/*   autores de cualquier infraccion.                              */
/*******************************************************************/
/*                          PROPOSITO                              */
/*  Procedimiento para consultas end la tabla                      */
/*  cob_workflow..wf_proceso                                       */
/*******************************************************************/
/*                     MODIFICACIONES                              */
/*   FECHA        AUTOR              RAZON                         */
/*   18/Ene/2012  Francisco Schnabel Emision Inicial               */
/*******************************************************************/
    @i_operacion         varchar(15)    = 'S',
    @i_id_proceso        int            = null,
    @i_version           int            = null,
    @i_task_id           int            = null,
    @i_component_id      int            = null,
    @i_component_detail  int            = null,
    @i_order             int            = null,			--FBO 2016/11/15 (Envia sp_clonacion_wf)
    @i_id_task_view      int            = 0,
    @o_siguiente         int            = 0 out
	
   
)
as

declare @w_contador             int,
	    @w_cuenta_reg           int,
		@w_id_task_view         int,
		@w_order                int,
		@w_cuenta_order         int,
		@w_sp_name              varchar(50)

select @w_sp_name = 'sp_adm_task_form'

if(@i_operacion != 'I' and @i_operacion != 'D')
begin
  if exists (select 1
               from bpi_task_view
              where tv_process_id = @i_id_proceso
                and tv_version_id = @i_version
                and tv_task_id    = @i_task_id)
  begin
      update bpi_task_view 
         set tv_component_id        = @i_component_id,
             tv_component_detail_id = @i_component_detail
       where tv_process_id = @i_id_proceso
         and tv_version_id = @i_version
         and tv_task_id    = @i_task_id
  end
  else
  begin
  
  	  exec cobis..sp_cseqnos
	  @i_tabla     = 'bpi_task_view',
	  @o_siguiente = @i_id_task_view out
	   
	  if @i_id_task_view is null
	  begin
		return 3107503
	  end
  
  
      insert into bpi_task_view
                 (tv_process_id,
                  tv_version_id,
                  tv_task_id,
                  tv_component_id,
                  tv_component_detail_id,
				  tv_order,
				  tv_id)
           values(@i_id_proceso,
                  @i_version,
                  @i_task_id,
                  @i_component_id,
                  @i_component_detail,
				  1,
				  @i_id_task_view)
  end
end

if(@i_operacion='I')
begin

	--Actualiza el orden de los registros
	select @w_id_task_view = 0
	select @w_contador = 0
	select @w_cuenta_order = 1
	select @w_order = 0
		
	select @w_cuenta_reg = count(1)
	from bpi_task_view 
	where tv_process_id = @i_id_proceso
	and   tv_version_id = @i_version
	and   tv_task_id    = @i_task_id
	and	  tv_id        <> @i_id_task_view
		
	while @w_contador != @w_cuenta_reg
	begin
		set rowcount 1
		
		select @w_id_task_view = tv_id,
			   @w_order = tv_order
		from bpi_task_view 
		where tv_process_id = @i_id_proceso
		and   tv_version_id = @i_version
		and   tv_task_id    = @i_task_id
		and   tv_id        <> @i_id_task_view
		and   tv_order > @w_order
		order by tv_order
		
		if(@w_cuenta_order = @i_order)
		begin
			select @w_cuenta_order = @w_cuenta_order + 1
			update bpi_task_view set tv_order = @w_cuenta_order where tv_id = @w_id_task_view
		end
		else
		begin
			update bpi_task_view set tv_order = @w_cuenta_order where tv_id = @w_id_task_view
		end
		
		select @w_contador = @w_contador + 1
		
		select @w_cuenta_order = @w_cuenta_order + 1
		
		set rowcount 0
	end

	if (@i_id_task_view > 0)
	begin
	
	  update bpi_task_view 
		 set tv_component_id        = @i_component_id,
			 tv_component_detail_id = @i_component_detail,
			 tv_order = @i_order
	   where tv_id = @i_id_task_view
	   
	   select @o_siguiente = @i_id_task_view
	   
	end
	else
	begin

	  exec cobis..sp_cseqnos
	  @i_tabla     = 'bpi_task_view',
	  @o_siguiente = @o_siguiente out
	   
	  if @o_siguiente is null
	  begin
		return 3107503
	  end

	  insert into bpi_task_view
				 (tv_process_id,
				  tv_version_id,
				  tv_task_id,
				  tv_component_id,
				  tv_component_detail_id,
				  tv_order,
				  tv_id)
		   values(@i_id_proceso,
				  @i_version,
				  @i_task_id,
				  @i_component_id,
				  @i_component_detail,
				  @i_order,
				  @o_siguiente)
		
	end

end

if(@i_operacion='D')
begin

	if exists(select 1 from bpi_task_view where tv_id = @i_id_task_view)
	begin
  
		delete from bpi_task_view where tv_id = @i_id_task_view
	
		if @@error != 0
		begin
		  exec cobis..sp_cerror
			   @t_from  = @w_sp_name,
			   @i_num   = 3107505
		end
		
		--Actualiza el orden de los registros
		select @w_id_task_view = 0
		select @w_contador = 0
		select @w_cuenta_order = 1
        select @w_order = 0
		
		select @w_cuenta_reg = count(1)
		from bpi_task_view 
		where tv_process_id = @i_id_proceso
		and   tv_version_id = @i_version
		and   tv_task_id    = @i_task_id
		and   tv_id        <> @i_id_task_view
		
		while @w_contador != @w_cuenta_reg
		begin
			set rowcount 1
			
			select @w_id_task_view = tv_id,
				   @w_order = tv_order
			from bpi_task_view 
			where tv_process_id = @i_id_proceso
			and   tv_version_id = @i_version
			and   tv_task_id    = @i_task_id
			and   tv_id        <> @i_id_task_view
			and   tv_order > @w_order
			order by tv_order
						
			update bpi_task_view set tv_order = @w_cuenta_order where tv_id = @w_id_task_view
			
			select @w_contador = @w_contador + 1
			
			select @w_cuenta_order = @w_cuenta_order + 1
			
			set rowcount 0
			
		end
	
	end
	else
	begin  
		exec cobis..sp_cerror
			 @t_from       = @w_sp_name,
			 @i_num        = 3107501
	end
end

return 0 
go
