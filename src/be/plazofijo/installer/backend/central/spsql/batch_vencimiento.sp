/************************************************************************/
/*      Archivo:                bt_venci.sp                             */
/*      Stored procedure:       sp_batch_vencimiento                    */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Gustavo Calderon                        */
/*      Fecha de documentacion: 08/Agt/95                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*         Aqui se mandan los depositos que cumplan con los parametros	*/
/*      de fecha ingresada = fecha de vencimiento del dep. y opcio-     */
/* 	    nalmente ciudad, oficina y tipo de dept. a ejecutar su ven-	*/
/* 	    cimiento simple o renovacion o cancelacion 			*/
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists ( select 1 from sysobjects where name = 'sp_batch_vencimiento' and type = 'P')
   drop proc sp_batch_vencimiento
go
create proc sp_batch_vencimiento (
@s_ssn                  int             = NULL,
@s_user                 login           = 'sa',
@s_term                 varchar(30)     = 'consola',
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = 'PRESRV',
@s_lsrv                 varchar(30)     = 'PRESRV',
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  int             = 14921,
@i_fecha_proceso        datetime        = NULL,
@i_toperacion           catalogo        = 'T',		
@i_ciudad               catalogo        = 'T',
@i_oficina              catalogo        = 'T',
@i_hora                 tinyint         = 0,
@i_en_linea             char(1)         = 'S'
)
with encryption
as
declare @w_sp_name              descripcion,
        @w_return               int,
        @w_string               descripcion,
        @w_error                int,
        @w_fecha_proceso        datetime,
	@w_fecha_hoy            datetime,
        @w_flag                 tinyint, 
        @w_ofi_ant		int,
        @w_user			login,
        /** VARIABLES PARA NUMERO DE TRANSACCIONES **/
 	@w_tran_can   		int,
        @w_tran_ren   		int,  
        @w_tran_ven   		int,
        @w_operacion   		int,
        @w_operacion_ant	int,
        @w_tipo_deposito 	smallint,
        @w_toperacion_ant 	catalogo,
        @o_operacion   		cuenta,
        /** VARIABLES PARA PF_OPERACION **/
        @w_descripcion          descripcion,
        @w_moneda               tinyint, 
        @w_moneda_ant           smallint, 
        @w_tplazo_ant           catalogo, 
        @w_estado               catalogo, 
        @w_monto                money,
        @w_op_monto_pgdo        money,
        @w_producto             tinyint, 
        @w_intereses            money, 
        @w_tot_monto            money,
        @w_tot_intereses        money, 
        @w_num_banco            cuenta,
        @w_toperacion           catalogo,
        @w_fecha_ven            datetime,
        @w_accion_sgt           catalogo,
        @w_primero              tinyint,
        @w_cero                 tinyint,
        @w_oficina              smallint,  
        @w_pignorado            char(1),
        @w_debug                char(1)

                           
select @w_sp_name        = 'sp_batch_vencimiento', 
       @w_tot_monto      = 0, 
       @w_tot_intereses  = 0, 
       @w_toperacion_ant = null,
       @w_moneda_ant     = null

-----------------------
-- Carga de Parametros
-----------------------
if @i_toperacion = 'T'
	select @i_toperacion = '%'
if @i_ciudad = 'T'
	select @i_ciudad = '%'
if @i_oficina = 'T'
	select @i_oficina = '%'

select @w_tran_ven      = 14921,
       @w_tran_can      = 14903,
       @w_tran_ren      = 14918,  
       @w_fecha_proceso = @i_fecha_proceso,
       @s_date          = @i_fecha_proceso,
       @w_error         = 0

       if @w_debug = 'S' begin
          print 'btvenci  antes de crsor a fecha '+ cast(@i_fecha_proceso  as varchar) 
       end


-------------------------------------------------------------
-- Declaracion de cursor para acceso a la tabla pf_operacion
-------------------------------------------------------------
declare cursor_operacion cursor
for select op_operacion, op_num_banco, op_producto   , op_fecha_ven,
           op_estado   , op_oficial  , op_accion_sgte, op_tipo_plazo,
           op_oficina  , op_moneda   , op_toperacion , op_pignorado, 
           op_monto_pgdo
      from pf_operacion  
     where datediff(dd, op_fecha_ven, @w_fecha_proceso) >= 0 --op_fecha_ven <= @w_fecha_proceso 
       and op_estado = 'ACT'
for read only

open cursor_operacion
fetch cursor_operacion into 
           @w_operacion, @w_num_banco , @w_producto      , @w_fecha_ven,
           @w_estado   , @w_user      , @w_accion_sgt    , @w_tplazo_ant, 
           @w_ofi_ant  , @w_moneda_ant, @w_toperacion_ant, @w_pignorado,
           @w_op_monto_pgdo

---------------------------------------------------------------
-- Inicializacion de variables con el primer acceso del cursor
---------------------------------------------------------------
select @w_oficina       = @w_ofi_ant,
       @w_moneda        = @w_moneda_ant,
       @w_toperacion    = @w_toperacion_ant,
       @w_operacion_ant = @w_operacion

while @@fetch_status = 0
begin

   ----------------------------------
   -- Proceso de Vencimiento simple  
   ----------------------------------
   if @w_accion_sgt is null and @i_hora = 1
   begin	
      select @t_trn = @w_tran_ven

	--I. CVA Jun-30-06 implementacion para obtener seqnos del kernel
	exec @s_ssn = ADMIN...rp_ssn
	--F. CVA Jun-30-06 implementacion para obtener seqnos del kernel
     
      exec @w_return = sp_vence_op 
           @s_ssn           = @s_ssn,
           @s_user          = @w_user, 
           @s_term          = @s_term,	
           @s_date          = @s_date,
           @s_srv           = @s_srv,
           @s_lsrv          = @s_lsrv,
           @s_ofi           = @w_ofi_ant,
  	   @s_rol           = @s_rol,
           @t_debug         = @t_debug,
  	   @t_file          = @t_file, 
           @t_from          = @w_sp_name,
  	   @t_trn           = @t_trn,
           @i_fecha_proceso = @w_fecha_proceso,	
  	   @i_num_banco     = @w_num_banco,
           @i_en_linea      = 'N', 
           @o_monto         = @w_monto out,
           @o_intereses     = @w_intereses out 

      if @w_return <> 0		
      begin		
         exec sp_errorlog 
              @i_fecha   = @s_date,  
              @i_error   = @w_return,
              @i_usuario = @s_user,
              @i_tran    = @t_trn,
              @i_cuenta  = @w_num_banco
	              		
         select @w_error = 1
      end     
      
      if @w_pignorado = 'S'
       	 select @w_monto = @w_monto - isnull(@w_op_monto_pgdo ,0)

      select @w_string = 'Despues de Aplica_conta'
      select @w_monto = 0, @w_intereses = 0
   end  

   --------------------------------
   -- Acceso al siguiente registro
   --------------------------------   
   fetch cursor_operacion into 
               @w_operacion, @w_num_banco , @w_producto      , @w_fecha_ven,
               @w_estado   , @w_user      , @w_accion_sgt    , @w_tplazo_ant,
               @w_ofi_ant  , @w_moneda_ant, @w_toperacion_ant, @w_pignorado,
               @w_op_monto_pgdo
		
end /* fin del while de cursor operacion */

if @w_debug = 'S' begin
   print 'vencimiento spread @@FETCH_STATUS '+ cast(@@FETCH_STATUS as varchar) 
end


if @@fetch_status = -2
begin
   close cursor_operacion
   deallocate cursor_operacion
   raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
   return 0
end  


close cursor_operacion
deallocate cursor_operacion    
return @w_error
go
