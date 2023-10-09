
/************************************************************************/
/*  Archivo:                sp_eli_carpetas_mc.sp                       */
/*  Stored procedure:       sp_eli_carpetas_mc                          */
/*  Base de Datos:          cob_conta_super                             */
/*  Producto:               cob_conta_super                             */
/*  Disenado por:           PXSG                                        */
/*  Fecha de Documentacion: 29/11/2019                                  */
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
/* Devuelve la fecha para Eliminar las carpetas del FTP de Interfactura */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/*  29/11/2019    PXSG                  Emision Inicial                 */
/* **********************************************************************/

use cob_conta_super
go

if exists(select 1 from sysobjects where name ='sp_eli_carpetas_mc')
	drop proc sp_eli_carpetas_mc
go

create proc sp_eli_carpetas_mc (
	@i_operacion		char(1),
	@i_formato        int         = 103,
	@t_show_version   bit         = 0
	
)

AS

Declare
@w_sp_name               varchar(32),
@w_fecha_proceso         datetime, 
@w_num_meses             int,
@w_fin_aux               datetime,
@w_fecha_eli_aux         datetime,
@w_fecha_eli             varchar (10),
@w_estado                char (1),--estado para ejecutar la eliminacion solo en el finde mes habil
@w_mes_aux               int      ,
@w_anio_aux              int      , 
@w_reporte               varchar(10),
@w_fecha_eli_fin         varchar (8)

if @t_show_version = 1
begin
    print 'Stored procedure sp_eli_carpetas_mc, Version 1.0.0'
    return 0
end
--------------------------------------------------------------------------------------

/*  Inicializacion de Variables  */
select  @w_sp_name = 'sp_eli_carpetas_mc'

select 
@w_fecha_proceso=fp_fecha 
from   cobis..ba_fecha_proceso

select 
@w_num_meses =isnull(pa_int,3) 
from   cobis..cl_parametro
where  pa_nemonico='MECMC'
and    pa_producto='REC'
           
--Consulta
if @i_operacion = 'Q'
begin

    select @w_fecha_eli_aux = dateadd(mm, -3 , @w_fecha_proceso )
    select @w_fecha_eli     = convert(varchar(10),@w_fecha_eli_aux,103)
    select @w_fecha_eli_fin =replace(@w_fecha_eli,'/','')
    select @w_fecha_eli_fin

end   


return 0
go

