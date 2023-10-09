use master
go
if exists (select * from sysobjects where name = 'sp_reclogin')
    drop proc sp_reclogin
go
create proc sp_reclogin (
    @i_server          varchar(30) = NULL,
    @i_login           varchar(30),
    @i_terminal        varchar(30) = NULL,
    @i_office          int,
    @i_role            int,
    @s_sesn            int,
    @i_check           char(1) = 'S',
    @i_modo            tinyint = 0,
    @o_fecha           datetime = NULL    output,
    @o_hora            datetime = NULL        output,
    -- PTO 1996-08-08 Retornar dias antes de que password caduque
    @o_dvpass          int = NULL    output,
    -- PTO 1996-09-16 Retornar dias para cambio de password
    @o_dcpass          tinyint = NULL    output
    -- **********************************************************
) as
    declare @w_terminal varchar(30),
        @w_servidor       varchar(30),
        @w_servidor_central varchar(30),
        @w_fecha_in       datetime,
        @w_fecha_out      datetime,
        @w_dvpw           tinyint,
        @w_avpw           tinyint,
        @w_fecha_ult_mod  datetime,
        @w_fecha_suma     datetime,
        @w_dias           int,
        @w_estado_usr     char(1),
        @w_mensaje        varchar(128),
        @w_return         int,
        @w_horaini        varchar(8),
        @w_horafin        varchar(8)

    select @o_fecha = fp_fecha
    from cobis.dbo.ba_fecha_proceso

    select @o_hora = getdate()

    if @i_terminal is NULL
    begin
        raiserror 900000 'Nombre de terminal no transmitido'
        return 1
    end

    if @i_server is NULL
    begin
        raiserror 900000 'Nombre de servidor no transmitido'
        return 1
    end

    if @i_modo = 1
    begin
        exec @w_return=cobis..sp_check_loghorol
            @i_login=@i_login,
            @i_rol=@i_role,
            @o_fini=@w_horaini out,
            @o_ffin=@w_horafin out
        if @w_return!=0
        begin
            raiserror 900000 'Usuario rol u horario incorrecto'
            return 1 
        end
        select 'reclogin'=@w_horaini+@w_horafin
    end

    if (@i_check = 'S')
    begin

        select @w_dvpw = pa_tinyint
        from cobis.dbo.cl_parametro
        where pa_nemonico = 'DVPW'
        
        select @w_avpw = pa_tinyint
        from cobis.dbo.cl_parametro
        where pa_nemonico = 'AVPW'
        
        -- PTO 1996-09-16 Dias para cambio de password
        select @o_dcpass = isnull(pa_tinyint, 2)
        from cobis.dbo.cl_parametro
        where pa_nemonico = 'CHPW'

        select @w_servidor_central = isnull(pa_char, '')
        from cobis.dbo.cl_parametro
        where pa_nemonico = 'SCVL'

        if @@rowcount = 0 select @o_dcpass = 2    
        
        select @w_fecha_ult_mod = us_fecha_ult_mod,
           @w_estado_usr = us_estado
        from cobis.dbo.ad_usuario
        where us_login = @i_login
        and us_oficina = @i_office
        
        if (@w_estado_usr != 'V')
        begin
            raiserror 900000 'Usuario NO vigente. Solicite AUTORIZACION'
            return 1
        end
        
        select @w_fecha_suma = dateadd(day, @w_dvpw, @w_fecha_ult_mod)
        
        if ((@w_fecha_suma < getdate()) OR (@w_fecha_suma IS NULL))
        begin
            raiserror 900000 'Usuario tiene password caducada'
            return 1
        end
        select @w_dias = datediff(day, getdate(), @w_fecha_suma)
        if (@w_dias < @w_avpw)
        begin
            select 'AVISO: su password expira el ' +
                convert(char(20), @w_fecha_suma, 11)
        end
        
        
        if (@w_servidor_central=@i_server)
        begin
            if (exists (select 1 from cobis..in_login where lo_login = @i_login and  lo_fecha_out = NULL and lo_terminal<>@i_terminal))
            begin
                select @w_terminal = lo_terminal,
                       @w_servidor = lo_server
                from   cobis..in_login
                where  lo_login = @i_login
                       and lo_terminal<>@i_terminal
                       and lo_fecha_out = NULL
                
                select @w_mensaje = 'Usuario: '+@i_login+
                        ' fue registrado anteriormente en '
                        +@w_servidor+'.'+@w_terminal
                raiserror 900000 @w_mensaje
                return 1
            end
        end
        else
        begin
            select @w_terminal = lo_terminal,
                   @w_servidor = lo_server
            from   cobis..in_login
            where  lo_login = @i_login
                   and (lo_server <> @w_servidor_central or lo_terminal<>@i_terminal)
                   and lo_fecha_out = NULL
                    
            if (@w_terminal is not null)
            begin
                if ((@w_terminal != @i_terminal) OR (@w_servidor != @i_server))
                begin
                    select @w_mensaje = 'Usuario: '+@i_login+
                            ' fue registrado anteriormente en '
                            +@w_servidor+'.'+@w_terminal
                    raiserror 900000 @w_mensaje
                    return 1
                end
            end
        end
        
        select @w_terminal = lo_terminal,
               @w_servidor = lo_server,
               @w_fecha_in = lo_fecha_in,
               @w_fecha_out= lo_fecha_out
        from   cobis..in_login
        where  lo_login = @i_login
        and    lo_fecha_in = (select max(lo_fecha_in)
                              from cobis..in_login
                              where  lo_login = @i_login)
        
        insert into cobis..in_login 
        (lo_login, lo_terminal, lo_server, lo_sesion, lo_mail, lo_fecha_in)
        values
        (@i_login, @i_terminal, @i_server, @s_sesn, 'N', getdate())
        
        if (@@rowcount != 1)
        begin
            raiserror 900000 'Usuario no puede registrarse por error en in_login'
            return 1
        end
        
        raiserror 44441 'l'
        select i_server    = @i_server,
            i_login        = @i_login,
            i_terminal     = substring(@i_terminal,1,10),
            i_office       = @i_office,
            i_role         = @i_role
        if (@w_fecha_in is NULL)
            select 'Usted debe modificar ahora su clave de ingreso'+
                char(13) + char(10) + ' Bienvenido a COBIS'
        else
            if (@w_fecha_out is NULL)
                select respuesta = 'Ultimo ingreso en '+
                    @w_servidor+'.'+@w_terminal+
                    char(13) + char(10) + 'Desde: ' +
                    convert(char(19),@w_fecha_in)+
                    char(13) + char(10) +
                    ' y se encuentra activa' +
                    char(13) + char(10) + 'Bienvenido a COBIS'
            else
                select respuesta = 'Ultimo ingreso: '+
                    @w_servidor+'.'+@w_terminal+
                    char(13) + char(10) + 'Desde: ' +
                    convert(char(19),@w_fecha_in)+
                    char(13) + char(10) + 'Hasta: ' +
                    convert(char(19),@w_fecha_out)+
                    char(13) + char(10) + 'Bienvenido a COBIS'
        -- PTO 1996-08-08 Retornar dias antes de que password caduque
        -- select diasvpwd = @w_dias
        select @o_dvpass = @w_dias
        -- **********************************************************
    end
    else
    begin
        raiserror 44441 'l'
        select i_server   = @i_server,
            i_login       = @i_login,
            i_terminal    = substring(@i_terminal,1,10),
            i_office      = @i_office,
            i_role        = @i_role
        select respuesta  = 'Bienvenido a COBIS'
    end
    return 0
go
