/************************************************************************/
/*  Archivo:            cu_valnv.sp                                     */ 
/*  Stored procedure:   sp_valoracion_nvivienda                         */
/*  Base de datos:      COB_CUSTODIA                                    */
/*  Producto:           GARANTIAS                                       */
/*  Disenado por:       Silvia Portilla                             	*/
/*  Fecha de escritura: Julio 7 de 2005                                 */
/************************************************************************/
/*                        IMPORTANTE                                    */
/* Este programa es parte de los paquetes bancarios propiedad de        */
/* "MACOSA", representantes exclusivos para el Ecuador de la            */
/* "NCR CORPORATION".                                                   */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier */
/* alteracion o agregado hecho por alguno de sus usuarios sin el debido */
/* consentimiento por escrito de la Presidencia Ejecutiva de "MACOSA"   */
/* o su representante.                                                  */
/************************************************************************/
/*                         PROPOSITO                                    */
/*Este es un nuevo procedimiento que permite realizar la valoración de  */
/*las garantías de bienes inmuebles con destinos diferentes a vivienda. */ 
/* **********************************************************************/
/*                       MODIFICACIONES                                 */
/* FECHA       AUTOR     RAZON                                          */
/* 18/jul/2005 A.Tovar   Emsion Inicial                                 */                                                         
/************************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_valoracion_nvivienda')
   drop proc sp_valoracion_nvivienda
go

create proc sp_valoracion_nvivienda(
    	@t_debug         char(1)        = 'N',
    	@t_file          varchar(10) 	= null,
    	@s_date		 datetime	= null,
	@s_user		 login		= null,
    	@i_ciudad        catalogo       = null, 
    	@i_porcentaje    catalogo       = null,
    	@t_trn           smallint       = null,
    	@i_operacion     char(1)        = null,
    	@i_estrato       catalogo       = null
)

as 
declare  /* Declaracion de Variables */
	 @w_sp_name		varchar(32),
	 @w_return		int,
	 @w_tvobno		int,
	 @w_tvobre		int,
	 @w_vivienda		char,
	 @w_codigo_externo	varchar(64), 
	 @w_valor_actual	money, 
	 @w_oficina		int,
	 @w_ciudad		int,
	 @w_filial		smallint,
	 @w_tipo		varchar(64),
	 @w_custodia		int,
	 @w_dias		int,
	 @w_porcentaje		float,
	 @w_sucursal		smallint,
	 @w_tipo_sup		varchar(64),
	 @w_valor_actual_gar	money,
	 @w_restruct		int,
	 @w_max_fecha           datetime,
	 @w_dias_insp           int,
         @w_define              int,
         @w_mensaje             varchar(250),
	 @w_valor_ini_pre       money,
 	 @w_valor_ini_act       money
         
         
/* DATOS GENERALES */
select @w_sp_name = 'sp_valoracion_nvivienda'

if @s_date is null
   select @s_date	  = fc_fecha_cierre
   from cobis..ba_fecha_cierre
   where fc_producto = 21

Truncate  table cob_custodia..cu_tmp_valoracion
Truncate  table cob_custodia..cu_tmp_valgarnv
truncate table cob_custodia..cu_error_valvn

/* parametros */
select @w_tvobno   = pa_int    -- FAG (tiempo valorizacion de las obligaciones)
 from cobis..cl_parametro
where pa_producto = 'GAR'
and pa_nemonico = 'TVOBNO'
set transaction isolation level read uncommitted 


if @w_tvobno is null
begin
    exec cobis..sp_cerror
    @t_from  = @w_sp_name,
    @i_num   = 101077
    return 1 
end

select @w_tvobre   = pa_int    -- FAG (tiempo valorizacion obligaciones reestructurados)
from cobis..cl_parametro
where pa_producto = 'GAR'
and pa_nemonico = 'TVOBRE'
set transaction isolation level read uncommitted   

if @w_tvobre is null
begin
    exec cobis..sp_cerror
    @t_from  = @w_sp_name,
    @i_num   = 101077
    return 1 
end

select @w_vivienda   = pa_char    -- FAG (clase de cartera vivienda)
from cobis..cl_parametro
where pa_producto = 'CRE'
and pa_nemonico = 'CVIV'
set transaction isolation level read uncommitted   

if @w_vivienda is null
begin
    exec cobis..sp_cerror
    @t_from  = @w_sp_name,
    @i_num   = 101077
    return 1 
end

/* oficinas */

declare cur_oficina cursor for
select of_oficina
from    cobis..cl_oficina
where of_oficina > 0
and of_filial = 1

open cur_oficina

fetch cur_oficina into
@w_oficina

while (@@fetch_status = 0) 
begin

	insert into cob_custodia..cu_tmp_valoracion
	(tv_codigo_externo,tv_valor,tv_clase,tv_oficina,tv_reestruct, tv_aplica)
	select  cu_codigo_externo, 
		cu_valor_actual, 
		de_clase, 
		cu_oficina, 
		op_reestructuracion,
		'S'
	from cob_custodia..cu_custodia, 
	     cob_credito..cr_corresp_sib, 
	     cob_credito..cr_tramite,  
	     cob_cartera..ca_operacion,
	     cob_credito..cr_gar_propuesta, 
	     cob_credito..cr_destino_economico
	where cu_tipo = codigo
	and tabla  = 'T1'
	and cu_oficina = @w_oficina
	and gp_tramite = tr_tramite
	and tr_tramite = op_tramite
	and gp_garantia = cu_codigo_externo
	and cu_estado in ('V','X','F')
	and tr_estado in ('N','A','D')
	and tr_tipo in ('O','R','M') and de_codigo_inversion > '' -- CCA 436 Normalizacion
	and de_codigo_inversion  = tr_destino
	and cu_filial = 1
	
	fetch cur_oficina into
	@w_oficina
end   --while 

close cur_oficina
deallocate cur_oficina 


/*garantia destinada para vivienda */


select  codigo_externo = tv_codigo_externo 
into #garantia_tmp
from cu_tmp_valoracion
where tv_clase = @w_vivienda  --Parametro obtenido para la clase de cartera vivienda
group by tv_codigo_externo
having count(1) > 0 


update cu_tmp_valoracion
set tv_aplica = 'N'
from #garantia_tmp
where tv_codigo_externo = codigo_externo

/*Cursor*/

declare cur_aplica cursor for
select distinct tv_codigo_externo, tv_valor,tv_oficina
from cob_custodia..cu_tmp_valoracion 
where tv_aplica =  'S'

open cur_aplica 
 
fetch cur_aplica into
@w_codigo_externo, 
@w_valor_actual, 
@w_oficina

while (@@fetch_status = 0) 
begin

	select @w_restruct = isnull(count(1),0)
	from cu_tmp_valoracion
	where tv_reestruct = 'S'
	and tv_codigo_externo = @w_codigo_externo 

	if @w_restruct >0
	   select @w_dias = @w_tvobre
	else
	    select @w_dias = @w_tvobno  

	select @w_max_fecha = max(in_fecha_insp)
	from cob_custodia..cu_inspeccion
        where in_codigo_externo = @w_codigo_externo

        select @w_dias_insp = isnull(datediff(dd,@w_max_fecha,@s_date),0)
	
	if @w_dias_insp >= @w_dias or @w_dias_insp = 0
	begin	

	        select @w_ciudad           = null,
		       @w_porcentaje       = 0,
		       @w_define           = 0,
		       @w_valor_actual_gar = 0


		-- ciudad de la garantia
		select @w_ciudad = null
		select @w_ciudad = cu_ciudad_gar,
                       @w_valor_ini_pre =  cu_valor_inicial
		from cob_custodia..cu_custodia
		where cu_codigo_externo = @w_codigo_externo


                if @w_ciudad is null
		begin
		   select @w_mensaje = ''
                   select @w_mensaje = 'No Existe Definida Ciudad de la Garantia',
                          @w_define = 1
                   
		   insert into cu_error_valvn
                   values(@w_codigo_externo, @w_mensaje)
		end
		
                --Porcentaje 
		if @w_ciudad is not null
		begin
                   select @w_porcentaje = cp_porcentaje
                   from cu_ciudad_porcentaje
		   where cp_ciudad = convert(varchar(10),@w_ciudad)

                   if @w_porcentaje = 0
		   begin
		      select @w_mensaje = ''
                      select @w_mensaje = 'No Existe Parametrizado el Porcentaje para la Ciudad',
                             @w_define = 1
                   
	              insert into cu_error_valvn
                      values(@w_codigo_externo, @w_mensaje)
		   end
		end

		if @w_valor_actual = null
		begin
		   select @w_mensaje = ''
	           select @w_mensaje = 'El valor de la garantia no es valido',
                          @w_define = 1

   	           insert into cu_error_valv
                   values(@w_codigo_externo, @w_mensaje)

	        end

		if @w_porcentaje > 0 and @w_define = 0
		begin
		
                   --Procedimiento cambio de valor
                   select @w_valor_actual_gar = @w_valor_ini_pre + (@w_valor_ini_pre * @w_porcentaje /100)
		
                   exec sp_compuesto
			@t_trn		= 19245,
			@i_operacion	= 'Q',
			@i_compuesto	= @w_codigo_externo,
			@o_filial	= @w_filial out,
			@o_sucursal	= @w_sucursal out,
			@o_tipo		= @w_tipo	out,
			@o_custodia	= @w_custodia	out
          		
	           select @w_tipo_sup = tc_tipo_superior
                   from cob_custodia..cu_tipo_custodia
                   where tc_tipo = @w_tipo
		
		   exec @w_return = sp_modvalor
			@s_date			= @s_date,
			@s_user			= @s_user,
			@i_operacion		= 'I',
			@i_filial		= @w_filial,
			@i_sucursal		= @w_sucursal,
			@i_tipo_cust		= @w_tipo,
			@i_custodia		= @w_custodia,
			@i_fecha_tran		= @s_date,
			@i_debcred		= 'D',
			@i_valor		= @w_valor_actual,
			@i_descripcion		= 'VALOR DE GARANTIA',
			@i_usuario		= 'crebatch',
			@i_autoriza		= 'crebatch',
			@i_nuevo_comercial	= @w_valor_actual_gar,
			@i_tipo_superior	= @w_tipo_sup

                   if @w_return = 0
		   begin


                      select @w_valor_ini_act =  cu_valor_inicial
                      from cob_custodia..cu_custodia
                      where cu_codigo_externo = @w_codigo_externo

		      
		      insert into cob_custodia..cu_inspeccion
                      (in_filial, in_sucursal, in_tipo_cust, in_custodia, in_fecha_insp, in_inspector, in_codigo_externo, in_registro)
		      select 1, cu_sucursal, cu_tipo, cu_custodia, @s_date, 0 , cu_codigo_externo, 'N'
		      from cob_custodia..cu_custodia
		      where cu_codigo_externo = @w_codigo_externo

		      --TABLA DE REPORTE PARA CONOCER LAS GARANTIAS MODIFICADAS
                      insert into cu_tmp_valgarnv
	              (tv_codigo_externo,tv_valor_ant,tv_valor_nvo, tv_ciudad ,  tv_porcentaje)
                      values(@w_codigo_externo,@w_valor_ini_pre, @w_valor_ini_act,@w_ciudad, @w_porcentaje)

                   end
		   else

                      insert into cu_error_valvn
                      values(@w_codigo_externo, 'Error en el cambio de valor de la garantia')

	    end
	end
	else
	begin
	   select @w_mensaje = ''
	   select @w_mensaje = 'La garantia fue valorizada hace ' + convert(varchar,@w_dias_insp) + ' dias'
           insert into cu_error_valvn
           values(@w_codigo_externo, @w_mensaje )
        end

	
	fetch cur_aplica into
	@w_codigo_externo, 
	@w_valor_actual, 
	@w_oficina
end   --while 

close cur_aplica
deallocate cur_aplica 

return 0
go

