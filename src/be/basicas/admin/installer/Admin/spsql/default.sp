
/************************************************************************/
/*      Archivo:                default.sp                              */
/*      Stored procedure:       sp_default                              */
/*      Base de datos:          cobis                                   */
/*      Producto: Administracion                                        */
/*      Disenado por:  Mauricio Bayas/Sandra Ortiz                      */
/*      Fecha de escritura:                                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*                                      Emision inicial                 */
/*      04/May/94       F.Espinosa      Parametros tipo "S"             */
/*                                      Transacciones de Servicio       */
/*      28/ABR/95       S.Vinces        Cambios por Admin Distribuido   */
/*      28/DIC/01       A.Duque         Consulta de defaults por oficina*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_default')
	drop proc sp_default
go

create proc sp_default (
	@s_ssn                  int = NULL,
	@s_user                 login = NULL,
	@s_sesn                 int = NULL,
	@s_term                 varchar(30) = NULL,
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
	@t_trn                  smallint =NULL,
	@i_oficina              smallint,
	@i_tabla                descripcion = null,
	@i_operacion            varchar(1) = null,
	@i_codigo               varchar(10) = null,
	@i_valor                varchar(30) = null,
        @i_central_transmit     varchar(1) = null
)
as
declare @w_sp_name      varchar(30),
	@w_return	int,
	@w_nt_nombre    varchar(40),
	@w_cod_tabla    smallint,
	@w_cmdtransrv   varchar(64),
	@w_server_logico    varchar(10),
	@w_num_nodos        smallint,    
	@w_contador          smallint,
	@w_titulo	descripcion,
	@w_clave	int 

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_default'

/*  Determina codigo de tabla de la base de datos  */
select  @w_cod_tabla = codigo,
	@w_titulo = descripcion
from    cl_tabla
where   tabla = @i_tabla

/* Creacion de tabla temporal de nodos a distribuir */
/* Si esta en ambiente UNIX SYBASE                  */
if ( @i_operacion is null ) and (@i_central_transmit is NULL)
begin
 create table #ad_nodo_reentry_tmp (nt_nombre varchar(60), nt_bandera char (1))
end
 
/*  Update  */
if @i_operacion is null
begin
if @t_trn = 1587
begin
	begin tran
		if exists (select *
			     from cobis..cl_default
			    where oficina = @i_oficina
			      and tabla   = @w_cod_tabla)
			update  cobis..cl_default
			   set  codigo = @i_codigo,
				valor  = @i_valor
			 where  oficina = @i_oficina
			   and  srv     = @s_lsrv
			   and  tabla   = @w_cod_tabla
		else
		begin
			insert into cobis..cl_default 
				(oficina, tabla, 
				codigo, valor, srv)
			values (@i_oficina, @w_cod_tabla, 
				@i_codigo, @i_valor, @s_lsrv)
			if @@error != 0
			begin
				/*  Error en insercion de default  */
				exec cobis..sp_cerror
					@t_debug= @t_debug,
					@t_file = @t_file,
					@t_from = @w_sp_name,
					@i_num  = 103055
				return 1
			end
		end
		if not exists( select * from cobis..cl_catalogo
				where tabla = @w_cod_tabla
				 and  codigo = @i_codigo)
			begin
			insert into cobis..cl_catalogo
				(tabla, codigo,
				 valor, estado)
			values (@w_cod_tabla, @i_codigo,
				@i_valor, 'V')
			if @@error != 0
			begin
				/*  Error en insercion de default  */
				exec cobis..sp_cerror
					@t_debug= @t_debug,
					@t_file = @t_file,
					@t_from = @w_sp_name,
					@i_num  = 103055
				return 1
			end
			end
	commit tran

  exec REENTRY...rp_gen_catalogo
  select @w_cmdtransrv = @s_lsrv +'...sp_load_catalogo'
  exec @w_cmdtransrv
/************************    Para    Unix     **************************/

	insert into #ad_nodo_reentry_tmp
	select nl_nombre,'N'
          from ad_nodo_oficina,ad_server_logico
	 where nl_nombre <> @s_lsrv          
	   and nl_filial   = sg_filial_i   
	   and nl_oficina  = sg_oficina_i 
	   and nl_nodo     = sg_nodo_i    
	   and sg_producto = 1             
	   and sg_tipo     = 'R'           
	   and sg_moneda   = 0             


	select @w_num_nodos = count(*) from #ad_nodo_reentry_tmp

	/* Lazo para hacer REENTRY a los nodos de la tabla temporal */
	select @w_contador = 1
	while @w_contador <= @w_num_nodos
         begin
		set rowcount 1
	select @w_cmdtransrv = 'REENTRY' + '.' + nt_nombre + '.cobis.' + @w_sp_name,@w_nt_nombre = nt_nombre
		  from #ad_nodo_reentry_tmp
	          where nt_bandera = 'N'

		  set rowcount 0

		update #ad_nodo_reentry_tmp set nt_bandera = 'S'
		where nt_nombre = @w_nt_nombre

		exec @w_return = @w_cmdtransrv
					@s_lsrv        = @w_nt_nombre,
					@t_rty	       = 'S',
					@t_trn         = @t_trn,           
					@i_oficina     = @i_oficina,
					@i_tabla       = @i_tabla,
					@i_cod_tabla   = @w_cod_tabla,
					@i_titulo      = @w_titulo,
					@i_codigo      = @i_codigo,
					@i_valor       = @i_valor,
					@i_central_transmit = 'S',
					@o_clave	= @w_clave out


			if @w_return <> 0
				return @w_return

			exec @w_return = cobis..sp_reentry
				@i_key = @w_clave,
				@i_tipo =  'I'

			if @w_return <> 0
				return @w_return

			select @w_contador = @w_contador + 1
			continue
	end
	delete #ad_nodo_reentry_tmp
/************************    Para    Unix     **************************/
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

/*  Search  */
if @i_operacion = 'S'
begin
if @t_trn = 1588
begin
	select  'Tabla',
		'Codigo', 
		'Valor'
	select  cl_tabla.tabla, 
		cl_default.codigo,
		valor
	  from  cl_tabla,
		cl_default
	 where  cl_tabla.codigo = cl_default.tabla      
	   and  oficina = @i_oficina
	if @@error != 0
	begin
		/*  No existen datos de default  */
		exec cobis..sp_cerror
			@t_debug= @t_debug,
			@t_file = @t_file,
			@t_from = @w_sp_name,
			@i_num  = 101078
	end
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

/*Consulta de default por oficina*/
/*         ADU  2001-12-28       */
/*  Search  */
if @i_operacion = 'Q'
begin
if @t_trn = 1588
begin
	select	cl_default.codigo, valor
	  from	cl_default, cl_tabla
	 where	cl_default.tabla = cl_tabla.codigo
           and  cl_tabla.tabla = @i_tabla
	   and	oficina = @i_oficina
end
end
/*             Fin ADU           */
go
