/****************************************************************************/
/*     Archivo:     rem_consulcar.sp                                        */
/*     Stored procedure: sp_rem_consulcar                                   */
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
           where  name = 'sp_rem_consulcar')
  drop proc sp_rem_consulcar
go
SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

CREATE proc sp_rem_consulcar (
    @s_ssn          int,
    @s_srv          varchar(30),
    @s_lsrv         varchar(30),
    @s_user         varchar(30),
    @s_sesn         int=null,
    @s_term         varchar(10),
    @s_date         datetime,
    @s_ofi          smallint,   /* Localidad origen transaccion */
    @s_rol          smallint,
    @s_org_err      char(1) = null, /* Origen de error: [A], [S] */
    @s_error        int = null,
    @s_sev          tinyint = null,
    @s_msg          mensaje = null,
    @s_org          char(1),
    @t_corr         char(1) = 'N',
    @t_ssn_corr     int = null, /* Trans a ser reversada */
    @t_debug        char(1) = 'N',
    @t_file         varchar(14) = null,
    @t_from         varchar(32) = null,
    @t_rty          char(1) = 'N',
    @t_trn          smallint,
    @p_lssn         int = null,
    @p_rssn         int = null,
    @p_rssn_corr    int = null,
    @p_envio        char(1) = 'N',
    @p_rpta         char(1) = 'N',
    @i_secuen       int,
    @i_mon          tinyint,
    @i_consulta     char(1),
    @i_status       varchar(20),
    @i_ref          int,
    @i_vez          tinyint,
    @i_operacion    char(1) = 'Q',
    @o_existe       char(1) = null out ,
    @o_via_banco    char(1) = 'N' out 
)
as
declare @w_return   int,
    @w_sp_name      varchar(30),
    @w_des_corr     varchar(30),
    @w_des_prop     varchar(30),
    @w_des_emi      varchar(30),
    @w_dias_ret     tinyint,
    @w_corres       char(12),
    @w_propie       char(12),
    @w_emisor       char(12),
    @w_estado       char(1),
    @w_fecha_emi    smalldatetime,
    @w_fecha_efe    smalldatetime,
    @w_oficina      int,
    @w_ofi_bco      smallint,
    @w_banco        smallint,
    @w_parroquia    int,
    @w_num_cheques  tinyint,
    @w_valor        money,
    @w_bco_p        smallint,
    @w_ofi_p        smallint,
    @w_par_p        int,
    @w_bco_c        smallint,
    @w_ofi_c        smallint,
    @w_par_c        int,
    @w_prod_desc    char(3),
    @w_producto     tinyint,
    @w_ctadep       cuenta,
    @w_cta          int,
    @w_cheque_rec   int,
    @w_codigo       smallint,
    @w_ciudad_ofi   int,
    @w_ciudad       int,
    @w_confirmar    char(1),
    @w_estadoq      char(1),
    @w_estadoq1     char(1),
    @w_codbco       tinyint 
        
/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_rem_consulcar'

/* Chequeo de errores generados remotamente */
if @s_org_err is not null           /*  Error del Sistema  */
begin
   exec cobis..sp_cerror
   @t_from         = @w_sp_name,
   @i_num          = @s_error,
   @i_sev          = @s_sev,
   @i_msg          = @s_msg
   return 1
end

/* Valida datos */
if @i_secuen = 0
begin
   exec cobis..sp_cerror
   @t_from   = @w_sp_name,
   @i_num    = 351003
   return 1
end

--Codigo propio de compensacion
select @w_codbco = pa_tinyint
from   cobis..cl_parametro 
where  pa_nemonico = 'CBCO' 
and    pa_producto = 'CTE'

if @@rowcount <> 1
begin
   exec cobis..sp_cerror
   @t_from         = @w_sp_name,
   @i_num          = 201196
   return 201196
end


select @o_existe = 'N'
if exists (select dc_status from cob_remesas..re_det_carta 
           where  dc_carta    = @i_secuen
           and    dc_moneda   = @i_mon
           and    dc_status in ('D','B'))
   select @o_existe = 'S'

if not exists (select 1
               from   cob_cuentas..cc_centro_canje, 
                      cob_cuentas..cc_ofi_centro
               where  ca_oficina = @s_ofi
               and    oc_centro  = ca_sec)
begin               
   exec cobis..sp_cerror
   @t_from     = @w_sp_name,
   @i_num      = 351003,
   @i_msg      = 'OFICINA NO ES CENTRO DE CANJE'
   return 351003
end

select @w_estadoq = '', @w_estadoq1 = ''
if @i_operacion = 'A'
   select @w_estadoq = 'N'
else
   if @i_operacion = 'N'
      select @w_estadoq = 'A'
   else
      if @i_operacion = 'C'
         select @w_estadoq = 'A', @w_estadoq1 = 'C'

if @i_operacion = 'Q'
begin
    select @w_banco       = ct_banco_e,
           @w_ofi_bco     = ct_oficina_e,
           @w_parroquia   = ct_ciudad_e,
           @w_bco_p       = ct_banco_p,
           @w_ofi_p       = ct_oficina_p,
           @w_par_p       = ct_ciudad_p,
           @w_bco_c       = ct_banco_c,
           @w_ofi_c       = ct_oficina_c,
           @w_par_c       = ct_ciudad_c,
           @w_fecha_efe   = ct_fecha_efe,
           @w_fecha_emi   = ct_fecha_emi,
           @w_estado      = ct_estado,
           @w_oficina     = ct_oficina,
           @w_num_cheques = ct_num_cheques,
           @w_valor       = ct_valor
    from   cob_remesas..re_carta
    where  ct_carta      = @i_secuen
    and    ct_moneda     = @i_mon
    and    ((ct_oficina_e = @s_ofi  and ct_banco_c <> @w_codbco)
         or (ct_banco_c = @w_codbco and ct_oficina_e in 
         (select oc_oficina from cob_cuentas..cc_centro_canje,  cob_cuentas..cc_ofi_centro
          where  oc_centro  = ca_sec and ca_oficina = @s_ofi)))
end
else
begin
 /* Obtiene datos de la Carta */  
    select @w_banco       = ct_banco_e,
           @w_ofi_bco     = ct_oficina_e,
           @w_parroquia   = ct_ciudad_e,
           @w_bco_p       = ct_banco_p,
           @w_ofi_p       = ct_oficina_p,
           @w_par_p       = ct_ciudad_p,
           @w_bco_c       = ct_banco_c,
           @w_ofi_c       = ct_oficina_c,
           @w_par_c       = ct_ciudad_c,
           @w_fecha_efe   = ct_fecha_efe,
           @w_fecha_emi   = ct_fecha_emi,
           @w_estado      = ct_estado,
           @w_oficina     = ct_oficina,
           @w_num_cheques = ct_num_cheques,
           @w_valor       = ct_valor
    from   cob_remesas..re_carta
    where  ct_carta      = @i_secuen
    and    ct_moneda     = @i_mon
    and    ((ct_fecha_emi < @s_date and ct_banco_c = @w_codbco)
         or (ct_fecha_emi <= @s_date and ct_banco_c <> @w_codbco and @i_operacion = 'N')
         or (ct_fecha_emi < @s_date and ct_banco_c <> @w_codbco and @i_operacion = 'C'))
    and    ((ct_oficina_e = @s_ofi  and ct_banco_c <> @w_codbco)
         or (ct_oficina_c = @s_ofi  and ct_banco_c = @w_codbco))
    and    ct_estado in (@w_estadoq, @w_estadoq1)
    and    (ct_estado <> 'C' or (ct_estado = 'C' and ct_fecha_efe = @s_date))
end
if @@rowcount <> 1
begin
   exec cobis..sp_cerror
   @t_from         = @w_sp_name,
   @i_num          = 351003
   return 1
end

/* Obtiene codigo de tabla para Tipos de Cheque Remesa */
select @w_codigo = codigo
from   cobis..cl_tabla
where  tabla = 're_tcheque'

if @i_vez = 1
begin
   /* Obtiene numero de cheques y valor de la carta solo para Consultas */
   if @i_consulta = 'S'
   begin
      select @w_num_cheques = count(*)
      from   cob_remesas..re_det_carta
      where  dc_carta = @i_secuen

      select @w_valor = sum(dc_valor)
      from   cob_remesas..re_det_carta
      where  dc_carta = @i_secuen
   end

   /* Obtiene Ciudad de la Oficina de la Carta */
   select @w_ciudad = of_ciudad
   from  cobis..cl_oficina
   where of_oficina = @w_oficina

   /* Formateo de codigos de banco(2), oficina(3) y parroquia(6) */
   select @w_corres = right(('0000' + convert(varchar(4),@w_bco_c)),4)
                    + right(('0000' + convert(varchar(4),@w_ofi_c)),4)
                    + right(('0000' + convert(varchar(4),@w_par_c)),4)
   select @w_propie = right(('0000' + convert(varchar(4),@w_bco_p)),4)
                    + right(('0000' + convert(varchar(4),@w_ofi_p)),4)
                    + right(('0000' + convert(varchar(4),@w_par_p)),4)
   select @w_emisor = right(('0000' + convert(varchar(4),@w_banco)),4)
                    + right(('0000' + convert(varchar(4),@w_ofi_bco)),4)
                    + right(('0000' + convert(varchar(4),@w_parroquia)),4)
 
   /* Obtiene descripciones de banco Corresponsal, Propietario y Emisor */
   select @w_des_corr = ba_descripcion
   from  cob_remesas..re_transito,
         cob_remesas..re_banco
   where tn_banco_c      = @w_bco_c
   and   tn_oficina_c    = @w_ofi_c
   and   tn_ciudad_c  = @w_par_c
   and   tn_banco_c      = ba_banco

   select @w_des_prop = ba_descripcion
   from   cob_remesas..re_banco
   where  ba_banco       = @w_bco_p

   select @w_des_emi = ob_descripcion
   from   cob_remesas..re_ofi_banco
   where  ob_banco      = @w_banco
   and    ob_oficina    = @w_ofi_bco
   and    ob_ciudad  = @w_parroquia

   /* Determina dias de retencion */
   select @w_dias_ret = tn_num_dias
   from cob_remesas..re_transito
   where tn_banco_p      = @w_bco_p
   and   tn_oficina_p    = @w_ofi_p
   and   tn_ciudad_p  = @w_par_p
   
   if @w_bco_c <> @w_codbco
      select @o_via_banco = 'S'

   /* Envia los datos de la carta al front end de Cobis */
   select 
   'corresponsal'       = @w_corres,
   'nombre corres'      = @w_des_corr,
   'propietario'        = @w_propie,
   'nombre propie'      = @w_des_prop,
   'emisor'             = @w_emisor,
   'nombre emisor'      = @w_des_emi,
   'dias de retencion'  = @w_dias_ret,
   'fecha efectiva'     = convert(varchar(10),@w_fecha_efe, 101),
   'nro de cheques'     = @w_num_cheques,
   'valor de carta'     = @w_valor,
   'estado de la carta' = @w_estado,
   'fecha emision'      = convert(varchar(10),@w_fecha_emi, 101)
end
-- Fin Primera Vez

set rowcount 40
/* Envio de los cheques de la Carta */
select 
'CTA GIRADA' = dc_cta_girada,
'CTA DEPOS'  = substring(dc_cta_depositada,1,13),
'PRODUCTO'   = dc_producto,
'CHEQUE'     = dc_num_cheque,
'VALOR'      = dc_valor,
'ESTADO'     = substring(c.valor,1,15), 
'No.REM'     = dc_cheque,
'SUB-ESTADO' = a.valor, --dc_sub_estado,
'CAUSA'      = dc_causa_blo,
'REMESA'     = dc_tipo_rem,
'PROPIETARIO'= right(('0000' + convert(varchar(4),dc_banco_p)),4)
                  + right(('0000' + convert(varchar(4),dc_oficina_p)),4)
                  + right(('0000' + convert(varchar(4),dc_ciudad_p)),4),
'FECHA EFEC.'= convert(varchar(10),dc_fecha_efe,101)
from cobis..cl_catalogo c, cob_remesas..re_det_carta     
   left join cobis..cl_catalogo a
on   dc_sub_estado  = a.codigo      
where dc_carta     = @i_secuen
and   c.tabla = (select cobis..cl_tabla.codigo
                   from cobis..cl_tabla
                  where tabla = 're_tcheque')
and   dc_status    = c.codigo
and   a.tabla = (select cobis..cl_tabla.codigo
                   from cobis..cl_tabla
                  where tabla = 're_sub_estado')
and   (( c.valor     > @i_status )  or ( c.valor     = @i_status and dc_cheque > @i_ref ))
order by c.valor, dc_cheque

set rowcount 0

select @o_existe 
select @o_via_banco 

return 0


GO


