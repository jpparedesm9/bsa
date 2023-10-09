/************************************************************************/
/*   Stored procedure:     sp_envio_sms_cobranza                  	    */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         Alexander Inca	                            */
/*   Fecha de escritura:   Octubre. 2020                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                              PROPOSITO                               */
/* Procedimiento que obtiene la información del cliente para el envío   */
/* del sms																*/
/************************************************************************/
/*                              CAMBIOS                                 */
/*      FECHA         AUTOR         CAMBIO                              */
/*   OCT-14-2020      AIN           Versión incial                      */
/************************************************************************/
use cob_cartera
go

if exists ( select 1 from sysobjects where name = 'sp_envio_sms_cobranza' )
   drop proc sp_envio_sms_cobranza
go

create proc sp_envio_sms_cobranza 
as

declare @w_dia                 int,
        @w_plantilla           varchar (10),
        @w_contador            int,
        @w_cliente             int,
        @w_telefono            varchar(12),
        @w_bloque              varchar(2),
        @w_total_registro      int,
        @w_sp_name             varchar(30),
        @w_error               int,
        @w_msg                 varchar(200)

-- nombre del sp
select @w_sp_name = 'sp_envio_sms_cobranza'

-- Se llama al parametro para la cantidad de envío de sms en cada ejecución 
select @w_total_registro = pa_tinyint 
from cobis..cl_parametro 
where pa_nemonico = 'TRESC'

if @w_total_registro is null
begin
   set @w_total_registro = 30
end

select  @w_contador = count(1) from ca_ns_sms_cobranzas where nsc_estado = 'N'

if @w_contador = 0
begin
   print 'NO EXISTEN REGISTROS A PROCESAR'
   return 1
end

if @w_contador > @w_total_registro
begin
   set @w_contador = @w_total_registro
end

select @w_cliente = 0

while (@w_contador > 0)
begin

    select top 1
    @w_plantilla = nsc_plantilla,	
	@w_cliente   = nsc_cliente,
	@w_telefono  = nsc_num_telf,
	@w_bloque    = nsc_bloque
	from ca_ns_sms_cobranzas
	where nsc_estado = 'N'
	and nsc_cliente > @w_cliente
    order by nsc_cliente
    
    -- contador para salir del while
    select @w_contador = @w_contador - 1
  
    exec @w_error = cobis..sp_despacho_ins
    @i_cliente          = @w_cliente,
    @i_servicio         = 1,--hay que confirmar este valor
    @i_estado           = 'P',
    @i_tipo             = 'SMS',
    @i_tipo_mensaje     = 'I', 
    @i_prioridad        = 1,
    @i_from             = @w_telefono, --número celular del ente cl_telefono
    @i_to               = null,
    @i_cc               = '',
    @i_bcc              = '',
    @i_subject          = 'Envío SMS Cobranzas',
    @i_body             = '',
    @i_content_manager  = 'TEXT',
    @i_retry            = 'N',
    @i_tries            = 0,
    @i_max_tries        = 0,
    @i_template			= '',
    @i_var1             = @w_bloque, -- bloque
    @i_var2             = @w_plantilla, -- plantilla
    @i_var3             = @w_cliente, -- cliente
    @i_var4             = 'S' -- Si valida el buc o no
    
    if @w_error = 0
    begin 
       update ca_ns_sms_cobranzas
       set nsc_estado    = 'S',
           nsc_fecha_env = getdate()
       where nsc_cliente = @w_cliente
       and   nsc_estado  = 'N'
    end
    else
    begin
       update ca_ns_sms_cobranzas
       set nsc_estado    = 'E',
           nsc_fecha_env = getdate()
       where nsc_cliente = @w_cliente
       and   nsc_estado  = 'N'
    end
    
    if @w_error <> 0
    begin
       select @w_msg = 'ERROR AL ENVIAR NOTIFICACION DE LA CODIGO DEL CLIENTE'+convert(varchar(100),@w_cliente),
   	          @w_error = 5000
       goto ERROR1
    end
   	
   	ERROR1:
       print 'ERROR A INSERTAR>> '+convert(varchar(10),@w_error)+' mensaje>>'+@w_msg
       CONTINUAR:
    
    
 
end

return 0

go
