/************************************************************************/
/*      Archivo:                bt_acsgt.sp                             */
/*      Stored procedure:       sp_batch_accionsgt                      */
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
/************************************************************************/
/*                              PROPOSITO                               */
/*         Aqui se mandan los depositos que cumplan con los parametros	*/
/*      de fecha ingresada = fecha de vencimiento del dep. y opcio-     */
/* 	    nalmente ciudad, oficina y tipo de dept. a ejecutar su ven-	*/
/* 	    cimiento simple o renovacion o cancelacion 			*/
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      8-Agt-95  Erika Sanchez       Creacion                          */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists ( select 1 from sysobjects where name = 'sp_batch_accionsgt' and type = 'P')
   drop proc sp_batch_accionsgt
go

create proc sp_batch_accionsgt (
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
        @w_toperacion		catalogo,
	    @w_fecha_ven            datetime,
	    @w_accion_sgt		catalogo,
        @w_primero		tinyint,
	    @w_cero                 tinyint,
	    @w_oficina		smallint,  
        @w_pignorado            char(1),
	    @w_plazo_orig           int,  --CVA Oct-03-05
        @w_mensaje              varchar(64)  --CVA Nov-01-05
                           
select @w_sp_name        = 'sp_batch_accionsgt', 
       @w_tot_monto      = 0, 
       @w_tot_intereses  = 0, 
       @w_toperacion_ant = null,
       @w_moneda_ant     = null,
       @w_mensaje        = null


/*LIM 23/ENE/2006 Creacion Tablas Temporales*/
create table #ca_operacion_aux (
op_operacion         int,
op_banco             varchar(24), 
op_toperacion        varchar(10),
op_moneda            tinyint,
op_oficina           int,
op_fecha_ult_proceso datetime ,
op_dias_anio         int,
op_estado            int,
op_sector            varchar(10),
op_cliente           int,
op_fecha_liq         datetime,
op_fecha_ini         datetime ,
op_cuota_menor       char(1),
op_tipo              char(1),
op_saldo             money,     -- LuisG 04.06.2001
op_fecha_fin         datetime,   -- LuisG 04.06.2001
op_base_calculo      char(1) , --lre version estandar 05/06/2001
op_periodo_int       smallint, --lre version estandar 05/06/2001
op_tdividendo        varchar(10)  --lre version estandar 05/06/2001
)

create table #ca_abonos (
ab_secuencial_ing    int,
ab_dias_retencion    int          null,
ab_estado            varchar(10)  null,
ab_cuota_completa    char(1)      null
)
/* ALMACENA LAS DIFERENCIAS DE INTERES EN LOS REAJUSTES */
create table #interes_proyectado (
concepto        varchar(10),
valor           money
)
/* Tabla de cotizaciones usada en el calcdint */
create table #cotizacion(
   moneda     tinyint,
   valor      money)

CREATE TABLE #det_cus_garantias (				--LIM 01/FEB/2006
       garantia                varchar(64)     NOT NULL,
       tipo                    varchar(64)     NOT NULL,
       tasa                    float           NULL,
       cuenta                  varchar(24)     NULL)	


CREATE TABLE #det_oper_relacion (				--LIM 01/FEB/2006
       op_garantia                varchar(64)     NOT NULL,
       op_tramite                 int             NOT NULL,
       op_tipo                    char(1)         NOT NULL,
       op_toperacion              varchar(10)     NULL,
       op_producto                varchar(10)     NULL,
       op_tasa_asoc               char(1)         NULL,
       op_cuenta                  varchar(24)     NULL)



       
select 
   ct_moneda     as uc_moneda, 
   max(ct_fecha) as uc_fecha
into #ult_cotiz
from cob_conta..cb_cotizacion
group by ct_moneda
       

insert into #cotizacion
select ct_moneda, ct_valor
from   cob_conta..cb_cotizacion, #ult_cotiz
where ct_moneda = uc_moneda
and   ct_fecha  = uc_fecha


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

-------------------------------------------------------------
-- Declaracion de cursor para acceso a la tabla pf_operacion
-------------------------------------------------------------
declare cursor_operacion_accionsgt cursor local static
for select op_operacion, op_num_banco, op_producto   , op_fecha_ven,
           op_estado   , op_oficial  , isnull(op_accion_sgte,'NULL'), op_tipo_plazo,
           op_oficina  , op_moneda   , op_toperacion , op_pignorado, 
           op_monto_pgdo,op_plazo_orig
      from pf_operacion  
     where datediff(dd, op_fecha_ven, @w_fecha_proceso) >= 0 
       and op_estado 			= 'ACT'
       and isnull(op_pago_interes,'S')  = 'S'  --Si todos sus intereses se pagaron entonces puede ejecutarse la accion sgte
       and isnull(op_accion_sgte,'NULL') is not null
for read only

open cursor_operacion_accionsgt
fetch cursor_operacion_accionsgt into 
           @w_operacion, @w_num_banco , @w_producto      , @w_fecha_ven,
           @w_estado   , @w_user      , @w_accion_sgt    , @w_tplazo_ant, 
           @w_ofi_ant  , @w_moneda_ant, @w_toperacion_ant, @w_pignorado,
           @w_op_monto_pgdo, @w_plazo_orig

---------------------------------------------------------------
-- Inicializacion de variables con el primer acceso del cursor
---------------------------------------------------------------
select @w_oficina       = @w_ofi_ant,
       @w_moneda        = @w_moneda_ant,
       @w_toperacion    = @w_toperacion_ant,
       @w_operacion_ant = @w_operacion

while @@fetch_status <> -1
begin
   if @@fetch_status = -2
   begin
     close cursor_operacion_accionsgt
     deallocate cursor_operacion_accionsgt
     raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
     return 0
   end  

   -----------------------------------------
   -- Proceso de Instruccion de Cancelacion
   -----------------------------------------	
   if @w_accion_sgt = 'XCAN' and @i_hora = 0   
   begin			
	--I. CVA Jun-14-06 implementacion para obtener seqnos del kernel
	exec @s_ssn = ADMIN...rp_ssn
	--F. CVA Jun-14-06 implementacion para obtener seqnos del kernel

      exec @w_return = sp_cancelacion_op 
           @s_ssn           = @s_ssn, 
           @s_user          = 'sa',
           @s_term          = @s_term,
           @s_date          = @s_date,
           @s_srv           = @s_srv,	
           @s_lsrv          = @s_lsrv,
           @s_ofi           = @w_ofi_ant,	-- CVA May-05-06
           @s_rol           = @s_rol,
           @s_sesn          = @s_ssn,		--LIM 25/ENE/2006
           @t_debug         = @t_debug,	
           @t_file          = @t_file,
           @t_from          = @w_sp_name,		
           @t_trn           = @w_tran_can,
           @i_fecha_proceso = @w_fecha_proceso,
           @i_num_banco     = @w_num_banco,
           @i_en_linea      = @i_en_linea
 
      if @w_return <> 0		
      begin
         select @w_mensaje = 'Error Inst. Cancelacion' 
         exec sp_errorlog 
              @i_fecha   = @s_date,  
              @i_error   = @w_return,
              @i_usuario = @s_user,
              @i_tran    = @t_trn,
              @i_cuenta  = @w_num_banco,
              @i_descripcion = @w_mensaje 
         select @w_error = 0
      end      
   end		

   ----------------------------------------
   -- Proceso de Instruccion de Renovacion
   ----------------------------------------
   if @w_accion_sgt = 'XREN' and @i_hora = 0
   begin			
	--I. CVA Jun-14-06 implementacion para obtener seqnos del kernel
	exec @s_ssn = ADMIN...rp_ssn
	--F. CVA Jun-14-06 implementacion para obtener seqnos del kernel

     -- CVA Jun-30-06 Para escalonados mueve pf_rubro_op_i a pf_rubro_op_tmp
     if charindex('C',@w_tplazo_ant) > 0
     begin
		--Cargue en temporales lo registrado en la instruccion pf_rubro_op_i
		exec    @w_return       = sp_rubro_op_tmp
			@s_ssn 		= @s_ssn,
			@s_user         = @s_user,  
			@s_sesn         = @s_ssn,
			@s_term         = @s_term, 
			@s_date         = @s_date,
			@s_srv          = @s_srv,
			@s_lsrv         = @s_lsrv,
			@s_ofi          = @s_ofi,
			@s_rol          = @s_rol,
			@t_debug        = @t_debug,
			@t_file         = @t_file,
			@t_from         = @t_from,
			@t_trn          = 14469,
			@i_operacion    = 'R',
			@i_op_operacion = @w_operacion
	      	if @w_return <> 0
              	begin
         		select @w_mensaje = 'Error en Paso temporales tasa variable' 

         		exec sp_errorlog 
              		@i_fecha   = @s_date,  
              		@i_error   = @w_return,
              		@i_usuario = @s_user,
              		@i_tran    = @t_trn,
              		@i_cuenta  = @w_num_banco,
              		@i_descripcion = @w_mensaje 

         		select @w_error = 0
               	end	
     end

      exec @w_return = sp_renova_op 
           @s_ssn           = @s_ssn,
           @s_user          = 'sa', 
           @s_term          = @s_term,		
	   @s_date          = @s_date,
           @s_srv           = @s_srv,
     	   @s_lsrv          = @s_lsrv,
           @s_ofi           = @w_ofi_ant,  --CVA May-05-06
	   @s_rol           = @s_rol, 
           @t_debug         = @t_debug,
           @t_file          = @t_file,
           @t_from          = @w_sp_name,	
           @t_trn           = @w_tran_ren,
           @i_fecha_proceso = @w_fecha_proceso,
	   @i_cuenta_ant    = @w_num_banco,
           @i_operacion     = @w_operacion, 
           @i_cuenta_banco  = @w_num_banco,
           @i_en_linea      = @i_en_linea,
	   @i_inicio        = 0,
           @i_fin           = 99999999,
           @i_plazo_orig    = @w_plazo_orig,
           @o_operacion_new = @o_operacion out
      if @w_return <> 0   
      begin   
         select @w_mensaje  = 'Error Inst. Renovacion'
         exec sp_errorlog 
              @i_fecha   = @s_date, 
              @i_error   = @w_return,
              @i_usuario = @s_user,
              @i_tran    = @t_trn,
              @i_descripcion = @w_mensaje ,
              @i_cuenta  = @w_num_banco 

         select @w_error = 0
      end 

     -- CVA Jun-30-06 Para escalonados una vez ejecutada la instruccion borra la pf_rubro_op_i
     if charindex('C',@w_tplazo_ant) > 0
     begin
	delete from pf_rubro_op_i where roi_operacion = @w_operacion
        delete from pf_rubro_op_tmp where rot_operacion = @w_operacion
     end

   end 		

   --------------------------------
   -- Acceso al siguiente registro
   --------------------------------   
   select      @w_accion_sgt  = 'NULL' --CVA Oct-15-05

   fetch cursor_operacion_accionsgt into 
               @w_operacion, @w_num_banco , @w_producto      , @w_fecha_ven,
               @w_estado   , @w_user      , @w_accion_sgt    , @w_tplazo_ant,
               @w_ofi_ant  , @w_moneda_ant, @w_toperacion_ant, @w_pignorado,
               @w_op_monto_pgdo, @w_plazo_orig
		
end /* fin del while de cursor operacion */

close cursor_operacion_accionsgt
deallocate cursor_operacion_accionsgt    
return @w_error
go
