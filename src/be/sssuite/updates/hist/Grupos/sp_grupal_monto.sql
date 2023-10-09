use cob_credito
go
if exists(select 1 from sysobjects where name = 'sp_grupal_monto')
    drop proc sp_grupal_monto
go

create proc sp_grupal_monto (
@i_operacion char(1),
@i_grupo     int         = null,
@i_tramite   int         = null,
@i_ente      int         = null,
@i_monto     money       = 0,
@s_ssn       int         = null,
@s_sesn      int         = null,
@s_ofi       smallint    = null,
@s_rol       smallint    = null,
@s_user      login       = null,
@s_date      datetime    = null,
@s_term      descripcion = null--,
--@s_org       char(1)     = null,
--@s_culture   varchar(30) = null
)
as
declare
   @w_operacionca            int,
   @w_fecha_ini              datetime,
   @w_fecha_fin              datetime,
   @w_fecha_liq              datetime,
   @w_monto                  money,   
   @w_moneda                 tinyint,
   @w_oficina                smallint,   
   @w_banco                  cuenta, 
   @w_cliente                int,        
   @w_nombre                 descripcion,
   @w_estado                 smallint,
   @w_op_direccion           tinyint,
   @w_lin_credito            cuenta,
   @w_tipo_amortizacion      catalogo,
   @w_cuota                  MONEY,
   @w_periodo_cap            int,   
   @w_periodo_int            int,
   @w_base_calculo           char(1),
   @w_dias_anio              smallint,    
   @w_plazo                  tinyint,      
   @w_tplazo                 char(1),
   @w_plazo_no_vigente       tinyint,   
   @w_min_fecha_vig          datetime,
   @w_est_novigente          smallint,
   @w_formato_fecha          int,
   @w_return                 int

select @w_est_novigente = 0,  
       @w_formato_fecha = 101
	   
-- validaciones para Insercion y Modificacion
if @i_operacion = 'I' or @i_operacion = 'U'
begin
    if @i_tramite is null or @i_ente is null or @i_monto is null or @i_monto < 0 or @i_grupo is null
    begin
        return 2101001 --CAMPOS NOT NULL CON VALORES NULOS
    end
end

if @i_operacion = 'I' -- Insertar el valor de la solicitud de un cliente del tramite del grupo
begin
    if exists(select 1 from cr_tramite_grupal where tg_tramite = @i_tramite and tg_cliente    = @i_ente)
    begin
        return 2101002  -- REGISTRO YA EXISTE
    end
    insert into cr_tramite_grupal (tg_tramite, tg_cliente, tg_monto, tg_grupal, tg_grupo )
    values (@i_tramite, @i_ente, @i_monto, 'S', @i_grupo)

    if @@error <> 0
    begin
        return 150000 -- ERROR EN INSERCION
    end
    return 0
end

if @i_operacion = 'U'  -- Modificar el valor de la solicitud de un cliente del tramite del grupo
begin
    declare @w_suma_montos money
    update cr_tramite_grupal 
	set    tg_monto = @i_monto
    where  tg_tramite = @i_tramite
    and    tg_cliente   = @i_ente

	select @w_suma_montos = sum(tg_monto)
    from   cob_credito..cr_tramite_grupal
    where  tg_tramite = @i_tramite
	
	update cob_credito..cr_tramite
	set    tr_monto = @w_suma_montos,
	       tr_monto_solicitado = @w_suma_montos
	where  tr_tramite = @i_tramite

	-- Inicio Se copia de sp_pasa_cartera_interciclo porque los datos no quedaban consistentes
    select @w_operacionca       = op_operacion,
           @w_fecha_liq         = convert(varchar(10),op_fecha_liq,@w_formato_fecha),
           @w_moneda            = op_moneda,
           @w_fecha_ini         = convert(varchar(10),op_fecha_ini,@w_formato_fecha),
           @w_fecha_fin         = convert(varchar(10),op_fecha_fin,@w_formato_fecha),
           @w_oficina           = op_oficina,
           @w_banco             = op_banco,
           @w_cliente           = op_cliente,
           @w_nombre            = op_nombre,
           @w_estado            = op_estado,
           @w_op_direccion      = op_direccion,
           @w_lin_credito       = op_lin_credito,
           @w_tipo_amortizacion = op_tipo_amortizacion,
           @w_cuota             = op_cuota,
           @w_periodo_cap       = op_periodo_cap,
           @w_periodo_int       = op_periodo_int,
           @w_base_calculo      = op_base_calculo,
           @w_dias_anio         = op_dias_anio,
           -- LGU-ini  se comenta para obtenerlo en el primer select de la operacion
           --@w_ah_cta_banco      = op_cuenta, -- tomar el numero de cuenta
           --@w_monto_gar_grupal  = op_monto * @w_porc_gar_grupal / 100,
           @w_plazo             = op_plazo,
           @w_tplazo            = op_tplazo
           -- LGU-ini  se comenta para obtenerlo en el primer select de la operacion
    from  cob_cartera..ca_operacion
    where op_tramite = @i_tramite

	select @w_plazo_no_vigente = count(1) - 1,
	       @w_min_fecha_vig    = convert(varchar(10),min(di_fecha_ini),@w_formato_fecha)
	from  cob_cartera..ca_dividendo
	where di_operacion = @w_operacionca --@w_tg_operacion
	and   di_estado    = @w_est_novigente
	   
	-- BORRAR TEMPORALES
	exec @w_return = cob_cartera..sp_borrar_tmp
	     @i_banco  = @w_banco,
	     @s_user   = @s_user,
	     @s_term   = @s_term
	
	if @w_return <> 0
	   return @w_return
		
	---PASAR A TEMPRALES CON LOS ULTIMOS DATOS
	exec @w_return          = cob_cartera..sp_pasotmp
	     @s_term            = @s_term,
	     @s_user            = @s_user,
	     @i_banco           = @w_banco,
	     @i_operacionca     = 'S',
	     @i_dividendo       = 'S',
	     @i_amortizacion    = 'S',
	     @i_cuota_adicional = 'S',
	     @i_rubro_op        = 'S',
	     @i_nomina          = 'S'
	
	if @w_return <> 0
	   return @w_return
		
	exec @w_return = cob_cartera..sp_modificar_operacion
	     @s_user                  =  @s_user,
	     @s_term                  =  @s_term,
	     @s_date                  =  @s_date,
	     @s_ofi                   =  @s_ofi,
	     @i_operacionca           =  @w_operacionca,
	     @i_banco                 =  @w_banco,
	     @i_fecha_ini             =  @w_min_fecha_vig,
	     @i_monto                 =  @w_suma_montos,
	     @i_monto_aprobado        =  @w_suma_montos,
	     @i_plazo                 =  @w_plazo_no_vigente,
	     @i_cuota                 =  0,
	     @i_tipo_amortizacion     =  @w_tipo_amortizacion,
	     @i_periodo_cap           =  @w_periodo_cap,
	     @i_periodo_int           =  @w_periodo_int,
	     @i_dias_anio             =  @w_dias_anio,
	     @i_base_calculo          =  @w_base_calculo,
	     @i_gracia_cap            =  0,
	     @i_gracia_int            =  0,
	     @i_tplazo                =  @w_tplazo,
	     @i_tdividendo            =  @w_tplazo,
	     @i_calcular_tabla        =  'S'
	
	if @w_return <> 0
	   return @w_return
	
	exec @w_return          = cob_cartera..sp_pasodef
	     @i_banco           = @w_banco,
	     @i_operacionca     = 'S',
	     @i_dividendo       = 'S',
	     @i_amortizacion    = 'S',
	     @i_cuota_adicional = 'S',
	     @i_rubro_op        = 'S',
	     @i_relacion_ptmo   = 'S',
	     @i_nomina          = 'S',
	     @i_acciones        = 'S',
	     @i_valores         = 'S'
	     
	if @w_return <> 0
	   return @w_return 
	-- Fin Se copia de sp_pasa_cartera_interciclo
    return 0
end

if @i_operacion = 'D' -- Eliminar un cliente del tramite del grupo
begin

    if not exists(select 1 from cr_tramite_grupal where tg_tramite = @i_tramite and tg_cliente    = @i_ente)
    begin
        return 105506  --  NO EXISTEN REGISTROS
    end

    delete cr_tramite_grupal
    where tg_tramite = @i_tramite
      and tg_cliente    = @i_ente

    if @@error <> 0
    begin
        return 150004 -- ERROR EN ELIMINACION
    end

    return 0
end

if @i_operacion = 'Q' -- consulta: valores de la solicitud de los integrantes del grupo
begin
    if exists( select 1 from cr_tramite_grupal tg where tg_tramite = @i_tramite )
    begin
        select
            'cliente' = tg_cliente,
            'nombre'  = (select en_nomlar from cobis..cl_ente where en_ente = tg.tg_cliente),
            'monto'   =  tg_monto,
            'cuenta'  = (SELECT ea_cta_banco FROM cobis..cl_ente_aux WHERE ea_ente=tg.tg_cliente )
        from cr_tramite_grupal tg
        where tg_tramite = @i_tramite

        return 0
    end
    else
    begin
        select @i_operacion = 'G'
    end
end


if @i_operacion = 'G' -- consulta de los miembros del grupo que van a solicitar el prestamo
begin

    select
        'cliente' = cg_ente,
        'nombre' = (select en_nomlar from cobis..cl_ente where en_ente = cg.cg_ente),
        'monto'  = 0
    from cobis..cl_grupo, cobis..cl_cliente_grupo cg
    where gr_grupo = @i_grupo
    and gr_grupo = cg_grupo

	insert into cr_tramite_grupal (tg_tramite, tg_cliente, tg_monto, tg_grupal, tg_grupo )
	select
		@i_tramite,
		cg_ente,
		0,
		'S',
		@i_grupo
	from cobis..cl_grupo, cobis..cl_cliente_grupo cg
	where gr_grupo = @i_grupo
	and gr_grupo = cg_grupo

	if @@error <> 0
	begin
		return 150000 -- ERROR EN INSERCION
	end


    return 0
end

return 0
go
