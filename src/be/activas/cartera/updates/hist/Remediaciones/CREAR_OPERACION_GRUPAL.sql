use cob_cartera
go

set nocount off

declare @s_ssn              integer,
        @w_return           integer,
        @w_tramite_0        int,
        @w_operacion_0      int,
        @w_op_banco_0       cuenta,
        @w_monto_0          money,
        @w_fecha            datetime,
        @w_cliente          int,
        @w_toperacion       catalogo,
        @w_tasa             float,
        @w_banco_generado   cuenta,
        @w_nom_cliente      varchar(254)


select  @s_ssn = max(secuencial) + 1 from cob_credito..ts_tramite
select  @w_tramite_0 = max(tr_tramite) +1 from cob_credito..cr_tramite 
update cobis..cl_seqnos set siguiente = @w_tramite_0 where tabla = 'cr_tramite'



/********************** AQUI COLOCAR LOS PARAMETROS DE ENTRADA *************************************************************************/
select @w_monto_0    = 258900,  -- Aqui colocar el monto del prestamo
       @w_cliente    = 1,       -- Aqui colocar el codigo de cliente COBIS
       --@w_tasa     = 30,      -- Aqui colocar la tasa de interes (GRUPAL = 60%, INDIVIDUAL = 96%, INTERCICLO = 72%)
                                -- El parametro de la tasa es OPCIONAL (DESCOMENTAR SI SE REQUIERE INGRESAR LA TASA CASO CONTRARIO TOMARA LA DEL PRIODUCTO) 
       @w_toperacion = 'GRUPAL',-- Aqui colocar el tipo de operacion (GRUPAL, INDIVIDUAL, INTERCICLO)
       @w_fecha      = null     -- Fecha Inicial para fecha valor (Formato mm/dd/yyyy
/***************************************************************************************************************************************/



if @w_fecha is null
   select @w_fecha = fp_fecha from cobis..ba_fecha_proceso

select @w_nom_cliente = en_nomlar
from cobis..cl_ente
where en_ente =  @w_cliente

select @s_ssn = @s_ssn + 1000
    
exec cob_credito..sp_tramite_cca 
     @s_ssn                =  @s_ssn,
     @s_user               = 'admuser',
     @s_sesn               = @s_ssn, 
     @s_term               = 'pc-jta',
     @s_date               = @w_fecha, 
     @s_srv                = 'pc-jta',
     @s_lsrv               = 'pc-jta',
     @s_ofi                = 1,
     @t_trn                = 21020,
     @i_oficina_tr         = 1,
     @i_usuario_tr         = 'admuser',
     @i_fecha_crea         = @w_fecha,
     @i_oficial            = 4,
     @i_sector             = '2', -- select * from cobis..cl_tabla where tabla like '%sector%'
     @i_ciudad             = 1,   -- select * from cobis..cl_ciudad 
     @i_fecha_apr          = @w_fecha,
     @i_usuario_apr        = 'admuser',
     @i_banco              = 203, 
     @i_toperacion         = @w_toperacion,
     @i_producto           = 'CCA',
     @i_monto              = @w_monto_0, 
     @i_tipo               = 'O',
     @i_moneda             = 0, 
     @i_periodo            = 'M',
     @i_num_periodos       = 0,
     @i_destino            = 1001,
     @i_ciudad_destino     = '11001',
     @i_cliente            = @w_cliente, 
     @i_clase              = 4, --AUMENTADO CLASE DE CARTERA 2/FEB/99
     @i_monto_mn           = @w_monto_0, 
     @i_monto_des          = @w_monto_0,
     @o_tramite            = @w_tramite_0 out

print '--------------------------------------------'
print '-- CREACION DE OPERACION'
print '--------------------------------------------'
exec @w_return         = sp_crear_operacion
     @s_user           = 'admuser',
     @s_ofi            = 1,
     @i_tramite        = @w_tramite_0, 
     @s_date           = @w_fecha, 
     @s_term           = 'admuser',
     @i_cliente        = @w_cliente,
     @i_nombre         = @w_nom_cliente,
     @i_sector         = '2',
     @i_toperacion     = @w_toperacion,
     @i_oficina        = 1,
     @i_moneda         = 0,
     @i_comentario     = 'OPERACION GRUPAL',
     @i_oficial        = 4, 
     @i_fecha_ini      = @w_fecha,
     @i_monto          = @w_monto_0,
     @i_monto_aprobado = @w_monto_0,
     @i_destino        = '1', 
     @i_ciudad         = 1,
     @i_formato_fecha  = 0,
     @i_salida         = 'N',
     @i_fondos_propios = 'N',
     @i_origen_fondos  = 'Q',
     @i_batch_dd       = 'N',
     @i_clase_cartera  = '1',
    -- @i_tasa           = @w_tasa,
     @o_banco          = @w_operacion_0 output

select @s_ssn = @s_ssn + 1

-- PASO A  DEFINITIVAS 
exec @w_return = sp_operacion_def
     @s_date   = @w_fecha,
     @s_sesn   = @s_ssn,
     @s_user   = 'ADMUSER',
     @s_ofi    = 1,
     @i_banco  = @w_operacion_0

update ca_operacion
   set op_estado = 0 --NO VIGENTE
where op_operacion = @w_operacion_0

select '-------------------------'
select 'Tramite   : ' + cast ( @w_tramite_0 as varchar)
select 'Operacion : ' + cast ( @w_operacion_0 as varchar)



exec @w_return = sp_borrar_tmp
     @s_sesn   = @s_ssn,
     @s_user   = 'ADMUSER',
     @s_term   = 'admuser',
     @i_banco  = @w_operacion_0

exec @w_return          = sp_pasotmp
     @s_user            = 'ADMUSER',
     @s_term            = 'admuser',
     @i_banco           = @w_operacion_0,
     @i_operacionca     = 'S',
     @i_dividendo       = 'S',
     @i_amortizacion    = 'S',
     @i_cuota_adicional = 'S',
     @i_rubro_op        = 'S',
     @i_relacion_ptmo   = 'S',
     @i_nomina          = 'S',
     @i_acciones        = 'S',
     @i_valores         = 'S'

exec @w_return         = sp_desembolso
     @s_ofi            = 1,
     @s_term           = 'admuser',
     @s_user           = 'ADMUSER',
     @s_date           = @w_fecha,
     @i_nom_producto   = 'CCA',
     @i_producto       = 'CHLOCAL',
     @i_beneficiario   = @w_nom_cliente,
     @i_ente_benef     = @w_cliente,
     @i_oficina_chg    = 1,
     @i_banco_ficticio = @w_operacion_0,
     @i_banco_real     = @w_operacion_0,
     @i_fecha_liq      = @w_fecha,
     @i_monto_ds       = @w_monto_0,
     @i_moneda_ds      = 0,
     @i_tcotiz_ds      = 'COT',
     @i_cotiz_ds       = 1.0,
     @i_cotiz_op       = 1.0,
     @i_tcotiz_op      = 'COT',
     @i_moneda_op      = 0,
     @i_operacion      = 'I',
     @i_externo        = 'N'

exec @w_return = sp_borrar_tmp
     @s_sesn   = @s_ssn,
     @s_user   = 'ADMUSER',
     @s_term   = 'admuser',
     @i_banco  = @w_operacion_0

exec @w_return          = sp_pasotmp
     @s_user            = 'ADMUSER',
     @s_term            = 'admuser',
     @i_banco           = @w_operacion_0,
     @i_operacionca     = 'S',
     @i_dividendo       = 'S',
     @i_amortizacion    = 'S',
     @i_cuota_adicional = 'S',
     @i_rubro_op        = 'S',
     @i_relacion_ptmo   = 'S',
     @i_nomina          = 'S',
     @i_acciones        = 'S',
     @i_valores         = 'S'


exec @w_return         = sp_liquida
     @s_ssn            = @s_ssn,
     @s_sesn           = @s_ssn,
     @s_user           = 'ADMUSER',
     @s_date           = @w_fecha,
     @s_ofi            = 1,
     @s_rol            = 3,
     @s_term           = 'admuser',
     @i_banco_ficticio = @w_operacion_0,
     @i_banco_real     = @w_operacion_0,
     @i_fecha_liq      = @w_fecha,
     @i_externo        = 'N',
     @o_banco_generado = @w_banco_generado out

select '-------------------------'
select '-------------------------'
select 'Operacion Banco: ' + @w_banco_generado


exec @w_return = sp_borrar_tmp
     @s_sesn   = @s_ssn,
     @s_user   = 'ADMUSER',
     @s_term   = 'admuser',
     @i_banco  = @w_banco_generado
go


