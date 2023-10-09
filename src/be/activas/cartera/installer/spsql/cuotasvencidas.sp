/************************************************************************/
/*   Archivo:              avisovenccuotas.sp                           */
/*   Stored procedure:     sp_vencimientos_cuotas                       */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         DFu                                          */
/*   Fecha de escritura:   Julio 2017                                   */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                                   PROPOSITO                          */
/*   Genera archivo xml con informacion de vencimiento de cuotas para   */
/*   envio de correo de aviso de vencimiento a deudores                 */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA        AUTOR             RAZON                                */
/*  12/Dic/2017  DFU               Emision inicial                      */
/*  21/Nov/2018  SRO               Referencias Numéricas                */
/*  06/Nov/2019  SRO               Mejora 129659                        */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_vencimientos_cuotas')
   drop proc sp_vencimientos_cuotas
go

create proc sp_vencimientos_cuotas
(
    @i_param1        datetime = null, --fecha
    @i_param2        cuenta   = null, --banco
    @o_msg           varchar(255) = null out
)
as 

declare
@w_error                int,
@w_valida_error         char(1),
@w_return               int,
@w_fecha_proceso        datetime,
@w_fecha_vencimiento    datetime,
@w_banco                cuenta,
@w_est_vigente          tinyint,
@w_est_vencida          tinyint,
@w_lon_operacion        tinyint,
@w_format_fecha         varchar(30),
@w_toperacion           varchar(30),
@w_param_ISSUER         varchar(30),
@w_sp_name              varchar(30),
@w_msg                  varchar(255),
@w_path_out             varchar(255),
@w_path_in              varchar(255),
@w_cmd                  varchar(1000),
@w_par_fp_co_pag_ref    varchar(10),
@w_institucion1         varchar(20),
@w_institucion2         varchar(20),
@w_operacion_ca         int,
@w_cliente              int, 
@w_fecha                datetime, 
@w_corresponsal         varchar(20), 
@w_fecha_venci          datetime, 
@w_monto_pago           money, 
@w_referencia           varchar(40),
@w_ref_santander        varchar(40),
@w_ciudad_nacional      int,
@w_fecha_ini            datetime ,
@w_operacion            int,
@w_id_corresp           varchar(10),
@w_sp_corresponsal      varchar(50),
@w_descripcion_corresp  varchar(30),
@w_fail_tran            char(1),
@w_convenio             varchar(30),
@w_nombre_cliente       varchar(255),
@w_tipo_tran            varchar(4)


select @w_sp_name = 'sp_vencimientos_cuotas', @w_valida_error = 'S'
select @w_toperacion = 'INDIVIDUAL'
select @w_tipo_tran = 'PI'

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'


/*DETERMINAR FECHA DE PROCESO*/
if (@i_param1 is null)
begin
    select @w_fecha_proceso     = fc_fecha_cierre,
           @w_fecha_vencimiento = dateadd(dd, -1, fc_fecha_cierre)
    from cobis..ba_fecha_cierre 
    where  fc_producto = 7
end
else
begin
    select @w_fecha_proceso     = @i_param1,
           @w_fecha_vencimiento = dateadd(dd, -1, @i_param1)
end


--CONDICION DE SALIDA EN CASO DE DOBLE CIERRE POR FIN DE MES NO SE DEBE EJECUTAR
if exists( select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_proceso )
          return 0 

--HASTA ENCONTRAR EL HABIL ANTERIOR
select  @w_fecha_ini  = dateadd(dd,-1,@w_fecha_proceso)

while exists( select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_ini ) 
   select @w_fecha_ini = dateadd(dd,-1,@w_fecha_ini)
   

exec @w_error = sp_estados_cca
@o_est_vigente  = @w_est_vigente out,
@o_est_vencido  = @w_est_vencida out

select @w_param_ISSUER = pa_char
    from cobis..cl_parametro 
    where pa_nemonico = 'ISSUER' 
    and pa_producto = 'CCA'

if (@@error != 0 or @@rowcount != 1)
begin
   select @w_error = 724629
   goto ERROR_PROCESO
end

select @w_lon_operacion = pa_tinyint
    from cobis..cl_parametro 
    where pa_nemonico = 'LOOPA' 
    and pa_producto = 'CCA'

if (@@error != 0 or @@rowcount != 1)
begin
   select @w_error = 724653
   goto ERROR_PROCESO
end

select @w_format_fecha = pa_char
    from cobis..cl_parametro 
    where pa_nemonico = 'FFOPA' 
    and pa_producto = 'CCA'

if (@@error != 0 or @@rowcount != 1)
begin
   select @w_error = 724654
   goto ERROR_PROCESO
end

if not exists(select pa_tinyint
    from cobis..cl_parametro 
    where pa_nemonico = 'LMOPA' 
    and pa_producto = 'CCA')
begin
   select @w_error = 724655
   goto ERROR_PROCESO
end


delete from ca_vencimiento_cuotas_det
delete from ca_vencimiento_cuotas 

select @w_fecha_proceso,@w_est_vencida,@w_toperacion,@w_fecha_vencimiento,@w_fecha_ini

select 
op_cliente   as cliente, 
op_operacion as operacion, 
op_tramite   as tramite, 
op_banco     as ope_grupal, 
di_dividendo as dividendo, 
di_fecha_ven as fecha_ven, 
op_fecha_ult_proceso as fecha_ult_pro
into #InfoPresGrupal
from ca_operacion, ca_dividendo (nolock)
where 
op_operacion        = di_operacion 
and di_estado       = @w_est_vencida
and op_estado       in (@w_est_vigente, @w_est_vencida)
and op_toperacion   = @w_toperacion
and di_fecha_ven    between @w_fecha_ini and @w_fecha_vencimiento
and op_fecha_ult_proceso = @w_fecha_proceso
and op_banco = isnull(@i_param2, op_banco)

select @@rowcount
if (@@error != 0)
begin
    select @w_error = 708154
    goto ERROR_PROCESO
end



insert into ca_vencimiento_cuotas 
(vc_operacion,   vc_cliente,   vc_fecha_proceso, vc_cliente_name, 
vc_op_fecha_liq, vc_op_moneda, vc_op_oficina,    vc_di_fecha_vig, 
vc_di_dividendo, vc_di_monto,  vc_email)
select  operacion, cliente,    @w_fecha_proceso, isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,'') + ' ' + en_nombre AS vc_cliente_name, 
opg.op_fecha_liq, opg.op_moneda, opg.op_oficina, fecha_ven, 
dividendo, sum(am_cuota + am_gracia - am_pagado),
(select top 1 di_descripcion from cobis..cl_direccion where di_ente = cliente and di_tipo = 'CE' order by di_direccion ) as mail
from #InfoPresGrupal, ca_dividendo (nolock), ca_amortizacion (nolock), cobis..cl_ente, ca_operacion opg
where cliente          = en_ente 
and   operacion        = di_operacion 
and   di_operacion     = am_operacion
and   di_dividendo     = am_dividendo
and   di_estado        = @w_est_vencida
and   opg.op_operacion = operacion 
group by operacion, cliente, tramite, p_p_apellido, p_s_apellido, en_nombre, fecha_ven, dividendo, opg.op_fecha_liq, opg.op_moneda, opg.op_oficina, opg.op_operacion 
order by operacion, cliente, tramite, p_p_apellido, p_s_apellido, en_nombre, fecha_ven, dividendo, opg.op_fecha_liq, opg.op_moneda, opg.op_oficina, opg.op_operacion

if (@@error != 0)
begin
    select @w_error = 708154
    goto ERROR_PROCESO
end

select @w_cliente = 0
select top 1
@w_cliente      = vc_cliente,
@w_operacion_ca = vc_operacion,
@w_monto_pago   = vc_di_monto,
@w_fecha_venci  = vc_di_fecha_vig
from ca_vencimiento_cuotas
where vc_cliente >  @w_cliente
order by vc_cliente asc

while @@rowcount > 0 begin
   select @w_nombre_cliente = upper(vc_cliente_name) from cob_cartera..ca_vencimiento_cuotas where vc_cliente = @w_cliente
   select @w_nombre_cliente = replace(@w_nombre_cliente,'Á','A')
   select @w_nombre_cliente = replace(@w_nombre_cliente,'É','E')
   select @w_nombre_cliente = replace(@w_nombre_cliente,'Í','I')
   select @w_nombre_cliente = replace(@w_nombre_cliente,'Ó','O')
   select @w_nombre_cliente = replace(@w_nombre_cliente,'Ú','U')
   select @w_nombre_cliente = replace(@w_nombre_cliente,'Ñ','N')
   select @w_nombre_cliente = replace(@w_nombre_cliente,'Ü','U')
   
   update  cob_cartera..ca_vencimiento_cuotas
   set  vc_cliente_name = @w_nombre_cliente
   where vc_cliente = @w_cliente
  
   select @w_id_corresp = 0
    
   
   while 1 = 1 begin
  
      select top 1 
      @w_id_corresp          = co_id,   
      @w_corresponsal        = co_nombre,
      @w_descripcion_corresp = co_descripcion,
      @w_sp_corresponsal     = co_sp_generacion_ref,
      @w_convenio            = ctr_convenio
      from  ca_corresponsal, 
      ca_corresponsal_tipo_ref
      where co_id                 = ctr_co_id       
      and   convert(int,co_id)    > convert(int,@w_id_corresp)
      and   co_estado             = 'A'
      and   ctr_tipo_cobis        = @w_tipo_tran      
      and   co_nombre             not in ('OBJETADO','QUEBRANTO') --Mejora 129659
      order by convert(INT,co_id) asc
	  
	  if @@rowcount = 0 break
   
      exec @w_error     = @w_sp_corresponsal
      @i_tipo_tran      = @w_tipo_tran,
      @i_id_referencia  = @w_operacion_ca ,
      @i_monto          = @w_monto_pago,
      @i_monto_desde    = null,
      @i_monto_hasta    = null,
      @i_fecha_lim_pago = @w_fecha_venci,	  
      @o_referencia     = @w_referencia out
         
         
       if @w_error <> 0 begin
          select @w_msg = mensaje from cobis..cl_errores where numero = @w_error
          print @w_msg + '. CLIENTE:'+ convert(VARCHAR, @w_cliente)
          continue
       end
   	  
   	   insert into ca_vencimiento_cuotas_det 
   	   (vcd_cliente, vcd_operacion, vcd_corresponsal, vcd_institucion,     vcd_referencia,   vcd_convenio)
   	   values
   	   (@w_cliente,  @w_operacion_ca, @w_corresponsal,  @w_descripcion_corresp, @w_referencia,  @w_convenio)
         
  	  
   end
   
   select 
   @w_cliente      = vc_cliente,
   @w_operacion_ca = vc_operacion, 
   @w_monto_pago   = vc_di_monto,
   @w_fecha_venci  = vc_di_fecha_vig   
   from ca_vencimiento_cuotas
   where vc_cliente >  @w_cliente
   order by vc_cliente desc

end


 

exec @w_return = cob_cartera..sp_vencimientos_cuotas_xml 

if @w_return != 0 
begin
   select @w_error = @w_return
   goto ERROR_PROCESO
end

return 0
   
ERROR_PROCESO:
    select @w_msg = mensaje
        from cobis..cl_errores with (nolock)
        where numero = @w_error
        set transaction isolation level read uncommitted
      
   select 
   @w_banco      = isnull(@i_param2, ''), 
   @w_msg        = isnull(@w_msg,    '')
      
   select @w_msg = @w_msg + ' cuenta: ' + @w_banco
      
   select @o_msg = ltrim(rtrim(@w_msg))
      
   exec sp_errorlog 
      @i_fecha     = @i_param1,
      @i_error     = @w_error, 
      @i_usuario   = 'sa', 
      @i_tran      = 7076,
      @i_tran_name = @w_sp_name,
      @i_cuenta    = @i_param2,
      @i_anexo     = @w_msg,
      @i_rollback  = 'N'
   
   if (@w_valida_error = 'S')
   begin
      return @w_error
   end
   else
   begin
      return 0
   end

go

