/************************************************************************/
/*    Base de datos:            cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           Sonia Rojas                             */
/*      Fecha de escritura:     13/09/2017                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA'.                                                       */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                         PROPOSITO                                    */
/*      Tiene como propósito procesar los pagos de los corresponsales   */
/************************************************************************/
/*                        MOFICACIONES                                  */
/*   FECHA       AUTOR                     RAZON                        */
/* 24/07/2018    SRO    Validaciones referencias OXXO                   */
/* 06/11/2019    SRO    Mejora 129659                                   */
/* 05/02/2020    ACH    Caso#134843(133012)no valide la ofi             */
/* 16/06/2022    ACH    REQ#185234,se agrega opcion GI y reemp de nombre*/
/************************************************************************/  
use cob_cartera
go


if exists(select 1 from sysobjects where name ='sp_oxxo_val_ref')
	drop proc sp_oxxo_val_ref
GO


CREATE proc sp_oxxo_val_ref(
    @s_ssn              int                = null,
    @s_user             login              = null,
    @s_sesn             int                = null,
    @s_term             varchar(30)        = null,
    @s_date             datetime           = null,
    @s_srv              varchar(30)        = null,
    @s_lsrv             varchar(30)        = null,
    @s_ofi              smallint           = null,
    @s_servicio         int                = null,
    @s_cliente          int                = null,
    @s_rol              smallint           = null,
    @s_culture          varchar(10)        = null,
    @s_org              char(1)            = null,
    @i_referencia       varchar(255)       = null, -- Obligatorio 
	@i_fecha_pago       varchar(8)         = null, -- Fecha de Pago
    @i_monto_pago       varchar(14)        = null, -- Monto de Pago
    @i_archivo_pago     varchar(255),              -- Archivo de Pago, opcional
	@o_tipo             char(2)            out,    -- Tipo de transacción (G,C,P)
    @o_codigo_interno   varchar(10)        out,    -- Código interno
    @o_fecha_pago       datetime           out,    -- Fecha de pago
    @o_monto_pago       money              out,     -- Monto de pago
    @o_tipo_tran        char(2)            = null   out
)
as
declare 
@w_sp_name                 varchar(30),
@w_tipo_tran               char(2),            -- Obligatorio si operacion = 'G', (GL) Garantia Líquida, (PG) Préstamo Grupal, (PI) Préstamo Individual, 
                                               -- (CG)Cancelacción de Crédito Grupal, (CI)Cancelación de Crédito Individual, (GI) Garantia Líquida individual
@w_codigo_int              int,
@w_error                   int,
@w_msg                     varchar(255),
@w_tipo_tran_corresp       varchar(4),
@w_oficina                 int, --TEMPORAL 129499
@w_tramite                 int  --TEMPORAL 129499--porCaso#185234
   
select @w_sp_name  = 'sp_oxxo_val_ref'

if len (@i_referencia) <> 14
begin
   select @w_error=70204
   goto ERROR_FIN	
end


select @w_tipo_tran_corresp = substring(@i_referencia,3,2) 

select @w_tipo_tran =  ctr_tipo_cobis from cob_cartera..ca_corresponsal_tipo_ref 
where ctr_co_id = (select co_id from cob_cartera..ca_corresponsal where co_nombre = 'OXXO')
and   ctr_tipo  = @w_tipo_tran_corresp

if @@rowcount = 0 
begin
    select @w_tipo_tran = case when @w_tipo_tran_corresp in ('GL','00') then 'GL'                      
                               when @w_tipo_tran_corresp in ('PG','01','20') then 'PG' -- '20' se anade por caso 115813
                               when @w_tipo_tran_corresp in ('CG','02') then 'CG'
                               when @w_tipo_tran_corresp in ('PI','03') then 'PI'
						       when @w_tipo_tran_corresp in ('PR','04') then 'CI'
                               when @w_tipo_tran_corresp in ('GI','11') then 'GI' --porCaso#185234							   
                               else @w_tipo_tran_corresp 
                          end
end

if  @w_tipo_tran <> 'GL'
and @w_tipo_tran <> 'PG'
and @w_tipo_tran <> 'PI'
and @w_tipo_tran <> 'CG'
and @w_tipo_tran <> 'CI'
and @w_tipo_tran <> 'GI' begin --porCaso#185234
   select @w_error = 70204,
          @w_msg   = 'ERROR: TIPO DE TRANSACCIÓN NO VÁLIDA'
   goto ERROR_FIN
end


select @o_tipo_tran  = @w_tipo_tran
select @w_codigo_int = substring(@i_referencia,5,9)
select @i_monto_pago = isnull(@i_monto_pago,0)

--INICIO MODIFICACION TEMPORAL 129499. Validación Pago por Sucursal
if @w_tipo_tran in ('GL', 'PG', 'CG') begin
   select @w_oficina = gr_sucursal 
   from cobis..cl_grupo
   where gr_grupo    = convert(int,@w_codigo_int)
   
   if not exists (select 1 from cobis..cl_oficina where of_oficina = @w_oficina) begin
      select @w_tramite = max(tg_tramite)
	  from cob_credito..cr_tramite_grupal
	  where tg_grupo     = convert(int, @w_codigo_int)
	  
	  select @w_oficina = op_oficina
	  from cob_cartera..ca_operacion 
	  where op_tramite = @w_tramite 
	  
   end

/* se comenta por el caso #133012 se pasa en #134096
   if not exists (select 1 from ca_corresponsal_oficina where co_oficina_id = @w_oficina) begin
      select 
      @w_error = 70214,
      @w_msg   = 'ERROR: LA SUCURSAL A LA QUE PERTENECE EL GRUPO NO ACEPTA PAGOS DE OXXO'
      goto ERROR_FIN	
   end 

   end else if @w_tipo_tran in ('PI', 'CI')  begin

   select @w_oficina   = op_oficina
   from   cob_cartera..ca_operacion 
   where  op_operacion = convert(int,@w_codigo_int)
      
   if not exists (select 1 from ca_corresponsal_oficina where co_oficina_id = @w_oficina) begin
      select 
      @w_error = 70215,
      @w_msg   = 'ERROR: LA SUCURSAL A LA QUE PERTENECE EL CLIENTE NO ACEPTA PAGOS DE OXXO'
      goto ERROR_FIN
   end	*/
    	  
end

if @w_tipo_tran in ('GI') begin
   select @w_oficina = en_oficial 
   from cobis..cl_ente
   where en_ente    = convert(int,@w_codigo_int)
   
   if not exists (select 1 from cobis..cl_oficina where of_oficina = @w_oficina) begin
      select @w_tramite = max(tr_tramite)
	  from cob_credito..cr_tramite
	  where tr_cliente     = convert(int, @w_codigo_int)
	  and tr_toperacion = 'INDIVIDUAL'
	  
	  select @w_oficina = op_oficina
	  from cob_cartera..ca_operacion 
	  where op_tramite = @w_tramite  
	  
   end	  
end

--FIN MODIFICACION TEMPORAL 129499. Validación Pago por Sucursal

--print 'fecha que se envia a validar_pagos '+@i_fecha_pago

exec @w_error    = sp_validar_pagos
@i_referencia    = @i_referencia,   
@i_fecha_pago    = @i_fecha_pago,
@i_monto_pago    = @i_monto_pago,
@i_archivo_pago  = @i_archivo_pago,
@i_tipo          = @w_tipo_tran,
@i_codigo_int    = @w_codigo_int,
@o_tipo          = @o_tipo           out ,
@o_codigo_int    = @o_codigo_interno out,
@o_monto_pago    = @o_monto_pago     out ,
@o_fecha_pago    = @o_fecha_pago     out 

if @w_error <> 0 begin
   select @w_error = @w_error,
          @w_msg = 'ERROR AL VALIDAR LA REFERENCIA SANTANDER'	  
   goto ERROR_FIN
end

-- Para que no utilice el valor que devuelve el sp_validar_pagos (*.*/100)
select @o_monto_pago = @i_monto_pago

return 0

ERROR_FIN:

/*exec cobis..sp_cerror 
    @t_from = @w_sp_name, 
    @i_num  = @w_error, 
    @i_msg  = @w_msg*/
return @w_error

go