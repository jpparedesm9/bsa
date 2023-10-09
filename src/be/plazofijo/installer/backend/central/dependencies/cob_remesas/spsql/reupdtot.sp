/****************************************************************************/
/*     Archivo:            reupdtot.sp                                      */
/*     Stored procedure:   sp_upd_totales                                   */
/*     Base de datos:      cob_remesas                                      */
/*     Producto:           Personalizacion                                  */
/*     Disenado por:       Jorge Baque                                      */
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
           where  name = 'sp_upd_totales')
  drop proc sp_upd_totales
go

SET ANSI_NULLS OFF
go
SET QUOTED_IDENTIFIER OFF
go
CREATE proc sp_upd_totales (
   @i_ofi          smallint,
   @i_rol          smallint,
   @i_user         varchar(30),
   @i_mon          tinyint,
   @i_trn          smallint,
   @i_nodo         descripcion,
   @i_tipo         char(1)    = 'L',
   @i_corr         char(1)    = 'N',
   @i_efectivo     money      = 0,
   @i_cheque       money      = 0,
   @i_chq_locales  money      = 0,
   @i_chq_ot_plaza money      = 0,
   @i_otros        money      = 0,
   @i_interes      money      = 0,
   @i_adj_int      money      = 0,
   @i_adj_cap      money      = 0,
   @i_ssn          int        = 0,
   @i_idcaja       int,
   @i_filial       tinyint,
   @i_saldo_caja   money,
   @i_idcierre     int        = null,
   @i_pit          char(1)    = 'N',   
   @i_causa        varchar(9) = null
)
as

declare 
   @w_return    int,
   @w_sp_name   varchar(30),
   @w_fecha     datetime, 
   @w_factor    int,
   @w_catalogo  varchar(20)
    
/* Captura nombre de Stored Procedure */
select @w_sp_name = 'sp_upd_totales'

select @w_fecha   = fp_fecha
from cobis..ba_fecha_proceso

if @i_corr = 'N'
     select @w_factor = 1
else select @w_factor = -1

 
/*  Actualizacion de totales de cajero  */
if @i_pit = 'N'
begin
   begin tran
end

select @w_catalogo = tg_tabla_catalogo
from   cob_remesas..re_trn_grupo
where  tg_transaccion = @i_trn

if @w_catalogo is null
   select @i_causa = null

if exists (select 1 from cob_remesas..re_caja
           where  cj_filial      = @i_filial    
           and    cj_oficina     = @i_ofi
           and    cj_rol         = @i_rol
           and    cj_operador    = @i_user
           and    cj_moneda      = @i_mon
           and    cj_transaccion = @i_trn 
           and    cj_id_caja     = @i_idcaja 
           and    isnull(cj_causa,'') = isnull(@i_causa,''))
begin
   update cob_remesas..re_caja with (rowlock)
   set
   cj_numero       = cj_numero       + @w_factor, 
   cj_efectivo     = cj_efectivo     + (@i_efectivo * @w_factor),
   cj_cheque       = cj_cheque       + (@i_cheque   * @w_factor),
   cj_chq_locales  = cj_chq_locales  + (@i_chq_locales * @w_factor),
   cj_chq_ot_plaza = cj_chq_ot_plaza + (@i_chq_ot_plaza * @w_factor),
   cj_otros        = cj_otros        + (@i_otros    * @w_factor),
   cj_interes      = cj_interes      + (@i_interes  * @w_factor),
   cj_ajuste_int   = cj_ajuste_int   + (@i_adj_int  * @w_factor),
   cj_ajuste_cap   = cj_ajuste_cap   + (@i_adj_cap  * @w_factor),
   cj_ssn          = @i_ssn
   where cj_filial           = @i_filial  
   and   cj_oficina          = @i_ofi
   and   cj_rol              = @i_rol
   and   cj_operador         = @i_user
   and   cj_moneda           = @i_mon
   and   cj_transaccion      = @i_trn 
   and   cj_id_caja          = @i_idcaja
   and   isnull(cj_causa,'') = isnull(@i_causa,'')
   
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror1
      @t_from   = @w_sp_name,
      @i_num    = 355034,
      @i_pit    = @i_pit
      return 355034
   end
end
else
begin
   insert into cob_remesas..re_caja with (rowlock)
   (
   cj_oficina,      cj_rol,          cj_operador, cj_moneda, 	cj_transaccion,
   cj_numero,       cj_efectivo,     cj_cheque,   cj_otros,		cj_ajuste_int,
   cj_ajuste_cap,   cj_interes,      cj_nodo,     cj_tipo, 		cj_fecha,
   cj_chq_locales,  cj_chq_ot_plaza, cj_ssn,      cj_id_caja, 	cj_id_cierre, 
   cj_filial,       cj_causa)
   values (
   @i_ofi,          @i_rol,          @i_user,    @i_mon,      @i_trn,
   1,               @i_efectivo,     @i_cheque,  @i_otros,    @i_adj_int,
   @i_adj_cap,      @i_interes,      @i_nodo,    @i_tipo,     @w_fecha,
   @i_chq_locales,  @i_chq_ot_plaza, @i_ssn,     @i_idcaja,   @i_idcierre, 
   @i_filial,       @i_causa)
   
   if @@error != 0
   begin
      exec cobis..sp_cerror1
      @t_from   = @w_sp_name,
      @i_num    = 353031,
      @i_pit    = @i_pit
      return 353031
   end
end


-- Afectacion de saldos de caja 
if exists ( select 1 from cob_remesas..re_saldos_caja
            where sc_filial  = @i_filial                   
            and   sc_oficina = @i_ofi
            and   sc_id      = @i_idcaja
            and   sc_moneda  = @i_mon)
begin
   update cob_remesas..re_saldos_caja with (rowlock)
   set
   sc_saldo = @i_saldo_caja
   where sc_filial   = @i_filial
   and   sc_oficina  = @i_ofi
   and   sc_id       = @i_idcaja
   and   sc_moneda   = @i_mon

   if @@error != 0
   begin
      exec cobis..sp_cerror1
      @t_from = @w_sp_name,
      @i_num  = 355033,
      @i_pit    = @i_pit
      return 355033
   end
end
else
begin
   insert  into cob_remesas..re_saldos_caja with (rowlock)
   (sc_filial, sc_oficina, sc_id,     sc_moneda, sc_saldo)
   values
   (@i_filial, @i_ofi,     @i_idcaja, @i_mon,    @i_saldo_caja)

   if @@error != 0
   begin
      exec cobis..sp_cerror1
      @t_from = @w_sp_name,
      @i_num  = 353030,
      @i_pit    = @i_pit
      
      return 353030
   end
end
if @i_pit = 'N'
begin
commit tran
end
return 0


go
