/************************************************************************/
/*  Archivo:            fn_formato_num_txt.sp                           */
/*  Function:           fn_formato_num_txt                              */
/*  Base de datos:      cob_conta_super                                 */
/*  Producto:           M.I.S.                                          */
/*  Disenado por:                                                       */
/*  Fecha de escritura:                                                 */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de 'COBISCorp'.                                                     */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                           PROPOSITO                                  */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA         AUTOR             RAZON                               */
/* 01/Abril/2020  D. Cumbal      Formato numero en texto                */
/************************************************************************/
USE cob_conta_super
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

if exists (select * from sysobjects where name = 'fn_formato_num_txt')
    drop function fn_formato_num_txt
go

create function fn_formato_num_txt
(
@i_monto      money,
@i_tamanio    int  ,
@i_decimales  int   
)
returns varchar(50)
as
begin
   declare @w_valor_str varchar(50),
           @w_valor     varchar(50),
           @w_enteros   int
    
   select @w_enteros = @i_tamanio -  @i_decimales 
   select @w_valor_str = convert(varchar(50),@i_monto)
   
   select @w_valor = case when charindex('-',@w_valor_str) > 0 then      
                          '-' + replicate ('0',(@w_enteros - len(substring(@w_valor_str,2,charindex('.',@w_valor_str))))) + substring(@w_valor_str,2,charindex('.',@w_valor_str)-1)
                           +  substring(@w_valor_str,charindex('.',@w_valor_str)+1, len(@w_valor_str)) + '0'
                     else
                           replicate ('0',(@w_enteros - len(substring(@w_valor_str,1,charindex('.',@w_valor_str))))) + substring(@w_valor_str,1,charindex('.',@w_valor_str))
                           + substring(@w_valor_str,charindex('.',@w_valor_str)+1, len(@w_valor_str)) + '0'
                     end
  return @w_valor
end

go

