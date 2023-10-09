/******************************************************************/
/*  Archivo:                 pf_transacciones_of.sp               */
/*  Stored procedure:        sp_trans_pf_of                       */
/*  Base de Datos:           cob_pfijo                            */
/*  Producto:                PLAZO FIJO                           */
/*  Fecha:                   Dic/2015                             */
/******************************************************************/
/*          IMPORTANTE                                            */
/*  Este programa es parte de los paquetes bancarios propiedad de */
/*  'MACOSA',representantes exclusivos para el Ecuador de la      */
/*  AT&T                                                          */
/*  Su uso no autorizado queda expresamente prohibido asi como    */
/*  cualquier autorizacion o agregado hecho por alguno de sus     */
/*  usuario sin el debido consentimiento por escrito de la        */
/*  Presidencia Ejecutiva de MACOSA o su representante            */
/******************************************************************/
/*                        PROPOSITO                               */
/* Este SP permite extraer las transacciones diarias por oficina  */
/* para plazo fijo                                                */
/******************************************************************/
/*                      MODIFICACIONES                            */
/*  FECHA       AUTOR                        RAZON                */
/*  Dic/2015    L.Guzmán                   Emisión Inicial REQ549 */
/******************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_trans_pf_of')
   drop proc sp_trans_pf_of
go

create proc sp_trans_pf_of(
@i_param1          datetime,    -- FECHA INICIO 
@i_param2          datetime)    -- FECHA FIN
with encryption
as
declare
@w_return          int,
@w_fecha_ini       datetime,
@w_fecha_fin       datetime,
@w_fecha_proceso   varchar(10),
@w_sp_name         varchar(32),
@w_error           int,
@w_msg             varchar(250)

/* INICIALIZACION DE VARIABLE */
select
@w_fecha_ini     = @i_param1,
@w_fecha_fin     = @i_param2,
@w_fecha_proceso = (select convert(varchar(10),fp_fecha,101) from cobis..ba_fecha_proceso),       
@w_sp_name       = 'sp_trans_pf_of',
@w_error         = 0,
@w_msg           = ''

/*CREACION DE TABLA DE TRABAJO*/
select * into #cl_transacciones_of from cobis..cl_transacciones_of where 1 = 2

alter table #cl_transacciones_of 
add to_operacion varchar(20) NULL

if @@error <> 0
begin
   select @w_msg   = 'ERROR ADICIONANDO COLUMNAS DE TRABAJO',
          @w_error = 1

   goto ERROR
end

if OBJECT_ID(N'tempdb..#Equivalencias', N'U') is not null
   drop table #Equivalencias
	  
create table #Equivalencias(
eq_modulo             tinyint          NULL,
eq_mod_int            tinyint          NULL,
eq_tabla              varchar(16)      NULL,
eq_val_cfijo          varchar(10)      NULL,
eq_val_num_ini        varchar(30)      NULL,
eq_val_num_fin        varchar(30)      NULL,
eq_val_interfaz       varchar(10)      NULL,
eq_descripcion        varchar(64)      NULL)

-- INSERTA EQUIVALENCIAS
exec @w_return        = cob_interfase..sp_iremesas
     @i_operacion     = 'AB'
	 
if @w_return <> 0
begin
   select
   @w_msg   = 'ERROR INSERTANDO LAS TRANSACCIONES DE EQUIVALENCIAS',
   @w_error = 1
   goto ERROR
end

-- INSERTA LAS TRANSACCIONES DE APERTURA, CANCELACION Y EMISION DE ORDEN DE PAGO 
insert into #cl_transacciones_of
select 
@w_fecha_proceso,                                                       -- FECHA GENERACION DEL REPORTE
hi_oficina,                                                             -- COD OFICINA
NULL,                                                                   -- NOM OFICINA
NULL,                                                                   -- COD ZONA
NULL,                                                                   -- NOM ZONA
NULL,                                                                   -- COD REGIONAL
NULL,                                                                   -- NOM REGIONAL
(select c.valor                                                         -- MES DEL REPORTE
 from cobis..cl_catalogo c
 where c.tabla  = (select t.codigo 
                   from cobis..cl_tabla t 
                   where  t.tabla = 'cr_meses')
 and c.codigo = datepart(mm,hi_fecha)
),                                                                        
right('00' + convert(varchar(2),datepart(dd,hi_fecha)),2),              -- DIA DEL REPORTE
(select eq_val_num_fin from #Equivalencias                              -- ORIGEN DE LA TRANSACCIÓN (CAJA / GESTOR)
                       where eq_tabla = 'REPOFIR549' 
                       and eq_val_cfijo = convert(varchar(10),hi_trn_code)
),
hi_trn_code,                                                            -- TIPO DE TRANSACCION
0,                                                                      -- CAUSAL
hi_valor,                                                               -- MONTO TRANSACCIONES 
0,                                                                      -- CANTIDAD TRANSACCIONES 
0,                                                                      -- CANTIDAD DE CLIENTES
hi_fecha,                                                               -- FECHA DE CADA TRANSACCION, SE ADICIONA PARA EL AGRUPAMIENTO
hi_operacion                                                            -- OPERACION AFECTADA
from pf_historia
where hi_fecha between @w_fecha_ini and @w_fecha_fin
and   hi_trn_code in (14901,14903,14759)                                -- APERTURA, CANCELACION Y EMISION DE ORDEN DE PAGO 
order by hi_oficina

if @@error <> 0
begin
   select @w_msg   = 'ERROR INSERTANDO LAS TRANSACCIONES DE APERTURA, CANCELACION Y EMISION DE ORDEN DE PAGO ',
          @w_error = 1

   goto ERROR
end

-- INSERTA LAS TRANSACCIONES DE DEPOSITO DE ACTIVACION
exec @w_return        = cob_interfase..sp_icuentas
     @i_operacion     = 'AD',
	 @i_fecha_proceso = @w_fecha_proceso,
     @i_fecha_ini     = @w_fecha_ini,
     @i_fecha_fin     = @w_fecha_fin
	 
if @w_return <> 0
begin
   select
   @w_msg   = 'ERROR INSERTANDO LAS TRANSACCIONES DE DEPOSITO DE ACTIVACION ',
   @w_error = 1
   goto ERROR
end

-- INSERTA LAS TRANSACCIONES DE PAGO CERTIFICADO EFECTIVO
insert into #cl_transacciones_of
select 
@w_fecha_proceso,                                                       -- FECHA GENERACION DEL REPORTE
hi_oficina,                                                             -- COD OFICINA
NULL,                                                                   -- NOM OFICINA
NULL,                                                                   -- COD ZONA
NULL,                                                                   -- NOM ZONA
NULL,                                                                   -- COD REGIONAL
NULL,                                                                   -- NOM REGIONAL
(select c.valor                                                         -- MES DEL REPORTE
from cobis..cl_catalogo c
where c.tabla  = (select t.codigo 
                   from cobis..cl_tabla t 
                   where  t.tabla = 'cr_meses')
and c.codigo = datepart(mm, ec_fecha_caja)
),
right('00' + convert(varchar(2),datepart(dd, ec_fecha_caja)),2),        -- DIA DEL REPORTE
(select eq_val_num_fin from #Equivalencias                              -- ORIGEN DE LA TRANSACCIÓN (CAJA / GESTOR)
                       where eq_tabla = 'REPOFIR549' 
                       and eq_val_cfijo = convert(varchar(10),ec_tran)
),         
ec_tran,                                                                -- TIPO DE TRANSACCION
0,                                                                      -- CAUSAL 
SUM(ec_valor),                                                               -- MONTO TRANSACCIONES 
0,                                                                      -- CANTIDAD TRANSACCIONES 
0,                                                                      -- CANTIDAD DE CLIENTES
ec_fecha_caja,                                                           -- FECHA DE CADA TRANSACCION, SE ADICIONA PARA EL AGRUPAMIENTO
ec_operacion                                                            -- OPERACION AFECTADA
from cob_pfijo..pf_emision_cheque , cob_pfijo..pf_historia
where ec_fecha_caja between @w_fecha_ini and @w_fecha_fin
and   ec_fecha_caja = hi_fecha
and   ec_operacion = hi_operacion
and   ec_tran      = hi_trn_code
and   ec_secuencia = hi_secuencia
and   ec_tran      in (14904,14905,14543,14168)                         -- PAGO CERTIFICADO EFECTIVO
and   ec_estado    = 'A' 
and   ec_caja      = 'S'              
group by ec_operacion, hi_oficina, ec_tran, ec_fecha_caja
order by hi_oficina
if @@error <> 0
begin
   select @w_msg   = 'ERROR INSERTANDO LAS TRANSACCIONES DE PAGO CERTIFICADO EFECTIVO ',
          @w_error = 1

   goto ERROR
end

/*ACTUALIZANDO DATOS DE LA OFICINA*/
select distinct 
'cod_oficina'  = to_cod_oficina,
'nom_oficina'  = of_nombre,
'cod_zona'     = of_zona,
'nom_zona'     = convert(varchar(255),''),
'cod_regional' = of_regional,
'nom_regional' = convert(varchar(255),'')
into #oficinas
from #cl_transacciones_of, cobis..cl_oficina 
where to_cod_oficina      = of_oficina

if @@error <> 0
begin
   select @w_msg   = 'ERROR CONSULTANDO DATOS DE OFICINA',
          @w_error = 1

   goto ERROR
end

update #oficinas set
nom_zona = of_nombre
from cobis..cl_oficina 
where cod_zona = of_oficina

if @@error <> 0
begin
   select @w_msg   = 'ERROR ACTUALIZANDO DATOS DE ZONAS',
          @w_error = 1

   goto ERROR
end

update #oficinas set
nom_regional = of_nombre
from cobis..cl_oficina 
where cod_regional = of_oficina

if @@error <> 0
begin
   select @w_msg   = 'ERROR ACTUALIZANDO DATOS DE REGIONAL',
          @w_error = 1

   goto ERROR
end

/*ACTUALIZANDO DATOS DE LA OFICINA EN TABLA DE TRABAJO*/
update #cl_transacciones_of set
to_nombre_oficina  = nom_oficina,
to_cod_zona        = cod_zona,
to_nombre_zona     = nom_zona,
to_cod_regional    = cod_regional,
to_nombre_regional = nom_regional
from #oficinas
where to_cod_oficina = cod_oficina

if @@error <> 0
begin
   select @w_msg   = 'ERROR ACTUALIZANDO DATOS DE OFICINA EN TABLA DE TRABAJO DE TRANSACCIONES',
          @w_error = 1

   goto ERROR
end

/*PARA ESTE TIPO DE TRANSACCION EN LA TABLA SOLO CONTAMOS CON EL BANCO POR ESO LO ACTUALIZAMOS*/
update #cl_transacciones_of set
to_operacion = op_operacion 
from pf_operacion
where to_operacion        = op_num_banco
and   to_tipo_transaccion = 14545

if @@error <> 0
begin
   select @w_msg   = 'ERROR ACTUALIZANDO DATOS DE OPERACIONES PARA TRASACCION DE DEPOSITO ACTIVACION',
          @w_error = 1

   goto ERROR
end

/*ACTUALIZA CANTIDAD DE CLIENTES*/
select to_operacion as operacion, to_cod_oficina as oficina, to_tipo_transaccion as transaccion, to_fecha_transaccion as fecha
into #op_clientes
from #cl_transacciones_of

if @@error <> 0
begin
   select @w_msg   = 'ERROR CONSULTANDO OPERACIONES',
          @w_error = 1

   goto ERROR
end

alter table #op_clientes
add cliente int null

if @@error <> 0
begin
   select @w_msg   = 'ERROR ALTERANDO TABLA DE TRABAJO',
          @w_error = 1

   goto ERROR
end

create index idx1 on #op_clientes(operacion)

update #op_clientes set
cliente = op_ente
from pf_operacion
where op_operacion = operacion

if @@error <> 0
begin
   select @w_msg   = 'ERROR ACTUALIZANDO CLIENTE POR OPERACIONES',
          @w_error = 1

   goto ERROR
end

/*CUENTA CLIENTES*/
select count(distinct(cliente)) as nro_clientes, oficina, transaccion, fecha
into #cant_clientes 
from #op_clientes
group by oficina, transaccion, fecha

if @@error <> 0
begin
   select @w_msg   = 'ERROR CONSULTANDO CANTIDAD DE CLIENTES',
          @w_error = 1

   goto ERROR
end

/*CANTIDAD DE TRANSACCIONES Y MONTOS*/
select count(1) as cant_trn, sum(convert(money,to_monto_trn)) as monto, to_cod_oficina as oficina, to_tipo_transaccion as transaccion, to_origen as origen, to_fecha_transaccion as fecha
into #cant_trn 
from #cl_transacciones_of
group by to_cod_oficina, to_tipo_transaccion, to_fecha_transaccion, to_origen
if @@error <> 0
begin
   select @w_msg   = 'ERROR CONSULTANDO CANTIDAD DE TRANSACCIONES',
          @w_error = 1

   goto ERROR
end

update #cl_transacciones_of set
to_cant_cli_trn = nro_clientes
from #cant_clientes
where to_cod_oficina       = oficina
and   to_tipo_transaccion  = transaccion
and   to_fecha_transaccion = fecha

if @@error <> 0
begin
   select @w_msg   = 'ERROR ACTUALIZANDO CLIENTES AGRUPADOS',
          @w_error = 1

   goto ERROR
end

update #cl_transacciones_of set
to_cant_trn  = cant_trn,
to_monto_trn = monto
from #cant_trn
where to_cod_oficina       = oficina
and   to_tipo_transaccion  = transaccion 
and   to_fecha_transaccion = fecha
and   to_origen            = origen

if @@error <> 0
begin
   select @w_msg   = 'ERROR ACTUALIZANDO TRANSACCIONES AGRUPADAS',
          @w_error = 1

   goto ERROR
end

alter table #cl_transacciones_of
drop column to_operacion

if @@error <> 0
begin
   select @w_msg   = 'ERROR ELIMINANDO COLUMNAS DE TRABAJO',
          @w_error = 1
   goto ERROR
end

--AGRUPAR TABLA DE TRABAJO
select * into #cl_transacciones_of_tmp
from #cl_transacciones_of
group by to_fecha_generacion, to_cod_oficina, to_nombre_oficina, 
         to_cod_zona,         to_nombre_zona, to_cod_regional, 
         to_nombre_regional,  to_mes_reporte, to_dia_mes, 
         to_origen,           to_tipo_transaccion, to_causal_trn,
         to_monto_trn,        to_cant_trn,         to_cant_cli_trn,
         to_fecha_transaccion
order by to_cod_oficina

if @@error <> 0
begin
   select @w_msg   = 'ERROR AGRUPANDO TABLA DE TRABAJO ',
          @w_error = 1

   goto ERROR
end

/*ACTUALIZA DESCRIPCION TRANSACCIONES*/
update #cl_transacciones_of_tmp set
to_tipo_transaccion = eq_descripcion
from  #Equivalencias
where to_tipo_transaccion = eq_val_cfijo
and   eq_modulo           = 14

if @@error <> 0
begin
   select @w_msg   = 'ERROR ACTUALIZANDO DESCRIPCION DEL TIPO DE TRANSACCION EN TABLA DE TRABAJO DE TRANSACCIONES',
          @w_error = 1

   goto ERROR
end

/*INGRESO DE INFORMACION A LA TABLA DE TRANSACCIONES POR OFICINA*/
insert into cobis..cl_transacciones_of 
select * from #cl_transacciones_of_tmp

if @@error <> 0
begin
   select @w_msg   = 'ERROR INGRESANDO INFORMACION DE TRANSACCIONES POR OFICINA',
          @w_error = 1

   goto ERROR
end

return 0

ERROR:
   print @w_msg
   return @w_error

go