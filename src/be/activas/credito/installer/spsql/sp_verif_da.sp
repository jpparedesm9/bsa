/* ********************************************************************* */
/*      Archivo:                sp_verificacion_datos.sp                 */
/*      Stored procedure:       sp_verif_datos                           */
/*      Base de datos:          cob_pac                                  */
/*      Producto:               Credito                                  */
/*      Disenado por:           Adriana Chiluisa                         */
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
/*      Este programa procesa las transacciones del stored procedure     */
/*      Inserta actualiza y consulta información para verificación       */
/*      datos                                                            */
/* ********************************************************************* */
/*                              MODIFICACIONES                           */
/*      FECHA           AUTOR                RAZON                       */
/*      30/05/2017     Adriana Chiluisa      Version Inicial             */
/*      24/07/2019     ACHP                  Val para geo Referencia     */
/*                                                                       */
/* ********************************************************************* */
USE cob_credito
go
IF OBJECT_ID ('dbo.sp_verificacion_datos') IS NOT NULL
    DROP PROCEDURE dbo.sp_verificacion_datos
GO

CREATE proc sp_verificacion_datos (
    @s_ssn                  int             = null,
    @s_sesn                 int             = null,
    @s_culture              varchar(10)     = null,
    @s_user                 login           = null,
    @s_term                 varchar(30)     = null,
    @s_date                 datetime        = null,
    @s_srv                  varchar(30)     = null,
    @s_lsrv                 varchar(30)     = null,
    @s_ofi                  smallint        = null,
    @s_rol                  smallint        = NULL,
    @s_org_err              char(1)         = NULL,
    @s_error                int             = NULL,
    @s_sev                  tinyint         = NULL,
    @s_msg                  descripcion     = NULL,
    @s_org                  char(1)         = NULL,
    @t_show_version         bit             = 0,    -- Mostrar la version del programa
    @t_debug                char(1)         = 'N',
    @t_file                 varchar(10)     = null,
    @t_from                 varchar(32)     = null,
    @t_trn                  smallint        = null,
    @i_operacion            char(1),                -- Opcion con que se ejecuta el programa
    @i_modo                 tinyint         = null, -- Modo de busqueda
    @i_tipo                 char(1)         = null, -- Tipo de consulta
    @i_filial               tinyint         = null, -- Codigo de la filial
    @i_oficina              smallint        = null, -- Codigo de la oficina
    @i_tramite              int             = null,
    @i_ente                 int             = null,
    @i_respuesta            char(200)       = null,
    @i_latitud_neg          float           = null,
    @i_longitud_neg         float           = null,
    @i_latitud_dom          float           = null,
    @i_longitud_dom         float           = null,
    @o_resultado            int             = null out

)
as
declare
    @w_siguiente                int,
    @w_return                   int,
    @w_num_cl_gr                int,
    @w_contador                 int,
    @w_sp_name                  varchar(32),
    @w_error                    int,
    @w_ente                     int,
    @w_respuestas               varchar(200),
    @w_resultado                int,
    @w_actualizar               char(1),
   -- @w_ingreso_mensual          money,
   -- @w_gasto_mens_famil         money,
    @w_nombre_grupo             varchar(30),--
    @w_nombre_presi             varchar(30),--
    @w_nombre                   varchar(30),--
    @w_apellido_paterno         varchar(30),--
    @w_apellido_materno         varchar(30),--
    @w_calle                    varchar(30),--
    @w_numero                   varchar(30),--
    @w_colonia                  varchar(30),--
    @w_delegacion_municipio     varchar(30),--
    @w_anos_en_domic_actual     VARCHAR(30), --veri
    @w_ocupacion                varchar(30),--
    @w_nombre_negocio           varchar(30),--
    @w_tiempo_arraigo_negocio   varchar(30),--
    @w_tipo_local               varchar(30),--
    @w_gasto_mens               money,
    @w_cod_tab_negocio          smallint,
    @w_cod_tab_tiempo           smallint,
    @w_fecha_proceso            datetime,
    @w_grupal_aux               char(1),
    @w_grupal                   char(1),
    @w_tecnologico              int,
    @v_lat_segundos             float,
    @v_lon_segundos             float,
    @w_lat_segundos             float,
    @w_lon_segundos             float,
@w_otros_ingresos           money,
    @w_ventas                   money,
    @w_ct_ventas                money,
    @w_ct_operativos            money,
    @w_ingreso_total            money,
    @w_gasto_total              money
    
    --declaracion de variables para consultas
declare
    @w_grupo int, @w_rol catalogo, @w_ente_presi int, @w_cod_tab_profesion catalogo,
    @w_cod_tab_parroq catalogo, @w_cod_tab_ciudad catalogo
    -- saco la cadena de respuestas
declare
    @w_cadena varchar(200),
    @w_resultado_aux smallint,
    @w_resp1 varchar(100),
    @w_pos1 smallint,
    @w_col1  SMALLINT


-------------------------------- VERSIONAMIENTO DE SP --------------------------------
if @t_show_version = 1
begin
    print 'Stored procedure sp_verificacion_datos, Version 1.0.0.0'
    return 0
end
--------------------------------------------------------------------------------------
select @w_sp_name = 'sp_verificacion_datos'

if @t_trn <> 21700
begin
    select @w_error = 151051 -- TRANSACCION NO PERMITIDA
    goto ERROR
end

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
SELECT @w_grupal = tr_grupal FROM cob_credito..cr_tramite WHERE tr_tramite = @i_tramite

set @w_actualizar = 'N'

if @i_operacion in ('I', 'U')
begin
    --Actualizacion latitud , longitud -- negocio
	if (@i_latitud_neg != '' and @i_longitud_neg != '' and
	    @i_latitud_neg is not null and @i_longitud_neg is not null)
	begin
	    declare @w_di_direccion_neg int
        select @w_di_direccion_neg = di_direccion
        from    cobis..cl_direccion where di_ente = @i_ente and di_tipo = 'AE'

		if exists (select 1 from cobis..cl_direccion_geo
		           where dg_ente =  @i_ente and dg_direccion = @w_di_direccion_neg
				   and dg_secuencial = (select max(dg_secuencial)
				                        from cobis..cl_direccion_geo
										where dg_ente =  @i_ente and dg_direccion = @w_di_direccion_neg ))
		begin		
		    -------------CARGANDO LOS DATOS ANTERIORES DE LA GEOREFERENCIACION
		    select @w_lat_segundos = dg_lat_seg,
                   @w_lon_segundos = dg_long_seg         
            from cobis..cl_direccion_geo where dg_ente =  @i_ente and dg_direccion = @w_di_direccion_neg and dg_secuencial =
            (select max(dg_secuencial) from cobis..cl_direccion_geo where dg_ente =  @i_ente and dg_direccion = @w_di_direccion_neg )		

		    ---------------GUARDANDO LOS DATOS ANTERIORES
			select @v_lat_segundos = @w_lat_segundos,--@w_lat_segundos,---
                   @v_lon_segundos = @w_lon_segundos--@w_lon_segundos---

		    ---------------VERIFICANDO CAMBIOS EN LOS CAMPOS
			if @w_lat_segundos = @i_latitud_neg----/****
			    select @w_lat_segundos = null, @v_lat_segundos = null
				    else
				select @w_lat_segundos = @i_latitud_neg
				
			if @w_lon_segundos = @i_longitud_neg----/****
			    select @w_lon_segundos = null, @v_lon_segundos = null
				    else
				select @w_lon_segundos = @i_longitud_neg
			
			if ((@w_lat_segundos is not null and @v_lat_segundos  is not null) or 
			    (@w_lon_segundos is not null and @v_lon_segundos  is not null))
		begin
		        ---------------ACTUALIZACION
            update cobis..cl_direccion_geo
                set    dg_lat_seg  = isnull(@i_latitud_neg, dg_lat_seg),
                       dg_long_seg = isnull(@i_longitud_neg, dg_long_seg)				   
                from   cobis..cl_direccion_geo where dg_ente =  @i_ente and dg_direccion = @w_di_direccion_neg and dg_secuencial =
                (select max(dg_secuencial) from cobis..cl_direccion_geo where dg_ente =  @i_ente and dg_direccion = @w_di_direccion_neg )
                   
		        ---------------TRANSACCION DE SERVICIOS DATOS PREVIOS
		        insert into cobis..ts_direccion_geo ( secuencia,       tipo_transaccion, clase,            fecha,
                                                  oficina_s,       usuario,          terminal_s,       srv, 
                                                  lsrv,            hora,             ente,             direccion,
                                                  latitud_coord,   latitud_grados,   latitud_minutos,  latitud_segundos,
                                                  longitud_coord,  longitud_grados,  longitud_minutos, longitud_segundos,
                                                  path_croquis)
		        values (                       @s_ssn,          1609,            'P',               @s_date,
		                                       @s_ofi,          @s_user,          @s_term,          @s_srv, 
		        							   @s_lsrv,         getdate(),        @i_ente,          @w_di_direccion_neg,
		        							   null,            null,             null,             @v_lat_segundos,
		        							   null,            null,             null,             @v_lon_segundos,
		        							   null)
		        if @@error <> 0
		           begin
                       select @w_error = 103005
                       goto ERROR
		        end
                   
		        ---------------TRANSACCION DE SERVICIOS DATOS ACTUALIZADOS
		        insert into cobis..ts_direccion_geo ( secuencia,       tipo_transaccion, clase,            fecha,
		                                       oficina_s,       usuario,          terminal_s,       srv, 
		                                       lsrv,            hora,             ente,             direccion,
		                                       latitud_coord,   latitud_grados,   latitud_minutos,  latitud_segundos,
		                                       longitud_coord,  longitud_grados,  longitud_minutos, longitud_segundos,
		                                       path_croquis)
		        values (                       @s_ssn,          1609,            'A',               @s_date,
		                                       @s_ofi,          @s_user,          @s_term,          @s_srv, 
		                                       @s_lsrv,         getdate(),        @i_ente,          @w_di_direccion_neg,
		                                       null,            null,             null,             @w_lat_segundos,
		                                       null,            null,             null,             @w_lon_segundos,
		                                       null)			   
		        if @@error <> 0
		           begin
		               select @w_error = 103005
		               goto ERROR
		        end			
			end
		end
	end

    --Actualizacion latitud , longitud -- domicilio
	if (@i_latitud_dom != '' and @i_longitud_dom != '' and
	    @i_latitud_dom is not null and @i_longitud_dom is not null)
	begin
	    declare @w_di_direccion_dom int
        select @w_di_direccion_dom = di_direccion
        from cobis..cl_direccion where di_ente = @i_ente and di_tipo = 'RE'

		if exists (select 1 from cobis..cl_direccion_geo
		           where dg_ente =  @i_ente and dg_direccion = @w_di_direccion_dom
				   and dg_secuencial = (select max(dg_secuencial)
				                        from cobis..cl_direccion_geo
										where dg_ente =  @i_ente and dg_direccion = @w_di_direccion_dom ))
		begin
		    -------------CARGANDO LOS DATOS ANTERIORES DE LA GEOREFERENCIACION
		    select @w_lat_segundos = dg_lat_seg,
                   @w_lon_segundos = dg_long_seg         
            from cobis..cl_direccion_geo where dg_ente =  @i_ente and dg_direccion = @w_di_direccion_dom and dg_secuencial =
            (select max(dg_secuencial) from cobis..cl_direccion_geo where dg_ente =  @i_ente and dg_direccion = @w_di_direccion_dom )		

		    ---------------GUARDANDO LOS DATOS ANTERIORES
			select @v_lat_segundos = @w_lat_segundos,
                   @v_lon_segundos = @w_lon_segundos

		    ---------------VERIFICANDO CAMBIOS EN LOS CAMPOS
			if @w_lat_segundos = @i_latitud_dom----/****
			    select @w_lat_segundos = null, @v_lat_segundos = null
				    else
				select @w_lat_segundos = @i_latitud_dom
				
			if @w_lon_segundos = @i_longitud_dom----/****
			    select @w_lon_segundos = null, @v_lon_segundos = null
				    else
				select @w_lon_segundos = @i_longitud_dom
			
			if ((@w_lat_segundos is not null and @v_lat_segundos is not null) or 
			    (@w_lon_segundos is not null and @v_lon_segundos is not null))
			begin
		        ---------------ACTUALIZACION
            update cobis..cl_direccion_geo
                set dg_lat_seg  = isnull(@i_latitud_dom, dg_lat_seg),
                    dg_long_seg = isnull(@i_longitud_dom, dg_long_seg)
                from cobis..cl_direccion_geo where dg_ente =  @i_ente and dg_direccion = @w_di_direccion_dom and dg_secuencial =
                (select max(dg_secuencial) from cobis..cl_direccion_geo where dg_ente =  @i_ente and dg_direccion = @w_di_direccion_dom )
	            
			    ---------------TRANSACCION DE SERVICIOS DATOS PREVIOS
			    insert into cobis..ts_direccion_geo ( secuencia,       tipo_transaccion, clase,            fecha,
                                               oficina_s,       usuario,          terminal_s,       srv, 
                                               lsrv,            hora,             ente,             direccion,
                                               latitud_coord,   latitud_grados,   latitud_minutos,  latitud_segundos,
                                               longitud_coord,  longitud_grados,  longitud_minutos, longitud_segundos,
                                               path_croquis)
			    values (                       @s_ssn,          1609,            'P',               @s_date,
			                                   @s_ofi,          @s_user,          @s_term,          @s_srv, 
			    							   @s_lsrv,         getdate(),        @i_ente,          @w_di_direccion_dom,
			    							   null,            null,             null,             @v_lat_segundos,
			    							   null,            null,             null,             @v_lon_segundos,
			    							   null)
			    if @@error <> 0
			       begin
                    select @w_error = 103005
                    goto ERROR
			    end
		        
			    ---------------TRANSACCION DE SERVICIOS DATOS ACTUALIZADOS
                insert into cobis..ts_direccion_geo ( secuencia,       tipo_transaccion, clase,            fecha,
                                               oficina_s,       usuario,          terminal_s,       srv, 
                                               lsrv,            hora,             ente,             direccion,
                                               latitud_coord,   latitud_grados,   latitud_minutos,  latitud_segundos,
                                               longitud_coord,  longitud_grados,  longitud_minutos, longitud_segundos,
                                               path_croquis)
                values (                       @s_ssn,          1609,            'A',               @s_date,
                                               @s_ofi,          @s_user,          @s_term,          @s_srv, 
                                               @s_lsrv,         getdate(),        @i_ente,          @w_di_direccion_dom,
                                               null,            null,             null,             @w_lat_segundos,
                                               null,            null,             null,             @w_lon_segundos,
                                               null)            
			    if @@error <> 0
			    begin
                    select @w_error = 103005
                    goto ERROR
			    end				   
			end
		end
	end -- Fin Actualizacion latitud , longitud

    select @w_cadena = @i_respuesta -- string a evaluar para determinar el resultado
    select @w_cadena = isnull(@w_cadena ,'')
    select @w_col1 = 1
    select @w_resultado_aux = 0
    select @w_tecnologico = 0
    WHILE len(@w_cadena) > 0
    BEGIN
        SELECT @w_pos1 = charindex(';',@w_cadena)
        IF @w_pos1 > 0
        begin
            SELECT @w_resp1 = substring(@w_cadena, 1,@w_pos1 - 1)
            SELECT @w_cadena = substring(@w_cadena, @w_pos1 + 1, 200)
        END
        ELSE
        begin
            SELECT @w_resp1 = @w_cadena
            SELECT @w_cadena = NULL
        END
        -- tengo la respuesta --> asignar puntaje
        if @w_grupal = 'S'
        begin
            if @w_col1 between 1 and 12
            begin
               -- if @w_col1 in (6,12)
               if @w_col1 in (1,7)
                    if @w_resp1 = 'S'
                        select @w_resultado_aux = @w_resultado_aux + 1
                    else
                        select @w_resultado_aux = @w_resultado_aux - 10
                else
                    if @w_resp1 = 'S'
                        select @w_resultado_aux = @w_resultado_aux + 1
                    else
                        select @w_resultado_aux = @w_resultado_aux - 0
            end
            else -- si @w_col1 >= 13
            begin
                if @w_col1 = 13
                begin
                    if @w_resp1 = 'S' -- diario/semanal
                    begin
                        select @w_resultado_aux = @w_resultado_aux + 1
                        select @w_tecnologico = @w_tecnologico + 1
                    end
                    else
                    begin
                        select @w_resultado_aux = @w_resultado_aux - 0
                        select @w_tecnologico = @w_tecnologico - 0
                    end
                end
                if @w_col1 = 14
                begin
                    if @w_resp1 in ('D', 'S') -- diario/semanal
                    begin
                        select @w_resultado_aux = @w_resultado_aux + 1
                        select @w_tecnologico = @w_tecnologico + 1
                    end
                    else
                    begin
                        select @w_resultado_aux = @w_resultado_aux - 0
                        select @w_tecnologico = @w_tecnologico - 0
                    end
                end
                if @w_col1 = 15
                begin
                    if @w_resp1 in ('F', 'W') -- facebook/wa
                    begin
                        select @w_resultado_aux = @w_resultado_aux + 1
                        select @w_tecnologico = @w_tecnologico + 1
                    end
                    else
                    begin
                        select @w_resultado_aux = @w_resultado_aux - 0
                        select @w_tecnologico = @w_tecnologico - 0
                    end
                end
                if @w_col1 = 16
                begin
                    if @w_resp1 in ('S') -- smartphone
                    begin
                        select @w_resultado_aux = @w_resultado_aux + 1
                        select @w_tecnologico = @w_tecnologico + 1
                    end
                    else
                    begin
                        select @w_resultado_aux = @w_resultado_aux - 0
                        select @w_tecnologico = @w_tecnologico - 0
                    end
                end
                if @w_col1 = 17
                begin
                    if @w_resp1 in ('R') -- renta
                    begin
                        select @w_resultado_aux = @w_resultado_aux + 1
                        select @w_tecnologico = @w_tecnologico + 1
                    end
                    else
                    begin
                        select @w_resultado_aux = @w_resultado_aux - 0
                        select @w_tecnologico = @w_tecnologico - 0
                    end
                end
            end
        end
        else
        begin
            if @w_col1 between 1 and 9
            begin
                --if @w_col1 in (3,9)
                if @w_col1 in (1,7)
                    if @w_resp1 = 'S'
                        select @w_resultado_aux = @w_resultado_aux + 1
                    else
                        select @w_resultado_aux = @w_resultado_aux - 10
                else
                    if @w_resp1 = 'S'
                        select @w_resultado_aux = @w_resultado_aux + 1
                    else
                        select @w_resultado_aux = @w_resultado_aux - 0
            end
            else
            begin
                if @w_col1 = 10
                begin
                    if @w_resp1 = 'S' -- diario/semanal
                    begin
                        select @w_resultado_aux = @w_resultado_aux + 1
                        select @w_tecnologico = @w_tecnologico + 1
                    end
                    else
                    begin
                        select @w_resultado_aux = @w_resultado_aux - 0
                        select @w_tecnologico = @w_tecnologico - 0
                    end
                end
                if @w_col1 = 11
                begin
                    if @w_resp1 in ('D', 'S') -- diario/semanal
                    begin
                        select @w_resultado_aux = @w_resultado_aux + 1
                        select @w_tecnologico = @w_tecnologico + 1
                    end
                    else
                    begin
                        select @w_resultado_aux = @w_resultado_aux - 0
                        select @w_tecnologico = @w_tecnologico - 0
                    end
                end
                if @w_col1 = 12
                begin
                    if @w_resp1 in ('F', 'W') -- facebook/wa
                    begin
                        select @w_resultado_aux = @w_resultado_aux + 1
                        select @w_tecnologico = @w_tecnologico + 1
                    end
                    else
                    begin
                        select @w_resultado_aux = @w_resultado_aux - 0
                        select @w_tecnologico = @w_tecnologico - 0
                    end
                end
                if @w_col1 = 13
                begin
                    if @w_resp1 in ('S') -- smartphone
                    begin
                        select @w_resultado_aux = @w_resultado_aux + 1
                        select @w_tecnologico = @w_tecnologico + 1
                    end
                    else
                    begin
                        select @w_resultado_aux = @w_resultado_aux - 0
                        select @w_tecnologico = @w_tecnologico - 0
                    end
                end
                if @w_col1 = 14
                begin
                    if @w_resp1 in ('R') -- renta
                    begin
                        select @w_resultado_aux = @w_resultado_aux + 1
                        select @w_tecnologico = @w_tecnologico + 1
                    end
                    else
                    begin
                        select @w_resultado_aux = @w_resultado_aux - 0
                        select @w_tecnologico = @w_tecnologico - 0
                    end
                end
            end
        end

        --SELECT @w_col1, @w_resp1, @w_resultado_aux
        SELECT @w_col1 = @w_col1 +1
    END

    --AGREGAR ACTALIZACION AL TECNOLOGICO DEL USUARIO

    if @w_tecnologico >= 4
    begin
        UPDATE cobis..cl_ente_aux SET ea_tecnologico = 'ALTO'
        WHERE ea_ente = @i_ente
    end
    else if @w_tecnologico = 3
    begin
        UPDATE cobis..cl_ente_aux SET ea_tecnologico = 'MEDIO'
        WHERE ea_ente = @i_ente
    end
    else if @w_tecnologico <=2
    begin
        UPDATE cobis..cl_ente_aux SET ea_tecnologico = 'BAJO'
        WHERE ea_ente = @i_ente
    end

end

if @i_operacion = 'I'
begin
    -- verificar que exista el registro --
    if exists (select 1 from cr_verifica_datos where vd_tramite = @i_tramite and vd_cliente = @i_ente)
    begin
        select @w_error = 2101002; -- REGISTRO YA EXISTE
        goto ERROR
    end

    INSERT INTO cr_verifica_datos VALUES(@i_tramite, @i_ente, @i_respuesta , @w_resultado_aux, @w_fecha_proceso)

    -- Si no se puede modificar, error --
    if @@error <> 0
    begin
        select @w_error = 2103057  --ERROR EN LA ACTUALIZACIÓN
        goto ERROR
    end
end -- Fin Operacion I

if @i_operacion = 'U'
begin
    -- verificar que exista el registro --
    if not exists (select 1 from cr_verifica_datos where vd_tramite = @i_tramite and vd_cliente = @i_ente)
    begin
        insert into cr_verifica_datos values(@i_tramite, @i_ente, @i_respuesta , @w_resultado_aux, @w_fecha_proceso)
        -- Si no se puede modificar, error --
        if @@error <> 0
        begin
            select @w_error = 2103057  --ERROR EN LA ACTUALIZACIÓN
            goto ERROR
        end
    end
    else
    begin
        select @w_respuestas = vd_respuesta,
               @w_resultado  = vd_resultado
        from   cr_verifica_datos
        where  vd_tramite = @i_tramite
        and    vd_cliente = @i_ente

        if @w_respuestas <> @i_respuesta or @w_resultado <> @w_resultado_aux
            set @w_actualizar = 'S'

        -- Actualizacion de registros
        IF @w_actualizar = 'S'
        begin
            update cr_verifica_datos
            set    vd_respuesta  = @i_respuesta,
                   vd_resultado  = @w_resultado_aux,
                   vd_fecha      = @w_fecha_proceso
            where  vd_tramite    = @i_tramite
            and    vd_cliente    = @i_ente

            -- Si no se puede modificar, error --
            if @@rowcount = 0
            begin
                select @w_error = 2103057  --ERROR EN LA ACTUALIZACIÓN
                goto ERROR
            end
        end
    end
end -- Fin Operacion U

if @i_operacion = 'Q'
begin

    SELECT @w_rol = 'P'

    select @w_resultado  = vd_resultado
    from   cr_verifica_datos
    where  vd_tramite = @i_tramite
    and    vd_cliente = @i_ente

    --Seccion catalogos
    select @w_cod_tab_profesion = codigo
    from  cobis..cl_tabla
    where tabla = 'cl_profesion'

    select @w_cod_tab_parroq = codigo
    from   cobis..cl_tabla
    where  tabla  = 'cl_parroquia'

    select @w_cod_tab_ciudad = codigo
    from   cobis..cl_tabla
    where  tabla  = 'cl_ciudad'

    select @w_cod_tab_negocio = codigo
    from   cobis..cl_tabla
    where  tabla  = 'cr_tipo_local'

    select @w_cod_tab_tiempo = codigo
    from   cobis..cl_tabla
    where  tabla  = 'cl_referencia_tiempo'

    --- Para obtener el grupo
    --set rowcount 1
    select top 1
    @w_grupo = tg_grupo
    from   cob_credito..cr_tramite_grupal
    where  tg_tramite = @i_tramite
    --set rowcount 0

    --- Para obtener el presidente
    select @w_ente_presi = cg_ente
    from   cobis..cl_cliente_grupo
    where  cg_grupo = @w_grupo
    and    cg_rol   = @w_rol

    --- Para obtener el nombr del grupo
    select @w_nombre_grupo = gr_nombre
    from   cobis..cl_grupo
    where  gr_grupo = @w_grupo

    --- Para obtener datos del presi
    select @w_nombre_presi = en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido
    from   cobis..cl_ente
    where  en_ente = @w_ente_presi

    --- Para obtener datos del ente
    select @w_nombre           = en_nombre,
           @w_apellido_paterno = p_p_apellido,
           @w_apellido_materno = p_s_apellido,
           @w_ocupacion        = (select valor from cobis..cl_catalogo
                                  where  tabla = @w_cod_tab_profesion and codigo = E.p_profesion),
           @w_otros_ingresos  = en_otros_ingresos
    from cobis..cl_ente E
    where en_ente = @i_ente

    -- GASTOS 
    select @w_ventas = ea_ventas,
     @w_ct_ventas = ea_ct_ventas,
     @w_ct_operativos = ea_ct_operativo
    from cobis..cl_ente_aux
    where ea_ente = @i_ente

    -- NOMBRE NEGOCIO // TIPO DE NEGOCIO
--    set rowcount 1
    select top 1
        @w_nombre_negocio   = nc_nombre,
        @w_tipo_local       = (select valor from cobis..cl_catalogo
                               where  tabla = @w_cod_tab_negocio
                               and    codigo = nc.nc_tipo_local),
        @w_tiempo_arraigo_negocio =  (select valor from cobis..cl_catalogo
                               where  tabla = @w_cod_tab_tiempo
                               and    codigo = nc_tiempo_actividad)
    from cobis..cl_negocio_cliente nc
    where nc_ente  = @i_ente
    and nc_estado_reg = 'V'
    order by nc_codigo desc

    select top 1
           @w_anos_en_domic_actual = (select valor from cobis..cl_catalogo
                                      where  tabla = @w_cod_tab_tiempo
                                      and    codigo = convert(varchar(10),C.di_tiempo_reside)),
           @w_calle                = di_calle,
           @w_numero               = di_nro,
           @w_colonia              = (select valor from cobis..cl_catalogo
                                      where  tabla = @w_cod_tab_parroq
                                      and    codigo = convert(varchar(10),C.di_parroquia)),
           @w_delegacion_municipio= (select valor from cobis..cl_catalogo
                                      where  tabla = @w_cod_tab_ciudad
                                      and    codigo = convert(varchar(10),C.di_ciudad))
    from   cobis..cl_direccion C
    where  di_ente = @i_ente
    and di_tipo <> 'CE'
    order by di_direccion asc
--    set rowcount 0

   -- select @w_gasto_mens_famil = ea_ct_ventas from cobis..cl_ente_aux
   -- where  ea_ente = @i_ente

    select
        @w_ingreso_total          = isnull(@w_otros_ingresos,0)+isnull(@w_ventas,0),
        @w_gasto_total            = isnull(@w_ct_ventas,0)+isnull(@w_ct_operativos,0),
        @w_nombre_grupo           = isnull(@w_nombre_grupo          ,''),
        @w_nombre_presi           = isnull(@w_nombre_presi          ,''),
        @w_nombre                 = isnull(@w_nombre                ,''),
        @w_apellido_paterno  = isnull(@w_apellido_paterno      ,''),
        @w_apellido_materno       = isnull(@w_apellido_materno      ,''),
        @w_calle                  = isnull(@w_calle                 ,''),
        @w_numero                 = isnull(@w_numero                ,''),
        @w_colonia                = isnull(@w_colonia               ,''),
        @w_delegacion_municipio   = isnull(@w_delegacion_municipio  ,''),
        @w_anos_en_domic_actual   = isnull(@w_anos_en_domic_actual  ,0),
        @w_ocupacion              = isnull(@w_ocupacion             ,''),
        @w_nombre_negocio         = isnull(@w_nombre_negocio        ,''),
        @w_tiempo_arraigo_negocio = isnull(@w_tiempo_arraigo_negocio,0),
        @w_tipo_local             = isnull(@w_tipo_local            ,'')


    CREATE TABLE #cr_verifica_tmp (
        vt_tramite        INT NOT NULL,
        vt_cliente        INT NOT NULL,
        vt_codigo         INT NOT NULL,
        vt_pregunta       CHAR(1000) NOT NULL,
        vt_respuesta      VARCHAR(10) NOT null
    )

    --ALTER TABLE #cr_verifica_tmp ADD CONSTRAINT pk_vt_tramite
    --PRIMARY KEY (vt_tramite, vt_cliente, vt_codigo)

    if(@w_grupal = 'S')
        select @w_grupal_aux = 'G'
    else
        select @w_grupal_aux = 'I'

    INSERT INTO #cr_verifica_tmp
    SELECT @i_tramite, @i_ente, pr_codigo, pr_descripcion, ''
    FROM cob_credito..cr_pregunta_ver_dat
    where pr_tipo = @w_grupal_aux
    ORDER BY pr_codigo ASC

    -- pasear las preguntas para obtener las respuestas
    IF EXISTS(SELECT 1 FROM cob_credito..cr_verifica_datos WHERE vd_tramite = @i_tramite AND vd_cliente = @i_ente)
    BEGIN
        SELECT @w_cadena = vd_respuesta
        FROM cob_credito..cr_verifica_datos
        WHERE vd_tramite = @i_tramite
        AND vd_cliente = @i_ente

        SELECT @w_cadena = isnull(@w_cadena ,'')
        SELECT @w_col1 = 1
        WHILE len(@w_cadena) > 0
        BEGIN
            SELECT @w_pos1 = charindex(';',@w_cadena)
            IF @w_pos1 > 0
            begin
                SELECT @w_resp1 = substring(@w_cadena, 1,@w_pos1 - 1)
                SELECT @w_cadena = substring(@w_cadena, @w_pos1 + 1, 200)
            END
            ELSE
            begin
                SELECT @w_resp1 = @w_cadena
                SELECT @w_cadena = NULL
            END

            UPDATE #cr_verifica_tmp SET vt_respuesta = @w_resp1
            WHERE vt_tramite = @i_tramite
            AND vt_cliente = @i_ente
            AND vt_codigo = @w_col1

            SELECT @w_col1 = @w_col1 +1
        END
    END

    if @i_modo = 4  -- para la generacion del XML
    begin
        DELETE cr_verifica_xml_tmp
        WHERE vt_x_tramite = @i_tramite
        AND vt_x_cliente   = @i_ente

        DECLARE
        @w_pregunta SMALLINT,
        @w_item SMALLINT,
        @w_descripcion  VARCHAR(255),
        @w_pos2  SMALLINT


        SELECT @w_pregunta = 0

        CREATE TABLE #cr_verifica_xml_tmp(
        codigo     INT,
        secuencial INT IDENTITY NOT NULL,
        tag        varchar(255),
        respuesta  VARCHAR(10)
        )

        WHILE 1 = 1
        BEGIN
            -- leo la pregunta
            SELECT
                TOP 1 @w_pregunta     = pr_codigo,
                      @w_descripcion  = pr_descripcion
            FROM cob_credito..cr_pregunta_ver_dat
            WHERE pr_tipo = @w_grupal_aux
            AND pr_codigo > @w_pregunta
            ORDER BY pr_codigo
            IF @@ROWCOUNT = 0 BREAK
            --PRINT '--------->'+convert(VARCHAR, @w_pregunta) + ' - ' + + @w_descripcion
            -- parsear cada pregunta
            SELECT @w_pos1 = charindex('#', @w_descripcion)
EVAL_CAD:
            IF @w_pos1 > 0
            BEGIN
                SELECT @w_pos2 = charindex('#', @w_descripcion, @w_pos1+1)
                -- hay un tag
                IF @w_pos2 > 0
                BEGIN
                    --PRINT 'tag = '+ substring(@w_descripcion, @w_pos1, @w_pos2 - @w_pos1 + 1)
                    INSERT INTO #cr_verifica_xml_tmp VALUES(@w_pregunta, substring(@w_descripcion, @w_pos1, @w_pos2 - @w_pos1 + 1), 'x')
                    SELECT @w_descripcion = substring(@w_descripcion, @w_pos2 + 1, 1000)
                    SELECT @w_pos1 = charindex('#', @w_descripcion)
                    IF @w_pos1 > 0 GOTO EVAL_CAD
                END
                ELSE -- no hay tag
                BEGIN
                    --PRINT '- ' + convert(VARCHAR, @w_pregunta) + ' - ' + @w_descripcion
                    INSERT INTO #cr_verifica_xml_tmp VALUES(@w_pregunta, '**', 'x')
                END
            END
            ELSE -- no hay tag
            BEGIN
                --PRINT '+ ' + convert(VARCHAR, @w_pregunta) + ' - ' + @w_descripcion
                INSERT INTO #cr_verifica_xml_tmp VALUES(@w_pregunta, '**', 'x')
            END
        END -- while


        select
            @w_ingreso_total          = isnull(@w_otros_ingresos,0)+isnull(@w_ventas,0),
            @w_gasto_total            = isnull(@w_ct_ventas,0)+isnull(@w_ct_operativos,0),
            @w_nombre_grupo     = isnull (@w_nombre_grupo,''),
            @w_nombre_presi     = isnull (@w_nombre_presi,''),
            @w_nombre           = isnull (@w_nombre,''),
            @w_apellido_paterno = isnull (@w_apellido_paterno,''),
            @w_apellido_materno = isnull (@w_apellido_materno,''),
            @w_calle            = isnull (@w_calle,''),
            @w_numero           = isnull (@w_numero,''),
            @w_colonia          = isnull (@w_colonia,''),
            @w_delegacion_municipio     = isnull (@w_delegacion_municipio,''),
            @w_ocupacion                = isnull (@w_ocupacion,''),
            @w_nombre_negocio           = isnull (@w_nombre_negocio,''),
            @w_tiempo_arraigo_negocio   = isnull (@w_tiempo_arraigo_negocio,''),
            @w_anos_en_domic_actual     = isnull (@w_anos_en_domic_actual,''),
            @w_tipo_local               = isnull (@w_tipo_local,'')

        update #cr_verifica_xml_tmp set tag = replace(tag, '#SUELDO#', convert(varchar,cast(@w_ingreso_total as money),1))
        update #cr_verifica_xml_tmp set tag = replace(tag, '#GASTOS#', convert(varchar,cast(@w_gasto_total as money),1))
        update #cr_verifica_xml_tmp set tag = replace(tag, '#NOM_GRUPO#', convert(varchar, @w_nombre_grupo))
        update #cr_verifica_xml_tmp set tag = replace(tag, '#PRESIDENTE#', convert(varchar, @w_nombre_presi))
        update #cr_verifica_xml_tmp set tag = replace(tag, '#NOM_CLIENTE#', @w_nombre + ' ' + @w_apellido_paterno + ' ' + @w_apellido_materno )
        update #cr_verifica_xml_tmp set tag = replace(tag, '#DIRECCION#', @w_calle + ' ' + @w_numero + ' ' +@w_colonia + ' ' + @w_delegacion_municipio )
        update #cr_verifica_xml_tmp set tag = replace(tag, '#ACTIVIDAD#', @w_ocupacion)
        update #cr_verifica_xml_tmp set tag = replace(tag, '#COMERCIO#', @w_nombre_negocio)
        update #cr_verifica_xml_tmp set tag = replace(tag, '#TIEMPO#', convert(varchar, @w_tiempo_arraigo_negocio))
        update #cr_verifica_xml_tmp set tag = replace(tag, '#TIEMPO_VIV#', @w_anos_en_domic_actual)
        update #cr_verifica_xml_tmp set tag = replace(tag, '#TIEMPO_TR#', @w_tiempo_arraigo_negocio)
        update #cr_verifica_xml_tmp set tag = replace(tag, '#LOCAL#', @w_tipo_local)

        delete cr_verifica_xml_tmp where vt_x_tramite = @i_tramite and vt_x_cliente = @i_ente

        INSERT INTO cr_verifica_xml_tmp
        SELECT @i_tramite, @i_ente, codigo, secuencial, tag, vt_respuesta
        FROM #cr_verifica_xml_tmp, #cr_verifica_tmp
        WHERE vt_tramite = @i_tramite
        AND vt_cliente = @i_ente
        and vt_codigo  = codigo

		drop TABLE #cr_verifica_tmp

        return 0
    END -- mod = 4

    update #cr_verifica_tmp set vt_pregunta = replace(vt_pregunta, '#SUELDO#', convert(varchar,cast(@w_ingreso_total as money),1))
    update #cr_verifica_tmp set vt_pregunta = replace(vt_pregunta, '#GASTOS#', convert(varchar,cast(@w_gasto_total as money),1))
    update #cr_verifica_tmp set vt_pregunta = replace(vt_pregunta, '#NOM_GRUPO#', convert(varchar, @w_nombre_grupo))
    update #cr_verifica_tmp set vt_pregunta = replace(vt_pregunta, '#PRESIDENTE#', convert(varchar, @w_nombre_presi))
    update #cr_verifica_tmp set vt_pregunta = replace(vt_pregunta, '#NOM_CLIENTE#', @w_nombre + ' ' + @w_apellido_paterno + ' ' + @w_apellido_materno )
    update #cr_verifica_tmp set vt_pregunta = replace(vt_pregunta, '#DIRECCION#', @w_calle + ' ' + @w_numero + ' ' +@w_colonia + ' ' + @w_delegacion_municipio )
    update #cr_verifica_tmp set vt_pregunta = replace(vt_pregunta, '#ACTIVIDAD#', @w_ocupacion)
    update #cr_verifica_tmp set vt_pregunta = replace(vt_pregunta, '#COMERCIO#', @w_nombre_negocio)
    update #cr_verifica_tmp set vt_pregunta = replace(vt_pregunta, '#TIEMPO#', convert(varchar, @w_tiempo_arraigo_negocio))
    update #cr_verifica_tmp set vt_pregunta = replace(vt_pregunta, '#TIEMPO_VIV#', @w_anos_en_domic_actual)
    update #cr_verifica_tmp set vt_pregunta = replace(vt_pregunta, '#TIEMPO_TR#', @w_tiempo_arraigo_negocio)
    update #cr_verifica_tmp set vt_pregunta = replace(vt_pregunta, '#LOCAL#', @w_tipo_local)

    if @i_modo = 1
    begin
        if (@w_grupal = 'S')
        begin
            -- grilla No.1
            SELECT vt_tramite, vt_cliente, vt_codigo, vt_pregunta, vt_respuesta,@w_resultado
            FROM #cr_verifica_tmp
            WHERE vt_tramite = @i_tramite
            AND vt_cliente = @i_ente
            and vt_codigo between 1 and 5
            ORDER BY vt_codigo
        end
        else
        begin
            SELECT vt_tramite, vt_cliente, vt_codigo, vt_pregunta, vt_respuesta,@w_resultado
            FROM #cr_verifica_tmp
            WHERE vt_tramite = @i_tramite
            AND vt_cliente = @i_ente
            and vt_codigo between 1 and 2
            ORDER BY vt_codigo
        end
    end
    if @i_modo = 2
    begin
        if (@w_grupal = 'S')
        begin
           -- grilla No.2
           SELECT vt_tramite, vt_cliente, vt_codigo, vt_pregunta, vt_respuesta,@w_resultado
           FROM #cr_verifica_tmp
           WHERE vt_tramite = @i_tramite
           AND vt_cliente = @i_ente
           and vt_codigo between 6 and 12
           ORDER BY vt_codigo
        end
        else
        begin
           -- grilla No.2
           SELECT vt_tramite, vt_cliente, vt_codigo, vt_pregunta, vt_respuesta,@w_resultado
           FROM #cr_verifica_tmp
           WHERE vt_tramite = @i_tramite
           AND vt_cliente = @i_ente
           and vt_codigo between 3 and 9
           ORDER BY vt_codigo
        end
    end

    if @i_modo = 3
    begin
        if (@w_grupal = 'S')
        begin
           -- grilla No.3
               SELECT vt_tramite, vt_cliente, vt_codigo, vt_pregunta, vt_respuesta,@w_resultado
           FROM #cr_verifica_tmp
           WHERE vt_tramite = @i_tramite
           AND vt_cliente = @i_ente
           and vt_codigo > 12
           ORDER BY vt_codigo
        end
        else
        begin
            -- grilla No.3
               SELECT vt_tramite, vt_cliente, vt_codigo, vt_pregunta, vt_respuesta,@w_resultado
           FROM #cr_verifica_tmp
           WHERE vt_tramite = @i_tramite
           AND vt_cliente = @i_ente
           and vt_codigo > 9
           ORDER BY vt_codigo
        end
    end

end -- Fin Operacion Q

return 0

ERROR:
    begin --Devuelve mensaje de Error
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = @w_error
        return @w_error
    end

GO

