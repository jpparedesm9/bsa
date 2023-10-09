/************************************************************************/
/*  Archivo:            tr_cons_tot_nal_adm.sp                          */
/*  Stored procedure:   sp_tr_cons_tot_nal_adm                          */
/*  Base de datos:      cobis                                           */
/*  Producto:           Ahorros                                         */
/*  Disenado por:                                                       */
/*  Fecha de escritura:                                                 */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*                                                                      */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA          AUTOR           RAZON                                */
/*  06/Jul/2016  Juan Tagle    Migración CEN                            */
/************************************************************************/

use cob_cuentas
go 

if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_cons_tot_nal_adm')
  drop proc sp_tr_cons_tot_nal_adm
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_tr_cons_tot_nal_adm (
	@s_ssn		int,
	@s_srv	    varchar(30),
	@s_lsrv		varchar(30),
	@s_user		varchar(30),
	@s_sesn		int = null,
	@s_term		varchar(10),
	@s_date		datetime,
	@s_ofi		smallint,	/* Localidad origen transaccion */
	@s_rol		smallint,
	@s_org_err	char(1)	= null,	/* Origen de error: [A], [S] */
	@s_error	int	= null,
	@s_sev		tinyint	= null,
	@s_msg		varchar(240)	= null,
	@s_org		char(1),
	@t_corr   	char(1) = 'N',
	@t_ssn_corr	int = null,	/* Trans a ser reversada */
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(32) = null,
	@t_rty		char(1) = 'N',
	@t_trn		smallint,
	@i_mon		tinyint,
	@i_tran		smallint,
	@i_proc		char(1),
	@i_grupo	tinyint
)
as
declare	@w_return	int,
	@w_sp_name	varchar(30),
	@w_maxgrupos    tinyint
	
/*  Captura nombre de Stored Procedure  */
select	@w_sp_name = 'sp_tr_cons_tot_nal_adm'

/* Inicia el proceso para obtencion de la consulta */
if @t_trn != 2700
begin
  /* Error en codigo de transaccion */
   exec cobis..sp_cerror
	   @t_debug     = @t_debug,
	   @t_file      = @t_file,
	   @t_from      = @w_sp_name,
	   @i_num	= 201048
   return 201048
end

if @i_proc = 'G' or @i_proc = 'P'
begin
   set rowcount 1
   select gr_grupo,
          gr_descripcion
     from cob_remesas..re_grupo
    where gr_grupo > @i_grupo
      and gr_nivel = 0 
    order by gr_grupo    

   if @i_proc = 'P'
   begin
      select 'Trans'                 = cj_transaccion,
             'NOMBRE DE TRANSACCION' = cj_transaccion,
             'No.'                   = cj_numero,
             'EFECTIVO        '      = cj_efectivo,
             'CHEQUES PROPIOS '      = cj_cheque,
             'CHEQUES LOCALES '      = cj_chq_locales,
             'CHEQUES PLAZAS  '      = cj_chq_ot_plaza,
             'OTROS           '      = cj_otros,
             'INTERESES       '      = cj_interes,
             'AJUSTE INTERESES'      = cj_ajuste_int,
             'AJUSTE CAPITAL  '      = cj_ajuste_cap,
             'TOTAL           '      = cj_efectivo,
             'SIGNO           '      = 'S'
        from cob_remesas..re_caja
   end
   set rowcount 0
end
else
begin
   set rowcount 20
       /* Envio de resultados al Front End */
       select 'TRANS '                = cj_transaccion,
              'NOMBRE DE TRANSACCION' = (select tn_descripcion
                                           from cobis..cl_ttransaccion
                                          where tn_trn_code = x.cj_transaccion),
              'NUMERO'                = sum(cj_numero),
      	      'EFECTIVO'              = sum(cj_efectivo),
   	          'CHEQUES PROPIOS '      = sum(cj_cheque),
	          'CHEQUES LOCALES '      = sum(cj_chq_locales),
	          'CHEQUES OTRAS PLAZAS'  = sum(cj_chq_ot_plaza),
	          'OTROS'                 = sum(cj_otros),
	          'INTERESES'             = sum(cj_interes),
	          'AJUSTE DE INTERESES'   = sum(cj_ajuste_int),
	          'AJUSTE DE CAPITAL'     = sum(cj_ajuste_cap),
      	      'TOTAL'                 = sum(cj_efectivo) +
   	                                    sum(cj_cheque) +
	                                    sum(cj_chq_locales) +
	                                    sum(cj_chq_ot_plaza) +
	                                    sum(cj_otros) +
	                                    sum(cj_interes) +
	                                    sum(cj_ajuste_int) +
	                                    sum(cj_ajuste_cap),
              'SIGNO'                 = tg_afecta_efectivo + tg_afecta_signo
         from cob_remesas..re_caja x,
              cob_remesas..re_trn_grupo
        where cj_moneda = @i_mon
          and cj_transaccion > @i_tran 
          and cj_transaccion = tg_transaccion 
          and tg_grupo = @i_grupo 
          and cj_operador != 'reentry'
          and cj_numero > 0
        group by cj_transaccion, tg_afecta_efectivo + tg_afecta_signo

   set rowcount 0
end

return 0
go
