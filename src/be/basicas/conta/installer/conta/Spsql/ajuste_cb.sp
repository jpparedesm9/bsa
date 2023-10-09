/************************************************************************/
/*   Archivo:             ajuste_cb.sp                                  */
/*   Stored procedure:    sp_ajuste_cb                                  */
/*   Base de datos:       cob_conta                                     */
/*   Producto:            Contabilidad                                  */
/*   Disenado por:        Rafael Molano / Carlos Hernández              */
/*   Fecha de escritura:  Diciembre-2012                                */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/  
/*                           PROPOSITO                                  */  
/*   Este programa maneja el ajuste de corresponsales bancarios para la */
/*   cuenta de proceso 19049500800                                      */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA              AUTOR             RAZON                          */
/* 																		*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_ajuste_cb')
   drop proc sp_ajuste_cb
go

create proc sp_ajuste_cb(
@i_param1 varchar(255),
@i_param2 varchar(255),
@i_param3 varchar(1)   = 'N'
)

as 
declare 
@i_fecha         datetime,
@i_empresa       tinyint,
@i_reproceso     char(1),
@w_cuenta        varchar(24),
@w_cobcb         int,
@w_oficina       smallint,
@w_comprobante   int,
@w_descripcion   varchar(80),
@w_concepto      varchar(80),
@w_usuario       varchar(20),
@w_comp          int,
@w_cantidad      int,
@w_sec           int,
@w_count         int,
@w_proc          int,
@w_reemplazo     int,
@w_error         int,
@w_rowcount      int

set nocount on

select @w_comprobante = 0
select @w_usuario     = 'BANCOR'
select @w_descripcion = 'RECLASIFICACION POR CLIENTES CB'
select @w_concepto    = 'RECLASI. CLIENTE CB'
select @w_error       = 0
select @w_rowcount    = 0

select  @i_empresa  = convert(tinyint,  @i_param1)
select  @i_fecha    = convert(datetime, @i_param2)
select  @i_reproceso = convert(char(1), @i_param3)

select @w_cobcb = pa_int
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'CCCNB'

select cp_cuenta
into #cuentas
from cob_conta..cb_cuenta_proceso
where cp_proceso = 6151

select @w_cuenta = cp_cuenta
from #cuentas

if @@rowcount = 0 begin
   print 'Error no existe cuenta asociada al proceso'
   return 141142 
end

select c.codigo
into #productos
from cobis..cl_tabla t,
     cobis..cl_catalogo c
where t.tabla = 'cb_productos_cb'
and   t.codigo = c.tabla

if @i_reproceso = 'S' begin
  delete cob_conta..cb_ajuste_cb_log
  where ac_fecha = @i_fecha
  
  delete cob_externos..ex_convivencia_tmp
  where ct_usuario_modulo = 'BANCOR'
end

if exists(select 1 from cob_conta..cb_ajuste_cb_log where ac_fecha = @i_fecha and ac_estado = 'P')
begin
   print 'Error al actualizar en la tabla #base'
   return 150001
end  

select *
into #convivencia_tmp
from cob_externos..ex_convivencia_tmp
where 1=2

select 
empresa  = sa_empresa,
producto = sa_producto, 
oficina  = sa_oficina_dest, 
Area     = sa_area_dest, 
Fecha    = sa_fecha_tran, 
Cuenta   = sa_cuenta, 
Valor    = sa_debito - sa_credito,
valor_me = sa_debito_me - sa_credito_me,
Ente     = sa_ente, 
CB       = 0, 
Documento  = sa_documento, 
Comp_cobis = 0, 
Comp_ext   = 0,
moneda     = sa_moneda
into   #base
from   cob_conta_tercero..ct_sasiento
where  1=2

alter table #base add Secuencia int identity (1,1)

--Comprobantes generados desde productos COBIS en Corresponsales Bancarios
insert into #base
select 
sa_empresa, 
sa_producto, 
sa_oficina_dest, 
sa_area_dest, 
sa_fecha_tran, 
sa_cuenta, 
sa_valor = sa_debito - sa_credito, 
valor_me = sa_debito_me - sa_credito_me, 
sa_ente, 
0, 
sa_documento, 
sa_comprobante, 
0,
sa_moneda
from   cob_conta_tercero..ct_sasiento with (nolock), cobis..cl_oficina with (nolock)
where  sa_empresa     = @i_empresa
and    sa_comprobante > 0
and    sa_fecha_tran  = @i_fecha
and    sa_cuenta      in (select cp_cuenta from #cuentas)
and    sa_producto    in (select codigo from #productos)
and    sa_oficina_dest = of_oficina
and    of_cob          = @w_cobcb
and    (sa_debito - sa_credito) > 0
order by sa_cuenta, sa_oficina_dest, (sa_debito+sa_credito)

--Actualiza codigo de corresponsal
update #base
set    CB = ac_cliente
from   #base, cobis..cl_asoc_clte_serv
where  ac_codigo   = oficina

if @@error <> 0 begin      
   print 'Error al actualizar en la tabla #base 2'
   return 150001
end

--Actualiza informacion de comprobante de contrapartida BANCOR
update #base
set    Comp_ext = sa_comprobante
from   cob_conta_tercero..ct_sasiento a, #base b
where  sa_oficina_dest = oficina
and    sa_fecha_tran   = Fecha
and    sa_cuenta       = Cuenta 
and    sa_ente         = CB
and    sa_area_dest    = Area
and    sa_credito - sa_debito = Valor
and    sa_producto     <> producto
and    sa_empresa     = @i_empresa
and    sa_comprobante > 0
and    sa_fecha_tran  = @i_fecha
and    sa_cuenta      in (select cp_cuenta from #cuentas)
and    sa_concepto    not like '%' + @w_concepto + '%'

and    sa_producto    = 6

if @@error <> 0 begin      
   print 'Error al actualizar en la tabla #base 3'
   return 150001
end

--Manejo de Comprobantes por el mismo valor
select Comprobante = Comp_ext, Cantidad = count(1) 
into   #repetidos
from   #base 
group  by Comp_ext 
having count(1) > 1

select @w_count = @@rowcount

select @w_comp = 0, @w_cantidad = 0

while 1=1
begin
   select top 1 
   @w_comp     = Comprobante,
   @w_cantidad = Cantidad -1
   from  #repetidos
   where Comprobante > @w_comp
   order by Comprobante 

   if @@rowcount = 0
      break

   begin tran 
       
   select distinct comp_base = Comp_ext, comp_reemp = sa_comprobante
   into   #reemplazo1
   from   cob_conta_tercero..ct_sasiento a, #base b
   where  sa_oficina_dest = oficina
   and    sa_fecha_tran   = Fecha
   and    sa_cuenta       = Cuenta 
   and    sa_ente         = CB
   and    sa_area_dest    = Area
   and    sa_credito - sa_debito = Valor
   and    sa_producto     <> producto
   and    sa_empresa      =  @i_empresa
   and    Comp_ext        =  @w_comp
   and    sa_comprobante  <> @w_comp
   and    sa_fecha_tran   = @i_fecha
   and    sa_cuenta       in (select cp_cuenta from #cuentas)
   and    sa_producto     = 6

   if @@error <> 0 begin
      rollback tran      
      print 'Error en la insercion de Registros en la tabla #reemplazo1'
      return 601161    ---Error en insercion de registro
   end
   
   select @w_sec = 0, @w_proc = 0
   
   while @w_proc < @w_cantidad
   begin

      select @w_reemplazo = 0

      select top 1 
      @w_sec     = Secuencia
      from  #base
      where Comp_ext = @w_comp
      and   Secuencia > @w_sec
      order by Comp_ext, Secuencia 

      select top 1 
      @w_reemplazo = comp_reemp
      from  #reemplazo1
      where comp_base  = @w_comp
      and   comp_reemp > @w_reemplazo
      order by comp_base, comp_reemp

      if @@rowcount = 0 begin         
         print 'No hay mas comprobantes de reemplazo para ' + cast(@w_comp as varchar)

         select @w_reemplazo = 0,
                @w_proc = @w_cantidad
      end

      --Actualiza comprobante
      update #base
      set    Comp_ext = @w_reemplazo
      where  Comp_ext  = @w_comp
      and    Secuencia = @w_sec

      if @@error <> 0 begin     
         rollback tran 
         print 'Error al actualizar en la tabla #base'
         return 150001
      end
      
      select @w_proc = @w_proc +1

   end  
   
   commit tran
      
   drop table #reemplazo1   
   
end

select Comprobante = Comp_ext, Cantidad = count(1) 
into   #repetidos2
from   #base
group  by Comp_ext 
having count(1) > 1

--Base de Comprobantes a generar
select distinct oficina
into #oficinas
from #base
where Comp_cobis <> 0
and   Comp_ext   <> 0
order by oficina

delete #base
where (Ente = 0 OR CB = 0)
select @w_error = @@error,
       @w_rowcount = @@rowcount
       
if @w_error <> 0 begin
   print 'Error en borrado de clientes cero'
   return 601160
end

if @w_rowcount <> 0 begin
   print 'Existe inconsistencia de terceros, terceros en cero'
end

delete #base
where Ente not in (select en_ente from cobis..cl_ente)

select @w_error = @@error,
       @w_rowcount = @@rowcount
       
if @w_error <> 0 begin
   print 'Error en borrado de clientes cero'
   return 601159
end

if @w_rowcount <> 0 begin
   print 'Existe inconsistencia de terceros, no existe cliente cobis'
end

delete #base
where CB not in (select en_ente from cobis..cl_ente)
select @w_error = @@error,
       @w_rowcount = @@rowcount
       
if @w_error <> 0 begin
   print 'Error en borrado de clientes cero'
   return 601158
end

if @w_rowcount <> 0 begin
   print 'Existe inconsistencia de terceros, no existe cliente BANCOR'
end

while 1 = 1 
begin
   
   select top 1 
   @w_oficina = oficina
   from #oficinas

   if @@rowcount = 0 
      break

   delete #oficinas
   where oficina = @w_oficina

   select @w_comprobante = @w_comprobante + 1

   begin tran
        
   insert into #convivencia_tmp
   select 
   @w_comprobante,   @i_empresa,        @i_fecha,
   @w_oficina,       Area,              @w_descripcion,
   0,                '',                1,
   Cuenta,           oficina,           Area,
   case when Valor > 0 then Valor else 0 end,        case when Valor < 0 then abs(Valor) else 0 end,        substring(@w_concepto + ' Com Cob:' + cast (Comp_cobis as varchar) + ' Com Ext:' + cast (Comp_ext as varchar) + ' Cli:' + cast(Ente as varchar) + ' Corr:' + cast(CB as varchar),1,80),
   'N',              moneda,            'BANCOR',
   valor_me,         0,                 1,
   '',               (select en_tipo_ced from cobis..cl_ente where en_ente = Ente), (select en_ced_ruc from cobis..cl_ente where en_ente = Ente),
   '',               0,                 '',
   null,             null,              null,
   'BANCOR'
   from #base 
   where oficina = @w_oficina
   and   Comp_ext <> 0
   union all
   select 
   @w_comprobante,   @i_empresa,        @i_fecha,
   @w_oficina,       Area,              @w_descripcion,
   0,                '',                1,
   Cuenta,           oficina,           Area,
   case when Valor < 0 then abs(Valor) else 0 end,   case when Valor > 0 then Valor else 0 end,             substring(@w_concepto + ' Com Cob:' + cast (Comp_cobis as varchar) + ' Com Ext:' + cast (Comp_ext as varchar) + ' Cli:' + cast(Ente as varchar) + ' Corr:' + cast(CB as varchar),1,80),
   'N',              moneda,            'BANCOR',
   valor_me,         0,                 1,
   '',               (select en_tipo_ced from cobis..cl_ente where en_ente = CB), (select en_ced_ruc from cobis..cl_ente where en_ente = CB),
   '',               0,                 '',
   null,             null,              null,
   'BANCOR'
   from #base 
   where oficina = @w_oficina
   and   Comp_ext <> 0

   if @@error <> 0 begin
      rollback tran      
      print 'Error en la insercion de Registros en la tabla #convivencia_tmp'
      return 601161    ---Error en insercion de registro
   end
   
   insert into cob_externos..ex_convivencia_tmp(
   ct_comprobante,   ct_empresa,        ct_fecha_tran,
   ct_oficina_orig,  ct_area_orig,      ct_descripcion,
   ct_automatico,    ct_estado,         ct_asiento,
   ct_cuenta,        ct_oficina_dest,   ct_area_dest,
   ct_credito,       ct_debito,         ct_concepto,
   ct_tipo_doc,      ct_moneda,         ct_usuario_modulo,
   ct_credito_me,    ct_debito_me,      ct_cotizacion,
   ct_tipo_tran,     ct_tipo,           ct_identifica,
   ct_concepto_imp,  ct_base_imp,       ct_documento,
   ct_oper_banco,    ct_cheque,         ct_origen_mvto,
   ct_archivo)
   select 
   ct_comprobante,   ct_empresa,        ct_fecha_tran,
   ct_oficina_orig,  ct_area_orig,      ct_descripcion,
   ct_automatico,    ct_estado,         row_number() over(order by ct_identifica),
   ct_cuenta,        ct_oficina_dest,   ct_area_dest,
   ct_credito,       ct_debito,         ct_concepto,
   ct_tipo_doc,      ct_moneda,         ct_usuario_modulo,
   ct_credito_me,    ct_debito_me,      ct_cotizacion,
   ct_tipo_tran,     ct_tipo,           ct_identifica,
   ct_concepto_imp,  ct_base_imp,       ct_documento,
   ct_oper_banco,    ct_cheque,         ct_origen_mvto,
   ct_archivo
   from #convivencia_tmp
   
   if @@error <> 0 begin
      rollback tran      
      print 'Error en la insercion de Registros en la tabla cob_externos..ex_convivencia_tmp'
      return 601161    ---Error en insercion de registro
   end
   
   insert into cob_conta..cb_ajuste_cb_log (
   ac_producto,    ac_fecha,    ac_ente_cobis,
   ac_ente_cb,     ac_cuenta,   ac_valor,
   ac_comp_cobis,  ac_comp_cb,  ac_estado)
   select
   producto,       Fecha,       Ente,
   CB,             Cuenta,      Valor,
   Comp_cobis,     Comp_ext,     'P'
   from  #base
   where oficina = @w_oficina
   
   if @@error <> 0 begin      
      rollback tran
      print 'Error en la insercion de Registros en la tabla cob_conta..cb_ajuste_cb_log'
      return 601161    ---Error en insercion de registro
   end
   
   --AJUSTE PARA MARCAR REGISTRO C
   update cob_conta..cb_ajuste_cb_log
   set    ac_estado = 'E'
   where  ac_fecha    = @i_fecha
   and    ac_comp_cb  = 0
   
   if @@error <> 0 begin      
      rollback tran
      print 'Error en la actualizacion de Registros en la tabla cob_conta..cb_ajuste_cb_log'
      return 601161    ---Error en insercion de registro
   end

   commit tran
   
   truncate table #convivencia_tmp

end
return 0 
go