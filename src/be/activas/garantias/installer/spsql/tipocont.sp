/************************************************************************/
/*	Archivo:                tipocont.sp 			        */
/*	Stored procedure:       sp_tipo_conta				*/
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Gonzalo Jaramillo/Rodrigo Garces      	*/
/*			        Luis Alfredo Castellanos              	*/
/*	Fecha de escritura:     Junio-1995  				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa permite seleccionar los tipos de garantias y su   */
/*	descripcion.                                                    */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Jun/1995		     Emision Inicial			*/
/************************************************************************/
use cobis
go

if exists (select 1 from sysobjects where name = 'sp_tipo_conta')
    drop proc sp_tipo_conta
go
create proc sp_tipo_conta (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_corr               char(1)  = null,
   @s_ssn_corr           int      = null,
   @s_ofi                smallint  = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_tipo               descripcion  = null,
   @i_tipo_superior      descripcion  = null,
   @i_descripcion        varchar(255)  = null,
   @i_perfil             varchar(10)     = null,
   @i_abier_cerrada      char(  1)  = null,
   @i_periodicidad       catalogo  = null,
   @i_param1             descripcion = null,
   @i_filial		 tinyint = null,
   @i_cuenta		 char(20) = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_tipo               descripcion,
   @w_tipo_superior      descripcion,
   @w_descripcion        varchar(255),
   @w_perfil             varchar(10),     
   @w_abier_cerrada      char(  1),
   @w_periodicidad       catalogo,
   @w_des_tiposup        descripcion,
   @w_des_periodicidad   descripcion,
   @w_des_perfil         descripcion

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_tipo_conta'

/***********************************************************/
/* Codigos de Transacciones                                */

 /* Todos los datos de la tabla */
 /*******************************/
if @i_operacion = 'H'
begin
         select "TIPO" = tc_tipo, "DESCRIPCION" = substring(tc_descripcion,1,25)
           from cob_custodia..cu_tipo_custodia  
         if @@rowcount = 0
         begin 
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file, 
           @t_from  = @w_sp_name,
           @i_num   = 1901003
           return 1 
         end
end
go