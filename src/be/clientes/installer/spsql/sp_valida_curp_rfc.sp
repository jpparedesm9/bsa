/*************************************************************************/
/*   Archivo:            sp_valida_curp_rfc.sp                           */
/*   Stored procedure:   sp_valida_curp_rfc                              */
/*   Base de datos:      cobis                                           */
/*   Producto:           Clientes				                         */
/*   Disenado por:       PEDRO ROMERO	                                 */
/*   Fecha de escritura: 07/05/2020                                      */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   VALIDA EL CURP Y RFC											     */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA        AUTOR                       RAZON                      */
/*  07-05-2020   PRO               Emision Inicial					     */
/*  23-12-2020   AIN               Cambio en validación de RFC y CURP    */
/*************************************************************************/

use cobis
go

if exists (select 1 from sysobjects where name = 'sp_valida_curp_rfc')
   drop proc sp_valida_curp_rfc
go

IF OBJECT_ID ('dbo.sp_valida_curp_rfc') IS NOT NULL
	DROP PROCEDURE dbo.sp_valida_curp_rfc
GO
create proc sp_valida_curp_rfc(
    @i_curp 	numero	=	null,
	@i_rfc		numero	= 	null,
	@i_ente		int		= 	null
)
as
declare @w_today                 datetime,
		@w_fecha_nac_format		 varchar(10),
		@w_fecha_nac_format_org	 varchar(10),
		@w_genero				 varchar(2),
		@w_genero_org				 varchar(2),
		@w_rfc_org				numero,
		@w_curp_org				numero,
		@w_depa_nac_int			smallint,
		@w_depa_nac_org			varchar(64),
		@w_depa_nac				varchar(64)
		


SELECT 	@w_fecha_nac_format			=	SUBSTRING(@i_curp,5,6),
		@w_fecha_nac_format_org		=	FORMAT(p_fecha_nac,'yyMMdd'),
		@w_genero					=	SUBSTRING(@i_curp,11,1),
		@w_genero_org				=	case when p_sexo = 'M' then 'H' else 'M' end,
		@w_depa_nac					=	SUBSTRING(@i_curp,12,2),
		@w_rfc_org					=	en_rfc,
		@w_curp_org					= 	en_ced_ruc,
		@w_depa_nac_int				=	p_depa_nac
FROM cl_ente 
WHERE en_ente = @i_ente


select  @w_depa_nac_org = e2.eq_valor_arch
    from cob_conta_super..sb_equivalencias e1, cob_conta_super..sb_equivalencias e2
    where e1.eq_catalogo = 'ENT_FED'
    and e1.eq_valor_cat = convert(varchar, @w_depa_nac_int)
    and e2.eq_catalogo = 'ENT_CURP'
    and e2.eq_valor_cat = e1.eq_valor_arch

if(@w_fecha_nac_format <> @w_fecha_nac_format_org)
begin
	--print 'ERROR EN FECHA DE NAC'
	goto ERROR	
end

if(@w_genero <> @w_genero_org)
begin
	--print 'ERROR EN GENERO'
	goto ERROR	
end

if(@w_depa_nac <> @w_depa_nac_org)
begin
	--print 'ERROR EN DEPARTAMENTO'
	goto ERROR	
end
/*
if SUBSTRING(@i_rfc,0,11) <> SUBSTRING(@w_rfc_org,0,11)
begin		
	--print 'ERROR EN RFC'
	goto ERROR		
end	

if SUBSTRING(@i_curp,0,11) <> SUBSTRING(@w_curp_org,0,11)
begin		
	--print 'ERROR EN CURP'
	goto ERROR			
end	
*/
return 0

ERROR:
exec sp_cerror
		@t_debug = 'N',		
		@i_num   = 101043,
		@i_msg	 = 'ERROR: No hay consistencia de datos entre RFC, CURP y fecha de nacimiento'
	 return 101043	

go