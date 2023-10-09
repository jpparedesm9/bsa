/***********************************************************************/
/*	Archivo:			    cu_camfa.sp                                */
/*	Stored procedure:		sp_cambios_fag                             */
/*	Base de Datos:			cob_custodia                               */
/*	Producto:			    Custodia                                   */
/*	Disenado por:			Silvia Portilla                            */
/*	Fecha de Documentacion: 	10/Mar/2005                            */
/***********************************************************************/
/*			IMPORTANTE		       		                               */
/*	Este programa es parte de los paquetes bancarios propiedad de      */
/*	"MACOSA",representantes exclusivos para el Ecuador de la           */
/*	AT&T							                                   */
/*	Su uso no autorizado queda expresamente prohibido asi como         */
/*	cualquier autorizacion o agregado hecho por alguno de sus          */
/*	usuario sin el debido consentimiento por escrito de la             */
/*	Presidencia Ejecutiva de MACOSA o su representante	               */
/*			PROPOSITO				                                   */
/*	Este store procedure dada una monto y la moneda  	               */ 
/*	retorna el monto traducido a la moneda local		               */
/*								                                       */
/***********************************************************************/
/*			MODIFICACIONES				                               */
/*	FECHA		AUTOR			RAZON		                           */
/*	26/05/2005	Angela Tovar	Emision Inicial	                       */
/***********************************************************************/

use cob_custodia
go


if exists (select 1 from sysobjects where name = 'sp_cambios_fag')
    drop proc sp_cambios_fag
go


create proc sp_cambios_fag 
(
   @i_fecha              varchar(30)   = null   
)

as
declare
   @w_today		       datetime,     /* fecha del dia */ 
   @w_sp_name          varchar(32),  /* nombre stored proc*/
   @w_dias             int,
   @w_tipo_esp         varchar(64) 

select @w_today = getdate()
select @w_sp_name = 'sp_cambios_fag'

  
truncate table cob_custodia..cu_cambios_garantias

-- establecer parametro para la garantía FAG

select @w_tipo_esp = pa_char
from cobis..cl_parametro
where pa_producto = 'GAR'
and pa_nemonico = 'FAG'

-- Establecer el parámetro para los días adcicionales al desembolso para generear el reporte

select @w_dias =  pa_int
from cobis..cl_parametro
where pa_producto = 'GAR'
and pa_nemonico = 'DCAFAG'

--Tabla temporal que almacene los tipos y subtipo de la garantía FAG

create table #tipo (tipo varchar(64))

insert into #tipo
select tc_tipo
from cob_custodia..cu_tipo_custodia
where tc_tipo   = @w_tipo_esp
union
select tc_tipo
from cob_custodia..cu_tipo_custodia
where tc_tipo_superior = @w_tipo_esp
union
select tc_tipo
from cob_custodia..cu_tipo_custodia
where tc_tipo_superior in (select tc_tipo
                            from cob_custodia..cu_tipo_custodia
                            where tc_tipo_superior = @w_tipo_esp)

--- Selccionar datos para el reporte

insert into cob_custodia..cu_cambios_garantias
select 
op_oficina,
null,
op_banco,
op_fecha_liq,
op_monto,
op_cliente, 
null,
op_nombre,
ga_gar_nueva,
ga_gar_anterior,
gp_porcentaje
from cob_credito..cr_gar_propuesta,
cob_custodia..cu_custodia,
cob_cartera..ca_operacion,
cob_credito..cr_gar_anteriores
where gp_garantia = cu_codigo_externo
and cu_tipo in  (select tipo from #tipo)
and gp_tramite       = op_tramite
and op_fecha_liq    = dateadd(dd,-@w_dias,@i_fecha)
and gp_garantia     = ga_gar_nueva
and ga_tramite      > 0
and ga_gar_nueva  > ''
and ga_operacion  > ''
and op_estado not in (99,3)
and (ga_gar_anterior is not null and ga_gar_nueva is not null)
union 
select 
op_oficina,
null,
op_banco,
op_fecha_liq,
op_monto,
op_cliente,
null,
op_nombre,
ga_gar_nueva,
ga_gar_anterior,
gp_porcentaje
from cob_credito..cr_gar_propuesta,
cob_custodia..cu_custodia,
cob_cartera..ca_operacion,
cob_credito..cr_gar_anteriores
where gp_garantia = cu_codigo_externo
and cu_tipo in (select tipo from #tipo)
and gp_tramite = op_tramite
and op_fecha_liq = dateadd(dd,-@w_dias,@i_fecha)
and gp_garantia = ga_gar_nueva
and ga_tramite > 0
and ga_gar_nueva    > ''
and ga_operacion    > ''
and op_estado not in (99,3)
and (ga_gar_anterior is null and ga_gar_nueva is not null)



-- actualizar el número de identificación del cliente

update cob_custodia..cu_cambios_garantias
set cg_id_cliente = en_ced_ruc
from cobis..cl_ente
where cg_cliente = en_ente

update cob_custodia..cu_cambios_garantias
set cg_regional = of_regional
from cobis..cl_oficina
where cg_oficina = of_oficina

return 0
go


