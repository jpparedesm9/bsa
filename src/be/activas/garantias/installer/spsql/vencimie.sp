/************************************************************************/
/*  Archivo:                vencimie.sp                                 */
/*  Stored procedure:       sp_vencimiento                              */
/*  Base de datos:          cob_custodia                                */
/*  Producto:               garantias                                   */
/*  Disenado por:           Rodrigo Garces                              */
/*                          Luis Alfredo Castellanos                    */
/*  Fecha de escritura:     Junio-1995                                  */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Este programa procesa las transacciones de:                         */
/*      Ingreso / Modificacion / Eliminacion / Consulta y Busqueda de   */
/*  los Vencimientos de una Garantia                                    */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*  FECHA           AUTOR               RAZON                           */
/*  Jun/1995                            Emision Inicial                 */
/*  Jun/13/1997     Fernndo Patino L    Valor a recuperar               */
/*  Nov/30/2000     Milena Gonzalez emg Adicion cu_ente para aceptante  */
/************************************************************************/
use cob_custodia
go

set ansi_nulls off
go

if exists (select 1 from sysobjects where name = 'sp_vencimiento')
    drop proc sp_vencimiento
go
create proc sp_vencimiento (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_corr               char(1)  = null,
   @s_ssn_corr           int      = null,
   @s_ofi                smallint  = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_filial             tinyint  = null,
   @i_sucursal           smallint  = null,
   @i_tipo_cust          descripcion  = null,
   @i_custodia           int  = null,
   @i_vencimiento        smallint  = null,
   @i_fecha              datetime  = null,
   @i_valor              float = null,      
   @i_instruccion        varchar(255)  = null,
   @i_sujeto_cobro       char(  1)  = null,
   @i_num_factura        varchar( 20)  = null,
   @i_cta_debito         ctacliente  = null,
   @i_mora               money = 0,
   @i_comision           money = null,
   @i_formato_fecha      int     = null,   --PGA 16/06/2000
   @i_cond1              descripcion = null,
   @i_cond2              descripcion = null,
   @i_cond3              descripcion = null,
   @i_cond4              descripcion = null,
   @i_cond5              descripcion = null,
   @i_param1             descripcion = null,
   @i_estado_colateral   char(1) = null,
   @i_fecha_salida       datetime = null,
   @i_fecha_retorno      datetime = null,
   @i_destino_colateral  catalogo = null,
   @i_segmento           catalogo = null,
   @i_login              varchar(30) = null,
   @i_colateral          char(1)     = null,
   @i_beneficiario       varchar(64) = null,
   @i_emisor             varchar(64) = null, 
   @i_fecha_emision      datetime    = null, 
   @i_tasa               varchar(10) = null, 
   @i_temporal           smallint = null,
   @i_carga              smallint = null,
   @i_ente               int      = null --emg
)
as

declare
   @w_today                 datetime,     /* fecha del dia */ 
   @w_return                int,          /* valor que retorna */
   @w_sp_name               varchar(32),  /* nombre stored proc*/
   @w_existe                tinyint,      /* existe el registro*/
   @w_filial                tinyint,
   @w_sucursal              smallint,
   @w_tipo_cust             descripcion,
   @w_custodia              int,
   @w_secservicio           int,
   @w_secservicio1          int,
   @w_vencimiento           smallint,
   @w_fecha                 datetime,
   @w_valor                 float,  
   @w_instruccion           varchar(255),
   @w_mensaje               varchar(255),
   @w_sujeto_cobro          char(  1),
   @w_num_factura           varchar( 20),
   @w_cta_debito            ctacliente,
   @w_ultimo                smallint,
   @w_error                 int,
   @w_mora                  money,
   @w_comision              money,
   @w_monto_comision        money,
   @w_diferencia            float,      
   @w_diferencia1           money,
   @w_des_tipo              descripcion,
   @w_total_vencimiento     money,
   @w_total_mora            money, 
   @w_total_comision        money,
   @w_suma_ven              float,          
   @w_suma_rec              money,
   @w_codigo_externo        varchar(64),
   @w_estado_colateral      char(1),
   @w_estado                char(1),
   @w_fecha_salida          datetime,
   @w_fecha_retorno         datetime,
   @w_destino_colateral     catalogo,
   @w_segmento              catalogo,
   @w_des_estado_col        varchar(30),  
   @w_des_destino_col       varchar(30),  
   @w_des_segmento          varchar(30),
   @w_moneda                tinyint,
   @w_status                int,
   @w_valor_actual          float,      
   @w_estado_gar            char(1),
   @w_contabilizar          char(1),
   @w_beneficiario          varchar(64),
   @w_tot_recup             money ,
   @w_emisor                varchar(64), 
   @w_fecha_emision         datetime,    
   @w_tasa                  varchar(10), 
   @w_temporal              smallint,
   @w_valor_vencimiento_tot float,     
   @w_ente                  int           --emg

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_vencimiento'

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' and @i_operacion <> 'A' and 
   @i_operacion <> 'L' and @i_operacion <> 'T'
begin
   select 
   @w_filial            = vt_filial,
   @w_sucursal          = vt_sucursal,
   @w_tipo_cust         = vt_tipo_cust,
   @w_custodia          = vt_custodia,
   @w_vencimiento       = vt_vencimiento,
   @w_fecha             = vt_fecha,
   @w_valor             = vt_valor,
   @w_instruccion       = vt_instruccion,
   @w_sujeto_cobro      = vt_sujeto_cobro,
   @w_num_factura       = vt_num_factura,
   @w_cta_debito        = vt_cta_debito,
   @w_mora              = vt_mora,
   @w_comision          = vt_comision,
   @w_codigo_externo    = vt_codigo_externo,
   @w_estado_colateral  = vt_estado_colateral,
   @w_fecha_salida      = vt_fecha_salida,
   @w_fecha_retorno     = vt_fecha_retorno,
   @w_destino_colateral = vt_destino_colateral,
   @w_segmento          = vt_segmento,
   @w_beneficiario      = vt_beneficiario ,
   @w_emisor            = vt_emisor,
   @w_fecha_emision     = vt_fecha_emision,
   @w_tasa              = vt_tasa,
   @w_ente              = vt_ente
   from cob_custodia..cu_vencimiento_tmp
   where 
   vt_filial      = @i_filial and
   vt_sucursal    = @i_sucursal and
   vt_tipo_cust   = @i_tipo_cust and
   vt_custodia    = @i_custodia and
   vt_vencimiento = @i_vencimiento

   if @@rowcount > 0
      select @w_existe = 1
   else
      select @w_existe = 0
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
   exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,
        @w_codigo_externo out

   select @w_estado_gar = cu_estado
   from cu_custodia
   where cu_codigo_externo = @w_codigo_externo 

   if @w_estado_gar = 'C' or @w_estado_gar = 'A' --Cancelado
   begin 
        /* No puede registrar vencimientos de una garantia cancelada */
        select @w_error   = 1905010
        goto ERROR 
   end 
    
   /* Control del valor total de vencimientos, sin incluir el actual  */

   select @w_suma_ven = isnull(sum(vt_valor),0)        
   from   cu_vencimiento_tmp
   where  vt_codigo_externo = @w_codigo_externo 
   and    vt_vencimiento <> @i_vencimiento

   select @w_suma_rec = isnull(sum(re_valor),0)        
   from   cu_recuperacion
   where  re_codigo_externo = @w_codigo_externo 
   and    re_vencimiento <> @i_vencimiento

   select @w_diferencia = isnull(cu_valor_inicial,0) - 
                          (@w_suma_ven-@w_suma_rec) - @i_valor   
   from   cu_custodia   
   where  cu_codigo_externo = @w_codigo_externo 

   if @w_diferencia < 0
   begin 
   /* Valor de la diferencia debe ser positiva */
      select @w_error   = 1903004
      goto ERROR 
   end  
   if @i_fecha < @s_date 
   begin 
   /* La fecha de vencimiento debe ser mayor o igual a la fecha actual */
      select @w_error   = 1903007
      goto ERROR 
   end 
    
   if @i_filial    is NULL or 
      @i_sucursal  is NULL or 
      @i_tipo_cust is NULL or 
      @i_custodia  is NULL or 
      @i_valor     is NULL 
   begin
      /* Campos NOT NULL con valores nulos */
      select @w_error   = 1901001
      goto ERROR 
   end
end

/* Insercion del registro */
/**************************/

if @i_operacion = 'I'
begin
   if @w_existe = 1
   begin
      /* Registro ya existe */
      select @w_error   = 1901002
      goto ERROR 
   end
      -- PGA 18may2001
       select @w_secservicio = @@spid

   begin tran
      select @w_ultimo = isnull(max(vt_vencimiento),0)+1
      from   cu_vencimiento_tmp
      where  vt_filial = @i_filial 
      and    vt_sucursal  = @i_sucursal
      and    vt_tipo_cust = @i_tipo_cust
      and    vt_custodia  = @i_custodia

      exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,
                      @w_codigo_externo out

 
      insert into cu_vencimiento_tmp (
      vt_filial,        vt_sucursal,       vt_tipo_cust,
      vt_custodia,      vt_vencimiento,    vt_fecha,
      vt_valor,         vt_instruccion,    vt_sujeto_cobro,
      vt_num_factura,   vt_cta_debito,     vt_mora,
      vt_comision,      vt_codigo_externo, vt_estado_colateral,
      vt_fecha_salida,  vt_fecha_retorno,  vt_destino_colateral,
      vt_segmento,      vt_beneficiario,   vt_emisor,   --NVR-BE
      vt_fecha_emision, vt_tasa,           vt_sesion, vt_ente)      --NVR-BE
      values (
      @i_filial,        @i_sucursal,       @i_tipo_cust,
      @i_custodia,      @w_ultimo,         @i_fecha,
      @i_valor,         @i_instruccion,    @i_sujeto_cobro,
      @i_num_factura,   @i_cta_debito,     @i_mora,
      @w_monto_comision,@w_codigo_externo, @i_estado_colateral,
      @i_fecha_salida,  @i_fecha_retorno,  @i_destino_colateral,
      @i_segmento,      @i_beneficiario,   @i_emisor,   --NVR-BE
      @i_fecha_emision, @i_tasa,           @s_ssn, @i_ente)

      if @@error <> 0 
      begin
         /* Error en insercion de registro */
         select @w_error   = 1903001
         goto ERROR 
      end

      /* Transaccion de Servicio */
      /***************************/


      insert into ts_vencimiento
      values (@w_secservicio,@t_trn,'N',
      @s_date,@s_user,@s_term,
      @s_ofi,'cu_vencimiento',
      @i_filial, @i_sucursal, @i_tipo_cust,
      @i_custodia, @i_vencimiento, @i_fecha,
      @i_valor, @i_instruccion, @i_sujeto_cobro,
      @i_num_factura, @i_cta_debito, @i_mora,
      @i_comision, @w_codigo_externo, @i_estado_colateral,
      @i_fecha_salida, @i_fecha_retorno, @i_destino_colateral,
      @i_segmento,@i_ente)

      if @@error <> 0 
      begin
         /* Error en insercion de transaccion de servicio */
         select @w_error   = 1903003
         goto ERROR 
      end
      select @w_ultimo
   commit tran 
   return 0
end

/* Actualizacion del registro */
/******************************/

if @i_operacion = 'U'
begin
   if @w_existe = 0
   begin
   /* Registro a actualizar no existe */
      select @w_error   = 1905002
      goto ERROR 
   end

   --Aumentado por LCA
   if exists(select 1 from cu_recuperacion
             where  re_codigo_externo = @w_codigo_externo
             and    re_vencimiento    = @i_vencimiento)
   begin
   /* Ya tiene recuperaciones */
      select @w_error   = 1907008
      goto ERROR 
   end

   --Aumentado por LCA
      -- PGA 18may2001
   select @w_secservicio = @@spid
   exec @w_secservicio1 = sp_gensec     
   begin tran
      update cob_custodia..cu_vencimiento_tmp
      set 
      vt_fecha             = @i_fecha,
      vt_valor             = @i_valor,
      vt_instruccion       = @i_instruccion,
      vt_sujeto_cobro      = @i_sujeto_cobro,
      vt_num_factura       = @i_num_factura,
      vt_cta_debito        = @i_cta_debito,
      vt_mora              = @i_mora,
      vt_comision          = @w_comision,
      vt_codigo_externo    = @w_codigo_externo,
      vt_estado_colateral  = @i_estado_colateral,
      vt_fecha_salida      = @i_fecha_salida,
      vt_fecha_retorno     = @i_fecha_retorno,
      vt_destino_colateral = @i_destino_colateral,
      vt_segmento          = @i_segmento,
      vt_beneficiario      = @i_beneficiario,
      vt_emisor            = @i_emisor, --NVR-BE
      vt_fecha_emision     = @i_fecha_emision, --NVR-BE
      vt_tasa              = @i_tasa,    --NVR-BE
      vt_sesion            = @s_ssn,
      vt_ente              = @w_ente --emg
      where 
      vt_filial      = @i_filial and
      vt_sucursal    = @i_sucursal and
      vt_tipo_cust   = @i_tipo_cust and
      vt_custodia    = @i_custodia and
      vt_vencimiento = @i_vencimiento

      if @@error <> 0 
      begin
         /* Error en actualizacion de registro */
         select @w_error   = 1905001
         goto ERROR 
      end

      /* Transaccion de Servicio */
      /***************************/

      insert into ts_vencimiento
      values (@w_secservicio,@t_trn,'P',
      @s_date,@s_user,@s_term,
      @s_ofi,'cu_vencimiento',
      @w_filial, @w_sucursal, @w_tipo_cust,
      @w_custodia, @w_vencimiento, @w_fecha,
      @w_valor, @w_instruccion, @w_sujeto_cobro,
      @w_num_factura, @w_cta_debito, @w_mora,
      @w_comision, @w_codigo_externo, @w_estado_colateral,
      @w_fecha_salida, @w_fecha_retorno, @w_destino_colateral,
      @w_segmento,@w_ente)

      if @@error <> 0 
      begin
         /* Error en insercion de transaccion de servicio */
         select @w_error   = 1903003
         goto ERROR 
      end

      /* Transaccion de Servicio */
      /***************************/
       -- PGA 18may2001
       exec @w_secservicio = sp_gen_sec
            @i_garantia    = @w_codigo_externo

      insert into ts_vencimiento
      values (@w_secservicio1,@t_trn,'A',
      @s_date,@s_user,@s_term,
      @s_ofi,'cu_vencimiento',
      @i_filial, @i_sucursal, @i_tipo_cust,
      @i_custodia, @i_vencimiento, @i_fecha,
      @i_valor, @i_instruccion, @i_sujeto_cobro,
      @i_num_factura, @i_cta_debito, @i_mora,
      @i_comision, @w_codigo_externo, @i_estado_colateral,
      @i_fecha_salida, @i_fecha_retorno, @i_destino_colateral,
      @i_segmento,@w_ente)

      if @@error <> 0 
      begin
         /* Error en insercion de transaccion de servicio */
         select @w_error   = 1903003
         goto ERROR 
      end
   commit tran
   return 0
end

/* Eliminacion de registros */
/****************************/

if @i_operacion = 'D'
begin
   if @w_existe = 0
   begin
   /* Registro a eliminar no existe */
      select @w_error   = 1907002
      goto ERROR 
   end

   /***** Integridad Referencial *****/
   /*****                        *****/
   /* CONTROLAR QUE NO SE ELIMINEN VENCIMIENTOS CON RECUPERACIONES */
   if exists (select 1 from cu_recuperacion
              where re_filial      = @i_filial and
                    re_sucursal    = @i_sucursal and
                    re_tipo_cust   = @i_tipo_cust and
                    re_custodia    = @i_custodia and
                    re_vencimiento = @i_vencimiento)
      return 2   -- No se puede eliminar
   else
   begin
       -- PGA 18may2001
       select @w_secservicio = @@spid

      begin tran
         delete cob_custodia..cu_vencimiento_tmp
         where 
         vt_filial      = @i_filial and
         vt_sucursal    = @i_sucursal and
         vt_tipo_cust   = @i_tipo_cust and
         vt_custodia    = @i_custodia and
         vt_vencimiento = @i_vencimiento 
                                        
         if @@error <> 0
         begin
         /*Error en eliminacion de registro */
            select @w_error   = 1907001
            goto ERROR 
         end

         /* Transaccion de Servicio */
         /***************************/
         insert into ts_vencimiento
         values (@w_secservicio,@t_trn,'B',
         @s_date,@s_user,@s_term,
         @s_ofi,'cu_vencimiento',
         @w_filial, @w_sucursal, @w_tipo_cust,
         @w_custodia, @w_vencimiento, @w_fecha,
         @w_valor, @w_instruccion, @w_sujeto_cobro,
         @w_num_factura, @w_cta_debito, @w_mora, 
         @w_comision, @w_codigo_externo, @w_estado_colateral,
         @w_fecha_salida, @w_fecha_retorno, @w_destino_colateral,
         @w_segmento,@w_ente)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
            select @w_error   = 1903003
            goto ERROR 
         end
      commit tran
      return 0
   end
end

/* Consulta opcion QUERY */
/*************************/


if @i_operacion = 'Q'
begin
   if @w_existe = 1
   begin 
      select @w_des_estado_col = A.valor
      from cobis..cl_catalogo A,cobis..cl_tabla B
      where B.codigo = A.tabla and
      B.tabla = 'cu_estado_colateral' and
      A.codigo = @w_estado_colateral

      select @w_des_destino_col = A.valor
      from cobis..cl_catalogo A,cobis..cl_tabla B
      where B.codigo = A.tabla and
      B.tabla = 'cu_destino_colateral' and
      A.codigo = @w_destino_colateral

      select @w_des_segmento = A.valor
      from cobis..cl_catalogo A,cobis..cl_tabla B
      where B.codigo = A.tabla and
      B.tabla = 'cu_segmento' and
      A.codigo = @w_segmento

      select @w_des_tipo = tc_descripcion
      from cu_tipo_custodia
      where tc_tipo = @w_tipo_cust

      select @w_total_vencimiento = sum(re_valor),
      @w_total_mora        = sum(re_cobro_mora),
      @w_total_comision    = sum(re_cobro_comision)
      from cu_recuperacion
      where re_filial      = @i_filial
      and re_sucursal    = @i_sucursal
      and re_tipo_cust   = @i_tipo_cust
      and re_custodia    = @i_custodia 
      and re_vencimiento = @i_vencimiento

      select 
      @w_filial,
      @w_sucursal,
      @w_tipo_cust,
      @w_des_tipo,
      @w_custodia,
      @w_vencimiento,
      convert(char(10),@w_fecha,@i_formato_fecha),
      @w_valor,
      @w_instruccion,
      @w_num_factura, -- 10
      isnull(@w_total_vencimiento,0),
      @w_total_mora,
      @w_total_comision,  
      @w_estado_colateral, -- 14
      @w_des_estado_col,
      @w_destino_colateral,
      @w_des_destino_col,
      @w_segmento, 
      @w_des_segmento,
      convert(char(10),@w_fecha_salida,@i_formato_fecha),
      convert(char(10),@w_fecha_retorno,@i_formato_fecha),
      @w_beneficiario,  -- 22
      @w_emisor,    
      convert(char(10),@w_fecha_emision,@i_formato_fecha),
      @w_tasa,      --25
      @w_ente           
   end 
   else
   begin
   /*Registro no existe */
      select @w_error   = 1901005
      goto ERROR 
   end
   return 0
end

if @i_operacion = 'S'
begin

   set rowcount 20
   select
   'NRO.'              = vt_vencimiento,
   'FECHA VENCIMIENTO' = convert(char(10),vt_fecha,@i_formato_fecha),
   'VALOR DOCUMENTO'   = convert(money,vt_valor),
   'VALOR RECUPERADO'  = convert(money,isnull(sum(re_valor),0)),
   'VALOR A RECUPERAR' = convert(money,vt_valor - isnull(sum(re_valor),0)),
   'No. DOCUMENTO'     = vt_num_factura,  --MVI 07/08/96
   'BENEFICIARIO'      = substring(vt_beneficiario,1,40),
   'ACEPTANTE' = vt_ente
   from cu_recuperacion
   right outer join cu_vencimiento_tmp 
   on re_codigo_externo  = vt_codigo_externo
   and re_vencimiento    = vt_vencimiento
   where vt_filial          = @i_filial
   and vt_sucursal        = @i_sucursal
   and vt_tipo_cust       = @i_tipo_cust
   and vt_custodia        = @i_custodia      
   and (vt_vencimiento > @i_vencimiento
   or @i_vencimiento is null)
   group by vt_vencimiento,vt_fecha,vt_valor,vt_num_factura,vt_beneficiario, vt_ente
   order by vt_vencimiento,vt_fecha,vt_valor,vt_num_factura
        
   if @@rowcount = 0
   begin
      if @i_vencimiento is null  
         select @w_error  = 1901003
      else
         select @w_error  = 1901004
      goto ERROR
   end 
end 


/***********************************************************************/
if @i_operacion = 'A'
begin
   set rowcount 20
   select 
   'VENCIMIENTO' = vt_vencimiento,
   'FECHA'       = convert(char(10),vt_fecha,convert(int,@i_cond5)),
   'VALOR'       = vt_valor,  --MVI 07/09/96
   'BENFICIARIO' = vt_beneficiario
   from  cu_vencimiento_tmp
   where vt_filial     = convert(tinyint,@i_cond1)
   and   vt_sucursal   = convert(smallint,@i_cond2)
   and   vt_tipo_cust  = @i_cond3
   and   vt_custodia   = convert(int,@i_cond4)
   and   (vt_vencimiento > convert(tinyint,@i_param1) or @i_param1 is null)
   
   if @@rowcount = 0
      begin
      if @i_param1 is null
      begin
         select @w_error = 1901003
      end
      else
         select @w_error = 1901004
      goto ERROR 
   end
end 

if @i_operacion = 'V'
begin

   select @w_tot_recup = isnull(sum(re_valor),0)
   from   cu_recuperacion
   where  re_codigo_externo = @w_codigo_externo
   and    re_vencimiento =  @i_vencimiento

   select convert(char(10), ve_fecha, @i_formato_fecha),
   ve_valor,    --MVI 07/09/96
   ve_beneficiario,
   'Saldo a Recuperar' = ve_valor-@w_tot_recup
   from cu_vencimiento
   where ve_filial      = @i_filial
   and   ve_sucursal    = @i_sucursal
   and   ve_tipo_cust   = @i_tipo_cust
   and   ve_custodia    = @i_custodia
   and   ve_vencimiento = @i_vencimiento

   if @@rowcount = 0
   begin
      select @w_error   = 1901005
      goto ERROR 
   end
end

if @i_operacion = 'Z'
begin
   /* Control del valor total de vencimientos  */
   select @w_diferencia = cu_valor_inicial - @i_valor
   from   cu_custodia
   where  cu_filial   = @i_filial 
   and    cu_sucursal = @i_sucursal 
   and    cu_tipo     = @i_tipo_cust
   and    cu_custodia = @i_custodia

   select @w_diferencia1 = @w_diferencia - isnull(sum(vt_valor),0) 
   from cu_vencimiento_tmp
   where vt_filial    = @i_filial 
   and   vt_sucursal  = @i_sucursal 
   and   vt_tipo_cust = @i_tipo_cust
   and   vt_custodia  = @i_custodia 
   and   (vt_vencimiento <> @i_vencimiento or @i_vencimiento is null)
  
   if @w_diferencia1 < 0
   begin 
      /* Valor de la diferencia debe ser positiva 
      select  @w_error   = 1903004  */
      goto ERROR 
   end
   return 0
end    

if (@i_operacion = 'L')
begin
   exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,
   @w_codigo_externo out
   if @i_carga = 0 
   begin
      if exists(select 1 from cu_vencimiento_tmp
                where vt_codigo_externo = @w_codigo_externo)
         select @w_temporal = 0
      else
      begin
         if exists(select 1 from cu_vencimiento
                   where ve_codigo_externo = @w_codigo_externo)
         begin
            begin tran
            insert into cu_vencimiento_tmp(
            vt_filial,vt_sucursal,vt_tipo_cust,
            vt_custodia,vt_vencimiento,vt_fecha,
            vt_valor,vt_instruccion,vt_sujeto_cobro,
            vt_num_factura ,vt_cta_debito,vt_mora,
            vt_comision ,vt_codigo_externo ,vt_estado_colateral,
            vt_fecha_salida,vt_fecha_retorno,vt_destino_colateral,
            vt_segmento ,vt_procesado,vt_cotizacion,
            vt_beneficiario,vt_emisor,vt_fecha_emision,
            vt_tasa,vt_ente)
            select 
            ve_filial,ve_sucursal,ve_tipo_cust,
            ve_custodia,ve_vencimiento,ve_fecha,
            ve_valor,ve_instruccion,ve_sujeto_cobro,
            ve_num_factura ,ve_cta_debito,ve_mora,
            ve_comision ,ve_codigo_externo ,ve_estado_colateral,
            ve_fecha_salida,ve_fecha_retorno,ve_destino_colateral,
            ve_segmento ,ve_procesado,ve_cotizacion,
            ve_beneficiario,ve_emisor,ve_fecha_emision,
            ve_tasa,ve_ente
            from   cu_vencimiento
            where  ve_codigo_externo = @w_codigo_externo
            if @@error <> 0
            begin
               print 'No es posible consultar los vencimientos de esta garantia'
               return 1
            end
            select @w_temporal = 1
            commit tran
         end
         else
            select @w_temporal = 0
      end
      begin
         begin tran 
         update cu_vencimiento_tmp
         set    vt_sesion = @s_ssn
         where  vt_codigo_externo = @w_codigo_externo
         if @@error <> 0
         begin
            print 'No es posible consultar los vencimientos de esta garantia'
            return 1
         end
         commit tran
      end
   end
   if @i_carga = 1
   begin
      if @i_temporal = 1
      begin
         begin tran
         delete cu_vencimiento_tmp
         where  vt_codigo_externo = @w_codigo_externo
         commit tran
      end
      else
      begin
         begin tran
         update cu_vencimiento_tmp
         set vt_sesion = null
         where vt_codigo_externo = @w_codigo_externo
         commit tran
      end
   end
   select  @w_temporal
end

if (@i_operacion = 'T')
begin
   exec sp_externo @i_filial,@i_sucursal,@i_tipo_cust,@i_custodia,
   @w_codigo_externo out



   select  @w_valor_actual = isnull(cu_valor_inicial,0)*isnull(cv_valor,1)
   from cu_custodia,cob_conta..cb_vcotizacion
   where cu_codigo_externo = @w_codigo_externo
   and   cv_moneda         = cu_moneda
   and   cv_fecha          in (select max(cv_fecha)
                               from  cob_conta..cb_vcotizacion,cu_custodia
                               where cv_fecha <=  @w_today
                               and   cv_moneda = cu_moneda)
   if @w_valor_actual is null
      select @w_valor_actual = 0
    

   if  @w_valor_actual = 0
   begin
      /* Campos NOT NULL con valores nulos */
      select @w_error   = 1901017
      goto ERROR
   end

   select @w_valor_vencimiento_tot = sum(isnull(vt_valor,0)*isnull(cv_valor,1))
   from cu_vencimiento_tmp,    -- PGA 30AGO2000
        cu_custodia,
        cob_conta..cb_vcotizacion
   where cu_codigo_externo = @w_codigo_externo
     and vt_codigo_externo = @w_codigo_externo
     and cv_moneda         = cu_moneda
     and cv_fecha          in (select max(cv_fecha)
                               from  cob_conta..cb_vcotizacion,cu_custodia
                               where cv_fecha <=  @w_today
                               and   cv_moneda = cu_moneda)
   
   if @w_valor_vencimiento_tot is null
   begin
      /* Campos NOT NULL con valores nulos */
      select @w_error   = 1901017
      goto ERROR
   end
    

   -- Si suma de las vencimientos es igual al valor actual
   -- inserta las vencimientos en la tabla cu_vencimiento  --MVG
   begin tran
      if @w_valor_vencimiento_tot = @w_valor_actual
      begin
         if exists (select 1
                    from   cu_vencimiento
                    where  ve_codigo_externo = @w_codigo_externo)
            delete cu_vencimiento
            where  ve_codigo_externo = @w_codigo_externo

         insert into cu_vencimiento
         select 
         vt_filial,vt_sucursal,vt_tipo_cust,
         vt_custodia,vt_vencimiento,vt_fecha,
         vt_valor,vt_instruccion,vt_sujeto_cobro,
         vt_num_factura ,vt_cta_debito,vt_mora,
         vt_comision ,vt_codigo_externo ,vt_estado_colateral,
         vt_fecha_salida,vt_fecha_retorno,vt_destino_colateral,
         vt_segmento ,vt_procesado,vt_cotizacion,
         vt_beneficiario,vt_emisor,vt_fecha_emision,
         vt_tasa,vt_ente
         from   cu_vencimiento_tmp
         where  vt_codigo_externo = @w_codigo_externo
        if @@error <> 0 
        begin
           /*Error en insercion del registro */ 
           exec cobis..sp_cerror
           @t_from  = @w_sp_name,
           @i_num   = 1903001
           return 1 
        end 

         delete cu_vencimiento_tmp
         where  vt_codigo_externo = @w_codigo_externo
         if @@error <> 0
         begin           
           /*Error en eliminacion del registro */ 
           exec cobis..sp_cerror
           @t_from  = @w_sp_name,
           @i_num   = 1907001
           return 1 
         end
      end
      else
      begin
         if exists (select 1
                    from   cu_vencimiento
                    where  ve_codigo_externo = @w_codigo_externo)
         begin
            select @w_mensaje = 'No es igual al valor actual'
            select @w_mensaje = @w_mensaje + ' de la garantia, no se hicieron'
            select @w_mensaje = @w_mensaje + ' las modificaciones '            
            print @w_mensaje
            delete cu_vencimiento_tmp
            where  vt_codigo_externo = @w_codigo_externo
         end
         else
         begin
            update cu_vencimiento_tmp
            set vt_sesion = null
            where vt_codigo_externo = @w_codigo_externo            
            select @w_mensaje = 'El total de vencimientos no es igual al valor'
            select @w_mensaje = @w_mensaje + ' actual de la garantia'
            print @w_mensaje
         end
      end

   commit   tran
end
return 0
ERROR:    /* Rutina que dispara sp_cerror dado el codigo de error */
   exec cobis..sp_cerror
   @t_from  = @w_sp_name,
   @i_num   = @w_error
   return 1
go
