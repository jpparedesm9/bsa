/************************************************************************/
/*   Archivo:              sp_grupal_xml_det.sp                         */
/*   Stored procedure:     sp_grupal_xml_det.sp                         */
/*   Base de datos:        cob_credito                                  */
/*   Producto:             Credito                                      */
/*   Disenado por:         SMO                                          */
/*   Fecha de escritura:   22/12/2017                                   */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                                PROPOSITO                             */
/*   El programa sincroniza cada solicitud en la tabla de detalle       */
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*      22/12/2017     SMO              Emision Inicial                 */
/*      11/01/2021     SRO              Requerimiento #140073           */
/*      11/02/2021     PRO              Requerimiento #147999           */
/*      10/03/2021     SRO              Requerimiento #147999 V2        */
/*      20/10/2021     DCU              Cambio Error #171068            */
/************************************************************************/
use cob_credito
go
IF OBJECT_ID ('sp_grupal_xml_det') IS NOT NULL
	DROP PROCEDURE sp_grupal_xml_det
GO

create proc sp_grupal_xml_det (
    @i_en_linea      CHAR (1)    = 'S',
    @t_file          varchar(14) = null,
    @t_debug         char(1)     = 'N',
    @i_origen        varchar(32) = '',
    @i_inst_proc     int         = NULL,
    @i_secuencial	 int         =0,
    @i_tramite       int
    
    
)
as
declare
--@w_tramite             INT,
@w_tc_si_sincroniza    SMALLINT,
@w_cod_entidad         VARCHAR(10),
--@w_max_si_sincroniza   INT,
@w_fech_proc           DATETIME,
@w_operacion           INT,
@w_des_entidad         VARCHAR(64),
@w_xml                 varchar(max),
@w_accion              VARCHAR(255),
@w_observacion         VARCHAR(5000),
@w_error               INT,
@w_sp_name             VARCHAR(32),
@w_msg                 VARCHAR(100),
@w_oficial             INT,
@w_user                login,
@w_grupo               INT,
@w_gr_ente             INT,
@w_coment_1            varchar(255),
@w_coment_2            varchar(255),
@w_id_observacion      smallint,
@w_linea               smallint,
@w_coment_asig         varchar(255),
@w_id_asig_act         int,
@w_id_inst_act         int,
@w_cl_code             INT,
@w_diff_horaria        bigint,
@w_num_miembros        int,
@w_proceso			   int,
@w_request_type        varchar(5),
@w_nom_proceso		   varchar(100)

select @w_sp_name = 'sp_grupal_xml_det'

--Diferencia horaria 
select @w_diff_horaria = ABS(datepart(TZOFFSET, sysdatetimeoffset())*60*1000)

--Datos de la Entidad -- Grupal
select @w_cod_entidad = 3
SELECT @w_cod_entidad = codigo,
       @w_des_entidad = valor
FROM cobis..cl_catalogo
WHERE tabla = ( SELECT codigo  FROM cobis..cl_tabla
                WHERE tabla = 'si_sincroniza') AND codigo = @w_cod_entidad

--Fecha de Proceso
SELECT @w_fech_proc = fp_fecha FROM cobis..ba_fecha_proceso

--Tramite
/*SELECT @w_tramite = io_campo_3 FROM cob_workflow..wf_inst_proceso WHERE io_id_inst_proc = @i_inst_proc
if @@rowcount = 0
begin
    select @w_error = 150000 -- ERROR EN INSERCION,
    select @w_msg = 'Solicitud Grupal: No existe informacion para esa instancia de proceso'
    goto ERROR
end
*/
---Número de operacion y usuario
SELECT @w_operacion = op_operacion
FROM cob_cartera..ca_operacion OP WHERE op_tramite = @i_tramite

/*SELECT @w_user      = (SELECT fu_login from cobis..cl_funcionario, cobis..cc_oficial
                       WHERE oc_funcionario = fu_funcionario AND oc_oficial = TR.tr_oficial)
FROM cob_credito..cr_tramite TR
WHERE tr_tramite = @i_tramite

if @w_user is null
begin
    select @w_error = 150000 -- ERROR EN INSERCION,
    select @w_msg = 'No existe Oficial'
    goto ERROR
end*/

-- Comentarios
SELECT @w_accion = 'ACTUALIZAR'
-- Observaciones
declare @w_aa_id_asig_act int, @w_texto varchar(max) = ''

select 	
@w_aa_id_asig_act     = io_campo_2,
@w_proceso            = io_codigo_proc
from cob_workflow..wf_inst_proceso 
where io_id_inst_proc = @i_inst_proc

select @w_aa_id_asig_act = case when @w_aa_id_asig_act = 0 then null else @w_aa_id_asig_act end

select @w_nom_proceso = pr_nombre_proceso
from cob_workflow..wf_proceso
WHERE pr_codigo_proceso = @w_proceso

if(@w_nom_proceso = 'SOLICITUD CREDITO GRUPAL - RENOVACIÓN')
begin
	select @w_request_type = 'REN'
end
else
begin
    select @w_request_type = 'NOR'
end

select DISTINCT @w_observacion = ol_texto
from cob_workflow..wf_observaciones OB, cob_workflow..wf_ob_lineas OL
where OB.ob_id_asig_act        = OL.ol_id_asig_act
and ob_id_asig_act             = @w_aa_id_asig_act
AND ol_observacion             = (SELECT max(ol_observacion) FROM cob_workflow..wf_ob_lineas
                                  where OB.ob_id_asig_act = ol_id_asig_act
                                  and OB.ob_id_asig_act = @w_aa_id_asig_act)

if (@w_aa_id_asig_act is null)
begin
	
	SELECT @w_accion = 'Observaciones'
	
	/* Comentarios para buscar */
	select @w_coment_1 = 'El grupo excede CONDICIONADOS, se recomienda eliminar%'
	select @w_coment_2 = '%no tienen cuenta de ahorro en Banco Santander.'
	
	select @w_id_inst_act = ia_id_inst_act
	from cob_workflow..wf_inst_actividad 
	where ia_id_inst_proc = @i_inst_proc
	and   ia_estado       in ('INA', 'ACT')
	
	select @w_id_asig_act = aa_id_asig_act 
	from cob_workflow..wf_asig_actividad 
	where aa_id_inst_act = @w_id_inst_act
	
	select @w_id_observacion = 0
	while 1=1
	begin
		select @w_id_observacion = ol_observacion  
		from cob_workflow..wf_ob_lineas 
		where ol_id_asig_act = @w_id_asig_act
		and ((ol_texto like @w_coment_1)
		or (ol_texto like @w_coment_2))
		and ol_observacion > @w_id_observacion
		order by ol_observacion asc
		
		if @@rowcount = 0
		  break
		
		select @w_linea
		while 1=1
		begin
			select @w_linea 		= ol_linea,
			       @w_coment_asig	= ol_texto
			from cob_workflow..wf_ob_lineas 
			where ol_id_asig_act = @w_id_asig_act
			and ol_observacion = @w_id_observacion
			and ol_linea > @w_linea
			order by ol_linea asc
			
			if @@rowcount = 0
		  		break
			
			if(@w_coment_asig is not null)
			begin
				if(len(@w_observacion) = 5000)
				begin
					break
				end
				else
				begin
					select @w_observacion = @w_observacion + @w_coment_asig
				end
			end
		end
		
	end
	
end

SELECT @w_observacion = isnull(@w_observacion,'ACTUALIZAR INFORMACION') + isnull(@i_origen,'')

select 	
   'cliente'    = tg_cliente, 
   'prestamo'   = tg_prestamo, 
   'operacion'  = tg_operacion, 
   'saldo'      = sum(am_acumulado + am_gracia - am_pagado)   
into #montos_tmp
from cr_tramite_grupal, cob_cartera..ca_amortizacion
where tg_referencia_grupal =(select op_anterior from cob_cartera..ca_operacion where op_tramite=@i_tramite)
and am_operacion =  tg_operacion 
group by tg_cliente, tg_prestamo, tg_operacion

create table #cr_tramite_grupal_miembros(
   w_tg_monto	 	      MONEY,
   w_tg_monto_aprobado    MONEY,
   w_en_ente              INT,
   w_cg_nro_ciclo         INT null ,
   w_tr_porc_garantia     VARCHAR(20),
   w_en_nomlar            VARCHAR(254),
   w_tg_participa_ciclo   CHAR(1),
   w_tg_monto_max         money,
   w_en_calificacion      VARCHAR(10),
   w_cg_rol               VARCHAR(10), 
   w_cg_ahorro_voluntario MONEY,
   w_en_nit               VARCHAR(30),
   w_tramite              INT,
   w_check_renapo         char(1),
   w_saldo_anterior       money null,
   w_monto_resultado      money null
)
				   
				 
INSERT INTO  #cr_tramite_grupal_miembros 
SELECT 
'amountRequestedOriginal' = tg_monto,
'authorizedAmount'        = isnull(tg_monto_aprobado,0.0),
'code'                    = en_ente,
'cycleNumber'             = null,
'liquidGuarantee'         = convert(VARCHAR(20),((ISNULL(tr_porc_garantia,0))*tg_monto/100)),
'name'                    = rtrim(en_nomlar),
'participant'             = tg_participa_ciclo,
'proposedMaximumAmount'   = tg_monto_max,
'riskLevel'               = (ISNULL(en_calificacion,'')),
'role'                    = cg_rol,
'voluntarySavings'        = cg_ahorro_voluntario,
'rfc'                     = en_nit,
'w_tramite'               = @i_tramite,
'w_check_renapo'		  = (select ea_consulto_renapo FROM cobis..cl_ente_aux where ea_ente = en_ente),
'previousBalance'		  = isnull((select saldo from #montos_tmp where cliente = en_ente),0.00),
'resultAmount'            = isnull(tg_monto_aprobado,0.0) - isnull((select saldo from #montos_tmp where cliente = en_ente),0.00)
FROM cob_credito..cr_tramite_grupal TG,
     cobis..cl_ente EN,
	 cobis..cl_cliente_grupo CG,
	 cob_credito..cr_tramite T
WHERE TG.tg_cliente = EN.en_ente
AND   TG.tg_cliente = CG.cg_ente
AND   TG.tg_tramite = T.tr_tramite
AND   TG.tg_grupo  = CG.cg_grupo
AND   TG.tg_tramite = @i_tramite
and   CG.cg_estado  = 'V'
           		  	 
SELECT  TOP 1 @w_grupo = tg_grupo 
FROM  cob_credito..cr_tramite_grupal 
WHERE tg_tramite       = @i_tramite  			   

SELECT @w_gr_ente=0
while 1=1 -- while para barrerse los clientes del grupo
begin
    select top 1
    @w_gr_ente                 = cg_ente
    from cobis..cl_cliente_grupo
    WHERE cg_grupo             = @w_grupo
    and cg_ente                > @w_gr_ente
    AND cg_estado              ='V' 
	AND cg_fecha_desasociacion IS null
    order by cg_ente

    if @@rowcount = 0 BREAK --para salir del break
     
   
   IF NOT EXISTS (SELECT 1 FROM #cr_tramite_grupal_miembros WHERE w_en_ente=@w_gr_ente) BEGIN

      INSERT INTO #cr_tramite_grupal_miembros 
      SELECT 
	  w_tg_monto =  0,
      'authorizedAmount'        = 0,
      'code'                    = en_ente,
      'cycleNumber'             = en_nro_ciclo,
      'liquidGuarantee'         = null,
      'name'                    = rtrim(en_nomlar),
      'participant'             = 'N',
      'proposedMaximumAmount'   = 0,
      'riskLevel'               = (ISNULL(en_calificacion,'')),
      'role'                    = cg_rol,
      'voluntarySavings'        = cg_ahorro_voluntario,
      'rfc'                     = en_nit,
      'w_tramite'               =@i_tramite,
	  'w_check_renapo'		  = (select ea_consulto_renapo FROM cobis..cl_ente_aux where ea_ente = en_ente),
      'previousBalance'		  = isnull((select saldo from #montos_tmp where cliente = en_ente),0.00),
      'resultAmount'            = 0
       FROM cobis..cl_ente EN,
       cobis..cl_cliente_grupo CG
       WHERE EN.en_ente=CG.cg_ente
       AND EN.en_ente=@w_gr_ente
   
    END
    
END --end del while para barrerse los clientes del grupo				   
 	   			   
update #cr_tramite_grupal_miembros set 
w_cg_nro_ciclo = (select isnull(max(dc_ciclo_grupo), 0 ) +1
                  from cob_cartera..ca_det_ciclo
                  where  dc_cliente = w_cg_nro_ciclo)
			   
update #cr_tramite_grupal_miembros set 
w_cg_nro_ciclo       = 1
where w_cg_nro_ciclo is null

select @w_num_miembros = count(1) from #cr_tramite_grupal_miembros 
-- Inicio XML

SELECT @w_xml = '<creditGroupApplicationSynchronizedData><creditGroupApplication>'

SELECT @w_xml = @w_xml +
	'<applicationDate>' + convert(varchar(30),(CAST(Datediff(s, '1970-01-01', format(op_fecha_liq,'yyyy-MM-dd')) AS BIGINT)*1000)+@w_diff_horaria) + '</applicationDate>' +
	'<applicationType>' + OP.op_toperacion + '</applicationType>' +
	'<groupAgreeRenew>' + (CASE TR.tr_acepta_ren WHEN 'S' THEN 'true' ELSE 'false' END) + '</groupAgreeRenew>' +
	'<groupAmount>' + convert(varchar, OP.op_monto) + '</groupAmount>' +
	'<groupCycle>' + convert(varchar, G.gr_num_ciclo) + '</groupCycle>' +
	'<groupName>' + G.gr_nombre + '</groupName>' +
	'<groupNumber>' + convert(varchar, G.gr_grupo) + '</groupNumber>' +
	'<office>' + (SELECT of_nombre FROM cobis..cl_oficina WHERE of_filial = 1 AND of_oficina = TR.tr_oficina) + '</office>' +
	'<officer>' + (select fu_nombre from cobis..cl_funcionario, cobis..cc_oficial where oc_funcionario = fu_funcionario AND oc_oficial = TR.tr_oficial) + '</officer>' +
	'<processInstance>' + convert(varchar,@i_inst_proc) + '</processInstance>' + 
	'<promotion>' + (CASE TR.tr_promocion WHEN 'S' THEN 'true' ELSE 'false' END) + '</promotion>' +
	'<rate>' + convert (VARCHAR(30),(SELECT ro_porcentaje FROM cob_cartera..ca_rubro_op WHERE  ro_operacion = OP.op_operacion AND OP.op_tramite = TR.tr_tramite AND ro_concepto  = 'INT')) + '</rate>' +
	'<requestType>' + @w_request_type +'</requestType>' +
	CASE 
		WHEN TR.tr_no_acepta is not null
			THEN '<reasonNotAccepting>' + TR.tr_no_acepta + '</reasonNotAccepting>'
			ELSE ''
		END
	+
	CASE 
		WHEN OP.op_plazo is not null
			THEN '<term>' + convert(varchar,OP.op_plazo) + '</term>'
			ELSE ''
		END
	+
	CASE 
		WHEN OP.op_desplazamiento is not null
			THEN '<displacement>' + convert(varchar,OP.op_desplazamiento) + '</displacement>'
			ELSE ''
		END
FROM cob_cartera..ca_operacion OP, cobis..cl_grupo G, cob_credito..cr_tramite TR
where OP.op_tramite = TR.tr_tramite
AND OP.op_cliente = G.gr_grupo
AND TR.tr_tramite = @i_tramite

select @w_cl_code = 0
WHILE 1 = 1
BEGIN
	
	select top 1 @w_cl_code = w_en_ente
    from #cr_tramite_grupal_miembros
    WHERE w_en_ente > @w_cl_code
    order by w_en_ente asc

    if @@rowcount = 0 BREAK --para salir del break
    
    SELECT @w_xml = @w_xml + '<members>' +
    	'<amountRequestedOriginal>' + CONVERT(varchar, w_tg_monto) + '</amountRequestedOriginal>' +
    	'<authorizedAmount>' + CONVERT(varchar, w_tg_monto_aprobado) + '</authorizedAmount>' +
    	'<code>' + convert(varchar, @w_cl_code) + '</code>' +
    	CASE 
		WHEN w_cg_nro_ciclo is not null
			THEN '<cycleNumber>' + convert(varchar, w_cg_nro_ciclo) + '</cycleNumber>'
			ELSE ''
		END
		+
    	'<liquidGuarantee>' + convert(VARCHAR(20),((ISNULL(w_tr_porc_garantia,0))*w_tg_monto/100)) + '</liquidGuarantee>' +
    	'<name>' + rtrim(w_en_nomlar) + '</name>' +
    	'<participant>' + 
    	CASE   
      		WHEN w_tg_participa_ciclo ='S' THEN 'true'   
      		WHEN w_tg_participa_ciclo ='N' THEN 'false'   
      	END
      	+
    	'</participant>' +
    	CASE 
		WHEN w_tg_monto_max is not null
			THEN '<proposedMaximumAmount>' + CONVERT(varchar, w_tg_monto_max) + '</proposedMaximumAmount>'
			ELSE ''
		END
		+
		CASE 
		WHEN w_en_calificacion is not null
			THEN '<riskLevel>' + CONVERT(varchar, w_en_calificacion) + '</riskLevel>'
			ELSE '<riskLevel/>'
		END
		+
		'<role>' + w_cg_rol + '</role>' +
		'<voluntarySavings>' + CONVERT(varchar,w_cg_ahorro_voluntario) + '</voluntarySavings>' +
		'<rfc>' + w_en_nit + '</rfc>' +	
		'<checkRenapo>'+ w_check_renapo + '</checkRenapo>' +
		'<previousBalance>'+ CONVERT(varchar,w_saldo_anterior) +'</previousBalance>'+
		'<resultAmount>'+ CONVERT(varchar,w_monto_resultado) +'</resultAmount>'+
    	'</members>'
    from #cr_tramite_grupal_miembros
    where w_en_ente = @w_cl_code
END

if @w_num_miembros = 0 or @w_num_miembros is null begin 
   select @w_xml = @w_xml + '<members/>'
end

SELECT @w_xml = @w_xml + '</creditGroupApplication></creditGroupApplicationSynchronizedData>'

-- Insert en si_sincroniza_det
INSERT INTO cob_sincroniza..si_sincroniza_det 
(sid_secuencial,       sid_id_entidad, sid_id_1,
sid_id_2,              sid_xml,        sid_accion,
sid_observacion)
VALUES 
(@i_secuencial,       @i_inst_proc,   @i_tramite,
@w_operacion,         @w_xml,         @w_accion,
@w_observacion)

if @@error <> 0 begin
   select @w_error = 150000 -- ERROR EN INSERCION
   goto ERROR
end
return 0

ERROR:
IF @i_en_linea = 'S'
begin --Devolver mensaje de Error
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = @w_error,
   @i_msg   = @w_msg
   
   return @w_error
END
ELSE
    return @w_error
go
