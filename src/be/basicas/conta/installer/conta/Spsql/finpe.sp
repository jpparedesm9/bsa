/************************************************************************/
/*     Archivo: 		             finpe.sp	                        */
/*     Stored procedure: 	         sp_finpe	                        */
/*     Base de datos:     	         cob_conta                          */
/*     Producto:                     contabilidad                		*/
/*     Disenado por:                                                    */
/*     Fecha de escritura:           Febrero 2006 				        */
/************************************************************************/
/*				       IMPORTANTE				                        */
/*	Este programa es parte de los paquetes bancarios propiedad de	    */
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	        */
/*	"NCR CORPORATION".						                            */
/*	Su uso no autorizado queda expresamente prohibido asi como	        */
/*	cualquier alteracion o agregado hecho por alguno de sus		        */
/*	usuarios sin el debido consentimiento por escrito de la 	        */
/*	Presidencia Ejecutiva de MACOSA o su representante.		            */
/*				PROPOSITO				                                */
/*	Este programa procesa las transacciones de:			                */
/*	Genera los movimientos del fin de periodo                           */
/*	   			MODIFICACIONES				                            */
/*	   FECHA		AUTOR		RAZON				                    */
/************************************************************************/
use cob_conta
go


/* CREA TABLA DE TRABAJO */


IF EXISTS (select 1 from sysobjects where name = 'sp_finpe')
   drop proc sp_finpe
go

CREATE PROCEDURE sp_finpe (
   @s_user         login       = NULL,
   @s_date         DATETIME    = NULL,
   @s_term         VARCHAR(30) = NULL,
   @i_fec_ultdia   DATETIME,                               --ultimo dia habil del anio
   @i_empresa      TINYINT,
   @i_periodo      INT,
   @i_corte        INT
)
AS

/* DECLARA VARIABLES DE TRABAJO */
declare @w_oficina      smallint,
        @w_descripcion  varchar(80),
        @w_return       int,
        @w_area_orig    smallint,
        @w_saldo        money,
        @w_saldo_me     money,
        @w_detalles     int,
        @w_credito      money,
        @w_debito       money,
        @w_credito_me   money,
        @w_debito_me    money,
        @w_cuenta       varchar(14),
        @w_siguiente    int,
        @w_moneda_base  tinyint,
        @w_saldo_mn     money,
        @w_moneda       tinyint

/* INICIALIZA VARIABLES DE TRABAJO */                
select 
@w_descripcion = 'CIERRE DE CUENTAS DEL ESTADO DE RESULTADOS',
@w_oficina     = 0,
@w_return      = 0,
@w_area_orig   = 0,
@w_saldo       = 0,
@w_detalles    = 0,
@w_credito     = 0,
@w_debito      = 0,
@w_cuenta      = '',
@w_siguiente   = 0,
@w_moneda_base = 0

/* BUSCA AREA ORIGEN */
select @w_area_orig = pa_smallint
from cobis..cl_parametro
where pa_nemonico = 'ARC'
and   pa_producto = 'CCA'

/* BUSCA MONEDA BASE */
select @w_moneda_base = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'MLO'
and   pa_producto = 'ADM'

/* SELECCIONAS LAS OFICINAS DE MIOVIMIENTO */
select distinct of_oficina
into #oficina
from cob_conta..cb_oficina
where of_movimiento = 'S'

/*DETERMINAR EL UNIVERSO DE CUENTAS QUE PARTICIPAN EN ESTE PROCESO (TODAS LAS CTAS 4 Y 5) */
select distinct cu_cuenta, cu_moneda, cu_tercero = convert(char(1),'N')
into #cuentas
from cob_conta..cb_cuenta
where substring(cu_cuenta,1,1) in ('4', '5')
and   cu_cuenta not like '59%'
and   cu_movimiento = 'S'

update #cuentas set 
cu_tercero = 'S'
from cob_conta..cb_cuenta_proceso 
where cp_cuenta = cu_cuenta
and   cp_proceso in (6003, 6095)


/* CICLO POR OFICINA EXTRAE SALDOS GENERALES Y DE TERCEROS */
while 1 = 1 begin

   set rowcount 1
   
   select @w_oficina = of_oficina
   from #oficina
   where of_oficina > @w_oficina
   order by of_oficina
   
   if @@rowcount = 0 begin
      set rowcount 0
      break
   end
   
   set rowcount 0
   
   create table #saldos_cierre(
   asiento      int identity,
   cuenta       varchar(14),
   oficina      smallint,
   area         smallint,
   ente         int,
   debito       money,
   credito      money,
   debito_me    money,
   credito_me   money,
   moneda       tinyint,
   documento    varchar(20) null,
   tdocumento   char(2)     null)
   
   insert into #saldos_cierre(
   cuenta,       oficina,     area,
   ente,
   debito,
   credito,
   debito_me,
   credito_me,
   moneda)
   select 
   hi_cuenta,    hi_oficina,   hi_area,
   0,
   case when hi_saldo    < 0 then abs(hi_saldo)     else 0 end,
   case when hi_saldo    > 0 then abs(hi_saldo)     else 0 end,
   case when hi_saldo_me < 0 then abs(hi_saldo_me)  else 0 end,
   case when hi_saldo_me > 0 then abs(hi_saldo_me)  else 0 end,
   cu_moneda
   from cob_conta_his..cb_hist_saldo, #cuentas
   where hi_corte   = @i_corte
   and   hi_periodo = @i_periodo
   and   hi_oficina = @w_oficina
   and   hi_cuenta  = cu_cuenta
   and   cu_tercero = 'N'
   and   isnull(hi_saldo, 0)  <> 0
   
   insert into #saldos_cierre(
   cuenta,       oficina,     area,
   ente,
   debito,
   credito,
   debito_me,
   credito_me,
   moneda)
   select 
   st_cuenta,     st_oficina,  st_area,    
   st_ente,     
   case when st_saldo    < 0 then abs(st_saldo)    else 0 end,
   case when st_saldo    > 0 then abs(st_saldo)    else 0 end,   
   case when st_saldo_me < 0 then abs(st_saldo_me) else 0 end,
   case when st_saldo_me > 0 then abs(st_saldo_me) else 0 end,     
   cu_moneda
   from cob_conta_tercero..ct_saldo_tercero, #cuentas
   where st_corte      = @i_corte
   and   st_periodo    = @i_periodo
   and   st_oficina    = @w_oficina
   and   st_cuenta     = cu_cuenta
   and   cu_tercero    = 'S'  
   and   isnull(st_saldo, 0)  <> 0
   
   select 
   @w_saldo_me = isnull(sum(case when moneda = 0 then 0 else debito_me - credito_me end),0),
   @w_saldo_mn = isnull(sum(case when moneda = 0 then 0 else debito    - credito    end),0),
   @w_saldo    = isnull(sum(debito - credito), 0), 
   @w_detalles = count(1)
   from #saldos_cierre
   
   select distinct oficina, area, cuenta
   into #plan_general
   from #saldos_cierre
   where oficina = @w_oficina 

   if @w_detalles <= 0 goto SIGUIENTE
   
   if @w_saldo - @w_saldo_mn <> 0 begin

      select @w_detalles = @w_detalles + 1
      
      set rowcount 1

      select 
      @w_cuenta = cu_cuenta,
      @w_moneda = cu_moneda
      from cob_conta..cb_cuenta
      where cu_cuenta    like '59%'
      and   cu_moneda     = @w_moneda_base     
      and   cu_movimiento = 'S'
      
      set rowcount 0
      
      if @w_saldo-@w_saldo_mn > 0 begin
         select 
         @w_credito = @w_saldo-@w_saldo_mn,
         @w_debito  = 0
      end else begin
         select 
         @w_debito  = abs(@w_saldo-@w_saldo_mn),
         @w_credito = 0
      end

      insert into #saldos_cierre(
      cuenta,        oficina,       area,
      ente,          debito,        credito,
      debito_me,     credito_me,    moneda)
      values(
      @w_cuenta,     @w_oficina,    @w_area_orig, 
      0,             @w_debito,     @w_credito, 
      0,             0,             @w_moneda_base)
      
   end
   
  
   /* REGISTRAR MOVIMIENTOS EN MONEDA EXTRAJERA */
   if @w_saldo_me <> 0 begin

      select @w_detalles = @w_detalles + 1
   
      set rowcount 1

      select 
      @w_cuenta = cu_cuenta,
      @w_moneda = cu_moneda
      from cob_conta..cb_cuenta
      where cu_cuenta    like '59%'
      and   cu_moneda     <> @w_moneda_base     
      and   cu_movimiento = 'S'
      
      set rowcount 0
   
      if @w_saldo_me > 0 begin
         select 
         @w_credito    = @w_saldo_mn,
         @w_credito_me = @w_saldo_me,
         @w_debito     = 0,
         @w_debito_me  = 0
      end else begin
         select 
         @w_debito     = abs(@w_saldo_mn),
         @w_debito_me  = abs(@w_saldo_me),
         @w_credito    = 0,
         @w_credito_me = 0 
      end

      insert into #saldos_cierre(
      cuenta,        oficina,       area,
      ente,          debito,        credito,
      debito_me,     credito_me,    moneda)
      values(
      @w_cuenta,     @w_oficina,    @w_area_orig, 
      0,             @w_debito,     @w_credito, 
      @w_debito_me,  @w_credito_me, @w_moneda)
      
   end
   
   select 
   @w_saldo_me = isnull(sum(debito_me),0),
   @w_saldo    = isnull(sum(debito),0),
   @w_detalles = count(1)
   from #saldos_cierre
   
   delete #plan_general
   from cob_conta..cb_plan_general
   where pg_cuenta  = cuenta
   and   pg_oficina = oficina
   and   pg_area    = area
   
   if exists (select 1 from #plan_general) begin
      insert into cob_conta..cb_errores
      select 
      'sp_finpe','FALTA ASOCIACIÓN PLAN GENERAL Cta:'+cuenta,'oficina',CONVERT(VARCHAR(50),@w_oficina),getdate()
      from #plan_general
      goto SIGUIENTE
   end

   exec @w_return = cob_conta..sp_cseqcomp
   @i_empresa = @i_empresa,
   @i_fecha   = @i_fec_ultdia,
   @i_tabla   = 'cb_tcomprobante',
   @i_modulo  = 6,
   @i_modo    = 1,
   @o_siguiente = @w_siguiente out
   
   if @w_return <> 0 begin
      set rowcount 0
      insert into cob_conta..cb_errores
      VALUES('sp_finpe','GENERANDO CODIGO COMPROBANTE','oficina',CONVERT(VARCHAR(50),@w_oficina),getdate())      
      goto SIGUIENTE
   end   
   
   update #saldos_cierre set
   documento  = en_ced_ruc,
   tdocumento = en_tipo_ced
   from cobis..cl_ente
   where en_ente = ente
   
   update #saldos_cierre set
   documento  = den_ced_ruc,
   tdocumento = den_tipo_ced
   from cobis..cl_depu_ente
   where den_ente = ente

   insert into cob_conta..cb_errores
   select
   'sp_finpe',   'CLIENTE NO EXISTE','ente',CONVERT(VARCHAR(50),ente),getdate()
   from #saldos_cierre
   where isnull(ente, 0) > 0
   and  (documento is null or tdocumento is null)
   
   if @@rowcount <> 0 goto SIGUIENTE
   
   if @w_saldo > 0 begin
      begin tran
      
      insert into cob_conta..cb_comprobante
      values(
      @w_siguiente,       @i_empresa,        @i_fec_ultdia,
      @w_oficina,         @w_area_orig,      getdate(),
      getdate(),          @s_user,           @w_descripcion,
      'N',                NULL,              @w_detalles,       
      abs(isnull(@w_saldo,0)),      abs(isnull(@w_saldo,0)),     abs(isnull(@w_saldo_me, 0)),  
      abs(isnull(@w_saldo_me,0)),   6078,              'N',               
      'S',               'sa',               NULL,              
      NULL,              NULL,               NULL,              
      'N',               NULL)
      
      if @@error <> 0 begin
         rollback tran   
         set rowcount 0
         insert into cob_conta..cb_errores
         VALUES('sp_finpe','INSERTANDO CB_COMPROBANTE','oficina',CONVERT(VARCHAR(50),@w_oficina),getdate())      
         goto SIGUIENTE
      end
         
      insert into cob_conta..cb_asiento
      select
      @i_fec_ultdia,     
      @w_siguiente,     
      @i_empresa,
      asiento,
      cuenta, 
      @w_oficina,
      area,        
      credito,     
      debito,
      @w_descripcion, 
      credito_me,     
      debito_me,   
      0, 
      'N',  
      case when moneda = 0 then 'N' else 'C' end,  
      'N' ,    
      moneda,   
      NULL,  
      NULL, 
      NULL, 
      NULL, 
      @w_oficina, 
      NULL 
      from #saldos_cierre
      
      if @@error <> 0 begin
         rollback tran   
         set rowcount 0
         insert into cob_conta..cb_errores
         VALUES('sp_finpe','INSERTANDO CB_ASIENTO','oficina',CONVERT(VARCHAR(50),@w_oficina),getdate())      
         goto SIGUIENTE
      end
      
      
      insert into cob_conta..cb_retencion
      select
      @w_siguiente,   @i_empresa,     asiento,
      documento,      tdocumento,     ente,           
      @i_fec_ultdia,  cuenta,        '9999',          
      0,              0,              0,              NULL,           
      NULL,           NULL,           NULL,           NULL,           
      0,              NULL,           NULL,           NULL,          
      NULL,           NULL,           NULL,           NULL,          
      NULL,           NULL,           NULL,           '.',            
      @w_oficina,     NULL,           NULL
      from #saldos_cierre
      where isnull(ente, 0) > 0
      
      if @@error <> 0 begin
         rollback tran   
         set rowcount 0
         insert into cob_conta..cb_errores
         VALUES('sp_finpe','INSERTANDO CB_RETENCION','oficina',CONVERT(VARCHAR(50),@w_oficina),getdate())      
         goto SIGUIENTE
      end   
      
      commit tran
   end
   
   SIGUIENTE:   

   drop table #plan_general
   drop table #saldos_cierre

end
   
return 0

go