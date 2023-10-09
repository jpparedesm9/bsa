/************************************************************************/
/*      Archivo:                inidedia.sp                             */
/*      Stored procedure:       sp_inicio_de_dia                        */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Miryam Davila                           */
/*      Fecha de documentacion: 24/Oct/94                               */
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
/*      Este script crea los procedimientos para las Actualizaciones    */
/*      de inicio de dia del modulo de Plazo Fijo.                      */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA       AUTOR              RAZON                            */
/************************************************************************/
/*      25-Nov-94   Juan Lam           Creacion                         */
/*      13-Mar-00   Marcelo Cartagena  Agrego lectura de registros PRA  */
/*      16-Mar-2005 N. Silva           Correcciones de identacion       */
/*      08_Ago-06   Clotilde Vargas    Agregar proceso para disminucion */
/*                                     en los bonos corporativos        */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists ( select 1 from sysobjects where name = 'sp_inicio_de_dia' and type = 'P')
   drop proc sp_inicio_de_dia
go

create proc sp_inicio_de_dia (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  int             = NULL,
@i_fecha_proceso        datetime,
@i_formato_fecha        int,
@i_oficina              catalogo        = '%',
@i_ciudad               catalogo        = '%',
@i_en_linea             char(1)         = 'S'
)
with encryption
as
declare 
        @w_sp_name              descripcion,
        @w_return               int,
        @w_secuencial           int, 
        @w_error                int,
     @w_fecha_hoy            datetime,
     @w_fecha_siguiente      datetime,
     @w_ret_paga_int         varchar(30),
/** VARIABLES PARA PF_OPERACION **/
        @w_num_banco            cuenta,
        @w_operacionpf          int,
        @w_op_toperacion        catalogo,
     @w_op_tcapitalizacion   char(1),
        @w_renovaciones         smallint,
     @w_fecha_ven            datetime,
     @w_fecha_pg_int         datetime,
        @w_fecha_proceso        datetime,
        @w_fecha_proceso1       varchar(10), 
     @w_estado      catalogo,
     @w_fpago       catalogo,
        @w_retorno              char(1),
        @w_mensaje              varchar(240), --CVA Oct-21-05
        @w_flag                 tinyint,
        @w_op_fpago             catalogo

---------------------------------------------------------------------------------------------  
-- Se declaran y se inicializan las variables w_secuencial, w_fecha_proceso,w_fecha_proceso1
---------------------------------------------------------------------------------------------
Select @w_fecha_proceso = convert(datetime,convert(varchar,@i_fecha_proceso,101)) 
Select @w_fecha_proceso1 = convert(varchar(10), @i_fecha_proceso)
select @w_retorno   = 'N', @w_flag = 0

/*---------*/
/*  DEBUG  */
/*---------*/
select @w_sp_name       = 'sp_inicio_de_dia',
       @s_user          = 'sa',
       @s_term          = 'CONSOLA',
       @i_fecha_proceso = isnull(@i_fecha_proceso,getdate()),
       @s_srv           = @@servername,
       @s_lsrv          = @@servername,
       @s_rol           = 1,
       @t_debug         = 'N',
       @t_file          = 'SQR',
       @t_trn           = 14999 


select @s_date    = @i_fecha_proceso
select @w_fecha_hoy = convert(datetime,convert(varchar,@i_fecha_proceso,101))
 
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
ab_dias_retencion    int         null,
ab_estado            varchar(10) null,
ab_cuota_completa    char(1)     null
)

/* Tabla de cotizaciones usada en el calcdint */
create table #cotizacion(
   moneda     tinyint,
   valor      money)

select ct_moneda     as uc_moneda, 
       max(ct_fecha) 	as uc_fecha
into   #ult_cotiz
from   cob_conta..cb_cotizacion
group by ct_moneda

insert into #cotizacion
select ct_moneda, ct_valor
from   cob_conta..cb_cotizacion, #ult_cotiz
where ct_moneda = uc_moneda
and   ct_fecha  = uc_fecha



/* ALMACENA LAS DIFERENCIAS DE INTERES EN LOS REAJUSTES */

create table #interes_proyectado (
concepto        varchar(10),
valor           money
)


print 'inidedia @w_fecha_hoy ' + cast(@w_fecha_hoy as varchar) 
--------------------------------
-- Proceso de pago de intereses 
--------------------------------   
select @w_num_banco = ' '
while 1 = 1
begin
     set rowcount 1
     select @w_num_banco          = op_num_banco,  
            @w_operacionpf        = op_operacion,
            @w_fecha_pg_int       = op_fecha_pg_int,
            @w_op_tcapitalizacion = op_tcapitalizacion,
            @w_op_fpago           = op_fpago
     from pf_operacion 
     where op_num_banco > @w_num_banco
            and datediff(dd,op_fecha_valor, @w_fecha_hoy) > 0 
            and datediff(dd,op_fecha_pg_int, @w_fecha_hoy) = 0        -- Solo los pagos de la fecha de proceso
            and datediff(dd,op_fecha_ult_pg_int, @w_fecha_hoy) > 0  
            and op_estado = 'ACT'
            and op_int_ganado > 0
     order by op_num_banco
     if @@rowcount = 0
          break

     set rowcount 0
   
SIGUIENTE:

     --I. CVA Jun-30-06 implementacion para obtener seqnos del kernel
     exec @s_ssn = ADMIN...rp_ssn
       
     exec @w_return             = sp_paga_int
          @s_ssn                = @s_ssn,
          @s_user               = @s_user,
          @s_term               = @s_term,
          @s_date               = @s_date,
          @s_srv                = @s_srv,
          @s_lsrv               = @s_lsrv,
          @s_ofi                = @s_ofi,
          @s_rol                = @s_rol,
          @t_debug              = @t_debug,
          @t_file               = @t_file, 
          @t_from               = @w_sp_name,
          
          @t_trn                = 14905,
          @i_fecha_proceso      = @i_fecha_proceso,
          @i_num_banco          = @w_num_banco,
          @i_op_fecha_pg_int    = @w_fecha_pg_int   -- Fecha actual de pago de interes
     if @w_return <> 0
     begin
          update pf_operacion
          set op_pago_interes = 'N' --Indicar que esta el pago pendiente
          where op_num_banco  = @w_num_banco
       
          select @w_mensaje = 'inidedia.sp Error devuelto por paga_int.sp'      
          select @w_error   = @w_return
          select @w_flag    = 1 
          goto ERROR
     end
     else
     begin
          update pf_operacion
          set op_pago_interes = 'S' --Indicar que el pago se hizo correctamente
          where op_num_banco  = @w_num_banco
     end
end /* END WHILE 1 */

--------------------------------------------------------------
-- Proceso de emision de Orden de pago de cheques de gerencia
--------------------------------------------------------------
EMISION:

--I. CVA Jun-30-06 implementacion para obtener seqnos del kernel
exec @s_ssn = ADMIN...rp_ssn
exec @w_return=sp_batch_emision_cheque
     @s_ssn           = @s_ssn,
     @s_user          = @s_user,
     @s_term          = @s_term,
     @s_date          = @s_date, 
     @s_srv           = @s_srv,
     @s_lsrv          = @s_lsrv,
     @s_rol           = @s_rol,
     @s_ofi           = @s_ofi, 
     @t_debug         = @t_debug, 
     @t_file          = @t_file,
     @t_from          = @w_sp_name,
     @t_trn           = 14955 ,
     @i_fecha_proceso = @i_fecha_proceso,
     @i_formato_fecha = @i_formato_fecha,
     @i_en_linea      = @i_en_linea
if @w_return <> 0 
begin
     select @w_mensaje = 'Error devuelto por emitchep.sp'
     select @w_error   = @w_return
     goto ERROR
end

if @w_retorno   = 'N'
     return 0
else
     return  @w_error

ERROR:

     select @w_retorno   = 'S'

     exec sp_errorlog 
          @i_fecha       = @s_date,
          @i_error       = @w_error, 
          @i_usuario     = @s_user,
          @i_tran        = @t_trn,
          @i_descripcion = @w_mensaje, --CVA Oct-21-05 
          @i_operacion   = @w_num_banco

     if @w_flag = 1 --Error en Pago Intereses pero tiene que emitir los documentos
     begin
          set rowcount 1
          select @w_num_banco = op_num_banco,
               @w_operacionpf        = op_operacion,
               @w_fecha_pg_int       = op_fecha_pg_int,
               @w_op_tcapitalizacion = op_tcapitalizacion,
               @w_op_fpago           = op_fpago            
          from pf_operacion 
          where op_num_banco > @w_num_banco
               and datediff(dd,op_fecha_valor, @w_fecha_hoy) > 0 
               and datediff(dd,op_fecha_pg_int, @w_fecha_hoy) >= 0 
               and datediff(dd,op_fecha_ult_pg_int, @w_fecha_hoy) > 0  
               and op_estado = 'ACT'
               and op_int_ganado > 0
          order by op_num_banco
          
          if @@rowcount = 0
               goto EMISION
          else
          begin
               select    @w_error = NULL, 
                    @w_retorno = 'N',
                    @w_flag = 0
               goto SIGUIENTE
          end
     end

     return @w_error
go

