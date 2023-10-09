/************************************************************************/
/*   Archivo:              sp_individual_xml.sp                         */
/*   Stored procedure:     sp_individual_xml                            */
/*   Base de datos:        cob_credito                                  */
/*   Producto:             Credito                                      */
/*   Disenado por:         ACHP                                         */
/*   Fecha de escritura:   01/08/2017                                   */
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
/* Ingresa en las tablas de cob_sincroniza, si_sincroniza,              */
/* y genera el XML si_sincroniza_det                                    */
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*      01/08/2017     ACHP             Emision Inicial                 */
/*      13/10/2017     P. Ortiz         Correccion de conversion True   */
/*      15/03/2019     SRO              Corrección esquema secuenciales */
/*                                      en si_sincroniza                */
/*      30/06/2021     SRO              #ERROR 161777                   */
/************************************************************************/
USE cob_credito
GO

if exists (select 1 from sysobjects where name = 'sp_individual_xml')
drop proc sp_individual_xml
go

create proc sp_individual_xml (
    @t_file       varchar(14) = null,
    @t_debug      char(1)     = 'N',
    @i_inst_proc  int         = NULL
)
as
declare
    @w_tramite             INT,
    @w_tc_si_sincroniza    SMALLINT,
    @w_cod_entidad         VARCHAR(10),
    @w_codigo              INT,
    @w_fech_proc           DATETIME,
    @w_operacion           INT,
    @w_des_entidad         VARCHAR(64),
    @w_xml                 XML,
    @w_accion              VARCHAR(255),
    @w_observacion         VARCHAR(255),
    @w_error               INT,
    @w_sp_name             VARCHAR(32),
    @w_msg                 VARCHAR(100),
    @w_user                login

select @w_sp_name = 'sp_individual_xml'

--Datos de la Entidad -- Individual
select @w_cod_entidad = 4
SELECT @w_cod_entidad = codigo,
       @w_des_entidad = valor
FROM cobis..cl_catalogo
WHERE tabla = ( SELECT codigo  FROM cobis..cl_tabla
                WHERE tabla = 'si_sincroniza') AND codigo = @w_cod_entidad

--Fecha de Proceso
SELECT @w_fech_proc = fp_fecha FROM cobis..ba_fecha_proceso

--Tramite
SELECT @w_tramite = io_campo_3 FROM cob_workflow..wf_inst_proceso WHERE io_id_inst_proc = @i_inst_proc
if @@rowcount = 0
begin
    select @w_error = 150000 -- ERROR EN INSERCION,
    select @w_msg = 'Solicitud Individual: No existe informacion para esa instancia de proceso'
    goto ERROR
end

---Número de operacion
SELECT @w_operacion = op_operacion,
       @w_user      = (SELECT fu_login from cobis..cl_funcionario, cobis..cc_oficial
                       WHERE oc_funcionario = fu_funcionario AND oc_oficial = OP.op_oficial)
FROM cob_cartera..ca_operacion OP WHERE op_tramite = @w_tramite

if @w_user is null
begin
    select @w_error = 150000 -- ERROR EN INSERCION,
    select @w_msg = 'No existe Oficial'
    goto ERROR
end

-- Comentarios
SELECT @w_accion = 'ACTUALIZAR'
-- Observaciones
declare @w_aa_id_asig_act int, @w_texto varchar(max) = ''
select @w_aa_id_asig_act = io_campo_5
from cob_workflow..wf_inst_proceso where io_id_inst_proc = @i_inst_proc

select @w_observacion = @w_observacion + ' ' + ol_texto
from cob_workflow..wf_observaciones OB, cob_workflow..wf_ob_lineas OL
where OB.ob_id_asig_act = OL.ol_id_asig_act
and ob_id_asig_act = @w_aa_id_asig_act

SELECT @w_observacion = isnull(@w_observacion,'ACTUALIZAR INFORMACION')

-- Inicio XML

    select @w_xml = (
SELECT 
tag, 
parent,
           [creditIndividualApplicationSynchronizedData!1!valor],--1
           [creditIndividualApplication!2!valor],                --2
           [applicationData!3!valor],                            --3
		     [applicationData!3!processInstance!ELEMENT],          --3
           [applicationData!3!amountOriginalRequest!ELEMENT],    --4
           [applicationData!3!applicationType!ELEMENT],          --5
           [applicationData!3!authorizedAmount!ELEMENT],         --6
           [applicationData!3!creditDestination!ELEMENT],        --7
           [applicationData!3!frecuency!ELEMENT],                --8
           [applicationData!3!promotion!ELEMENT],                --9
           [applicationData!3!rate!ELEMENT],                     --10
           [applicationData!3!term!ELEMENT],                     --11
           [customerData!4!valor],                               --12
           [customerData!4!agreeRenew!ELEMENT],                  --13
           [customerData!4!applicationDate!ELEMENT],             --14
           [customerData!4!avalCode!ELEMENT],                    --15
           [customerData!4!avalName!ELEMENT],                    --16
           [customerData!4!avalRfc!ELEMENT],                     --17
           [customerData!4!avalRiskLevel!ELEMENT],               --18
           [customerData!4!code!ELEMENT],                        --19
           [customerData!4!cycle!ELEMENT],                       --20
           [customerData!4!lastAmountApplication!ELEMENT],       --21
           [customerData!4!name!ELEMENT],                        --22
           [customerData!4!office!ELEMENT],                      --23
           [customerData!4!officer!ELEMENT],                     --24
           [customerData!4!partner!ELEMENT],                     --25
           [customerData!4!rfc!ELEMENT],                         --26
           [customerData!4!riskLevel!ELEMENT]                    --27
    FROM
    (
    SELECT 1 AS tag,
    NULL AS parent,
    NULL AS [creditIndividualApplicationSynchronizedData!1!valor],--1
    NULL AS [creditIndividualApplication!2!valor],                --2

    NULL AS [applicationData!3!valor],                            --3
	NULL AS [applicationData!3!processInstance!ELEMENT],          --3
    NULL AS [applicationData!3!amountOriginalRequest!ELEMENT],    --4
    NULL AS [applicationData!3!applicationType!ELEMENT],          --5
    NULL AS [applicationData!3!authorizedAmount!ELEMENT],         --6
    NULL AS [applicationData!3!creditDestination!ELEMENT],        --7
    NULL AS [applicationData!3!frecuency!ELEMENT],                --8
    NULL AS [applicationData!3!promotion!ELEMENT],                --9
    NULL AS [applicationData!3!rate!ELEMENT],                     --10
    NULL AS [applicationData!3!term!ELEMENT],                     --11

    NULL AS [customerData!4!valor],                               --12
    NULL AS [customerData!4!agreeRenew!ELEMENT],                  --13
    NULL AS [customerData!4!applicationDate!ELEMENT],             --14
    NULL AS [customerData!4!avalCode!ELEMENT],                    --15
    NULL AS [customerData!4!avalName!ELEMENT],                    --16
    NULL AS [customerData!4!avalRfc!ELEMENT],                     --17
    NULL AS [customerData!4!avalRiskLevel!ELEMENT],               --18
    NULL AS [customerData!4!code!ELEMENT],                        --19
    NULL AS [customerData!4!cycle!ELEMENT],                       --20
    NULL AS [customerData!4!lastAmountApplication!ELEMENT],       --21
    NULL AS [customerData!4!name!ELEMENT],                        --22
    NULL AS [customerData!4!office!ELEMENT],                      --23
    NULL AS [customerData!4!officer!ELEMENT],                     --24
    NULL AS [customerData!4!partner!ELEMENT],                     --25
    NULL AS [customerData!4!rfc!ELEMENT],                         --26
    NULL AS [customerData!4!riskLevel!ELEMENT]                    --27

    UNION ALL
    SELECT 2 AS tag,
    1 AS parent,
    NULL,--1
    NULL,
    NULL,--3
	NULL,--3
    NULL,
    NULL,--5
    NULL,
    NULL,--7
    NULL,
    NULL,--9
    NULL,
    NULL,--11
    NULL,
    NULL,--13
    NULL,
    NULL,--15
    NULL,
    NULL,--17
    NULL,
    NULL,--19
    NULL,
    NULL,--21
    NULL,
    NULL,--23
    NULL,
    NULL,--25
    NULL,
    NULL--27

    UNION ALL
    SELECT 3 AS tag,
    2 AS parent,
    NULL,--1
    NULL,
    NULL,--3
	'processInstance'       = @i_inst_proc,--3,
    'amountOriginalRequest' = op_monto_aprobado,
    'applicationType'       = op_toperacion,
    'authorizedAmount'      = op_monto,
    'creditDestination'     = OP.op_destino,
    'frecuency'             = TR.tr_tipo_plazo,
    'promotion'             = (CASE TR.tr_promocion WHEN 'S' THEN 'true' ELSE 'false' END),
    'rate'                  =  convert (VARCHAR(30),(SELECT ro_porcentaje FROM cob_cartera..ca_rubro_op
                               WHERE  ro_operacion = OP.op_operacion
                               AND OP.op_tramite = TR.tr_tramite
                               AND ro_concepto  = 'INT')),
    'term' = tr_plazo,
    NULL,
    NULL,--13
    NULL,
    NULL,--15
    NULL,
    NULL,--17
    NULL,
    NULL,--19
    NULL,
    NULL,--21
    NULL,
    NULL,--23
    NULL,
    NULL,--25
    NULL,
    NULL--27
    FROM  cob_cartera..ca_operacion OP, cob_credito..cr_tramite TR
    WHERE op_tramite = tr_tramite
    AND tr_tramite = @w_tramite

    UNION ALL
    SELECT 4 AS tag,
    2 AS parent,
    NULL,--1
    NULL,
    NULL,--3
	NULL,--3
    NULL,
    NULL,--5
    NULL,
    NULL,--7
    NULL,
    NULL,--9
    NULL,
    NULL,--11
    NULL,
    'agreeRenew'            = tr_acepta_ren,
    'applicationDate'       = (SELECT format(op_fecha_liq,'yyyy-MM-ddTHH:mm:ssZ')), --op_fecha_liq,
    'avalCode'              = tr_alianza,
    'avalName'              = (SELECT en_nomlar FROM cobis..cl_ente WHERE en_ente =  TR.tr_alianza),
    'avalRfc'               = (SELECT en_nit    FROM cobis..cl_ente WHERE en_ente =  TR.tr_alianza),
    'avalRiskLevel'         = (SELECT ISNULL(en_calificacion,'') FROM cobis..cl_ente WHERE en_ente =  TR.tr_alianza),
    'code'                  = en_ente,
    'cycle'                 = en_nro_ciclo,
    'lastAmountApplication' = (SELECT TOP 1 op_monto FROM cob_cartera..ca_operacion
                               WHERE op_cliente = OP.op_cliente AND op_estado NOT in (0,6,99)
                               ORDER BY op_operacion DESC),
    'name'                  = en_nomlar,
    'office'                = (SELECT of_nombre FROM cobis..cl_oficina WHERE of_filial = 1 AND of_oficina = TR.tr_oficina),
    'officer'               = (select fu_nombre from cobis..cl_funcionario, cobis..cc_oficial
                               where oc_funcionario = fu_funcionario AND oc_oficial = TR.tr_oficial),
    'partner'               = '',
    'rfc'                   = en_nit,
    'riskLevel'             = ISNULL(p_calif_cliente,'')
    FROM cob_credito..cr_tramite TR, cob_cartera..ca_operacion OP, cobis..cl_ente EN
    WHERE TR.tr_tramite = @w_tramite
    AND OP.op_tramite = TR.tr_tramite
    AND OP.op_cliente = EN.en_ente ) AS A FOR XML EXPLICIT )

--Secuencial
exec 
@w_error     = cobis..sp_cseqnos
@t_debug     = @t_debug,
@t_file      = @t_file,
@t_from      = @w_sp_name,
@i_tabla     = 'si_sincroniza',
@o_siguiente = @w_codigo out

if @w_error <> 0 begin
   goto ERROR
end


-- Insert en si_sincroniza
if not exists (select 1 from cob_sincroniza..si_sincroniza where si_secuencial = @w_codigo) begin
   INSERT INTO cob_sincroniza..si_sincroniza 
   (si_secuencial,     si_cod_entidad, si_des_entidad,
   si_usuario,               si_estado,      si_fecha_ing,
   si_fecha_sin,             si_num_reg)
   VALUES                             
   (@w_codigo,         @w_cod_entidad, @w_des_entidad,
   @w_user,                  'P',            @w_fech_proc,
   NULL,                     1)
    
   if @@error <> 0 begin
      select @w_error = 150000 -- ERROR EN INSERCION
      goto ERROR
   end
end else begin
   select @w_error = 2108087, @w_msg = 'ERROR: YA EXISTE UNA SINCRONIZACION CON ESTE SECUENCIAL ' + convert(varchar, @w_codigo)
   print @w_msg
   goto ERROR

end

    -- Insert en si_sincroniza_det
INSERT INTO cob_sincroniza..si_sincroniza_det 
(sid_secuencial,       sid_id_entidad, sid_id_1,
sid_id_2,             sid_xml,        sid_accion,
sid_observacion)
VALUES                                 
(@w_codigo,            @i_inst_proc,   @w_tramite,
@w_operacion,         @w_xml,         @w_accion,
@w_observacion)

if @@error <> 0
begin
    select @w_error = 150000 -- ERROR EN INSERCION
    goto ERROR
end

return 0

ERROR:
begin --Devolver mensaje de Error
    exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = @w_error,
         @i_msg   = @w_msg
    return @w_error
end

go
