/************************************************************************/
/*  Archivo:            fn_calculo_edad.sp                              */
/*  Function:           fn_calculo_edad                                 */
/*  Base de datos:      cobis                                           */
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
/* 29/Enero/2020  D. Cumbal     Calculo edad anios, meses y dias        */
/* 24/Agosto/2020 ACH-DCU       Validacion para meses con 31 dias-145036*/
/************************************************************************/
USE cobis
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

if exists (select * from sysobjects where name = 'fn_calculo_edad')
    drop function fn_calculo_edad
go

create function fn_calculo_edad
(
@i_fecha_inicio    datetime,
@i_fecha_fin       datetime
)
returns varchar(50)
as
begin
  declare @w_valor varchar(50)
  declare @w_fecha_i DATETIME
  declare @w_fecha_f DATETIME
  declare @w_fecha_ref DATETIME
  
  select @w_fecha_i = @i_fecha_inicio,
         @w_fecha_f = @i_fecha_fin
  
  declare @nMeses    int
  declare @nDias     int
  declare @w_meses   int,
          @w_anio    int,
          @w_dia     int,
          @w_dia_feb int
          
  select @w_meses = MONTH(@w_fecha_f),
         @w_anio  = YEAR(@w_fecha_f),
         @w_dia   = DAY (@w_fecha_i)
  
  if @w_meses = 2
  begin
     if (@w_anio % 4) = 0 
         select @w_dia_feb = 29
     else 
         select @w_dia_feb = 28
     
     if  @w_dia > @w_dia_feb 
         select @w_dia = @w_dia_feb    
  end 

  if (( @w_meses = 4 or @w_meses = 6 or @w_meses = 9 or @w_meses = 11) and @w_dia > 30)
  begin
       SELECT @w_dia = 30
  end
  
  select @w_fecha_ref = DATEFROMPARTS(@w_anio,@w_meses, @w_dia)
 
  if @w_fecha_ref > @w_fecha_f
    select @w_fecha_ref = DATEADD(MONTH,-1,@w_fecha_ref)
 
  select @nMeses = DATEDIFF(MONTH,@w_fecha_i, @w_fecha_ref)
 
  if @w_fecha_ref = EOMONTH(@w_fecha_ref)
     select @nMeses = @nMeses + 1
 
  select @nDias = DATEDIFF(DAY,@w_fecha_ref, @w_fecha_f)
 
  select @w_valor = convert(varchar(4),@nMeses/12) + '|' + convert(varchar(2),@nMeses % 12) + '|' +  convert(varchar(2),@nDias)
  

  return @w_valor
end

go

