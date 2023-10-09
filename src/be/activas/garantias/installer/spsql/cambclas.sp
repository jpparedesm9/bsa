/************************************************************************/
/*  Archivo:                   cambclas.sp                              */
/*  Stored procedure:          sp_cambio_clase                          */
/*  Base de datos:             cob_custodia                             */
/*  Producto:                  Garantia                                 */
/*  Disenado por:              Xavier Tapia                             */
/*  Fecha de escritura:        19/OCT/1999                              */
/************************************************************************/
/*                       IMPORTANTE                                     */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de NCR          */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                       PROPOSITO                                      */
/*  Este programa generara el los registros contables en CARTERA        */
/*  resultado del cambio de una garantia admisible a no admisible       */
/*  cuando la garantia esta atada a una operacion.                      */
/************************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_cambio_clase')
   drop proc sp_cambio_clase
go

create proc sp_cambio_clase
 @s_user               login        = null,
 @s_term               varchar(64)  = null,
 @s_ofi                smallint     = null,
 @t_debug              char(1)      = 'N',
 @t_file               varchar(14)  = null,
 @t_from               varchar(30)  = null,
 @s_date               datetime     = null,
 @i_codigo_externo     varchar(64),
 @i_fecha_tran         datetime     = null,
 @i_usuario            login        = null,
 @i_terminal           descripcion  = null,
 @i_oficina            smallint     = null,
 @i_adecuada_noadec    char(1)      = null,
 @i_clase_cartera      char(1)      = null


as


if @i_adecuada_noadec is not null begin   --Cambio de Clase de Custodia

   update cu_custodia set
   cu_clase_custodia = @i_adecuada_noadec
   where cu_codigo_externo = @i_codigo_externo

   if @@error <> 0  return 1 
   
end

return 0

go