use master
go

if exists (select * from sysobjects where name = 'sp_reclogin')
   drop proc sp_reclogin
go

print 'sp_reclogin'
go

create proc sp_reclogin ( 
        @i_server varchar(30) = NULL, 
        @i_login varchar(30), 
        @i_terminal varchar(32) = NULL, 
        @i_office int, 
        @i_role int, 
        @s_sesn int, 
        @i_check char(1) = 'S', 
        @i_modo tinyint = 0,
        @i_campwd tinyint =0,
        @o_fecha datetime = NULL        out, 
        @o_hora datetime = NULL         out, 
        -- PTO 1996-08-08 Retornar dias antes de que password caduque 
        @o_dvpass int = NULL    out, 
        -- PTO 1996-09-16 Retornar dias para cambio de password 
        @o_dcpass tinyint = NULL        out ,
        -- **********************************************************
        @o_campwd tinyint =0   output,
    @t_show_version        bit = 0 -- Mostrar la versión del programa
) as 
--===========================================================================
--                     HISTORIAL DE MODIFICACIONES
--===========================================================================
-- FECHA       AUTOR                   MOTIVO
--===========================================================================
-- 20120807    Pedro Montenegro        Modificar programa de login para que
--                                     el parametro @i_terminal  sea de 32 
--                                     caracteres y que presente la fecha en 
--                                     formato yyyy/MM/dd segun la INC-1095.
--===========================================================================

        declare  @w_terminal varchar(32), 
                @w_servidor varchar(30), 
                @w_fecha_in datetime, 
                @w_fecha_out datetime, 
                @w_dvpw         tinyint, 
                @w_avpw         tinyint, 
                @w_fecha_ult_mod        datetime, 
                @w_fecha_suma   datetime, 
                @w_dias         int, 
                @w_estado_usr   char(1), 
                @w_mensaje      varchar(128),
                @w_return       int,
                @w_horaini      varchar(8),
                @w_horafin      varchar(8),
                @w_fec_cad_rol  datetime,
                @w_dbp          smallint,
                @w_fec_ult_in datetime,
                @w_estado_fun   char(1),
                @w_nom_oficina          varchar(64),
                @w_filas                        int

        if @t_show_version = 1
        begin
                print 'Stored procedure master..sp_reclogin, Version 4.0.0.6'
                return 0
        end

        select @o_fecha = fp_fecha 
        from cobis.dbo.ba_fecha_proceso 
 
        select @o_hora = getdate() 
 
        if @i_terminal is NULL 
        begin 
                RAISERROR (900000, 16, 1, N'Nombre de terminal no transmitido')
                return 1 
        end 
 
        if @i_server is NULL 
        begin 
                RAISERROR (900000, 16, 1, N'Nombre de servidor no transmitido')
                return 1 
        end 

        if @i_modo = 1
        begin

           select @w_estado_fun = fu_estado
           from cobis..cl_funcionario
           where fu_login = @i_login


                if (@w_estado_fun != 'V')
           begin
                RAISERROR (900000, 16, 1, N'Usuario esta bloqueado. Solicite AUTORIZACION')
                return 1
           end

                exec @w_return=cobis..sp_check_loghorol
                        @i_login=@i_login,
                        @i_rol=@i_role,
                        @o_fini=@w_horaini out,
                        @o_ffin=@w_horafin out
                if @w_return!=0
                begin
                        RAISERROR (900000, 16, 1, N'Usuario rol u horario incorrecto')
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


           -- Verificación de Bloqueo de Password

           select @w_dbp = pa_smallint
           from cobis.dbo.cl_parametro
           where pa_nemonico = 'DBP'
                and pa_producto = 'ADM'


                select @w_fec_ult_in=dateadd (day,@w_dbp,fu_fec_inicio) 
                from cobis..cl_funcionario 
                where fu_login=@i_login

                
           if (@w_fec_ult_in is not null)
       begin
           if ((
                   datepart(yy,@w_fec_ult_in) < datepart(yy,getdate())
               ) or
        
               (
                   datepart(yy,@w_fec_ult_in) = datepart(yy,getdate()) 
                   and 
                   datepart(mm,@w_fec_ult_in) < datepart(mm,getdate())
               ) or
         
              (
                   datepart(yy,@w_fec_ult_in) = datepart(yy,getdate()) 
                   and 
                   datepart(mm,@w_fec_ult_in) = datepart(mm,getdate())
                   and 
                   datepart(dd,@w_fec_ult_in) < datepart(dd,getdate())
               )
               ) 
        
                   begin
                        update cobis..cl_funcionario set fu_estado='B'
                        where fu_login=@i_login
                   end
           end

          select @w_estado_fun = fu_estado
           from cobis..cl_funcionario
           where fu_login = @i_login


                if (@w_estado_fun != 'V')
           begin
                RAISERROR (900000, 16, 1, N'Usuario esta bloqueado. Solicite AUTORIZACION')
                return 1
           end

           -- FIN Verificación de Bloqueo de Password
           


           -- Verificación de caducidad de rol
           select @w_fec_cad_rol=NULL
           select @w_fec_cad_rol = ur_fec_cad_rol 
           from cobis..ad_usuario_rol where
                ur_login=@i_login
                and ur_rol=@i_role
           

           if (@w_fec_cad_rol is not null)
           begin
           if ((
                   datepart(yy,@w_fec_cad_rol) < datepart(yy,getdate())
               ) or
        
               (
                   datepart(yy,@w_fec_cad_rol) = datepart(yy,getdate()) 
                   and 
                   datepart(mm,@w_fec_cad_rol) < datepart(mm,getdate())
               ) or
         
              (
                   datepart(yy,@w_fec_cad_rol) = datepart(yy,getdate()) 
                   and 
                   datepart(mm,@w_fec_cad_rol) = datepart(mm,getdate())
                   and 
                   datepart(dd,@w_fec_cad_rol) < datepart(dd,getdate())
               )
               ) 
        
                   begin
                        RAISERROR (900000, 16, 1, N'El rol seleccionado esta caducado')
                        return 1
                   end
           end

           -- FIN Verificación de Rol caducado.
 
           -- PTO 1996-09-16 Dias para cambio de password 
           select @o_dcpass = isnull(pa_tinyint, 2) 
           from cobis..cl_parametro 
           where pa_nemonico = 'CHPW' 
           if @@rowcount = 0 select @o_dcpass = 2        
 
           select @w_fecha_ult_mod = us_fecha_ult_mod, 
                  @w_estado_usr = us_estado 
           from cobis..ad_usuario 
           where us_login = @i_login 
           and us_oficina = @i_office 

                select @w_filas = @@rowcount

                if (@w_estado_usr != 'V')
                begin
                        select @w_nom_oficina = of_nombre
                        from cobis..cl_oficina
                        where of_oficina = @i_office


                        if @w_filas = 0 
                        begin
                                select @w_mensaje       = 'Usuario NO AUTORIZADO para la oficina [' + 
				                           @w_nom_oficina + 
							   '].' + 
							   char(10) + 'Solicite AUTORIZACION.'
                        end
                        else
			begin
                                select @w_mensaje       = 'Usuario NO VIGENTE [' + 
				                          @w_nom_oficina + 
							  '].' + 
							  char(10) + 'Solicite que le activen su usuario.'
                        end

                        RAISERROR (900000, 16, 1, @w_mensaje)
                        return 1
                end

 
           select @w_fecha_suma = dateadd(day, @w_dvpw, @w_fecha_ult_mod) 
 
           if ((@w_fecha_suma < getdate()) OR (@w_fecha_suma IS NULL)) 
           begin 
                if @i_campwd = 1
                  begin
                        select @o_campwd = 1
                        select 'Usuario tiene password caducado, debe cambiarlo ahora'
                  end
                else
                  begin
                        RAISERROR (900000, 16, 1, N'Usuario tiene password caducado')
                        return 1
                  end
           end
           select @w_dias = datediff(day, getdate(), @w_fecha_suma) 
 
           select @w_terminal = lo_terminal, 
                  @w_servidor = lo_server 
           from   cobis..in_login 
         where  lo_login = @i_login 
           and    lo_fecha_out is NULL 
           
           if (@w_terminal is not null) 
           begin 
                if ((@w_terminal != @i_terminal) OR (@w_servidor != @i_server)) 
                begin 
                        select @w_mensaje = 'Usuario: '''+@i_login+''' fue registrado anteriormente en '+@w_servidor+'.'+@w_terminal 
                        RAISERROR (900000, 16, 1, @w_mensaje)
                        return 1 
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
 
           update cobis.dbo.cl_funcionario
           set fu_fec_inicio=getdate() 
           where fu_login=@i_login

           if (@@rowcount != 1)
           begin
                RAISERROR (900000, 16, 1, N'Usuario no puede registrarse por error en la cl_funcionario')
                return 1
           end

           insert into cobis..in_login  
           (lo_login, lo_terminal,lo_server, lo_sesion, lo_mail, lo_fecha_in) 
           values 
           (@i_login, @i_terminal, @i_server, @s_sesn, 'N', getdate()) 
 
           if (@@rowcount != 1) 
           begin 
                RAISERROR (900000, 16, 1, N'Usuario no puede registrarse por error en in_login')
                return 1 
           end 

           if (@w_dias < @w_avpw) 
           begin 
                select 'AVISO: su password expira el ' + 
                        convert(char(20), @w_fecha_suma, 111) 
           end 
 
           /* Para que el kernel no le ponga al usuario reentry los parametros @s_ */           
 
           if @i_login <> 'reentry'
 
           begin 
             RAISERROR (144441, 16, 1, N'l')
             select     i_server        = @i_server, 
                i_login         = @i_login, 
                i_terminal      = @i_terminal, 
                i_office        = @i_office, 
                i_role          = @i_role
 
           end
 
 
           if (@w_fecha_in is NULL) 
                select 'Usted debe modificar ahora su clave de ingreso' + 
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
 
           /* Para que el kernel no le ponga al usuario reentry los parametros @s_ */
 
           if @i_login <> 'reentry'
 
           begin 
                RAISERROR (144441, 16, 1, N'l')
                select  i_server        = @i_server, 
                        i_login         = @i_login, 
                        i_terminal      = @i_terminal, 
                        i_office        = @i_office, 
                        i_role          = @i_role 
                select respuesta = 'Bienvenido a COBIS'
 
           end 
        end 
        return 0 
               
go 
 

