/************************************************************************/
/*      Archivo           :  gmf_pfijo.sp                               */
/*      Base de datos     :  cob_pfijo                                  */
/*      Producto          :                                             */
/*      Disenado por      :  Jose Molano                                */
/*      Fecha de escritura:  21/07/2014                                 */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*                    Reporte de transacciones de GMF                   */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*   FECHA          AUTOR              RAZON                            */
/************************************************************************/
use cob_conta
go

set nocount on
go

if exists(select 1 from sysobjects where name = 'sp_gmf_pfijo' and type = 'P')
   drop proc sp_gmf_pfijo
go

create proc sp_gmf_pfijo (
@i_param1    varchar(10),
@i_param2    varchar(10)
)
as
declare
@i_fecha_inicio   datetime,
@i_fecha_fin      datetime,
@w_fecha          datetime,
@w_error          int,
@w_anio           smallint,
@w_mes            smallint,
@w_dia            smallint,
@w_path_lis       varchar(100),
@w_s_app          varchar(100),
@w_destino        varchar(100),
@w_errores        varchar(100),
@w_comando        varchar(255),
@w_ruta           varchar(100)

select @i_fecha_inicio = '01/01/1900'
select @i_fecha_fin    = '01/01/1900'
select @w_fecha        = '01/01/1900'
select @w_error        = 0
select @w_anio         = 0
select @w_mes          = 0
select @w_dia          = 0

select @w_path_lis = pp_path_destino
from cobis..ba_path_pro  
where pp_producto = 6
if @@rowcount = 0 begin
  print 'No existe ruta de listados'
  return 1
end

select @w_ruta = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'
if @@rowcount = 0 begin
  print 'No existe ruta de s_app'
  return 1
end


if exists (select 1 from sysobjects where name = 'pf_gmf_semanal' and type = 'U') begin
   drop table pf_gmf_semanal 
end

create table pf_gmf_semanal (
PRODUCTO       varchar(10),
CUENTA         varchar(24),
OFICINA        varchar(10),
NOM_OFI        varchar(64),
NOMBRE         varchar(254),
DOCUMENTO      varchar(30),
ESTADO         varchar(10),
NRO_TITULO     varchar(24),
TRN            varchar(10),
FECHA_APER     varchar(10),
FECHA_CANCEL   varchar(10),
VALOR_CDT      varchar(30),
INT_PAGADO     varchar(30),
GMF            varchar(30),
BASE_GMF_INT   varchar(30),
BASE_GMF_CAP   varchar(30),
VALOR_GMF_CAP  varchar(30),
VALOR_GMF_INT  varchar(30)
)

if exists (select 1 from sysobjects where name = '#pf_gmf_semanal' and type = 'U') begin
   drop table #pf_gmf_semanal 
end

create table #pf_gmf_semanal (
PRODUCTO       varchar(10),
CUENTA         varchar(24),
OFICINA        varchar(10),
NOM_OFI        varchar(64),
NOMBRE         varchar(254),
DOCUMENTO      varchar(30),
ESTADO         varchar(10),
NRO_TITULO     varchar(24),
TRN            varchar(10),
FECHA_APER     varchar(10),
FECHA_CANCEL   varchar(10),
VALOR_CDT      varchar(30),
INT_PAGADO     varchar(30),
GMF            varchar(30),
BASE_GMF_INT   money,
BASE_GMF_CAP   money,
VALOR_GMF_CAP  money,
VALOR_GMF_INT  money,
SECUENCIAL     int
)
create table #temporal (
tr_banco               varchar(24),
tr_tran                int,
tr_secuencia           int,
ret_practicadaT        money,
int_pagadosT           money,
valor_gmf_capT         money,
valor_gmf_intT         money)

create index idx1 on #temporal (tr_banco)
  
create table #aux (
sec_aux        varchar(24), 
operacion      int,     
monto          money,   
banco          varchar(24), 
trn            int,
num_tran       int ,    
valor          money ,  
gmf            money,   
forma_pago     varchar(10),
secuencial     int )

create table #datos_cdt_det ( 
tr_banco        varchar(24), 
tr_operacion    int        ,  
tr_secuencia    int        ,  
td_concepto     varchar(10), 
tr_tran         int        ,  
tr_tipo_tran    varchar(3) ,  
tr_valor        money  ) 

select @i_fecha_inicio = convert(datetime, @i_param1)
select @i_fecha_fin = convert(datetime, @i_param2)
select @w_fecha = @i_fecha_inicio

insert into pf_gmf_semanal
values('PRODUCTO',     'CUENTA',       'OFICINA',      'NOM_OFI',      
       'NOMBRE',       'DOCUMENTO',    'ESTADO',       'NRO_TITULO',   
       'TRN',		   'FECHA_APER',   'FECHA_CANC',   'VALOR_TITULO',          
       'INT_PAGADO',   'GMF',          'BASE_GMF_INT', 'BASE_GMF_CAP', 
       'VALOR_GMF_CAP','VALOR_GMF_INT')

if @@error <> 0 begin
   print 'Error al insertar cabecera'
   select @w_error = 1
   goto final
end       

while 1 = 1 begin
   
   insert into #pf_gmf_semanal  
   select
   PRODUCTO     = 14,
   CUENTA       = (select re_substring from cob_conta..cb_relparam where re_producto = 14 and   re_substring like '%2530%'),
   OFICINA      = convert(varchar(10),tr_ofi_oper),
   NOM_OFI      = (select of_nombre from cobis..cl_oficina where of_oficina = tr_ofi_oper),
   NOMBRE       = (select en_nomlar from cobis..cl_ente where en_ente = op_ente),
   DOCUMENTO    = (select en_ced_ruc from cobis..cl_ente where en_ente = op_ente),
   ESTADO       = op_estado,
   NRO_TITULO   = op_num_banco,
   TRN          = tr_tran,
   FECHA_APER   = convert(varchar(10), op_fecha_crea,103),
   FECHA_CANCEL = convert(varchar(10), op_fecha_cancela,103),
   VALOR_CDT    = convert(varchar(30), op_monto),
   INT_PAGADO   = convert(varchar(30), op_int_pagados),
   GMF          = convert(varchar(30), td_monto),
   BASE_GMF_INT = convert(money, 0), 
   BASE_GMF_CAP = convert(money, 0),
   VALOR_GMF_CAP = convert(money, 0),
   VALOR_GMF_INT = convert(money, 0),
   SECUENCIAL    = tr_secuencial 
   from cob_pfijo..pf_transaccion with(nolock),
        cob_pfijo..pf_transaccion_det with(nolock),
        cob_pfijo..pf_operacion
   where tr_fecha_mov  = @w_fecha
   and   tr_estado     = 'CON'
   and   td_operacion  = tr_operacion
   and   td_secuencial = tr_secuencial
   and   td_concepto   = 'GMF'
   and   tr_operacion  = op_operacion
   
   if @@error <> 0 begin
      print 'Error al insertar en tabla temporal pfijo'
      select @w_error = 1
      goto final
   end

   insert into #temporal
   select 
   tr_banco,
   tr_tran,
   tr_secuencia,
   ret_practicadaT = isnull(sum(case when tr_tran = 14905 and td_concepto = 'RET' then td_monto else 0 end),0),
   int_pagadosT    = isnull(sum(case when tr_tran = 14905 and td_concepto = 'INT' then td_monto else 0 end),0),
   valor_gmf_capT  = isnull(sum(case when tr_tran = 14903 and td_concepto = 'GMF' then td_monto else 0 end),0),
   valor_gmf_intT  = isnull(sum(case when tr_tran = 14905 and td_concepto = 'GMF' then td_monto else 0 end),0)
   from cob_pfijo..pf_transaccion with (nolock), cob_pfijo..pf_transaccion_det with (nolock)
   where tr_fecha_mov  = @w_fecha
   and   tr_estado     = 'CON'
   and   tr_tran       in( 14905, 14903)
   and   td_operacion  = tr_operacion
   and   td_secuencial = tr_secuencial
   group by tr_banco,tr_tran,tr_secuencia
   
   update #pf_gmf_semanal set
   BASE_GMF_INT   = (isnull(int_pagadosT,0) - isnull(ret_practicadaT,0)),
   BASE_GMF_CAP   = 0,
   VALOR_GMF_CAP  = valor_gmf_capT,
   VALOR_GMF_INT  = valor_gmf_intT
   from #temporal
   where tr_banco = NRO_TITULO
   and   tr_tran  = TRN
   
   insert into #aux
   select 
   'sec_aux'    = isnull(M.mm_secuencial,'-1'),
   'operacion'  = tr_operacion, 
   'monto'      = op_monto, 
   'banco'      = tr_banco,
   'trn'        = tr_tran,
   'num_tran'   = convert(int,0),
   'valor'      = td_monto,
   'gmf'		= isnull(mm_emerg_eco,0),
   'forma_pago' = td_concepto,
   'secuencial' = tr_secuencial
   from	cob_pfijo..pf_transaccion T, 
        cob_pfijo..pf_transaccion_det,
        cob_pfijo..pf_mov_monet M,
   		cob_pfijo..pf_operacion
   where   T.tr_operacion = op_operacion
   and	   T.tr_operacion = M.mm_operacion
   and     T.tr_operacion = td_operacion 
   and     T.tr_secuencial = td_secuencial
   and     T.tr_tran = 14943 
   and     T.tr_estado = 'CON'
   and     T.tr_secuencia = M.mm_secuencia  
   and     T.tr_fecha_mov  = @w_fecha
   and     td_concepto not in ('VXP','OTROS','PCHC')
   and     td_aux = mm_sub_secuencia
   order by T.tr_operacion, T.tr_secuencial
   
   update	#aux 
   set num_tran = isnull(M.mm_tran,0) 
   from	#aux A, cob_pfijo..pf_mov_monet M
   where	M.mm_operacion = operacion
   and		convert(varchar(50),M.mm_secuencial) = sec_aux
   and		M.mm_tran in (14903,14905,14943)
   
   insert into #datos_cdt_det
   select tr_banco,
   tr_operacion, 
   tr_secuencia ,
   td_concepto,
   tr_tran,
   tr_tipo_tran = case when tr_tran = 14905 then 'INT'
   when tr_tran = 14903 then 'CAP' end,
   tr_valor = isnull(sum(td_monto),0)
   from cob_pfijo..pf_transaccion with (nolock),
   cob_pfijo..pf_transaccion_det with (nolock)
   where tr_operacion = td_operacion
   and tr_secuencial = td_secuencial
   and tr_estado = 'CON'
   and tr_tran in (14903,14905)
   and td_concepto not in ('VXP','OTROS','PCHC')
   and tr_fecha_mov  = @w_fecha
   and td_concepto in (select fp_mnemonico from cob_pfijo..pf_fpago where fp_estado = 'A')
   group by tr_banco, tr_operacion,tr_secuencia ,td_concepto, tr_tran
   order by tr_banco
   
   update #pf_gmf_semanal set
   BASE_GMF_CAP   =    (select ISNULL(sum(mm_valor),0) from  #datos_cdt_det, cob_pfijo..pf_mov_monet   where tr_banco =  D.NRO_TITULO and tr_tran = D.TRN and mm_operacion = tr_operacion   and mm_secuencia = tr_secuencia   and mm_tran = 14903    and td_concepto = mm_producto     and mm_emerg_eco > 0   and mm_valor = tr_valor   and mm_estado ='A')
                     + (select ISNULL(sum(valor),0) FROM  #aux where banco = D.NRO_TITULO and trn = D.TRN and num_tran in ( 14903, 14943) and forma_pago <> 'GMF' and gmf > 0 and secuencial = SECUENCIAL),
   VALOR_GMF_CAP  = VALOR_GMF_CAP + (select ISNULL(sum(gmf),0) FROM #aux where banco  = D.NRO_TITULO and num_tran = 14903 ),
   VALOR_GMF_INT  = VALOR_GMF_INT + (select ISNULL(sum(gmf),0) FROM #aux where banco  = D.NRO_TITULO and num_tran = 14905 )
   from #pf_gmf_semanal D
   
   update #pf_gmf_semanal set
   VALOR_GMF_CAP = GMF
   where BASE_GMF_CAP > 0
   and   VALOR_GMF_CAP = 0
   
   insert into pf_gmf_semanal 
   select 
	PRODUCTO,
	convert(varchar(24),CUENTA),   
	OFICINA,      
	NOM_OFI,      
	NOMBRE ,      
	DOCUMENTO,    
	ESTADO,       
	NRO_TITULO, 
	convert(varchar(10),TRN),  
	FECHA_APER,   
	FECHA_CANCEL, 
	VALOR_CDT,    
	INT_PAGADO,   
	GMF,          
	convert(varchar(30),BASE_GMF_INT), 
	convert(varchar(30),BASE_GMF_CAP), 
	convert(varchar(30),VALOR_GMF_CAP), 
	convert(varchar(30),VALOR_GMF_INT)   
   from #pf_gmf_semanal
     
   insert into pf_gmf_semanal
   select 
   PRODUCTO     = 4,
   CUENTA       = '25301500005',
   OFICINA      = convert(varchar(10),hs_oficina),
   NOM_OFI      = (select of_nombre  from cobis..cl_oficina where of_oficina = X.hs_oficina),
   NOMBRE       = (select en_nomlar  from cobis..cl_ente where en_ente       = X.hs_cliente),
   DOCUMENTO    = (select en_ced_ruc from cobis..cl_ente where en_ente       = X.hs_cliente),
   ESTADO       = (select top 1 ah_estado    from cob_ahorros..ah_cuenta where ah_cta_banco = X.hs_cta_banco),
   NRO_TITULO   = (select top 1 ah_cta_banco from cob_ahorros..ah_cuenta where ah_cta_banco = X.hs_cta_banco),
   TRN          = convert(varchar(10),hs_tipo_transaccion),
   FECHA_APER   = (select top 1 convert(varchar(10), ah_fecha_aper,103) from cob_ahorros..ah_cuenta where ah_cta_banco = X.hs_cta_banco),
   FECHA_CANCEL = convert(varchar(10), ''),
   VALOR_CDT    = convert(varchar(30), 0),
   INT_PAGADO   = convert(varchar(30), 0),
   GMF          = convert(varchar(30), hs_valor),
   BASE_GMF_INT = convert(varchar(30), hs_interes), 
   BASE_GMF_CAP = convert(varchar(30), 0),
   VALOR_GMF_CAP = convert(varchar(30), hs_valor),
   VALOR_GMF_INT = convert(varchar(30), 0)   
   from cob_ahorros_his..ah_his_servicio X        
   where hs_tsfecha          = @w_fecha
   and   hs_tipo_transaccion = 379
   
   if @@error <> 0 begin
      print 'Error al insertar en tabla temporal ahorros'
      select @w_error = 1
      goto final
   end
   
   insert into pf_gmf_semanal
   select 
   PRODUCTO     = 3,
   CUENTA       = convert(varchar(12),(select re_substring from cob_conta..cb_relparam where re_producto = 4 and re_substring like '%2530%' and re_clave like '%NDEGMF')),
   OFICINA      = convert(varchar(10),to_ofic_dest),
   NOM_OFI      = (select of_nombre from cobis..cl_oficina where of_oficina = to_ofic_dest),
   NOMBRE       = (select en_nomlar from cobis..cl_ente where en_ente = to_cliente),
   DOCUMENTO    = (select en_ced_ruc from cobis..cl_ente where en_ente = to_cliente),
   ESTADO       = 'CON',
   NRO_TITULO   = '',
   TRN          = convert(varchar(10),to_tipo_tran),
   FECHA_APER   = convert(varchar(10), ''),
   FECHA_CANCEL = convert(varchar(10), ''),
   VALOR_CDT    = convert(varchar(30), 0),
   INT_PAGADO   = convert(varchar(30), 0),
   GMF          = convert(varchar(30), to_valor),
   BASE_GMF_INT = convert(varchar(30), 0), 
   BASE_GMF_CAP = convert(varchar(30), 0),
   VALOR_GMF_CAP = convert(varchar(30), to_valor),
   VALOR_GMF_INT = convert(varchar(30), 0) 
   from cob_remesas_his..re_his_total
   where to_hora = @w_fecha
   and   to_perfil  = 'EG_GMFGENE'

   if @w_fecha = @i_fecha_fin begin
      break
   end
   
   delete #pf_gmf_semanal
   
   select @w_fecha = dateadd(dd, 1, @w_fecha)
end

select @w_anio = datepart(yy, convert(datetime,@i_fecha_fin))
select @w_mes  = datepart(mm, convert(datetime,@i_fecha_fin))
select @w_dia  = datepart(dd, convert(datetime,@i_fecha_fin))

select @w_s_app =  's_app bcp -auto -login cob_conta..pf_gmf_semanal out '
select @w_destino  = 'pf_gmf_pfijo_'+ convert(varchar, @w_anio)+ convert(varchar, @w_mes) + convert(varchar, @w_dia) + '.txt',
       @w_errores  = @w_path_lis + 'pf_gmf_semanal' + '.err'
select @w_comando = @w_ruta + @w_s_app + @w_path_lis + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+  + @w_ruta + 's_app.ini'


exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   print 'Error Generando archivo plano'
   print @w_s_app
   print @w_destino
   print @w_errores
   print @w_path_lis
   print @w_ruta
   print @w_comando
   goto final
end

final:
if @w_error = 1 
   return 1
   
return 0
go
