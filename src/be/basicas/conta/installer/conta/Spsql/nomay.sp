/************************************************************************/
/*   Archivo:                       valida_mig.sp                       */
/*   Stored procedure:              sp_valida_mig                       */
/*   Base de datos:                 cob_conta                           */
/*   Producto:                      contabilidad                        */
/*   Disenado por:                  Jose Rafael Molano Z                */
/*   Fecha de escritura:            23/Abril/2008                       */
/************************************************************************/
/*                            IMPORTANTE                                */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "MACOSA", representantes exclusivos para el Ecuador de la          */
/*   "NCR CORPORATION".                                                 */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/*                             PROPOSITO                                */
/*   Este programa sumariza los movimientos no mayorizados en           */
/*   contabilidad.                                                      */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*       FECHA                 AUTOR             RAZON                  */
/*                                                                      */
/************************************************************************/
use cob_conta
go

if exists (select 1 from sysobjects where name = 'sp_may_tmp' and xtype = 'P')
   drop proc sp_may_tmp
go

create proc sp_may_tmp
(
   @s_user       login           = NULL,
   @t_trn        smallint        = NULL,
   @i_empresa    tinyint,
   @i_oficina    smallint        = 0,
   @i_area       smallint        = 0,
   @i_operacion  char(1),
   @i_cuenta_ini cuenta_contable = '1',
   @i_cuenta_fin cuenta_contable = '9',
   @i_modo       tinyint         = 0,
   @i_secuencial int             = NULL,
   @i_spid       int             = NULL

)
as
declare @w_fecha_min   datetime,
        @w_fecha_tran  datetime,
        @w_hora_ini    datetime,
        @w_hora_fin    datetime,
        @w_total       int,
        @w_contsald    int,
        @w_sp_name     char(20),
        @w_spid        int
        
select @w_sp_name = 'sp_may_tmp'

if (@t_trn <> 6215 and @i_operacion = 'Q')
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end

create table #movi_nomay
(
as_empresa       tinyint      NULL,
as_cuenta        varchar(14)  NULL,
as_oficina_dest  smallint     NULL,
as_area_dest     smallint     NULL,
as_debito        money        NULL,
as_credito       money        NULL,
as_debito_me     money        NULL,
as_credito_me    money        NULL
)

select @w_fecha_min = min(co_fecha_ini)
from cob_conta..cb_corte
where co_empresa = @i_empresa
and   co_estado = 'V'

select @w_fecha_tran = max(co_fecha_ini)
from cob_conta..cb_corte
where co_empresa = @i_empresa
and   co_estado = 'A'

if @i_operacion = 'Q'
begin
     if @i_modo = 0
     begin
         delete cob_conta..cb_saldo_may
         where sa_usuario = @s_user     

         select @w_spid = @@spid
         if @i_oficina = 255
         begin
              insert into #movi_nomay
              select @i_empresa, 
                     as_cuenta, 
                     @i_oficina, 
                     @i_area, 
                     sum(as_debito), 
                     sum(as_credito), 
                     sum(as_debito_me), 
                     sum(as_credito_me)
              from  cb_comprobante, cb_asiento
              where co_empresa       = @i_empresa
                and co_fecha_tran  between @w_fecha_min and @w_fecha_tran
                and co_comprobante  >= 0
                and co_oficina_orig >= 0
                and co_autorizado    = 'S'
                and co_automatico   >= 0
                and co_mayorizado    = 'N'
                and as_empresa       = co_empresa
                and as_fecha_tran    = co_fecha_tran
                and as_comprobante   = co_comprobante
                and as_oficina_orig  = co_oficina_orig
                and as_asiento      >= 0
                and as_cuenta       >= @i_cuenta_ini
                and as_cuenta       <= @i_cuenta_fin
                and as_mayorizado    = 'N'
              group by as_empresa, as_cuenta, as_fecha_tran
              
              if @@error <> 0
              begin
                  exec cobis..sp_cerror
                  @t_from  = @w_sp_name,
                  @i_num   = 601161
                  print '601161-1'
                  return 1
              end
              
              
              insert into cb_saldo_may (
                     sa_spid,        sa_usuario,    sa_empresa,    
                     sa_cuenta,      sa_oficina,    sa_area,       
                     sa_debito,      sa_credito,    sa_debito_me, 
                     sa_credito_me,  sa_saldo,      sa_saldo_me,   
                     sa_saldonm,     sa_saldonm_me)
              select @w_spid,             @s_user,          @i_empresa,     
                     sa_cuenta,           @i_oficina,       @i_area,       
                     sum(sa_debito),      sum(sa_credito),  sum(sa_debito_me), 
                     sum(sa_credito_me),  sum(sa_saldo),    sum(sa_saldo_me),   
                     0,                   0
              from cob_conta..cb_saldo,
                   #movi_nomay
              where as_cuenta  > ''
              and   sa_cuenta = as_cuenta
              and   sa_empresa = @i_empresa
              group by sa_cuenta
              
              if @@error <> 0
              begin
                  exec cobis..sp_cerror
                  @t_from  = @w_sp_name,
                  @i_num   = 601161
                  print '601161-2'
                  return 1
              end              
         
         end
         else
         begin
              if @i_oficina <> 255
              begin
                 insert into #movi_nomay
                 select @i_empresa, 
                        as_cuenta, 
                        @i_oficina, 
                        @i_area, 
                        sum(as_debito), 
                        sum(as_credito), 
                        sum(as_debito_me), 
                        sum(as_credito_me)
                 from  cb_comprobante, cb_asiento
                 where co_empresa       = @i_empresa
                   and co_fecha_tran  between @w_fecha_min and @w_fecha_tran
                   and co_comprobante  >= 0
                   and co_oficina_orig >= 0
                   and co_autorizado    = 'S'
                   and co_automatico   >= 0
                   and co_mayorizado    = 'N'
                   and as_empresa       = co_empresa
                   and as_fecha_tran    = co_fecha_tran
                   and as_comprobante   = co_comprobante
                   and as_oficina_orig  = co_oficina_orig
                   and as_oficina_dest  in (select je_oficina from cb_jerarquia where je_oficina_padre = @i_oficina and je_empresa = @i_empresa)
                   and as_asiento      >= 0
                   and as_cuenta       >= @i_cuenta_ini
                   and as_cuenta       <= @i_cuenta_fin
                   and as_mayorizado    = 'N'
                 group by as_empresa, as_cuenta, as_fecha_tran, as_oficina_dest, as_area_dest
                 
                 if @@error <> 0
                 begin
                     exec cobis..sp_cerror
                     @t_from  = @w_sp_name,
                     @i_num   = 601161
                     print '601161-3'
                     return 1
                 end                 
              
                 insert into cb_saldo_may (
                        sa_spid,        sa_usuario,    sa_empresa,    
                        sa_cuenta,      sa_oficina,    sa_area,       
                        sa_debito,      sa_credito,    sa_debito_me,  
                        sa_credito_me,  sa_saldo,      sa_saldo_me,   
                        sa_saldonm,     sa_saldonm_me)
                 select @w_spid,             @s_user,             @i_empresa,     
                        sa_cuenta,           @i_oficina,          @i_area,       
                        sum(sa_debito),      sum(sa_credito),     sum(sa_debito_me),  
                        sum(sa_credito_me),  sum(sa_saldo),       sum(sa_saldo_me),   
                        0,                   0
                 from cob_conta..cb_saldo,
                      #movi_nomay
                 where as_cuenta  > ''
                 and   sa_cuenta = as_cuenta
                 and   sa_oficina in (select je_oficina from cb_jerarquia where je_oficina_padre = @i_oficina and je_empresa = @i_empresa)
                 and   sa_empresa = @i_empresa
                 group by sa_cuenta
                 
                 if @@error <> 0
                 begin
                     exec cobis..sp_cerror
                     @t_from  = @w_sp_name,
                     @i_num   = 601161
                     print '601161-4'
                     return 1
                 end                                 
              end
         end
         
         select  mf_cuenta       = as_cuenta,         
                 mf_oficina_dest = as_oficina_dest,    
                 mf_area_dest =as_area_dest
         into #mov_falta
         from #movi_nomay, 
              cb_saldo_may
         where sa_cuenta <> as_cuenta
         or   sa_oficina <> as_oficina_dest
         or   sa_area <> as_area_dest
         group by as_cuenta, as_oficina_dest,as_area_dest
         
         update cb_saldo_may
         set sa_debito     = (sa_debito + as_debito),
             sa_credito    = (sa_credito + as_credito),
             sa_debito_me  = (sa_debito_me + as_debito_me),
             sa_credito_me = (sa_credito_me + as_credito_me),
             sa_saldonm    = (as_debito - as_credito),
             sa_saldonm_me = (as_debito_me - as_credito_me)
         from #movi_nomay, 
              cb_saldo_may
         where sa_cuenta > ''
         and   sa_cuenta = as_cuenta
         and   sa_oficina = as_oficina_dest
         and   sa_area = as_area_dest
         
         if @@error <> 0
         begin
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 601162
             print '601162-1'
             return 1
         end                         
         
         insert into cb_saldo_may (sa_spid,        sa_usuario,  sa_empresa,     
                                  sa_cuenta,       sa_oficina,  sa_area,       
                                  sa_debito,       sa_credito,  sa_debito_me,  
                                  sa_credito_me,   sa_saldo,    sa_saldo_me,  
                                  sa_saldonm,      sa_saldonm_me)
         
         select                  @w_spid,        @s_user,       as_empresa,     
                                 as_cuenta,      @i_oficina,    @i_area,  
                                 as_debito,      as_credito,    as_debito_me,  
                                 as_credito_me,  0,             0,         
                                 (as_debito - as_credito), (as_debito_me - as_credito_me)
         from #movi_nomay, 
              #mov_falta
         where mf_cuenta > ''
         and   as_cuenta = mf_cuenta
         and   as_oficina_dest = mf_oficina_dest
         and   as_area_dest = mf_area_dest
         
         if @@error <> 0
         begin
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 601161
             print '601161-5'
             return 1
         end             
         
         set rowcount 20
         select 
         'EMPRESA'         = sa_empresa,
         'CUENTA'          = sa_cuenta,
         'OFICINA'         = sa_oficina,
         'AREA'            = sa_area,
         'SALDO MN'        = convert(money,sa_saldo),
         'SALDO ME'        = convert(money,sa_saldo_me),
         'DEBITO MN'       = convert(money,sa_debito),
         'CREDITO MN'      = convert(money,sa_credito),
         'DEBITO ME'       = convert(money,sa_debito_me),
         'CREDITO ME'      = convert(money,sa_credito_me),
         'SALDO NO MAY'    = convert(money,sa_saldonm),
         'SALDO NO MAY ME' = convert(money,sa_saldonm_me),
         'ID CONSULTA'     = sa_spid,
         'SECUENCIAL'      = sa_secuencial
         from cb_saldo_may
         where sa_spid    = @w_spid
         and   sa_usuario = @s_user
         order by sa_secuencial
         
         if @@rowcount = 0
         begin
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 601153
             return 1
         end         
     end
     else
     begin
        if @i_modo = 1
        begin
            select @w_spid = @i_spid
            set rowcount 20
            select 
            'EMPRESA'         = sa_empresa,
            'CUENTA'          = sa_cuenta,
            'OFICINA'         = sa_oficina,
            'AREA'            = sa_area,
            'SALDO MN'        = convert(money,sa_saldo),
            'SALDO ME'        = convert(money,sa_saldo_me),
            'DEBITO MN'       = convert(money,sa_debito),
            'CREDITO MN'      = convert(money,sa_credito),
            'DEBITO ME'       = convert(money,sa_debito_me),
            'CREDITO ME'      = convert(money,sa_credito_me),
            'SALDO NO MAY'    = convert(money,sa_saldonm),
            'SALDO NO MAY ME' = convert(money,sa_saldonm_me),
            'ID CONSULTA'     = sa_spid,
            'SECUENCIAL'      = sa_secuencial
            from cb_saldo_may
            where sa_spid    = @w_spid
            and   sa_usuario = @s_user
            and   sa_secuencial > @i_secuencial
            order by sa_secuencial
        end        
     end   
end

return 0

go