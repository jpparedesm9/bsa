/************************************************************************/
/*   Archivo:                 rptinvclpro.sp                            */
/*   Stored procedure:        sp_rpt_inv_clientes_prosp                 */
/*   Base de Datos:           cob_cartera                               */
/*   Producto:                Cartera                                   */
/*   Disenado por:                                                      */
/*   Fecha de Documentacion:  Octubre 01 de 2019                        */
/************************************************************************/
/*                            IMPORTANTE                                */
/*   Este programa es parte de los paquetes bancario s propiedad de     */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier autorizacion o agregado hecho por alguno de sus          */
/*   usuario sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante                 */
/************************************************************************/
/*                         PROPOSITO                                    */
/*   Generación de informes mensuales que permitan evaluar              */
/*   el impacto social de TUIIO en la comunidad.                        */
/*   --> Reporte Inventario de Clientes y Prospectos                    */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*   Fecha      Nombre          Proposito                               */
/*   19/09/2019 Walther Toledo  Emision Inicial Caso Redmine#123062     */
/*   18/05/2021 D. Cumbal       Cambios #156405 Mejora                  */
/************************************************************************/

use cob_conta_super
go

if not object_id('sp_rpt_inv_clientes_prosp') is null
   drop proc sp_rpt_inv_clientes_prosp
go
-- ========================================================
create proc sp_rpt_inv_clientes_prosp
   @i_param1 datetime = null
as
declare 
   @w_batch          int,
   @w_formato_fecha  int,
   @w_filial         int,
   @w_fecha          datetime,
   @w_fecha_1        datetime,
   @w_msg            varchar(132),
   @w_mensaje        varchar(512),
   @w_ciudad_nacional   int,
   @w_return         int,
   @w_fecha_proceso datetime,
   @w_sp_name        varchar(64),
   @w_error          int,
   @w_comando        varchar(6000),
   @w_columna        varchar(50),
   @w_cabecera       varchar(5000),
   @w_col_id         smallint,
   @w_path           varchar(255),
   @w_destino        varchar(255),
   @w_dest_cab       varchar(255),
   @w_s_app          varchar(255),
   @w_errores        varchar(255),
   @w_cmd            varchar(5000),
   @w_ente_aux       int,
   @w_dia_semana     int, 
   @w_dia_max        int,
   @w_procesa        char(1),
   @w_dia_viernes    int,
   @w_fecha_param    datetime,
   @w_mes            int,
   @w_anio           int,
   @w_ini_mes        datetime,
   @w_primer_dia_habil datetime

select @w_sp_name = 'sp_rpt_inv_clientes_prosp'

select
   @w_batch       = 36438,
   @w_fecha_param = @i_param1

select @w_filial = pa_int 
from cobis..cl_parametro 
where pa_nemonico = 'FILSAN'
if @@error != 0 or @@rowcount != 1
begin
   select @w_error = 101254, @w_mensaje = 'No se encuentra parametro FILSAN'
   goto ERROR_PROCESO
end

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'
if @@error != 0 or @@rowcount != 1
begin
   select @w_error = 101254, @w_mensaje = 'No se encuentra parametro CIUN'
   goto ERROR_PROCESO
end

/****************Encontrar Dia Habil ******************/
print '@w_fecha_param: ' + convert(varchar,@w_fecha_param)
select 
@w_mes              = MONTH (@w_fecha_param),  
@w_anio             = YEAR (@w_fecha_param)

select 
@w_ini_mes    = datefromparts(@w_anio, @w_mes, 1)

select 
@w_primer_dia_habil = @w_ini_mes

while exists(select 1 from cobis..cl_dias_feriados 
					where df_ciudad = @w_ciudad_nacional	
					and   df_fecha  = @w_primer_dia_habil ) begin
	select @w_primer_dia_habil = dateadd(day,1,@w_primer_dia_habil)
end

if @w_fecha_param <> @w_primer_dia_habil
	return 0   
   
select 
@w_fecha_proceso =  isnull(@w_fecha_param,fp_fecha),
@w_fecha = isnull(@w_fecha_param, fp_fecha)
from cobis..ba_fecha_proceso

print '@w_fecha_param: '+ convert(varchar,@w_fecha_param)
select 
@w_fecha_proceso =  isnull(@w_fecha_param,fp_fecha),
@w_fecha = isnull(@w_fecha_param, fp_fecha)
from cobis..ba_fecha_proceso

select @w_fecha = dateadd(day,-1,@w_fecha)
while exists(select 1 from cobis..cl_dias_feriados 
					where df_ciudad = @w_ciudad_nacional	
					and   df_fecha  = @w_fecha ) begin
	select @w_fecha = dateadd(day,-1,@w_fecha)
end

select @w_fecha_1 = @w_fecha
print '@w_fecha_1:' + convert(varchar,@w_fecha_1)    
	
/******************************************************/
select
distinct
   dcl_asesor        = dc_oficial,
   dcl_coordina_id   = convert(int, 0),
   dcl_gerente_id    = convert(int, 0),
   dcl_dom_cod_dir   = convert(tinyint, 0),
   dcl_dom_cod_tel   = convert(tinyint, 0),
   dcl_dom_cod_ciu   = convert(int, 0),
   dcl_dom_cod_depar = convert(int, 0),
   dcl_id_escolarida = dc_nivel_estudio,
   dcl_oficina       = dc_oficina,
-- ----------------- - -----------------------------
   dcl_ofc_id        = convert(varchar(10),dc_oficina),  -- 01
   dcl_nom_ofc       = convert(varchar(64), ''),         -- 02
   dcl_regional      = convert(smallint, 0),             -- 03
   dcl_nom_reg       = convert(varchar(64), ''),         -- 04
   dcl_nom_ger       = convert(varchar(64), ' '),        -- 05
   dcl_nom_coord     = convert(varchar(64), ' '),        -- 06
   dcl_nom_asesr     = convert(varchar(64), ' '),        -- 07
   dcl_status_cli    = convert(varchar(64),(             -- 08
                        case dc_estado_cliente
                        when 'I' then 'INACTIVO' 
                        when 'A' then 'ACTIVO' end)),
   dcl_nivel_riesgo  = convert(varchar(64), ''),         -- 09
   dcl_buc           = convert(varchar(20), ' '),        -- 10
   dcl_id_cliente    = dc_cliente,                       -- 11
   dcl_p_apellido    = upper(isnull(dc_p_apellido,' ')),        -- 12
   dcl_s_apellido    = upper(isnull(dc_s_apellido,' ')),        -- 13
   dcl_p_nombres     = convert(varchar(128), ''),        -- 14
   dcl_nro_ciclos    = convert(varchar(20), ' '),        -- 15
   dcl_num_ciclos    = convert(varchar(20), ' '),        -- 16
   dcl_cta_deposito  = convert(varchar(45), ' '),        -- 17
   dcl_rfc           = convert(varchar(30), ''),         -- 18
   dcl_tipo_cta      = convert(varchar(30), ' '),        -- 19
   dcl_genero        = dc_sexo,                          -- 20
   dcl_edad          = convert(smallint, 0),             -- 21
   dcl_est_civil     = convert(varchar(64), ' '),        -- 22
   dcl_escolaridad   = convert(varchar(64), ' '),        -- 23
   dcl_dom_estado    = convert(varchar(64), ' '),        -- 24
   dcl_dom_munic     = convert(varchar(64), ' '),        -- 25
   dcl_dom_cod_pos   = convert(varchar(30), ' '),        -- 26
   dcl_dom_num_telf  = convert(varchar(64), ' '),        -- 27
   dcl_dom_num_cel   = convert(varchar(64), ' '),        -- 28
   dcl_act_eco_corto = convert(varchar(64), ' '),        -- 29
   dcl_antigue_neg   = convert(smallint, 0),             -- 30
   dcl_correo_elect  = convert(varchar(254), ' '),       -- 31
   dcl_ingreso_mens  = convert(varchar(25), ' '),        -- 32
   dcl_gastos_mens   = convert(varchar(25), ' '),        -- 33
   dcl_otros_ingre   = convert(varchar(25), ' '),        -- 34
   dcl_cap_pago      = convert(varchar(25), ' '),        -- 35
   dcl_producto      = convert(varchar(64), ' '),        -- 36
   dcl_est_prod      = convert(varchar(64), ' ')         -- 37
-- -----------------------------------------
   into #dato_cliente
from sb_dato_cliente
where dc_fecha = @w_fecha_1

update #dato_cliente 
set dcl_nom_ofc = of_nombre,
    dcl_regional = of_regional
from #dato_cliente
inner join cobis..cl_oficina 
on dcl_oficina = of_oficina 
and of_filial = @w_filial

update #dato_cliente 
set dcl_nom_reg = r.of_nombre
from #dato_cliente 
inner join cobis..cl_oficina r
on dcl_regional = r.of_oficina

update #dato_cliente set 
dcl_coordina_id = fu_jefe,
dcl_nom_asesr   = fu_nombre
from #dato_cliente
inner join cobis..cl_funcionario f
on fu_funcionario = dcl_asesor  

update #dato_cliente set 
dcl_gerente_id  = fu_jefe ,
dcl_nom_coord = fu_nombre
from #dato_cliente
inner join cobis..cl_funcionario 
on fu_funcionario = dcl_coordina_id  

update #dato_cliente set
dcl_nom_ger  = fu_nombre
from #dato_cliente
inner join cobis..cl_funcionario 
on fu_funcionario = dcl_gerente_id           

update #dato_cliente set 
dcl_p_nombres     = upper(isnull(en_nombre  + ' ','') + isnull(p_s_nombre + ' ','')),
dcl_rfc           = en_rfc,
dcl_edad          = datediff(yy,p_fecha_nac,@w_fecha_1) - case when (month(@w_fecha_1) * 100) + day(@w_fecha_1) < (month(p_fecha_nac) * 100) + day(p_fecha_nac) then 1 else 0 end,
dcl_act_eco_corto = (select min(nc_actividad_ec) from cobis..cl_negocio_cliente where nc_ente = dcl_id_cliente and nc_estado_reg ='V' and nc_actividad_ec is not null),
dcl_antigue_neg   = (select max(datediff(yyyy, nc_fecha_apertura,@w_fecha_1)) from cobis..cl_negocio_cliente where nc_ente = dcl_id_cliente and nc_estado_reg ='V' and nc_actividad_ec is not null),
dcl_ingreso_mens  = convert(varchar(25), round(isnull(en_otros_ingresos,0),2)),
dcl_gastos_mens   = convert(varchar(25), round(isnull(ea_ct_ventas,0) + isnull(ea_ct_operativo,0),2)),
dcl_otros_ingre   = convert(varchar(25), round(isnull(ea_ventas,0),2)),
dcl_cap_pago      = convert(varchar(25), round(isnull(ea_ventas,0) + isnull(en_otros_ingresos,0) - isnull(ea_ct_ventas,0) - isnull(ea_ct_operativo,0) ,2)),
dcl_est_civil     = p_estado_civil,
dcl_cta_deposito  = isnull(ea_cta_banco,' '),
dcl_nivel_riesgo  = case  when ea_nivel_riesgo_cg is null then 'NO EVALUADO' when ea_nivel_riesgo_cg = 'F' then 'NO APROBADO' else 'APROBADO' end,
dcl_buc           = isnull(en_banco,' '),
dcl_nro_ciclos    = isnull(en_nro_ciclo,' ')
from #dato_cliente
inner join cobis..cl_ente
on en_ente = dcl_id_cliente
inner join cobis..cl_ente_aux 
on en_ente = ea_ente
where dcl_id_cliente = en_ente

update #dato_cliente
set dcl_escolaridad = isnull(c.valor,' ')
from #dato_cliente
inner join cobis..cl_catalogo c
on dcl_id_escolarida = c.codigo
inner join cobis..cl_tabla t
on t.codigo      = c.tabla 
and t.tabla       = 'cl_nivel_estudio'

update #dato_cliente
set dcl_est_civil = isnull(c.valor,' ')
from cobis..cl_tabla t,cobis..cl_catalogo c
where t.codigo      = c.tabla 
and   t.tabla       = 'cl_ecivil'
and   dcl_est_civil = c.codigo

update #dato_cliente set
dcl_dom_cod_dir     = di_direccion,
dcl_dom_cod_tel     = di_telefono,
dcl_dom_cod_ciu     = di_ciudad,        -- MUNICIPIO
dcl_dom_cod_depar   = di_provincia,     -- ESTADO
dcl_dom_cod_pos     = di_codpostal      -- COD POS
from cobis..cl_direccion
where di_ente = dcl_id_cliente
and   di_tipo = 'RE'  
and   di_direccion=(SELECT min(di_direccion) FROM cobis..cl_direccion where di_ente = dcl_id_cliente
and   di_tipo = 'RE')

if exists(select 1 from #dato_cliente where dcl_dom_cod_dir is null or dcl_dom_cod_dir = 0)
begin
   update #dato_cliente set
   dcl_dom_cod_dir     = di_direccion,
   dcl_dom_cod_tel     = di_telefono,
   dcl_dom_cod_ciu     = di_ciudad,
   dcl_dom_cod_depar   = di_provincia,
   dcl_dom_cod_pos     = di_codpostal
   from cobis..cl_direccion
   where di_ente = dcl_id_cliente
   and   di_direccion=(SELECT min(di_direccion) FROM cobis..cl_direccion where di_ente = dcl_id_cliente and di_tipo not in ('AE')) --negocio
   and ( dcl_dom_cod_dir = 0 or dcl_dom_cod_dir is null)
end

update #dato_cliente set
dcl_dom_munic = ci_descripcion
from cobis..cl_ciudad
where ci_ciudad = dcl_dom_cod_ciu

update #dato_cliente set
dcl_dom_estado = pv_descripcion
from cobis..cl_provincia
where pv_provincia = dcl_dom_cod_depar

update #dato_cliente set
dcl_dom_num_telf = te_valor
from cobis..cl_telefono
where te_ente  = dcl_id_cliente
and te_direccion = dcl_dom_cod_dir
and te_secuencial = dcl_dom_cod_tel

update #dato_cliente set
dcl_dom_num_cel = te_valor
from cobis..cl_telefono
where te_ente  = dcl_id_cliente
and te_tipo_telefono = 'C'

update #dato_cliente set                                
dcl_act_eco_corto = c.valor 
from cobis..cl_tabla t,cobis..cl_catalogo c
where t.tabla             = 'cl_actividad'
and   t.codigo            = c.tabla
and   dcl_act_eco_corto = c.codigo

update #dato_cliente set
dcl_correo_elect = di_descripcion
from cobis..cl_direccion
where di_ente = dcl_id_cliente
and   di_direccion=(SELECT min(di_direccion) FROM cobis..cl_direccion where di_ente = dcl_id_cliente and di_tipo = 'CE')
and di_tipo = 'CE'


   select distinct dcl_id_cliente 
   into #solo_datos_cli
   from #dato_cliente 
   
   select op_cliente dul_cod_cli, op_banco dul_banco, op_operacion dul_operacion, 
          op_toperacion dul_toper, op_estado dul_estado,op_fecha_fin dul_fec_fin,
   row_number() over ( partition by op_cliente order by op_operacion desc) as row_ind
   into #datos_ult_oper
   FROM cob_cartera..ca_operacion
   inner join #solo_datos_cli 
   on op_cliente = dcl_id_cliente 
   group by op_cliente, op_banco, op_operacion, op_toperacion, op_estado, op_fecha_fin

   update #dato_cliente set
   dcl_producto = isnull(dul_toper,' '),
   dcl_est_prod = (select es_descripcion from cob_cartera..ca_estado where es_codigo = dul_estado),
   dcl_nro_ciclos = case when dul_toper != 'GRUPAL' then ' ' end  -- 15
   from #dato_cliente 
   inner join #datos_ult_oper
   on dcl_id_cliente = dul_cod_cli
   and row_ind = 1
   
   update #dato_cliente set
   dcl_num_ciclos = (select isnull(convert(varchar(20),max(dc_ciclo_grupo)),' ') 
                     from cob_cartera..ca_det_ciclo 
                     where dc_cliente = dcl_id_cliente)
   from #dato_cliente
   where dcl_producto = 'GRUPAL'
   

update #dato_cliente set
dcl_status_cli = 'PROSPECTO'
from #dato_cliente
where dcl_producto is null
or dcl_producto = ' '
or dcl_producto = ''

update #dato_cliente set
dcl_status_cli = 'ACTIVO'
from #dato_cliente
inner join #datos_ult_oper
on dul_cod_cli = dcl_id_cliente
and dul_estado != 3
and dcl_producto in ('GRUPAL','INDIVIDUAL')

update #dato_cliente set
dcl_status_cli = 'ACTIVO'
from #dato_cliente
inner join #datos_ult_oper
on dul_cod_cli = dcl_id_cliente
and dul_fec_fin > @w_fecha_proceso
and dcl_producto = 'REVOLVENTE'

update #dato_cliente set
dcl_tipo_cta = isnull(pr_codigo_subproducto,' ')
from #dato_cliente 
inner join cobis..cl_producto_santander
on dcl_id_cliente = pr_ente
and pr_numero_contrato = dcl_cta_deposito
and dcl_cta_deposito is not null

if not object_id('sb_rpt_inv_cli_y_prosp_cab') is null drop table sb_rpt_inv_cli_y_prosp_cab
create table sb_rpt_inv_cli_y_prosp_cab (nombres_columnas varchar(1024))
insert into sb_rpt_inv_cli_y_prosp_cab values(
'OFICINA'               + '|' +  'NOMBRE OFICINA'        + '|' +  'ID REGION'                + '|' +
'REGION'                + '|' +  'NOMBRE DEL GERENTE'    + '|' +  'NOMBRE DEL COORDINADOR'   + '|' +
'NOMBRE DEL ASESOR'     + '|' +  'ESTATUS DEL CLIENTE'   + '|' +  'BURO DE CREDITO'          + '|' +
'BUC'                   + '|' +  'ID CLIENTE COBIS'      + '|' +  'APELLIDO PATERNO'         + '|' +
'APELLIDO MATERNO'      + '|' +  'NOMBRE (S)'            + '|' +  'CICLO INDIVIDUAL'         + '|' +
'CICLO GRUPAL'          + '|' +  'CUENTA DE DEPOSITO'    + '|' +  'RFC'                      + '|' +
'TIPO DE CUENTA'        + '|' +  'GENERO'                + '|' +  'EDAD'                     + '|' +
'ESTADO CIVIL'          + '|' +  'ESCOLARIDAD'           + '|' +  'ESTADO'                   + '|' +
'MUNICIPIO'             + '|' +  'CODIGO POSTAL'         + '|' +  'NUMERO TELEFONICO LOCAL'  + '|' +
'NUMERO DE CELULAR'     + '|' +  'ACTIVIDAD ECONOMICA'   + '|' +  'ANTIGUEDAD NEGOCIO (AÑOS)'+ '|' +
'CORREO ELECTRONICO'    + '|' +  'INGRESO MENSUAL'       + '|' +  'GASTOS MENSUALES'         + '|' +
'OTROS INGRESOS'        + '|' +  'CAPACIDAD DE PAGO'     + '|' +  'PRODUCTO'                 + '|' +
'ESTATUS DEL CREDITO'
)
----------------------------------------
-- Generar Archivo Plano
----------------------------------------
select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select @w_path = ba_path_destino
from cobis..ba_batch
where ba_batch = @w_batch

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_conta_super..sb_rpt_inv_cli_y_prosp_cab out '

-- IS_PERSONAS_YYMMDD.TXT
select @w_dest_cab = @w_path + 'IS_PERSONAS_CAB_'  + replace(convert(varchar, @w_fecha_1, 12), '.', '')   + '.txt',
       @w_errores  = @w_path + 'IS_PERSONAS_'      + replace(convert(varchar, @w_fecha_1, 12), '.', '')   + '.err'

select @w_comando = @w_cmd + @w_dest_cab + ' -b1 -c -C RAW -T -e ' + @w_errores + ' -t"|" ' + '-config ' + @w_s_app + 's_app.ini'
exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   print 'Error generando Reporte Operativo de Cartera'
   print @w_comando
   return 1
end
-- ====================

if not object_id('sb_rpt_inv_clientes_y_prosp') is null drop table sb_rpt_inv_clientes_y_prosp
select
'Oficina'                  = isnull(dcl_oficina       ,0),    -- 01
'Nombre oficina'           = isnull(dcl_nom_ofc       ,''),   -- 02
'Id Región'                = isnull(dcl_regional      ,0),    -- 03
'Región'                   = isnull(dcl_nom_reg       ,''),   -- 04
'Nombre del Gerente'       = isnull(dcl_nom_ger       ,' '),  -- 05
'Nombre del Coordinador'   = isnull(dcl_nom_coord     ,' '),  -- 06
'Nombre del Asesor'        = isnull(dcl_nom_asesr     ,' '),  -- 07
'Estatus del cliente'      = isnull(dcl_status_cli    ,''),   -- 08
'Buró de crédito'          = isnull(dcl_nivel_riesgo  ,''),   -- 09
'BUC'                      = isnull(dcl_buc           ,' '),  -- 10
'ID cliente COBIS'         = isnull(dcl_id_cliente    ,0),    -- 11
'Apellido Paterno'         = isnull(dcl_p_apellido    ,' '),  -- 12
'Apellido Materno'         = isnull(dcl_s_apellido    ,' '),  -- 13
'Nombre (s)'               = isnull(dcl_p_nombres     ,''),   -- 14
'Ciclo individual'         = isnull(dcl_nro_ciclos    ,' '),  -- 15
'Ciclo grupal'             = isnull(dcl_num_ciclos    ,' '),  -- 16
'Cuenta de depósito'       = isnull(dcl_cta_deposito  ,' '),  -- 17
'RFC'                      = isnull(dcl_rfc           ,''),   -- 18
'Tipo de cuenta'           = isnull(dcl_tipo_cta      ,' '),  -- 19
'Género'                   = isnull(dcl_genero        ,''),   -- 20
'Edad'                     = isnull(dcl_edad          , 0),   -- 21
'Estado civil'             = isnull(dcl_est_civil     ,' '),  -- 22
'Escolaridad'              = isnull(dcl_escolaridad   ,' '),  -- 23
'Estado'                   = isnull(dcl_dom_estado    ,' '),  -- 24
'Municipio'                = isnull(dcl_dom_munic     ,' '),   -- 25
'Código Postal'            = isnull(dcl_dom_cod_pos   ,' '),   -- 26
'Número telefónico local'  = isnull(dcl_dom_num_telf  ,' '),  -- 27
'Número de celular'        = isnull(dcl_dom_num_cel   ,' '),  -- 28
'Actividad económica'      = isnull(dcl_act_eco_corto ,' '),  -- 29
'Antigüedad Negocio (años)'= isnull(dcl_antigue_neg   , 0),   -- 30
'Correo electrónico'       = isnull(dcl_correo_elect ,' '),   -- 31
'Ingreso mensual'          = isnull(dcl_ingreso_mens,' '),    -- 32
'Gastos mensuales'         = isnull(dcl_gastos_mens ,0),      -- 33
'Otros ingresos'           = isnull(dcl_otros_ingre ,0),      -- 34
'Capacidad de pago'        = isnull(dcl_cap_pago    ,0),      -- 35
'Producto'                 = isnull(dcl_producto      ,' '),  -- 36
'Estatus del Crédito'      = isnull(dcl_est_prod      ,' ')   -- 37
into sb_rpt_inv_clientes_y_prosp
from #dato_cliente

-- select top 100 * from sb_rpt_inv_clientes_y_prosp

----------------------------------------
--Generar Archivo Plano
----------------------------------------
select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select @w_path = ba_path_destino
from cobis..ba_batch
where ba_batch = @w_batch

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_conta_super..sb_rpt_inv_clientes_y_prosp out '

-- IS_PERSONAS_YYMMDD.TXT
select @w_destino  = @w_path + 'IS_PERSONAS_'      + replace(convert(varchar, @w_fecha_1, 12), '.', '') + '.txt',
       @w_errores  = @w_path + 'IS_PERSONAS_'      + replace(convert(varchar, @w_fecha_1, 12), '.', '') + '.err'

select @w_comando = @w_cmd + @w_path + 'rptinvclpro -b5000 -c -C RAW -T -e ' + @w_errores + ' -t"|" ' + '-config ' + @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error generando Reporte Operativo de Cartera'
   print @w_comando
   return 1
end

-- ------
select @w_comando = 'copy ' + @w_dest_cab + ' + ' + @w_path + 'rptinvclpro ' + @w_destino

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error Agregando Cabeceras'
   print @w_comando
   return 1
end

return 0

ERROR_PROCESO:
select @w_msg = mensaje
from  cobis..cl_errores with (nolock)
where numero = @w_error
set transaction isolation level read uncommitted
exec @w_return       = sp_errorlog
     @i_operacion    = 'I',
     @i_fecha_fin    = @w_fecha_proceso,
     @i_origen_error = @w_error,
     @i_fuente       = @w_sp_name,
     @i_descrp_error = @w_msg

return @w_error

go

