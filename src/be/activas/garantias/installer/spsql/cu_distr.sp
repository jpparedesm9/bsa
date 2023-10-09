/***********************************************************************/
/*	Archivo          :	   cu_distr.sp                         */
/*	Stored procedure :	   sp_distr                            */
/*	Base de Datos    :	   cob_credito                         */
/*	Producto         :	   Credito                             */
/*	Disenado por     :	   Ivonne Ordonez                      */
/*	Fecha de Documentacion:    03/Sep/2001                         */
/***********************************************************************/
/*	 	            IMPORTANTE                                 */
/*	Este programa es parte de los paquetes bancarios propiedad de  */
/*	"MACOSA",representantes exclusivos para el Ecuador de la       */
/*	AT&T                                                           */
/*	Su uso no autorizado queda expresamente prohibido asi como     */
/*	cualquier autorizacion o agregado hecho por alguno de sus      */
/*	usuario sin el debido consentimiento por escrito de la         */
/*	Presidencia Ejecutiva de MACOSA o su representante	       */
/***********************************************************************/
/*			    PROPOSITO				       */
/*	Este stored procedure permite distribuir el valor de las       */
/*	Garantias por garant­a                                         */
/***********************************************************************/
/*			  MODIFICACIONES			       */
/*	FECHA		AUTOR			RAZON	               */
/*	03/Sep/2001	Pablo Gaibor		Emision Inicial        */
/* 07/Jul/2004     Elcira Pelaez    Insert en ca_seguros_base_garantia */
/***********************************************************************/

use cob_custodia
go
if exists (select 1 from sysobjects where name = 'sp_distr')
    drop proc sp_distr
go
create proc sp_distr (
   @i_garantia		 varchar(20) = null
)
as
declare
   @w_today              datetime,     
   @w_return             int,          
   @w_sp_name            varchar(32),  
   @w_existe             tinyint,      
   @w_codigo             varchar(10),
   @w_valor              money,
   @w_tipo_tram          char(1),
   @w_tipo_seg           varchar(64),
   @w_cont               tinyint,
   @w_tipo_gar           catalogo,
   @o_codigo             varchar(10),
   @o_tipo               char(1),
   @w_porctram     	 float,
   @w_garantiag		 varchar(64),
   @w_tramite		 int, 
   @w_disponible         money,
   @w_monto_tram         money,
   @w_monto_ori          money,
   @w_porctramite     	 float,
   @w_tramiteg           int,
   @w_clase              varchar(2),
   @w_calificacion       varchar(2),
   @w_estado_gar	 char(1),
   @w_estado_g	 	 char(1),
   @w_estado_ope  	 int,
   @w_estado             int,
   @w_abierta_c          char(1),
   @w_error              int,
   @w_fecha_cierre       datetime,
   @w_operacion          int,
   @w_tipogar_seg       varchar(64)


   select @w_fecha_cierre = fc_fecha_cierre
   from   cobis..ba_fecha_cierre
   where  fc_producto = 7 

--       begin tran
	-- CURSOR INGRESO DISTR
	declare cur_dis_prop cursor for
	select 	gp_tramite, 
		gp_garantia, 
		cu_estado,
                op_estado,
                cu_tipo,
                op_operacion
	from 	cob_credito..cr_gar_propuesta, 
		cob_cartera..ca_operacion, 
		cob_custodia..cu_custodia
        where 	gp_tramite in (	select distinct gp_tramite 
				from cob_credito..cr_gar_propuesta 
				where gp_garantia = @i_garantia)
	and     cu_estado = "V"
	and  	gp_tramite = op_tramite
        and  	op_estado not in(99)
	and 	gp_garantia = cu_codigo_externo
        order by cu_clase_custodia asc,gp_abierta desc,cu_agotada desc,cu_acum_ajuste desc
        for read only

	open  cur_dis_prop 
	fetch cur_dis_prop into 
		@w_tramiteg, 
		@w_garantiag, 
		@w_estado_gar,
		@w_estado_ope,
                @w_tipo_seg,
                @w_operacion


	while @@fetch_status = 0
        begin
	      	if @@fetch_status = -1
		begin
		close cur_dis_prop 
		deallocate cur_dis_prop 
		rollback
		return 1
		end



	if not exists (	select 1 
			from 	cob_custodia..cu_distr_garantia
		   	where  	dg_tramite  = @w_tramiteg
		   	and    	dg_garantia = @w_garantiag
                        and     dg_clase_cartera > '')
	begin
		select 	@w_calificacion = op_calificacion, 
			@w_clase  	= op_clase 
		from cob_cartera..ca_operacion
		where op_tramite = @w_tramiteg

		select @w_calificacion  = isnull(@w_calificacion ,"A")

		insert into cob_custodia..cu_distr_garantia 
		(dg_tramite, dg_garantia, dg_clase_cartera, dg_calificacion, dg_monto_exceso,
		 dg_porcentaje, dg_valor_resp_garantia,dg_estado_gar, dg_estado_ope)
		values 
		(@w_tramiteg, @w_garantiag, @w_clase, @w_calificacion,0,0,0, @w_estado_gar,@w_estado_ope )

		   if @@error != 0
		      return 1901013


	end
	else
	begin
      BEGIN TRAN
      delete cob_cartera..ca_seguros_base_garantia
      where sg_tramite  = @w_tramiteg 
      and   sg_fecha_reg  = @w_fecha_cierre
      and   sg_tipo_garantia = @w_tipo_seg
      
      if @@error != 0
           return 1901013
    
        insert into cob_cartera..ca_seguros_base_garantia              
        values (@w_tramiteg,   @w_fecha_cierre,@w_tipo_seg)


        if @@error != 0
           return 1901013

      COMMIT TRAN
		select 	@w_calificacion = op_calificacion, 
			      @w_clase  	    = op_clase 
		from cob_cartera..ca_operacion
		where op_tramite = @w_tramiteg

		select @w_calificacion  = isnull(@w_calificacion ,"A")

	  select @w_estado_gar = cu_estado
	  from cob_custodia..cu_custodia
	  where cu_codigo_externo = @w_garantiag

           update cob_custodia..cu_distr_garantia  
           set dg_calificacion 	= @w_calificacion,
               dg_clase_cartera = @w_clase,
               dg_estado_gar   	= @w_estado_gar,
	       dg_estado_ope    = @w_estado_ope
	   where dg_garantia 	= @w_garantiag 
           and   dg_tramite 	= @w_tramiteg

	   if @@error != 0
	      return 1901013


	
	end
	

	fetch cur_dis_prop into   
		@w_tramiteg, 
		@w_garantiag, 
		@w_estado_gar,
		@w_estado_ope,
	        @w_tipo_seg,
                @w_operacion

   	end
   	close cur_dis_prop 
   	deallocate cur_dis_prop 


	declare cur_distri_mas cursor for
	select  dg_tramite, 
		    dg_estado_gar,
            cu_abierta_cerrada,
            tr_tipo
	from 	cob_custodia..cu_distr_garantia, cob_custodia..cu_custodia,cob_credito..cr_tramite
	where 	dg_garantia 	  = @i_garantia
	and     cu_codigo_externo = @i_garantia
	and     dg_garantia 	  = cu_codigo_externo 
        and     dg_tramite        = tr_tramite
        group by dg_estado_ope, cu_clase_custodia, cu_abierta_cerrada, cu_agotada, dg_tramite,dg_estado_gar, tr_tipo
        order by dg_estado_ope desc, cu_clase_custodia asc, cu_abierta_cerrada desc,cu_agotada desc, dg_tramite, 
       		     dg_estado_gar, tr_tipo
        for read only

	open 	cur_distri_mas
	fetch 	cur_distri_mas into 
		@w_tramite,
		@w_estado_g,
		@w_abierta_c,
                @w_tipo_tram

	while @@fetch_status = 0
        begin
	      	if @@fetch_status = -1
		begin
		close cur_distri_mas
		deallocate cur_distri_mas                        
		--rollback
		return 1
		end


        -- Regenerar el dsiponible de las garant¡as para la nueva distribuici½n
	update 	cob_custodia..cu_custodia
	set 	cu_acum_ajuste = cu_acum_ajuste + isnull(dg_valor_resp_garantia,0)
	from  	cob_custodia..cu_distr_garantia
	where 	dg_garantia = cu_codigo_externo
        and   	cu_estado in ('V','F','X') 
	and   	dg_tramite = @w_tramite


	   if @@error != 0
	      return 1901013


	update 	cob_custodia..cu_distr_garantia
	set 	dg_valor_resp_garantia = 0
	from 	cob_custodia..cu_distr_garantia, cu_custodia
	where 	dg_tramite = @w_tramite
	and     dg_garantia = cu_codigo_externo


	   if @@error != 0
	      return 1901013


	select @w_estado = op_estado 
	from cob_cartera..ca_operacion
	where op_tramite = @w_tramite

	
	   if (@w_estado = 3 or @w_estado = 6 or @w_estado = 0)
	   begin
           	delete 	cob_custodia..cu_distr_garantia  
	   	where 	dg_tramite  = @w_tramite

		   if @@error != 0
		      return 1901013


	   end

	

	if @w_estado_g = "V"
	begin
		exec 	@w_error  = sp_distr_cust 
			@i_tramite = @w_tramite,
                        @i_tipo_tram = @w_tipo_tram

           	if @w_error <> 0 
           	begin
           	 return @w_error 
           	end
	end

	fetch cur_distri_mas into   
		@w_tramite,
		@w_estado_g,
                @w_abierta_c,
                @w_tipo_tram
   	end
   	close cur_distri_mas
   	deallocate cur_distri_mas


return 0
go
