/************************************************************************/
/*	Archivo:		funcbusq.sp				*/
/*	Stored procedure:	sp_funcbusq				*/
/*	Base de datos:		cobis					*/
/*	Producto: 		Clientes				*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 26-Ene-1994					*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa las busquedas de funcionarios bajo los	*/
/*	siguientes criterios :						*/
/*	Codigo								*/
/*	Nombre								*/
/*	Login								*/
/*	Cargo								*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	25/Ene/94	F.Espinosa	Emision Inicial			*/
/*	25/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_funcbusq')
   drop proc sp_funcbusq
go

create proc sp_funcbusq (
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(30) = NULL,
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
	@t_trn			smallint = null,
	@i_modo             	tinyint = NULL,
	@i_tipo             	char(1) = NULL,
	@i_funcionario      	smallint = NULL,
	@i_nombre           	descripcion = NULL,
        @i_login            	login = NULL,
	@i_cargo		varchar(30) = NULL,
	@i_valor		varchar(32) = '%',
	@o_num_reg_bloque	tinyint  = null out,
	@o_num_reg_total	int  = null out
)
as
declare
	@w_sp_name	varchar(32)

select @w_sp_name = 'sp_funcbusq'


If @t_trn = 15001
begin
/* Busqueda por Codigo */
if @i_tipo = '1'
begin
   select @o_num_reg_bloque = 20
   set rowcount 20
   if @i_modo = 0
   begin
      select @o_num_reg_total = count(*)
        from   cl_funcionario, cl_catalogo a, cl_tabla m
        where a.codigo = convert(char(10),fu_cargo)
        and    a.tabla  = m.codigo
        and    m.tabla  = 'cl_cargo'
        and    convert(varchar,fu_funcionario) like @i_valor
      select 'Codigo' = fu_funcionario,
	     'Funcionario' = substring(fu_nombre,1, 30),
             'Login' = fu_login,
	     'Cod. Cargo' = fu_cargo,
	     'Cargo' = substring(a.valor, 1, 30),
	     'Nomina' = fu_nomina
      from   cl_funcionario, cl_catalogo a, cl_tabla m
      where a.codigo = convert(char(10),fu_cargo)
      and    a.tabla  = m.codigo
      and    m.tabla  = 'cl_cargo'
      and    convert(varchar,fu_funcionario) like @i_valor
      order  by fu_funcionario
   end
   else
	 select 'Codigo' = fu_funcionario,
		'Funcionario' = substring(fu_nombre, 1, 30),
                'Login' = fu_login,
	        'Cod. Cargo' = fu_cargo,
	        'Cargo' = substring(a.valor, 1, 30),
	        'Nomina' = fu_nomina
         from   cl_funcionario, cl_catalogo a, cl_tabla m
	 where	convert(varchar,fu_funcionario) like @i_valor 
	 and	fu_funcionario > @i_funcionario
         and    a.codigo = convert(char(10),fu_cargo)
         and    a.tabla  = m.codigo
         and    m.tabla  = 'cl_cargo'
	 order  by fu_funcionario
   set rowcount 0
 return 0
end

/* Busqueda por Nombre */
if @i_tipo = '2'
begin
   select @o_num_reg_bloque = 20
   set rowcount 20
   if @i_modo = 0
   begin
      select @o_num_reg_total = count(*)
        from   cl_funcionario, cl_catalogo a, cl_tabla m
        where  a.codigo = convert(char(10),fu_cargo)
        and    a.tabla  = m.codigo
        and    m.tabla  = 'cl_cargo'
        and    substring(fu_nombre,1,30) like @i_valor
      select 'Codigo' = fu_funcionario,
	     'Funcionario' = substring(fu_nombre,1, 30),
             'Login' = fu_login,
	     'Cod. Cargo' = fu_cargo,
	     'Cargo' = substring(a.valor, 1, 30),
	     'Nomina' = fu_nomina
      from   cl_funcionario, cl_catalogo a, cl_tabla m
      where  a.codigo = convert(char(10),fu_cargo)
      and    a.tabla  = m.codigo
      and    m.tabla  = 'cl_cargo'
      and    substring(fu_nombre,1,30) like @i_valor
      order  by fu_nombre
   end
   else
	 select 'Codigo' = fu_funcionario,
		'Funcionario' = substring(fu_nombre, 1, 30),
                'Login' = fu_login,
	        'Cod. Cargo' = fu_cargo,
	        'Cargo' = substring(a.valor, 1, 30),
	        'Nomina' = fu_nomina
         from   cl_funcionario, cl_catalogo a, cl_tabla m
	 where	substring(fu_nombre,1,30) like @i_valor 
	 and	substring(fu_nombre,1,30) > @i_nombre
         and    a.codigo = convert(char(10),fu_cargo)
         and    a.tabla  = m.codigo
         and    m.tabla  = 'cl_cargo'
	 order  by fu_nombre
   set rowcount 0
 return 0
end


/* Busqueda por Login */
if @i_tipo = '3'
begin
   select @o_num_reg_bloque = 20
   set rowcount 20
   if @i_modo = 0
   begin
      select @o_num_reg_total = count(*)
        from   cl_funcionario, cl_catalogo a, cl_tabla m
        where  a.codigo = convert(char(10),fu_cargo)
        and    a.tabla  = m.codigo
        and    m.tabla  = 'cl_cargo'
        and    fu_login like @i_valor
      select 'Codigo' = fu_funcionario,
	     'Funcionario' = substring(fu_nombre,1, 30),
             'Login' = fu_login,
	     'Cod. Cargo' = fu_cargo,
	     'Cargo' = substring(a.valor, 1, 30),
	     'Nomina' = fu_nomina
      from   cl_funcionario, cl_catalogo a, cl_tabla m
      where  a.codigo = convert(char(10),fu_cargo)
      and    a.tabla  = m.codigo
      and    m.tabla  = 'cl_cargo'
      and    fu_login like @i_valor
      order  by fu_login
   end
   else
	 select 'Codigo' = fu_funcionario,
		'Funcionario' = substring(fu_nombre, 1, 30),
                'Login' = fu_login,
	        'Cod. Cargo' = fu_cargo,
	        'Cargo' = substring(a.valor, 1, 30),
	        'Nomina' = fu_nomina
         from   cl_funcionario, cl_catalogo a, cl_tabla m
	 where	fu_login like @i_valor 
	 and	fu_login > @i_login
         and    a.codigo = convert(char(10),fu_cargo)
         and    a.tabla  = m.codigo
         and    m.tabla  = 'cl_cargo'
	 order  by fu_login
   set rowcount 0
 return 0
end


/* Busqueda por Cargo */
if @i_tipo = '4'
begin
   select @o_num_reg_bloque = 20
   set rowcount 20
   if @i_modo = 0
   begin
      select @o_num_reg_total = count(*)
        from   cl_funcionario, cl_catalogo a, cl_tabla m
        where  a.codigo = convert(char(10),fu_cargo)
        and    a.tabla  = m.codigo
        and    m.tabla  = 'cl_cargo'
        and    substring(a.valor, 1, 30) like @i_valor
      select 'Codigo' = fu_funcionario,
	     'Funcionario' = substring(fu_nombre,1, 30),
             'Login' = fu_login,
	     'Cod. Cargo' = fu_cargo,
	     'Cargo' = substring(a.valor, 1, 30),
	     'Nomina' = fu_nomina
      from   cl_funcionario, cl_catalogo a, cl_tabla m
      where  a.codigo = convert(char(10),fu_cargo)
      and    a.tabla  = m.codigo
      and    m.tabla  = 'cl_cargo'
      and    substring(a.valor, 1, 30) like @i_valor
      order  by a.valor
   end
   else
	 select 'Codigo' = fu_funcionario,
		'Funcionario' = substring(fu_nombre, 1, 30),
                'Login' = fu_login,
	        'Cod. Cargo' = fu_cargo,
	        'Cargo' = substring(a.valor, 1, 30),
	        'Nomina' = fu_nomina
         from   cl_funcionario, cl_catalogo a, cl_tabla m
	 where	substring(a.valor, 1, 30) like @i_valor 
	 and	((substring(a.valor, 1, 30) > @i_cargo) 
	   	or (substring(a.valor, 1, 30) = @i_cargo and
		fu_funcionario > @i_funcionario))
         and    a.codigo = convert(char(10),fu_cargo)
         and    a.tabla  = m.codigo
         and    m.tabla  = 'cl_cargo'
	 order  by a.valor
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
