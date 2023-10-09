/************************************************************************/
/*  Archivo:                sp_eje_lcr_etc.sp                           */
/*  Stored procedure:       sp_eje_lcr_etc                              */
/*  Base de Datos:          cob_conta_super                             */
/*  Producto:               cob_conta_super                             */
/*  Disenado por:           PXSG                                        */
/*  Fecha de Documentacion: 15/07/2019                                  */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/* Devuelve el estado de ejecucion del job para los estados de cuenta   */
/* de interfactura para las  LCR                                        */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/*16/07/2019    PXSG                  Emision Inicial                   */
/* **********************************************************************/

use cob_conta_super
go

if exists(select 1 from sysobjects where name ='sp_eje_lcr_etc')
	drop proc sp_eje_lcr_etc
go

create proc sp_eje_lcr_etc (
	@i_operacion		char(1)
	
)

AS
declare
@w_count                 int ,
@w_fecha_proceso         datetime,
@w_fecha_inicio          datetime,
@w_fecha_inicio_proceso  datetime,
@w_fecha_fin_proceso     datetime,
@w_dia_semana            int ,
@w_ejecuta               char (1)='N',
@w_dia_aux               int,
@w_mes_aux               int,
@w_anio_aux              int,
@w_dia_semana_proc       int 

set @w_count=1

select @w_fecha_proceso=fp_fecha from cobis..ba_fecha_proceso 

set @w_fecha_inicio=DATEADD(dd,-(DAY(@w_fecha_proceso)-1),@w_fecha_proceso)
set @w_dia_semana = datepart(dw, @w_fecha_inicio)

select @w_dia_semana_proc=isnull(pa_int,6)--primer dia del mes a procesar  Viernes=6
from cobis..cl_parametro 
where   pa_nemonico ='DPELCR'
and     pa_producto='REC'


select @w_dia_aux=isnull(pa_int,6) --Fin de Dia a procesar maximo 28 
from cobis..cl_parametro 
where pa_nemonico = 'FPELCR'
and pa_producto='REC'

select @w_mes_aux  = datepart(mm,@w_fecha_proceso),
       @w_anio_aux = datepart(yy,@w_fecha_proceso)    
                  
if (@i_operacion='Q')
begin
select @w_fecha_fin_proceso = convert(datetime,convert(varchar,@w_mes_aux)+'/'+convert(varchar,@w_dia_aux)+'/'+convert(varchar,@w_anio_aux))

if(@w_dia_semana=@w_dia_semana_proc)
begin

	set @w_fecha_inicio_proceso=@w_fecha_inicio

end
else
begin

	while @w_count <= 8
	begin
	
		select @w_fecha_inicio=DATEADD(DAY,+1,@w_fecha_inicio)
		select @w_dia_semana = datepart(dw, @w_fecha_inicio) 
		
		if(@w_dia_semana=6)
		begin
		set @w_fecha_inicio_proceso=@w_fecha_inicio
		
		break
		
		end
		set @w_count=@w_count+1    
   end

end

if( @w_fecha_inicio_proceso<=@w_fecha_proceso and @w_fecha_proceso<=@w_fecha_fin_proceso)
begin

	set @w_ejecuta='S'

end
--Retorna los datos al Java
select  'Inicio Proceso'= convert(varchar(10),@w_fecha_inicio_proceso,103),
        'Fecha Proceso' = convert(varchar(10),@w_fecha_proceso,103),  
        'Fin Proceso'   = convert(varchar(10),@w_fecha_fin_proceso,103), 
        'Ejecuta'       = @w_ejecuta
end
go

