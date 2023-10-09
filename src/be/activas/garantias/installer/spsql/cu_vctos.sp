/***********************************************************************/
/*	Archivo:                  cu_vctos.sp                          */
/*	Stored procedure:         sp_vctos                             */
/*	Base de Datos:            cob_custodia                         */
/*	Producto:                 Custodia                             */
/*	Disenado por:             Silvia Portilla                      */
/*	Fecha de Documentacion:   05/Abril/20005                       */
/***********************************************************************/
/*			IMPORTANTE		       		       */
/*	Este programa es parte de los paquetes bancarios propiedad de  */
/*	"MACOSA",representantes exclusivos para el Ecuador de la       */
/*	AT&T							       */
/*	Su uso no autorizado queda expresamente prohibido asi como     */
/*	cualquier autorizacion o agregado hecho por alguno de sus      */
/*	usuario sin el debido consentimiento por escrito de la         */
/*	Presidencia Ejecutiva de MACOSA o su representante	       */
/***********************************************************************/
/*			PROPOSITO				       */
/*	Permite almacenar la informacion en la tabla cu_rep_venc       */
/*      para la generacion del reporte de vencimiento de Garantias     */
/***********************************************************************/
/*			MODIFICACIONES				       */
/*	FECHA		AUTOR			RAZON		       */
/*	05/04/2005	Angela Tovar	Emision Inicial	               */
/***********************************************************************/
use cob_custodia
go


if exists (select 1 from sysobjects where name = 'sp_vctos')
    drop proc sp_vctos
go


create proc sp_vctos 
(
   @i_fecha_ini        datetime,
   @i_fecha_fin        datetime
)

as
declare
   @w_today            datetime,     /* fecha del dia */ 
   @w_sp_name          varchar(32),  /* nombre stored proc*/
   @w_certifica        varchar(64),
   @w_dias             int,
   @w_item             varchar(30)


select @w_today = getdate()
select @w_sp_name = 'sp_vctos'

select @w_dias = pa_int
from cobis..cl_parametro 
where pa_producto  = 'GAR'
and pa_nemonico = 'DVCTRA' 

if @@error <> 0 
begin
    exec cobis..sp_cerror
       @t_from  = @w_sp_name,
       @i_num   = 2101008
    return 1 
end

select @w_item = pa_char
from cobis..cl_parametro 
where pa_nemonico = 'CERTRA' 
and pa_producto = 'GAR'



create table #cu_vctos
(  
   rv_codigo_externo    varchar(64) NOT NULL,
   rv_sucursal          int         NOT NULL, 
   rv_estado            char(1)     NULL,
   rv_tipo              catalogo    NULL,
   rv_valor_inicial     money       NULL,
   rv_vcto_gar          varchar(10)    NULL,
   rv_vcto_poliza       varchar(10)    NULL,
   rv_vcto_cert         varchar(10)    NULL,
   rv_custodia	        int 	    NULL
)

insert into #cu_vctos
select
distinct cu_codigo_externo,
cu_sucursal,
cu_estado,
cu_tipo,
cu_valor_inicial,
convert(char(10),cu_fecha_vencimiento,101),
null,
convert(char(10),dateadd(dd,@w_dias,convert(datetime,ic_valor_item)),101),
cu_custodia
from 
     cob_custodia..cu_custodia,
     cob_custodia..cu_item_custodia, 
     cob_custodia..cu_item, cob_credito..cr_corresp_sib
where ic_codigo_externo = cu_codigo_externo

   and cu_estado in ('P','F','V','X')
   and ic_item = it_item
   and it_nombre = @w_item

   and ic_sucursal > 0
   and ic_tipo_cust > ''
   and ic_custodia > 0
   and ic_valor_item is not null
   and tabla = 'T1'
   and codigo =   ic_tipo_cust 




if exists(select 1 from sysobjects o, syspartitions p
           where o.id = p.id
           and   o.name = 'cu_rep_venc')
	   --alter table cob_custodia..cu_rep_venc unpartition
   
truncate table cu_rep_venc

--alter table cob_custodia..cu_rep_venc partition 200



insert into cob_custodia..cu_rep_venc
select
cu_sucursal,
cu_estado,
cu_tipo,
cu_codigo_externo,
cu_valor_inicial,
convert(varchar(10),cu_fecha_vencimiento,101),
convert(varchar(10),po_fvigencia_fin,101),
null,
cu_custodia
from cob_custodia..cu_custodia,
     cob_custodia..cu_poliza
where po_codigo_externo  = cu_codigo_externo   
   and cu_estado in ('P','F','V','X') 
   and po_fvigencia_fin  between @i_fecha_ini and @i_fecha_fin
   and po_aseguradora > ''
   and po_poliza > ''
   and po_codigo_externo > ''

union
select
cu_sucursal,
cu_estado,
cu_tipo,
cu_codigo_externo,
cu_valor_inicial,
convert(varchar(10),cu_fecha_vencimiento,101),
convert(varchar(10),po_fvigencia_fin,101),
null,
cu_custodia
from cob_custodia..cu_custodia,
     cob_custodia..cu_poliza
where po_codigo_externo  = cu_codigo_externo   
   and cu_estado in ('P','F','V','X')
   and po_fvigencia_fin  is null
   and po_aseguradora > ''
   and po_poliza > ''
   and po_codigo_externo > ''

union
select
cu_sucursal,
cu_estado,
cu_tipo,
cu_codigo_externo,
cu_valor_inicial,
convert(varchar(10),cu_fecha_vencimiento,101) ,
null,
null,
cu_custodia
from cob_custodia..cu_custodia
where cu_filial = 1
   and cu_sucursal > 0
   and cu_tipo > ''
   and cu_custodia > 0
   and cu_estado in ('P','F','V','X')
   and cu_fecha_vencimiento  between @i_fecha_ini and @i_fecha_fin

union
select
cu_sucursal,
cu_estado,
cu_tipo,
cu_codigo_externo,
cu_valor_inicial,
convert(varchar(10),cu_fecha_prox_insp,101),
null,
null,
cu_custodia
from cob_custodia..cu_custodia
where cu_filial = 1
   and cu_sucursal > 0
   and cu_tipo > ''
   and cu_custodia > 0
   and cu_estado in ('P','F','V','X')
   and cu_fecha_prox_insp  between @i_fecha_ini and @i_fecha_fin

union
select
cu_sucursal,
cu_estado,
cu_tipo,
cu_codigo_externo,
cu_valor_inicial,
convert(char(10),cu_fecha_vencimiento,101),
null,
null,
cu_custodia
from cob_custodia..cu_custodia
where  cu_filial = 1
   and cu_sucursal > 0
   and cu_tipo > ''
   and cu_custodia > 0
   and cu_estado in ('P','F','V','X')
   and cu_fecha_prox_insp  is null



update cob_custodia..cu_rep_venc 
set a.rv_vcto_cert = b.rv_vcto_cert
from #cu_vctos b, cob_custodia..cu_rep_venc a
where a.rv_codigo_externo = b.rv_codigo_externo



return 0
go



