/************************************************************************/
/*	Archivo: 	        intcre06.sp                                     */ 
/*	Stored procedure:       sp_intcre06                                 */ 
/*	Base de datos:  	cob_custodia				                    */
/*	Producto:               garantias               		            */
/*	Disenado por:           Rodrigo Garces			      	            */
/*			        Luis Alfredo Castellanos              	            */
/*	Fecha de escritura:     Junio-1995  				                */
/************************************************************************/
/*				IMPORTANTE				                                */
/*	Este programa es parte de los paquetes bancarios propiedad de	    */
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	        */
/*	"NCR CORPORATION".						                            */
/*	Su uso no autorizado queda expresamente prohibido asi como	        */
/*	cualquier alteracion o agregado hecho por alguno de sus		        */
/*	usuarios sin el debido consentimiento por escrito de la 	        */
/*	Presidencia Ejecutiva de MACOSA o su representante.		            */
/************************************************************************/
/*				PROPOSITO				                                */
/*	Este programa procesa las transacciones de:			                */
/*	Operaciones Cerradas con garantias propuestas                       */
/************************************************************************/
/*				MODIFICACIONES				                            */
/*	FECHA		AUTOR		RAZON				                        */
/*	Oct/1995  L.Castellanos      Emision Inicial            	        */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_intcre06')
drop proc sp_intcre06
go
create proc sp_intcre06  (
   @s_date               datetime    = null,
   @t_trn                smallint    = null,
   @t_debug              char(1)     = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)     = null,
   @i_producto           char(64)    = null,
   @i_modo               smallint    = null,	
   @i_cliente            int         = null,		
   @i_filial 		     tinyint     = null,	
   @i_sucursal		     smallint    = null,	
   @i_tipo_cust		     varchar(64) = null,	
   @i_custodia 		     int         = null,		
   @i_codigo_compuesto   varchar(64) = null,	
   @i_garantia           varchar(64) = null,
   @i_operac             cuenta      = null,
   @i_tipo_ctz           char(1)     = 'B',
   @o_opcion             money       = null out

)
as

declare
   @w_today              datetime,     /* FECHA DEL DIA */ 
   @w_sp_name            varchar(32),  /* NOMBRE STORED PROC*/
   @w_est_cancelado      tinyint,
   @w_est_precancelado   tinyint,
   @w_est_anulado        tinyint,
   @w_def_moneda         tinyint,
   @w_return		     int,
   @w_pid_cus	         int,
   @w_rowcount           int

select @w_today   = @s_date
select @w_sp_name = 'sp_intcre06'
select @w_pid_cus = @@spid * 100 

delete from cu_tmp_cotizacion_moneda06
where  sesion =@w_pid_cus

delete from cu_tmp_operacion_cerrada
where  sesion = @w_pid_cus


/***********************************************************/
/* CODIGO DE TRANSACCIONES                                */

if (@t_trn <> 19544 and @i_operacion = 'S') 
     
begin
/* TIPO DE TRANSACCION NO CORRESPONDE */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file, 
   @t_from  = @w_sp_name,
   @i_num   = 1901006
   return 1 

end

/*CREACION DE TABLA TEMPORAL PARA COTIZACIONES*/
   /*SELECCION DE CODIGO DE MONEDA LOCAL*/
select @w_def_moneda = pa_tinyint
from   cobis..cl_parametro
where  pa_nemonico = 'MLOCR'

select @w_rowcount = @@rowcount
set transaction isolation level read uncommitted

if @w_rowcount=0
begin
   /*REGISTRO NO EXISTE*/
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 2101005
   return 1
end



/*create table #cotizacion_moneda
(moneda		tinyint null,
 cotizacion	money null
)*/
insert into cu_tmp_cotizacion_moneda06
(moneda, cotizacion,sesion)
select
a.cv_moneda, a.cv_valor,@w_pid_cus
from  cob_conta..cb_vcotizacion a
where cv_fecha =(select max(b.cv_fecha)
                 from   cob_conta..cb_vcotizacion b
                 where  b.cv_moneda = a.cv_moneda
                 and    b.cv_fecha <= @w_today)

--INSERTAR UN REGISTRO PARA LA MONEDA LOCAL
if not exists(select 1 from cu_tmp_cotizacion_moneda06
              where  moneda = @w_def_moneda
              and    sesion = @w_pid_cus)
insert into cu_tmp_cotizacion_moneda06 (moneda, cotizacion,sesion)
values(@w_def_moneda,1,@w_pid_cus)


if @i_operacion = 'S'
begin
   select @w_est_cancelado = es_codigo
   from   cob_cartera..ca_estado
   where  es_codigo = 3

   select @w_est_precancelado = es_codigo
   from   cob_cartera..ca_estado
   where  es_codigo = 5

   select @w_est_anulado = es_codigo
   from   cob_cartera..ca_estado
   where  es_codigo = 6

   /*create table #cu_operacion_cerrada (
             oc_producto         char(3),
             oc_operacion        varchar(24),
             oc_moneda           tinyint,
             oc_valor_inicial    money,
             oc_valor_actual     money,
             oc_fecha_venc       datetime)*/

   insert into cu_tmp_operacion_cerrada
   select  tr_producto,  
   op_banco,
   op_moneda,
   sum(am_acumulado),
   sum(am_acumulado - am_pagado ),
   op_fecha_fin,
   @w_pid_cus
   from cu_custodia,cob_credito..cr_gar_propuesta,cob_credito..cr_tramite,
   cob_cartera..ca_operacion,cob_cartera..ca_amortizacion
   where cu_codigo_externo  = @i_garantia
   and cu_abierta_cerrada   = 'C'  -- Garantia Cerrada
   and cu_codigo_externo    = gp_garantia
   and cu_estado            not in ('A')
   and gp_tramite           = tr_tramite
   and tr_tipo              in ('O','R','M') -- Tipo de Tramite Normalizacion
   and tr_numero_op         is not null        
   and tr_numero_op         = op_operacion
   and tr_producto          = 'CCA' 
   and am_operacion         = op_operacion
   and am_concepto          = 'CAP' -- (C)apital
   and op_estado            <> @w_est_cancelado
   and op_estado            <> @w_est_precancelado
   and op_estado            <> @w_est_anulado
   group by tr_producto,op_banco,op_moneda,op_fecha_fin
   order by op_banco

   if @i_producto is null -- PRIMEROS 20 REGISTROS
   begin
      set rowcount  20 
      select distinct   'PRODUCTO'        = oc_producto,
      'OPERACION'       = oc_operacion,
      'MONEDA'          = oc_moneda,
      'VALOR GARANTIA'  = oc_valor_inicial,
      'VALOR ACEPTADO'  = oc_valor_actual,
      'FECHA VENCIM'    = convert(char(10),oc_fecha_venc,103)
      from   cu_tmp_operacion_cerrada
      where  sesion = @w_pid_cus
      order  by oc_producto, oc_operacion 
   end else               -- 20 SIGUIENTES
   begin
      set rowcount  20 
      select distinct   'PRODUCTO'        = oc_producto,
      'OPERACION'       = oc_operacion,
      'MONEDA'          = oc_moneda,
      'VALOR GARANTIA'  = oc_valor_inicial,
      'VALOR ACEPTADO'  = oc_valor_actual,
      'FECHA VENCIM'    = convert(char(10),oc_fecha_venc,103)
      from cu_tmp_operacion_cerrada
      where (oc_producto > @i_producto
      and   sesion       = @w_pid_cus
      or    (oc_producto = @i_producto and oc_operacion > @i_operac))
      order by oc_producto, oc_operacion 

      select @o_opcion=isnull(sum(isnull(A.oc_valor_actual,0)*isnull(B.cotizacion,1)),0)
      from cu_tmp_cotizacion_moneda06 B --pga22may2001 cob_credito..cr_cotizacion,
           LEFT OUTER JOIN cu_tmp_operacion_cerrada A
                ON  A.oc_moneda   = B.moneda
      where A.sesion =  @w_pid_cus
   end
end
go