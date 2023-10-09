use cob_sincroniza
go

/************************************************************************/
/*   Archivo:              sp_limp_data_sincro.sp                       */
/*   Stored procedure:     sp_limp_data_sincro                          */
/*   Base de datos:        cob_sincroniza                               */
/*   Producto:             Sincronizacion                               */
/*   Disenado por:         AINCA                                        */
/*   Fecha de escritura:   Marzo 2019                                   */
/************************************************************************/
/*                            IMPORTANTE                                */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                            PROPOSITO                                 */
/*   Eliminar data de las tablas si_sincroniza_batch , si_sincroniza,   */
/*   si_sincroniza_det con un parametro general TPERDS en meses         */
/*   que mantiene la data segun el tiempo establecido                   */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA          AUTOR             RAZON                              */
/*  13/Marzo/2019  AINCA               Emision inicial                  */
/************************************************************************/

IF EXISTS (select * from sys.objects where name = 'sp_limp_data_sincro' and [type] = 'P')
	DROP PROCEDURE sp_limp_data_sincro
go

CREATE PROCEDURE sp_limp_data_sincro 
as
DECLARE 
@w_sp_name varchar(15),
@w_time_month int,
@w_date_result date,
@w_max_secuencial int,
@w_min_secuencial int,
@w_str  varchar(25)

select @w_sp_name = 'sp_limp_data_sincro'

select @w_time_month = pa_smallint 
from cobis..cl_parametro 
where pa_nemonico= 'TPERDS'

print '@w_time_month -- >' + convert(varchar(5),@w_time_month)

select @w_min_secuencial = 2
select @w_str = 'El parametro TPERDS es menor que' + convert(varchar(3),@w_min_secuencial)

if @w_time_month >= @w_min_secuencial
begin
   select @w_date_result = DATEADD(month,(-1)*@w_time_month,getdate())
   
   print 'getdate() -- >' + convert(varchar(25),getdate())
   print '@w_date_result() -- >' + convert(varchar(15),@w_date_result)
   
   
   -- Obtencion del indice maximo que sea menor o igual a la fecha calculada por el parametro y el datetime()
   select @w_max_secuencial = max(si_secuencial)
   from cob_sincroniza..si_sincroniza
   where si_fecha_ing  <= @w_date_result
   
   print '@w_max_secuencial -- >' + convert(varchar(5),@w_max_secuencial) 
   
   -- Eliminacion de la data en la tabla si_sincroniza_det que sea menor o igual al indice obtenido
   delete from cob_sincroniza..si_sincroniza_det
   where sid_secuencial <= @w_max_secuencial
      
   -- Eliminacion de la data en la tabla si_sincroniza que sea menor o igual al indice obtenido
   delete from cob_sincroniza..si_sincroniza
   where si_fecha_ing  <= @w_date_result
   
   -- Eliminacion de la data en la tabla si_sincroniza_batch que sea menor a la fecha obtenida
   delete from cob_sincroniza..si_sincroniza_batch
   where sb_fecha_registro <= @w_date_result
end
else
begin
   exec cobis..sp_cerror 
   @t_from = @w_sp_name, 
   @i_num = 2108027, 
   @i_msg = @w_str
end

return 0