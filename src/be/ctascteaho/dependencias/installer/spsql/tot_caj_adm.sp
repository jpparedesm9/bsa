/************************************************************************/
/*      Archivo           :  tot_caj_adm.sp                             */
/*      Stored procedure  :  sp_tr_tot_caj_adm                          */
/*      Base de datos     :  cob_cuentas                                */
/*      Producto          :  Cuentas Corrientes                         */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*                                                                      */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      29/06/2016      Ignacio Yupa            Dependencias Ahorros    */   
/************************************************************************/
use cob_cuentas
go

SET QUOTED_IDENTIFIER OFF
go
SET ANSI_NULLS OFF
go
IF OBJECT_ID('sp_tr_tot_caj_adm') IS NOT NULL
BEGIN
    DROP PROCEDURE sp_tr_tot_caj_adm
    IF OBJECT_ID('sp_tr_tot_caj_adm') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE sp_tr_tot_caj_adm >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE sp_tr_tot_caj_adm >>>'
END
go
create proc sp_tr_tot_caj_adm (
    @s_ssn      int,
    @s_srv          varchar(30),
    @s_lsrv         varchar(30),
    @s_user     varchar(30),
    @s_sesn         int=null,
    @s_term     varchar(10),
    @s_date     datetime,
    @s_ofi      smallint,   /* Localidad origen transaccion */
    @s_rol      smallint,
    @s_org_err  char(1) = null, /* Origen de error: [A], [S] */
    @s_error    int = null,
    @s_sev          tinyint = null,
    @s_msg      varchar(240)    = null,
    @s_org      char(1),
    @t_corr     char(1) = 'N',
    @t_ssn_corr int = null, /* Trans a ser reversada */
    @t_debug    char(1) = 'N',
    @t_file     varchar(14) = null,
    @t_from     varchar(32) = null,
    @t_rty      char(1) = 'N',
    @t_trn      smallint,
    @i_mon      tinyint,
    @i_caj      varchar(64),
    @i_rol      smallint,
    @i_ofi      smallint,
        @i_tran         smallint,
        @i_proc         char(1),
        @i_grupo        tinyint,
        @i_nivel    tinyint = null
)
as
declare @w_return   int,
    @w_sp_name  varchar(30),
    @w_filial   tinyint,
    @w_oficina  smallint,
    @w_oficial  tinyint,
    @w_producto tinyint,
    @w_server_rem   varchar(64),
    @w_server_local varchar(64),
    @w_tipo     char(1)
    
/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_tr_tot_caj_adm'

/*  Modo de debug  */


exec @w_return = cobis..sp_parametros 
            @t_debug    = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @s_lsrv         = @s_lsrv,
            @i_nom_producto = 'CUENTA CORRIENTE',
            @o_oficina  = @w_oficina out,
            @o_producto     = @w_producto out
            
if @w_return != 0
    return @w_return

select @w_server_local = @s_lsrv

/************************************************************************/
/* Inicia el proceso para obtencion de la consulta */

if @t_trn != 90
begin
  /* Error en codigo de transaccion */
   exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num   = 201048
   return 201048
end

if not exists (
        select  cj_operador
          from  cob_remesas..re_caja
         where  cj_oficina = @i_ofi
           and  cj_operador = @i_caj
           and  cj_rol = @i_rol)
begin
  /* Cajero no registrado en esta oficina */
   exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 201063
   return 201063
end

if @i_proc = 'N'
begin
   set rowcount  0 
   
   select distinct gr_nivel 
   from cob_remesas..re_grupo
   where gr_nivel = 0
   
   if @@rowcount = 0
   begin
       exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 201063
       return 201063
   end    
end   
else
    if @i_proc = 'G' or @i_proc = 'P'
    begin
        set rowcount 1

       /*select tg_grupo, gr_descripcion
         from cob_remesas..re_trn_grupo,
              cob_remesas..re_grupo
        where tg_grupo > @i_grupo
          and tg_grupo = gr_grupo
        order by tg_grupo*/
    
        select gr_nivel,
               gr_grupo,
               gr_descripcion
        from cob_remesas..re_grupo
        where gr_nivel = @i_nivel
          and gr_grupo > @i_grupo
        order by gr_nivel,gr_grupo    

       if @i_proc = 'P'
          select 'Trans'                 = cj_transaccion,
                 'NOMBRE DE TRANSACCION' = substring(convert(varchar(5),cj_transaccion),1,30),
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

         set rowcount 0
    end
    else
    begin
    set rowcount 20

      /* Envio de resultados al Front End */
       select 'TRANS '                = cj_transaccion,
              'NOMBRE DE TRANSACCION' = substring(tn_descripcion,1,30),
              'NUMERO'                = cj_numero,
              'EFECTIVO'              = cj_efectivo,
          'CHEQUES PROPIOS '      = cj_cheque,
          'CHEQUES LOCALES '      = cj_chq_locales,
          'CHEQUES OTRAS PLAZAS'  = cj_chq_ot_plaza,
          'OTROS'                 = cj_otros,
          'INTERESES'             = cj_interes,
          'AJUSTE DE INTERESES'   = cj_ajuste_int,
          'AJUSTE DE CAPITAL'     = cj_ajuste_cap,
              'TOTAL   '              = cj_efectivo +
                                    cj_cheque +
                                    cj_chq_locales +
                                    cj_chq_ot_plaza +
                                    cj_otros +
                                    cj_interes +
                                    cj_ajuste_int +
                                    cj_ajuste_cap,
          'SIGNO'                 = tg_afecta_efectivo + tg_afecta_signo
         from cob_remesas..re_caja,
              cobis..cl_ttransaccion,
              cob_remesas..re_trn_grupo
         where cj_oficina = @i_ofi
          and cj_moneda = @i_mon
          and cj_rol = @i_rol
          and cj_operador = @i_caj
          and cj_transaccion > @i_tran 
          and cj_transaccion = tg_transaccion 
          and tg_grupo = @i_grupo
          and tg_nivel = @i_nivel   
          and tn_trn_code = cj_transaccion 
          and cj_numero > 0

       set rowcount 0
    end

return 0
go
IF OBJECT_ID('sp_tr_tot_caj_adm') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE sp_tr_tot_caj_adm >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE sp_tr_tot_caj_adm >>>'
go
SET ANSI_NULLS OFF
go
SET QUOTED_IDENTIFIER OFF
go
