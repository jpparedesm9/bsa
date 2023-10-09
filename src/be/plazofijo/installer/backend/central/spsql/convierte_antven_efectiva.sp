/******************************************************************/
/*  Archivo:              c_anveef.sp                             */
/*  Stored procedure:     sp_convierte_antven_efectiva            */
/*  Base de datos:        cob_tesoreria                           */
/*  Producto:             TESORERIA                               */
/*  Disenado por:         N. Silva                                */
/*  Fecha:                04-Ene-99                               */
/******************************************************************/
/*                         IMPORTANTE                             */
/*  Esta Aplicacion es parte de los paquetes bancarios propiedad  */
/*  de MACOSA, representantes exclusivos para  el Ecuador de  la  */
/*  NCR CORPORATION.  Su uso  no  autorizado queda  expresamente  */
/*  prohibido asi como cualquier alteracion o agregado hecho por  */
/*  alguno  de sus  usuarios  sin el debido  consentimiento  por  */
/*  escrito  de  la   Presidencia  Ejecutiva   de  MACOSA  o  su  */
/*  representante                                                 */
/******************************************************************/
/*                          PROPOSITO                             */
/* Este proceso se encarga de convertir cualquier tasa anticipada */
/* o vencida a una tasa efectiva.                                 */
/******************************************************************/
/*                       MODIFICACIONES                           */
/*  FECHA          AUTOR           RAZON                          */
/*  05-Jun-2002    N. Silva        Emision Inicial                */
/******************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_convierte_antven_efectiva' and type = 'P')
   drop proc sp_convierte_antven_efectiva
go

create proc sp_convierte_antven_efectiva (
@i_tasa              float,
@i_modalidad         char(1),
@i_periodo           int,
@o_tasa_efectiva     float out
)
with encryption
as
declare
@w_mensaje           varchar(80),
@w_sp_name           varchar(30),
@w_return            int,
@w_n                 int,
@w_tper              float,
@w_aux               float,
@w_tasa_efec         float

select @w_sp_name =  'sp_convierte_antven_efectiva'

--------------------------------------------
-- Encontrar el n£mero de periodos del anio
--------------------------------------------
select @w_n = 12/@i_periodo

----------------------------------
--Validar la modalidad de la tasa
----------------------------------
if @i_modalidad = 'A'
begin
   select @w_tper = @i_tasa/@w_n
   select @w_aux = power((1-(@w_tper/100.0)),@w_n)
   select @w_tasa_efec = (1/@w_aux)-1

--print '@w_tper:%1!,@i_tasa:%2!,@w_n:%3!,@w_aux:%4!,@w_tasa_efec:%5!',@w_tper,@i_tasa,@w_n,@w_aux,@w_tasa_efec

end
else
begin
   select @w_tper = @i_tasa/@w_n
   select @w_aux  = power((1+(@w_tper/100.0)),@w_n)
   select @w_tasa_efec = (@w_aux)-1
end
-----------------------------------------------------------------
-- Asigna a la variable de output el valor de la tasa resultante
-----------------------------------------------------------------
select @o_tasa_efectiva = @w_tasa_efec*100

return 0
go
