/************************************************************************/
/*      Archivo:		sp_embargo.sp                        	*/
/*      Stored procedure:	sp_embargo  	                        */
/*      Base de datos:		cob_pfijo                               */
/*      Producto:		Plazo_fijo                              */
/*      Disenado por:           Mario Andres Algarin 			*/
/*      Fecha de documentacion: 07/Sep/2009                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*	Este programa permite hacer la administracion de los Bloqueos	*/
/*	Legales y el Detalle de de Pagos de dichos bloqueos,    	*/
/*	aplicable a los depositos a Termino, tambien permite 		*/
/*	levantamiento de los mismos bloqueos, y consultarlos.		*/
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      	AUTOR                RAZON                      */
/*      07/Sep/2009	Mario Algarin	     Emision Inical	        */
/*									*/
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_embargo')
   drop proc sp_embargo
go
create proc sp_embargo (
@s_ssn                        int        	= null,
@s_user                       login      	= null,
@s_term                       varchar(30)	= null,
@s_date                       datetime  	= null,
@s_sesn                       int        	= null,
@s_srv                        varchar(30)   = null,
@s_lsrv                       varchar(30)   = null,
@s_ofi                        smallint   	= null,
@s_rol                        smallint  	= null,
@t_debug                      char(1)    	= 'N',
@t_file                       varchar(10)   = null,
@t_from                       varchar(32)   = null,
@t_trn                        smallint   	= null,
@i_filial			          smallint      = 1,
@i_operacion                  char(1),
@i_op_num_banco               cuenta,    		       --Este es el numero del titulo
@i_bl_operacion               int        	= null,  
@i_bl_valor_embgdo_juzgado    money      	= null,    --El que manda el juzgado
@i_bl_valor_embgdo_banco      money      	= null,	   --El que el banco aplicara   
@i_bl_valor_int_embgdo_banco  money      	= null,	   --El que el banco aplicara para int  
@i_bl_fecha_oficio            datetime   	= null,    --Fecha del oficio
@i_bl_num_oficio              varchar(30)   = null,    --Numero del oficio
@i_bl_autoridad               varchar(64)   = null,	   --Nombre del que manda el oficio
@i_bl_observacion             varchar(64)   = null,    --Notas adicionales al embargo
@i_modifico_fp                tinyint    	= 0,       --Si modifica el detalle (0 = no / 1 = si)
@i_bl_secuencial              tinyint    	= null,    
@i_canal                      char(1)       = null,    
@i_formato_fecha              int        	= 101,	   
@i_ente                 	  int           = null,	  --Cliente del Banco al que se le asignara el pago de intereses
@i_cuentapro            	  cuenta        = null,  
@i_monto                	  money         = null,
@i_moneda_pago          	  smallint      = 0,	
@i_descripcion          	  varchar(255)  = '',
@i_tipo_cliente               char(1)       = null,
@i_secltext             	  int           = null,
@i_oficina              	  int           = null,
@i_secuencia            	  int           = 1,
@i_tipo_cuenta_ach      	  char(1)       = null,
@i_banco_ach            	  smallint     	= null,
@o_sec_embargo                int           = null out)
with encryption
as
declare         
@w_sp_name                    varchar(32),
@w_return		      	      int,                              
@w_nombre			          varchar(255),
@w_num_banco                  cuenta,
@w_operacion                  int,
@w_estado                     catalogo,
@w_tcapitalizacion            char(1),
@w_fpago                      char(3),
@w_fpago_int                  varchar(5),
@w_monto_blqlegal             money,
@w_monto_int_blqlegal         money,
@w_monto                      money,
@w_monto_int 			      money,
@w_monto_disponible		      money,
@w_monto_int_disponible		  money,
@w_monto_pgdo                 money,
@w_monto_blq                  money,
@w_accion_sgte                catalogo,
@w_descripcion			      descripcion,
@w_tipo_cliente			      char(1),
@w_ente                       int,
@w_forma_pago		          varchar(10),
@w_tipo_bloq_legal            catalogo,
@w_motivo_blqlegal         	  catalogo,
@w_porcentaje           	  float,
@w_total_int_estimado 		  money

---------------------------------------
----| Inicializacion de Variables |----
---------------------------------------
select @w_sp_name     = 'sp_embargo'

if @t_trn <> 14560
begin

   begin

       exec cobis..sp_cerror

          @t_debug  = @t_debug,

          @t_file   = @t_file,

          @t_from   = @w_sp_name,

          @i_num    = 151051

          /*  'No corresponde codigo de transaccion' */

       return 1

   end

end


if @t_debug = 'S' if @t_debug = 'S' print '@s_ofi' + cast (@s_ofi as varchar)

select @w_motivo_blqlegal = 'EMB'   --Motivo Bloqueo Legal
select @w_porcentaje = 100.00       --Porcentaje pago de Interese    	

 select @w_num_banco          = op_num_banco,
        @w_operacion          = op_operacion,
        @w_estado             = op_estado,
        @w_tcapitalizacion    = op_tcapitalizacion,
        @w_fpago              = op_fpago,
 	@w_monto_blqlegal     = isnull(op_monto_blqlegal,0),
 	@w_monto_int_blqlegal     = isnull(op_monto_int_blqlegal,0),
        @w_monto_disponible   = op_monto_pg_int - (isnull(op_monto_blq,0) + isnull(op_monto_pgdo,0) + isnull(op_monto_blqlegal,0)),  
   	@w_monto_int_disponible   = isnull(op_total_int_estimado,0) - isnull((select isnull(sum((isnull(bl_valor_int_embgdo_banco,0) - isnull(bl_valor_int_embgdo_aplicado,0)) ),0) from cob_pfijo..pf_bloqueo_legal where bl_operacion = pf.op_operacion and bl_estado = 'I'),0) - isnull(op_total_int_pagados,0),
   	@w_monto              = op_monto,
	@w_monto_int 	      = op_int_estimado,
        @w_monto_pgdo         = op_monto_pgdo,
        @w_monto_blq          = op_monto_blq,
 	@w_accion_sgte        = op_accion_sgte,
 	@w_total_int_estimado = op_total_int_estimado
   from pf_operacion pf, 
        pf_tipo_deposito
  where op_num_banco = @i_op_num_banco  
    and op_toperacion = td_mnemonico

   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 141051
      return 141051
   end


--Se valida que el Embargo a Eliminar Exista antes de proceder a Cambiarle la forma de pago de intereses
if @i_operacion = 'D'
begin

if @t_debug = 'S' print '@i_operacion) ' + cast (@i_operacion as varchar)
if @t_debug = 'S' print '@i_bl_secuencial) ' + cast (@i_bl_secuencial as varchar)


	if not exists (select 1 from pf_bloqueo_legal
   			where  bl_operacion = @w_operacion
     			  and  bl_secuencial = @i_bl_secuencial)
   	if @@rowcount = 0   
   	begin
      	    exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 141176
           return 141176 
        end

	--Captura de Parametro de Forma de Pago de Intereses al Levantar el Embargo
	select @w_forma_pago = pa_char 
          from cobis..cl_parametro 
         where pa_nemonico = 'MPICLE'

	if @@rowcount = 0
  	begin
    	    exec cobis..sp_cerror 
               @t_debug= @t_debug,
               @t_file = @t_file,
               @t_from = @w_sp_name,
               @i_num  = 141243   --No Existe Parametro De forma de Pago de Intereses despues de Levantar Embargo 
           return 141243
  	end 

end



-------------------------
----| BLOQUEO LEGAL |----
------------------------- 
if @i_operacion = 'I'
begin



	if isnull(@i_bl_fecha_oficio,'') = '' 
   	begin
      	  exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141223    --No se ha Ingresado la Fecha del Oficio
      	    return 141223
   	end

	if isnull(@i_bl_num_oficio,'') = '' 
   	begin
      	  exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141224    --No se ha Ingresado El Numero del Oficio 
      	    return 141224
   	end

	if isnull(@i_bl_autoridad,'') = '' 
   	begin
      	  exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141225    --No se ha Ingresado La Autoridad del Oficio 
      	    return 141225
   	end


	if isnull(isnull(@i_bl_valor_embgdo_banco,0) + isnull(@i_bl_valor_int_embgdo_banco,0),0) = 0 
   	begin
      	  exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141221    --no se ha ingresado el valor que el banco embargara
      	    return 141221
   	end

	if isnull(@i_bl_valor_embgdo_juzgado,0) = 0 
   	begin
      	  exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141220    --no se ha ingresado el valor enviado por el juzgado
      	    return 141220
   	end

	--Se Valida que el Titulo No tenga Instruccion de Cancelacion o Renovacion --

	if @w_accion_sgte = 'XREN' Or @w_accion_sgte = 'XCAN'
	begin
      	  exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141230   --Deposito tiene instruccion de Cancelacion o Renovacion. Por favor Levantarla 
           return 141230
 	end


  --Se Valida Que no se Pueda Modificar un Detalle de Pago si Capitaliza
  if @w_tcapitalizacion = 'S' and @i_bl_valor_int_embgdo_banco > 0
  begin
	exec cobis..sp_cerror
             @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141228    --Los Titulos capitalizables no Permiten Cambiar el detalle de pago intereses
     	  return 141228
  end


	--Se Valida que el saldo a bloquear sea menor o Igual al disponible

if @t_debug = 'S' print '@w_monto_disponible ' + cast (@w_monto_disponible as varchar)
if @t_debug = 'S' print '@w_monto_int_disponible ' + cast (@w_monto_int_disponible as varchar)
if @t_debug = 'S' print '@i_bl_valor_embgdo_banco ' + cast (@i_bl_valor_embgdo_banco as varchar)
if @t_debug = 'S' print '@i_bl_valor_int_embgdo_banco ' + cast (@i_bl_valor_int_embgdo_banco as varchar)

	if (isnull(@i_bl_valor_embgdo_banco,0) + isnull(@i_bl_valor_int_embgdo_banco,0) )> (isnull(@w_monto_disponible,0) + isnull(@w_monto_int_disponible,0)) 
	begin
		exec cobis..sp_cerror
             	   @t_debug = @t_debug,
                   @t_file  = @t_file,
                   @t_from  = @w_sp_name,
                   @i_num   = 141229    --El monto Real a Bloquear debe ser menor o igual que el monto disponible
      	         return 141229
        end 

	
	--Carga del tipo de Embargo

	if (isnull(@i_bl_valor_embgdo_banco,0) + isnull(@i_bl_valor_int_embgdo_banco,0) ) <= (isnull(@i_bl_valor_embgdo_juzgado,0))
	   select @w_tipo_bloq_legal = 'PARCIAL'	
        else --if @i_bl_valor_embgdo_banco >= @w_monto_disponible
           select @w_tipo_bloq_legal = 'TOTAL'        



--Valida estado del titulo --

if @w_estado <> 'ACT' and @w_estado <> 'VEN'
begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 141231   --Deposito no se encuentra ni activo ni vencido
      return 141231
end

--------------------------------------------------
-- Valida que los Titulares no sean Fundaciones --
--------------------------------------------------

-- Cursor que valida el nombre de los Titulares beneficiarios --

      declare beneficiarios cursor                                                                                                                                                                                                                            
          for select isnull(en_nomlar,en_nombre) 
	  from pf_beneficiario,
               cobis..cl_ente                                                                                                                                                                                                       
	 where be_operacion = @w_operacion                                                                                                                                                                                                          
	   and be_ente = en_ente                                                                                                                                                                                                                   
	   and be_estado = 'I'                                                                                                                                                                                                                    
	   and be_tipo = 'T'                                                                                                                                                                                                                      
	   and be_estado_xren = 'N'                                                                                                                                                                                                               
 	order by be_secuencia 
                                                                                                                                                                                                                
      open  beneficiarios                                                                                                                                                                                                            
      fetch beneficiarios into @w_nombre
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
      while @@fetch_status <> -1                                                                                                                                                                                                                              
      begin                                                                                                                                                                                                                                        
         if @@fetch_status = -2                                                                                                                                                                                                                    
         begin                                                                                                                                                                                                                               
            close beneficiarios                                                                                                                                                                                                              
            deallocate beneficiarios                                                                                                                                                                                           
            raiserror ('200001 - Fallo lectura del cursor beneficiarios', 16, 1)                                                                                                                                                     
          return 1                                                                                                                                                                                                                              
         end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
         -- Verificacion del Nombre del Titular --   
                                                                                                                                                                                                             
         if charindex('FUND', upper(@w_nombre)) > 0                                                                                                                                                      
         begin                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
            exec cobis..sp_cerror                                                                                                                                                                                        
                 @t_debug = @t_debug,                                                                                                                                                                                     
                 @t_file  = @t_file,                                                                                                                                                                                   
                 @t_from  = @w_sp_name,                                                                                                                                                                                
                 @i_num   = 141232 --El propietario del tiutlo es una Fundacion                                                                                                                              
            break                                                                                                                                                                                                                         
           return 141232                                                                                                                                                                                                                                          
         end                                                                                                                                                                                                                                                  

                                                                                                                                                                                                                                                              
      fetch beneficiarios into @w_nombre
                                                                                                                                                                                                                   
      end --del while
                                                                                                                                                                                                                                      
   close beneficiarios                                                                                                                                                                                                                                   
   deallocate beneficiarios


--Carga del Bloqueo Legal

if @t_debug = 'S' print 'antes de inserccion de boqueo_legal @s_ofi' + cast (@s_ofi as varchar)
 
   exec @w_return = sp_bloqueo_legal
	@s_ssn				= @s_ssn,
        @s_user				= @s_user,
	@s_term 			= @s_term, 
	@s_date				= @s_date,
	@s_sesn 			= @s_sesn,                      
   	@s_srv 				= @s_srv,                       
   	@s_lsrv 			= @s_lsrv,                      
   	@s_ofi 				= @s_ofi,                        
   	@s_rol 				= @s_rol,                       
   	@t_debug 			= @t_debug,                     
   	@t_file 			= @t_file,                      
   	@t_from 			= @t_from,                      
        @t_trn				= '14157',
   	@i_operacion			= @i_operacion,
   	@i_bl_operacion			= @w_operacion,              
   	@i_bl_valor_embgdo_juzgado	= @i_bl_valor_embgdo_juzgado,
   	@i_bl_valor_embgdo_banco	= @i_bl_valor_embgdo_banco,
   	@i_bl_valor_int_embgdo_banco	= @i_bl_valor_int_embgdo_banco,
   	@i_bl_tipo_bloq_legal		= @w_tipo_bloq_legal,
   	@i_bl_fecha_oficio		= @i_bl_fecha_oficio,
   	@i_bl_num_oficio		= @i_bl_num_oficio,
   	@i_bl_autoridad			= @i_bl_autoridad,
   	@i_bl_usuario			= @s_user,
   	@i_bl_observacion		= @i_bl_observacion,
   	@i_bl_motivo_blqlegal		= @w_motivo_blqlegal,
	--@i_modifico_fp			= @i_modifico_fp,
   	@i_bl_secuencial 		= @i_bl_secuencial,             
   	@i_canal 			= @i_canal,                     
   	@i_formato_fecha 		= @i_formato_fecha,
   	@i_ente                 = @i_ente 

  	if @w_return <> 0
           return @w_return

	select @o_sec_embargo = max(bl_secuencial) 
                                from pf_bloqueo_legal
			       where bl_operacion = @w_operacion

end

---------------------------------------
----| LEVANTAMIENTO BLOQUEO LEGAL |----
--------------------------------------- 

if @i_operacion = 'D'
begin


if @t_debug = 'S' print '@i_bl_observacion ' + cast (@i_bl_observacion as varchar)


	if isnull(@i_bl_observacion,'') = ''
   	begin
      	  exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141235    --No se ha Ingresado una Descripcion del Levantamiento Legal del Embargo
      	    return 141235
   	end


	if isnull(@i_bl_secuencial,0) = 0 
   	begin
      	  exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141236    --No Se ha ingresado el numero de bloqueo de Embargo a Levantar
      	    return 141236
   	end

if @t_debug = 'S' print 'antes de levantamiento de boqueo_legal @s_ofi' + cast (@s_ofi as varchar)

if @t_debug = 'S' print '@i_operacion ' + cast (@i_operacion as varchar)
if @t_debug = 'S' print '@w_operacion ' + cast (@w_operacion as varchar)
if @t_debug = 'S' print '@i_bl_observacion ' + cast (@i_bl_observacion as varchar)
if @t_debug = 'S' print '@i_modifico_fp ' + cast (@i_modifico_fp as varchar)
if @t_debug = 'S' print '@i_bl_secuencial ' + cast (@i_bl_secuencial as varchar)

   exec @w_return = sp_bloqueo_legal
	@s_ssn			= @s_ssn,
        @s_user			= @s_user,
	@s_term 		= @s_term, 
	@s_date			= @s_date,
	@s_sesn 		= @s_sesn,                      
   	@s_srv 			= @s_srv,                       
   	@s_lsrv 		= @s_lsrv,                      
   	@s_ofi 			= @s_ofi,                        
   	@s_rol 			= @s_rol,                       
   	@t_debug 		= @t_debug,                     
   	@t_file 		= @t_file,                      
   	@t_from 		= @t_from,      
	@t_trn			= '14344',
   	@i_operacion		= @i_operacion,
   	@i_bl_operacion		= @w_operacion,	         
	@i_bl_observacion	= @i_bl_observacion,  
	@i_modifico_fp		= @i_modifico_fp,     
	@i_bl_secuencial 	= @i_bl_secuencial    

  	if @w_return <> 0
           return @w_return       

if @t_debug = 'S' print '@w_return ' + cast (@w_return as varchar)


end


-------------------------------------
----| CONSULTA DE BLOQUEO LEGAL |----
------------------------------------- 
if @i_operacion = 'S'
begin

   exec @w_return = sp_bloqueo_legal
	@s_ssn			= @s_ssn,
        @s_user			= @s_user,
	@s_term 		= @s_term, 
	@s_date			= @s_date,
	@s_sesn 		= @s_sesn,                      
   	@s_srv 			= @s_srv,                       
   	@s_lsrv 		= @s_lsrv,                      
   	@s_ofi 			= @s_ofi,                        
   	@s_rol 			= @s_rol,                       
   	@t_debug 		= @t_debug,                     
   	@t_file 		= @t_file,                      
   	@t_from 		= @t_from,      
	@t_trn			= '14539',
   	@i_operacion		= @i_operacion,
   	@i_bl_operacion		= @w_operacion,	         
	@i_formato_fecha	= @i_formato_fecha    

  	if @w_return <> 0
           return @w_return       

end
 
   return 0
go