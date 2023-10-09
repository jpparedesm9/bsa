/************************************************************************/
/*   Archivo:            sp_consconex.sp                                */
/*   Stored procedure:   sp_consconex                                   */
/*   Base de datos:      cobis                                          */
/*   Producto:           Admin                                          */
/*   Disenado por:       Juan Tagle                                     */
/*   Fecha de escritura: 06/Abr/2015                                    */
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
/*   FECHA      AUTOR      RAZON                                        */
/*   06/Abr/2015 J.Tagle      Emision Inicial                           */
/*   21-04-2016  BBO          Migracion SYB-SQL FAL                     */
/************************************************************************/

use cobis
go

SET ANSI_NULLS OFF
go

if exists (select * from sysobjects where name = 'sp_consconex')
    drop  proc sp_consconex
go

create proc sp_consconex (
   @s_ssn            int       = NULL,
   @s_user            login       = NULL,
   @s_sesn            int       = NULL,
   @s_term            varchar(32) = NULL,
   @s_date            datetime    = NULL,
   @s_srv            varchar(30) = NULL,
   @s_lsrv            varchar(30) = NULL, 
   @s_rol            smallint    = NULL,
   @s_ofi            smallint    = NULL,
   @s_org_err         char(1)    = NULL,
   @s_error         int       = NULL,
   @s_sev            tinyint    = NULL,
   @s_msg            descripcion = NULL,
   @s_org            char(1)      = NULL,
   @t_show_version     bit         = 0,
   @t_debug         char(1)    = 'N',
   @t_file            varchar(14) = null,
   @t_from            varchar(32) = null,
   @t_trn            smallint    = NULL,
   @i_operacion       char(1) = null,
   @i_modo           int = null,
   @i_login         varchar(30) = NULL,
   @i_fecha_desde      datetime = null,
   @i_fecha_hasta      datetime = null,
   @i_siguiente       datetime = null
)
as
declare @w_sp_name varchar(32),
        @w_compo integer,
      @w_rep integer,
      @w_nivel integer,
      @w_prodname varchar(10)

if @t_show_version = 1
begin
    print 'Stored procedure sp_consconex, Version 4.0.0.0'
    return 0
end

select @w_sp_name = 'sp_consconex'

if @t_trn = 15404
begin
   -----------
   -- CONSULTA      
   -----------
   if @i_operacion = 'S'
   begin
   
      set rowcount 20

      select 
         '500706'   = a.lo_login,                       
         '500707'   = a.lo_terminal,                    
         '500708'   =  fu_oficina,
         '500709'   = e.of_nombre,  -- fu_oficina
         '500710'   = b.fu_funcionario,  
         '500711'   = b.fu_nombre,  
         '500712'   = c.valor,  -- fu_cargo
         '500713'    = a.lo_fecha_in,                 
         '500714'   = a.lo_fecha_out,
         '500715'   = a.lo_server,
         '500716'   = a.lo_sesion
         
      from in_login a
      
      inner join cl_funcionario b
      on b.fu_login = a.lo_login
      
      LEFT join cobis..cl_tabla d ON d.tabla = 'cl_cargo' 
      LEFT join cobis..cl_catalogo c ON convert(varchar(10) , b.fu_cargo ) = c.codigo and d.codigo=c.tabla
      LEFT join cl_oficina e on e.of_oficina = fu_oficina
      
      where (
            a.lo_login = @i_login
            or
            a.lo_login = isnull(@i_login,a.lo_login)
           )
                      
      and a.lo_fecha_in >= @i_fecha_desde
      and a.lo_fecha_in <=@i_fecha_hasta
      and (a.lo_fecha_in > @i_siguiente or @i_siguiente is null) 
      
      order by a.lo_fecha_in

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
