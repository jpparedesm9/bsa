USE [cobis]
GO
/****** Object:  StoredProcedure [dbo].[sp_facultad]    Script Date: 02/08/2018 11:05:08 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

ALTER proc [dbo].[sp_facultad] (
    @i_base_datos    varchar(30),
    @i_procedure     varchar(30),
    @i_login         varchar(30),
    @i_trn           int,
    @t_rol           smallint=-2,
    @t_branch        char(1)='S' -- ARO: Branch Unix
)
as

    declare @w_result    int

    if  (@i_procedure <> 'sp_reclogin') 
    AND (@i_procedure <> 'sp_intento')
    AND (@i_procedure <> 'sp_endlogin')
    AND (@i_procedure <> 'sp_cargarpc')
    AND (@i_procedure <> 'sp_recmail')
    AND (@i_procedure <> 'sp_line_status')
    AND (@i_procedure <> 'rp_rol')
    AND (@i_procedure <> 'rp_tr_autorizada')
    AND (@i_procedure <> 'sp_hp_catalogo')
    AND (@i_procedure <> 'rp_llave')
    AND (@i_procedure <> 'sp_services_catalog')
    AND (@i_procedure <> 'sp_authorized_modules')
    AND (@i_procedure <> 'sp_authorized_navigation_zone')
    AND (@i_procedure <> 'sp_authorized_zone')
    AND (@i_procedure <> 'sp_information_page')
    AND (@i_procedure <> 'sp_get_authorized_modules')
    AND (@i_procedure <> 'sp_information_page_offbanking')
    AND (@i_procedure <> 'sp_perfil')
    AND (@i_procedure <> 'sp_get_authorized_page')
    AND (@i_procedure <> 'sp_get_autho_navi_zones')
    AND (@i_procedure <> 'sp_get_authorized_agents')
    AND (@i_procedure <> 'sp_pagos_corresponsal_batch')
    
    begin
        if @t_rol!=-2
        begin
            select @w_result = 0
            exec @w_result = cobis..sp_check_rolspro
                @i_trn = @i_trn,
                @i_rol = @t_rol,
                @i_base= @i_base_datos,
                @i_sp  = @i_procedure

            if @w_result != 0 
            begin
                select null, null
                return 2
            end
        end

        /* ARO: Si es branch no ejecuta sp_protran_activa */
        if (@t_branch='N') 
        begin
            select @w_result = 0
            exec @w_result = cobis..sp_protran_activa
                @i_transaccion = @i_trn
            if @w_result = 1 
            begin
                select null, null
                return 1
            end
        end
        /* FIN ARO */

        if exists (select 1 from cl_trn_atrib where ta_transaccion=@i_trn and ta_graba_log='S')
        begin
            select null, null
            return 3
        end
        if exists (select 1 from cl_trn_atrib where ta_transaccion=@i_trn and ta_graba_log='A')
        begin
            select null, null
            return 4
        end
    end

    select fa_parametro, fa_maximo
    from   ad_facultad, ad_procedure
    where  pd_base_datos = @i_base_datos
    and    pd_stored_procedure = @i_procedure
    and    fa_login = @i_login
    and    fa_trn = @i_trn
    and    pd_procedure = fa_procedure
return 0
                                                                                                                                          
GO
