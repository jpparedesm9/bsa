/************************************************************************/
/*  Archivo:            abonobat.sp                                     */
/*  Stored procedure:   sp_abonos_batch                                 */
/*  Base de datos:      cob_cartera                                     */
/*  Producto:           Credito y Cartera                               */
/*  Disenado por:       Fabian de la Torre                              */
/*  Fecha de escritura: Ene. 1998                                       */
/************************************************************************/
/*                      IMPORTANTE                                      */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA'                                                            */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/  
/*                      PROPOSITO                                       */
/*  Procedimiento que realiza la Aplicacion de Abonos Automaticos       */
/************************************************************************/
/*                              CAMBIOS                                 */
/*      FECHA         AUTOR         CAMBIO                              */
/*   JUN-06-2019      ANDYG         Req 116911 TRX DES PARA LCR         */
/*   NOV-27-2019      DCU           Aumentar tamaño del campo           */
/*   OCT-26-2021      DCU           Socio Comercial                     */
/************************************************************************/  


use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_abonos_batch')
    drop proc sp_abonos_batch
go
----Inc.39517 partiendo de la version 7 dic.11.2011
create proc sp_abonos_batch
   @s_sesn                  int      = NULL,   
   @s_user      	        login    = NULL,
   @s_term      	        varchar(30),
   @s_date      	        datetime,
   @s_ofi       	        smallint,
   @i_en_linea              char(1),
   @i_fecha_proceso         datetime,
   @i_operacionca           int,
   @i_banco                 cuenta,
   @i_pry_pago              char(1)  = 'N',
   @i_cotizacion            money,
   @i_secuencial_ing        int = 0

as declare 
   @w_error                 int,
   @w_return                int,
   @w_sp_name               descripcion,
   @w_ab_secuencial_ing     int,
   @w_ab_dias_retencion     int,
   @w_ab_estado             catalogo,
   @w_commit                char(1),
   @w_fecha_pag             datetime,
   @w_categoria             catalogo,
   @w_op_estado_cobranza    catalogo,    -- 14/ENE/2011 - REQ 089 - ACUERDOS DE PAGO
   @w_toperacion            catalogo,    -- 14/ENE/2011 - REQ 089 - ACUERDOS DE PAGO
   @w_moneda_op             tinyint,     -- 14/ENE/2011 - REQ 089 - ACUERDOS DE PAGO
   @w_abd_monto_mop         money,       -- 14/ENE/2011 - REQ 089 - ACUERDOS DE PAGO
   @w_abd_tipo              catalogo,    -- 14/ENE/2011 - REQ 089 - ACUERDOS DE PAGO
   @w_est_cobro_juridico    catalogo,    -- 14/ENE/2011 - REQ 089 - ACUERDOS DE PAGO
   @w_est_cobro_prejuridico catalogo ,    -- 14/ENE/2011 - REQ 089 - ACUERDOS DE PAGO
   @w_tipo_tran             varchar(4) ,
   @w_monto_des             money,
   @w_banco                 varchar(24),
   @w_socio_comercial       char(1),
   @w_monto_compra          money   
   
/** CARGADO DE VARIABLES DE TRABAJO **/
select 
@w_sp_name = 'sp_abonos_batch',
@w_commit  = 'N'   

select @w_est_cobro_juridico = pa_char
from cobis..cl_parametro
where pa_nemonico = 'ESTJUR'
and   pa_producto = 'CRE'

select @w_est_cobro_prejuridico = pa_char
from cobis..cl_parametro
where pa_nemonico = 'ESTCPR'
and   pa_producto = 'CRE'  


---1- temporal  dos inserts  ca_abono (NA), ca_desembolso (NA) , tipo = 'PAG' o 'DES'
---2.- Cursor sobre la temporal ordenada por el secuencial  
--3.- Hacer un update al nuevo secuencial del detalle 

create table #transac (
tipo_tran           varchar(10) null,
secuencial_ing      int        null,
dias_retencion      int        null,
estado              varchar(3) null,
fecha               datetime  null
)

select 
@w_banco              = op_banco,      
@w_op_estado_cobranza = op_estado_cobranza,
@w_toperacion         = op_toperacion,
@w_moneda_op          = op_moneda
from ca_operacion
where op_operacion = @i_operacionca

if @i_secuencial_ing  = 0
begin
    
   insert into #transac 
   select
   tipo_tran      = 'PAG',
   secuencial_ing =ab_secuencial_ing,
   dias_retencion =ab_dias_retencion,
   estado         =ab_estado,
   fecha          =ab_fecha_pag
   from   ca_abono with (nolock)
   where  ab_operacion  = @i_operacionca
   and    ab_fecha_pag = @i_fecha_proceso
   and    ab_estado   in ('ING','P', 'NA')

   
   insert into #transac 
   select 
   tipo_tran      = 'DES',
   secuencial_ing = dm_secuencial ,
   dias_retencion = 0,
   estado         = 'NA',
   fecha          = dm_fecha
   from ca_desembolso
   where dm_operacion =  @i_operacionca
   and   dm_fecha     = @i_fecha_proceso
   and  dm_estado     = 'NA'


end
ELSE ---Los pagos masivos son puntuales yenvian su secuencial
begin

   insert into #transac 
   select
   tipo_tran      = 'PAG',
   secuencial_ing =ab_secuencial_ing,
   dias_retencion =ab_dias_retencion,
   estado         =ab_estado,
   fecha          =ab_fecha_pag
   from   ca_abono with (nolock)
   where  ab_operacion  = @i_operacionca
   and    ab_fecha_pag = @i_fecha_proceso
   and    ab_secuencial_ing = @i_secuencial_ing
   and    ab_estado   in ('ING','P', 'NA')

   
   insert into #transac 
   select 
   tipo_tran      = 'DES',
   secuencial_ing = dm_secuencial ,
   dias_retencion = 0,
   estado         = 'NA',
   fecha          = dm_fecha
   from ca_desembolso
   where dm_operacion   =  @i_operacionca
   and   dm_fecha       = @i_fecha_proceso
   and    dm_secuencial = @i_secuencial_ing
   and  dm_estado       = 'NA'

end




declare  cursor_abonos cursor for
select  tipo_tran,secuencial_ing, dias_retencion, estado
from   #transac 
order by secuencial_ing 
for read only

open cursor_abonos

fetch   cursor_abonos into
@w_tipo_tran ,@w_ab_secuencial_ing, @w_ab_dias_retencion, @w_ab_estado 

while   @@fetch_status = 0 begin /*WHILE CURSOR PRINCIPAL*/

   if (@@fetch_status = -1) begin
      select @w_error = 708999
      goto ERROR
   end

   if @w_tipo_tran  ='PAG' begin ---PARA transac  DE TIPO PAG

      select @w_error = 0
      
      if @i_pry_pago = 'N' and @@trancount = 0 begin
         begin tran --atomicidad por abono
         select @w_commit = 'S'
      end
      
      if @w_ab_estado in ('ING','P') begin
         
         exec @w_return =  sp_registro_abono
         @s_user            = @s_user,
         @s_term            = @s_term,
         @s_date            = @s_date,
         @s_ofi             = @s_ofi,
         @i_secuencial_ing  = @w_ab_secuencial_ing,
         @i_en_linea        = @i_en_linea,
         @i_operacionca     = @i_operacionca,
         @i_fecha_proceso   = @i_fecha_proceso,
         @i_cotizacion      = @i_cotizacion
      
      
         if @w_return <> 0 begin
            select @w_error = @w_return
            goto ERROR
         end
      
      end
      
      if @w_ab_estado = 'NA' begin   
         
         -- LECTURA DETALLE DE ABONO
         select
         @w_abd_monto_mop = abd_monto_mop,
         @w_abd_tipo      = abd_tipo
         from ca_abono_det
         where abd_secuencial_ing = @w_ab_secuencial_ing
         and   abd_operacion      = @i_operacionca
         and   (abd_tipo = 'PAG' or abd_tipo = 'CON')
         order by abd_tipo
         
         /* VERIFICA SI DEBE COBRAR HONORARIOS DE ABOGADO - OTROS CARGOS */
         if  @w_op_estado_cobranza in (@w_est_cobro_juridico, @w_est_cobro_prejuridico) and @w_abd_tipo <> 'CON'
         begin
            exec @w_return = sp_calculo_honabo
            @s_user            = @s_user,           --Usuario de conexion
            @s_ofi             = @s_ofi,            --Oficina del pago (si es por front es la de conexion)
            @s_term            = @s_term,           --Terminal de operacion
            @s_date            = @s_date,           --ba_fecha_proceso
            @i_operacionca     = @i_operacionca,    --op_operacion de la operacion
            @i_toperacion      = @w_toperacion,     --op_toperacion de la operacion
            @i_moneda          = @w_moneda_op,      --op_moneda de la operacion
            @i_monto_mpg       = @w_abd_monto_mop   --Monto del pago que sera utilizado para el calculo de honabo
            
            if @w_return ! = 0
               return @w_return
         end     
      end   
      
      if @w_ab_dias_retencion > 0 begin
      
         update ca_abono with (rowlock) set
         ab_dias_retencion = ab_dias_retencion - 1
         where ab_secuencial_ing = @w_ab_secuencial_ing
         and   ab_operacion      = @i_operacionca  --MPO06/10/2001
      
         if @@error <> 0 begin
            select @w_error = 710002
            goto ERROR
         end
      
      end
      
      /* APLICACION DEL PAGO */
      if @w_ab_dias_retencion <= 0
      begin
      
         if @i_secuencial_ing > 0 PRINT 'abonobat.sp va @i_banco :'  + cast (@i_banco as varchar) + ' @i_secuencial_ing : ' + cast (@i_secuencial_ing as varchar)
      
         exec @w_return = sp_cartera_abono
         @s_sesn           = @s_sesn,
         @s_user           = @s_user,
         @s_term           = @s_term,
         @s_date           = @s_date,
         @s_ofi            = @s_ofi,
         @i_secuencial_ing = @w_ab_secuencial_ing,
         @i_en_linea       = @i_en_linea,
         @i_operacionca    = @i_operacionca,
         @i_fecha_proceso  = @i_fecha_proceso,
         @i_cotizacion      = @i_cotizacion
      
         if @w_return <> 0 begin
            select @w_error = @w_return
            goto ERROR
         end 
      
      end
	  
   end   
   
   if  @w_tipo_tran  ='DES' begin --TRANSACCION DES
   
      select 
      @w_monto_des       =  dtr_monto
	  from ca_det_trn 
	  where dtr_operacion  = @i_operacionca
	  and   dtr_secuencial = @w_ab_secuencial_ing
	  and   dtr_concepto   = 'CAP' 
	  -------------------------------------------
	  --------Validacion Socio Comercial
	  -------------------------------------------
	  select 
	  @w_socio_comercial = 'N',
      @w_monto_compra    = 0
	  
	  if exists (select 1
                 from cob_cartera..ca_operacion, cobis..cl_ente_aux 
                 where op_operacion = @i_operacionca
				 and  ea_ente = op_cliente
                 and op_toperacion = 'REVOLVENTE'
                 and ea_colectivo in (select c.codigo 
                                      from cobis..cl_catalogo c,
                                      cobis..cl_tabla t 
                                      where c.tabla = t.codigo
                                      and t.tabla = 'cl_socio_comercial'))
      begin
	     select 
		 @w_socio_comercial = 'S',
		 @w_monto_compra = @w_monto_des
      end	  
	  
      ---------------------------------------------
	  
      exec @w_error= sp_lcr_desembolsar 
      @s_ssn              = @s_sesn,
      @s_ofi              = @s_ofi,
      @s_user             = @s_user,
      @s_sesn             = @s_sesn,
      @s_term             = @s_term,
      @s_srv              = 'consola',
      @s_date             = @s_date,
      @i_banco            = @i_banco,
      @i_monto            = @w_monto_des ,
      @i_fecha_valor      = @i_fecha_proceso,
      @i_secuencial       = @w_ab_secuencial_ing,
      @i_socio_comercial  = @w_socio_comercial,
	  @i_monto_compra     = @w_monto_compra
 
	  
       if @w_error <> 0  goto ERROR
   
   end 

   if @w_commit = 'S' begin 
      commit tran
      select @w_commit = 'N'
   end
   
   goto SIGUIENTE    

   ERROR:
   if @w_commit = 'S' begin
      rollback tran
      select @w_commit = 'N'
   end
   
   if @i_en_linea = 'S' 
      exec cobis..sp_cerror 
      @t_debug='N',
      @t_file=null,
      @t_from=@w_sp_name,  
      @i_num = @w_error
      
   else begin
      if @i_secuencial_ing > 0 PRINT 'abonobat.sp va @i_banco con error ' + cast (@i_banco as varchar)
      exec sp_errorlog 
      @i_fecha     = @s_date,
      @i_error     = @w_error,
      @i_usuario   = @s_user,
      @i_tran      = @w_ab_secuencial_ing,
      @i_tran_name = @w_sp_name,
      @i_cuenta    = @i_banco,
      @i_rollback  = 'S'
      
   end

   SIGUIENTE:

   fetch   cursor_abonos into
   @w_tipo_tran ,@w_ab_secuencial_ing, @w_ab_dias_retencion, @w_ab_estado 

end /*WHILE CURSOR RUBROS*/

close cursor_abonos
deallocate cursor_abonos

return 0

go