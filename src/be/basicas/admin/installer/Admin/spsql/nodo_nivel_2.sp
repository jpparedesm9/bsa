/************************************************************************/
/*	Archivo:		nodo_ni2.sp				*/
/*	Stored procedure:	sp_nodo_nivel_2         		*/
/*	Base de datos:		cobis					*/
/*	Producto: Administracion					*/
/*	Disenado por:  Patricio Martinez/Diego Hidalgo			*/
/*	Fecha de escritura: 24-Mar-1995					*/
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
/*	Busqueda del nombre del mapa del 1er nivel 			*/
/*	Busqueda del path del mapa dado 				*/
/*	Busqueda de todos los nodos de un mapa y nivel dados		*/
/*	Busqueda de todos los iconos de un mapa y nivel dados		*/
/*	Busqueda del mapa_hijo del icono presionado			*/
/*	Busqueda de todos los nombres de los diferentes niveles		*/
/*      Grabacion de coordenadas de los nodos de un mapa y nivel dados  */
/*      Grabacion de coordenadas de los iconos de un mapa y nivel dados */
/*      Obtener el path del icono					*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	24-03-95	Diego Hidalgo	Emision Inicial			*/
/* 24-06-16 J.Hernandez    Ajuste Vesion Falabella cambio               */
/*                         tipo de dato nodo                            */
/************************************************************************/

use cobis
go

if exists ( select * from sysobjects where name = 'sp_nodo_nivel_2')
   drop proc sp_nodo_nivel_2
go

create proc sp_nodo_nivel_2(
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
        @i_operacion            char(1),
        @i_codigo_nivel         tinyint = NULL,
	@i_codigo_icono         tinyint = NULL,
        @i_codigo_mapa          tinyint = NULL, 
	@i_nombre_icono		descripcion = NULL,
	@i_x			smallint = NULL,
	@i_y			smallint = NULL,
	@i_filial		tinyint = NULL,
	@i_oficina		smallint = NULL,
	@i_nodo			smallint = NULL
)
as
declare
	@w_sp_name		varchar(32),
        @o_codigo_mapa          tinyint,	
	@o_path_mapa		descripcion,	
	@o_nombre_nodo		descripcion,
	@o_x			smallint,
	@o_y			smallint,
	@o_filial		tinyint,
	@o_oficina		smallint,
	@o_nodo			smallint,
	@o_codigo_icono		tinyint,
	@o_nombre_icono		descripcion,
	@o_mapa_hijo		descripcion,
	@o_nombre_nivel		descripcion

select @w_sp_name = 'sp_nodo_nivel_2'


/* ** Mapa 1er nivel ** */
if @i_operacion = 'M'
   begin
        select nm_codigo_mapa
	from ad_nivel_mapa
	where nm_codigo_nivel = @i_codigo_nivel
	return 0 
   end

/* ** Path de un Mapa dado ** */
if @i_operacion = 'P'
   begin
        select mp_mapath_bmp
	from ad_mapa
	where mp_codigo_mapa = @i_codigo_mapa
	return 0 
   end

/* ** Nodos de un mapa y nivel dados ** */
if @i_operacion = 'N'
   begin
        select nn_nombre_nodo,nn_x,nn_y,nn_filial,
	       nn_oficina,nn_nodo,nn_mapa_hijo
	from ad_nodo_nivel
	where nn_codigo_nivel = @i_codigo_nivel
          and nn_codigo_mapa = @i_codigo_mapa
	return 0 
   end

/* ** Iconos de un mapa y nivel dados ** */
if @i_operacion = 'I'
   begin
        select ic_nombre_icono,ic_x,ic_y,ic_codigo_icono
	from ad_icono
	where ic_codigo_nivel = @i_codigo_nivel
          and ic_codigo_mapa = @i_codigo_mapa
	return 0 
   end

/* ** Mapa_hijo de un icono presionado ** */
if @i_operacion = 'H'
   begin
        select ic_mapa_hijo
	from ad_icono
	where ic_codigo_nivel = @i_codigo_nivel
          and ic_codigo_mapa = @i_codigo_mapa
          and ic_nombre_icono = @i_nombre_icono
	return 0 
   end

/* ** Nombre de los niveles existentes ** */
if @i_operacion = 'O'
   begin
        select ni_nombre_nivel,ni_codigo_nivel
	from ad_nivel
	return 0 
   end

/* ** Grabacion de las coordenadas de los Nodos de un mapa y nivel dados ** */
if @i_operacion = 'A'
   begin
        Update ad_nodo_nivel
           set nn_x = @i_x,
	       nn_y = @i_y
	where nn_codigo_nivel = @i_codigo_nivel
          and nn_codigo_mapa = @i_codigo_mapa
	  and nn_filial = @i_filial
	  and nn_oficina = @i_oficina
	  and nn_nodo = @i_nodo
	return 0 

	if @@error != 0
	  begin
	  /*  'Error en actualizacion de nodo nivel' */
		exec sp_cerror
	 	@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 20500
		return 1
   	  end
    end

/* ** Grabacion de las coordenadas de los Iconos de mapa y nivel dados ** */
if @i_operacion = 'B'
   begin
        Update ad_icono
           set ic_x = @i_x,
	       ic_y = @i_y
	where ic_codigo_nivel = @i_codigo_nivel
          and ic_codigo_mapa = @i_codigo_mapa
          and ic_nombre_icono = @i_nombre_icono
	return 0 

	if @@error != 0
	  begin
	  /*  'Error en actualizacion de icono' */
		exec sp_cerror
	 	@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 20500
		return 1
   	  end
   end

/* ** Obtener el path del icono ** */
if @i_operacion = 'C'
   begin
        select ci_icopath_bmp 
	from ad_catalogo_icono
        where ci_codigo_icono = @i_codigo_icono
	return 0 
   end

go
