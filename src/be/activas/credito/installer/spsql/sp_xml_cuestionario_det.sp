/* ********************************************************************* */
/*      Archivo:                sp_verificacion_datos.sp                 */
/*      Stored procedure:       sp_verif_datos                           */
/*      Base de datos:          cob_pac                                  */
/*      Producto:               Credito                                  */
/*      Disenado por:           Luis Guachamin                           */
/*      Fecha de escritura:     30-May-2017                              */
/* ********************************************************************* */
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      "MACOSA", representantes exclusivos para el Ecuador de la        */
/*      "NCR CORPORATION".                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de MACOSA o su representante.              */
/*                              PROPOSITO                                */
/*      Generar XML para cuestionarios GRUPAL e INDIVIDUAL               */
/* ********************************************************************* */
/*                              MODIFICACIONES                           */
/*      FECHA       AUTOR        RAZON                                   */
/*  30/05/2017     LGU           Version Inicial                         */
/*  09/11/2017     P. Ortiz      Quitar espacio de respuestas            */
/*  31/07/2018     D. Cambios    Validacion fechas                       */
/*  19/NOV/2020    ACH           ERROR.149444                            */
/*  02/05/2023     ACH           Error #200142                           */
/* ********************************************************************* */

USE cob_credito
GO

IF OBJECT_ID ('dbo.sp_xml_cuestionario_det') IS NOT NULL
    DROP PROCEDURE dbo.sp_xml_cuestionario_det
GO

CREATE proc sp_xml_cuestionario_det (
    @i_fecha_proceso     datetime = null,
    @i_max_si_sincroniza INT = 1,
    @i_inst_proc         INT = 0,
    @i_tramite           INT = NULL,
    @i_cliente           int = null,
    @i_nombre_cl         varchar(64) = null,
    @i_grupal            bit = 0,
    @i_accion            VARCHAR(255) = 'INGRESAR',
    @i_observacion       VARCHAR(255) = 'Ingresar cuestionario',
	@i_toperacion        varchar(255) = null,
    @o_filas             int = 0 output
)
as
declare
@w_siguiente            INT,
@w_parametro            VARCHAR(100),
@w_param                VARCHAR(2000),
@w_respuesta            VARCHAR(2),
@w_resultado            int,
@w_flag                 SMALLINT,
@w_cliente              INT,
@w_nombre_cl            varchar(64),
@w_num_param            int,
@w_pregunta             INT,
@w_secuencial           INT,
@w_return               int,
@w_str                  nVARCHAR(max),
@w_rol                  char(1),
@w_fecha_ini_param      datetime,
@w_param_val_resp_min   int,
--@w_num_meses_MESVCC     smallint,
@w_fecha_proceso        datetime,
@w_domicilio            int,
@w_negocio              int,
@w_lat_neg              float,
@w_lat_dom              float,
@w_long_neg             float,
@w_long_dom             float


select  @w_fecha_proceso    = fp_fecha   from cobis..ba_fecha_proceso
--select  @w_num_meses_MESVCC = pa_tinyint from cobis..cl_parametro where  pa_nemonico = 'MESVCC'
--select  @w_fecha_ini_param  = dateadd(mm, -1*@w_num_meses_MESVCC, @w_fecha_proceso)
select @w_param_val_resp_min = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'RVDGR' and pa_producto = 'CRE'

CREATE TABLE #cr_clientes_tramite(
	w_ente             int,
	w_resultado        int
)

-- Ya no va porque se quita el parametro de vigencia
--print 'INSERT TEMPORAL CLIENTES EN EL GRUPO DEL TRAMITE: ' +  convert(varchar(10),@i_tramite) 
--select 	 
--'cliente'      = vd_cliente,
--'fecha'        = max(vd_fecha)
--into #temporal_cliente         
--from 	cob_credito..cr_tramite_grupal t,cob_credito..cr_verifica_datos
--where  tg_tramite = @i_tramite
--and    vd_cliente = tg_cliente
--and    tg_monto   > 0  
--and    tg_participa_ciclo = 'S'
--group by vd_cliente

-- Ya no va porque se quita el parametro de vigencia
--print 'INSERT CLIENTES CON FECHA MENORES A : ' + convert(varchar(10),@w_fecha_ini_param, 103)
--insert into #cr_clientes_tramite
--select distinct 
--cliente, 
--vd_resultado
--from #temporal_cliente,
--cob_credito..cr_verifica_datos
--where cliente = vd_cliente
--and   fecha   = vd_fecha      
--and   fecha   <= @w_fecha_ini_param--Caso #149444

print 'INSERT CLIENTES CON CALIFICACION MENORES A: ' + convert(varchar(10), @w_param_val_resp_min)
insert into #cr_clientes_tramite 
select distinct
vd_cliente,
vd_resultado
from cob_credito..cr_verifica_datos
where vd_tramite = @i_tramite
--where vd_cliente = cliente
--and fecha = vd_fecha
and vd_resultado <= @w_param_val_resp_min

--*---Ya debe tener un usuario asignado
--*-print  'Ingreso de clientes con cal'
--*-insert into #cr_clientes_tramite
--*-select tg_cliente,
--*-       0
--*-from cr_ej_regla_aplica_cuest, cr_tramite_grupal
--*-where er_tramite = tg_tramite
--*-and tg_tramite = @i_tramite
--*-and tg_cliente = er_cliente
--*-and tg_monto > 0
--*-and tg_participa_ciclo = 'S'
--*-and er_in_etapa = 'S'

print 'INSERT CLIENTES NUEVOS'
insert into #cr_clientes_tramite 
SELECT 
tg_cliente,
0
from cr_tramite_grupal t, cr_ej_regla_aplica_cuest
where tg_tramite = @i_tramite
and er_tramite = tg_tramite
and er_cliente = tg_cliente
and tg_monto > 0
and tg_participa_ciclo = 'S'
and tg_cliente not in (select vd_cliente FROM cob_credito..cr_verifica_datos where vd_tramite = @i_tramite)
and er_in_etapa = 'S'
and er_est_en_cred = 'V'

IF (@i_grupal=1 AND NOT EXISTS (SELECT 1 FROM #cr_clientes_tramite))
begin
	PRINT 'no se sincroniza ningún cuestionario'
	select @o_filas = 0
	RETURN 0
end

    SELECT @w_cliente = 0
    select @o_filas   = 0
    --WHILE 1 = 1  -----> CURSOR POR CLIENTE DEL TRAMITE
    --BEGIN
        select @o_filas   = @o_filas + 1

        if @i_grupal = 1
            select @w_str = '<verificationGroupSynchronizedData>' +
                            '<groupId>' + convert(varchar, @i_cliente) + '</groupId>' +
                            '<name>'    + @i_nombre_cl                 + '</name>'
        if @i_grupal = 0
        begin
		   select @w_str = '<verificationSynchronizedData>'
           if @i_toperacion = 'REVOLVENTE' begin
              insert into #tmp_deudores
              select 
              w_cliente   = tr_cliente,
              w_resultado = 0,
              w_nombre_cl = (SELECT isnull(en_nombre,'') + ' ' + isnull(p_s_nombre,'') + ' ' +  isnull(p_p_apellido,'') + ' ' +  isnull(p_s_apellido,'') 
                             FROM cobis..cl_ente 
                             WHERE en_ente = t.tr_cliente),
              w_rol       = 'D' -- deudor
              from   cob_credito..cr_tramite t
              where  tr_tramite = @i_tramite
           end else begin              
                insert into #tmp_deudores
                select TOP 1 w_cliente   = op_cliente,
                             w_resultado =0,
                             w_nombre_cl = op_nombre,
                             w_rol       = 'D' -- deudor
                 from cob_cartera..ca_operacion, cob_credito..cr_ej_regla_aplica_cuest
                where op_tramite = @i_tramite
				  and er_tramite = op_tramite
				  and er_aplica = 'S' and er_in_etapa = 'S' and er_est_en_cred = 'V'
				  and op_cliente = er_cliente
                  and op_cliente > 0

                union
                select w_cliente   = tr_alianza,
                       w_resultado = 0,
                       w_nombre_cl = (SELECT isnull(en_nombre,'') + ' ' + isnull(p_s_nombre,'') + ' ' +  isnull(p_p_apellido,'') + ' ' +  isnull(p_s_apellido,'') FROM cobis..cl_ente WHERE en_ente = t.tr_alianza),
                       w_rol       = 'A' -- aval
                 from cob_credito..cr_tramite t, cob_credito..cr_ej_regla_aplica_cuest
                where tr_tramite = @i_tramite
				  and tr_tramite = er_tramite
				  and tr_alianza = er_cliente
				  and er_aplica = 'S' and er_in_etapa = 'S' and er_est_en_cred = 'V'
                  and tr_alianza > 0			 				  
           end
        end

        select 
		@w_str = @w_str +
		'<processInstance>'+ convert(VARCHAR, @i_inst_proc) + '</processInstance>'

        WHILE 1 = 1  -----> CURSOR POR CLIENTE DEL TRAMITE
        BEGIN
		   select  
		   @w_resultado = null,
		   @w_nombre_cl = null,
		   @w_resultado = null,
		   @w_rol       = null,
		   @w_negocio   = null,
		   @w_lat_neg   = null,
		   @w_long_neg  = null,
		   @w_domicilio = null,
		   @w_lat_dom   = null,
		   @w_long_dom  = null		   
		   
		   if @i_grupal = 1 -- GRUPAL
           begin  
		   
            /*select TOP 1
                @w_cliente   = tg_cliente,
                @w_resultado = '',
                @w_nombre_cl = (select en_nomlar from cobis..cl_ente where en_ente = t.tg_cliente)
          from   cob_credito..cr_tramite_grupal t
            where  tg_tramite = @i_tramite
            and    tg_cliente > @w_cliente
            and    tg_monto   > 0
            */

			select TOP 1
            @w_cliente   = w_ente,
            @w_resultado = w_resultado,
            @w_nombre_cl = (select en_nomlar from cobis..cl_ente where en_ente = w_ente)
            from   #cr_clientes_tramite
            --where  tg_tramite = @i_tramite
            where    w_ente > @w_cliente
            --and    tg_monto   > 0
            
         	ORDER BY w_ente            

            IF @@ROWCOUNT = 0 BREAK
        end

        if @i_grupal = 0 -- INDIVIDUAL
        begin
            select TOP 1
                @w_cliente   = cliente,
                @w_resultado = resultado,
                @w_nombre_cl = nombre,
                @w_rol       = rol
            from   #tmp_deudores
            where cliente > @w_cliente
            ORDER BY cliente
            IF @@ROWCOUNT = 0 BREAK
        end

        --print '1.- >>>>>>>>>>>>>>>' + CONVERT(varchar, @w_cliente)

        exec @w_return = cob_credito..sp_verificacion_datos
        @i_operacion = 'Q',
        @i_tramite = @i_tramite,
        @i_ente = @w_cliente,
        @i_modo = 4,
		@t_trn  = 21700

		--if @w_return <> 0
		--select ' ERROR ' = @w_return


        select @w_negocio = di_direccion
        from cobis..cl_direccion 
        where  di_ente = @w_cliente
        and di_tipo ='AE'
		
		if @w_negocio is null begin	
		   SELECT @w_negocio = di_direccion
           from   cobis..cl_direccion 
           where  di_ente = @w_cliente
           AND    di_principal = 'S'
		end 

		select 
		@w_lat_neg  = dg_lat_seg,
		@w_long_neg = dg_long_seg
		from cobis..cl_direccion_geo 
		where dg_ente = @w_cliente
		and dg_direccion = @w_negocio		
        
        select @w_domicilio = di_direccion
        from cobis..cl_direccion 
        where  di_ente = @w_cliente
        and di_tipo ='RE'
		
       if @w_domicilio is null begin
		   select @w_domicilio = di_direccion
           from   cobis..cl_direccion 
           where  di_ente = @w_cliente
           and    di_principal = 'S'		   
		end    
        
        select 
		@w_lat_dom  = dg_lat_seg,
		@w_long_dom = dg_long_seg
		from cobis..cl_direccion_geo 
		where dg_ente = @w_cliente
		and dg_direccion = @w_domicilio
           

        select @w_str = @w_str +
                   '<verification>'  +
                   '<applicationId>' + convert(VARCHAR, @i_tramite)  + '</applicationId>'+
                   '<date>'          + format(@i_fecha_proceso, 'yyyy-MM-ddTHH:mm:ssZ') + '</date>'+
                   '<customerId>'    + convert(VARCHAR, @w_cliente)    + '</customerId>'+
                   '<customerName>'  + @w_nombre_cl                    + '</customerName>'+
                   '<businessAddressGeoReference>'+        
                       '<addressId>'+convert(varchar(10),@w_negocio)+'</addressId>'+
                        '<latitude>'+STR(@w_lat_neg, 12,10)+'</latitude>'+
                        '<longitude>'+STR(@w_long_neg, 12,10)+'</longitude>'+
                   '</businessAddressGeoReference>'+
                   '<homeAddressGeoReference>'+
                        '<addressId>'+convert(varchar(10),@w_domicilio)+'</addressId>'+
                        '<latitude>'+STR(@w_lat_dom, 12,10)+'</latitude>'+
                        '<longitude>'+STR(@w_long_dom, 12,10)+'</longitude>'+
                   '</homeAddressGeoReference>'
                   

        if @i_grupal = 1
            select @w_str = @w_str + '<group>true</group>'
        if @i_grupal = 0
        begin
            select @w_str = @w_str + '<group>false</group>'
            if @w_rol = 'D'
                select @w_str = @w_str + '<aval>false</aval>'
            else
                select @w_str = @w_str + '<aval>true</aval>'
        end

        -- ENCONTRAR LAS PREGUNTAS
        SELECT @w_pregunta = 0

        WHILE 1 = 1
        BEGIN
            SELECT TOP 1
                @w_pregunta  = vt_x_codigo
            FROM cr_verifica_xml_tmp
            WHERE vt_x_tramite = @i_tramite
            AND vt_x_cliente = @w_cliente
            AND vt_x_codigo > @w_pregunta
            ORDER BY vt_x_codigo
            IF @@ROWCOUNT = 0 BREAK

            SELECT @w_str = @w_str + '<questions>' --'<id> '+ convert(VARCHAR, @w_pregunta)+  '</id>'

            -- ENCONTRAR LOS PARAMETROS DE LAS PREGUNTAS
            SELECT @w_secuencial = 0, @w_flag = 0, @w_num_param = 0
            DELETE #tmp_items_xml

            WHILE 1 = 1
            BEGIN
                SELECT TOP 1
                    @w_secuencial = vt_x_secuencial,
                    @w_parametro  = isnull(vt_x_preg_dato,'-'),
                    @w_respuesta  = LTRIM(RTRIM(vt_x_respuesta))
                FROM cr_verifica_xml_tmp
                WHERE vt_x_tramite = @i_tramite
                AND vt_x_cliente = @w_cliente
                AND vt_x_codigo = @w_pregunta
                AND vt_x_secuencial > @w_secuencial
                ORDER BY vt_x_secuencial
                IF @@ROWCOUNT = 0 BREAK
                IF @w_parametro = '**' ---> NO HAY PARAMETROS
                    BREAK
                select @w_num_param = @w_num_param + 1
                INSERT INTO #tmp_items_xml  VALUES(@w_pregunta , @w_parametro, @w_num_param)
            END -- while PARAMETROS

            SELECT @w_param = (select rtrim(value) as value
                              fRom #tmp_items_xml as parameters where sec = @w_pregunta
                              for xml auto , elements)

            SELECT @w_param = isnull(@w_param , '')

            SELECT @w_str = @w_str + @w_param

            SELECT @w_str = @w_str + '<answer>' + isnull(@w_respuesta,' ') + '</answer>' + '</questions>'
        END -- while preguntas

        SELECT @w_str = @w_str  +'<result>' + convert(varchar,@w_resultado)  + '</result>' + '</verification>'

    END ----- WHILE   POR CLIENTES

    if @i_grupal = 1  select @w_str = @w_str + '</verificationGroupSynchronizedData>'
    if @i_grupal = 0  select @w_str = @w_str + '</verificationSynchronizedData>'

    INSERT INTO cob_sincroniza..si_sincroniza_det
    VALUES( @i_max_si_sincroniza, @i_inst_proc, @i_tramite, isnull(@i_cliente,0), @w_str,   @i_accion, @i_observacion, 0)
    if @@error <> 0
        begin
            return 150000 -- ERROR EN INSERCION
        end
    RETURN 0
GO
