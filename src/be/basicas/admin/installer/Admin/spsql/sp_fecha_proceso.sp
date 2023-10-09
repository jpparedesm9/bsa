/************************************************************************/
/*  Archivo:                sp_fecha_proceso.sp                         */
/*  Stored procedure:       sp_fecha_proceso                            */
/*  Base de datos:          cobis                                       */
/*  Producto:               MIS                                         */
/*  Disenado por:           C. Espinel                                  */
/*  Fecha de escritura:     24/JUN/94                                   */
/************************************************************************/
/*                               IMPORTANTE                             */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "COBIS".                                                            */
/*  Su  uso no autorizado  queda expresamente  prohibido asi como       */
/*  cualquier   alteracion  o  agregado  hecho por  alguno de sus       */
/*  usuarios   sin el debido  consentimiento  por  escrito  de la       */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*              PROPOSITO                                               */
/*  Este programa devuelve la fecha de proceso del sistema              */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA       AUTOR       RAZON                                       */
/************************************************************************/

use cobis 
go

if exists (select * from sysobjects where name = 'sp_fecha_proceso')
   drop proc sp_fecha_proceso
go

create proc sp_fecha_proceso (
    @i_operacion        char(1) = null,
    @i_formato_fecha    int     = 101
)
as

declare @w_return       int,
        @w_sp_name  varchar(32)
DECLARE
    @w_fecha           DATETIME,
    @w_ciudad_nacional INT 

select @w_sp_name = 'sp_fecha_proceso'

if(@i_operacion = 'S')
begin
   -- Envio resultado de producto instalado y fecha de proceso
      select convert(char(10),fp_fecha,@i_formato_fecha)
      from cobis..ba_fecha_proceso
end

if(@i_operacion = 'L') -- dia laborale anterior a hoy
begin
    select @w_ciudad_nacional = pa_int
    from   cobis..cl_parametro with (nolock)
    where  pa_nemonico = 'CIUN'
    and    pa_producto = 'ADM'
    
    select @w_ciudad_nacional = isnull(@w_ciudad_nacional,9999)
   
   select @w_fecha = fp_fecha
   from cobis..ba_fecha_proceso

   select @w_fecha = dateadd(dd, -1, @w_fecha )   
   WHILE exists(SELECT 1 FROM cobis..cl_dias_feriados 
         WHERE df_ciudad = @w_ciudad_nacional 
         AND df_fecha = @w_fecha)
   BEGIN
       select @w_fecha = dateadd(dd, -1, @w_fecha )   
   END 
   select convert(char(10),@w_fecha,@i_formato_fecha)
end

return 0



GO

