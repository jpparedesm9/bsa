/************************************************************************/
/*	Archivo:		genseach.sp				*/
/*	Stored procedure:	sp_secuencial_ach			*/
/*	Base de datos:		cob_compensacion			*/
/*	Producto: 		Cartera					*/
/*	Disenado por:  		Elcira Pelaez Burbanco			*/
/*	Fecha de escritura:	Febrero 2001 				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA"							*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/  
/*				PROPOSITO				*/
/*	Procedimiento que genera el secuencial  para interfaz ACH	*/
/*      Operaciones:							*/
/*                  'I' Genera por producto e Insertar secuencial en    */
/*                      ach_secuencial            			*/
/*                  'U' Actualiza el secuencial por producto            */
/************************************************************************/  
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*									*/
/************************************************************************/
use cob_compensacion
go

if exists (select 1 from sysobjects where name = 'sp_secuencial_ach')
	drop proc sp_secuencial_ach
go

create proc sp_secuencial_ach 
   @s_date              datetime    = null,
   @i_operacion         char(1),
   @i_producto          char(3),
   @i_secuencial        varchar (64) = null,
   @o_secuencial        varchar (64) = null  out
as


declare @w_secuencial    varchar (64),
        @w_long_producto tinyint,
	@w_prod          char(3),
        @w_secuencial_nuevo  int,
        @w_error	     int,
        @w_parte_1_sec       char(3),
        @w_parte_2_sec       char(7),
        @w_long              smallint,
        @w_secuencial_final  varchar (64)

/* Insertar secuencial */

/** PARCHADO HASTA CUANDO SE DECIDA UTILIZAR -- JCQ -- 10/10/2002 **/

/**

if @i_operacion = 'I' begin
 
 select @w_secuencial = se_secuencial
       from ach_secuencial
       where se_producto = @i_producto
 if @@rowcount = 0  begin

      select  @w_secuencial = @i_producto +
              replicate('0', 5) + '1'
  
  insert into ach_secuencial values(@i_producto,@w_secuencial)	
  if @@error != 0 return 250003

  select  @o_secuencial = @w_secuencial
 end
 else
  select  @o_secuencial = @w_secuencial
end   


if @i_operacion = 'U' begin

  select @w_parte_1_sec = substring(@i_secuencial,1,3)
  select @w_parte_2_sec = substring(@i_secuencial,4,6)

  select @w_secuencial_nuevo = convert(int,@w_parte_2_sec) + 1
  select @w_secuencial = convert(varchar,@w_secuencial_nuevo)


  while 1 = 1 begin
    select @w_long = char_length(@w_secuencial) 
    select @w_secuencial = '0' + @w_secuencial  
    
    if @w_long = 5
       break
   end 

 
  select @w_secuencial_final = @w_parte_1_sec + @w_secuencial

  update ach_secuencial
  set se_secuencial = @w_secuencial_final
  where se_producto = @i_producto
  if @@error != 0  return  250004

end /*Actualizar*/

**/

return 0


go

