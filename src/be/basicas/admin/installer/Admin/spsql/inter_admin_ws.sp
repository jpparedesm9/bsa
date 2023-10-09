/************************************************************************/
/*      Archivo:                inter_admin_ws.sp                       */
/*      Stored procedure:       sp_inter_admin_ws                       */
/*      Base de datos:          cobis                                   */
/*      Producto: Administracion                                        */
/*      Disenado por:           Jorge Salazar                           */
/*      Fecha de escritura: 	30-Ago-2012                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                                                                      */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de:                     */
/*      Interfaces con otros sistemas externos a COBIS                  */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      17/07/2012   J. Salazar      Emision Inicial                    */
/*      26/11/2012   G.Balon         Control de Errores                 */ 
/*      21/04/2016   BBO             Migracion syb-sql FAL              */
/************************************************************************/

use cobis
go

SET ANSI_NULLS OFF
go

if exists (select * from sysobjects where name = 'sp_inter_admin_ws')
   drop proc sp_inter_admin_ws
go

create proc sp_inter_admin_ws 
(
	@s_ssn                  int = NULL,
	@s_user                 login = NULL,
	@s_sesn                 int = NULL,
	@s_term                 varchar(32) = NULL,
	@s_date                 datetime = NULL,
	@s_srv                  varchar(30) = NULL,
	@s_lsrv                 varchar(30) = NULL, 
	@s_rol                  smallint = NULL,
	@s_ofi                  smallint = NULL,
	@s_org_err              char(1) = NULL,
	@s_error                int = NULL,
	@s_sev                  tinyint = NULL,
	@s_msg                  descripcion = NULL,
	@s_org                  char(1) = NULL,
	@t_debug                char(1) = 'N',
	@t_file                 varchar(14) = null,
	@t_from                 varchar(32) = null,
	@t_trn                  smallint,
	@t_show_version         bit  = 0,

	@i_operacion            varchar(1) = 'S',
	@i_modo                 smallint,
	@i_nombre               varchar(64) = null,
	@i_oficina              smallint = null,
	@i_login                varchar(14) = null,
	@i_idcanal              varchar(20) = null,
	@i_provincia            smallint = null,
	@i_codigo               smallint = null,
	@i_tabla                char(30) = null,
	@i_descripcion          varchar(64) = null,
	@i_nombre_ofi           varchar(255) = null,
	@i_tipo                 int = null
)
as
declare
	@w_sp_name              varchar(32)
	
select @w_sp_name = 'sp_inter_admin_ws'
------------------------------------------
---VERSIONAMIENTO PROGRAMA-----------------
-------------------------------------------
if @t_show_version = 1 
begin
   print 'Stored procedure sp_inter_admin_ws, version 4.0.0.3'
   return 0
end

--Control Numero Transaccion
if @t_trn <> 15403 and @i_operacion = 'S'
begin
   /* 'Tipo de transaccion no corresponde' */
   exec cobis..sp_cerror
   @t_debug  = @t_debug,
   @t_file	 = @t_file,
   @t_from	 = @w_sp_name,
   @i_num	 = 151042
   return 1
end

if @i_operacion = 'S'
begin
   if @i_modo = 1
   begin
      select  'Canal'          = @i_idcanal,
              'Cod. Provincia' = pv_provincia,
              'Provincia'      = pv_descripcion
      from cl_provincia
      where pv_estado  = 'V' 
      order by pv_provincia

      if @@rowcount = 0
      begin
         /* 'No existen registros' */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001
         return 1
      end 

   end
   
   if @i_modo = 2
   begin
      select 'Canal'           = @i_idcanal,
             'Cod. Sucursal'   = of_oficina,
             'Nombre Sucursal' = of_nombre
      from cl_oficina, cl_ciudad, cl_provincia
      where ci_ciudad = of_ciudad
        and ci_provincia = pv_provincia
        and of_filial = 1
        and pv_provincia = @i_provincia
        and ci_estado = 'V'
        and pv_estado = 'V'
      order by of_oficina

      if @@rowcount = 0
      begin
         /* 'No existen registros' */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001
         return 1
      end 

   end
   
   if @i_modo = 3
   begin
      select 'Codigo' = b.codigo,
             'Valor'  = b.valor,
             'Estado' = b.estado
      from cl_tabla a, cl_catalogo b
      where a.codigo = b.tabla
       and (a.codigo = @i_codigo or @i_codigo is null)
       and (a.tabla = @i_tabla or @i_tabla is null)
       and (a.descripcion like @i_descripcion + '%' or @i_descripcion is null)
      order by b.codigo

      if @@rowcount = 0
      begin
         /* 'No existen registros' */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001
         return 1
      end 
   end
   
   if @i_modo = 4
   begin
      select 'Codigo Oficial' = oc_oficial,
             'Oficial'        = fu_login,
             'Nombre Oficial' = fu_nombre
      from cc_oficial, cl_funcionario
      where oc_funcionario = fu_funcionario
      and (fu_oficina = @i_oficina or @i_oficina is null)
      and (fu_login = @i_login or @i_login is null)
      and (fu_nombre like @i_nombre + '%' or @i_nombre is null)
	  and fu_estado = 'V'
      order by fu_login

      if @@rowcount = 0
      begin
         /* 'No existen registros' */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001
         return 1
      end 
   end

   if @i_modo = 5
   begin
      if @i_tipo = 1
	  begin
	     select 'Tipo'            = @i_tipo,
                'Nombre Oficial'  = fu_nombre,
                'Login Oficial'   = fu_login,
                'Codigo Oficial'  = oc_oficial,
                'Codigo Sucursal' = fu_oficina,
                'Nombre Sucursal' = of_nombre
             from cc_oficial, cl_funcionario, cl_oficina
             where oc_funcionario = fu_funcionario
             and fu_oficina = of_oficina
             and (fu_oficina = @i_oficina or @i_oficina is null)
             and (of_nombre like '%' + @i_nombre_ofi + '%' or @i_nombre_ofi is null)
             and fu_estado = 'V'
             order by fu_login

             if @@rowcount = 0
             begin
             /* 'No existen registros' */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 101001
                return 1
             end 
	  end
	  
	  if @i_tipo = 2
	  begin
	     select 'Tipo'            = @i_tipo,
                'Nombre Completo' = fu_nombre,
                'Login'           = fu_login,
                'Codigo'          = oc_oficial,
                'Codigo Sucursal' = fu_oficina,
                'Nombre Sucursal' = of_nombre
             from cc_oficial, cl_funcionario, cl_oficina
             where oc_funcionario = fu_funcionario
             and fu_oficina = of_oficina
             and (fu_oficina = @i_oficina or @i_oficina is null)
             and (fu_nombre like '%' + @i_nombre_ofi + '%' or @i_nombre_ofi is null)
             and fu_estado = 'V'
             order by fu_login

             if @@rowcount = 0
             begin
             /* 'No existen registros' */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 101001
                return 1
             end 
	  end
   end   
end

return 0

go

