/************************************************************************/
/*	Archivo:		filial.sp				*/
/*	Stored procedure:	sp_filial				*/
/*	Base de datos:		cobis					*/
/*	Producto:               Clientes				*/
/*	Disenado por:           Mauricio Bayas/Sandra Ortiz		*/
/*	Fecha de escritura:     15-Nov-1992				*/
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
/*	Este programa procesa las transacciones del stored procedure	*/
/*	Insercion de filial						*/
/*	Actualizacion de filial						*/
/*	Busqueda de filial						*/
/*	Query de filial especifico y generico				*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	15/Nov/92	M. Davila	Emision Inicial			*/
/*	14/Ene/93	L. Carvajal	Tabla de errores, variables	*/
/*					de debug			*/
/*	11/Jun/93	S. Ortiz	Actualizacion de datos redun-	*/
/*					dantes de ad_ruta.		*/
/*      17/Nov/93       R. Minga V.     documentacion,                  */
/*                                      personalizacion                 */
/*	25/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/************************************************************************/
use cobis
go




if exists (select * from sysobjects where name = 'sp_filial')
   drop proc sp_filial
go

create proc sp_filial (
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
	@i_operacion        	char(1),
	@i_modo			tinyint = null,
	@i_tipo			char(1) = null,
	@i_filial		tinyint = null
)
as
declare     @w_sp_name	   varchar(32),
	    @o_filial      tinyint,
	    @o_nombre      descripcion,
	    @o_rep_legal   descripcion,
	    @o_direccion   direccion,
	    @o_actividad   catalogo,
	    @o_acnombre    descripcion,
	    @o_abreviatura char(4),
            @o_ruc         numero


select @w_sp_name = 'sp_filial'

/* ** search ** */
/* Busqueda de datos de filial que se traen de 20 en 20 */
if @i_operacion='S'
begin
if @t_trn = 1570
begin
  set rowcount 20
     if @i_modo = 0
	 select   'Filial' = fi_filial,
		  'Nombre' = substring(fi_nombre, 1, 25),
		  'Rep.Legal' = fi_rep_nombre,
		  'Direccion' = substring(fi_direccion, 1, 55),
		  'R.U.C.' = fi_ruc,
		  'Abreviatura' = fi_abreviatura,
		  'Actividad'=fi_actividad,
		  'Descrip. Actividad'= substring(b.valor,1,30)
	 from     cl_filial, cl_tabla a, cl_catalogo b
	where     a.tabla='cl_actividad'
	  and     a.codigo=b.tabla
	  and     b.codigo=fi_actividad
	 order by fi_filial
     else if @i_modo = 1
     Begin
	    select  'Filial' = fi_filial,
		    'Nombre' = substring(fi_nombre, 1, 25),
		    'Rep.Legal' = fi_rep_nombre,
		    'Direccion' = substring(fi_direccion, 1, 55),
		    'R.U.C.' = fi_ruc,
		    'Abreviatura' = fi_abreviatura,
		    'Actividad'=fi_actividad,
		    'Descrip. Actividad'= substring(b.valor,1,30)
	    from     cl_filial, cl_tabla a, cl_catalogo b
	    where    fi_filial > @i_filial
	      and     a.tabla='cl_actividad'
	      and     a.codigo=b.tabla
	      and     b.codigo=fi_actividad
	    order by fi_filial

	/* ARO: 2 de Junio del 2000: Corrección Siguientes */        
        if @@rowcount=0
        Begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
        	set rowcount 0
        	return 1
        End
        /* Fin ARO */

	    
     End	    
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


/*  ** query **  */
/* Query de datos completos de filial dado el codigo */
if @i_operacion='Q'
begin
if @t_trn = 1569
begin
    select  @o_filial = fi_filial,
	    @o_nombre = fi_nombre,
	    @o_rep_legal = fi_rep_nombre,
	    @o_direccion = fi_direccion,
	    @o_actividad = fi_actividad,
	    @o_acnombre  = w.valor,
	    @o_abreviatura = fi_abreviatura,
            @o_ruc         = fi_ruc
    from    cl_filial, cl_catalogo w, cl_tabla z
    where   fi_filial = @i_filial
    	and w.codigo = fi_actividad
	and w.tabla = z.codigo
	and z.tabla = 'cl_actividad'

    if @@rowcount = 0
	 begin
	    exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101002
	    /* 'No existe filial'*/
	    return 1
	 end

    select  @o_filial, @o_nombre, @o_rep_legal, @o_direccion,
	    @o_actividad, @o_acnombre, @o_abreviatura, @o_ruc
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


/*  ** help ** */
/* Query de datos especificos [A]ll y [V]alue */
if @i_operacion='H'
begin
if @t_trn = 1571
begin

 if @i_tipo = 'A'
 begin
     set rowcount 20
     if (@i_modo = 0) or (@i_modo is null)
	 select   'Codigo' = fi_filial,
                  'Filial' = fi_nombre
	   from   cl_filial
	   order  by fi_filial
    else if @i_modo = 1
	 select   fi_filial, fi_nombre
	   from   cl_filial
          where   fi_filial > @i_filial
	   order  by fi_filial
     set rowcount 0
     return 0
 end

 if @i_tipo = 'V'
 begin
	 select  fi_nombre
	   from  cl_filial
	  where fi_filial = @i_filial
	 if @@rowcount = 0
	 begin
	    exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101002
	   /*	'No existe filial'*/
	   return 1
	 end
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
go
