/***********************************************************************/
/*      Archivo:                        sp_princ_clientes.sp           */
/*      Stored procedure:               sp_princ_clientes              */
/*      Base de Datos:                  cobis                          */
/*      Producto:                       Clientes                       */
/*      Disenado por:                   Alejandro Fernandez            */
/*      Fecha de Documentacion:         22/Jul/2015                    */
/***********************************************************************/
/*                      IMPORTANTE                                     */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/***********************************************************************/
/*                      PROPOSITO                                      */
/* Realizar Validaciones al modulo de Cliente                          */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      25/08/2016      Ignacio Yupa            Emision Inicial         */  
/***********************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_princ_clientes')
   drop proc sp_princ_clientes
go
create proc sp_princ_clientes
-- (
--    @i_rango             int          = null, -- 50000
--    @i_val               char(2)      = null  -- S
-- )
as

declare
   @w_sp_name           varchar(30),    --Setea nombre del Sp
   @w_pase              int,            --Numero de Ciclos
   @w_minimo            int,            --Rango minimo de registros
   @w_registros         int,            --Cantidad de registros
   @w_tabla_pric        varchar(30),    --Tabla en uso
   @w_rango             int,            --Rango de seleccion de registro
   @w_conteo            int,            --Cantidad de registro en tabla principal
   @w_clave_i           int,            --Registro Clave Inicial
   @w_clave_f           int,            --Registro Clave Final
   @w_return            int
   --@w_comando           varchar(255)    --llamada al dump

--------------------------------
-- REINICIANDO CONTADOR DE TABLAS MIG
--------------------------------
exec contadores_tablas_mig


-- ------------------------------------------------------------------
-- - Variables Iniciales
-- ------------------------------------------------------------------
select  @w_sp_name        = 'sp_princ_clientes',
        @w_pase           = 0,
        @w_minimo         = 0,
        @w_registros      = 0,
        @w_tabla_pric     = 'cl_ente_mig',
        @w_rango          = 1000,
        @w_conteo         = (select rm_total from cl_rango_mig where rm_tabla = 'cl_ente_mig'),
        @w_clave_i        = 0,
        @w_clave_f        = @w_rango
        --@w_comando        = 'isql -U' + @i_user + ' -P' + @i_pass + ' -S' + @i_server + ' -n -i' + @i_direct + '/dump.txt'

    -- if upper(@i_val) = 'N'
    --     return 0
  
--------------------------------
-- REINICIA LOS LOGS
--------------------------------
-- if upper(@i_val) = 'S'
-- begin
    -- update cl_rango_mig set rm_ciclos=0, rm_valor_rango = 0, rm_valor_regis = 0 , rm_cant_reg_val = 0 , rm_fec_fin_val = null , rm_fec_ini_val =  null , rm_cant_reg_cobis = 0
    -- where rm_tabla != 'Definitivas'
    -- delete from cl_log_mig where lm_tabla = @w_tabla_pric
-- end

-- if upper(@i_val) = 'S'
-- begin
    -- ------------------------------------------------------------------
    -- - Validacion cl_ente
    -- ------------------------------------------------------------------
    update cl_rango_mig set rm_fec_ini_val = getdate()
    where rm_tabla = @w_tabla_pric

    while @w_minimo < @w_conteo
    begin
        --Obtener los clientes
        select @w_registros = count(en_ente)
        from cl_ente_mig
        where en_ente between @w_clave_i and @w_clave_f

        if @w_registros = 0
        begin
            select @w_clave_i = (select min(en_ente) - 1 from cl_ente_mig where en_ente > @w_clave_i)
            select @w_clave_f = @w_clave_i + @w_rango

            select @w_registros = count(en_ente)
            from cl_ente_mig
            where en_ente between @w_clave_i and @w_clave_f
        end

        --Ejecucion de Validaciones cl_ente
        exec sp_valida_cl_ente @i_clave_i = @w_clave_i,
                             @i_clave_f = @w_clave_f

        --Actualizar Rangos
        select @w_clave_i = @w_clave_i + @w_rango
        select @w_clave_f = @w_clave_f + @w_rango

        select @w_minimo = @w_minimo + @w_registros

        if @w_registros <> 0
        begin
            select @w_pase = @w_pase + 1
            update cl_rango_mig set
            rm_valor_regis  = isnull(@w_minimo,0),
            rm_valor_rango  = isnull(@w_clave_i,0),
            rm_ciclos       = @w_pase
            where rm_tabla = @w_tabla_pric
            -- exec xp_cmdshell @w_comando, no_output
        end
    end

    update cl_rango_mig set rm_fec_fin_val    = getdate(),
                            rm_cant_reg_val   = (select count(*) from cl_ente_mig where en_estado_mig = 'VE')
    where rm_tabla = @w_tabla_pric

    -- ------------------------------------------------------------------
    -- - Variables Iniciales
    -- ------------------------------------------------------------------
    select  @w_pase           = 0,
            @w_minimo         = 0,
            @w_registros      = 0,
            @w_tabla_pric     = 'cl_refinh_mig',
            @w_conteo         = (select rm_total from cl_rango_mig where rm_tabla = 'cl_refinh_mig'),
            @w_clave_i        = 0,
            @w_clave_f        = @w_rango --@i_rango
    -- ------------------------------------------------------------------
    -- - Validacion cl_refinh
    -- ------------------------------------------------------------------
    update cl_rango_mig set rm_fec_ini_val = getdate()
    where rm_tabla = @w_tabla_pric
    
    while @w_minimo < @w_conteo
    begin
        
        --Obtener los clientes
        select @w_registros = count(in_codigo)
        from cl_refinh_mig
        where in_codigo between @w_clave_i and @w_clave_f

        if @w_registros = 0
        begin
            select @w_clave_i = (select min(in_codigo) - 1 from cl_refinh_mig where in_codigo > @w_clave_i)
            select @w_clave_f = @w_clave_i + @w_rango

            select @w_registros = count(in_codigo)
            from cl_refinh_mig
            where in_codigo between @w_clave_i and @w_clave_f
        end

        --Ejecucion de Validaciones cl_refinh
        exec sp_valida_cl_refinh @i_clave_i = @w_clave_i,
                             @i_clave_f = @w_clave_f

        --Actualizar Rangos
        select @w_clave_i = @w_clave_i + @w_rango
        select @w_clave_f = @w_clave_f + @w_rango

        select @w_minimo = @w_minimo + @w_registros

        if @w_registros <> 0
        begin
            select @w_pase = @w_pase + 1
            update cl_rango_mig set
            rm_valor_regis  = isnull(@w_minimo,0),
            rm_valor_rango  = isnull(@w_clave_i,0),
            rm_ciclos       = @w_pase
            where rm_tabla = @w_tabla_pric
            -- exec xp_cmdshell @w_comando, no_output
        end
    end

    update cl_rango_mig set rm_fec_fin_val    = getdate(),
                            rm_cant_reg_val   = (select count(*) from cl_refinh_mig where in_estado_mig = 'VE')
    where rm_tabla = @w_tabla_pric

    -- ------------------------------------------------------------------
    -- - Variables Iniciales
    -- ------------------------------------------------------------------
    select  @w_pase           = 0,
            @w_minimo         = 0,
            @w_registros      = 0,
            @w_tabla_pric     = 'cl_direccion_mig',
            @w_conteo         = (select rm_total from cl_rango_mig where rm_tabla = 'cl_direccion_mig'),
            @w_clave_i        = 0,
            @w_clave_f        = @w_rango -- @i_rango
    -- ------------------------------------------------------------------
    -- - Validacion cl_direccion
    -- ------------------------------------------------------------------
    update cl_rango_mig set rm_fec_ini_val = getdate()
    where rm_tabla = @w_tabla_pric

    while @w_minimo < @w_conteo
    begin
        --Obtener los clientes
        select @w_registros = count(di_ente)
        from cl_direccion_mig
        where di_ente between @w_clave_i and @w_clave_f

        if @w_registros = 0
        begin
            select @w_clave_i = (select min(di_ente) - 1 from cl_direccion_mig where di_ente > @w_clave_i)
            select @w_clave_f = @w_clave_i + @w_rango

            --Obtener los clientes
            select @w_registros = count(di_ente)
            from cl_direccion_mig
            where di_ente between @w_clave_i and @w_clave_f
        end

        --Ejecucion de Validaciones cl_direccion
        exec sp_valida_cl_direccion @i_clave_i = @w_clave_i,
                                  @i_clave_f = @w_clave_f

        --Actualizar Rangos
        select @w_clave_i = @w_clave_i + @w_rango
        select @w_clave_f = @w_clave_f + @w_rango

        select @w_minimo = @w_minimo + @w_registros

        if @w_registros <> 0
        begin
            select @w_pase = @w_pase + 1
            update cl_rango_mig set rm_valor_regis  = isnull(@w_minimo,0),
                                 rm_valor_rango  = isnull(@w_clave_i,0),
                                 rm_ciclos       = @w_pase
            where rm_tabla = @w_tabla_pric
            -- exec xp_cmdshell @w_comando, no_output
        end
    end

    update cl_rango_mig set rm_fec_fin_val    = getdate(),
                            rm_cant_reg_val   = (select count(*) from cl_direccion_mig where di_estado_mig = 'VE')
    where rm_tabla = @w_tabla_pric

    -- ------------------------------------------------------------------
    -- - Variables Iniciales
    -- ------------------------------------------------------------------
    select  @w_pase           = 0,
            @w_minimo         = 0,
            @w_registros      = 0,
            @w_tabla_pric     = 'cl_telefono_mig',
            @w_conteo         = (select rm_total from cl_rango_mig where rm_tabla = 'cl_telefono_mig'),
            @w_clave_i        = 0,
            @w_clave_f        = @w_rango -- @i_rango

    -- ------------------------------------------------------------------
    -- - Validacion cl_telefono
    -- ------------------------------------------------------------------
    update cl_rango_mig set rm_fec_ini_val = getdate()
    where rm_tabla = @w_tabla_pric

    while @w_minimo < @w_conteo
    begin
        --Obtener los clientes
        select @w_registros = count(te_ente)
        from cl_telefono_mig
        where te_ente between @w_clave_i and @w_clave_f

        if @w_registros = 0
        begin
            select @w_clave_i = (select min(te_ente) - 1 from cl_telefono_mig where te_ente > @w_clave_i)
            select @w_clave_f = @w_clave_i + @w_rango

            --Obtener los clientes
            select @w_registros = count(te_ente)
            from cl_telefono_mig
            where te_ente between @w_clave_i and @w_clave_f
        end

        --Ejecucion de Validaciones cl_telefono
        exec sp_valida_cl_telefono  @i_clave_i = @w_clave_i,
                                    @i_clave_f = @w_clave_f

        --Actualizar Rangos
        select @w_clave_i = @w_clave_i + @w_rango
        select @w_clave_f = @w_clave_f + @w_rango

        select @w_minimo = @w_minimo + @w_registros

        if @w_registros <> 0
        begin
            select @w_pase = @w_pase + 1

            update cl_rango_mig set rm_valor_regis  = isnull(@w_minimo,0),
                                 rm_valor_rango  = isnull(@w_clave_i,0),
                                 rm_ciclos       = @w_pase
            where rm_tabla = @w_tabla_pric
            -- exec xp_cmdshell @w_comando, no_output
        end
    end

    update cl_rango_mig set rm_fec_fin_val    = getdate(),
                            rm_cant_reg_val   = (select count(*) from cl_telefono_mig where te_estado_mig = 'VE')
    where rm_tabla = @w_tabla_pric

    -- ------------------------------------------------------------------
    -- - Variables Iniciales
    -- ------------------------------------------------------------------
    select  @w_pase           = 0,
            @w_minimo         = 0,
            @w_registros      = 0,
            @w_tabla_pric     = 'cl_trabajo_mig',
            @w_conteo         = (select rm_total from cl_rango_mig where rm_tabla = 'cl_trabajo_mig'),
            @w_clave_i        = 0,
            @w_clave_f        = @w_rango -- @i_rango

    -- ------------------------------------------------------------------
    -- - Validacion cl_trabajo
    -- ------------------------------------------------------------------
    update cl_rango_mig set rm_fec_ini_val = getdate()
    where rm_tabla = @w_tabla_pric

    while @w_minimo < @w_conteo
    begin
        --Obtener los clientes
        select @w_registros = count(tr_persona)
        from cl_trabajo_mig
        where tr_persona between @w_clave_i and @w_clave_f

        if @w_registros = 0
        begin
            select @w_clave_i = (select min(tr_persona) - 1 from cl_trabajo_mig where tr_persona > @w_clave_i)
            select @w_clave_f = @w_clave_i + @w_rango

            --Obtener los clientes
            select @w_registros = count(tr_persona)
            from cl_trabajo_mig
            where tr_persona between @w_clave_i and @w_clave_f
        end

        --Ejecucion de Validaciones cl_trabajo
        exec sp_valida_cl_trabajo   @i_clave_i = @w_clave_i,
                                    @i_clave_f = @w_clave_f

        --Actualizar Rangos
        select @w_clave_i = @w_clave_i + @w_rango
        select @w_clave_f = @w_clave_f + @w_rango

        select @w_minimo = @w_minimo + @w_registros

        if @w_registros <> 0
        begin
            select @w_pase = @w_pase + 1
            update cl_rango_mig set rm_valor_regis  = isnull(@w_minimo,0),
                                    rm_valor_rango  = isnull(@w_clave_i,0),
                                    rm_ciclos       = @w_pase
            where rm_tabla = @w_tabla_pric
            -- exec xp_cmdshell @w_comando, no_output
        end
    end

    update cl_rango_mig set rm_fec_fin_val    = getdate(),
                            rm_cant_reg_val   = (select count(*) from cl_trabajo_mig where tr_estado_mig = 'VE')
    where rm_tabla = @w_tabla_pric

    -- ------------------------------------------------------------------
    -- - Variables Iniciales
    -- ------------------------------------------------------------------
    select  @w_pase           = 0,
            @w_minimo         = 0,
            @w_registros      = 0,
            @w_tabla_pric     = 'cl_ref_personal_mig',
            @w_conteo         = (select rm_total from cl_rango_mig where rm_tabla = 'cl_ref_personal_mig'),
            @w_clave_i        = 0,
            @w_clave_f        = @w_rango -- @i_rango

    -- ------------------------------------------------------------------
    -- - Validacion cl_ref_persona
    -- ------------------------------------------------------------------
    update cl_rango_mig set rm_fec_ini_val = getdate()
    where rm_tabla = @w_tabla_pric

    while @w_minimo < @w_conteo
    begin
        --Obtener los clientes
        select @w_registros = count(rp_persona)
        from cl_ref_personal_mig
        where rp_persona between @w_clave_i and @w_clave_f

        if @w_registros = 0
        begin
            select @w_clave_i = (select min(rp_persona) - 1 from cl_ref_personal_mig where rp_persona > @w_clave_i)
            select @w_clave_f = @w_clave_i + @w_rango

            --Obtener los clientes
            select @w_registros = count(rp_persona)
            from cl_ref_personal_mig
            where rp_persona between @w_clave_i and @w_clave_f
        end

        --Ejecucion de Validaciones cl_ref_persona
        exec sp_valida_ref_personal @i_clave_i = @w_clave_i,
                                    @i_clave_f = @w_clave_f

        --Actualizar Rangos
        select @w_clave_i = @w_clave_i + @w_rango
        select @w_clave_f = @w_clave_f + @w_rango

        select @w_minimo = @w_minimo + @w_registros

        if @w_registros <> 0
        begin
            select @w_pase = @w_pase + 1
            update cl_rango_mig set rm_valor_regis  = isnull(@w_minimo,0),
                                    rm_valor_rango  = isnull(@w_clave_i,0),
                                    rm_ciclos       = @w_pase
            where rm_tabla = @w_tabla_pric
            -- exec xp_cmdshell @w_comando, no_output
        end
    end

    update cl_rango_mig set rm_fec_fin_val    = getdate(),
                            rm_cant_reg_val   = (select count(*) from cl_ref_personal_mig where rp_estado_mig = 'VE')
    where rm_tabla = @w_tabla_pric






    -- ------------------------------------------------------------------
    -- - Variables Iniciales
    -- ------------------------------------------------------------------
    select  @w_pase           = 0,
            @w_minimo         = 0,
            @w_registros      = 0,
            @w_tabla_pric     = 'cl_instancia_mig',
            @w_conteo         = (select rm_total from cl_rango_mig where rm_tabla = 'cl_instancia_mig'),
            @w_clave_i        = 0,
            @w_clave_f        = @w_rango -- @i_rango

    -- ------------------------------------------------------------------
    -- - Validacion cl_instancia
    -- ------------------------------------------------------------------
    update cl_rango_mig set rm_fec_ini_val = getdate()
    where rm_tabla = @w_tabla_pric

    while @w_minimo < @w_conteo
    begin
        --Obtener los clientes
        select @w_registros = count(1)
        from cl_instancia_mig
        where in_ente_i between @w_clave_i and @w_clave_f

        if @w_registros = 0
        begin
            select @w_clave_i = (select min(in_ente_i) - 1 from cl_instancia_mig where in_ente_i > @w_clave_i)
            select @w_clave_f = @w_clave_i + @w_rango

            --Obtener los clientes
            select @w_registros = count(1)
            from cl_instancia_mig
            where in_ente_i between @w_clave_i and @w_clave_f
        end

        --Ejecucion de Validaciones cl_instancia
        exec @w_return=sp_valida_cl_instancia 
                @i_clave_i = @w_clave_i,
                @i_clave_f = @w_clave_f
        if @w_return <> 0
        begin
            insert into cl_log_mig
            select  '',
                    @w_tabla_pric,
                    @w_sp_name,
                    'sp_valida_cl_instancia',
                    @@error,
                    174,
                    ''
        end
        --Actualizar Rangos
        select @w_clave_i = @w_clave_i + @w_rango
        select @w_clave_f = @w_clave_f + @w_rango

        select @w_minimo = @w_minimo + @w_registros

        if @w_registros <> 0
        begin
            select @w_pase = @w_pase + 1
            update cl_rango_mig set rm_valor_regis  = isnull(@w_minimo,0),
                                    rm_valor_rango  = isnull(@w_clave_i,0),
                                    rm_ciclos       = @w_pase
            where rm_tabla = @w_tabla_pric
            -- exec xp_cmdshell @w_comando, no_output
        end
    end

    update cl_rango_mig set rm_fec_fin_val    = getdate(),
                            rm_cant_reg_val   = (select count(*) from cl_instancia_mig where in_estado_mig = 'VE')
    where rm_tabla = @w_tabla_pric

-- end -- END if upper(@i_val) = 'S'

return 0
go

