/************************************************************************/
/*	Archivo:		busqnodo.sp				*/
/*	Stored procedure:	sp_busqueda_nodos			*/
/*	Base de datos:		cobis					*/
/*	Producto: Administracion					*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 15-Mar-1994					*/
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
/*	Este programa procesa las transacciones de:			*/
/*	Busqueda del nodo - oficina					*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	15/Mar/94	F. Espinosa	Emision inicial			*/
/*	04/May/94	F.Espinosa	Parametros tipo "S"		*/
/************************************************************************/

use cobis
go

if exists ( select * from sysobjects where name = 'sp_busqueda_nodos')
   drop proc sp_busqueda_nodos










go
create proc sp_busqueda_nodos (
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
	@i_tipo			char(1) = null,
	@i_modo			smallint = null,
        @i_nodo                 tinyint = null,
        @i_nombre               descripcion = NULL,
	@i_valor		varchar(30) = '%',
	@i_formato_fecha	int = null
)
as
declare
	@w_today		datetime,
	@w_sp_name		varchar(32)

select @w_today = @s_date
select @w_sp_name = 'sp_busqueda_nodos'


/* ** search ** */
if @t_trn = 1583
begin
  if @i_tipo = '0'
  begin
     set rowcount 20
     if @i_modo = 0
     begin
	select  'Codigo nodo' = nl_nodo,
		'Nombre del servidor' = substring(nl_nombre, 1, 20),
		'Codigo filial' = nl_filial,
		'Filial' = fi_abreviatura,
		'Codigo Oficina' = nl_oficina,
		'Oficina' = substring(of_nombre, 1, 20),
		'Cod. S.O' = nl_sis_operativo,
		'Sistema operativo' = substring(so_descripcion, 1, 20),
		'Marca' = substring(no_marca + '  ' + no_modelo, 1, 30),
		'Registrador' = nl_registrador,
		'Nombre Reg' = X.fu_nombre,
		'Habilitante' = nl_habilitante,
		'Nombre_hab' = Y.fu_nombre,
		'Fecha habil' = convert(char(10),nl_fecha_habil,@i_formato_fecha)

	 from	ad_nodo_oficina, ad_nodo, cl_filial, cl_oficina,
		ad_sis_operativo, cl_funcionario X, cl_funcionario Y
	where	nl_registrador = X.fu_funcionario
	  and	nl_habilitante = Y.fu_funcionario
	  and	nl_filial = fi_filial
	  and	nl_oficina = of_oficina
	  and	nl_nodo = no_nodo
	  and   convert(char,nl_nodo) like @i_valor
	  and	nl_sis_operativo = so_sis_operativo
	  and	nl_estado = 'V'
        order   by  nl_nodo
       set rowcount 0
     end
     if @i_modo = 1
     begin
	select  'Codigo nodo' = nl_nodo,
		'Nombre del servidor' = substring(nl_nombre, 1, 20),
	        'Codigo filial' = nl_filial,
		'Filial' = fi_abreviatura,
		'Codigo Oficina' = nl_oficina,
		'Oficina' = substring(of_nombre, 1, 20),
		'Cod. S.O' = nl_sis_operativo,
		'Sistema operativo' = substring(so_descripcion, 1, 20),
		'Marca' = substring(no_marca + '  ' + no_modelo, 1, 30),
		'Registrador' = nl_registrador,
		'Nombre Reg' = X.fu_nombre,
		'Habilitante' = nl_habilitante,
		'Nombre_hab' = Y.fu_nombre,
		'Fecha habil' = convert(char(10),nl_fecha_habil,@i_formato_fecha)

	 from	ad_nodo_oficina, ad_nodo, cl_filial, cl_oficina,
		ad_sis_operativo, cl_funcionario X, cl_funcionario Y
	where	nl_registrador = X.fu_funcionario
	  and	nl_habilitante = Y.fu_funcionario
	  and	nl_filial = fi_filial
	  and	nl_oficina = of_oficina
	  and	nl_nodo    = no_nodo
	  and   convert(char,nl_nodo) like @i_valor
	  and	nl_sis_operativo = so_sis_operativo
          and   nl_nodo > @i_nodo
	  and   nl_estado = 'V'
        order   by nl_nodo
       set rowcount 0
     end
  end

  if @i_tipo = '1'
  begin

     set rowcount 20
     if @i_modo = 0
     begin
	select  'Codigo nodo' = nl_nodo,
		'Nombre del servidor' = substring(nl_nombre, 1, 20),
		'Codigo filial' = nl_filial,
		'Filial' = fi_abreviatura,
		'Codigo Oficina' = nl_oficina,
		'Oficina' = substring(of_nombre, 1, 20),
		'Cod. S.O' = nl_sis_operativo,
		'Sistema operativo' = substring(so_descripcion, 1, 20),
		'Registrador' = nl_registrador,
		'Nombre Reg' = X.fu_nombre,
		'Habilitante' = nl_habilitante,
		'Nombre_hab' = Y.fu_nombre,
		'Fecha habil' = convert(char(10),nl_fecha_habil,@i_formato_fecha)

	 from	ad_nodo_oficina, ad_nodo, cl_filial, cl_oficina,
		ad_sis_operativo, cl_funcionario X, cl_funcionario Y
	where	nl_registrador = X.fu_funcionario
	  and	nl_habilitante = Y.fu_funcionario
	  and	nl_filial = fi_filial
	  and	nl_oficina = of_oficina
	  and	nl_nodo = no_nodo
          and   substring(nl_nombre, 1, 20) like @i_valor
	  and	nl_sis_operativo = so_sis_operativo
	  and	nl_estado = 'V'
	  order by  substring(nl_nombre, 1, 20)
       set rowcount 0
     end
     if @i_modo = 1
     begin
	select  'Codigo nodo' = nl_nodo,
		'Nombre del servidor' = substring(nl_nombre, 1, 20),
	        'Codigo filial' = nl_filial,
		'Filial' = fi_abreviatura,
		'Codigo Oficina' = nl_oficina,
		'Oficina' = substring(of_nombre, 1, 20),
		'Cod. S.O' = nl_sis_operativo,
		'Sistema operativo' = substring(so_descripcion, 1, 20),
		'Marca' = substring(no_marca + '  ' + no_modelo, 1, 30),
		'Registrador' = nl_registrador,
		'Nombre Reg' = X.fu_nombre,
		'Habilitante' = nl_habilitante,
		'Nombre_hab' = Y.fu_nombre,
		'Fecha habil' = convert(char(10),nl_fecha_habil,@i_formato_fecha)

	 from	ad_nodo_oficina, ad_nodo, cl_filial, cl_oficina,
		ad_sis_operativo, cl_funcionario X, cl_funcionario Y
	where	nl_registrador = X.fu_funcionario
	  /*and	isnull(nl_habilitante,0) = Y.fu_funcionario*/
	  and	nl_habilitante = Y.fu_funcionario
	  and	nl_filial = fi_filial
	  and	nl_oficina = of_oficina
	  and	nl_nodo    = no_nodo
          and   substring(nl_nombre, 1, 20) like @i_valor
	  and	nl_sis_operativo = so_sis_operativo
          and   substring(nl_nombre, 1, 20) > @i_nombre 
	  and   nl_estado = 'V'
	  order by  substring(nl_nombre, 1, 20)
       set rowcount 0
     end
  end
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
return 0
go
