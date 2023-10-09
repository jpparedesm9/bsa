/*******************************************************************/
/*  Archivo:          mantfunaut.sp                                */
/*  Stored procedure: sp_tr_mant_fun_aut                           */
/*  Base de datos:    cob_remesas                                  */
/*  Producto:         Cuentas de Ahorros                           */
/*******************************************************************/
/*                         IMPORTANTE                              */
/* Esta aplicacion es parte de los paquetes bancarios propiedad    */
/* de COBISCorp.                                                   */
/* Su uso no autorizado queda expresamente prohibido asi como      */
/* cualquier alteracion o agregado  hecho por alguno de sus        */
/* usuarios sin el debido consentimiento por escrito de COBISCorp. */
/* Este programa esta protegido por la ley de derechos de autor    */
/* y por las convenciones  internacionales   de  propiedad inte-   */
/* lectual.    Su uso no  autorizado dara  derecho a COBISCorp para*/
/* obtener ordenes  de secuestro o retencion y para  perseguir     */
/* penalmente a los autores de cualquier infraccion.               */
/*******************************************************************/
/*                           PROPOSITO                             */
/* Permite almacenar las notas de credito y debito de cuentas      */
/* de ahorros en una tabla de transaciones por autorizar.          */
/* Estas transacciones son realizadas desde el modulo de TADMIN    */
/*******************************************************************/
/*                        MODIFICACIONES                           */
/*  FECHA                 AUTOR           RAZON                    */
/* 08/Jul/2016          J. Tagle        Migración a CEN            */
/*******************************************************************/

use cob_remesas
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select * from sysobjects where name = 'sp_tr_mant_fun_aut')
    drop proc sp_tr_mant_fun_aut
go

create proc sp_tr_mant_fun_aut (
    @s_ssn              int,
    @s_srv              varchar(30),
    @s_lsrv             varchar(30),
    @s_user             varchar(30),
    @s_sesn             int,
    @s_term             varchar(32),
    @s_date             datetime,
    @s_ofi              smallint,
    @s_rol              smallint    = 1,
    @s_org_err          char(1)     = null,
    @s_error            int         = null,
    @s_sev              tinyint     = null,
    @s_msg              catalogo    = null,
    @s_org              char(1),
    @t_show_version     bit         = 0, 
    @t_debug            char(1)     = 'N',
    @t_file             varchar(14) = null,
    @t_from             varchar(32) = null,
    @t_rty              char(1)     = 'N',
    @t_trn              smallint,
    @i_autorizante      smallint    = 0,
    @i_ejecutor         smallint    = null,
    @i_tipo_f           char(1),
    @i_operacion        char(2),
    @i_modo             tinyint     = null
)
as
declare
        @w_return         int,
    @w_sp_name        varchar(30)

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_tr_mant_fun_aut'

---- VERSIONAMIENTO DEL PROGRAMA ----
if @t_show_version = 1
begin
    print 'Stored procedure sp_tr_mant_fun_aut, Version 4.0.0.1'
    return 0
end

/*  Activacion del Modo de debug  */
if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug @t_file=@t_file
    select  '/**  Stored Procedure  **/ ' = @w_sp_name,
        s_ssn           = @s_ssn,
        s_srv           = @s_srv,
        s_lsrv          = @s_lsrv,
        s_user          = @s_user,
        s_sesn          = @s_sesn,
        s_term          = @s_term,
        s_date          = @s_date,
        s_ofi           = @s_ofi,
        s_rol           = @s_rol,
        s_org_err       = @s_org_err,
        s_error         = @s_error,
        s_sev           = @s_sev,
        s_msg           = @s_msg,
        s_ori           = @s_org,   
        t_from          = @t_from,
        t_file          = @t_file, 
        t_rty           = @t_rty,
        t_trn           = @t_trn,
        i_autorizante   = @i_autorizante,
        i_ejecutor      = @i_ejecutor,
        i_tipo_f        = @i_tipo_f,
        i_operacion     = @i_operacion,
        i_modo          = @i_modo     
        
    exec cobis..sp_end_debug
  end


if @t_trn not in (411, 412, 413, 414, 415, 416)
   begin

    /* Codigo de transaccion errado */
        exec cobis..sp_cerror
             @t_debug   = @t_debug,
             @t_file    = @t_file,
             @t_from    = @w_sp_name,
			 @i_msg		= 'ERROR EN CODIGO DE TRANSACCION',
             @i_num     = 201048  -- ERROR EN CODIGO DE TRANSACCION
        return 201048
   end
   

if @t_trn in (412) /* Creaci¢n de funcionarios autorizantes */
begin
    if @i_operacion = 'I'
    begin
        if exists(select 1 from cob_cuentas..cc_funcionario_autoriz where fa_autorizante = @i_autorizante and fa_tipo = 'S') 
        begin
            exec cobis..sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
			@i_msg		= 'YA EXISTE FUNCIONARIO AUTORIZANTE',
            @i_num     = 203091  -- YA EXISTE FUNCIONARIO AUTORIZANTE
            return 203091
        end        
        begin tran
            insert into cob_cuentas..cc_funcionario_autoriz 
            values(@i_autorizante, @i_ejecutor, @i_tipo_f)
            
            if @@error <> 0 or @@rowcount = 0
            begin
                exec cobis..sp_cerror
                @t_debug   = @t_debug,
                @t_file    = @t_file,
                @t_from    = @w_sp_name,
				@i_msg		= 'ERROR EN CREACION DE AUTORIZANTE DE NOTAS DEBITO / CREDITO',
                @i_num     = 203082  -- ERROR EN CREACION DE AUTORIZANTE DE NOTAS DEBITO / CREDITO
                return 203082
            end
        commit tran
    end
end



if @t_trn in (413) /* Eliminaci¢n de funcionarios autorizantes */
begin
    if @i_operacion = 'D'
    begin
        if exists(select *
                    from cob_cuentas..cc_funcionario_autoriz
                    where fa_autorizante = @i_autorizante
                    and fa_tipo = 'D')
        begin
            exec cobis..sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
			@i_msg		= 'EL FUNCIONARIO AUTORIZANTE QUE SE DESEA ELIMINAR TIENE ASOCIADO FUNCIONARIOS DIGITADORES',
            @i_num     = 201327  -- EL FUNCIONARIO AUTORIZANTE QUE SE DESEA ELIMINAR TIENE ASOCIADO FUNCIONARIOS DIGITADORES 
            return 201327
        end      
        begin tran
            delete cob_cuentas..cc_funcionario_autoriz
            where fa_autorizante = @i_autorizante
            and fa_tipo = @i_tipo_f
            
            if @@rowcount = 0 or @@error <> 0 
            begin
                exec cobis..sp_cerror
                @t_debug   = @t_debug,
                @t_file    = @t_file,
                @t_from    = @w_sp_name,
				@i_msg		= 'ERROR AL ELIMINAR REGISTRO DE FUNCIONARIO AUTORIZANTE',
                @i_num     = 207037  -- ERROR AL ELIMINAR REGISTRO DE FUNCIONARIO AUTORIZANTE
                return 207037
            end      
        commit tran
    end
end
   
   

if @t_trn in (411) /* Consulta de funcionarios autorizantes */
begin
    if @i_operacion = 'S'
    begin
        set rowcount 20
        select  'CODIGO'    = fa_autorizante,
                'NOMBRE'    = fu_nombre
        from  cob_cuentas..cc_funcionario_autoriz, 
        cobis..cl_funcionario
        where  fu_funcionario = fa_autorizante
        and  fa_tipo = 'S'   
        and  fa_autorizante > @i_autorizante
        order by fa_autorizante
        set rowcount 0
    end
    if @i_operacion = 'S1'
    begin
        set rowcount 20
        select  fa_autorizante,fu_nombre
        from  cob_cuentas..cc_funcionario_autoriz, 
        cobis..cl_funcionario
        where  fu_funcionario = fa_autorizante
        and  fa_tipo = 'S'   
        and  fa_autorizante > @i_autorizante
        order by fa_autorizante
        set rowcount 0
    end
    if @i_operacion = 'Q'
    begin
        select  'CODIGO'    = fa_autorizante,
                'NOMBRE'    = fu_nombre
        from  cob_cuentas..cc_funcionario_autoriz, cobis..cl_funcionario
        where  fu_funcionario = fa_autorizante
        and  fa_tipo = 'S'   
        and  fa_autorizante = @i_autorizante
    end
    if @i_operacion = 'Q1'
    begin
        select  'NOMBRE'    = fu_nombre
        from  cob_cuentas..cc_funcionario_autoriz, 
        cobis..cl_funcionario
        where  fu_funcionario = fa_autorizante
        and  fa_tipo = 'S'   
        and  fa_autorizante = @i_autorizante
        if @@rowcount = 0
        begin
            exec cobis..sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
			@i_msg		= 'NO EXISTEN FUNCIONARIO AUTORIZANTE',
            @i_num     = 201328 -- NO EXISTEN FUNCIONARIO AUTORIZANTE 
            return 201328
        end
    end
end


if @t_trn in (414)
begin
    if @i_operacion = 'S'
    begin
        set rowcount 20
        if @i_modo = 0
        begin
            select  
            'COD. AUTORIZANTE'  = fa_autorizante,
            'NOM. AUTORIZANTE'  = (select fu_nombre
                                    from cobis..cl_funcionario
                                    where fu_funcionario = a.fa_autorizante),
            'COD. EJECUTOR'     = fa_ejecutor,
            'NOM. EJECUTOR'     = (select fu_nombre
                                    from cobis..cl_funcionario
                                    where fu_funcionario = a.fa_ejecutor)                    
            from   cob_cuentas..cc_funcionario_autoriz a
            where   fa_autorizante in (select fa_autorizante
                                        from cob_cuentas..cc_funcionario_autoriz 
                                        where fa_tipo = 'S'
                                        and fa_autorizante = @i_autorizante)
            and   (fa_ejecutor = @i_ejecutor or @i_ejecutor = null)
            and   fa_tipo = @i_tipo_f
            order by fa_autorizante, fa_ejecutor       
        end
        else
        begin
            select  
			'COD. AUTORIZANTE'  = fa_autorizante,
            'NOM. AUTORIZANTE'  = (select fu_nombre
                                    from cobis..cl_funcionario
                                    where fu_funcionario = a.fa_autorizante),
            'COD. EJECUTOR'     = fa_ejecutor,
            'NOM. EJECUTOR'     = (select fu_nombre
                                    from cobis..cl_funcionario
                                    where fu_funcionario = a.fa_ejecutor)                    
            from   cob_cuentas..cc_funcionario_autoriz a
            where   fa_autorizante in (select fa_autorizante
                                        from cob_cuentas..cc_funcionario_autoriz 
                                        where fa_tipo = 'S'
                                        and fa_autorizante = @i_autorizante)
            and   (fa_ejecutor > @i_ejecutor)
            and   fa_tipo = @i_tipo_f
            order by fa_autorizante, fa_ejecutor       
        end
        set rowcount 0
    end
end


if @t_trn in (415) /*Ingreso de funcionario ejecutor*/
begin
    if @i_operacion = 'I'
    begin
        if @i_autorizante = @i_ejecutor
        begin
            exec cobis..sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
			@i_msg		= 'EL FUNCIONARIO EJECUTOR NO PUDE SER AUTORIZANTE DE EL MISMO',
            @i_num     = 208047 -- EL FUNCIONARIO EJECUTOR NO PUDE SER AUTORIZANTE DE EL MISMO
            return 208047
        end
        begin tran
            if exists (select 1
            from cob_cuentas..cc_funcionario_autoriz
            where fa_autorizante = @i_autorizante
            and fa_ejecutor    = @i_ejecutor)
            begin
                exec cobis..sp_cerror
                @t_debug   = @t_debug,
                @t_file    = @t_file,
                @t_from    = @w_sp_name,
				@i_msg		= 'EL USUARIO EJECUTOR YA SE ENCUENTRA INGRESADO CON EL MISMO AUTORIZANTE',
                @i_num     = 207044 -- EL USUARIO EJECUTOR YA SE ENCUENTRA INGRESADO CON EL MISMO AUTORIZANTE
                return 207044
            end
            insert into cob_cuentas..cc_funcionario_autoriz
            values(@i_autorizante, @i_ejecutor, @i_tipo_f)
            if @@error <> 0 
            begin
                exec cobis..sp_cerror
                @t_debug   = @t_debug,
                @t_file    = @t_file,
                @t_from    = @w_sp_name,
				@i_msg		= 'ERROR EN CREACION DE EJECUTOR DE NOTAS DEBITO / CREDITO',
                @i_num     = 203083 -- ERROR EN CREACION DE EJECUTOR DE NOTAS DEBITO / CREDITO
                return 203083
            end
        commit tran
    end
end



if @t_trn in (416) /* Eliminacion de funcionarios ejecutores */
begin
    if @i_operacion = 'D'
    begin        
        begin tran
            delete cob_cuentas..cc_funcionario_autoriz
            where fa_autorizante = @i_autorizante
            and fa_ejecutor    = @i_ejecutor
            and fa_tipo = @i_tipo_f
            if @@rowcount = 0 or @@error <> 0 
            begin
                exec cobis..sp_cerror
                @t_debug   = @t_debug,
                @t_file    = @t_file,
                @t_from    = @w_sp_name,
				@i_msg		= 'ERROR AL ELIMINAR REGISTRO DE FUNCIONARIO EJECUTOR',
                @i_num     = 207038 -- ERROR AL ELIMINAR REGISTRO DE FUNCIONARIO EJECUTOR
                return 207038
            end      
        commit tran
    end
end

return 0
go