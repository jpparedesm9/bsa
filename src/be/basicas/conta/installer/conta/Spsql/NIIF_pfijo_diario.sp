/************************************************************************/
/*      Archivo:                NIIF_pfijo_diario.sp                    */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:           Alejandra Celis                         */
/*      Fecha de escritura:     08/22/2014                              */
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
/*  Proceso de extraccion diaria de Interface INstrumentos CDT's        */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA          AUTOR                    RAZON                       */
/*  Ago /22/2014   Alejandra Celis       Emisión Inicial                */
/*  Sep /01/2014   Alejandra Celis       Ajuste para ejecutar en Hist.  */
/************************************************************************/

use cob_conta
go

if exists(select 1 from cob_conta..sysobjects where name = 'sp_niif_pfijo_dia' and type = 'P') 
   drop proc sp_niif_pfijo_dia
go

create proc sp_niif_pfijo_dia
@i_param1  as varchar(12) = null,
@i_param2  as varchar(12) = null
as
declare
@w_contador   int,
@w_interes    money,
@w_interes_fin money,
@w_fecha_ven  datetime,
@w_monto      money,
@w_fecha_crea datetime,
@w_operacion  varchar(24),
@w_cuotas     int,
@w_fecha      datetime,
@w_fecha_dia  datetime,
@w_fecha_dia_fin datetime,
@w_plazo      int,
@w_per        int,
@w_error      int,
@w_ano_ini    smallint,
@w_ano_fin    smallint,

@w_servidor    varchar(50),
@w_servidor_cen varchar(50),
@w_server      varchar(50),
@w_comando as varchar (5000)


/* PARAMETRO GENERAL SERVIDOR HISTORICOS*/
select @w_servidor = pa_char
from cobis..cl_parametro
where pa_producto = 'CCA'
and   pa_nemonico = 'SRVHIS'


/* PARAMETRO GENERAL SERVIDOR CENTRAL*/
select  @w_servidor_cen = pa_char
from cobis..cl_parametro
where   pa_nemonico = 'LSCP'

--SRVPROD  en preproduccion
select @w_server = @@servername

select @w_servidor = pa_char
from cobis..cl_parametro
where pa_nemonico = 'NSCP'
and   pa_producto = 'ADM'


select @w_contador   = 0
select @w_interes    = 0
select @w_fecha_ven  = '01/01/1900'
select @w_monto      = 0
select @w_fecha_crea = '01/01/1900'
select @w_fecha      = '01/01/1900'
select @w_plazo      = 1


select @w_fecha_dia = convert(datetime, @i_param1)
select @w_fecha_dia_fin = convert(datetime, @i_param2)

set nocount on

if (@w_fecha_dia > @w_fecha_dia_fin)
begin
  print 'LA FECHA INICIAL NO PUEDE SER MAYOR QUE LA FECHA FINAL '
  return 1
end  

select @w_ano_ini = datepart(yyyy,@w_fecha_dia)
select @w_ano_fin = datepart(yyyy,@w_fecha_dia_fin)

if (datediff(mm,@w_fecha_dia, @w_fecha_dia_fin) + 1) > 3
begin
  print 'LAS FECHAS DEBEN SER DEL MISMO TRIMESTRE'
  return 1
end  

if (@w_ano_ini <> @w_ano_fin)
begin
  print 'LAS FECHAS DEBEN SER DEL MISMO AÑO'
  return 1
end  
truncate table cob_externos..ex_int_tablaDesarrolloDetIF
truncate table cob_externos..ex_int_operacionesIF

while (@w_fecha_dia <= @w_fecha_dia_fin) begin
begin tran
   truncate table cob_externos..ex_int_cdt_tmp
   print 'FECHA DE PROCESO ES  ' + convert(varchar, @w_fecha_dia)

   insert into cob_externos..ex_int_cdt_tmp

   select 
   ic_fecha      = convert(varchar(10),dp_fecha_apertura,111),
   ic_producto   = (case when  dp_plazo_dias < 180  then 31 
                      when (dp_plazo_dias >= 180 and dp_plazo_dias < 360) then 32
                      when (dp_plazo_dias >= 360 and dp_plazo_dias < 540) then 33
                      else 34 end ),
   ic_monto      = dp_monto,
   ic_documento  = isnull((select en_ced_ruc from cobis..cl_ente where en_ente = dp_cliente),''),
   ic_operacion  = dp_banco,
   ic_indicador  = 1,
   ic_costo_adic = convert(money, 0),
   ic_tasa       = convert(money, 0),
   ic_cuotas     = dp_num_cuotas,
   ic_moneda     = 'COP',
   ic_tipo_tasa  = convert(tinyint, 0),
   ic_tipo_doc   = isnull((select en_tipo_ced from cobis..cl_ente where en_ente = dp_cliente),''),
   ic_empresa    = 1,
   ic_tipo_cl    = (select (case isnull(c_tipo_compania, '') when '' then 'PA' else c_tipo_compania end) from cobis..cl_ente
                where en_ente = dp_cliente),
   ic_plazo_dias =  dp_plazo_dias, 
   ic_fpago      = ( case when dp_num_cuotas = 1  then 'VEN' else 'PER' end),
   ic_fecven     = dp_fecha_vencimiento,
   ic_numren     = dp_num_renovaciones,
   ic_base_cal   = 360,
   ic_centro_costo= dp_oficina
 
   from cob_conta_super..sb_dato_pasivas
   where dp_aplicativo = 14
   and   dp_fecha      =@w_fecha_dia
   and   dp_fecha      = dp_fecha_apertura
   and   dp_estado     = 1
   and   dp_oficina in (select of_oficina from cobis..cl_oficina)
   if @@ERROR <> 0 begin
      print 'Error al insertar cob_externos..ex_int_cdt_tmp'
      rollback tran
      goto final
   end


   select @w_comando =            + ' select op_num_banco '
   select @w_comando = @w_comando + ' into #oper_var '
   if isnull(@w_servidor,'')  = isnull(@w_server,'')
      select @w_comando = @w_comando + ' from cob_pfijo..pf_historia , cobis..cl_ttransaccion, cob_pfijo..pf_operacion '
   else
      select @w_comando = @w_comando + ' from ' + @w_servidor_cen + '.cob_pfijo.dbo.pf_historia , cobis..cl_ttransaccion, ' + @w_servidor_cen + '.cob_pfijo.dbo.pf_operacion '
   
   select @w_comando = @w_comando + ' where      tn_descripcion =''CALCULO DE TASA VARIABLE'' '
   select @w_comando = @w_comando + ' and        hi_trn_code  = tn_trn_code '
   select @w_comando = @w_comando + ' and        hi_fecha=  '  + convert(varchar(10),@w_fecha_dia,111)
   select @w_comando = @w_comando + ' and        op_operacion = hi_operacion '

   select @w_comando = @w_comando + ' insert into cob_externos..ex_int_cdt_tmp '
   select @w_comando = @w_comando + ' select  '
   select @w_comando = @w_comando + ' ic_fecha      = convert(varchar(10),dp_fecha,111), '
   select @w_comando = @w_comando + ' ic_producto   = (case when  dp_plazo_dias < 180  then 31 '
                      select @w_comando = @w_comando + ' when (dp_plazo_dias >= 180 and dp_plazo_dias < 360) then 32 '
                      select @w_comando = @w_comando + ' when (dp_plazo_dias >= 360 and dp_plazo_dias < 540) then 33 '
                      select @w_comando = @w_comando + ' else 34 end ), '
   select @w_comando = @w_comando + ' ic_monto      = dp_monto, '
   select @w_comando = @w_comando + ' ic_documento  = isnull((select en_ced_ruc from cobis..cl_ente where en_ente = dp_cliente),''''), '
   select @w_comando = @w_comando + ' ic_operacion  = dp_banco, '
   select @w_comando = @w_comando + ' ic_indicador  = 1, '
   select @w_comando = @w_comando + ' ic_costo_adic = convert(money, 0), '
   select @w_comando = @w_comando + ' ic_tasa       = convert(money, 0), '
   select @w_comando = @w_comando + ' ic_cuotas     = dp_num_cuotas, '
   select @w_comando = @w_comando + ' ic_moneda     = ''COP'', '
   select @w_comando = @w_comando + ' ic_tipo_tasa  = convert(tinyint, 0), '
   select @w_comando = @w_comando + ' ic_tipo_doc   = isnull((select en_tipo_ced from cobis..cl_ente where en_ente = dp_cliente),''''), '
   select @w_comando = @w_comando + ' ic_empresa    = 1, '
   select @w_comando = @w_comando + ' ic_tipo_cl    = (select (case isnull(c_tipo_compania, '''') when '''' then ''PA'' else c_tipo_compania end) from cobis..cl_ente '
                 select @w_comando = @w_comando + ' where en_ente = dp_cliente), '
   select @w_comando = @w_comando + ' ic_plazo_dias =  dp_plazo_dias, '
   select @w_comando = @w_comando + ' ic_fpago      = ( case when dp_num_cuotas = 1  then ''VEN'' else ''PER'' end), '
   select @w_comando = @w_comando + ' ic_fecven    =dp_fecha_vencimiento, '
   select @w_comando = @w_comando + ' ic_numren    = dp_num_renovaciones, '
   select @w_comando = @w_comando + ' ic_base_cal  = 360 ,'
   select @w_comando = @w_comando + ' ic_centro_costo  = dp_oficina '
   select @w_comando = @w_comando + ' from      cob_conta_super..sb_dato_pasivas, #oper_var '
   select @w_comando = @w_comando + ' where     dp_aplicativo = 15 '
   select @w_comando = @w_comando + ' and       dp_fecha      = ' + convert(varchar(10),@w_fecha_dia,111)
   select @w_comando = @w_comando + ' and       dp_estado     = 1 '
   select @w_comando = @w_comando + ' and       op_num_banco = dp_banco '
   select @w_comando = @w_comando + ' and       dp_oficina in (select of_oficina from cobis..cl_oficina) '
   select @w_comando = @w_comando + ' and       op_num_banco not in (select ic_operacion  from cob_externos..ex_int_cdt_tmp) '
 
   --print ' comando A es ' + @w_comando

   exec   @w_error = sp_sqlexec @w_comando

   if @@ERROR <> 0 begin
      print 'Error al  seleccionar con tasa variable'
      rollback tran
      goto final
   end

   update cob_externos..ex_int_cdt_tmp set
   ic_producto  = (case when (ic_producto = 31 and ic_tipo_cl = 'PA'  ) then 301
                     when (ic_producto = 31 and ic_tipo_cl <>'PA'  ) then 302
                     when (ic_producto = 32 and ic_tipo_cl ='PA'   ) then  303
                     when (ic_producto = 32 and ic_tipo_cl <>'PA'  ) then 304
                     when (ic_producto = 33 and ic_tipo_cl = 'PA'  ) then 305
                     when (ic_producto = 33 and ic_tipo_cl <>'PA'  ) then 306
                     when (ic_producto = 34 and ic_tipo_cl ='PA'   ) then 307
                     when (ic_producto = 34 and ic_tipo_cl <>'PA'  ) then 308 else null end)

   if @@ERROR <> 0 begin
      print 'Error al  actualizar Producto'
      rollback tran
      goto final
   end


   select @w_comando =              ' update cob_externos..ex_int_cdt_tmp set '
   select @w_comando = @w_comando + ' ic_costo_adic = isnull(cp_costo, 0) '
   select @w_comando = @w_comando + ' from cob_externos..ex_int_cdt_tmp, '
   if isnull(@w_servidor,'')  = isnull(@w_server,'')
      select @w_comando = @w_comando + ' cob_externos..ex_costos_pfijo '
   else
      select @w_comando = @w_comando +  @w_servidor_cen + '.cob_externos.dbo.ex_costos_pfijo '
   select @w_comando = @w_comando + ' where ic_operacion    = cp_cdt '


   --print ' comando B es ' + @w_comando

   exec   @w_error = sp_sqlexec @w_comando

   if @@ERROR <> 0 begin
      print 'Error al al actualizar costos'
      rollback tran
      goto final
   end

   select @w_comando =              ' update cob_externos..ex_int_cdt_tmp set '
   select @w_comando = @w_comando + ' ic_tipo_tasa = case when isnull(td_tasa_variable, ''N'') = ''N'' then 0 when isnull(td_tasa_variable, ''N'') = ''S'' then 1 end '
   select @w_comando = @w_comando + ' from cob_externos..ex_int_cdt_tmp, '
   if isnull(@w_servidor,'')  = isnull(@w_server,'')
      select @w_comando = @w_comando + ' cob_pfijo..pf_operacion,  cob_pfijo..pf_tipo_deposito '
   else
      select @w_comando = @w_comando +  @w_servidor_cen + '.cob_pfijo.dbo.pf_operacion,  ' +  @w_servidor_cen + '.cob_pfijo.dbo.pf_tipo_deposito '
   select @w_comando = @w_comando + ' where ic_operacion    = op_num_banco '
   select @w_comando = @w_comando + ' and   td_mnemonico = op_toperacion '


   --print ' comando C es ' + @w_comando
   exec   @w_error = sp_sqlexec @w_comando

   if  @@ERROR <> 0 begin
      print 'Error al al actualizar tipo tasa'
      rollback tran
      goto final
   end



   select @w_comando =            + ' update cob_externos..ex_int_cdt_tmp '
   select @w_comando = @w_comando + ' set    ic_tasa = pd_tasa, '
          select @w_comando = @w_comando + ' ic_base_cal = pd_base_cal '
   if isnull(@w_servidor,'')  = isnull(@w_server,'')
      select @w_comando = @w_comando + ' from cob_pfijo..pf_operacion,  cob_pfijo..pf_prov_dia '
   else
      select @w_comando = @w_comando + 'from ' +   @w_servidor_cen + '.cob_pfijo.dbo.pf_operacion,  ' +  @w_servidor_cen + '.cob_pfijo.dbo.pf_prov_dia '
   select @w_comando = @w_comando + ' where  pd_operacion = op_operacion '
   select @w_comando = @w_comando + ' and    pd_fecha_proceso = ic_fecha '
   select @w_comando = @w_comando + ' and    op_num_banco = ic_operacion '


   --print ' comando D es ' + @w_comando
   exec   @w_error = sp_sqlexec @w_comando

   if @@ERROR <> 0 begin
      print 'Error al al actualizar Valor tasa'
      rollback tran
      goto final
   end


   select @w_comando =            + ' update cob_externos..ex_int_cdt_tmp '
   select @w_comando = @w_comando + ' set    ic_tasa = hi_tasa '
   if isnull(@w_servidor,'')  = isnull(@w_server,'')
      select @w_comando = @w_comando + ' from   cob_pfijo..pf_historia, cob_pfijo..pf_operacion '
   else
      select @w_comando = @w_comando + ' from ' +  @w_servidor_cen + '.cob_pfijo.dbo.pf_operacion,  ' +  @w_servidor_cen + '.cob_pfijo.dbo.pf_historia '
  
   select @w_comando = @w_comando + ' where  hi_operacion = op_operacion '
   select @w_comando = @w_comando + ' and    hi_fecha = ic_fecha '
   select @w_comando = @w_comando + ' and    hi_tasa is not null '
   select @w_comando = @w_comando + ' and    ic_tasa = 0 '
 

   --print ' comando E es ' + @w_comando
   exec   @w_error = sp_sqlexec @w_comando
   if @@ERROR <> 0 begin
      print 'Error al al actualizar Valor Tasa estando en Cero '
      rollback tran
      goto final
   end


   insert into cob_externos..ex_int_operacionesIF
   select 
   ic_fecha,      ic_producto,    ic_monto,
   ic_documento,  ic_tipo_doc,    ic_operacion,
   ic_indicador,  ic_costo_adic,  ic_tasa,
   ic_cuotas,     ic_moneda,      ic_tipo_tasa,
   ic_empresa,    ic_centro_costo
   from cob_externos..ex_int_cdt_tmp

   if @@ERROR <> 0 begin
      print 'Error al insertar en ex_int_operacionesIF'
      rollback tran
      goto final
   end


   insert cob_externos..ex_int_tablaDesarrolloDetIF
   select 
   ic_operacion,
   1,
   convert(varchar(10), ic_fecven, 111),
   ic_monto + round(ic_monto*ic_tasa*ic_plazo_dias/(ic_base_cal*100),2),
   ic_monto,
   round(ic_monto*ic_tasa*ic_plazo_dias/(ic_base_cal*100),2) ,
   0
   from    cob_externos..ex_int_cdt_tmp
   where    ic_fpago     = 'VEN'
   if @@ERROR <> 0 begin
      print 'Error al insertar en ex_int_tablaDesarrolloDetIF'
      rollback tran
      goto final
   end



-- EXTRAE LOS CDTS CON PAGO PERIODICO
   select ic_operacion, ic_cuotas
   into #oper_periodica
   from  cob_externos..ex_int_cdt_tmp
   where ic_fpago     = 'PER'

   if   @@ERROR <> 0 begin
      print 'Error al insertar en ex_int_tablaDesarrolloDetIF'
      rollback tran
      goto final
   end

-- CICLO POR CADA CDT PERIODICA
   while 1 = 1 begin
  
      select @w_contador   = 0
      select @w_interes    = 0
      select @w_fecha_ven  = '01/01/1900'
      select @w_monto      = 0
      select @w_fecha_crea = '01/01/1900'
      select @w_operacion  = ''
      select @w_cuotas     = 0
      select @w_plazo      = 1
   
      select top 1
      @w_operacion = ic_operacion,
      @w_cuotas    = ic_cuotas
      from #oper_periodica
      order by ic_operacion
      if @@rowcount = 0 begin
         break
      end
   

      delete #oper_periodica
      where ic_operacion = @w_operacion
   
      select 
      @w_interes    = round(ic_monto*ic_tasa*ic_plazo_dias/(ic_base_cal*100),2)/@w_cuotas,  
      @w_interes_fin= round(ic_monto*ic_tasa*ic_plazo_dias/(ic_base_cal*100),2)/@w_cuotas,  
      @w_fecha_ven  = ic_fecven,
      @w_monto      = ic_monto,
      @w_fecha_crea = ic_fecha, 
      @w_plazo      = ic_plazo_dias 
      from  cob_externos..ex_int_cdt_tmp
      where  ic_operacion = @w_operacion
      if @@rowcount = 0 begin
         print 'No existe operacion ' + @w_operacion
         rollback tran
         goto final
      end
      while @w_contador < @w_cuotas begin
         select @w_contador = @w_contador + 1
      
         if @w_contador = @w_cuotas begin
            -- INSERTA LA ULTIMA CUOTA DEL CDT
            insert cob_externos..ex_int_tablaDesarrolloDetIF 
            values (
            @w_operacion,            @w_contador,        convert(varchar(10), dateadd(dd, -1, @w_fecha_ven),111),
            @w_monto + @w_interes,   @w_monto,           @w_interes_fin,
            0)
            if @@error <> 0 begin
               print 'Error al insertar ex_int_tablaDesarrolloDetIF (1)'
               rollback tran
               goto final
            end
         end
         else begin
         -- INSERTA LAS CUOTAS DEL CDT MENOS LA ULTIMA
            select @w_per = (@w_plazo/@w_cuotas/30)
            select @w_fecha = dateadd(dd, -1, dateadd(mm, @w_contador* @w_per , @w_fecha_crea))
         
            insert cob_externos..ex_int_tablaDesarrolloDetIF 
            values (
            @w_operacion, @w_contador, convert(varchar(10), @w_fecha, 111),
            @w_interes,   0,           @w_interes,
            @w_monto)
            if @@error <> 0 begin
               print 'Error al insertar ex_int_tablaDesarrolloDetIF (2)'
               rollback tran
               goto final
            end
         end
      end
   end

   insert into cob_externos..ex_control_corvus
   select getdate(),'PROCESO EXITOSO INSTRUMENTOS CDT ' ,'sp_niif_pfijo_dia', 'P','N','FECHA PROCESO:' + + convert(varchar(10),@w_fecha_dia,111)
      
   if @@TRANCOUNT > 0 begin
     commit tran
   end
   drop table  #oper_periodica
   select @w_fecha_dia  = dateadd(dd,1,@w_fecha_dia)

end -- while  mayor 

return 0

final:
insert into cob_externos..ex_control_corvus
   select getdate(),'PROCESO CON ERROR INSTRUMENTOS CDT' ,'sp_niif_pfijo_dia', 'E','N','FECHA PROCESO: ' + + convert(varchar(10),@w_fecha_dia,111)
return 1

go
/*
exec sp_niif_pfijo_dia
@i_param1 ='11/25/2011',
@i_param2 ='11/30/2011'
select * from  cob_externos..ex_int_operacionesIF
select * from cob_externos..ex_int_tablaDesarrolloDetIF 
select * from cob_externos..ex_control_corvus
*/
