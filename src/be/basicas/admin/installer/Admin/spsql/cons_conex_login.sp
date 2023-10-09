/************************************************************************/
/*   Archivo:            cons_conex_login.sp                            */
/*   Stored procedure:   sp_cons_conex_login                            */
/*   Base de datos:      cobis                                          */
/*   Producto:           Admin                                          */
/*   Disenado por:       Jefferson Mateo                                */
/*   Fecha de escritura: 13/Oct/2015                                    */
/************************************************************************/
/*                        IMPORTANTE                                    */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    'Cobiscorp'.                                                      */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de Cobiscorp o su representante.            */
/************************************************************************/
/*                           PROPOSITO                                  */
/*   Este programa consulta conexiones de la tabla in_login             */
/*                        MODIFICACIONES                                */
/************************************************************************/
/*   FECHA      	AUTOR      			 RAZON                          */
/*   13/Oct/2015 	Jefferson Mateo      Emision Inicial                */
/*   11-04-2016     BBO                  Migracion Sybase-Sqlserver FAL */
/************************************************************************/

use cobis
go

SET ANSI_NULLS OFF
go

if exists (select * from sysobjects where name = 'sp_cons_conex_login')
    drop  proc sp_cons_conex_login
go

create proc sp_cons_conex_login (
   @s_ssn             int         = NULL,
   @s_user            login       = NULL,
   @s_sesn            int         = NULL,
   @s_term            varchar(32) = NULL,
   @s_date            datetime    = NULL,
   @s_srv             varchar(30) = NULL,
   @s_lsrv            varchar(30) = NULL, 
   @s_rol             smallint    = NULL,
   @s_ofi             smallint    = NULL,
   @s_org_err         char(1)     = NULL,
   @s_error           int         = NULL,
   @s_sev             tinyint     = NULL,
   @s_msg             descripcion = NULL,
   @s_org             char(1)     = NULL,
   @t_show_version    bit         = 0,
   @t_debug           char(1)     = 'N',
   @t_file            varchar(14) = null,
   @t_from            varchar(32) = null,
   @t_trn             smallint    = NULL,
   @i_operacion       char(1)     = null,
   @i_modo            int         = null,
   @i_login           varchar(30) = NULL,
   @i_autenticacion   varchar(30) = NULL,
   @i_fecha_desde     datetime    = null,
   @i_fecha_hasta     datetime    = null,
   @i_siguiente       int         = null,
   @i_formato_fecha   int         = 103
)
as
declare @w_sp_name varchar(32),
        @w_compo integer,
      @w_rep integer,
      @w_nivel integer,
      @w_prodname varchar(10)

if @t_show_version = 1
begin
    print 'Stored procedure sp_cons_conex_login, Version 4.0.0.0'
    return 0
end

select @w_sp_name = 'sp_cons_conex_login'

if @t_trn = 15417
begin
   -----------
   -- CONSULTA      
   -----------
   if @i_operacion = 'S'
   begin
   
      set rowcount 20

	  select  '500763'   = usuario, 
			  '500707'	 = terminal, 
			  '500711'   =  f.fu_nombre, 
			  '500712'   =c.valor, 
			  '500766'	 = convert(varchar, fecha,@i_formato_fecha) +' '+convert(varchar, fecha,108), 
			  '500760'   = autenticacion, 
			  '500759'   =(
				       case a.id_estado_usuario
				            when 'V' then ('ACTIVO')
					    when 'B' then ('BLOQUEADO')
					    else ('INACTIVO')
					   end 
				       ),
			  '500715'   =servidor,
			  '500767'	 =secuencia
	           from ts_conexion_login a
          inner join cobis..cl_funcionario f on f.fu_login = a.usuario
	  LEFT join cobis..cl_tabla d ON d.tabla = 'cl_cargo' 
	  LEFT join cobis..cl_catalogo c ON convert(varchar(10) , f.fu_cargo ) = c.codigo and d.codigo=c.tabla	 
          where	a.usuario =isnull(@i_login,a.usuario)    
          and (a.fecha between @i_fecha_desde and @i_fecha_hasta)
          and (a.secuencia > @i_siguiente or @i_siguiente is null) 
           order by a.secuencia

      if @@rowcount = 0
      begin
       exec sp_cerror
         @t_debug      = @t_debug,
         @t_file       = @t_file,
         @t_from       = @w_sp_name,
         @i_num        = 107122

         return 1
      end
      
   end

end 

return 0
go
