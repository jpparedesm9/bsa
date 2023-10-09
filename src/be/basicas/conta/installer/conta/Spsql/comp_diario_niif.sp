/************************************************************************/
/*      Archivo:                comp_diario_niif.sp                     */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:           Alejandra Celis                         */
/*      Fecha de escritura:     08/01/2014                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA".                                                       */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*  extraer los saldos diarios de contabilidad para NIIF                */
/*                                                                      */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA          AUTOR                    RAZON                       */
/*  Ago/01/2014   Alejandra Celis       Creacion Inicial NR 429         */
/************************************************************************/

use cob_conta
go

if exists(select 1 from cob_conta..sysobjects where name = 'sp_comp_diario_niif' and type = 'P') 
   drop proc sp_comp_diario_niif
go

create proc sp_comp_diario_niif 
@i_param1  as varchar(2),
@i_param2  as varchar(12) = null,
@i_param3  as varchar(12) = null,
@i_param4  as varchar(1) = 'C'   --OPCION   C: CONTA   K: CALENDARIO
as
declare
@w_oficina    smallint,
@w_diferencia money,
@w_credito    money,
@w_fecha      datetime,
@w_fecha_fin  datetime,
@w_ano_ini    smallint,
@w_ano_fin    smallint,
@i_opcion     varchar(1)

select @w_oficina    = 0
select @w_diferencia = 0
select @w_credito    = 0

select @w_fecha = convert(datetime, @i_param2)
select @w_fecha_fin = convert(datetime, @i_param3)
select @i_opcion = @i_param4

if isnull(@i_param1,'') = '' OR isnull(@i_param2,'') = ''  OR isnull(@i_param3,'') = '' begin
   print 'PARAMETRO DE ENTRADA INVALIDO '
   return 1
end

if (@w_fecha > @w_fecha_fin)
begin
  print 'LA FECHA INICIAL NO PUEDE SER MAYOR QUE LA FECHA FINAL '
  return 1
end  

select @w_ano_ini = datepart(yyyy,@w_fecha)
select @w_ano_fin = datepart(yyyy,@w_fecha_fin)

if (datediff(mm,@w_fecha, @w_fecha_fin) + 1) > 3
begin
  print 'LAS FECHAS DEBEN SER DEL MISMO TRIMESTRE'
  return 1
end  

if (@w_ano_ini <> @w_ano_fin)
begin
  print 'LAS FECHAS DEBEN SER DEL MISMO AÑO'
  return 1
end  


truncate table   cob_externos..ex_int_comprobantes


if @@error <> 0 begin
   print 'Error al borrar tabla cob_externos..ex_int_comprobantes'
   goto final
end

if @i_param1 = 'SC'  begin  --Sin Cartera 
   select cu_cuenta
   into   #cuentas_tercero
   from   cob_conta..cb_cuenta
   where  substring (cu_cuenta,1,2) in ('13','26')
   and    cu_movimiento = 'S'
   and    cu_cuenta  in (select cp_cuenta from cob_conta..cb_cuenta_proceso where cp_proceso in (6003, 6095))

   insert into #cuentas_tercero
   select cu_cuenta
   from   cob_conta..cb_cuenta
   where  substring (cu_cuenta,1,4) in ('2115')
   and    cu_movimiento = 'S'
   and    cu_cuenta  in (select cp_cuenta from cob_conta..cb_cuenta_proceso where cp_proceso in (6003, 6095))

   insert into #cuentas_tercero
   select cu_cuenta
   from   cob_conta..cb_cuenta
   where  substring (cu_cuenta,1,6) in ('250505', '250520')
   and    cu_movimiento = 'S'
   and    cu_cuenta  in (select cp_cuenta from cob_conta..cb_cuenta_proceso where cp_proceso in (6003, 6095))

 end


select cuenta = cu_cuenta
into   #cuentas_gnral
from   cob_conta..cb_cuenta
where  cu_movimiento = 'S'

delete #cuentas_gnral
from   #cuentas_tercero,
       #cuentas_gnral
where  cu_cuenta = cuenta



while (@w_fecha <= @w_fecha_fin) begin
   print 'FECHA DE PROCESO ES  ' + convert(varchar, @w_fecha)
   truncate table   cob_externos..ex_int_comprobantes_tmp
   select distinct of_oficina
   into #oficina
   from cob_conta..cb_oficina
   where of_movimiento = 'S'

   while 1 = 1 begin
      begin tran
      
      select 
      @w_oficina = of_oficina
      from #oficina
   
      if @@rowcount = 0 begin
         break
      end
   
      delete #oficina
      where of_oficina = @w_oficina
      if @@error <> 0 begin
         rollback tran
         print 'Error al borrar #oficina'
         goto final
      end
   
   ---CUENTAS TERCEROS   productos diferentes de 6
     insert into cob_externos..ex_int_comprobantes_tmp
     select   
     sc_empresa ,
     convert(varchar,sc_comprobante) + '-' + convert(varchar,sc_producto) + '-'  + convert(varchar,sc_fecha_tran,111)  , 
     (case when isnull(sc_automatico, 0) in (6078, 6056) then 'C' else 'N' end),
     convert(varchar,sc_fecha_tran,111) ,
     2,
     sc_descripcion ,
     sa_cuenta , 
     sa_oficina_dest , 
     '0' , 
     isnull((select isnull(en_ced_ruc, '99') from cobis..cl_ente where en_ente = sa_ente),'99') ,
     'COP' ,
     (case when sc_producto in (4)  then substring( (substring(sa_concepto, charindex('Co:', sa_concepto)+3, len(sa_concepto))),1,charindex(' ', substring(sa_concepto, charindex('Co:', sa_concepto)+3, len(sa_concepto)))-1)
           when  sc_producto = 14 then substring( (substring(sa_concepto, charindex('Cpt:', sa_concepto)+4, len(sa_concepto))),1,charindex(' ', substring(sa_concepto, charindex('Cpt:', sa_concepto)+4, len(sa_concepto)))-1)  
           else substring(sa_concepto,1,100)  end ) ,

     1 ,    -- LINEA POR COMPROBANTE
    
     sum(sa_debito)  ,
     sum(sa_credito) ,
     sum(sa_debito)  ,
     sum(sa_credito) , 
     case when isnull((select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), '') = '' then '0' else 'CI' end ,
     case when isnull((select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), '') = '' then '99' else '01' end ,
     convert(varchar,dateadd(dd,1,@w_fecha),111) ,
     isnull((select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), '99') 
     from  cob_conta_tercero..ct_sasiento,
           cob_conta_tercero..ct_scomprobante
     where sc_comprobante   = sa_comprobante
     and   sc_fecha_tran    = sa_fecha_tran
     and   sc_producto      = sa_producto
     and   sa_oficina_dest  = @w_oficina
     and   sc_fecha_tran=  @w_fecha
     and   sc_producto      <> 6
     and   sc_estado = 'P'
     and sa_cuenta in (select cu_cuenta from #cuentas_tercero )
     group by sc_empresa,sc_automatico,sc_producto, convert(varchar,sc_fecha_tran,111), sa_cuenta, sa_oficina_dest,sa_ente,sc_comprobante , sc_descripcion,
     (case when sc_producto in (4)  then substring( (substring(sa_concepto, charindex('Co:', sa_concepto)+3, len(sa_concepto))),1,charindex(' ', substring(sa_concepto, charindex('Co:', sa_concepto)+3, len(sa_concepto)))-1)
           when  sc_producto = 14 then substring( (substring(sa_concepto, charindex('Cpt:', sa_concepto)+4, len(sa_concepto))),1,charindex(' ', substring(sa_concepto, charindex('Cpt:', sa_concepto)+4, len(sa_concepto)))-1)  
           else substring(sa_concepto,1,100) end ) 

     if @@ERROR <> 0 begin
        print 'Error al insertar ex_int_comprobantes de Terceros Productos diferentes de 6'
        rollback tran
        goto final
     end
   
     
     insert into cob_externos..ex_int_comprobantes_tmp
     select   sc_empresa ,
     convert(varchar,sc_comprobante) + '-' + convert(varchar,sc_producto) + '-' + convert(varchar,sc_fecha_tran,111)  , 
     case when isnull(sc_automatico, 0) in (6078, 6056) then 'C' else 'N' end,
     convert(varchar,sc_fecha_tran,111) ,
     2,
     sc_descripcion ,
     sa_cuenta , 
     sa_oficina_dest , 
     '0' , 
     '99' ,
     'COP' ,
     (case when sc_producto in (4)  then substring( (substring(sa_concepto, charindex('Co:', sa_concepto)+3, len(sa_concepto))),1,charindex(' ', substring(sa_concepto, charindex('Co:', sa_concepto)+3, len(sa_concepto)))-1)
           when  sc_producto = 14 then substring( (substring(sa_concepto, charindex('Cpt:', sa_concepto)+4, len(sa_concepto))),1,charindex(' ', substring(sa_concepto, charindex('Cpt:', sa_concepto)+4, len(sa_concepto)))-1)  
           else substring(sa_concepto,1,100) end )  nada1,

     1,
     sum(sa_debito)  ,
     sum(sa_credito) ,
     sum(sa_debito)  ,
     sum(sa_credito) , 
     '99' ,
     '99' ,
     convert(varchar,dateadd(dd,1,@w_fecha),111) ,
     '99' 
     from  cob_conta_tercero..ct_sasiento,
           cob_conta_tercero..ct_scomprobante
     where sc_comprobante = sa_comprobante
     and   sc_fecha_tran  = sa_fecha_tran
     and   sc_producto    = sa_producto
     and   sa_oficina_dest = @w_oficina
     and   sc_fecha_tran=  @w_fecha
     and   sc_producto      <> 6
     and   sc_estado = 'P'
     and   sa_cuenta in (select cuenta from #cuentas_gnral )
     group by sc_empresa,sc_automatico,sc_producto, convert(varchar,sc_fecha_tran,111), sa_cuenta, sa_oficina_dest,sc_comprobante , sc_descripcion,
     (case when sc_producto in (4)  then substring( (substring(sa_concepto, charindex('Co:', sa_concepto)+3, len(sa_concepto))),1,charindex(' ', substring(sa_concepto, charindex('Co:', sa_concepto)+3, len(sa_concepto)))-1)
           when  sc_producto = 14 then substring( (substring(sa_concepto, charindex('Cpt:', sa_concepto)+4, len(sa_concepto))),1,charindex(' ', substring(sa_concepto, charindex('Cpt:', sa_concepto)+4, len(sa_concepto)))-1)  
           else substring(sa_concepto,1,100) end ) 

   
     if @@ERROR <> 0 begin
        print 'Error al insertar ex_int_comprobantes de General, productos diferentes de 6'
        rollback tran
        goto final
     end 
   
    
   if @i_opcion = 'K' begin
   ---CUENTAS TERCEROS   producto 6
      insert into cob_externos..ex_int_comprobantes_tmp
      select   sc_empresa ,
      convert(varchar,sc_comprobante) + '-' + convert(varchar,sc_producto) + '-'  + convert(varchar,sc_fecha_tran,111)  , 
      case when isnull(sc_automatico, 0) in (6078, 6056) then 'C' else 'N' end,
      convert(varchar,sc_fecha_tran,111) ,
      2,
      sc_descripcion ,
      sa_cuenta , 
      sa_oficina_dest , 
      '0' , 
      isnull((select isnull(en_ced_ruc, '99') from cobis..cl_ente where en_ente = sa_ente),'99') ,
      'COP' ,
      sa_concepto,
      1,
      sum(sa_debito)  ,
      sum(sa_credito) ,
      sum(sa_debito)  ,
      sum(sa_credito) , 
      case when isnull((select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), '') = '' then '0' else 'CI' end ,
      case when isnull((select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), '') = '' then '99' else '01' end ,
      convert(varchar,dateadd(dd,1,@w_fecha),111) ,
      isnull((select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), '99') 
      from  cob_conta_tercero..ct_sasiento,
            cob_conta_tercero..ct_scomprobante
      where sc_comprobante   = sa_comprobante
      and   sc_fecha_tran    = sa_fecha_tran
      and   sc_producto      = sa_producto
      and   sa_oficina_dest  = @w_oficina
      and   sc_fecha_gra>    =  @w_fecha
      and   sc_fecha_gra < dateadd(dd,1,@w_fecha)
      and   sc_producto      = 6
      and   sc_estado = 'P'
      and sa_cuenta in (select cu_cuenta from #cuentas_tercero )
      group by sc_empresa,sc_automatico,sc_producto, convert(varchar,sc_fecha_tran,111), sa_cuenta, sa_oficina_dest,sa_ente,sc_comprobante , sc_descripcion,sa_concepto
      
      if @@ERROR <> 0 begin
         print 'Error al insertar ex_int_comprobantes de Terceros, producto 6'
         rollback tran
         goto final
      end
      
      
      insert into cob_externos..ex_int_comprobantes_tmp
      select   sc_empresa ,
      convert(varchar,sc_comprobante) + '-' + convert(varchar,sc_producto) + '-' + convert(varchar,sc_fecha_tran,111)  , 
      case when isnull(sc_automatico, 0) in (6078, 6056) then 'C' else 'N' end,
      convert(varchar,sc_fecha_tran,111) ,
      2,
      sc_descripcion ,
      sa_cuenta , 
      sa_oficina_dest , 
      '0' , 
      '99' ,
      'COP' ,
      sa_concepto,
      1,
      sum(sa_debito)  ,
      sum(sa_credito) ,
      sum(sa_debito)  ,
      sum(sa_credito) , 
      '99' ,
      '99' ,
      convert(varchar,dateadd(dd,1,@w_fecha),111) ,
      '99' 
      from  cob_conta_tercero..ct_sasiento,
            cob_conta_tercero..ct_scomprobante
      where sc_comprobante = sa_comprobante
      and   sc_fecha_tran  = sa_fecha_tran
      and   sc_producto    = sa_producto
      and   sa_oficina_dest = @w_oficina
      and   sc_fecha_gra>=  @w_fecha
      and   sc_fecha_gra < dateadd(dd,1,@w_fecha)
      and   sc_producto      = 6
      and   sc_estado = 'P'
      and   sa_cuenta in (select cuenta from #cuentas_gnral )
      group by sc_empresa,sc_automatico,sc_producto, convert(varchar,sc_fecha_tran,111), sa_cuenta, sa_oficina_dest,sc_comprobante , sc_descripcion,sa_concepto
           
      
      if @@ERROR <> 0 begin
         print 'Error al insertar ex_int_comprobantes ctas Generales, producto 6'
         rollback tran
         goto final
      end 
   end
   
   if @i_opcion = 'C' begin
   ---CUENTAS TERCEROS   producto 6
      insert into cob_externos..ex_int_comprobantes_tmp
      select   sc_empresa ,
      convert(varchar,sc_comprobante) + '-' + convert(varchar,sc_producto) + '-'  + convert(varchar,sc_fecha_tran,111)  , 
      case when isnull(sc_automatico, 0) in (6078, 6056) then 'C' else 'N' end,
      convert(varchar,sc_fecha_tran,111) ,
      2,
      sc_descripcion ,
      sa_cuenta , 
      sa_oficina_dest , 
      '0' , 
      isnull((select isnull(en_ced_ruc, '99') from cobis..cl_ente where en_ente = sa_ente),'99') ,
      'COP' ,
      sa_concepto,
      1,
      sum(sa_debito)  ,
      sum(sa_credito) ,
      sum(sa_debito)  ,
      sum(sa_credito) , 
      case when isnull((select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), '') = '' then '0' else 'CI' end ,
      case when isnull((select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), '') = '' then '99' else '01' end ,
      convert(varchar,dateadd(dd,1,@w_fecha),111) ,
      isnull((select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), '99') 
      from  cob_conta_tercero..ct_sasiento,
            cob_conta_tercero..ct_scomprobante
      where sc_comprobante   = sa_comprobante
      and   sc_fecha_tran    = sa_fecha_tran
      and   sc_producto      = sa_producto
      and   sa_oficina_dest  = @w_oficina
      and   sc_fecha_tran     = @w_fecha
      and   sc_estado = 'P'
      and   sc_producto      = 6
      and sa_cuenta in (select cu_cuenta from #cuentas_tercero )
      group by sc_empresa,sc_automatico,sc_producto, convert(varchar,sc_fecha_tran,111), sa_cuenta, sa_oficina_dest,sa_ente,sc_comprobante , sc_descripcion,sa_concepto
      
      if @@ERROR <> 0 begin
         print 'Error al insertar ex_int_comprobantes de Terceros, producto 6'
         rollback tran
         goto final
      end
      
      insert into cob_externos..ex_int_comprobantes_tmp
      select   sc_empresa ,
      convert(varchar,sc_comprobante) + '-' + convert(varchar,sc_producto) + '-' + convert(varchar,sc_fecha_tran,111)  , 
      case when isnull(sc_automatico, 0) in (6078, 6056) then 'C' else 'N' end,
      convert(varchar,sc_fecha_tran,111) ,
      2,
      sc_descripcion ,
      sa_cuenta , 
      sa_oficina_dest , 
      '0' , 
      '99' ,
      'COP' ,
      sa_concepto,
      1,
      sum(sa_debito)  ,
      sum(sa_credito) ,
      sum(sa_debito)  ,
      sum(sa_credito) , 
      '99' ,
      '99' ,
      convert(varchar,dateadd(dd,1,@w_fecha),111) ,
      '99' 
      from  cob_conta_tercero..ct_sasiento,
            cob_conta_tercero..ct_scomprobante
      where sc_comprobante  = sa_comprobante
      and   sc_fecha_tran   = sa_fecha_tran
      and   sc_producto     = sa_producto
      and   sa_oficina_dest = @w_oficina
      and   sc_fecha_tran   =  @w_fecha
      and   sc_producto     = 6
      and   sc_estado = 'P'
      and   sa_cuenta in (select cuenta from #cuentas_gnral )
      group by sc_empresa,sc_automatico,sc_producto, convert(varchar,sc_fecha_tran,111), sa_cuenta, sa_oficina_dest,sc_comprobante , sc_descripcion,sa_concepto
           
      
      if @@ERROR <> 0 begin
         print 'Error al insertar ex_int_comprobantes ctas Generales, producto 6'
         rollback tran
         goto final
      end 
   end
     if @@TRANCOUNT > 0 begin
        commit tran
     end
     print 'oficina es ' + convert(varchar, @w_oficina)
  end -- while 1 = 1

  if @@TRANCOUNT > 0 begin
       commit tran
  end      

  insert into cob_externos..ex_int_comprobantes
  select ic_CodigoEmpresa, ic_Folio,         ic_Periodo,             ic_Fecha,           ic_Tipo_comprobante,
         ic_Observacion,   ic_Codigo_cuenta ,ic_Codigo_centro_costo, ic_Codigo_proyecto, ic_CodigoTercero, 
         ic_Simbolo_moneda, ic_Glosa_detalle,
         row_number() over(partition by  ic_Folio order by ic_Folio),ic_Debe_local ,      ic_Haber_local ,
         ic_Debe_imputacion,ic_Haber_imputacion, ic_Codigo_documento,ic_Numero_documento, ic_Fecha_vencimiento,
          ic_Tipo_Doc_Identificacion
  from cob_externos..ex_int_comprobantes_tmp

  if @@ERROR <> 0 begin
      print 'Error al Crear la linea del comprobante '
     goto final
  end 
   
  insert into cob_externos..ex_control_corvus
  select getdate(),'PROCESO EXITOSO COMPROBANTE DIARIO' ,'sp_comp_diario_niif', 'P','N','FECHA PROCESO ' + + convert(varchar(10),@w_fecha,111)

  select @w_fecha  = dateadd(dd,1,@w_fecha)
  drop table #oficina

 
end -- while fecha

   
if @@TRANCOUNT > 0 begin
   commit tran
end


   

return 0

final:
   insert into cob_externos..ex_control_corvus
   select getdate(),'PROCESO NO EXITOSO COMPROBANTE DIARIO' ,'sp_comp_diario_niif', 'E','N','FECHA PROCESO ' + + convert(varchar(10),@w_fecha,111)
   return 1

go


/*

delete cob_externos..ex_int_comprobantes_tmp
delete cob_externos..ex_control_corvus
exec sp_comp_diario_niif
@i_param1 = 'SC',
@i_param2 = '05/16/2014',  --ctas gnral
@i_param3 = '05/30/2014'  --ctas gnral

select * from cob_externos..ex_int_comprobantes_tmp
select * from cob_externos..ex_int_comprobantes

select * from cob_externos..ex_control_corvus
*/

