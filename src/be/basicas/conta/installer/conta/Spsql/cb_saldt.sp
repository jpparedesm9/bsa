use cob_conta
go

if exists(select * from cob_conta..sysobjects where name = 'sp_promedios_terceros')
   drop proc sp_promedios_terceros
go

create proc sp_promedios_terceros(
   @i_empresa		  tinyint,
   @i_fecha	          datetime,
   @i_nivel_oficina	  int,
   @i_oficina_i	          smallint,
   @i_oficina_f	          smallint,
   @i_cuenta_i            cuenta,
   @i_cuenta_f            cuenta,
   @i_area                smallint
)
as

declare 
   @w_cuenta			cuenta,
   @w_nombre			varchar(80),
   @w_sp_name			varchar(50),
   @w_oficina			smallint,
   @w_saldo			money,
   @w_prom_act			money,
   @w_prom_ant           	money,
   @w_var_abs                   money,
   @w_var_rel         		money,
   @w_anio 			char(4),
   @w_mes			char(2),
   @w_fec_ant			datetime,
   @w_corte_ant			int,
   @w_corte			int,
   @w_dias_act			int,
   @w_dias_ant			int,
   @w_periodo     		int,
   @w_periodo_ant		int,
   @w_periodof_ini		int,
   @w_periodof_fin		int,
   @w_cortef_ini		int,
   @w_cortef_fin		int,
   @w_contador			int,
   @w_ente1                     int,  
   @w_cuenta1                   cuenta,
   @w_concepto1                 money, 
   @w_concepto2                 money, 
   @w_concepto3                 money, 
   @w_concepto4                 money, 
   @w_concepto5                 money,
   @w_oficina1                  smallint, 
   @w_concepto6                 money


select @w_sp_name = 'sp_promedios_terceros'

truncate  table cob_conta..tmp_cb_saldo_ter
truncate  table cob_conta..tmp_cb_saldo_ter2
truncate  table cob_conta..cb_oficina_temp


select @w_anio = convert(char(4),datepart (yy,@i_fecha))   
select @w_mes  = convert(char(2),datepart (mm,@i_fecha))  

select @w_fec_ant = right('00' + convert(varchar(2),@w_mes),2) + '/01/' +  right('0000' + convert(varchar(4),@w_anio),4)
select @w_fec_ant = dateadd(dd,-1, @w_fec_ant)  

select @w_corte_ant   = co_corte, 
       @w_periodo_ant = co_periodo
from  cb_corte
where co_empresa   = @i_empresa
and   co_periodo  >= 0
and   co_corte    >= 0
and   co_fecha_ini = @w_fec_ant
and   co_fecha_fin = @w_fec_ant

select @w_corte   = co_corte, 
       @w_periodo = co_periodo
from  cb_corte
where co_empresa   = @i_empresa
and   co_periodo  >= 0
and   co_corte    >= 0
and   co_fecha_ini = @i_fecha
and   co_fecha_fin = @i_fecha


select @w_nombre = convert(char(15),@w_periodo_ant)
insert into cob_conta..cb_oficina_temp
select je_oficina, je_oficina_padre
   from  cob_conta..cb_oficina,cob_conta..cb_jerarquia
   where of_empresa = convert(tinyint,@i_empresa)
   and   of_oficina >= convert(smallint,@i_oficina_i)
   and   of_oficina <= convert(smallint,@i_oficina_f)
   and   of_organizacion = convert(tinyint,@i_nivel_oficina)
   and   je_empresa = of_empresa
   and   je_oficina_padre = of_oficina


declare cursor_cuentas cursor for
   select cp_cuenta from cob_conta..cb_cuenta_proceso
   where cp_empresa = convert(tinyint,@i_empresa)
   and   cp_proceso in (6003,6095)
   and   cp_oficina >= 0
   and   cp_area >= 0
   and   cp_cuenta >= @i_cuenta_i
   and   cp_cuenta <= @i_cuenta_f
for read only


open  cursor_cuentas
fetch cursor_cuentas  into @w_cuenta
while @@fetch_status = 0
begin   
   if @@fetch_status = -2
   begin
      print 'Error en Fetch de Cursor Cuenta'
      return 0
   end       
   
   if @i_area = 255
   begin

      insert into cob_conta..tmp_cb_saldo_ter
      select @i_empresa,@w_cuenta,ot_oficina_padre,st_ente,' ',' ',' ',0,sum(st_mov_debito),sum(st_mov_credito),
             sum(st_saldo),0, sum(st_mov_debito_me),sum(st_mov_credito_me),sum(st_saldo_me)
      from cob_conta_tercero..ct_saldo_tercero, cob_conta..cb_oficina_temp    
      where st_empresa = @i_empresa
      and   st_periodo = @w_periodo
      and   st_corte  = @w_corte
      and   st_cuenta = @w_cuenta
      and   st_oficina = ot_oficina
      and   st_area > 0
      and   st_ente > 0
      group by ot_oficina_padre, st_ente


      insert into cob_conta..tmp_cb_saldo_ter2
      select @i_empresa,@w_cuenta,ot_oficina_padre,st_ente,sum(st_saldo), sum(st_mov_debito),sum(st_mov_credito),
      sum(st_saldo_me), sum(st_mov_debito_me),sum(st_mov_credito_me)
      from cob_conta_tercero..ct_saldo_tercero, cob_conta..cb_oficina_temp 
      where ot_oficina >= 0
      and   st_empresa = @i_empresa
      and   st_periodo = @w_periodo_ant
      and   st_corte  = @w_corte_ant
      and   st_cuenta = @w_cuenta
      and   st_oficina = ot_oficina
      and   st_area > 0
      and   st_ente > 0
      group by ot_oficina_padre, st_ente
   end
   else
   begin
      insert into cob_conta..tmp_cb_saldo_ter
      select @i_empresa,@w_cuenta,ot_oficina_padre,st_ente,' ',' ',' ',0,sum(st_mov_debito),sum(st_mov_credito),
             sum(st_saldo),0, sum(st_mov_debito_me),sum(st_mov_credito_me),sum(st_saldo_me)
      from cob_conta_tercero..ct_saldo_tercero, cob_conta..cb_oficina_temp    
      where st_empresa = @i_empresa
      and   st_periodo = @w_periodo
      and   st_corte  = @w_corte
      and   st_cuenta = @w_cuenta
      and   st_oficina = ot_oficina
      and   st_area = @i_area
      and   st_ente > 0
      group by ot_oficina_padre, st_ente


      insert into cob_conta..tmp_cb_saldo_ter2
      select @i_empresa,@w_cuenta,ot_oficina_padre,st_ente,sum(st_saldo), sum(st_mov_debito),sum(st_mov_credito),
      sum(st_saldo_me), sum(st_mov_debito_me),sum(st_mov_credito_me)
      from cob_conta_tercero..ct_saldo_tercero, cob_conta..cb_oficina_temp 
      where ot_oficina >= 0
      and   st_empresa = @i_empresa
      and   st_periodo = @w_periodo_ant
      and   st_corte  = @w_corte_ant
      and   st_cuenta = @w_cuenta
      and   st_oficina = ot_oficina
      and   st_area = @i_area
      and   st_ente > 0
      group by ot_oficina_padre, st_ente
   end
   fetch cursor_cuentas  into @w_cuenta
end
close cursor_cuentas
deallocate cursor_cuentas


update cob_conta..tmp_cb_saldo_ter
set ts_ced_ruc = convert(varchar(20),en_ced_ruc),
    ts_tipo    = en_tipo_ced,
    ts_nombre =  en_nomlar
from cobis..cl_ente
where en_filial = convert(tinyint,@i_empresa)
and   ts_empresa = en_filial
and   ts_ente  = en_ente
and   ts_ente > 0
and   ts_oficina >= 0

go