/****************************************************************************/
/*     Archivo:     help_trn_contabilizar.sp                                */
/*     Stored procedure: sp_help_trn_contabilizar                           */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:    Jorge Baque                                         */
/*     Fecha de escritura: 13/May/2016                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*                                                                          */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     13/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_help_trn_contabilizar')
  drop proc sp_help_trn_contabilizar
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

CREATE proc sp_help_trn_contabilizar (
        @s_ssn          int,
        @s_srv          varchar(30),
        @s_lsrv         varchar(30),
        @s_user         varchar(30),
        @s_sesn         int=null,
        @s_term         varchar(10),
        @s_date         datetime,
        @s_ofi          smallint,       
        @s_rol          smallint,
        @s_org_err      char(1)     = null,
        @s_error        int         = null,
        @s_sev          tinyint     = null,
        @s_msg          mensaje     = null,
        @s_org          char(1),
        @t_corr         char(1)     = 'N',
        @t_ssn_corr     int         = null,   
        @t_debug        char(1)     = 'N',
        @t_file         varchar(14) = null,
        @t_from         varchar(32) = null,
        @t_rty          char(1)     = 'N',
        @t_trn          smallint,
        @i_operacion    char(1),
        @i_codigo       int         = null,
        @i_orden        int         = null,
        @i_causa        varchar(4)         = null,
        @i_prod         tinyint     = null,
	@i_formato_fecha int	    = 101,
        @i_codtrn       smallint    = 0
)
as
declare	@w_return	int,
        @w_sp_name      varchar(30)    
	
/*  Captura nombre de Stored Procedure  */
select	@w_sp_name = 'sp_help_trn_contabilizar'

/*  Modo de debug  */

/* Valida Transaccion */
if @t_trn <> 494
   begin
   /* No existe transaccion */
      exec cobis..sp_cerror
         @t_debug        = @t_debug,
         @t_file         = @t_file,
         @t_from         = @w_sp_name,
         @i_num          = 351014
      return 351014
   end

/*
-- Validación de las transacciones en la tabla de transacciones extractos
select * 
from cob_cuentas..cc_transaccion_extracto
where te_transaccion= @i_codtrn
if @@rowcount = 0
begin
 print 'La transaccion no se ha incluido en la parametrizacion de transacciones para extracto'
end
*/

/* Consulta de Transacciones a Contabilizar */
if @i_operacion = 'P'

   begin
      set rowcount 20

      select 'TRAN'         = tc_tipo_tran,
             'DESCRIPCION'  = substring(tc_descripcion,1,50),
             'SIGNO'        = tc_credeb,
             'CAUSA ORIG'   = substring(tc_causa_org,1,3),
             'CAUSA DEST'   = tc_causa_dst,
             'INDICADOR'    = tc_indicador,
             'CAMPO A CONT' = substring(tc_contabiliza,1,17),
             'ESTADO'       = tc_estado,
             'PERFIL'       = tc_perfil,
             'FECHA'        = convert(varchar(10),tc_fecha,@i_formato_fecha),
             'INDICE'       = tc_indice,
             'REF INT'      = tc_secuencial,
	     'PROD BANC'    = tc_prod_banc,
	     'CLASE'        = tc_clase,
	     'TOTALIZA'     = tc_totaliza
        from cob_remesas..re_tran_contable
       where tc_producto = @i_prod
         and tc_tipo_tran > @i_codtrn
         and (tc_causa_org) >= @i_causa
          or (tc_tipo_tran = @i_codtrn and tc_secuencial > @i_orden)
       order by tc_tipo_tran, tc_secuencial, tc_causa_org

      set rowcount 0
   end

if @i_operacion = 'T'

   begin
      set rowcount 20

      select 'TRAN'         = tc_tipo_tran,
             'DESCRIPCION'  = substring(tc_descripcion,1,50),
             'SIGNO'        = tc_credeb,
             'CAUSA ORIG'   = substring(tc_causa_org,1,3),
             'CAUSA DEST'   = tc_causa_dst,
             'INDICADOR'    = tc_indicador,
             'CAMPO A CONT' = substring(tc_contabiliza,1,17),
             'ESTADO'       = tc_estado,
             'PERFIL'       = tc_perfil,
             'FECHA'        = convert(varchar(10),tc_fecha,@i_formato_fecha),
             'INDICE'       = tc_indice,
             'REF INT'      = tc_secuencial,
	     'PROD BANC'    = tc_prod_banc,
	     'CLASE'        = tc_clase,
	     'TOTALIZA'     = tc_totaliza
        from cob_remesas..re_tran_contable
       where tc_producto = @i_prod
         and tc_causa_org >= @i_causa
         and tc_tipo_tran = @i_codtrn
         and tc_secuencial > @i_orden
       order by tc_secuencial

      set rowcount 0
   end

/* Ayuda para Consultas */
if @i_operacion = 'H' 
   begin
     select tn_descripcion
       from cobis..cl_ttransaccion
      where tn_trn_code = @i_codigo

     if @@rowcount = 0
       begin
        /* No existe cheque de camara */
        exec cobis..sp_cerror
             @t_debug     = @t_debug,
             @t_file      = @t_file,
             @t_from      = @w_sp_name,
             @i_num       = 101001
        return 1
      end
   end

if @i_operacion = 'C'

   begin
      set rowcount 20

	  -- Julio 4 2002 Adriana Rodriguez   Validacion de cuasal numerica o alfabetica
      if @t_trn = 50 or @t_trn = 264

      select 'TRAN'         = tc_tipo_tran,
             'DESCRIPCION'  = substring(tc_descripcion,1,50),
             'SIGNO'        = tc_credeb,
             'CAUSA ORIG'   = substring(tc_causa_org,1,3),
             'CAUSA DEST'   = tc_causa_dst,
             'INDICADOR'    = tc_indicador,
             'CAMPO A CONT' = substring(tc_contabiliza,1,17),
             'ESTADO'       = tc_estado,
             'PERFIL'       = tc_perfil,
             'FECHA'        = convert(varchar(10),tc_fecha,@i_formato_fecha),
             'INDICE'       = tc_indice,
             'REF INT'      = tc_secuencial,
	     'PROD BANC'    = tc_prod_banc,
	     'CLASE'        = tc_clase,
	     'TOTALIZA'     = tc_totaliza
        from cob_remesas..re_tran_contable
       where tc_producto = @i_prod
         and convert(int, tc_causa_org) = convert(int,@i_causa)+500
         and tc_tipo_tran = @i_codtrn
         and tc_secuencial > @i_orden
       order by tc_tipo_tran, tc_secuencial, tc_causa_org
     else
      select 'TRAN'         = tc_tipo_tran,
             'DESCRIPCION'  = substring(tc_descripcion,1,50),
             'SIGNO'        = tc_credeb,
             'CAUSA ORIG'   = substring(tc_causa_org,1,3),
             'CAUSA DEST'   = tc_causa_dst,
             'INDICADOR'    = tc_indicador,
             'CAMPO A CONT' = substring(tc_contabiliza,1,17),
             'ESTADO'       = tc_estado,
             'PERFIL'       = tc_perfil,
             'FECHA'        = convert(varchar(10),tc_fecha,@i_formato_fecha),
             'INDICE'       = tc_indice,
             'REF INT'      = tc_secuencial,
	     'PROD BANC'    = tc_prod_banc,
	     'CLASE'        = tc_clase,
	     'TOTALIZA'     = tc_totaliza
        from cob_remesas..re_tran_contable
       where tc_producto = @i_prod
         and tc_causa_org = @i_causa
         and tc_tipo_tran = @i_codtrn
         and tc_secuencial > @i_orden
       order by tc_tipo_tran, tc_secuencial, tc_causa_org


      set rowcount 0
   end

return 0


GO


