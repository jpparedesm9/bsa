/**************************************************************************/
/*   Archivo:              sp_gen_ficha_pago_ind.sp                       */
/*   Stored procedure:     sp_gen_ficha_pago_ind                          */
/*   Base de datos:        cob_cartera                                    */
/*   Producto:             Cartera                                        */
/*   Disenado por:         KVI                                            */
/*   Fecha de escritura:   Diciembre 2022                                 */
/**************************************************************************/
/*                             IMPORTANTE                                 */
/*   Este programa es parte de los paquetes bancarios propiedad de        */
/*   'COBIS'.                                                             */
/*   Su uso no autorizado queda expresamente prohibido asi como cualquier */
/*   alteracion o agregado hecho por alguno de sus usuarios sin el        */
/*   debido consentimiento por escrito de la Presidencia Ejecutiva de     */
/*   COBIS o su representante legal.                                      */
/**************************************************************************/
/*                             PROPOSITO                                  */
/*   Genera data para reporte ficha de pago individual                    */
/**************************************************************************/
/*                             MODIFICACIONES                             */
/*    FECHA       AUTOR                        RAZON                      */
/*   28/12/2022   KVI      Emision Inicial                                */
/*   25/01/2022   ACH      REQ#190362 Impresión de Ficha PI Inc.1 nota #52*/
/**************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_gen_ficha_pago_ind')
   drop proc sp_gen_ficha_pago_ind
go

create proc sp_gen_ficha_pago_ind
(
  @i_banco                cuenta     = null,
  @i_operacion            varchar(2) = 'I'
)
as 
declare
  @w_error                int,
  @w_sp_name              varchar(30),
  @w_msg                  varchar(255),
  @w_fecha_proceso        datetime,
  @w_est_vigente          tinyint,
  @w_est_vencida          tinyint,
  @w_est_etapa2           tinyint,
  @w_est_castigado        tinyint,
  @w_toperacion           varchar(30),
  @w_operacion_ca         int,
  @w_cliente              int,  
  @w_corresponsal         varchar(20), 
  @w_fecha_venci          datetime, 
  @w_monto_pago           money, 
  @w_referencia           varchar(40),
  @w_ciudad_nacional      int,
  @w_id_corresp           varchar(10),
  @w_sp_corresponsal      varchar(50),
  @w_descripcion_corresp  varchar(30),
  @w_convenio             varchar(30),
  @w_nombre_cliente       varchar(255),
  @w_tipo_tran            varchar(4),
  @w_cliente_tramite      int
  

select @w_sp_name = 'sp_gen_ficha_pago_ind'
select @w_toperacion = 'INDIVIDUAL'
select @w_tipo_tran = 'PI'

select @w_cliente_tramite = op_cliente
from ca_operacion where op_banco = @i_banco

/*DETERMINAR FECHA DE PROCESO*/
select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso
  
if @i_operacion = 'I' 
begin
  
  /*CONSULTA DE PARAMETROS*/
  select @w_ciudad_nacional = pa_int
  from cobis..cl_parametro with (nolock)
  where pa_nemonico = 'CIUN'
  and pa_producto = 'ADM'
     
  /*CONSULTA DE ESTADOS DE CARTERA*/
  exec @w_error    = sp_estados_cca
  @o_est_vigente   = @w_est_vigente   out,
  @o_est_vencido   = @w_est_vencida   out,
  @o_est_etapa2    = @w_est_etapa2    out,
  @o_est_castigado = @w_est_castigado out
  
  if @w_error <> 0 
  begin
     goto ERROR
  end

  /*ELIMINAR CONTENIDO DE LAS TABLAS*/
  delete from ca_gen_ficha_pago_ind_det
  where fpid_cliente = @w_cliente_tramite
  delete from ca_gen_ficha_pago_ind 
  where fpi_cliente = @w_cliente_tramite
  
  /*UNIVERSO DE CONSULTA*/
  print 'sp_gen_ficha_pago_ind >>paraUniverso>>fecha_proceso: ' + convert(varchar(30), @w_fecha_proceso) 
  select 
    op_cliente   as cliente, 
    op_operacion as operacion, 
    op_tramite   as tramite, 
    op_banco     as ope_grupal, 
    max(di_dividendo) as dividendo, 
    max(di_fecha_ven) as fecha_ven, 
    op_fecha_ult_proceso as fecha_ult_pro
  into #InfoPresIndividual
  from ca_operacion, ca_dividendo (nolock)
  where 
  op_operacion      = di_operacion 
  and di_estado     in (@w_est_vigente, @w_est_vencida)
  and op_estado     in (@w_est_vigente, @w_est_etapa2, @w_est_vencida, @w_est_castigado)
  and op_toperacion = @w_toperacion
  and op_banco      = @i_banco
  group by op_cliente, op_operacion, op_tramite, op_banco, op_fecha_ult_proceso
  
  if (@@error != 0)
  begin
      select @w_error = 708154
      goto ERROR
  end
  
  insert into ca_gen_ficha_pago_ind 
  (
  fpi_operacion,     fpi_cliente,    fpi_fecha_proceso,     fpi_cliente_name, 
  fpi_op_fecha_liq,  fpi_op_moneda,  fpi_op_oficina,        fpi_di_fecha_vig, 
  fpi_di_dividendo,  fpi_di_monto,   
  fpi_email,         
  fpi_banco
  )                                
  select                           
  operacion,         cliente,        @w_fecha_proceso,      isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,'') + ' ' + en_nombre AS fpi_cliente_name, 
  opg.op_fecha_liq,  opg.op_moneda,  opg.op_oficina,        fecha_ven, 
  dividendo,         sum(am_cuota + am_gracia - am_pagado),
  (select top 1 di_descripcion from cobis..cl_direccion where di_ente = cliente and di_tipo = 'CE' order by di_direccion) as mail,
  @i_banco
  from #InfoPresIndividual, ca_dividendo (nolock), ca_amortizacion (nolock), cobis..cl_ente, ca_operacion opg
  where cliente          = en_ente 
  and   operacion        = di_operacion 
  and   di_operacion     = am_operacion
  and   di_dividendo     = am_dividendo
  and   ( di_estado      = @w_est_vencida
         or (di_estado   = @w_est_vigente and di_fecha_ven = @w_fecha_proceso))
  and   opg.op_operacion = operacion 
  group by operacion, cliente, tramite, p_p_apellido, p_s_apellido, en_nombre, fecha_ven, dividendo, opg.op_fecha_liq, opg.op_moneda, opg.op_oficina, opg.op_operacion 
  order by operacion, cliente, tramite, p_p_apellido, p_s_apellido, en_nombre, fecha_ven, dividendo, opg.op_fecha_liq, opg.op_moneda, opg.op_oficina, opg.op_operacion
  
  if (@@error != 0)
  begin
      select @w_error = 708154
      goto ERROR
  end

  if((select count(1) from ca_gen_ficha_pago_ind where fpi_banco = @i_banco) = 0) begin
      insert into ca_gen_ficha_pago_ind 
      (
      fpi_operacion,     fpi_cliente,    fpi_fecha_proceso,     fpi_cliente_name, 
      fpi_op_fecha_liq,  fpi_op_moneda,  fpi_op_oficina,        fpi_di_fecha_vig, 
      fpi_di_dividendo,  fpi_di_monto,   
      fpi_email,         
      fpi_banco
      )                                
      select                           
      operacion,         cliente,        @w_fecha_proceso,      isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,'') + ' ' + en_nombre AS fpi_cliente_name, 
      opg.op_fecha_liq,  opg.op_moneda,  opg.op_oficina,        fecha_ven, 
      dividendo,         0,
      (select top 1 di_descripcion from cobis..cl_direccion where di_ente = cliente and di_tipo = 'CE' order by di_direccion) as mail,
      @i_banco
      from #InfoPresIndividual, cobis..cl_ente, ca_operacion opg
      where cliente          = en_ente
      and   opg.op_operacion = operacion 
      group by operacion, cliente, tramite, p_p_apellido, p_s_apellido, en_nombre, fecha_ven, dividendo, opg.op_fecha_liq, opg.op_moneda, opg.op_oficina, opg.op_operacion 
      order by operacion, cliente, tramite, p_p_apellido, p_s_apellido, en_nombre, fecha_ven, dividendo, opg.op_fecha_liq, opg.op_moneda, opg.op_oficina, opg.op_operacion  
     
	 if (@@error != 0)
      begin
          select @w_error = 708154
          goto ERROR
      end  
  end
  
  select @w_cliente = 0
  select top 1
  @w_cliente      = fpi_cliente,
  @w_operacion_ca = fpi_operacion,
  @w_monto_pago   = fpi_di_monto,
  @w_fecha_venci  = fpi_di_fecha_vig
  from ca_gen_ficha_pago_ind
  where fpi_cliente >  @w_cliente
  and fpi_banco = @i_banco 
  order by fpi_cliente asc
  
  while @@rowcount > 0 
  begin
     select @w_nombre_cliente = upper(fpi_cliente_name) from cob_cartera..ca_gen_ficha_pago_ind where fpi_cliente = @w_cliente
     select @w_nombre_cliente = replace(@w_nombre_cliente,'Á','A')
     select @w_nombre_cliente = replace(@w_nombre_cliente,'É','E')
     select @w_nombre_cliente = replace(@w_nombre_cliente,'Í','I')
     select @w_nombre_cliente = replace(@w_nombre_cliente,'Ó','O')
     select @w_nombre_cliente = replace(@w_nombre_cliente,'Ú','U')
     select @w_nombre_cliente = replace(@w_nombre_cliente,'Ñ‘','N')
     select @w_nombre_cliente = replace(@w_nombre_cliente,'Ü','U')
     
     update  cob_cartera..ca_gen_ficha_pago_ind
     set  fpi_cliente_name = @w_nombre_cliente
     where fpi_cliente = @w_cliente
     and   fpi_banco   = @i_banco
    
     select @w_id_corresp = 0
      
     
     while 1 = 1 
	 begin    
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
        and   co_nombre             not in ('OBJETADO','QUEBRANTO') 
        order by convert(int,co_id) asc
  	  
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
     	  
     	insert into ca_gen_ficha_pago_ind_det 
     	(fpid_cliente, fpid_operacion,   fpid_corresponsal, fpid_institucion,        fpid_referencia, fpid_convenio, fpid_banco)
     	values
     	(@w_cliente,   @w_operacion_ca,  @w_corresponsal,   @w_descripcion_corresp,  @w_referencia,   @w_convenio,   @i_banco)
             	  
     end
     
     select 
     @w_cliente      = fpi_cliente,
     @w_operacion_ca = fpi_operacion, 
     @w_monto_pago   = fpi_di_monto,
     @w_fecha_venci  = fpi_di_fecha_vig   
     from ca_gen_ficha_pago_ind
     where fpi_cliente >  @w_cliente
	 and fpi_banco = @i_banco 
     order by fpi_cliente desc  
  end
  
  select 
    'fecha_inicio'    = fpi_op_fecha_liq, 
    'nombre_cliente'  = fpi_cliente_name,
    'fecha_vigencia'  = fpi_di_fecha_vig, 
    'nro_pago'        = fpi_di_dividendo,
    'monto'           = fpi_di_monto,
    'sucursal'        = of_nombre
  from cob_cartera..ca_gen_ficha_pago_ind, cobis..cl_oficina 
  where fpi_banco = @i_banco
  and   fpi_op_oficina = of_oficina

  select 
    'institucion' = fpid_institucion,
    'referencia'  = fpid_referencia,
    'convenio'    = fpid_convenio
  from cob_cartera..ca_gen_ficha_pago_ind_det
  where fpid_banco = @i_banco
  
end

return 0

ERROR:
select @w_msg = mensaje
from cobis..cl_errores with (nolock)
where numero = @w_error

exec cobis..sp_cerror
@t_debug  = 'N',
@t_file   = null,
@t_from   = @w_sp_name,
@i_num    = @w_error,
@i_msg    = @w_msg

return 1

go
