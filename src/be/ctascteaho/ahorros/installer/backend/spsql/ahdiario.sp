/****************************************************************************/
/*      Archivo:            ahdiario.sp                                     */
/*      Stored procedure:   sp_ahdiario                                     */
/*      Base de datos:      cob_ahorros                                     */
/*      Producto:           Cuentas Corrientes                              */
/*      Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*      Fecha de escritura: 12/Jul/1994                                     */
/****************************************************************************/
/*                              IMPORTANTE                                  */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                              PROPOSITO                                   */
/* Ejecuta todos los procesos que provocan el inicio de dia para el         */
/* modulo de cuenta de ahorros                                              */
/****************************************************************************/
/*                              MODIFICACIONES                              */
/*      FECHA           AUTOR             RAZON                             */
/*      12/Jul/1994     R.Garces          Emision inicial                   */
/*      22/Feb/1999     M. Sanguino       Peronalizacion B Caribe           */
/*      13/Abr/2000     Maria Gracia      Eliminacion de mensajes           */
/*                                        Informativos                      */    
/*      26/May/2000     Maria Gracia      Modificar Truncate por            */
/*                                        Delete en la CC_tran_monet        */   
/*      28/Jun/2016     Ignacio Yupa      Conversion SQR a SP               */ 
/****************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ahdiario')
  drop proc sp_ahdiario
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ahdiario

(  
    @t_show_version     bit         = 0,
    @i_param1           int         = null,--@w_filial           int = null,
    @i_param2           datetime    = null--@w_fecha_proceso    datetime =null,
)

AS
DECLARE
    @w_retorno          int,
    @w_anio             int,
    @w_mes              int,
    @w_return           int,
    @w_ciu              int,
    @w_ani              int,
    @w_dia              INT,
    @w_sp_name          varchar(30),    
    @w_filial           int = null,
    @w_fecha_proceso    datetime =null,
    @w_error            int,
    @w_msg              varchar(100)
    
select @w_sp_name = 'sp_ahdiario'
select @w_filial        = @i_param1
select @w_fecha_proceso = @i_param2

if @t_show_version = 1
begin
  print 'Stored procedure: %1/ Version: %2/'+ @w_sp_name + '4.0.0.0'
  return 0
end

if not exists(select 1 
                from cobis..cl_filial 
                        where fi_filial=@w_filial)
begin
    select @w_error = 1,
           @w_msg = 'No Existe Filial'
    goto ERRORFIN
end

DELETE cob_ahorros..ah_fecha_promedio

truncate table cob_ahorros..ah_tran_monet
if @@error != 0
begin
    select @w_error = @@error,
           @w_msg = 'Error al eliminar la tabla cob_ahorros..ah_tran_monet'
    goto ERRORFIN
end

truncate table cob_ahorros..ah_tran_servicio
if @@error != 0
begin
     select @w_error = @@error,
           @w_msg = 'Error al eliminar la tabla cob_ahorros..ah_tran_servicio'
    goto ERRORFIN 
end

truncate table cob_ahorros..ah_aut_retiro_ofic
if @@error != 0
begin
     select @w_error = @@error,
           @w_msg = 'Error al eliminar la tabla cob_ahorros..ah_aut_retiro_ofic'
    goto ERRORFIN
end

truncate table cob_ahorros..ah_fecha_periodo
if @@error != 0
begin
     select @w_error = @@error,
           @w_msg = 'Error al eliminar la tabla cob_ahorros..ah_fecha_periodo'
    goto ERRORFIN   
end

execute @w_return = cobis..sp_datepart
@i_fecha = @w_fecha_proceso,
@o_anio = @w_anio out

if @w_return != 0
begin    
     select @w_error = @w_return,
           @w_msg = 'Error en el sp cobis..sp_datepart'
    goto ERRORFIN  
end

execute @w_return = cob_ahorros..sp_gen_aliprom
        @i_anio  = @w_anio,
        @i_tprom = 'M'
      
if @w_return != 0
begin
    select @w_error = @w_return,
           @w_msg = 'Error en el sp cob_ahorros..sp_gen_aliprom'
    goto ERRORFIN  
end

truncate table cob_ahorros..ah_dias_laborables 
if @@error != 0
begin
       select @w_error = @@error,
           @w_msg = 'Error al eliminar la tabla cob_ahorros..ah_dias_laborables'
    goto ERRORFIN      
end

Select @w_ciu = pa_int
from cobis..cl_parametro
where pa_producto = 'CTE'
and pa_nemonico = 'CMA'

execute @w_return = sp_calcula_dias
        @i_fecha  = @w_fecha_proceso,
        @i_ciudad = @w_ciu
        
if @w_return != 0
begin
   select @w_error = @w_return,
           @w_msg = 'Error en el sp sp_calcula_dias'
    goto ERRORFIN  
end  
declare dias_laborables cursor for
 select ci_ciudad 
from cobis..cl_ciudad
where ci_ciudad in (select distinct of_ciudad from cobis..cl_oficina)
for read only

open dias_laborables
    fetch dias_laborables into @w_ciu

    /* Control de error de lectura del cursor */
      if @@fetch_status = -2
      begin                
        /* Cerrar y liberar cursor */
        close dias_laborables
        deallocate dias_laborables
        return @@fetch_status        
      end
      
while @@fetch_status = 0
    begin  
      
      execute @w_return = sp_calcula_dias
        @i_fecha  = @w_fecha_proceso,
        @i_ciudad = @w_ciu
        
      if @w_return != 0
        begin          
            close dias_laborables
            deallocate dias_laborables         
            select @w_error = @w_return,
                    @w_msg = 'Error en el sp sp_calcula_dias'
            goto ERRORFIN  
        end 
        
 fetch dias_laborables into @w_ciu      
  end

    close dias_laborables
    deallocate dias_laborables         

delete cob_ahorros..ah_val_suspenso
where vs_estado = 'C'
if @@error != 0
begin
    select @w_error = @@error,
           @w_msg = 'Error al eliminar la tabla cob_ahorros..ah_val_suspenso'
    goto ERRORFIN   
end

truncate table cob_ahorros..ah_periodo
if @@error != 0
begin
      select @w_error = @@error,
           @w_msg = 'Error al eliminar la tabla cob_ahorros..ah_periodo'
    goto ERRORFIN   
end  

execute @w_return = cobis..sp_datepart
  @i_fecha = @w_fecha_proceso,
  @o_anio  = @w_ani out,
  @o_mes   = @w_mes out,
  @o_dia   = @w_dia out

  if @w_return <> 0
        begin
            select @w_error = @w_return,
                    @w_msg = 'Error en el sp cobis..sp_datepart'
            goto ERRORFIN 
        end 
  
execute @w_return = cob_ahorros..sp_gen_periodo
        @i_anio = @w_ani

 if @w_return <> 0
        begin
            select @w_error = @w_return,
                    @w_msg = 'Error en el sp cob_ahorros..sp_gen_periodo'
            goto ERRORFIN 
        end         
--print 'Ejecucion del sp sp_gen_periodo correcto' 

truncate table cob_ahorros..ah_cuenta_batch
if @@error != 0
begin
   select @w_error = @@error,
           @w_msg = 'Error al eliminar la tabla cob_ahorros..ah_cuenta_batch'
    goto ERRORFIN    
end
--print 'Eliminacion de cuenta batch' 

insert into cob_ahorros..ah_cuenta_batch
values ('0')
if @@error != 0
begin
   select @w_error = @@error,
           @w_msg = 'Error al insertar registro en la tabla cob_ahorros..ah_cuenta_batch'
    goto ERRORFIN    
end
  
return 0

ERRORFIN:

  exec sp_errorlog
    @i_fecha       = @w_fecha_proceso,
    @i_error       = @w_error,
    @i_usuario     = 'batch',
    @i_tran        = 4026,
    @i_descripcion = @w_msg,
    @i_programa    = @w_sp_name

  return @w_error
    
GO
