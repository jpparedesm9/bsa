
/************************************************************************/
/*	 Archivo:            qr2_usu.sp                                     */
/*   Stored procedure:   sp_qr_usuario                                  */
/*   Base de datos:      cobis                                          */
/*   Producto:           Administracion                                 */
/*   Disenado por:       Mauricio Bayas/Sandra Ortiz                    */
/*   Fecha de escritura: 7-Dic-1992                                     */
/************************************************************************/
/*            IMPORTANTE                                                */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "MACOSA", representantes exclusivos para el Ecuador de la          */
/*   "NCR CORPORATION".                                                 */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*            MODIFICACIONES                                            */
/*   FECHA      AUTOR             RAZON                                 */
/*   30/May/94   F.Espinosa       Parametros tipo "S"                   */
/*                                Transacciones de Servicio             */
/*   29/May/12   E. Moran         Se modifica mandatoriedad de          */
/*                                parametros @i_oficina y @i_nodo para  */
/*                                que soporten valores de entrada nulos */
/*  21-04-2016   BBO              Migracion SYB-SQL FAL                 */
/************************************************************************/


use cobis
go

SET ANSI_NULLS OFF
go

if exists (select * from sysobjects where name = 'sp_qr_usuario')
	drop proc sp_qr_usuario
go

create proc sp_qr_usuario (
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(32) = NULL,
	@s_date			datetime = NULL,
	@s_srv			varchar(30) = NULL,
	@s_lsrv			varchar(30) = NULL, 
	@s_rol			smallint = NULL,
	@s_ofi			smallint = NULL,
	@s_org_err		char(1) = NULL,
	@s_error		int = NULL,
	@s_sev			tinyint = NULL,
	@s_msg			descripcion = NULL,
	@s_org			char(1) = NULL,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(32) = null,
	@t_trn			smallint =NULL,
        @i_modo                 smallint,
        @i_filial               tinyint,
   @i_oficina      smallint    = null, -- EMO 20120529
   @i_nodo         smallint    = null, -- EMO 20120529
        @i_login                varchar(12) = null,
   @t_show_version        bit = 0 -- Mostrar la versión del programa
)
as
declare
	@w_today		datetime,
	@w_sp_name		varchar(32)

if @t_show_version = 1
begin
    print 'Stored procedure cobis..sp_qr_usuario, Version 4.0.0.1'
    return 0
end
	
select @w_today = @s_date
select @w_sp_name = 'sp_qr_usuario'


if @t_trn = 15094
begin

if @i_modo = 0
begin
        set rowcount 20
        select  'Funcionario' = fu_funcionario,
                'Nombre' = substring(fu_nombre, 1, 40),
                'Login' = us_login,
                'Estado' = fu_estado -- EMO 20120528 
         from   ad_usuario, cl_funcionario
        where   us_login = fu_login
          and   us_filial = @i_filial
          --and   us_oficina = @i_oficina -- EMO 20120529 
          --and   us_nodo    = @i_nodo -- EMO 20120529 
          and   (us_oficina = @i_oficina or @i_oficina is null) -- EMO 20120529 
          and   (us_nodo = @i_nodo or @i_nodo is null)          -- EMO 20120529 
          and   us_estado = 'V'
        order by us_filial, us_oficina, us_nodo, us_login
        set rowcount 0
return 0
end

if @i_modo = 1
begin
        set rowcount 20
        select  'Funcionario' = fu_funcionario,
                'Nombre' = substring(fu_nombre, 1, 40),
                'Login' = us_login,
                'Estado' = fu_estado -- EMO 20120528 
         from   ad_usuario, cl_funcionario
        where   us_login = fu_login
          and   us_filial = @i_filial
          --and   us_oficina = @i_oficina -- EMO 20120529 
          --and   us_nodo    = @i_nodo -- EMO 20120529 
          and   (us_oficina = @i_oficina or @i_oficina is null) -- EMO 20120529 
          and   (us_nodo = @i_nodo or @i_nodo is null)          -- EMO 20120529 
          and   us_login > @i_login
          and   us_estado = 'V'
        order by us_filial, us_oficina, us_nodo, us_login
        set rowcount 0
return 0
end
else
begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
	   /*  'No corresponde codigo de transaccion' */
	return 1
end
end
go
