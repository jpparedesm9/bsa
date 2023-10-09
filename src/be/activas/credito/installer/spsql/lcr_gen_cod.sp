/************************************************************************/
/*      Archivo:                lcr_gen_cod.sp                          */
/*      Stored procedure:       sp_lcr_gen_cod_registro                 */
/*      Base de datos:          cob_credito                             */
/*      Producto:               Credito                                 */
/*      Disenado por:           AINCA                                   */
/*      Fecha de escritura:     Jun/2019                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'COBISCORP'.                                                    */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBISCORP o su representante.          */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Generar un código de registro que será solicitado en la         */
/*      aplicación Business to Client.                                  */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 RAZON                 */
/*    15/Jun/2019           AINCA              Emision Inicial          */
/************************************************************************/

use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_lcr_gen_cod_registro')
    drop proc sp_lcr_gen_cod_registro
go

create proc sp_lcr_gen_cod_registro(
--@i_fecha_valida  datetime,
@o_cod_id_reg   varchar(6)  output
)
as

declare
@w_sp_name              varchar(25),
@w_numero_digitos       int,
@w_upper                int,
@w_lower                int,
@w_random               int,
@w_str_result           varchar(6),
@w_str_number           varchar(1),
@w_bandera_generacion   int,
@w_bandera_prueba       int,
@w_cod_registro         int,
@w_fecha_proceso        datetime

-- Variables
select @w_sp_name = 'sp_lcr_gen_cod_registro'
select @w_str_result = ''
select @w_numero_digitos = 6
select @w_bandera_generacion = 0 
-- Variables para generar aleatorio entre 0 y 9 
select @w_lower = 0  -- numero menor 
select @w_upper = 9  -- numero mayor

--Se obtiene la fecha de proceso
select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso


while 1 = 1
begin
   while @w_bandera_generacion<@w_numero_digitos
   begin
   select @w_random = ROUND(((@w_upper - @w_lower -1) * RAND() + @w_lower), 0)
   select @w_str_number = convert(varchar(6),@w_random) 
   select @w_str_result = @w_str_result + @w_str_number   
   select @w_bandera_generacion = @w_bandera_generacion + 1   
   end
   
   select @w_cod_registro = count(1)
   from cob_credito..cr_b2c_registro
   where rb_registro_id = @w_str_result
   and rb_fecha_ingreso = @w_fecha_proceso
   
   if @w_cod_registro = 0
   begin  
     print 'Ingreso a enviar el codigo'
     break
   end
   else
   begin
   print 'Codigo repetido'
      select @w_bandera_generacion = 0 
      select @w_str_result = ''
      
   end

end

select @o_cod_id_reg = @w_str_result

return 0

go