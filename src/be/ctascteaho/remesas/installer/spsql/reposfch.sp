/************************************************************************/
/*	Archivo: 		reposfch.sp                             */
/*	Stored procedure: 	sp_rem_postfecha            		*/
/*	Base de datos:  	cob_remesas				*/
/*	Producto: 		Remesas 				*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 03-May-1993					*/
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
/*	Este programa procesa la transaccion de:                 	*/
/*      Permite postergar fecha de efectivacion de una carta.           */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	03/May/1993	J Navarrete	Emision inicial			*/
/*      24/Ene/2001     E.Pulido        Aumentar el campo ciudad a 4 dig*/ 
/*      21/Ene/2003     J. Loyo         Aumentar el campo Oficna a 4 dig*/ 
/*      11/Nov/2004     J.Colorado      Banco AGRARIO                   */
/************************************************************************/
use cob_remesas
go

if exists (select * from sysobjects where name = 'sp_rem_postfecha')
	drop proc sp_rem_postfecha

go
create proc sp_rem_postfecha (
	@s_ssn		int,
	@s_srv	        varchar(30),
	@s_lsrv	        varchar(30),
	@s_user		varchar(30),
	@s_sesn	        int=null,
	@s_term		varchar(10),
	@s_date		datetime,
	@s_ofi		smallint,	/* Localidad origen transaccion */
	@s_rol		smallint,
	@s_org_err	char(1)	= null,	/* Origen de error: [A], [S] */
	@s_error	int	= null,
	@s_sev	        tinyint	= null,
	@s_msg		mensaje	= null,
	@s_org		char(1),
	@t_corr   	char(1) = 'N',
	@t_ssn_corr	int = null,	/* Trans a ser reversada */
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(32) = null,
	@t_rty		char(1) = 'N',
	@t_trn		smallint,
	@p_lssn		int	= null,
	@p_rssn		int	= null,
	@p_rssn_corr	int	= null,
	@p_envio	char(1) = 'N',
	@p_rpta	        char(1) = 'N',
        --IU ERP 24/01/2001 cc00194
	@i_corres	char(11),
	@i_propie       char(11),
        @i_emisor       char(11),
        --FU ERP 24/01/2001 cc00194
	@i_fecha	datetime,
	@i_secuen	int,
	@i_dias_pos	int,
	@i_mon	        tinyint    
)
as
declare	@w_return	int,
	@w_sp_name	varchar(30),
	@w_mensaje	varchar(120),
	@w_filial 	tinyint,
	@w_fecha_term	datetime,
	@w_fecha_efe	datetime,
	@w_fecha	datetime,
	@w_oficina	smallint,
	@w_ofi_bco	smallint,
	@w_banco	smallint,
	@w_ciudad	smallint,
	@w_producto	tinyint,
	@w_nom_producto	descripcion,
	@w_server_rem	descripcion,
	@w_server_local	descripcion,
	@w_bco_p	smallint,
	@w_ofi_p	smallint,
	@w_ciu_p	smallint,
	@w_bco_c	smallint,
	@w_ofi_c	smallint,
	@w_ciu_c	smallint,
	@w_factor	int
	
/*  Captura nombre de Stored Procedure  */
select	@w_sp_name = 'sp_rem_postfecha'

/*  Modo de debug  */

/* Chequeo de errores generados remotamente */
if @s_org_err is not null       	/*  Error del Sistema  */
begin
        exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = @s_error,
               @i_sev          = @s_sev,
               @i_msg          = @s_msg
        return 1
end

select @w_fecha = @i_fecha

/* Valida datos */
if @i_dias_pos = 0 or @i_secuen = 0
begin
    exec cobis..sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 351002
    return 1
end

--IU ERP 24/01/2001 cc00194
/* Separa codigo de banco del corresponsal en sus componentes */
select @w_bco_c = convert(smallint, substring(@i_corres,1,2))
select @w_ofi_c = convert(smallint, substring(@i_corres,3,5))
--select @w_ciu_c = convert(smallint, substring(@i_corres,6,3))
select @w_ciu_c = convert(smallint, substring(@i_corres,8,4))

/* Separa codigo de banco del propietario en sus componentes */
select @w_bco_p = convert(smallint, substring(@i_propie,1,2))
select @w_ofi_p = convert(smallint, substring(@i_propie,3,5))
--select @w_ciu_p = convert(smallint, substring(@i_propie,6,3))
select @w_ciu_p = convert(smallint, substring(@i_propie,8,4))
--FU ERP 24/01/2001 cc00194

select @w_nom_producto = 'CUENTA DE AHORROS'

/*  Captura de parametros de la oficina  */
exec @w_return = cobis..sp_parametros 
			@t_debug	= @t_debug,
			@t_file	        = @t_file,
			@t_from	        = @w_sp_name,
			@s_lsrv	        = @s_lsrv,
			@i_nom_producto	= @w_nom_producto,
			@o_banco 	= @w_banco out, 
			@o_ciudad 	= @w_ciudad out, 
			@o_oficina 	= @w_oficina out,
			@o_ofi_bco 	= @w_ofi_bco out,
			@o_producto 	= @w_producto out
			
if @w_return != 0
	return @w_return

select @w_server_local = @s_lsrv

/*  Modo de correccion  */
if   @t_corr = 'N'
     select @w_factor = 1
else select @w_factor = -1

/* el sp_parametros no envia estos campos */

select @w_banco   =   convert(smallint, substring(@i_emisor,1,2))
select @w_ofi_bco =   convert(smallint, substring(@i_emisor,3,5))
select @w_ciudad  =   convert(smallint, substring(@i_emisor,8,4))



/* Valido la existencia de la carta */
begin tran
select @w_fecha_efe = ct_fecha_efe
from cob_remesas..re_carta
where ct_banco_e 	= @w_banco
and   ct_oficina_e 	= @w_ofi_bco
and   ct_ciudad_e 	= @w_ciudad
and   ct_banco_p 	= @w_bco_p
and   ct_oficina_p 	= @w_ofi_p
and   ct_ciudad_p 	= @w_ciu_p
and   ct_fecha_emi 	= @w_fecha
and   ct_moneda 	= @i_mon
and   ct_carta 		= @i_secuen
and   ct_banco_c 	= @w_bco_c
and   ct_oficina_c 	= @w_ofi_c
and   ct_ciudad_c 	= @w_ciu_c
and   ct_estado 	= 'N'
if @@rowcount = 0
begin
     exec cobis..sp_cerror
          @t_debug        = @t_debug,
          @t_file         = @t_file,
          @t_from         = @w_sp_name,
          @i_num          = 351003
     return 1
end

/* Determina nueva fecha de efectivizacion */
exec @w_return = cobis..sp_fecha_posterior
            @t_file       = @t_file,
            @t_debug      = @t_debug,
		@t_from       = @t_from,
		@i_fecha      = @w_fecha_efe,
		@i_dias       = @i_dias_pos,
            @i_ofi        = @s_ofi,
		@o_fecha_efec = @w_fecha_term out
if @w_return != 0
   return @w_return

/* Actualiza carta */
update cob_remesas..re_carta
set ct_fecha_efe = @w_fecha_term
where ct_banco_e 	= @w_banco
and   ct_oficina_e 	= @w_ofi_bco
and   ct_ciudad_e 	= @w_ciudad
and   ct_banco_p 	= @w_bco_p
and   ct_oficina_p 	= @w_ofi_p
and   ct_ciudad_p 	= @w_ciu_p
and   ct_fecha_emi 	= @w_fecha
and   ct_moneda 	= @i_mon
and   ct_banco_c 	= @w_bco_c
and   ct_oficina_c 	= @w_ofi_c
and   ct_ciudad_c 	= @w_ciu_c
and   ct_estado 	= 'N'

commit tran
return 0
go
