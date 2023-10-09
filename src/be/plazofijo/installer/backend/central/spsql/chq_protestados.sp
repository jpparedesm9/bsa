/************************************************************************/
/*      Archivo:		chq_protestados.sp                     	*/
/*      Stored procedure:	sp_chq_protestados                       */
/*      Base de datos:		cob_pfijo                               */
/*      Producto:		Plazo_fijo                              */
/*      Disenado por:           Mario Andres Algarin 			*/
/*      Fecha de documentacion: 20/Oct/2009                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'COBISCORP', su uso no autorizado queda expresamente prohibido  */
/*      asi como cualquier alteracion o agregado hecho por alguno       */
/*      de sus usuarios sin el debido consentimiento por escrito de la  */
/*      Presidencia Ejecutiva de COBISCORP o su representante.          */
/************************************************************************/
/*                              PROPOSITO                               */
/*	Este programa permite hacer las devoluciones de los cheques     */
/*	protestados y la cancelacion del titulo creado con dicho cheque,*/
/*	de igual manera genera los valores por pagar, que hagan parte   */
/*	del valor total del titulo y no esten contenidos dentro del    */
/*	valor del cheque.						*/ 
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      	AUTOR                RAZON                          */
/*      20/Oct/2009	Mario Algarin	     Emision Inical	                */
/*      02/Dic/2016 A.Zuluaga            Desacople                      */
/************************************************************************/
use cob_pfijo
go
if exists (select * from sysobjects where name = 'sp_chq_protestados')
   drop proc sp_chq_protestados
go
create proc sp_chq_protestados (
   @s_ssn                        int        	= null,
   @s_user                       login      	= null,
   @s_term                       varchar(30)	= null,
   @s_date                       datetime  	= null,
   @s_sesn                       int        	= null,
   @s_srv                        varchar(30)    = null,
   @s_lsrv                       varchar(30)    = null,
   @s_ofi                        smallint   	= null,
   @s_rol                        smallint  	= null,
   @t_debug                      char(1)    	= 'N',
   @t_file                       varchar(10)    = null,
   @t_from                       varchar(32)    = null,
   @t_trn                        smallint	= null,
   @i_filial			 smallint   	= 1,
   @i_num_banco            	 cuenta		= null,
   @i_en_linea                   char(1)        = 'N',
   @i_observacion                descripcion    = null, 
   @i_estado                     char(1) 	= null,
   @i_tipo                       char(1) 	= null,
   @i_motivo                     catalogo  	= 'NNN',
   @i_banco 	                 catalogo 	= null,
   @i_cuenta 	                 cuenta         = null,
   @i_cheque		         int            = null,
   @i_valor                      money 	        = null,
   @o_mensaje                    mensaje        = null output 
)
as
declare         
@w_sp_name                   	varchar(32),
@w_return		      	int,
@w_mensaje                   	mensaje,
@w_error                     	int,
@w_trn                          smallint,
@w_secuencia                  	int,
@w_subsecuencia               	tinyint,
@w_operacion			int,
@w_num_chq_devueltos 		int,
@w_num_cheq_mov_prob		int


---------------------------------------
----| Inicializacion de Variables |----
---------------------------------------
select	@w_sp_name     = 'sp_chq_protestados'

if @t_trn is null
   select @w_trn = 14561 
else
   select @w_trn = @t_trn

-------------------------------------
---| Validaciones de Campos Req. |---
-------------------------------------

	if @i_num_banco = null  
   	begin
            --No se ha Ingresado el Numero del Titulo--
      	    select @w_error = 141249
            goto ERROR
   	end


	if isnull(@i_banco,0) = 0 
   	begin
	    --No se ha Ingresado el Codigo del Banco del Cheque--
      	    select @w_error = 141250
            goto ERROR
   	end

	if isnull(@i_cheque,0) = 0 
   	begin
            --No se ha Ingresado el Numero del Cheque--
      	    select @w_error = 141251
            goto ERROR
   	end


	if isnull(@i_valor,0) = 0 
   	begin
            --No se ha Ingresado el Valor del Cheque--
      	    select @w_error = 141252
            goto ERROR
   	end


---------------------------------------
---| Carga de Variables de trabajo |---
---------------------------------------

 select @w_operacion = op_operacion
   from pf_operacion, 
        pf_tipo_deposito
  where op_num_banco = @i_num_banco  
    and op_toperacion = td_mnemonico

   if @@rowcount = 0
   begin
       --No existe Operacion de Plazo Fijo--
       select @w_error = 141051
       goto ERROR
   end


print 'PFIJO.chqpro  w_operacion ' + cast(@w_operacion as varchar)
print 'PFIJO.chqpro  i_banco ' + cast(@i_banco as varchar)
print 'PFIJO.chqpro  i_cheque ' + cast(@i_cheque as varchar)
print 'PFIJO.chqpro  i_valor ' + cast(@i_valor as varchar)


  select @w_secuencia = ec_secuencia,
         @w_subsecuencia = ec_sub_secuencia  
    from pf_emision_cheque
   where ec_operacion = @w_operacion
    and ec_estado = 'A'   		
    and ec_banco = @i_banco         --Banco del cheque
    and ec_numero = @i_cheque       --Numero del cheque
    and ec_valor = @i_valor         --Valor del Cheque

   if @@rowcount = 0
   begin
       --No existe Emision de Cheque, Numero de Banco o Numero de Cheque Invalido--
       select @w_error = 141253
       goto ERROR
   end

   exec @w_return = cob_interfase..sp_iremesas
        @i_operacion         = 'F',
        @i_operacion_cta     = @w_operacion,
        @o_num_chq_devueltos = @w_num_chq_devueltos out
        
----------------------------------------
---| Insercion cheques con Problema |---
----------------------------------------

if @i_en_linea = 'S' begin tran

exec @w_return = sp_fpago_prob         
	@s_ssn		= @s_ssn,
	@s_user         = @s_user,       
	@s_term         = @s_term,       
	@s_date         = @s_date,       
	@s_srv          = @s_srv,      
	@s_lsrv         = @s_lsrv,       
	@s_ofi          = @s_ofi,      
	@s_rol          = @s_rol,       
	@t_debug        = @t_debug,       
	@t_file         = @t_file,       
	@t_from         = @t_from,       
	@t_trn          = 14139,
	@i_operacion    = 'I',
	@i_en_linea	= @i_en_linea,
	@i_num_banco    = @i_num_banco,       
   	@i_estado       = @i_estado,         
   	@i_tipo         = @i_tipo,             
   	@i_secuencia    = @w_secuencia,            
   	@i_subsecuencia = @w_subsecuencia,            
   	@i_motivo       = @i_motivo,            
   	@i_banco 	= @i_banco,                
   	@i_cuenta 	= @i_cuenta,                
   	@i_cheque	= @i_cheque,	        
  	@i_valor        = @i_valor             

     if @w_return <> 0
     begin
         select @w_error = @w_return,
		@w_trn = 14139
         goto ERROR
     end 


select 	@w_num_cheq_mov_prob = isnull(count(*) , 0)
from 	pf_mov_monet_prob
where 	pr_operacion = @w_operacion

-----------------------------------------
---| Devolucion y Cancelacion Titulo |---
-----------------------------------------

print 'PFIJO.chqpro  w_operacion ' + cast(@w_operacion as varchar)
print 'PFIJO.chqpro  w_num_chq_devueltos ' + cast(@w_num_chq_devueltos as varchar)
print 'PFIJO.chqpro  w_num_cheq_mov_prob ' + cast(@w_num_cheq_mov_prob as varchar)

if @w_num_chq_devueltos = @w_num_cheq_mov_prob and @w_num_cheq_mov_prob > 0
begin

exec @w_return = sp_canc_cheque_protestado
      	@s_ssn           = @s_ssn,
      	@s_user          = @s_user,
      	@s_term          = @s_term,
      	@s_date          = @s_date,
      	@s_sesn          = @s_sesn,
      	@s_srv           = @s_srv,
      	@s_lsrv          = @s_lsrv,
      	@s_ofi           = @s_ofi,
      	@s_rol           = @s_rol,
      	@t_debug         = @t_debug,
      	@t_file          = @t_file,
      	@t_from          = @t_from,
      	@t_trn           = 14543,
      	@i_num_banco     = @i_num_banco,
      	@i_en_linea      = @i_en_linea,
      	@i_observacion   = @i_observacion

     if @w_return <> 0
     begin
         select @w_error = @w_return,
		@w_trn = 14543
         goto ERROR
     end 
 
end

if @i_en_linea = 'S' commit tran

return 0

-------------------------------------
---| Rutina para manejo de error |---
-------------------------------------

ERROR:

--------------------------------------------
---| Encontrar la descripcion del error |---
--------------------------------------------

 if @w_mensaje is null
 begin
  select @w_mensaje = '[' + @w_sp_name + '] ' + mensaje
    from cobis..cl_errores
   where numero = @w_error
 end

      exec sp_errorlog 
           @i_fecha       = @s_date,
           @i_error       = @w_error,
           @i_usuario     = @s_user,
           @i_tran        = @w_trn,
           @i_cuenta      = @i_num_banco,
           @i_descripcion = @w_mensaje

     select @o_mensaje = @w_mensaje
     select @o_mensaje
  
   return @w_error

go