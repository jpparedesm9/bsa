/************************************************************************/
/*  Archivo:            mantenimiento_cb.sp                             */
/*  Stored procedure:   sp_mantenimiento_cb                             */
/*  Base de datos:      cob_remesas                                     */
/*  Producto:           Corresponsales Bancarios                        */
/*  Disenado por:                                                       */
/*  Fecha de escritura:                                                 */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'COBISCorp'.                                                        */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                            PROPOSITO                                 */
/* Mantenimiento de corresponsales bancarios                            */
/************************************************************************/

use cob_remesas
go
 
if exists (select 1 from sysobjects where name = 'sp_mantenimiento_cb')
   drop proc sp_mantenimiento_cb
go

CREATE proc sp_mantenimiento_cb (
@s_user            login        ,
@s_date            datetime     ,
@s_ofi             smallint     ,
@s_ssn             int          ,
@s_term            varchar(10)  ,
@t_trn             int          ,
@i_operacion       char(1)      ,
@i_corresponsal    int          = 0,
@i_codigo_red      varchar(30)  = null,
@i_estado          char(1)      = null,
@i_num_contrato    varchar(100) = null,
@i_cta_cupo        cuenta       = null,
@i_cta_comision    cuenta       = null,
@i_fecha_ven       datetime     = null,
@i_modo            int          = 0  
)    

as declare
@w_return    int,
@w_mensaje   mensaje,
@w_error     int,
@w_sp_name   mensaje,
@w_ente      int,
@w_rowcount  int

select @w_sp_name = 'sp_mantenimiento_cb'
if @i_operacion <> 'S'
begin
   if @i_corresponsal is null
   begin
      select @w_mensaje = 'CORRESPONSAL BANCARIO NO ENVIADO',
             @w_error   = 2609823
      goto ERROR
   end
   
   if @i_codigo_red is null 
   begin
      select @w_mensaje = 'CODIGO DE RED NO ENVIADO',
             @w_error   = 2609848
      goto ERROR
   end
   
   if @i_estado is null 
   begin
      select @w_mensaje = 'ESTADO NO ENVIADO',
             @w_error   = 2609849
      goto ERROR
   end
   
   if @i_num_contrato is null 
   begin
      select @w_mensaje = 'NUMERO DE CONTRATO NO ENVIADO',
             @w_error   = 2609850
      goto ERROR
   end
   
   if @i_cta_cupo  is null 
   begin
      select @w_mensaje = 'CUENTA DE CUPO NO ENVIADA',
             @w_error   = 2609851
      goto ERROR
   end
   
   if @i_fecha_ven  is null
   begin
      select @w_mensaje = 'FECHA DE VENCIMIENTO NO ENVIADA',
             @w_error   = 2609839
      goto ERROR
   end
   
   select @w_ente  = ac_cliente
   from cobis..cl_asoc_clte_serv
   where ac_codigo = @i_corresponsal
   and   ac_estado = 'H'
   
   if @@ROWCOUNT = 0
   begin
      select @w_mensaje = 'RELACION CLIENTE - CB NO EXISTE',
             @w_error   = 101250
      goto ERROR
   end
end

if @i_operacion = 'I'
begin
   if exists (select top 1 1 from re_mantenimiento_cb where mc_cod_cb = @i_corresponsal)
   begin
      select @w_mensaje = 'CORRESPONSAL YA SE ENCUENTRA REGISTRADO',
             @w_error   = 2609853
      goto ERROR
   end
   
   if exists (select top 1 1 from re_mantenimiento_cb where mc_cod_cb = @i_corresponsal and mc_cod_red = @i_codigo_red)
   begin
      select @w_mensaje = 'CORRESPONSAL YA SE ENCUENTRA REGISTRADO CON EL CODIGO DE RED',
             @w_error   = 2609853
      goto ERROR
   end
   
   if exists (select top 1 1 from re_mantenimiento_cb 
              where mc_cta_banco = @i_cta_cupo)
   begin
      select @w_mensaje = 'CUENTA DE CUPO YA SE ENCUENTRA ASOCIADA A OTRO CORRESPONSAL',
             @w_error   = 2609854
      goto ERROR
   end
   
   if @i_cta_comision is not null
   begin
      if exists (select top 1 1 from re_mantenimiento_cb 
                 where mc_cta_comision = @i_cta_comision)
      begin
         select @w_mensaje = 'CUENTA PARA COMISIONES YA SE ENCUENTRA ASOCIADA A OTRO CORRESPONSAL',
                @w_error   = 2609855
         goto ERROR
      end
   end
   
   insert into re_mantenimiento_cb (
   mc_cod_cb       , mc_ente      , mc_cod_red      , mc_estado        ,
   mc_num_contrato , mc_cta_banco , mc_cta_comision , mc_fecha_ven_con , 
   mc_usuario      , mc_fecha_ing , mc_fecha_mod    , mc_oficina       )
   values (
   @i_corresponsal , @w_ente     , @i_codigo_red   , @i_estado    ,
   @i_num_contrato , @i_cta_cupo , @i_cta_comision , @i_fecha_ven ,
   @s_user         , @s_date     , NULL            , @s_ofi       )
   
   if @@error <> 0
   begin
      select @w_mensaje = 'ERROR INSERTANDO CORRESPONSAL RED POSICIONADA',
             @w_error   = @@error
      goto ERROR
   end
   
   insert into re_tran_servicio (
   ts_int1     , ts_int2     , ts_varchar2 , ts_char1      ,
   ts_varchar4 , ts_cuenta1          , ts_cuenta2  , ts_datetime1  ,
   ts_operador , ts_tsfecha          , ts_oficina  , ts_secuencial ,
   ts_terminal , ts_tipo_transaccion )
   values (
   @i_corresponsal , @w_ente     , @i_codigo_red   , @i_estado    ,
   @i_num_contrato , @i_cta_cupo , @i_cta_comision , @i_fecha_ven ,
   @s_user         , @s_date     , @s_ofi          , @s_ssn       ,
   @s_term         , @t_trn      )
   
   if @@error <> 0
   begin
      select @w_mensaje = 'ERROR INSERTANDO TRANSACION DE SERVICIO',
             @w_error   = @@error
      goto ERROR
   end
end

if @i_operacion = 'U'
begin
   if exists (select top 1 1 from re_mantenimiento_cb where mc_cod_cb = @i_corresponsal)
   begin
      if exists (select top 1 1 from re_mantenimiento_cb 
                 where mc_cod_cb    <> @i_corresponsal 
                 and   mc_cta_banco =  @i_cta_cupo)
      begin
         select @w_mensaje = 'CUENTA DE CUPO YA SE ENCUENTRA ASOCIADA A OTRO CORRESPONSAL',
                @w_error   = 2609854
         goto ERROR
      end
      
      if @i_cta_comision is not null
      begin
         if exists (select top 1 1 from re_mantenimiento_cb 
                    where mc_cod_cb       <> @i_corresponsal 
                     and   mc_cta_comision =  @i_cta_comision)
         begin
            select @w_mensaje = 'CUENTA PARA COMISIONES YA SE ENCUENTRA ASOCIADA A OTRO CORRESPONSAL',
                   @w_error   = 2609855
           goto ERROR
         end
      end   
   
      update re_mantenimiento_cb
      set mc_cod_red       = @i_codigo_red   ,
          mc_estado        = @i_estado       ,
          mc_num_contrato  = @i_num_contrato ,
          mc_cta_banco     = @i_cta_cupo     ,
          mc_cta_comision  = @i_cta_comision ,
          mc_fecha_ven_con = @i_fecha_ven    ,
          mc_usuario       = @s_user         ,
          mc_fecha_mod     = @s_date         ,
          mc_oficina       = @s_ofi          ,
          mc_ente          = @w_ente
      where mc_cod_cb = @i_corresponsal
      
      select @w_rowcount = @@ROWCOUNT
      
      if @@error <> 0
      begin
         select @w_mensaje = 'ERROR ACTUALIZANDO CORRESPONSAL RED POSICIONADA',
                @w_error   = @@error
         goto ERROR
      end
      
      if @w_rowcount = 0
      begin
         select @w_mensaje = 'NO EXISTEN REGISTROS CORRESPONSAL RED POSICIONADA PARA ACTUALIZAR',
                @w_error   = 2609857
         goto ERROR
      end
      
      update cobis..cl_asoc_clte_serv
      set ac_estado = @i_estado
      where ac_codigo = @i_corresponsal
      
      select @w_rowcount = @@ROWCOUNT
      
      if @@error <> 0
      begin
         select @w_mensaje = 'ERROR ACTUALIZANDO CORRESPONSAL RED POSICIONADA',
                @w_error   = @@error
         goto ERROR
      end
      
      if @w_rowcount = 0
      begin
         select @w_mensaje = 'NO EXISTEN REGISTROS CORRESPONSAL RED POSICIONADA PARA ACTUALIZAR - ESTADO',
                @w_error   = 2609857
         goto ERROR
      end
      
      insert into re_tran_servicio (
      ts_int1     , ts_int2             , ts_varchar2 , ts_char1     ,
      ts_varchar4 , ts_cuenta1          , ts_cuenta2  , ts_datetime1 ,
      ts_operador , ts_tsfecha          , ts_oficina  , ts_secuencial,
      ts_terminal , ts_tipo_transaccion )
      values (
      @i_corresponsal , @w_ente     , @i_codigo_red   , @i_estado    ,
      @i_num_contrato , @i_cta_cupo , @i_cta_comision , @i_fecha_ven ,
      @s_user         , @s_date     , @s_ofi          , @s_ssn       ,
      @s_term         , @t_trn      )
      
      if @@error <> 0
      begin
         select @w_mensaje = 'ERROR INSERTANDO TRANSACION DE SERVICIO',
                @w_error   = @@error
         goto ERROR
      end
   
   end
   else
   begin
      select @w_mensaje = 'NO EXISTE REGISTROS A MODIFICAR',
             @w_error   = 1
      goto ERROR
   end
end

if @i_operacion = 'S'
begin
   if @i_modo = 0
   begin
      set rowcount 20
      
      select
      'Cod Cobis'       = mc_cod_cb    ,    
      'Cod Red'         = mc_cod_red    ,   
      'Nombre'          = (select of_nombre from cobis..cl_oficina where of_oficina = mc_cod_cb)          ,
      'Nro. Contrato'   = mc_num_contrato  ,
      'Venc. Contrato'  = convert(VARCHAR(10), mc_fecha_ven_con, 103) ,
      'Cuenta'          = mc_cta_banco     ,
      'Cuenta Comision' = mc_cta_comision  ,
      'Estado' = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c
                  where t.tabla = 're_estado_servicio' 
                  and   t.codigo = c.tabla
                  and   c.codigo = mc_estado) ,       
      'Fecha Ing'       = mc_fecha_ing     ,
      'Fecha Mod'       = mc_fecha_mod     ,
      'Usuario'         = mc_usuario    ,
      'Cliente'         = mc_ente         
      from re_mantenimiento_cb
      where mc_cod_cb > @i_corresponsal
      
      if @@rowcount = 0
      begin
         select @w_mensaje = 'NO EXISTEN REGISTROS DE CORRESPONSALES RED POSICIONADA',
                @w_error   = 2609857
         goto ERROR
      end
      
   end
end

return 0

ERROR:
exec cobis..sp_cerror
@t_from      = @w_sp_name,
@i_num       = @w_error,
@i_msg       = @w_mensaje,
@i_sev       = 0

return @w_error
go

