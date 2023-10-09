/************************************************************************/
/*  Archivo:            externo.sp                                      */
/*  Stored procedure:   sp_externo                                      */
/*  Base de datos:      cob_custodia                                    */
/*  Producto:           garantias                                       */
/*                      Rodrigo Garces / Luis Castellanos               */
/*  Fecha de escritura: Junio-1995                                      */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de la           */
/*  "NCR CORPORATION".                                                  */                      
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */  
/************************************************************************/    
/*                          PROPOSITO                                   */
/*  Este programa descifra el codigo compuesto de la garantia           */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  Jun/1995           Emision Inicial                                  */                 
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_externo')
    drop proc sp_externo
go
create proc sp_externo    (
   @i_filial             tinyint        = null,
   @i_sucursal           smallint       = null,
   @i_tipo               varchar(64)    = null,
   @i_custodia           int            = null,
   @o_compuesto          varchar(64)            out
)
as

declare
   @w_today              datetime,     /* fecha del dia */
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error              int,
   @w_parte              tinyint,
   @w_inicio             tinyint,
   @w_contador           tinyint,
   @w_longitud           tinyint,
   @w_caracter           char(1),
   @w_compuesto          varchar(64) ,
   @w_ceros              varchar(10)

/*Validacion de campos nulos*/
if @i_sucursal is null or
   @i_tipo is null or
   @i_custodia is null
   begin
      print 'No se pudo generar el CODIGO DE LA GARANTIA'
      return 1
   end



select @w_compuesto = ''

if @i_sucursal < 10
 select @w_compuesto = '0000'+convert(varchar(4),@i_sucursal)+@i_tipo
else
begin
 if (@i_sucursal >10 or @i_sucursal=10) and (@i_sucursal < 100)
   select @w_compuesto = '000'+convert(varchar(6),@i_sucursal)+@i_tipo
 if (@i_sucursal >100 or @i_sucursal=100) and (@i_sucursal < 1000)
   select @w_compuesto = '00'+convert(varchar(6),@i_sucursal)+@i_tipo
 if (@i_sucursal >1000 or @i_sucursal=1000) and (@i_sucursal < 10000)
   select @w_compuesto = '0'+convert(varchar(6),@i_sucursal)+@i_tipo
 if (@i_sucursal >= 10000)
   select @w_compuesto = convert(varchar(6),@i_sucursal)+@i_tipo
end
select @w_ceros = '000000'
select @w_longitud = datalength (convert(varchar(6),@i_custodia))
select @w_compuesto = @w_compuesto +
                      substring(@w_ceros,1,6-@w_longitud) +
                      convert(varchar(6),@i_custodia)



select @o_compuesto = @w_compuesto
return 0
go
