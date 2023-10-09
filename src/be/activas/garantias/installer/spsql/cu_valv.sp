/************************************************************************/
/*  Archivo:            cu_valv.sp                                      */ 
/*  Stored procedure:   sp_valoracion_vivienda                          */
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
/*las garantías de bienes inmuebles con destinos vivienda.              */
/* **********************************************************************/
/*                       MODIFICACIONES                                 */
/* FECHA       AUTOR     RAZON                                          */
/* 18/jul/2005 A.Tovar   Emsion Inicial                                 */                                                         
/************************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_valoracion_vivienda')
   drop proc sp_valoracion_vivienda
go

create proc sp_valoracion_vivienda(
	@t_debug         char(1)          = 'N',
	@t_file          varchar(10) 	  = null,
	@s_date          datetime         = null,
	@i_fecha         varchar(10)      = null,
	@s_user		 login    	  = null
)

as 
declare  /* Declaracion de Variables */
	 @w_sp_name		varchar(32),
	 @w_return		int,
	 @w_mes		varchar(10),
	 @w_tvobno		int,
	 @w_tvobre		int,
	 @w_vivienda		char,
	 @w_codigo_externo	varchar(64), 
	 @w_valor_actual		money, 
	 @w_oficina		int,
	 @w_ciudad		int,
	 @w_filial			smallint,
	 @w_tipo			catalogo,
	 @w_custodia		int,
	 @w_dias			datetime,
	 @w_porcentaje		float,
	 @w_sucursal		smallint,
	 @w_tipo_sup		varchar(64),
	 @w_valor_actual_gar	money,
	 @w_estrato		descripcion,
	 @w_item			tinyint,
	 @w_paritem		descripcion,
	 @w_mensaje             varchar(255),
	 @w_define              int,
	 @w_valor_ini_pre       money,
 	 @w_valor_ini_act       money

	 
	 
         
         
/* DATOS GENERALES */
select @w_sp_name = 'sp_valoracion_vivienda'

if @s_date is null
   select @s_date	  = fc_fecha_cierre
   from cobis..ba_fecha_cierre
   where fc_producto = 21

select @w_mes     = convert(varchar,datepart(mm,@s_date))


/*Validar que se encuentre en la tabla de procesos y correspondencias*/

if not exists (select 1
	from cob_credito..cr_corresp_sib
	where tabla = 'T42'
	and codigo_sib = @w_mes)
begin
	print 'Mes No Valido para Valoración'
	return 1
end	
	
/*Proceso para Valoracion*/

Truncate  table cob_custodia..cu_tmp_valorcart
Truncate  table cob_custodia..cu_tmp_valgarv
truncate table  cob_custodia..cu_error_valv

select @w_paritem  = pa_char    -- FAG
from cobis..cl_parametro
where pa_producto = 'GAR'
and pa_nemonico = 'ITEST'
set transaction isolation level read uncommitted   

if @w_paritem is null
begin
    exec cobis..sp_cerror
    @t_from  = @w_sp_name,
    @i_num   = 101077
    return 1 
end

select @w_vivienda   = pa_char    -- FAG
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
	
	insert into cob_custodia..cu_tmp_valorcart
	(tv_codigo_externo,tv_valor,tv_clase,tv_oficina,tv_tipo)
        select  distinct cu_codigo_externo, 
		cu_valor_actual, 
		de_clase, 
		cu_oficina, 
		cu_tipo
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
	and tr_tipo in ('O','R','M') and de_codigo_inversion > ''      -- Tipo Normalizacion
	and de_codigo_inversion  = tr_destino
	and cu_filial = 1
        and de_clase = @w_vivienda

	fetch cur_oficina into
	@w_oficina
end   --while 

close cur_oficina
deallocate cur_oficina 


/*Cursor*/


declare cur_aplica cursor for
select tv_codigo_externo, tv_valor,tv_oficina,tv_tipo
from cob_custodia..cu_tmp_valorcart 
where  tv_codigo_externo > ''


open cur_aplica 
 
fetch cur_aplica into
@w_codigo_externo, 
@w_valor_actual, 
@w_oficina,
@w_tipo


while (@@fetch_status = 0) 
begin



        select @w_item             = null,
               @w_estrato          = null,
               @w_ciudad           = null,
	       @w_porcentaje       = 0,
	       @w_define           = 0,
	       @w_valor_actual_gar = 0

	select @w_item = it_item
	from cob_custodia..cu_item
	where it_nombre = @w_paritem 
	and it_tipo_custodia  = @w_tipo

	if @w_item is null
	begin
	   select @w_mensaje = 'No existe definido el Item Estrato para el Tipo de Garantia',
                  @w_define = 1
   	   insert into cu_error_valv
           values(@w_codigo_externo, @w_mensaje)

	end

	select @w_estrato = ic_valor_item
	from cob_custodia..cu_item_custodia
	where ic_tipo_cust = @w_tipo
	and ic_codigo_externo = @w_codigo_externo
	and ic_item = @w_item

	--Ciudad de la garantia 	
	select @w_ciudad = cu_ciudad_gar,
               @w_valor_ini_pre =  cu_valor_inicial
	from cob_custodia..cu_custodia
	where cu_codigo_externo = @w_codigo_externo

       if @w_ciudad is null or @w_estrato is null
	begin
	   select @w_mensaje = 'No existe ciudad y/o estrato definidos',
                  @w_define = 1

  	   insert into cu_error_valv
           values(@w_codigo_externo, @w_mensaje)

	end

	if @w_ciudad is not null
	begin
 	              
	   --Porcentaje para la valoracion	
           select @w_porcentaje = isnull(cp_porcentaje,0)
           from cu_ciu_porcest 
           where cp_ciudad = convert(varchar(10), @w_ciudad)
           and cp_estrato = @w_estrato

           if @w_porcentaje = 0
           begin
	      select @w_mensaje = 'No existe definido el porcentaje para el Estrato y la ciudad',
                     @w_define = 1

              insert into cu_error_valv
              values(@w_codigo_externo, @w_mensaje)
           end
	end

	if @w_valor_actual is null
	begin
	   select @w_mensaje = 'El valor de la garantia no es valido',
                  @w_define = 1

   	   insert into cu_error_valv
           values(@w_codigo_externo, @w_mensaje)

	end

	
	if @w_porcentaje > 0 and @w_define = 0
	begin
           select @w_valor_actual_gar = @w_valor_ini_pre + (@w_valor_ini_pre * @w_porcentaje/100)

	   exec sp_compuesto
                @t_trn       = 19245,
                @i_operacion = 'Q',
                @i_compuesto = @w_codigo_externo,
                @o_filial    = @w_filial out,
                @o_sucursal  = @w_sucursal out,
                @o_tipo      = @w_tipo out,
                @o_custodia  = @w_custodia out
	
           select @w_tipo_sup = tc_tipo_superior
           from cob_custodia..cu_tipo_custodia
           where tc_tipo = @w_tipo
	
           exec @w_return = sp_modvalor
                @s_date            = @s_date, 
                @s_user            = @s_user,
                @i_operacion       = 'I',
                @i_filial          = @w_filial ,
                @i_sucursal        = @w_sucursal ,
                @i_tipo_cust       = @w_tipo ,
                @i_custodia        = @w_custodia ,
                @i_fecha_tran      = @s_date,
                @i_debcred         = 'D',
                @i_valor           = @w_valor_actual,
                @i_descripcion     = 'VALORACION DE GARANTIA',
                @i_usuario         = 'crebatch',
                @i_autoriza        = 'crebatch',
                @i_nuevo_comercial = @w_valor_actual_gar,
                @i_tipo_superior   = @w_tipo_sup
	
	   if @w_return = 0	
	   begin

               select @w_valor_ini_act =  cu_valor_inicial
               from cob_custodia..cu_custodia
                where cu_codigo_externo = @w_codigo_externo

	      --ALMACENAR COMO INSPECCION LA VALORACION
              insert into cob_custodia..cu_inspeccion
              (in_filial, in_sucursal, in_tipo_cust, in_custodia, in_fecha_insp, in_inspector, in_codigo_externo, in_registro)
              select 1, cu_sucursal, cu_tipo, cu_custodia, @s_date, 0, cu_codigo_externo, 'N'
              from cob_custodia..cu_custodia
              where cu_codigo_externo = @w_codigo_externo

              --TABLA DE REPORTE PARA CONOCER LAS GARANTIAS MODIFICADAS
	      insert into cu_tmp_valgarv
	      (tv_codigo_externo,tv_valor_ant,tv_valor_nvo, tv_ciudad , tv_estrato, tv_porcentaje)
	      values(@w_codigo_externo,@w_valor_ini_pre, @w_valor_ini_act, @w_ciudad,@w_estrato, @w_porcentaje)

           end
	   else
              insert into cu_error_valv
              values(@w_codigo_externo, @w_mensaje)

	end


	fetch cur_aplica into
	@w_codigo_externo, 
	@w_valor_actual, 
	@w_oficina,
	@w_tipo
end   --while 

close cur_aplica
deallocate cur_aplica 

return 0

go

