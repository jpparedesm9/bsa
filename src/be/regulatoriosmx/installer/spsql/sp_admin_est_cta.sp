/*   Archivo:                 sp_admin_est_cta.sp                        */
/*   Stored procedure:        sp_admin_est_cta                           */
/*   Base de Datos:           cob_conta_super                           */
/*   Producto:                Cartera                                   */
/*   Disenado por:                                                      */
/*   Fecha de Documentacion:  18/02/2020                                */
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
/*   Generar reporte operativo de cartera y archivo plano respectivo    */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*   Fecha      Nombre          Proposito                               */
/*   18/02/2020 PXSG   Emision Inicial                                  */
/************************************************************************/

use cob_conta_super
go

if not object_id('sp_admin_est_cta') is null
   drop proc sp_admin_est_cta
go

create  proc sp_admin_est_cta
   @i_toperacion         varchar(25)    = null,   --Tipo de Operacion
   @t_show_version       bit            = 0,
   @t_debug              char(1)         = 'N',
   @t_file               varchar(10)     = null

AS

Declare
@w_sp_name               varchar(32),
@w_fecha_proceso         datetime, 
@w_num_meses             int,
@w_fin_aux               datetime,
@w_fecha_eli_aux         datetime,
@w_fecha_eli             varchar (10),
@w_estado                char (1),--estado para ejecutar la eliminacion solo en el finde mes habil
@w_mes_aux               int      ,
@w_anio_aux              int      , 
@w_reporte               varchar(10),
@w_fecha_eli_fin         varchar (8),
@w_nombre                varchar(25),
@w_error                 int

if @t_show_version = 1
begin
    print 'Stored procedure sp_admin_est_cta, Version 1.0.0'
    return 0
end
--------------------------------------------------------------------------------------

/*  Inicializacion de Variables  */
select  @w_sp_name = 'sp_admin_est_cta'

--tipo de Operaciones 
--GENEARAR XML = 'GXML'
--TIMBRAR XML  = 'TIXML'
--GENERAR PDF  = 'GEPDF'
--ENVIAR MAIL  = 'EVMAIL'
--
select   
      'tipo_operacion'  = cr_etiqueta.cr_max_value,
      'generar_xml'         = cr_2.cr_max_value,
      'timbrar_xml'         = cr_3.cr_max_value,
      'generar_pdf'         = cr_4.cr_max_value,
      'enviar_email'        = cr_5.cr_max_value
       into #temp_admin_est_cta 
from cob_pac..bpl_rule r

        inner join cob_pac..bpl_rule_version rv on rv.rl_id = r.rl_id
        
        inner join cob_pac..bpl_condition_rule cr_etiqueta on rv.rv_id = cr_etiqueta.rv_id and cr_etiqueta.cr_parent is null
        
        inner join cob_workflow..wf_variable v_cr_etiqueta on v_cr_etiqueta.vb_codigo_variable = cr_etiqueta.vd_id
        
        inner join cob_pac..bpl_condition_rule cr_2 on rv.rv_id = cr_2.rv_id and cr_2.cr_parent = cr_etiqueta.cr_id
        
        inner join cob_workflow..wf_variable v_2 on v_2.vb_codigo_variable = cr_2.vd_id
        
        inner join cob_pac..bpl_condition_rule cr_3 on rv.rv_id = cr_3.rv_id and cr_3.cr_parent = cr_2.cr_id
        
        inner join cob_workflow..wf_variable v_3 on v_3.vb_codigo_variable = cr_3.vd_id
        inner join cob_pac..bpl_condition_rule cr_4 on rv.rv_id = cr_4.rv_id and cr_4.cr_parent = cr_3.cr_id
        
        inner join cob_workflow..wf_variable v_4 on v_4.vb_codigo_variable = cr_4.vd_id
        inner join cob_pac..bpl_condition_rule cr_5 on rv.rv_id = cr_5.rv_id and cr_5.cr_parent = cr_4.cr_id
        
        inner join cob_workflow..wf_variable v_5 on v_5.vb_codigo_variable = cr_5.vd_id        
        
 where rl_acronym = 'AdmEstCta' and rv.rv_status = 'PRO'
 

 
--Orden de salida de para ver si se ejecuta o no Tenr cuidado ya que se devulve al java 

 select generar_xml,--1 Generar Xml
        timbrar_xml,--2 Timbrar Xml
        generar_pdf,--3 Generar Pdf
        enviar_email--4 Enviar Mail
from #temp_admin_est_cta 
where tipo_operacion=@i_toperacion


return 0
go

