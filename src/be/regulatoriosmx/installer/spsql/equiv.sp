/*******************************************************************/
/*  Archivo:          equiv.sp                                     */
/*  Stored procedure: sp_equivalencias                             */
/*  Base de datos:    con_conta_super                              */
/*  Producto:         Regulatorios                                 */
/*******************************************************************/
/*                         IMPORTANTE                              */
/* Esta aplicacion es parte de los paquetes bancarios propiedad    */
/* de COBISCorp.                                                   */
/* Su uso no autorizado queda expresamente prohibido asi como      */
/* cualquier alteracion o agregado  hecho por alguno de sus        */
/* usuarios sin el debido consentimiento por escrito de COBISCorp. */
/* Este programa esta protegido por la ley de derechos de autor    */
/* y por las convenciones  internacionales   de  propiedad inte-   */
/* lectual.    Su uso no  autorizado dara  derecho a COBISCorp para*/
/* obtener ordenes  de secuestro o retencion y para  perseguir     */
/* penalmente a los autores de cualquier infraccion.               */
/*******************************************************************/
/*                           PROPOSITO                             */
/* Realiza consulta de estado de cuenta de una operación           */
/*******************************************************************/
/*                        MODIFICACIONES                           */
/*  FECHA                 AUTOR           RAZON                    */
/* 02/Feb/2017            D. Cumbal       Emision Inicial          */
/* 29/May/2019            PXSG            Modificacion soporte     */
/*                                         117889                  */
/* 15/07/2019            PXSG           Requerimiento #115931      */
/* 09/09/2019            RMA            Soporte #126040            */
/* 09/10/2022            SRO            Requerimiento #193221      */
/*******************************************************************/

use cob_conta_super
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select 1 from sysobjects where name = 'sp_equivalencias')
   drop proc sp_equivalencias
go

create proc sp_equivalencias 
(
    @i_operacion                varchar(10) = 'Q',
	@i_modo                     int         = 0,
    @i_catalogo                 varchar(10) = null,
	@i_catalogo_2               varchar(10) = null,
	@i_equivalencia             varchar(64),
	@o_valor_equiv              varchar(64) = null out
)                               
as                              


if @i_operacion = 'Q' begin
   if @i_modo = 0 begin
   
      if @i_catalogo = null return 601321
	  
      select @o_valor_equiv  = eq_valor_arch
      from cob_conta_super..sb_equivalencias 
      WHERE eq_catalogo      = @i_catalogo
      and 	 eq_valor_cat    = @i_equivalencia
	  
	  if @@rowcount = 0 return 601321
   end
   else if @i_modo = 1 begin
   
      if @i_catalogo = null or @i_catalogo_2 = null return 601321
	  
      select @o_valor_equiv  = eq_valor_arch
	  from cob_conta_super..sb_equivalencias 
      WHERE eq_catalogo      = @i_catalogo_2
	  and   eq_valor_cat     = ( select eq_valor_arch
                                 from cob_conta_super..sb_equivalencias 
                                 WHERE eq_catalogo    = @i_catalogo
                                 and   eq_valor_cat   = @i_equivalencia)
								 
	  if @@rowcount = 0 return 601321
   end
   else if @i_modo = 3 begin
   
      if @i_catalogo_2 = null return 601321
	  
      select @o_valor_equiv  = eq_valor_cat
      from cob_conta_super..sb_equivalencias 
      WHERE eq_catalogo      = @i_catalogo_2
      and 	eq_valor_arch    = @i_equivalencia
	  
	  if @@rowcount = 0 return 601321
   end

end                        
return 0 
go