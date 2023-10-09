/******************************************************************/
/*  Archivo:              c_efanve.sp                             */
/*  Stored procedure:     sp_convierte_efectiva_antven            */
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
/* Este proceso se encarga de convertir cualquier tasa efectiva   */
/* a una tasa periodica en cualquier modalidad.                   */
/******************************************************************/
/*                       MODIFICACIONES                           */
/*  FECHA          AUTOR           RAZON                          */
/*  05_jun-2002    N. Silva        Emision Inicial                */
/******************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_convierte_efectiva_antven' and type = 'P')
   drop proc sp_convierte_efectiva_antven
go

create proc sp_convierte_efectiva_antven(
@i_tasa_efectiva     float,
@i_modalidad         char(1),
@i_periodo           int,
@o_tasa_convrndt     float out
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
@w_tasa_conv         float

select @w_sp_name =  'sp_convierte_efectiva_antven'

-------------------------------------------
-- Encontrar el n£mero de periodos del anio
-------------------------------------------
select @w_n = 12/@i_periodo

-----------------------------------
-- Validar la modalidad de la tasa
-----------------------------------
if @i_modalidad = 'A'
begin
   select @w_tper = @i_tasa_efectiva
   select @w_aux = power((1+(@w_tper/100.0)),(1.0/@w_n))
   select @w_tasa_conv = (1-(1/@w_aux))*@w_n
end
else
begin
   select @w_tper = @i_tasa_efectiva
   select @w_aux = power((1+(@w_tper/100.0)),(1.0/@w_n))
   select @w_tasa_conv = (@w_aux - 1.0)*@w_n

--print '@w_tper:%1!,@i_tasa_efectiva:%2!,@w_n:%3!,@w_aux:%4!,@w_tasa_conv:%5!',@w_tper,@i_tasa_efectiva,@w_n,@w_aux,@w_tasa_conv

end


--------------------------------------------------------------------
-- Asigna a la variable de output el valor de la tasa resultante
--------------------------------------------------------------------
select @o_tasa_convrndt = @w_tasa_conv * 100
return 0
go



