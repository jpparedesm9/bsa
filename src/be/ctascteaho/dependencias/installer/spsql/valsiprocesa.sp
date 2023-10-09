/******************************************************************/
/*  Archivo:            valsiprocesa.sp                           */
/*  Stored procedure:   sp_valida_siprocesa                       */
/*  Base de datos:      cob_cuentas                               */
/*  Producto:           COBIS Branch II                           */
/*  Disenado por:       Javier Bucheli                            */
/*  Fecha de escritura: 10-Sep-1998                               */
/******************************************************************/
/*                        IMPORTANTE                              */
/*  Este programa es parte de los paquetes bancarios propiedad de */
/*  'MACOSA', representantes exclusivos para el Ecuador de la     */
/*  'NCR CORPORATION'.                                            */
/*  Su uso no autorizado queda expresamente prohibido asi como    */
/*  cualquier alteracion o agregado hecho por alguno de sus       */
/*  usuarios sin el debido consentimiento por escrito de la       */
/*  Presidencia Ejecutiva de MACOSA o su representante.           */
/******************************************************************/
/*                          PROPOSITO                             */
/*  Este stored procedure permite permite validar los fines de    */
/*  de semana y los feriados.                                     */
/******************************************************************/
/*                        MODIFICACIONES                          */
/*  FECHA              AUTOR              RAZON                   */
/*  22-Jul-1998        Roxana Sánchez    Modificación             */
/******************************************************************/

use cob_cuentas
go



if exists (select * from sysobjects where id = object_id('sp_valida_siprocesa'))
  drop procedure sp_valida_siprocesa
go

CREATE proc [dbo].[sp_valida_siprocesa](
  @i_param1 Datetime    -- Fecha Proceso
)
as

Declare
  @i_fecha         Datetime,
  @w_festivo       Int,
  @w_dia           Tinyint,
  @w_ciudad_matriz Int

Select @i_fecha = @i_param1

/* Validación de Corrida Sábado o Domingo */
Select @w_dia = (datediff(day,0,@i_fecha)%7 + 1)

If @w_dia Between 6 and 7 Begin
   Print ' '
   Print 'SABADO Y DOMINGOS NO CORRE SARTA DE CAMARA'
   Return 1
End

select @w_ciudad_matriz = pa_int
from   cobis..cl_parametro
where  pa_producto = 'CTE'
and    pa_nemonico = 'CMA'

If @@rowcount <> 1 Begin
   /* Error en lectura de parametro de Ciudad Matriz */
   exec cobis..sp_cerror
   @i_num = 201196,
   @i_msg = 'ERROR EN LECTURA DE PARAMETRO DE CIUDAD'
   return 201196
End

Select @w_festivo = df_ciudad 
From cobis..cl_dias_feriados
Where df_fecha = @i_fecha
and   df_ciudad = @w_ciudad_matriz

If @@rowcount > 0 Begin
   Print ' '
   Print 'LOS FESTIVOS NO CORRE SARTA DE CAMARA'
   Return 1
End

Return 0


GO

