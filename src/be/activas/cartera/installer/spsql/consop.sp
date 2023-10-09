/************************************************************************/
/*   Archivo:              consop.sp                                    */
/*   Stored procedure:     sp_consulta_operaciones                      */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         DFu                                          */
/*   Fecha de escritura:   Julio 2017                                   */
/************************************************************************/
/*                            IMPORTANTE                                */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                            PROPOSITO                                 */
/*   Consulta operaciones para clientes o grupos en base al id del ente,*/
/*   tipo ente (P,S) y corresponsal                                     */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA        AUTOR             RAZON                                */
/*  31/MAY/2019  SRO               Emision inicial                      */
/* 11/Sep/2019   DCU               Req.125021                           */
/* 08/Nov/2019   PXSG              Req.124807                           */
/* 11/Dic/2019   DCU               Inc.131812                           */      
/* 16/Ene/2019   DCU               Inc.126891                           */
/* 03/Mar/2021   SRO               Req #147999                          */
/* 30/May/2022   SRO               Req #204035                          */
/************************************************************************/

use cob_cartera
go

IF OBJECT_ID ('dbo.sp_consulta_operaciones') is not null
	DROP PROCEDURE dbo.sp_consulta_operaciones
GO

CREATE PROCEDURE sp_consulta_operaciones (   
   @s_user                         varchar(30),
   @s_term                         varchar(39),
   @s_date                         datetime,
   @i_operacion                    char(1),
   @i_id_persona_grupo             int,
   @i_tipo                         char(2),
   @i_corresponsal                 varchar(64),
   @i_debug                        char(1) = 'N'   
)
as 

declare
@w_error                    int,
@w_msg                      varchar(255),
@w_est_vigente              int,
@w_est_cancelado            int,
@w_est_vencido              int,
@w_sp_name                  varchar(30),
@w_toperacion               varchar(30),
@w_fecha_proceso            datetime,
@w_monto_sugerido           money,
@w_monto_precancelacion     money,
@w_referencia               varchar(64),
@w_correo                   varchar(255),
@w_id_ult_pago_elavon       int,
@w_operacionca              int,
@w_estado                   char(1),
@w_banco                    cuenta,
@w_fecha_limite_pago        datetime,
@w_saldo_exigible           MONEY,
@w_saldo_precancelar        MONEY,
@w_sp_corresponsal          varchar(50),
@w_id_corresponsal          varchar(50),
@w_banco_grupal             cuenta,
@w_fecha_ult_proceso        datetime,
@w_oficina                  int,
@w_id_ult_pago              varchar(64),
@w_tramite_grupal           int,
@w_nombre_persona_grupo     varchar(255),
@w_desestimiento            int,
@w_producto                 int,
@w_monto_seguro_basico      money,
@w_monto_gar_liquida        money,
@w_promo                    char(1),
@w_fecha_real               datetime,
@w_operacion                int

declare @w_operaciones table(
id_banco                 varchar(64),
tipo_operacion           catalogo,
fecha_inicio             datetime,
fecha_ult_proceso        datetime     null,
monto_max                money        null,
monto_min                money        null,   
referencia               varchar(64)  null,
fecha_limite             datetime     null,
email                    varchar(64)  null,
id_ult_pago              varchar(64)  null,
monto_sugerido           money        null,
monto_pago               money        null,
nombre_persona_grupo     varchar(255) null,
id_operacion             int          null,
oficina                  int          null
)

declare @w_prestamos_grupo table(
operacion          int,
banco              cuenta,
oficina            SMALLINT, 
fecha_ult_proceso  datetime,
cliente            int
)

select @w_sp_name = 'sp_cons_operaciones'

exec @w_error        = sp_estados_cca
@o_est_vigente       = @w_est_vigente   out,
@o_est_vencido       = @w_est_vencido   out,
@o_est_cancelado     = @w_est_cancelado out

if @w_error <> 0 begin
   goto ERROR
end

select @w_producto = pd_producto 
from cobis..cl_producto 
where pd_abreviatura = 'CCA'

--VALIDA MODULO FUERA DE LINEA
if exists(select 1 from cobis..cl_pro_moneda where pm_producto = @w_producto and  pm_estado  <> 'V')
begin
   select @w_error = 6900070
   select @w_msg   = 'PRODUCTO NO HABILITADO'
   goto ERROR   
end

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

select @w_desestimiento = pa_int 
from cobis..cl_parametro 
where pa_nemonico = 'DIPRE'

if @@rowcount = 0 begin
   select
   @w_error = 103203,
   @w_msg   = 'Error el Parámetro DIAS MAXIMO PARA PRECANCELACION no existe'
   goto ERROR

end 

if @i_operacion = 'S' begin --Búsqueda de Operaciones

   if @i_tipo not in ('P','S') begin

      select 
	  @w_error = 103200,
	  @w_msg   = 'Tipo no coincide para un Cliente o Grupo.'
	  goto ERROR
   end   
   else if @i_tipo = 'S' begin
   
      select @w_nombre_persona_grupo = gr_nombre 
	  from cobis..cl_grupo
	  where gr_grupo = @i_id_persona_grupo

      insert into @w_operaciones (id_banco, tipo_operacion)
      select 
      convert(varchar, max(tg_referencia_grupal)),
      op_toperacion
      from cob_credito..cr_tramite_grupal, ca_operacion
      where op_cliente	   = tg_cliente
      and   op_operacion   = tg_operacion
      and   op_estado	   NOT IN (0,3,6,99)
      and   tg_grupo       = @i_id_persona_grupo
	  group by op_toperacion

	  insert into @w_operaciones (id_banco, tipo_operacion)
	  select max(convert(varchar,io_campo_3)),
	  'GARANTIA' 
	  from cob_workflow..wf_inst_proceso
	  where io_campo_1=@i_id_persona_grupo--Nro del grupo
	  and   io_campo_7 = 'S'
	  and   io_campo_4 = 'GRUPAL'
	  and   io_estado='EJE'
	  and   not exists(select 1 from @w_operaciones )
	  
	  /*select
         max(convert(varchar,gl_tramite)),
        'GARANTIA'
        from ca_garantia_liquida
        where gl_pag_estado = 'PC'
        and   gl_grupo      = @i_id_persona_grupo*/

	  
	  delete @w_operaciones where id_banco is null

	  if not exists(select 1 from @w_operaciones) begin
         select 
	     @w_error = 70323,
	     @w_msg   = 'No existen operaciones para el grupo ingresado.'	
	     goto ERROR
      end 

	  select @w_correo  = di_descripcion
      from cobis..cl_cliente_grupo, cobis..cl_direccion 
      where cg_ente     = di_ente
      and   cg_grupo    = @i_id_persona_grupo
      and   cg_rol      = 'P'
      and   cg_estado   = 'V'
      and   di_tipo     = 'CE'	
	  
	  if @@rowcount = 0 begin
	     select @w_correo = ''
	  end
	
	  select @w_banco_grupal = ''
	  while 1= 1 begin
	
         select top 1
         @w_banco_grupal      = id_banco,
         @w_fecha_ult_proceso = fecha_ult_proceso
         from @w_operaciones
         where id_banco    >  @w_banco_grupal
         and tipo_operacion <> 'GARANTIA'
         order by id_banco asc	
         
         if @@rowcount = 0 break

         INSERT into @w_prestamos_grupo
         select op_operacion, op_banco,  op_oficina, op_fecha_ult_proceso, op_cliente     
         from cob_credito..cr_tramite_grupal, cob_cartera..ca_operacion
         where tg_referencia_grupal = @w_banco_grupal 
         and tg_operacion = op_operacion
         and op_estado <>  @w_est_cancelado
	  
         if @@rowcount = 0 or @@error <> 0 begin      
            select 
            @w_error = 70320,
            @w_msg = 'NO EXISTE PRESTAMOS ASOCIADOS A LA  OPERACION GRUPAL: ' + convert(varchar,@w_banco)
           
            goto ERROR        
         end
          
                   
         /* *********** LLEVAR A LA OPERCIONES A LA FECHA VALOR ******************/
         select @w_banco = ''		 
         while 1 = 1 begin
            
            select top 1 @w_banco = banco
            from @w_prestamos_grupo
            where fecha_ult_proceso <> @w_fecha_proceso
            and banco > @w_banco
            order by banco asc
            
            if @@rowcount = 0 break
            
            select  
            @w_oficina = op_oficina             
            from ca_operacion 
            where op_banco = @w_banco
             
            --print 'ingresa a fecha valor :' + @w_banco
            exec @w_error = sp_fecha_valor 
            @s_date        = @s_date,
            @s_user        = @s_user,
            @s_term        = @s_term,
            @t_trn         = 7049,
            @i_fecha_mov   = @s_date,
            @i_fecha_valor = @w_fecha_proceso,
            @i_banco       = @w_banco,
            @i_secuencial  = 1,
            @s_ofi         = @w_oficina,
            @i_operacion   = 'F'
            
            if @w_error <> 0 begin
               select @w_msg = 'ERROR AL EJECUTAR FECHA VALOR: Op Hija' + convert(varchar,@w_banco) + 'Fecha valor: '+convert(varchar,@w_fecha_proceso)+ 'Op Banco: '+convert(varchar,@w_banco)    
            end         
         end
         	 
         select
         @w_saldo_exigible     = isnull(sum(am_cuota - am_pagado),0),
         @w_fecha_limite_pago  = @w_fecha_proceso 
         from  ca_dividendo, ca_amortizacion, @w_prestamos_grupo
         where am_operacion = di_operacion
         and   am_dividendo = di_dividendo
         and   am_operacion = operacion
         and   (di_estado = @w_est_vencido or (di_estado = @w_est_vigente and di_fecha_ven = @w_fecha_proceso))
         
         if @w_saldo_exigible = 0 begin
            select
            @w_saldo_exigible     = isnull(sum(am_cuota - am_pagado),0),
            @w_fecha_limite_pago  = max(di_fecha_ven)
            from  ca_dividendo, ca_amortizacion, @w_prestamos_grupo
            where am_operacion = di_operacion
            and   am_dividendo = di_dividendo
            and   am_operacion = operacion
            and   di_estado    = @w_est_vigente
         end
         
         select @w_saldo_precancelar = isnull(sum(case when am_acumulado + am_gracia> am_pagado then am_acumulado + am_gracia - am_pagado else 0 end),0)
         from  ca_dividendo, ca_amortizacion,@w_prestamos_grupo
         where am_operacion = di_operacion
         and   am_dividendo = di_dividendo
         and   am_operacion = operacion 
         and   di_estado <> @w_est_cancelado
         
         select 
         @w_sp_corresponsal     = co_sp_generacion_ref,
         @w_id_corresponsal     = co_id
         from  ca_corresponsal 
         where co_nombre        = @i_corresponsal
         and   co_estado        = 'A'
         
         if @@rowcount = 0 begin
		    select 
			@w_error = 70209,
			@w_msg   = 'ERROR: EL CORRESPONSAL NO ESTÁ ACTIVO'
            goto ERROR
         end
         
         exec @w_error     = @w_sp_corresponsal
         @i_tipo_tran      = 'PG',
         @i_id_referencia  = @i_id_persona_grupo,
         @i_monto          = null,
         @i_monto_desde    = null,
         @i_monto_hasta    = null,
         @i_fecha_lim_pago = null,	  
         @o_referencia     = @w_referencia out
         
         if @w_error <> 0 begin
            select @w_msg = 'ERROR AL EJECUTAR FECHA VALOR: ' + convert(varchar,@w_banco) + 'Fecha valor: '+convert(varchar,@w_fecha_proceso)
            goto ERROR   
         end  

         select @w_id_ult_pago = isnull(max(co_trn_id_corresp),0)
         from ca_corresponsal_trn, ca_operacion
         where co_codigo_interno = op_operacion
		 and   co_tipo           = 'PG'
         and   co_corresponsal   = @i_corresponsal 
         and   op_cliente        = @i_id_persona_grupo         		 
		 
         update @w_operaciones set 
         monto_max      = @w_saldo_precancelar,
         monto_min      = 0,
         referencia     = @w_referencia,
         fecha_limite   = @w_fecha_limite_pago,
         email          = @w_correo,
         id_ult_pago    = isnull(@w_id_ult_pago,0),
         monto_sugerido = @w_saldo_exigible,
         monto_pago     = @w_saldo_exigible,
         nombre_persona_grupo = @w_nombre_persona_grupo
         where id_banco   = @w_banco_grupal
         and   tipo_operacion <> 'GARANTIA'
         
         if @@error <> 0 begin
            if @i_debug = 'S' begin
               print 'Error: '+ convert(varchar,@@error)
            end
            select @w_msg = 'ERROR: Ocurrió un error al consultar las operaciones del grupo/persona',
            @w_error = 70324
         end  

      end 
      
      select @w_tramite_grupal = 0
      while 1= 1 begin
      
         select top 1
         @w_tramite_grupal    = id_banco
         from @w_operaciones
         where id_banco    >  @w_tramite_grupal
         and tipo_operacion = 'GARANTIA'
         order by id_banco asc	
         
         if @@rowcount = 0 break 
         
           --OBTIENE EL SALDO PENDIENTE DE SEGUROS

          select @w_monto_seguro_basico = sum(case when isnull(se_monto,0) <> 0 and isnull(se_monto,0) > isnull(se_monto_pagado,0) then
                                    isnull(se_monto,0)- isnull(se_monto_pagado,0)
                                    else 0 end)
          from cob_cartera..ca_seguro_externo
          where se_tramite = @w_tramite_grupal
         
         
         select 
         @w_monto_gar_liquida  = isnull(sum(isnull(gl_monto_garantia,0) - isnull(gl_pag_valor,0)),0)--,
        -- @w_fecha_limite_pago = max(gl_fecha_vencimiento)
         from ca_garantia_liquida
         where gl_tramite     = @w_tramite_grupal
         and   gl_pag_estado  = 'PC'
         
         select @w_saldo_exigible=isnull(@w_monto_seguro_basico,0)
         select @w_saldo_exigible=isnull(@w_saldo_exigible,0)+isnull(@w_monto_gar_liquida,0)
         print'@w_tramite_grupal-->'+convert(varchar(50),@w_tramite_grupal)
         print'@w_monto_seguro_basico-->'+convert(varchar(50),@w_monto_seguro_basico)
          print'@w_monto_gar_liquida-->'+convert(varchar(50),@w_monto_gar_liquida)
         
         if @w_saldo_exigible = 0 begin
            select 
            @w_error = 70322,
            @w_msg   = 'No existe garantía líquida para el trámite ingresado.'
            goto ERROR 
         end 
        
         select @w_promo=tr_promocion 
         from cob_credito..cr_tramite
         where tr_tramite= @w_tramite_grupal
         
         print'Promo'+convert(varchar(50),@w_promo)
         
         if(@w_promo='S')
         begin
         
         select @w_fecha_limite_pago= max(se_fecha_ult_intento)
         from cob_cartera..ca_seguro_externo
         where se_tramite = @w_tramite_grupal
         
         end
         else
         begin
         select @w_fecha_limite_pago = max(gl_fecha_vencimiento)
         from ca_garantia_liquida
         where gl_tramite     = @w_tramite_grupal
         and   gl_pag_estado  = 'PC'
         
         end
		 
		 if @w_fecha_limite_pago < @w_fecha_proceso begin
		    update ca_garantia_liquida set
			gl_fecha_vencimiento = @w_fecha_proceso
			where gl_tramite     = @w_tramite_grupal
            and   gl_pag_estado  = 'PC'
			
            update cob_cartera..ca_seguro_externo set
			se_fecha_ult_intento = @w_fecha_proceso,
			se_usuario           = @s_user,
			se_terminal          = @s_term
			where se_tramite     = @w_tramite_grupal

			select @w_fecha_limite_pago = @w_fecha_proceso
		 
		 end 
         
         select 
         @w_sp_corresponsal     = co_sp_generacion_ref,
         @w_id_corresponsal     = co_id
         from  ca_corresponsal 
         where co_nombre        = @i_corresponsal
         and   co_estado        = 'A'
         
         if @@rowcount = 0 begin
		    select 
			@w_error = 70209,			
			@w_msg   = 'ERROR: EL CORRESPONSAL NO ESTÁ ACTIVO'
            goto ERROR
         end
	     
	     exec @w_error     = @w_sp_corresponsal
         @i_tipo_tran      = 'GL',
         @i_id_referencia  = @i_id_persona_grupo,
         @i_monto          = @w_saldo_exigible,
         @i_monto_desde    = null,
         @i_monto_hasta    = null,
         @i_fecha_lim_pago = @w_fecha_limite_pago,	  
         @o_referencia     = @w_referencia out
         
         if @w_error <> 0 begin
            select @w_msg = 'ERROR AL EJECUTAR FECHA VALOR: ' + convert(varchar,@w_banco) + 'Fecha valor: '+convert(varchar,@w_fecha_proceso)
            goto ERROR   
         end 
         
         select @w_id_ult_pago = isnull(max(co_trn_id_corresp),0)
         from ca_corresponsal_trn
         where co_tipo = 'GL'
         and co_corresponsal = @i_corresponsal 
         and co_codigo_interno = @i_id_persona_grupo
        
         update @w_operaciones set 
         monto_max      = @w_saldo_exigible,
         monto_min      = @w_saldo_exigible,
         referencia     = @w_referencia,
         fecha_limite   = @w_fecha_limite_pago,
         email          = @w_correo,
         id_ult_pago    = isnull(@w_id_ult_pago,0),
         monto_sugerido = @w_saldo_exigible,
         monto_pago     = @w_saldo_exigible,
         nombre_persona_grupo = @w_nombre_persona_grupo
         where id_banco   = @w_tramite_grupal
         and   tipo_operacion = 'GARANTIA'

         if @@error <> 0 begin
            if @i_debug = 'S' begin
               print 'Error: '+ convert(varchar,@@error)
            end
            select @w_msg = 'ERROR: Ocurrió un error al consultar las operaciones del grupo/persona',
            @w_error = 70324
         end   
      end   
  
   end   
   else if @i_tipo = 'P' begin  

      select 
      @w_nombre_persona_grupo = isnull(en_nombre,'') + ' ' + isnull(p_s_nombre,'') + ' ' + isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido, '')
      from cobis..cl_ente
      where en_ente = @i_id_persona_grupo	  
      
      insert into @w_operaciones (id_operacion, id_banco, tipo_operacion, fecha_inicio, oficina)
      select
	  op_operacion,
      convert(varchar, op_banco),
      op_toperacion,
      op_fecha_ini,
	  op_oficina
      from ca_operacion
      where op_estado	  NOT IN (0, 3,99)
      and   op_cliente    = @i_id_persona_grupo            
      
      
      delete @w_operaciones
      where tipo_operacion = 'GRUPAL'
      and datediff(dd, fecha_inicio, @w_fecha_proceso) > @w_desestimiento
      

      if not exists( select 1 from @w_operaciones) begin 
         select 
         @w_error = 70323,
         @w_msg   = 'No existen operaciones para el cliente ingresado.'	
         goto ERROR
      end 

      select @w_correo  = di_descripcion
      from  cobis..cl_direccion 
      where di_ente    = @i_id_persona_grupo
      and   di_tipo     = 'CE'	
      
      if @@rowcount = 0 begin 
         select @w_correo = ''
      end 
      
      
      select @w_banco = ''
      while 1= 1 begin 

         select top 1
         @w_banco             = id_banco,
		 @w_operacion         = id_operacion,
         @w_fecha_ult_proceso = fecha_ult_proceso,
		 @w_oficina           = oficina
         from @w_operaciones
         where id_banco    >  @w_banco
         order by id_banco asc	
         
         if @@rowcount = 0 break
         
         
         if @w_fecha_ult_proceso <> @w_fecha_proceso begin	    

            exec @w_error = sp_fecha_valor 
            @s_date        = @s_date,
            @s_user        = @s_user,
            @s_term        = @s_term,
            @t_trn         = 7049,
            @i_fecha_mov   = @s_date,
            @i_fecha_valor = @w_fecha_proceso,
            @i_banco       = @w_banco,
            @i_secuencial  = 1,
            @s_ofi         = @w_oficina,
            @i_operacion   = 'F'
            
            if @w_error <> 0 begin 
               select
               @w_msg = 'ERROR AL EJECUTAR FECHA VALOR: Op Hija' + convert(varchar,@w_operacion) + 'Fecha valor: '+convert(varchar,@w_fecha_proceso)+ 'Op Banco: '+convert(varchar,@w_banco)
            end
         end

         select
         @w_saldo_exigible     = isnull(sum(am_cuota - am_pagado),0),
         @w_fecha_limite_pago  = @w_fecha_proceso
         from  ca_dividendo, ca_amortizacion
         where am_operacion = di_operacion
         and   am_dividendo = di_dividendo
         and   am_operacion = @w_operacion
         and   (di_estado = @w_est_vencido or (di_estado = @w_est_vigente and di_fecha_ven = @w_fecha_proceso))
         
         if @w_saldo_exigible = 0 begin
            select
            @w_saldo_exigible     = isnull(sum(am_cuota - am_pagado),0),
            @w_fecha_limite_pago  = max(di_fecha_ven)
            from  ca_dividendo, ca_amortizacion
            where am_operacion = di_operacion
            and   am_dividendo = di_dividendo
            and   am_operacion = @w_operacion
            and   di_estado = @w_est_vigente
         end
         
         select 
         @w_saldo_precancelar = isnull(sum(case when am_acumulado + am_gracia> am_pagado then am_acumulado + am_gracia - am_pagado else 0 end),0)
         from  ca_dividendo, ca_amortizacion
         where am_operacion = di_operacion
         and   am_dividendo = di_dividendo
         and   am_operacion = @w_operacion 
         and   di_estado <> @w_est_cancelado
		 
		 select @w_fecha_real = max(co_fecha_real) 
		 from ca_corresponsal_trn 
		 where co_codigo_interno = @w_operacion
		 
		 select @w_id_ult_pago = isnull(max(co_trn_id_corresp),0)
         from  ca_corresponsal_trn a
         where co_codigo_interno = @w_operacion
         and   co_tipo           = 'PI'
         and   co_corresponsal   = @i_corresponsal 
         and   co_fecha_real     = @w_fecha_real
         
         select 
         @w_sp_corresponsal     = co_sp_generacion_ref,
         @w_id_corresponsal     = co_id
         from  ca_corresponsal 
         where co_nombre        = @i_corresponsal
         and   co_estado        = 'A'
         
         if @@rowcount = 0 begin
		    select 
		    @w_error = 70209, 
			@w_msg   = 'ERROR: EL CORRESPONSAL NO ESTÁ ACTIVO'
            goto ERROR
         end
         
         exec @w_error     = @w_sp_corresponsal
         @i_tipo_tran      = 'PI',
         @i_id_referencia  = @w_operacion,
         @i_monto          = null,
         @i_monto_desde    = null,
         @i_monto_hasta    = null,
         @i_fecha_lim_pago = null,	  
         @o_referencia     = @w_referencia out
         
         if @w_error <> 0 begin
            select @w_msg = 'ERROR AL EJECUTAR FECHA VALOR: ' + convert(varchar,@w_banco) + 'Fecha valor: '+convert(varchar,@w_fecha_proceso)
            goto ERROR   
         end 
         
         update @w_operaciones set 
         monto_max            = @w_saldo_precancelar,
         monto_min            = 0,
         referencia           = @w_referencia,
         fecha_limite         = @w_fecha_limite_pago,
         email                = @w_correo,
         id_ult_pago          = isnull(@w_id_ult_pago,0),
         monto_sugerido       = @w_saldo_exigible,
         monto_pago           = @w_saldo_exigible,
         nombre_persona_grupo = @w_nombre_persona_grupo
         where id_banco   = @w_banco
         
         if @@error <> 0 begin
            if @i_debug = 'S' begin
               print 'Error: '+ convert(varchar,@@error)
            end
            select @w_msg = 'ERROR: Ocurrió un error al consultar las operaciones del grupo/persona',
            @w_error = 70324
         end 
      end 

   end 
   
    
   select 
   "id_banco"      = id_banco,     
   "TIPO_OPERACION"    = tipo_operacion,  
   "MONTO_PAGO"        = CASE WHEN tipo_operacion = 'GRUPAL' AND @i_tipo = 'P' THEN monto_max ELSE monto_pago END,
   "MONTO_MAXIMO"      = monto_max,        
   "MONTO_MINIMO"      = CASE WHEN tipo_operacion = 'GRUPAL' AND @i_tipo = 'P' THEN monto_max ELSE monto_min END,        
   "REFERENCIA"        = referencia,       
   "FECHA_LIMITE_PAGO" = fecha_limite,     
   "CORREO"            = email,            
   "ID_ULT_PAGO"       = id_ult_pago,
   "MONTO_SUGERIDO"    = CASE WHEN tipo_operacion = 'GRUPAL' AND @i_tipo = 'P' THEN monto_max ELSE monto_sugerido END,
   "NOMBRE"            = nombre_persona_grupo
   from @w_operaciones
   
  
end

return 0
ERROR:
begin --Devolver mensaje de Error 
exec cobis..sp_cerror
     @t_debug = 'N',
     @t_file  = '',
     @t_from  = @w_sp_name,
     @i_num   = @w_error
	 
return @w_error
end
go