/************************************************************************/
/*   Archivo:             conciliar_corresponsal_qry.sp                 */
/*   Stored procedure:    sp_conciliar_corresponsal_qry            		*/
/*   Base de datos:       cob_cartera                                   */
/*   Producto:            Cartera                                       */
/*   Disenado por:        Raymundo Picazo                               */
/*   Fecha de escritura:  Abr.09.                                       */
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
/*   Etracion de informacion de los diferentescorresponsales para       */
/*    para obtener una consiliacion                                     */
/************************************************************************/
/*                               MODIFICACIONES                         */
/*  FECHA              AUTOR            CAMBIO                          */
/*  MAR-2019       Raymundo Picazo                                      */
/*                                                                      */
/*  JUN-2019       M. Taco          Validacion de fechas                */
/************************************************************************/
use cob_conta_super
go
 

IF OBJECT_ID ('dbo.sp_conciliar_corresponsal_qry') IS NOT NULL
	DROP PROCEDURE dbo.sp_conciliar_corresponsal_qry
GO

CREATE proc sp_conciliar_corresponsal_qry (
	@i_corresponsal     varchar(25)    = NULL, 
	@i_tipo_trn         varchar(10)    = NULL,
	@i_fecha_desde      datetime       = NULL,
    @i_fecha_hasta      datetime       = NULL,
	@i_id_trn_corresp   int            = NULL,
	@i_cliente          int            = NULL,
	@i_grupo            int            = NULL,
	@i_estado_conci     char(1)        = NULL,
    @s_user             login          = NULL,
	@i_razon_conci      char(1)        = NULL,
	@i_co_estado_trn    char(2)        = NULL,
    @i_siguiente        int            = 0,
	@i_accion			char(1)		   = 'Q' -- Accion Query, S -- Accion Fecha
)

AS

declare
@w_return			      int,
@w_error			      int,
@w_mensaje                varchar(150),
@w_sp_name                varchar(64),
@w_msg                    varchar(255),
@w_opcion                 int,
@w_fecha_proceso		  datetime


--MTA Validar que el rango de fechas no sea mayor a 1 dia
IF datediff(dd,@i_fecha_desde,@i_fecha_hasta) > 1 --por ahora se define 1 dia
BEGIN
   select 
   @w_msg  = 'RANGO DE FECHAS EXCEDEN EL MAXIMO DE DIAS PERMITIDOS PARA LA CONSULTA',
   @w_error = 357560
   goto ERROR_FIN  
END

if @i_fecha_hasta is not null
begin
	select @i_fecha_hasta = dateadd(HOUR,23,@i_fecha_hasta)
    select @i_fecha_hasta = dateadd(MINUTE,59,@i_fecha_hasta)
end

if @i_accion <> 'S' begin

	declare @w_trn_corresponsal table (id_trn_corresp     int)

	-- CAPTURA NOMBRE DE STORED PROCEDURE
	select 
	@w_sp_name = 'sp_conciliar_corresponsal_qry',
	@w_opcion = 1000

	if @i_tipo_trn = 'TO'
	   select @i_tipo_trn = NULL   
   
	if @i_estado_conci = 'T'
	   select @i_estado_conci = NULL

	if @i_co_estado_trn = 'T'
	   select @i_co_estado_trn = NULL
	   
	if @i_razon_conci = 'T'
	    select @i_razon_conci = NULL

	if @i_corresponsal       is not null  select @w_opcion = 11
	if @i_tipo_trn           is not null  select @w_opcion = 10
	if @i_estado_conci       is not null  select @w_opcion = 9
	if @i_co_estado_trn      is not null  select @w_opcion = 8
	if @i_fecha_hasta        is not null  select @w_opcion = 7
	if @i_fecha_desde        is not null  select @w_opcion = 6
	if @i_fecha_desde        is not null and @i_fecha_hasta is not null select @w_opcion = 5
	if @i_razon_conci        is not null  select @w_opcion = 4
	if @i_grupo              is not null  select @w_opcion = 3   
	if @i_cliente            is not null  select @w_opcion = 2   
	if @i_id_trn_corresp     is not null  select @w_opcion = 1

	if @w_opcion = 1000 begin --ESTO ES PARA QUE SIEMPRE HAYA UN CAMPO PRIMARIO 
    
		select 
		@w_msg  = 'ERROR- PARA BUSCAR INGRESE YA SEA: El Correspnsal, El Cliente, El Grupo, La Referencia, Una Fecha, ',
		@w_error   = 708199

		goto ERROR_FIN 

	end

	-- BUSQUEDAS DE NUMERO DE OPERACIONES
	if @w_opcion = 1 begin --por transaccion cobis
		  insert into @w_trn_corresponsal
		  select distinct co_id_trn_corresp
		  from sb_conciliacion_corresponsal
		  where co_id_trn_corresp = @i_id_trn_corresp
	end  

	if @w_opcion = 2 begin --por cliente
		  insert into @w_trn_corresponsal
		  select distinct co_id_trn_corresp
		  from sb_conciliacion_corresponsal
		  where co_cliente = @i_cliente
	end  

	if @w_opcion = 3 begin --por grupo
		  insert into @w_trn_corresponsal
		  select distinct co_id_trn_corresp
		  from sb_conciliacion_corresponsal
		  where co_grupo = @i_grupo
	end  

	if @w_opcion = 4 begin --por raon conciliacion
		  insert into @w_trn_corresponsal
		  select distinct co_id_trn_corresp
		  from sb_conciliacion_corresponsal
		  where co_razon_no_conci = @i_razon_conci
	end	

	if @w_opcion = 5 begin --por tipo transaccion
		  insert into @w_trn_corresponsal
		  select distinct co_id_trn_corresp
		  from sb_conciliacion_corresponsal
		  where co_fecha_registro BETWEEN @i_fecha_desde AND @i_fecha_hasta
	end  
  
	if @w_opcion = 6 begin --por tipo transaccion
		  insert into @w_trn_corresponsal
		  select distinct co_id_trn_corresp
		  from sb_conciliacion_corresponsal
		  where co_fecha_registro >= @i_fecha_desde 
	end  


	if @w_opcion = 7 begin --por tipo transaccion
		  insert into @w_trn_corresponsal
		  select distinct co_id_trn_corresp
		  from sb_conciliacion_corresponsal
		  where co_fecha_registro <= @i_fecha_hasta 
	end  


	if @w_opcion = 8 begin -- por estado trn
		  insert into @w_trn_corresponsal
		  select distinct co_id_trn_corresp
		  from sb_conciliacion_corresponsal
		  where co_estado_trn = @i_co_estado_trn   
	end  

	if @w_opcion = 9 begin -- por estado trn
		  insert into @w_trn_corresponsal
		  select distinct co_id_trn_corresp
		  from sb_conciliacion_corresponsal
		  where co_estado_conci = @i_estado_conci   
	end  

	if @w_opcion = 10 begin --por tipo transaccion
		  insert into @w_trn_corresponsal
		  select distinct co_id_trn_corresp
		  from sb_conciliacion_corresponsal
		  where co_tipo_trn = @i_tipo_trn
	end  

	if @w_opcion = 11 begin --por corresponsal
		  insert into @w_trn_corresponsal
		  select distinct co_id_trn_corresp
		  from sb_conciliacion_corresponsal
		  where co_corresponsal = @i_corresponsal
		  --select *from @w_trn_corresponsal
	end  

	-- LIMPIAR TABLA TEMPORAL
	delete sb_conciliacion_corresponsal_temp where  co_usuario = @s_user

	insert into sb_conciliacion_corresponsal_temp
	select 
	co_corresponsal,       
	co_id,  
	co_relacionados,
	@s_user,           
	co_id_trn_corresp,     
	co_id_cobis_trn, 
	co_tipo_trn,           
	co_referencia_pago,
	co_fecha_registro,     
	co_usuario_trn,
	co_fecha_valor,        
	co_monto,
	co_reverso,            
	co_trn_reverso,  
	co_cliente,            
	co_grupo,
	co_estado_trn,         
	co_estado_conci,  
	co_usuario_conci,
	co_razon_no_conci, 
	co_fecha_conci,
	co_accion_conci,
	co_observaciones
	from   sb_conciliacion_corresponsal, @w_trn_corresponsal
	where co_id_trn_corresp   = id_trn_corresp

	-- query de busqueda 
	select 
	'Id'                     =  co_id, 
	'Corresponsal'           =  co_corresponsal,
	'Referencia'             =  co_referencia_pago,
	'trn_corresponsal'       =  co_id_trn_corresp,
	'Tipo_trn'               =  co_tipo_trn,
	'Cliente / Grupo'        =  case 
								   when isnull(co_cliente, 0) != 0 THEN co_cliente
								   when isnull(co_grupo, 0)   != 0 THEN co_grupo
								   else 0
								end,--co_grupo
	'Nombre'                 =  case 
								   when isnull(co_cliente, 0) != 0 THEN (select en_nomlar from cobis..cl_ente  where en_ente = co_cliente)
								   when isnull(co_grupo, 0)   != 0 THEN (select gr_nombre from cobis..cl_grupo where gr_grupo = co_grupo)
								   else ''
								end,
	'Reverso'                =  case when co_reverso = 'S' then 'SI' else 'NO' end,
	'Fecha Registro'         =  co_fecha_registro,
	'Fecha Valor'            =  co_fecha_valor,
	'Usuario_trn'            =  co_usuario_trn,
	'Estado COBIS'           =  rtrim(co_estado_trn), -- (Procesado / Pendiente /Anulado / Reversado / Error )
	'Conciliado'             =  co_estado_conci, --(Si/No)
	'Causa'                  =  co_razon_no_conci, --(Huerfano COBIS / Huerfano Archivo)
	'Usuario'                =  co_usuario_conci,
	'Fecha Conciliacion'    =   co_fecha_conci,
	'Accion'                 =  co_accion_conci, --(aclarado / aplicado / reversado).
	'Observacion'            =  co_observaciones,
	'Secuencial'             =  co_secuencial,
	'Relacionados'			 =  co_relacionados
	from   sb_conciliacion_corresponsal_temp
	where  co_usuario          =  @s_user
	and    (co_corresponsal    =  @i_corresponsal     or @i_corresponsal         is null)
	and    (co_id_trn_corresp  =  @i_id_trn_corresp   or @i_id_trn_corresp       is null)
	and    (co_tipo_trn        =  @i_tipo_trn         or @i_tipo_trn             is null)
	and    (co_cliente         =  @i_cliente          or @i_cliente              is null)
	and    (co_grupo           =  @i_grupo            or @i_grupo                is null)
	and    (co_razon_no_conci  =  @i_razon_conci      or @i_razon_conci          is null)
	and    (co_estado_trn      =  @i_co_estado_trn    or @i_co_estado_trn        is null)
	and    (co_estado_conci    =  @i_estado_conci     or @i_estado_conci         is null)
	and    (co_fecha_registro  >= @i_fecha_desde      or @i_fecha_desde          is null)
	and    (co_fecha_registro  <= @i_fecha_hasta      or @i_fecha_hasta          is null)
	and    co_id > isnull(@i_siguiente, 0)
	order  by co_fecha_registro

	if @@rowcount = 0 begin
	   select @w_error = 1
	   select @w_msg   = 'NO EXISTEN MAS REGISTROS'
	  -- set rowcount 0
	   goto ERROR_FIN
	end
end 

if @i_accion = 'S' begin
	select @w_fecha_proceso = fp_fecha
	from cobis..ba_fecha_proceso
	
	select
	'Fecha Registro' = isnull(min(co_fecha_registro), @w_fecha_proceso)
	from sb_conciliacion_corresponsal 
	where co_estado_conci = 'N'
end

return 0

ERROR_FIN:

exec cobis..sp_cerror 
@t_debug = 'N', 
@t_file  = null,
@t_from  = @w_sp_name,
@i_num   = @w_error,
@i_msg   = @w_msg

return @w_error

