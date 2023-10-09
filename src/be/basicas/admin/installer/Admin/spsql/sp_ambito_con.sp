/************************************************************************/
/*  Archivo:            sp_ambito_con.sp                                */
/*  Stored procedure:   sp_ambito_con                                   */
/*  Base de datos:      cobis                                           */
/*  Producto:           Admin                                           */
/************************************************************************/
/*                        IMPORTANTE                                    */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "COBISCORP", representantes exclusivos para el Ecuador de la        */
/*  "NCR CORPORATION".                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de COBISCORP o su representante.              */
/************************************************************************/
/*                         PROPOSITO                                    */
/*  Este procedimiento almacenado invoca a la generacion de registros   */
/*  de registros temporales de ambito y permite consultar los mismos    */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR                    RAZON                          */
/* 12/May/2015  Omar Garcia              Emision inicial                */
/* 30/Jun/2015  Omar Garcia              Adición de la subregional      */
/************************************************************************/
use cobis  
go

if exists (select * from sysobjects where name = 'sp_ambito_con')
   drop proc sp_ambito_con
go

create proc sp_ambito_con(
   @s_ssn              int         = null,
   @s_user             login       = null,
   @s_term             varchar(32) = null,
   @s_date             datetime    = null,
   @s_srv              varchar(30) = null,
   @s_lsrv             varchar(30) = null,
   @s_ofi              smallint    = null,
   @s_rol              smallint    = NULL,
   @s_org_err          char(1)     = NULL,
   @s_error            int         = NULL,
   @s_sev              tinyint     = NULL,
   @s_msg              descripcion = NULL,
   @s_org              char(1)     = NULL,
   @t_debug            char(1)     = 'N',
   @t_file             varchar(10) = null,
   @t_from             varchar(32) = null,
   @t_trn              smallint    = null,
   @t_show_version     bit         = 0,
   @i_modo             int         = null,
   @i_filial          tinyint    = null,
   @i_siguiente        int         = 0,
   @i_regional         char(10)    = null,
   @i_subregional      char(10)    = null,
   @i_usuario          login       = null,
   @i_ssn              int         = null,
   @i_usuario_sig      login       = null,
   @i_oficina_sig      smallint    = 0,
   @i_operacion        char(1)     = null,
   @i_oficina          smallint    = null
   
)
as
declare @w_today      datetime,
  @w_sp_name          varchar(32),
  @w_return           int,
  @w_msg              varchar(100),  
  @w_oficina          smallint,
  @w_estado           char(1),
  @w_cargo            char(10),
  @w_ambito           char(10),
  @w_regional         char(10),
  @w_subregional      char(10),
  @w_secuencial       int,
  @w_usuario          login

select @w_today = @s_date
select @w_sp_name = 'sp_ambito_con'

--VERSIONAMIENTO DEL PROGRAMA
if @t_show_version = 1
begin
    print 'Stored procedure sp_ambito_con, Version 4.0.0.0'
    return 0
end

if @t_trn = 15413
   begin
      --TODOS
      if @i_operacion = 'T'
         begin
            if @i_modo = 0
               begin
                  set rowcount 20
                  select
                     'Cod Trabajador' = fu_funcionario,
                     'Login'          = f.fu_login,
                     'Nombre'         = f.fu_nombre,
                     'Cargo'          = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c
                                       where t.codigo = c.tabla
                                       and t.tabla = 'cl_cargo'
                                       and c. codigo = convert(varchar(10) , f.fu_cargo )),
                     'Cod. Oficina'   = u.us_oficina,
                     'Nombre Oficina' = (select o.of_nombre from cobis..cl_oficina o
                                       where of_oficina = u.us_oficina ),
                     'Regional' = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c, cl_oficina o
                                 where t.codigo = c.tabla
                                 and t.tabla = 'cl_regional'
                                 and c. codigo = convert(varchar(10) , o.of_regional )
                                 and of_oficina = u.us_oficina),
                     'Sub-Regional' = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c, cl_oficina o
                                 where t.codigo = c.tabla
                                 and t.tabla = 'cl_subregional'
                                 and c. codigo = convert(varchar(10) , o.of_subregional )
                                 and of_oficina = u.us_oficina)
                  from ad_usuario u, cl_funcionario f, cl_oficina o
                  where fu_login = us_login
                  and us_oficina = of_oficina
                  and us_filial = @i_filial
                  and us_estado = "V"
                  order by us_login, us_oficina

                  if @@rowcount = 0
                     begin
                        exec sp_cerror
                        @t_debug      = @t_debug,
                        @t_file       = @t_file,
                        @t_from       = @w_sp_name,
                        @i_num        = 151172
                        --NO EXISTEN REGISTROS
                        return 1
                     end
               end
            else if @i_modo = 1
               begin
                  set rowcount 20
                  select
                     'Cod Trabajador' = fu_funcionario,
                     'Login'          = f.fu_login,
                     'Nombre'         = f.fu_nombre,
                     'Cargo'          = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c
                                       where t.codigo = c.tabla
                                       and t.tabla = 'cl_cargo'
                                       and c. codigo = convert(varchar(10) , f.fu_cargo )),
                     'Cod. Oficina'   = u.us_oficina,
                     'Nombre Oficina' = (select o.of_nombre from cobis..cl_oficina o
                                       where of_oficina = u.us_oficina ),
                     'Regional' = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c, cl_oficina o
                                 where t.codigo = c.tabla
                                 and t.tabla = 'cl_regional'
                                 and c. codigo = convert(varchar(10) , o.of_regional )
                                 and of_oficina = u.us_oficina),
                     'Sub-Regional' = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c, cl_oficina o
                                 where t.codigo = c.tabla
                                 and t.tabla = 'cl_subregional'
                                 and c. codigo = convert(varchar(10) , o.of_subregional )
                                 and of_oficina = u.us_oficina)
                  from ad_usuario u, cl_funcionario f, cl_oficina o
                  where fu_login = us_login
                  and us_oficina = of_oficina
                  and us_filial = @i_filial
                  and us_estado = "V"
                  and ((us_login > @i_usuario_sig)
                        or 
                      (us_login = @i_usuario_sig and us_oficina > @i_oficina_sig))
                  order by us_login, us_oficina

                  if @@rowcount = 0
                     begin
                        exec sp_cerror
                        @t_debug      = @t_debug,
                        @t_file       = @t_file,
                        @t_from       = @w_sp_name,
                        @i_num        = 151172
                        --NO EXISTEN REGISTROS
                        return 1
                     end
               end
         end   
      --REGIONAL
      else if @i_operacion = 'R'
         begin
            if @i_modo = 0
               begin
                  set rowcount 20
                  select
                     'Cod Trabajador' = fu_funcionario,
                     'Login'          = f.fu_login,
                     'Nombre'         = f.fu_nombre,
                     'Cargo'          = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c
                                       where t.codigo = c.tabla
                                       and t.tabla = 'cl_cargo'
                                       and c. codigo = convert(varchar(10) , f.fu_cargo )),
                     'Cod. Oficina'   = u.us_oficina,
                     'Nombre Oficina' = (select o.of_nombre from cobis..cl_oficina o
                                       where of_oficina = u.us_oficina ),
                     'Regional' = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c, cl_oficina o
                                 where t.codigo = c.tabla
                                 and t.tabla = 'cl_regional'
                                 and c. codigo = convert(varchar(10) , o.of_regional )
                                 and of_oficina = u.us_oficina),
                     'Sub-Regional' = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c, cl_oficina o
                                 where t.codigo = c.tabla
                                 and t.tabla = 'cl_subregional'
                                 and c. codigo = convert(varchar(10) , o.of_subregional )
                                 and of_oficina = u.us_oficina)
                  from ad_usuario u, cl_funcionario f, cl_oficina o
                  where fu_login = us_login
                  and us_oficina = of_oficina
                  and us_filial = @i_filial
                  and us_estado = "V"
                  and of_regional = @i_regional
                  order by us_login, us_oficina

                  if @@rowcount = 0
                     begin
                        exec sp_cerror
                        @t_debug      = @t_debug,
                        @t_file       = @t_file,
                        @t_from       = @w_sp_name,
                        @i_num        = 151172
                        --NO EXISTEN REGISTROS
                        return 1
                     end
               end
            else if @i_modo = 1
               begin
                  set rowcount 20
                  select
                     'Cod Trabajador' = fu_funcionario,
                     'Login'          = f.fu_login,
                     'Nombre'         = f.fu_nombre,
                     'Cargo'          = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c
                                       where t.codigo = c.tabla
                                       and t.tabla = 'cl_cargo'
                                       and c. codigo = convert(varchar(10) , f.fu_cargo )),
                     'Cod. Oficina'   = u.us_oficina,
                     'Nombre Oficina' = (select o.of_nombre from cobis..cl_oficina o
                                       where of_oficina = u.us_oficina ),
                     'Regional' = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c, cl_oficina o
                                 where t.codigo = c.tabla
                                 and t.tabla = 'cl_regional'
                                 and c. codigo = convert(varchar(10) , o.of_regional )
                                 and of_oficina = u.us_oficina),
                     'Sub-Regional' = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c, cl_oficina o
                                 where t.codigo = c.tabla
                                 and t.tabla = 'cl_subregional'
                                 and c. codigo = convert(varchar(10) , o.of_subregional )
                                 and of_oficina = u.us_oficina)
                  from ad_usuario u, cl_funcionario f, cl_oficina o
                  where fu_login = us_login
                  and us_oficina = of_oficina
                  and us_filial = @i_filial
                  and us_estado = "V"
                  and of_regional = @i_regional
                  and ((us_login > @i_usuario_sig)
                        or 
                      (us_login = @i_usuario_sig and us_oficina > @i_oficina_sig))
                  order by us_login, us_oficina

                  if @@rowcount = 0
                     begin
                        exec sp_cerror
                        @t_debug      = @t_debug,
                        @t_file       = @t_file,
                        @t_from       = @w_sp_name,
                        @i_num        = 151172
                        --NO EXISTEN REGISTROS
                        return 1
                     end

               end
         end

      --SUB-REGIONAL
      else if @i_operacion = 'S'
         begin
            if @i_modo = 0
               begin
                  set rowcount 20
                  select
                     'Cod Trabajador' = fu_funcionario,
                     'Login'          = f.fu_login,
                     'Nombre'         = f.fu_nombre,
                     'Cargo'          = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c
                                       where t.codigo = c.tabla
                                       and t.tabla = 'cl_cargo'
                                       and c. codigo = convert(varchar(10) , f.fu_cargo )),
                     'Cod. Oficina'   = u.us_oficina,
                     'Nombre Oficina' = (select o.of_nombre from cobis..cl_oficina o
                                       where of_oficina = u.us_oficina ),
                     'Regional' = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c, cl_oficina o
                                 where t.codigo = c.tabla
                                 and t.tabla = 'cl_regional'
                                 and c. codigo = convert(varchar(10) , o.of_regional )
                                 and of_oficina = u.us_oficina),
                     'Sub-Regional' = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c, cl_oficina o
                                 where t.codigo = c.tabla
                                 and t.tabla = 'cl_subregional'
                                 and c. codigo = convert(varchar(10) , o.of_subregional )
                                 and of_oficina = u.us_oficina)
                  from ad_usuario u, cl_funcionario f, cl_oficina o
                  where fu_login = us_login
                  and us_oficina = of_oficina
                  and us_filial = @i_filial
                  and us_estado = "V"
                  and of_subregional = @i_subregional
                  order by us_login, us_oficina

                  if @@rowcount = 0
                     begin
                        exec sp_cerror
                        @t_debug      = @t_debug,
                        @t_file       = @t_file,
                        @t_from       = @w_sp_name,
                        @i_num        = 151172
                        --NO EXISTEN REGISTROS
                        return 1
                     end
               end
            else if @i_modo = 1
               begin
                  set rowcount 20
                  select
                     'Cod Trabajador' = fu_funcionario,
                     'Login'          = f.fu_login,
                     'Nombre'         = f.fu_nombre,
                     'Cargo'          = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c
                                       where t.codigo = c.tabla
                                       and t.tabla = 'cl_cargo'
                                       and c. codigo = convert(varchar(10) , f.fu_cargo )),
                     'Cod. Oficina'   = u.us_oficina,
                     'Nombre Oficina' = (select o.of_nombre from cobis..cl_oficina o
                                       where of_oficina = u.us_oficina ),
                     'Regional' = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c, cl_oficina o
                                 where t.codigo = c.tabla
                                 and t.tabla = 'cl_regional'
                                 and c. codigo = convert(varchar(10) , o.of_regional )
                                 and of_oficina = u.us_oficina),
                     'Sub-Regional' = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c, cl_oficina o
                                 where t.codigo = c.tabla
                                 and t.tabla = 'cl_subregional'
                                 and c. codigo = convert(varchar(10) , o.of_subregional )
                                 and of_oficina = u.us_oficina)
                  from ad_usuario u, cl_funcionario f, cl_oficina o
                  where fu_login = us_login
                  and us_oficina = of_oficina
                  and us_filial = @i_filial
                  and us_estado = "V"
                  and of_subregional = @i_subregional
                  and ((us_login > @i_usuario_sig)
                        or 
                      (us_login = @i_usuario_sig and us_oficina > @i_oficina_sig))
                  order by us_login, us_oficina

                  if @@rowcount = 0
                     begin
                        exec sp_cerror
                        @t_debug      = @t_debug,
                        @t_file       = @t_file,
                        @t_from       = @w_sp_name,
                        @i_num        = 151172
                        --NO EXISTEN REGISTROS
                        return 1
                     end

               end
         end

      --OFICINA
      else if @i_operacion = 'O'
         begin
            if @i_modo = 0
               begin
                  set rowcount 20
                  select
                     'Cod Trabajador' = fu_funcionario,
                     'Login'          = f.fu_login,
                     'Nombre'         = f.fu_nombre,
                     'Cargo'          = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c
                                       where t.codigo = c.tabla
                                       and t.tabla = 'cl_cargo'
                                       and c. codigo = convert(varchar(10) , f.fu_cargo )),
                     'Cod. Oficina'   = u.us_oficina,
                     'Nombre Oficina' = (select o.of_nombre from cobis..cl_oficina o
                                       where of_oficina = u.us_oficina ),
                     'Regional' = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c, cl_oficina o
                                 where t.codigo = c.tabla
                                 and t.tabla = 'cl_regional'
                                 and c. codigo = convert(varchar(10) , o.of_regional )
                                 and of_oficina = u.us_oficina)
                  from ad_usuario u, cl_funcionario f, cl_oficina o
                  where fu_login = us_login
                  and us_oficina = of_oficina
                  and us_filial = @i_filial
                  and us_estado = "V"
                  and of_oficina = @i_oficina
                  order by us_login, us_oficina

                  if @@rowcount = 0
                     begin
                        exec sp_cerror
                        @t_debug      = @t_debug,
                        @t_file       = @t_file,
                        @t_from       = @w_sp_name,
                        @i_num        = 151172
                        --NO EXISTEN REGISTROS
                        return 1
                     end
               end
            else if @i_modo = 1
               begin
                  set rowcount 20
                  select
                     'Cod Trabajador' = fu_funcionario,
                     'Login'          = f.fu_login,
                     'Nombre'         = f.fu_nombre,
                     'Cargo'          = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c
                                       where t.codigo = c.tabla
                                       and t.tabla = 'cl_cargo'
                                       and c. codigo = convert(varchar(10) , f.fu_cargo )),
                     'Cod. Oficina'   = u.us_oficina,
                     'Nombre Oficina' = (select o.of_nombre from cobis..cl_oficina o
                                       where of_oficina = u.us_oficina ),
                     'Regional' = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c, cl_oficina o
                                 where t.codigo = c.tabla
                                 and t.tabla = 'cl_regional'
                                 and c. codigo = convert(varchar(10) , o.of_regional )
                                 and of_oficina = u.us_oficina)
                  from ad_usuario u, cl_funcionario f, cl_oficina o
                  where fu_login = us_login
                  and us_oficina = of_oficina
                  and us_filial = @i_filial
                  and us_estado = "V"
                  and of_oficina = @i_oficina
                  and ((us_login > @i_usuario_sig)
                        or 
                      (us_login = @i_usuario_sig and us_oficina > @i_oficina_sig))

                  order by us_login, us_oficina

                  if @@rowcount = 0
                     begin
                        exec sp_cerror
                        @t_debug      = @t_debug,
                        @t_file       = @t_file,
                        @t_from       = @w_sp_name,
                        @i_num        = 151172
                        --NO EXISTEN REGISTROS
                        return 1
                     end

               end
         end
         
      --OFICINA
      else if @i_operacion = 'Q'
         begin
            select  'Cod. Rol' = ur_rol,
               'Descripcion de Rol' =  substring(ro_descripcion, 1, 20)
            from   ad_usuario_rol, ad_rol
            where   ur_rol = ro_rol
            and   ur_login = @i_usuario
            and   ur_estado = 'V'
            order   by ur_login, ur_rol

            if @@rowcount = 0
               begin
                  exec sp_cerror
                  @t_debug      = @t_debug,
                  @t_file       = @t_file,
                  @t_from       = @w_sp_name,
                  @i_num        = 151172
                  --NO EXISTEN REGISTROS
                  return 1
               end
         end

   end
else
   begin
      exec sp_cerror
         @t_debug      = @t_debug,
         @t_file       = @t_file,
         @t_from       = @w_sp_name,
         @i_num        = 151051
         --NO CORRESPONDE CODIGO DE TRANSACCION
      return 1
   end


return 0
go

