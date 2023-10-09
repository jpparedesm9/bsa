/************************************************************************/
/*	Archivo:		pro_inst.sp				*/
/*	Stored procedure:	sp_pro_instalado			*/
/*	Base de datos:		cobis					*/
/*	Producto:       	Administrador				*/
/*	Disenado por:           Mauricio Bayas / Sandra Ortiz 		*/
/*	Fecha de escritura:     14/Abr/94				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes  exclusivos  para el  Ecuador  de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su  uso no autorizado  queda expresamente  prohibido asi como	*/
/*	cualquier   alteracion  o  agregado  hecho por  alguno de sus	*/
/*	usuarios   sin el debido  consentimiento  por  escrito  de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones del stored procedure	*/
/*	Busqueda de Productos Instalados 				*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	14/Abr/94	F.Espinosa    	Emision Inicial			*/
/************************************************************************/
use cobis 
go

if exists (select * from sysobjects where name = 'sp_pro_instalado')
   drop proc sp_pro_instalado
go

create proc sp_pro_instalado (
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
       	@i_operacion		char(1),
       	@i_modo			tinyint = null,
       	@i_nemonico		char(3) = null,
        @i_firma                char(1) ='%'
)
as

declare @w_return       int,
        @w_sp_name	varchar(32)

select @w_sp_name = 'sp_pro_instalado'


/* ** Search** */
 if @i_operacion = 'S' 
 begin
If @t_trn = 15016
begin
     set rowcount 20
     if @i_modo = 0
	select 'Producto' = pi_producto ,
	       'Descripcion P.' = pd_descripcion,
	       'Moneda'      = pm_moneda,
	       'Descripcion M.' = pm_descripcion
	from   ad_pro_instalado , cl_producto,cl_pro_moneda
        where  pi_producto = pd_abreviatura
 	  and  pd_producto = pm_producto
	  and  pd_tipo	   = pm_tipo
	order by pi_producto

     if @i_modo = 1
	select 'Producto' = pi_producto ,
	       'Descripcion P.' = pd_descripcion,
	       'Moneda'      = pm_moneda,
	       'Descripcion M.' = pm_descripcion
	from   ad_pro_instalado , cl_producto,cl_pro_moneda
        where  pi_producto = pd_abreviatura
	  and  pi_producto > @i_nemonico
 	  and  pd_producto = pm_producto
	  and  pd_tipo	   = pm_tipo
	order by pi_producto

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
