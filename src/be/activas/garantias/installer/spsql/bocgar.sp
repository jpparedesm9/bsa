/************************************************************************/
/*   Archivo:              bocgar.sp                                    */
/*   Stored procedure:     sp_boc_gar                                   */
/*   Base de datos:        cob_custodia                                 */
/*   Producto:             Garantias                                    */
/*   Disenado por:         Sandra de La Cruz / Gabriel Alvis            */
/*   Fecha de escritura:   Jun/2009                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                               PROPOSITO                              */
/*   Balance Operativo Contable de Garantias                            */
/************************************************************************/


use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_boc_gar')
   drop proc sp_boc_gar
go

create procedure sp_boc_gar
   @i_param1     varchar(255)   = null,
   @i_param2     varchar(255)   = null
as

declare
   @w_mensaje            varchar(255),
   @w_error              int,
   @w_oficina            smallint,
   @w_tercero            char(1),
   @w_cliente            int,
   @w_valor_operativo    money,
   @w_calificacion       char(1),
   @w_clase_cartera      varchar(10),
   @w_cuenta_final       varchar(40),
   @w_dp_cuenta          varchar(40),
   @w_stored             varchar(40),
   @w_clave              varchar(40),
   @w_sp_name            varchar(40),
   @w_secuencial         int,
   @w_producto           int,
   @w_cod_val            int,
   @w_criterio           varchar(20),
   @w_garantia           varchar(64),
   @w_tipo_custodia      varchar(64),
   @w_idonea             char(1),
   @w_sec_fila           int,
   @i_fecha              datetime,   
   @i_historico          char(1)
   
select
   @i_fecha     = convert(datetime, @i_param1),
   @i_historico = isnull(convert(char(1), @i_param2), 'N')
   
if @i_fecha is null
begin
   select @i_fecha = fp_fecha
   from cobis..ba_fecha_proceso
end
   
/* CREAR TABLAS DE TRABAJO */
create table #cust_operativo(
   secuencial  int          identity(1,1)  null,
   garantia    varchar(64)                 null,
   tipo_cus    varchar(64)                 null,
   cliente     int                         null, 
   oficina     int                         null,  
   idonea      char(1)                     null,
   calif       char(1)                     null,
   clase_car   varchar(10)                 null,
   criterio    varchar(30)                 null,
   monto       money                       null,
   cod_val     int                         null )

/* INICIO DE VARIABLES DE TRABAJO */
select 
   @w_producto = 19,
   @w_sp_name  = 'sp_boc_gar'


delete cob_conta..cb_boc with (rowlock)
where bo_producto = @w_producto

if @@error <> 0
begin
   select 
      @w_mensaje = 'ERROR AL BORRAR LA TABLA DEL BOC',
      @w_error   = 710003
      
   goto ERRORFIN
end

delete cob_conta..cb_boc_det with (rowlock)
where bod_producto = @w_producto

if @@error <> 0
begin
   select 
      @w_mensaje = 'ERROR AL BORRAR LA TABLA DE DETALLES DEL BOC',
      @w_error   = 710003
      
   goto ERRORFIN
end


/* DETERMINAR TIPOS DE CUSTODIAS */
select tc_tipo
into #tipos_pagare
from cu_tipo_custodia
where tc_tipo like '12%'

select tc_tipo
into #tipos_otros
from cu_tipo_custodia
where tc_tipo not like '12%'


insert into #cust_operativo
select
   garantia       = dc_garantia,
   tipo_cus       = tc_tipo,
   cliente        = dc_cliente, 
   oficina        = dc_oficina,  
   idonea         = dc_idonea,
   calif          = '',
   clase_car      = '',
   criterio       = case dc_idonea when 'S' then 'I' else 'O' end + '.' + convert(varchar,dc_moneda),
   monto          = sum(dc_valor_actual),
   cod_val        = convert(int, 1)
from cob_conta_super..sb_dato_custodia,
     #tipos_pagare
where dc_fecha     = @i_fecha
and   dc_tipo      = tc_tipo
group by dc_garantia, tc_tipo, dc_cliente, dc_oficina, dc_idonea, dc_moneda
having sum(dc_valor_actual) >= 0.01

if @@error <> 0
begin
   select 
      @w_mensaje = 'ERROR AL INSERTAR CUSTODIAS DE TRABAJO',
      @w_error   = 710003
      
   goto ERRORFIN
end


insert into #cust_operativo
select
   garantia  = dc_garantia,
   tipo_cus  = tc_tipo,
   cliente   = do_codigo_cliente,       --> deudor principal de la operacion 
   oficina   = do_oficina,              --> oficina de la operacion  
   idonea    = dc_idonea,
   calif     = do_calificacion,
   clase_car = do_clase_cartera,
   criterio  = case dc_idonea when 'S' then 'I' else 'O' end  + '.' + do_clase_cartera +'.'+ convert(varchar, do_moneda),
   monto     = sum(dg_cobertura),
   cod_val   = convert(int, 2)
from cob_conta_super..sb_dato_garantia, 
     cob_conta_super..sb_dato_operacion, 
     cob_conta_super..sb_dato_custodia, 
     #tipos_otros
where dc_fecha          = @i_fecha
and   dc_tipo           = tc_tipo
and   dg_fecha          = dc_fecha
and   dg_garantia       = dc_garantia
and   dg_banco          = do_banco
and   do_tipo_operacion = dg_toperacion
and   do_fecha          = dg_fecha
group by dc_garantia, tc_tipo, do_codigo_cliente, do_oficina, dc_idonea, do_calificacion, do_clase_cartera, do_moneda
having sum(dg_cobertura) >= 0.01 

if @@error <> 0
begin
   select 
      @w_mensaje = ' ERROR AL INSERTAR GARANTIAS DE TRABAJO' ,
      @w_error   = 710001
      
   goto ERRORFIN
end


exec @w_error  = cob_credito..sp_boc_ini_cr_gar
   @i_empresa     = 1,
   @i_fecha       = @i_fecha,
   @i_producto    = @w_producto,
   @o_msg         = @w_mensaje out

if @w_error <> 0
   goto ERRORFIN
 
while 1=1
begin

   set rowcount 1
     
   select
      @w_garantia        = garantia,
      @w_tipo_custodia   = tipo_cus,
      @w_cliente         = cliente,
      @w_oficina         = oficina,
      @w_idonea          = idonea,
      @w_calificacion    = calif,
      @w_clase_cartera   = clase_car,
      @w_criterio        = criterio,
      @w_valor_operativo = monto,
      @w_cod_val         = cod_val,
      @w_sec_fila        = secuencial
   from #cust_operativo
   order by secuencial
   
   if @@rowcount = 0
   begin
      set rowcount 0
      break
   end
       
   set rowcount 0
   
   /*CURSOR PARA PERFILES*/
   declare cursor_perfiles cursor for
   select dp_cuenta
   from   cob_conta..cb_det_perfil with (nolock)
   where  dp_empresa  = 1
   and    dp_producto = @w_producto
   and    dp_perfil   = 'BOC_GAR'
   and    dp_codval   = @w_cod_val
   
   open cursor_perfiles
   
   fetch cursor_perfiles into @w_dp_cuenta
   
   while @@fetch_status = 0
   begin
   
      if @@fetch_status = -1
      begin
         close cursor_perfiles
         deallocate cursor_perfiles
         
         return 1
      end

      select @w_cuenta_final = 'NO DEFINIDA'
   
      /* DETERMINAR LA CUENTA CONTABLE */
      if substring(@w_dp_cuenta,1,1) in ('1','2','3','4','5','6','7','8','9','0')
      begin      
         select @w_cuenta_final   = @w_dp_cuenta
      end
      else
      begin
   
         select @w_stored = pa_stored
         from cob_conta..cb_parametro with (nolock)
         where pa_empresa     = 1
         and   pa_parametro   = @w_dp_cuenta
   
         if @@rowcount = 0
         begin
            select 
               @w_error   = 701102,
               @w_mensaje = ' ERR NO EXISTE TABLA DE CUENTAS ' +  @w_dp_cuenta + '(cb_parametro)'
               
            goto ERROR_PERFIL
         end
           
         select @w_cuenta_final = isnull(rtrim(ltrim(re_substring)), '')
         from cob_conta..cb_relparam with (nolock)
         where re_empresa   = 1
         and   re_parametro = @w_dp_cuenta
         and   re_clave     = @w_criterio
                     
         if @@rowcount = 0
         begin
            select 
               @w_error   = 701102,
               @w_mensaje = 'NO EXISTE CRITERIO CONTABLE ' +  isnull(@w_clave,'**') + ' EN TABLA DE CUENTAS: '+  isnull(@w_dp_cuenta,'**')
               
            goto ERROR_PERFIL
         end
            
      end
   
      /* DETERMINO SI ES CUENTA DE TERCERO */
      if exists (select 1 from cob_conta..cb_cuenta_proceso where cp_proceso in (6003, 6095) and cp_cuenta = @w_cuenta_final)
         select @w_tercero = 'S'
      else
         select @w_tercero = 'N'
      
      
      if exists(select 1 from cob_conta..cb_cuenta with (nolock)
                where cu_cuenta    = @w_cuenta_final
                and   cu_categoria = 'C') 
      begin
         select @w_valor_operativo = abs(@w_valor_operativo) * -1         
      end
      else
      begin
         select @w_valor_operativo = abs(@w_valor_operativo)         
      end
   
   
      if @w_tercero = 'S' begin
   
         if not exists (select 1 from cob_conta..cb_boc with (nolock)
                        where bo_fecha    = @i_fecha
                        and   bo_cliente  = @w_cliente
                        and   bo_cuenta   = @w_cuenta_final
                        and   bo_oficina  = @w_oficina
                        and   bo_producto = @w_producto)
         begin

            insert into cob_conta..cb_boc with (rowlock) (
               bo_fecha,          bo_cuenta,           bo_oficina,
               bo_cliente,        bo_val_opera,        bo_val_conta,
               bo_producto,       bo_diferencia)       
            values(                              
               @i_fecha,          @w_cuenta_final,     @w_oficina,
               @w_cliente,        @w_valor_operativo,  0,
               @w_producto,       @w_valor_operativo)
   
            if @@error != 0
            begin
               select 
                  @w_error   = 710001,
                  @w_mensaje = 'ERROR AL INSERTAR REGISTRO EN LA TABLA CB_BOC (cta de tercero)'
                  
               goto ERROR_PERFIL
            end
   
         end
         else
         begin
   
            update cob_conta..cb_boc with (rowlock) set
               bo_val_opera  = bo_val_opera  + @w_valor_operativo,
               bo_diferencia = bo_diferencia + @w_valor_operativo
            where bo_fecha    = @i_fecha
            and   bo_cliente  = @w_cliente
            and   bo_cuenta   = @w_cuenta_final
            and   bo_oficina  = @w_oficina
            and   bo_producto = @w_producto
   
            if @@error != 0
            begin
               select 
                  @w_error   = 710002,
                  @w_mensaje = 'ERROR AL ACTUALIZAR REGISTRO EN LA TABLA CB_BOC (cta de tercero)'
                  
               goto ERROR_PERFIL
            end
   
         end
   
      end
      else
      begin  -- la cuenta no es de terceros
   
         if not exists (select 1 from cob_conta..cb_boc with (nolock)
                        where bo_fecha    = @i_fecha
                        and   bo_cliente  = 0
                        and   bo_cuenta   = @w_cuenta_final
                        and   bo_oficina  = @w_oficina
                        and   bo_producto = @w_producto)
         begin
   
            insert into cob_conta..cb_boc with (rowlock)(
               bo_fecha,           bo_cuenta,          bo_oficina,
               bo_cliente,         bo_val_opera,       bo_val_conta,
               bo_diferencia,      bo_producto)
            values(
               @i_fecha,           @w_cuenta_final,    @w_oficina,
               0,                  @w_valor_operativo, 0,
               @w_valor_operativo, @w_producto)
   
            if @@error != 0
            begin
               select 
                  @w_error   = 710001,
                  @w_mensaje = 'ERROR AL INSERTAR REGISTRO EN LA TABLA CB_BOC (cta general)'
                  
               goto ERROR_PERFIL
            end
   
         end
         else
         begin
    
            update cob_conta..cb_boc with (rowlock) set
               bo_val_opera  = bo_val_opera  + @w_valor_operativo,
               bo_diferencia = bo_diferencia + @w_valor_operativo
            where bo_fecha    = @i_fecha
            and   bo_cliente  = 0
            and   bo_cuenta   = @w_cuenta_final
            and   bo_oficina  = @w_oficina
            and   bo_producto = @w_producto
   
            if @@error != 0
            begin
               select 
                  @w_error   = 710002,
                  @w_mensaje = 'ERROR AL ACTUALIZAR REGISTRO EN LA TABLA CB_BOC (cta general)'
                  
               goto ERROR_PERFIL
            end
         end
      end
   
      insert into cob_conta..cb_boc_det with (rowlock)(
         bod_fecha,           bod_cuenta,         bod_oficina,
         bod_cliente,         bod_banco,          bod_concepto,
         bod_admisible,       bod_calificacion,   bod_clase_cartera,
         bod_val_opera,       bod_producto)
      values(                 
         @i_fecha,            @w_cuenta_final,    @w_oficina,
         @w_cliente,          @w_garantia,        @w_tipo_custodia,
         @w_idonea,           @w_calificacion,    @w_clase_cartera,
         @w_valor_operativo,  @w_producto)
   
      if @@error != 0
      begin
         select 
            @w_error   = 710001,
            @w_mensaje = 'ERROR AL INSERTAR REGISTRO EN LA TABLA CB_BOC_DET'
            
         goto ERROR_PERFIL
      end
   
      goto SIGUIENTE_PERFIL
               
ERROR_PERFIL:
      
      select @w_mensaje = @w_mensaje + 'CTA: '   + @w_cuenta_final
      
      exec sp_errorlog
         @i_fecha_proc  = @i_fecha, 
         @i_usuario     = 'OPERADOR',
         @i_garantia    = @w_cuenta_final, 
         @i_descripcion = @w_mensaje
   
SIGUIENTE_PERFIL:
   
      fetch cursor_perfiles into @w_dp_cuenta
   
   end
   
   close cursor_perfiles
   deallocate cursor_perfiles
   
   delete #cust_operativo
   where secuencial = @w_sec_fila
         
   if @@error != 0
   begin
      select 
         @w_error   = 710003,
         @w_mensaje = 'ERROR AL ELIMINAR REGISTRO EN LA TABLA CB_BOC_DET'
      
      exec sp_errorlog
         @i_fecha_proc  = @i_fecha, 
         @i_usuario     = 'OPERADOR',
         @i_garantia    = @w_cuenta_final, 
         @i_descripcion = @w_mensaje
   end
   
end


if @i_historico = 'S' begin

   exec @w_secuencial= cob_cartera..sp_gen_sec
      @i_operacion= -999

   insert into cob_conta..cb_boc_respaldo with (rowlock)
   select @w_secuencial ,*
   from cob_conta..cb_boc
   where bo_producto = @w_producto

   if @@error != 0
   begin
      select 
         @w_error   = 710001,
         @w_mensaje = 'ERROR AL RESPALDAR EL BOC (TABLA:ca_boc_respaldo)'
         
      goto ERRORFIN
   end

   insert into cob_conta..cb_boc_det_respaldo with (rowlock)
   select @w_secuencial ,*
   from cob_conta..cb_boc_det with (nolock)
   where bod_producto = @w_producto

   if @@error != 0
   begin
      select 
         @w_error   = 710001,
         @w_mensaje = 'ERROR AL RESPALDAR EL BOC (TABLA:ca_boc_respaldo)'
         
      goto ERRORFIN
   end

end

return 0

ERRORFIN:

exec sp_errorlog
   @i_fecha_proc  = @i_fecha, 
   @i_usuario     = 'OPERADOR',
   @i_garantia    = @w_garantia, 
   @i_descripcion = @w_mensaje

return @w_error

go
