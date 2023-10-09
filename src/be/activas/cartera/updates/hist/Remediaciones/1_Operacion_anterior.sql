use cob_cartera
go

declare 
@s_ssn integer,
@w_return integer,
@w_tramite_0 int,
@w_tramite int,
@w_operacion_0  int,
@w_operacion  int,
@w_monto money,
@w_monto2 money,
@w_fecha datetime

exec  @s_ssn = ADMIN...rp_ssn  

select  @w_tramite_0 = max(tr_tramite) +1 from cob_credito..cr_tramite -- where tr_tramite < 100

update cobis..cl_seqnos
set siguiente = @w_tramite_0
where tabla = 'cr_tramite'


--------------------------
-- FECHA PROCESO
--------------------------
select @w_fecha = fp_fecha from cobis..ba_fecha_proceso 


print '--------------------------------------------'
print '-- TRAMITE ANTERIOR'
print '--------------------------------------------'
select @s_ssn = @s_ssn + 1000
    
exec cob_credito..sp_tramite_cca 
   @s_ssn                =  @s_ssn,
   @s_user               = 'admuser',
   @s_sesn               = @s_ssn, -- 1005,
   @s_term               = 'pc-jta',
   @s_date               = @w_fecha, --'11/10/2015',
   @s_srv                = 'pc-jta',
   @s_lsrv               = 'pc-jta',
   @s_ofi                = 1,
   @t_trn                = 21020,
   @i_oficina_tr         = 1,
   @i_usuario_tr         = 'admuser',
   @i_fecha_crea         = @w_fecha,
   @i_oficial            = 4,
   @i_sector             = '1', -- select * from cobis..cl_tabla where tabla like '%sector%'
   @i_ciudad             = 1,   -- select * from cobis..cl_ciudad 
   @i_fecha_apr          = @w_fecha,
   @i_usuario_apr        = 'admuser',
   @i_banco              = 203,  -- '140740117704',
   @i_toperacion         = 'CREDSEMI',
   @i_producto           = 'CCA',
   @i_monto              = 10000, -- 718,
   @i_tipo               = 'O',
   @i_moneda             = 0,  -- select op_moneda,* from cob_cartera..ca_operacion where op_estado in (1)
   @i_periodo            = 'M',
   @i_num_periodos       = 0,
   @i_destino            = 1001,
   @i_ciudad_destino     = '11001',
   @i_cliente            = 100001, -- 45206,   --SBU: 02/mar/2000
   @i_clase              = 4,--AUMENTADO CLASE DE CARTERA 2/FEB/99
   @i_monto_mn           = 10000, -- 718,
   @i_monto_des          = 10000, -- 718, 
   @o_tramite            = @w_tramite_0 out
   
select @w_tramite_0  -- 20



SELECT * FROM cobis..ba_fecha_proceso


print '--------------------------------------------'
print '-- CREACION DE OPERACION'
print '--------------------------------------------'

exec @w_return = sp_crear_operacion
@s_user           = 'admuser',
@s_ofi            = 1,
@i_tramite        = @w_tramite_0, -- 7,
@s_date           = @w_fecha, -- '11/10/2015',
@s_term           = 'admuser',
@i_cliente        = 100001,
@i_nombre         = 'ANDY ESTEBAN GARCIA MORLA',
@i_sector         = 1,
@i_toperacion     = 'CREDSEMI',
@i_oficina        = 1,
@i_moneda         = 0,
@i_comentario     = 'OP PARA RENOVACION',
@i_oficial        = 4, 
@i_fecha_ini      = @w_fecha, -- '11/10/2015',
@i_monto          = 10000,
@i_monto_aprobado = 10000,
@i_destino        = '01', ------ojo esta heredando el de la operaci½n que viene
@i_ciudad         = 1,
@i_formato_fecha  = 101,
@i_salida         = 'N',
@i_fondos_propios = 'N',
@i_origen_fondos  = 'Q',
@i_batch_dd       = 'N',
@i_clase_cartera  = 4,
@o_banco          = @w_operacion_0 output

select @w_operacion_0

select @s_ssn = @s_ssn + 1

-- PASO A  DEFINITIVAS 
exec @w_return = sp_operacion_def
@s_date   = @w_fecha, --  '11/10/2015',
@s_sesn   = @s_ssn, -- 10006,
@s_user   = 'ADMUSER',
@s_ofi    = 1,
@i_banco  = @w_operacion_0  

select @w_operacion_0  -- 177
update cob_cartera..ca_operacion
set op_estado = 1 -- 1 debe estar vigente para script 2 directo 1
where op_operacion = @w_operacion_0


update cob_cartera..ca_dividendo
set di_estado = 2 -- VENCE todas los dividendos
where  di_operacion = @w_operacion_0

GO