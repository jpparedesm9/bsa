
/************************************************************************/
/*   Archivo:                 sp_operaciones_canceladas.sp              */
/*   Stored procedure:        sp_operaciones_canceladas                 */
/*   Base de Datos:           cob_cartera                               */
/*   Producto:                Cartera                                   */
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
/*   Generar consulta de operaciones canceladas                         */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*   Fecha      Nombre          Proposito                               */
/*   02/08/2021 BGU            Emision Inicial                          */
/************************************************************************/

use cob_conta_super
go

if not object_id('sp_operaciones_canceladas') is null
   drop proc sp_operaciones_canceladas
go

create proc sp_operaciones_canceladas
   @i_param1   varchar(10),   --FECHA
   @i_param2   varchar(10),   --BATCH 28793
   @i_param3   varchar(10)    --FORMATO FECHA
as
declare 
@w_error           int,
@w_fecha           datetime,
@w_batch           int,
@w_fecha_desde     datetime,
@w_formato_fecha   int,
@w_est_vencido     int,
@w_est_vigente     int,
@w_est_castigado   int,
@w_return          int,
@w_est_suspenso    int ,
@w_fecha_ini       datetime,
@w_fecha_fin       datetime

select
@w_batch         = convert(int,@i_param2),
@w_formato_fecha = convert(int,@i_param3),
@w_fecha         = @i_param1

--CONSULTAR ESTADO VENCIDO/VIGENTE PARA CARTERA
exec @w_error    = cob_externos..sp_estados
@i_producto      = 7,
@o_est_vencido   = @w_est_vencido   out,
@o_est_vigente   = @w_est_vigente   out,
@o_est_castigado = @w_est_castigado out,
@o_est_suspenso  = @w_est_suspenso  out 

if @@error <> 0 begin
   print 'No Encontro Estado Vencido/Vigente/Castigado para Cartera'
   return 1
end


/*CREDITOS CANCELADO 30 DIAS ATRAS*/
SELECT @w_fecha_fin = @w_fecha--fp_fecha FROM cobis..ba_fecha_proceso
SELECT @w_fecha_ini = dateadd(dd,-30,@w_fecha_fin)
print 'oc1'
select
op_banco,
op_fecha_ult_proceso
into #oc_operaciones_canceladas
from cob_cartera..ca_operacion,  cob_credito..cr_tramite_grupal
where op_estado = 3 -- CANCELADO
and op_fecha_ult_proceso between @w_fecha_ini and @w_fecha_fin
and tg_operacion = op_operacion
and tg_prestamo <> tg_referencia_grupal

print 'oc2'

SET NOCOUNT ON
SET ROWCOUNT 0
print 'oc3'
/* GENERAR LA TABLA DE TRABAJO EN BASE A LOS DATOS DE LA TABLA SB_DATO_OPERACION */
select 
mca_fecha                = convert(varchar,do_fecha,111),
mca_oficina              = do_oficina,
mca_banco                = do_banco,
mca_grupo                = do_grupo,
mca_nombre_grupo         = convert(varchar(64),''),
mca_cliente              = do_codigo_cliente,
mca_nombre1              = convert(varchar(64),''),
mca_apellido_paterno     = convert(varchar(64),''),
mca_apellido_materno     = convert(varchar(64),''),
mca_toperacion           = do_tipo_operacion,
mca_edad_mora            = do_dias_mora_365,
mca_ciclo                = convert(varchar(3),isnull(do_numero_ciclos,0)),
mca_numero_ciclo_ind     = convert(int,0),
mca_atraso_max_ant       = convert(int,0)         ,
mca_atraso_max_act       = do_atraso_grupal       ,
mca_nivel_riesgo         = convert(char(1), null)
into #oc_manejo_cartera
from cob_conta_super..sb_dato_operacion, #oc_operaciones_canceladas
where do_fecha    = op_fecha_ult_proceso
and   do_aplicativo = 7
and   do_banco = op_banco

if @@error <> 0 begin
   print 'Error en generacion de data base'
   return 1
end
print 'oc4'
create index idx1 on #oc_manejo_cartera(mca_banco)
create index idx2 on #oc_manejo_cartera(mca_cliente)
print 'oc5'
--CALCULO DE MAXIMO DE DIAS DE ATRASO CICLO ANTERIOR 
select distinct
grupo         = mca_grupo,
ciclo         = isnull(mca_ciclo,0) -1
into #oc_grupos_ciclo
from #oc_manejo_cartera
where mca_ciclo >= 2
print 'oc6'
SELECT ogrupo      = grupo, 
       dias_atraso = max(isnull(CASE WHEN datediff(dd, di_fecha_ven, di_fecha_can ) <= 0 THEN 0 ELSE datediff(dd, di_fecha_ven, di_fecha_can ) END, 0)),
       ociclo      = isnull(ciclo,0)
  into #oc_atraso_anterior
  FROM #oc_grupos_ciclo,
       cob_cartera..ca_ciclo,
       cob_cartera..ca_det_ciclo,
       cob_cartera..ca_dividendo
 WHERE ci_grupo = grupo
   AND ci_ciclo = ciclo
   AND ci_grupo = dc_grupo
   AND ci_ciclo = dc_ciclo_grupo 
   AND dc_operacion = di_operacion
 GROUP BY grupo, ciclo
print 'oc7'
update #oc_manejo_cartera set 
mca_atraso_max_ant = dias_atraso 
from #oc_atraso_anterior
where mca_grupo = ogrupo 
and   mca_ciclo = ociclo +1


----------------------------------------
--Actualizaciones Masivas
--------------------------
print 'oc8'
update #oc_manejo_cartera set 
mca_nombre1             = UPPER(isnull(en_nombre,'')),
mca_apellido_paterno    = UPPER(isnull(p_p_apellido,'')),
mca_apellido_materno    = UPPER(isnull(p_s_apellido,'')),
mca_numero_ciclo_ind    = isnull(en_nro_ciclo,0),
mca_nivel_riesgo        = ea_nivel_riesgo_cg
from cobis..cl_ente, cobis..cl_ente_aux
where en_ente = mca_cliente 
and   en_ente = ea_ente                                   
                               
print 'oc9'                                    
--Actualiza LCR
-----------------------
update #oc_manejo_cartera set
mca_numero_ciclo_ind    = (select count(distinct(do_banco)) from sb_dato_operacion where do_codigo_cliente = mca_cliente and do_tipo_operacion='REVOLVENTE')
from #oc_manejo_cartera
where mca_toperacion = 'REVOLVENTE'
------------------------
print 'oc10'
update #oc_manejo_cartera
set mca_nombre_grupo = gr_nombre
from cobis..cl_grupo
where gr_grupo = mca_grupo

if @@error <> 0 begin
   print 'Error Actualizando Nombre Grupo'
   return 1
end
print 'oc12'
--------------------------------
/* ENTRAR BORRANDO LA TABLA DE TRABAJO */
if not object_id('sb_operacion_cancelada') is null drop table sb_operacion_cancelada
print 'oc13'
select
'CC'                             = isnull(mca_oficina,0),                                
'CONTRATO'                       = isnull(mca_banco,' '),                                  
'ID GRUPO'                       = isnull(mca_grupo,0),                                  
'NOMBRE GRUPO'                   = isnull(mca_nombre_grupo,' '),                                            
'CLIENTE COBIS'                  = isnull(mca_cliente,0),                                                                                                     
'APELLIDO PATERNO'               = isnull(mca_apellido_paterno,' '),                    
'APELLIDO MATERNO'               = isnull(mca_apellido_materno,' '),                     
'NOMBRE1'                        = isnull(mca_nombre1,' '),                                                                                                
'CICLO INDIVIDUAL'               = isnull(mca_numero_ciclo_ind,0),
'PRODUCTO DE PRESTAMOS'          = isnull(mca_toperacion,' '),
'DIAS MAX ATRASO ANT'            = isnull(mca_atraso_max_ant,0),
'DIAS MAX ATRASO ACT'            = (case when isnull(mca_atraso_max_act,0)  < 0 then 0 else isnull(mca_atraso_max_act,0) end ),
'DIAS MORA'                      = isnull(mca_edad_mora,0),
'NIVEL DE RIESGO'                = isnull(mca_nivel_riesgo,' ')
into sb_operacion_cancelada
from #oc_manejo_cartera
print 'oc14'

return 0
go
