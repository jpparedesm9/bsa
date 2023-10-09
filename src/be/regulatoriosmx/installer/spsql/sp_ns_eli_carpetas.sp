/************************************************************************/
/*  Archivo:                sp_ns_eli_carpetas.sp                       */
/*  Stored procedure:       sp_ns_eli_carpetas                          */
/*  Base de Datos:          cob_conta_super                             */
/*  Producto:               cob_conta_super                             */
/*  Disenado por:           PXSG                                        */
/*  Fecha de Documentacion: 26/06/2019                                  */
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
/*26/06/2019    PXSG                  Emision Inicial                   */
/* **********************************************************************/

use cob_conta_super
go

if exists(select 1 from sysobjects where name ='sp_ns_eli_carpetas')
	drop proc sp_ns_eli_carpetas
go

create proc sp_ns_eli_carpetas (
	@i_operacion		char(1),
	@i_formato        int         = 112,
	@t_show_version   bit         = 0
	
)

AS

Declare
@w_sp_name               varchar(32),
@w_fecha_proceso         datetime, 
@w_num_meses             int,
@w_fin_aux               datetime,
@w_fecha_eli_aux         datetime,
@w_fecha_eli             varchar (8),
@w_estado                char (1),--estado para ejecutar la eliminacion solo en el finde mes habil
@w_existe_solicitud      char (1) ,
@w_ini_mes               datetime ,
@w_fin_mes               datetime ,
@w_fin_mes_hab           datetime ,
@w_fin_mes_ant           datetime ,
@w_fin_mes_ant_hab       DATETIME ,
@w_mes_aux               int      ,
@w_anio_aux              int      , 
@w_reporte               varchar(10)

if @t_show_version = 1
begin
    print 'Stored procedure sp_lee_inter_factura, Version 1.0.0'
    return 0
end
--------------------------------------------------------------------------------------

/*  Inicializacion de Variables  */
select  @w_sp_name = 'sp_lee_inter_factura'



select @w_fecha_proceso=fp_fecha 
       from cobis..ba_fecha_proceso

select @w_num_meses=isnull(pa_int,3) 
       from cobis..cl_parametro
       where pa_nemonico='MECETC'
       and  pa_producto='REC'
       
select @w_estado = 'N'     
       

--Consulta
if @i_operacion = 'Q'
begin

if datepart(dd, @w_fecha_proceso) > 0 -- procesar con mes anterior
begin                  
    select @w_mes_aux  = datepart(mm,@w_fecha_proceso),
           @w_anio_aux = datepart(yy,@w_fecha_proceso)    
                    
    select @w_fin_aux = convert(datetime,convert(varchar,@w_mes_aux)+'/01/'+convert(varchar,@w_anio_aux))
end 

set @w_reporte='NINGUN'

EXEC cob_conta..sp_calcula_ultima_fecha_habil
     @i_reporte          = @w_reporte,
     @i_fecha            = @w_fin_aux,
     @o_existe_solicitud = @w_existe_solicitud  out,
     @o_ini_mes          = @w_ini_mes out,
     @o_fin_mes          = @w_fin_mes out,
     @o_fin_mes_hab      = @w_fin_mes_hab out,
     @o_fin_mes_ant      = @w_fin_mes_ant out,
     @o_fin_mes_ant_hab  = @w_fin_mes_ant_hab OUT
         
print ' @w_fecha_proceso    = ' + isnull(convert(varchar,@w_fecha_proceso   ),'x')    
print ' @o_existe_solicitud = ' + convert(varchar,@w_existe_solicitud)
print ' @o_ini_mes          = ' + isnull(convert(varchar,@w_ini_mes         ),'x')
print ' @o_fin_mes          = ' + isnull(convert(varchar,@w_fin_mes         ),'x')
print ' @o_fin_mes_hab      = ' + isnull(convert(varchar,@w_fin_mes_hab     ),'x')
print ' @o_fin_mes_ant      = ' + isnull(convert(varchar,@w_fin_mes_ant     ),'x')
print ' @o_fin_mes_ant_hab  = ' + isnull(convert(varchar,@w_fin_mes_ant_hab ),'x') 

if(@w_fecha_proceso=@w_fin_mes_hab)
   begin
    select @w_fecha_eli_aux = dateadd(mm, -@w_num_meses , @w_fecha_proceso )
    
    select @w_fin_aux       = dateadd(dd,-(day(dateadd(mm,1,@w_fecha_eli_aux))),dateadd(mm,1,@w_fecha_eli_aux))

    select @w_fecha_eli     = convert(varchar(10),@w_fin_aux,112)
    
    set @w_estado='S'
    select @w_fecha_eli,
           @w_estado
           
   end
else
begin
select @w_fecha_proceso,
       @w_estado
end   

end 

return 0

go
