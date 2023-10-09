/************************************************************************/
/*   Archivo:              sp_sync_cuestionarios.sp                     */
/*   Stored procedure:     sp_sync_cuestionarios.sp                     */
/*   Base de datos:        cob_credito                                  */
/*   Producto:             Credito                                      */
/*   Disenado por:         SMO                                          */
/*   Fecha de escritura:   22/12/2017                                   */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                           PROPOSITO                                  */
/*   El programa sincroniza los cuestionarios de los subalternos del    */
/*   oficial que recibe como parámetro			                        */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*    FECHA       AUTOR                 CAMBIO                          */
/*  22/12/2017    SMO      Emision Inicial                              */
/*  15/03/2019    SRO      Corrección esquema secuenciales              */
/*                         en si_sincroniza                             */
/*  30/06/2021    SRO      Error #161777                                */
/*  01/03/2023    ACH      REQ#200142 - AplicaciOn Cuestionario         */
/************************************************************************/
USE cob_credito
go
IF OBJECT_ID ('sp_sync_cuestionarios') IS NOT NULL
	DROP PROCEDURE sp_sync_cuestionarios
GO

CREATE proc sp_sync_cuestionarios (
    @i_oficial 	INT
)

AS
DECLARE
@w_sp_name             VARCHAR(32),
@w_accion              VARCHAR(255),
@w_observacion         VARCHAR(255),
@w_num_det			   INT,
@w_cod_entidad		   SMALLINT,
@w_des_entidad         VARCHAR(64),
@w_fecha_proceso       DATETIME,
@w_actividad		   INT,
@w_user				   login,
@w_subalterno 		   INT,
@w_codigo              INT,
@w_grupo 			   INT,
@w_inst_proceso 	   INT,
@w_tramite             INT,
@w_cliente      	   INT,
@w_act_actual 		   INT,
@w_nombre_cl           varchar(64),
@w_error               INT,
@w_msg                 VARCHAR(100),
@w_filas               INT,
@w_param_apli_cuest_gr varchar(64),
@w_codigo_cat_rol      varchar(30),
@w_id_usuario          int,
@w_grupal              bit,
@w_toperacion          varchar(30)

SET @w_sp_name = 'sp_sync_cuestionarios'
SET @w_accion = 'COMPLETAR CUESTIONARIO'
SET @w_observacion = 'POR SINCRONIZACION DE DISPOSITIVO'
SET @w_cod_entidad = 6 --cuestionario grupal
SET @w_num_det = 0
SET @w_toperacion = 'GRUPAL' --Se agrega este parametro porque el sp iba directo contra la tabla cl_grupo.

SELECT @w_des_entidad = valor
FROM cobis..cl_catalogo
WHERE tabla = ( SELECT codigo  FROM cobis..cl_tabla
                WHERE tabla = 'si_sincroniza') AND codigo = @w_cod_entidad

SELECT @w_fecha_proceso = fp_fecha FROM cobis..ba_fecha_proceso

create table #tmp_items_xml (
sec    int,
value  varchar(200),
numero int not null
)

select @w_user = fu_login
from cobis..cl_funcionario, cobis..cc_oficial
where oc_funcionario = fu_funcionario
and oc_oficial = @i_oficial

---***---***---***PorCaso#200142
--**Se obtiene el nombre de las activides de cuestionario por Flujo 
select ac_producto = C.codigo, ac_descp_act = C.valor, ac_codigo_act = convert(int, 0)
into #catalogo_act_cuestionario
from cobis..cl_tabla T, cobis..cl_catalogo C 
where T.tabla = 'cr_act_cuestionario' and T.codigo = C.tabla
if @@rowcount = 0 
begin
   select @w_error = 2101172
   goto ERROR
end

update #catalogo_act_cuestionario
set  ac_codigo_act = ac_codigo_actividad
FROM cob_workflow..wf_actividad 
WHERE ac_nombre_actividad = ac_descp_act

--**Usuario de workflow para tomar actividades 
select @w_id_usuario  = us_id_usuario 
from cob_workflow..wf_usuario 
where us_login = @w_user

--Actividades pendiendes del usuario
select id_actividades = aa_id_inst_act
into #act_pendientes_usu
from cob_workflow..wf_asig_actividad 
where aa_id_destinatario = @w_id_usuario
and aa_estado = 'PEN'

--Actividades de cuestionario por usuario
select ia_id_inst_proc
into #act_pend_usu_cuestionario
from cob_workflow..wf_inst_actividad, #act_pendientes_usu 
where ia_codigo_act in (select ac_codigo_act from #catalogo_act_cuestionario) 
and ia_id_inst_act = id_actividades

--Tomo las actividades que estan en cuestionario activas y en ejecuciOn
select id_proceso = ia_id_inst_proc, 
       tramite = io_campo_3, 
	   toperacion = io_campo_4 
into #actividades_cuestionario
from #act_pend_usu_cuestionario, cob_workflow..wf_inst_proceso
where ia_id_inst_proc = io_id_inst_proc
and io_estado = 'EJE'
and io_campo_4 = @w_toperacion

if exists (select 1 from #actividades_cuestionario) begin
    --Secuencial
    exec  @w_error     = cobis..sp_cseqnos
          @t_debug     = 'N',
          @t_file      = null,
          @t_from      = @w_sp_name,
          @i_tabla     = 'si_sincroniza',
          @o_siguiente = @w_codigo out
    
    if @w_error <> 0 begin
        goto ERROR
    end
    
	--Sincronizacion
    if not exists (select 1 from cob_sincroniza..si_sincroniza where si_secuencial = @w_codigo) begin
        INSERT INTO cob_sincroniza..si_sincroniza (si_secuencial,    si_cod_entidad,   si_des_entidad,    si_usuario,       
    	                                           si_estado,        si_fecha_ing,     si_fecha_sin,      si_num_reg)
                                           VALUES (@w_codigo,        @w_cod_entidad,   @w_des_entidad,    @w_user,    
    									          'P',               GETDATE(),        NULL,              1)  
        if @@error <> 0
        begin
            select @w_error = 150000 -- ERROR EN INSERCION
         	select @w_msg = 'Insertar en si_sincroniza'
         	goto ERROR
        end  
    end else begin
        select @w_error = 2108087, @w_msg = 'ERROR: YA EXISTE UNA SINCRONIZACION CON ESTE SECUENCIAL ' + convert(varchar, @w_codigo)
        print @w_msg
        goto ERROR	
    end

    select @w_inst_proceso = 0
    
	-- Insert en si_sincroniza_det
    while 1 = 1 begin
        select @w_tramite = null, @w_toperacion = null

		SELECT TOP 1
        @w_inst_proceso = id_proceso,
        @w_tramite = tramite,
		@w_toperacion = toperacion
        FROM #actividades_cuestionario
		where id_proceso > @w_inst_proceso
        ORDER BY id_proceso

		if @@rowcount = 0 break

        print '@w_inst_proceso>>'+isnull(convert(varchar(10),@w_inst_proceso),'no existe')
        print '@w_tramite>>'+isnull(convert(varchar(10),@w_tramite),'no existe')

        select @w_cliente    = op_cliente,
               @w_nombre_cl  = op_nombre
        from cob_cartera..ca_operacion
        where op_tramite = @w_tramite

        --if exists(select 1 from cob_credito..cr_tramite where tr_tramite = @w_tramite and tr_grupal = 'S') -- GRUPAL
        --    select @w_grupal = 1  -- GRUPAL
        --else
        --    select @w_grupal = 0 -- INDIVIDUAL

		exec @w_error = sp_xml_cuestionario_det
             @i_fecha_proceso     = @w_fecha_proceso,
             @i_max_si_sincroniza = @w_codigo,
             @i_inst_proc         = @w_inst_proceso,
             @i_tramite           = @w_tramite,
             @i_cliente           = @w_cliente,
             @i_nombre_cl         = @w_nombre_cl,
             @i_grupal            = 1,--@w_grupal,
             @i_accion            = @w_accion,
             @i_observacion       = @w_observacion,
			 @i_toperacion        = @w_toperacion,
             @o_filas             = @w_filas out

        if @w_error <> 0
        begin
            select @w_error = 150000 -- ERROR EN INSERCION,
            select @w_msg = 'Al ejecutra sp_xml_cuestionario_det'
            goto ERROR
        end
        print '@w_filas>>'+convert(VARCHAR(10),@w_filas)

        if @w_filas<>0 SET @w_num_det = @w_num_det+1
		print '@w_num_det>>'+convert(VARCHAR(10),@w_num_det)
	end --end while para cada cliente del subalterno

	if @w_num_det > 0		
        update cob_sincroniza..si_sincroniza 
        set si_num_reg = @w_num_det
        where si_secuencial = @w_codigo
	else
        delete from  cob_sincroniza..si_sincroniza
        where si_secuencial = @w_codigo
end --fin listado #actividades_cuestionario

RETURN 0


ERROR:
begin 
	exec cobis..sp_cerror
  		@t_debug = 'N',
   		@t_file  = 'S',
   		@t_from  = @w_sp_name,
   		@i_num   = @w_error,
      	@i_msg   = @w_msg
    return @w_error
END

GO

