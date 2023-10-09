use cob_conta_super
go
if exists (select 1 from sysobjects where name = 'sp_run_provision')
  drop procedure sp_run_provision
go

/************************************************************/
/*   ARCHIVO:         run_provision.sp		               */
/*   NOMBRE LOGICO:   sp_run_provision                      */
/*   PRODUCTO:        CARTERA                               */
/************************************************************/
/*                     IMPORTANTE                           */
/*   Esta aplicacion es parte de los  paquetes bancarios    */
/*   propiedad de MACOSA S.A.                               */
/*   Su uso no autorizado queda  expresamente  prohibido    */
/*   asi como cualquier alteracion o agregado hecho  por    */
/*   alguno de sus usuarios sin el debido consentimiento    */
/*   por escrito de MACOSA.                                 */
/*   Este programa esta protegido por la ley de derechos    */
/*   de autor y por las convenciones  internacionales de    */
/*   propiedad intelectual.  Su uso  no  autorizado dara    */
/*   derecho a MACOSA para obtener ordenes  de secuestro    */
/*   o  retencion  y  para  perseguir  penalmente a  los    */
/*   autores de cualquier infraccion.                       */
/************************************************************/
/*                     PROPOSITO                            */
/*  Este procedimiento permite obtener el porcentaje de    */
/*  provision para un préstamo de acuerdo a una tabla de    */
/*	parametrización                                         */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA         AUTOR               RAZON                */
/*   29-Nov-2016   Henry Salazar       Emision Inicial.     */
/************************************************************/

create proc sp_run_provision(
	@s_ssn			   int 			= NULL,
	@s_user			   login 		= NULL,
	@s_sesn			   int 			= NULL,
	@s_term			   varchar(30) 	= NULL,
	@s_date			   datetime 	= NULL,
	@s_srv			   varchar(30) 	= NULL,
	@s_lsrv			   varchar(30) 	= NULL, 
	@s_rol			   smallint 	= NULL,
	@s_ofi			   smallint 	= NULL,
	@s_org_err		   char(1) 		= NULL,
	@s_error		   int 			= NULL,
	@s_sev			   tinyint 		= NULL,
	@s_msg			   descripcion 	= NULL,
	@s_org			   char(1) 		= NULL,
	@t_debug		   char(1) 		= 'N',
	@t_file			   varchar(14) 	= NULL,
	@t_from			   varchar(32) 	= NULL,
	@t_trn			   int 			= NULL,		
	@i_banco 		   varchar(30),
    @o_porcentaje      float  		= 0   out
)
as
declare	@w_sp_name        	varchar(32),		
		@w_error		  	int,
		@w_clase_cartera  	catalogo,
		@w_tipo_cartera   	catalogo,		
		@w_subtipo_cartera  catalogo,
		@w_codigo_subtipo   catalogo,
		@w_calificacion   	char(1),		
		@w_dias_mora	  	int,
		@w_per_cuota 		int,
		@w_periodo_cuota    varchar(30)		

select @w_sp_name = 'sp_run_provision'

select @w_clase_cartera 	= do_clase_cartera,
	   @w_tipo_cartera  	= do_tipo_cartera,
	   @w_subtipo_cartera 	= do_subtipo_cartera,
	   @w_calificacion      = do_calificacion,
	   @w_per_cuota         = do_periodicidad_cuota,
	   @w_dias_mora         = do_dias_mora_365
from sb_dato_operacion
where do_banco = @i_banco

if @@rowcount > 0
begin
	--MICROCREDITO
	select @w_codigo_subtipo = pa_char
	from cobis..cl_parametro 
	where pa_nemonico = 'CSMIC' and pa_producto = 'CCA'	
		
	if @w_codigo_subtipo = @w_subtipo_cartera
	begin		
		select @w_periodo_cuota = td_tdividendo 
		from cob_cartera..ca_tdividendo
		where td_factor = @w_per_cuota		
	
		select @o_porcentaje 		= pr_porcentaje
		from sb_provisiones
		where pr_clase_cartera 		=  @w_clase_cartera
		  and pr_subtipo_cartera 	=  @w_subtipo_cartera
		  and @w_dias_mora 			>= pr_dias_mora_ini
		  and @w_dias_mora 			<= pr_dias_mora_fin
		  and pr_periodo_cuota 		=  @w_periodo_cuota
	end 
	else
	begin		
		select @o_porcentaje 	= pr_porcentaje
		from sb_provisiones
		where pr_clase_cartera 	=  @w_clase_cartera
		  and @w_dias_mora 		>= pr_dias_mora_ini
		  and @w_dias_mora 		<= pr_dias_mora_fin
		  and pr_calificacion 	= @w_calificacion
	end
	
	if @o_porcentaje is null
	begin
		exec cobis..sp_cerror
		@t_debug  = 'N',
		@t_from   = @w_sp_name,
		@i_num    = 708153 --No existe registro de Provision
		return 708153
	end	
end
else
begin
	exec cobis..sp_cerror
		 @t_debug  = 'N',
		 @t_from   = @w_sp_name,
		 @i_num    = 6904007 --No existieron resultados asociados a la operación indicada
	return 6904007
end

go
