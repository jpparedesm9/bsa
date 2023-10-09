/************************************************************************/
/*      Archivo:                maestach.sp                             */
/*      Stored procedure:       sp_maestro_ach                          */
/*      Base de datos:          cob_compensacion                        */
/*      Producto:               Cartera                                 */
/*      Disenado por:           Elcira Pelaez Burbano		        */
/*      Fecha de escritura:     Feb. 2001                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/  
/*                              PROPOSITO                               */
/*      Crear un registro en la tabla maestra ach_maestro               */
/*      de carga o prenotificacion					*/
/*									*/
/*       Operaciones:							*/
/*	 	    "E"  = Ejecuta sp_prenotificar_ach para evaluar     */
/*		           la existencia de la cuenta y el cliente en   */
/*	                   el archivo ach_prenotificados                */
/*	 	    "C"  = Inserta en ach_maestro en registro de carga  */
/*		           ACH                                          */
/*	 	    "P"  = Inserta en ach_maestro en registro de        */
/*                         prenotificaci•n                              */
/************************************************************************/  
/*                              MODIFICACIONES                          */
/*                                                                      */
/************************************************************************/  
use cob_compensacion
go

if exists (select 1 from sysobjects where name = 'sp_maestro_ach')
	drop proc sp_maestro_ach
go
create proc sp_maestro_ach
   @s_user		varchar (14)= null,
   @s_ofi 		smallint    = null,
   @s_date              datetime    = null,
   @i_producto_cobis    char(3)     = null,  ---Abreviatura
   @i_valor             money       = null,
   @i_codigo_banco	int         = null,
   @i_cliente   	int         = null,
   @i_producto_cuenta   tinyint     = null,
   @i_cuenta    	varchar (64)= null,
   @i_des_transaccion  	varchar (64)= null,
   @i_referencia        int         = null,---Secuencial Transaccion
   @i_camara    	char(1)     = null,---'A' ACH - 'S' Swift -  'C' Cenit
   @i_operacion         char(1)     = 'C',  --- 'P'prenotificar, 'C' Cargar
   @o_respuesta         char(1)     = null out
  
as
declare 
   @w_sp_name           	varchar (64),
   @w_return            	int,
   @w_error             	int,
   @w_secuencial        	varchar (64),
   @w_nombre			varchar (64),
   @w_nit                       varchar (64),
   @w_cod_carga         	char(10),
   @w_cod_prenotificacion       char(10),
   @w_respuesta                 char(1)
   
/* CARGAR VALORES INICIALES */
select @w_sp_name = 'sp_maestro_ach'




if @s_date is null
   select @s_date = convert(varchar(12),getdate(),(101))


if @i_camara is null
   select @i_camara = 'A'


 
if @i_producto_cuenta = 4 ---Ahorros
   select @w_cod_carga = '32',
          @w_cod_prenotificacion = '33'

if @i_producto_cuenta = 3 ---Corrientes
   select @w_cod_carga = '22',
          @w_cod_prenotificacion = '23'

select 
       @w_nit     = en_ced_ruc,
       @w_nombre = p_p_apellido  + ' ' +   p_s_apellido + ' ' + en_nombre
from cobis..cl_ente
where en_ente = @i_cliente 
set transaction isolation level read uncommitted


/** PARCHADO HASTA CUANDO SE DECIDA UTILIZAR -- JCQ -- 10/10/2002 **/

/**

/*Inicio evaluar existencia en el sp prenotificados*/
/*Inicialmente y al hacer efectiva la transaccion  */
if @i_operacion = 'E'
 begin
    exec @w_return = sp_prenotificar_ach
     @s_user                 = @s_user,              
     @s_date                 = @s_date,              
     @s_ofi                  = @s_ofi,  
     @i_operacion            = @i_operacion,
     @i_cliente              = @i_cliente,
     @i_cuenta               = @i_cuenta,
     @o_respuesta            = @w_respuesta out

   if @w_return != 0 
   begin
      return  @w_return
   end  
   else
   begin 
     select @o_respuesta = @w_respuesta
     if @o_respuesta = '0'  
       return 0
    end
 end  /* operacion E  */



/*Cargar Informacion*/

if @i_operacion = 'C'
begin

 if not exists(select 1 from ach_maestro
    where ma_referencia = @i_referencia
      and ma_estado = 'N'
      and ma_tipo_cuenta in ('23','33')) ---Archivo  prenotificado en proceso
    begin

      exec @w_return = sp_secuencial_ach
      @s_date        = @s_date,
      @i_operacion   = 'I',
      @i_producto    = @i_producto_cobis,
      @o_secuencial  = @w_secuencial out


      insert into ach_maestro values (@w_nit,        @i_valor,
				     @w_nombre,     @i_codigo_banco,
				     @w_cod_carga,  @i_cuenta,
				     @w_secuencial, @i_des_transaccion,
				     @s_date,       @s_date,       
				     'N',           @i_camara,
				     @i_referencia)
      if @@error <> 0 return 250002


      /*Actualiza secuencial */

      exec @w_return = sp_secuencial_ach
      @s_date        = @s_date,
      @i_operacion   = 'U',
      @i_producto    = @i_producto_cobis,
      @i_secuencial  = @w_secuencial
      if @w_return != 0 return  250004

   select  @o_respuesta = '1'      
   end
else		---Como existe retorna error hasta que se prenotifique
  return 250009

end  /* operacion C */


/*Cargar Informacion en maestro como prenotificacion*/
if @i_operacion = 'P'
begin

 if not exists(select 1 from ach_maestro
   where ma_referencia = @i_referencia
    and ma_estado = 'N'
    and ma_tipo_cuenta in ('23','33'))
  begin

    exec @w_return = sp_secuencial_ach
      @s_date        = @s_date,
      @i_operacion   = 'I',
      @i_producto    = @i_producto_cobis,
      @o_secuencial  = @w_secuencial out


     insert into ach_maestro values (@w_nit,        @i_valor,
				     @w_nombre,     @i_codigo_banco,
				     @w_cod_prenotificacion,  @i_cuenta,
				     @w_secuencial, @i_des_transaccion,
				     @s_date,       @s_date,       
				     'N',           @i_camara,
				     @i_referencia)
     if @@error <> 0 return 250002


    /*Actualiza secuencial */

    exec @w_return = sp_secuencial_ach
      @s_date        = @s_date,
      @i_operacion   = 'U',
      @i_producto    = @i_producto_cobis,
      @i_secuencial  = @w_secuencial
     if @w_return != 0 return  250004

      select  @o_respuesta = '1'
  end
   else
    return 250010

end  /*operacion P */

**/

return 0


go

