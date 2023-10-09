/*************************************************************************/
/*  Archivo:            clforfec.sp                                      */
/*  Stored procedure:   FormatoFecha                                     */
/*  Base de datos:      cobis                                            */
/*  Producto:           Clientes                                         */
/*  Disenado por:       Sandra Ortiz M.                                  */
/*  Fecha de escritura: 22-Mar-1995                                      */
/*************************************************************************/
/*              IMPORTANTE                                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*  de 'COBISCorp'.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como     */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus     */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.    */
/*  Este programa esta protegido por la ley de   derechos de autor       */
/*  y por las    convenciones  internacionales   de  propiedad inte-     */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir         */
/*  penalmente a los autores de cualquier   infraccion.                  */
/*************************************************************************/
/*               PROPOSITO                                               */
/*  Creacion de la Función Formato Fecha                                 */
/*************************************************************************/
/*               MODIFICACIONES                                          */
/*    FECHA             AUTOR               RAZON                        */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN                */
/*************************************************************************/

use cobis
GO
if exists (select
             *
           from   sys.objects
           where  object_id = object_id(N'FormatoFecha')
              and type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
  drop function FormatoFecha
go
create function FormatoFecha
(
  @TipoFormato   varchar(12),
  @i_fecha_larga varchar(30)
)
--*tipo de variable que retornamos
RETURNS varchar(12)
as
begin
  declare
    @w_anio          int,
    @w_mes           int,
    @w_dia           int,
    @w_fecha_final   datetime,
    @w_dato          bigint,
    @w_fecha_retorno varchar(12),
    @w_dato_entero   int

      
  select
    @w_dato = convert(bigint, @i_fecha_larga)
  select
    @w_dato = @w_dato / 60000
  -- select @w_fecha_retorno = 'paso'

  select
    @w_dato_entero = convert(int, @w_dato)
  --return @w_fecha_retorno
  select
    @w_fecha_final = convert(datetime, (dateadd(mi,
                                                @w_dato_entero,
                                                '1970/01/01')))
  -- select @w_fecha_retorno = CONVERT(VARCHAR(12), @w_fecha_final, 101)

  select
    @w_anio = datepart(year,
                       @w_fecha_final)
  select
    @w_mes = datepart(month,
                      @w_fecha_final)
  select
    @w_dia = datepart(day,
                      @w_fecha_final)

  select
    @w_fecha_retorno = (case
                          when @TipoFormato = 'dd/mm/yyyy' then
                          replicate('0', 2 - datalength(convert (
                          varchar(4), @w_dia )))
                          + convert (varchar(4), @w_dia ) + '/'
                          + replicate('0', 2 - datalength(convert
                          (varchar(4), @w_mes)))
                          + convert (varchar(4), @w_mes) + '/' +
                          convert (varchar(4), @w_anio)
                          when @TipoFormato = 'yyyy/mm' then
                          convert (varchar(4), @w_anio) + '/'
                          + replicate('0', 2 - datalength(convert (
                          varchar(4), @w_mes)))
                          + convert (varchar(4), @w_mes)
                          when @TipoFormato = 'yyyymm' then
                          convert (varchar(4), @w_anio)
                          + replicate('0', 2 - datalength(convert (
                          varchar(4), @w_mes)))
                          + convert (varchar(4), @w_mes)
                          else '01/01/1970'
                        end)

  ----*Retorno el valor
  return @w_fecha_retorno

end

go

