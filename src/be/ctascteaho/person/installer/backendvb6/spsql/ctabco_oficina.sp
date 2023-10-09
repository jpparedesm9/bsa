/****************************************************************************/
/*     Archivo:     ctabco_oficina.sp                                       */
/*     Stored procedure: sp_ctabco_oficina                                  */
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
           where  name = 'sp_ctabco_oficina')
  drop proc sp_ctabco_oficina
go


SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_ctabco_oficina (
    @s_ssn                int,
    @s_srv                varchar(30),
    @s_lsrv               varchar(30),
    @s_user               varchar(30),
    @s_sesn               int,
    @s_term               varchar(10),
    @s_date               datetime,
    @s_ofi                smallint,    /* Localidad origen transaccion */
    @t_trn                smallint,
    @i_operacion          char(1),
    @i_oficina            smallint = 0,
    @i_compensa           char(1)  = null,
    @i_banco              smallint = null,
    @i_cuenta             varchar(10) = null
)
as
declare @w_sp_name      varchar(20)

select @w_sp_name = 'sp_ctabco_oficina'

if @t_trn not in (696, 697)
begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
    @t_from    = @w_sp_name,
    @i_num     = 201048
    return 201048
end

if @i_operacion = 'S'
begin
   set rowcount 20
   
   select
   'OFICINA' = co_oficina,
   'DESC OFI'= (select of_nombre from cobis..cl_oficina where of_oficina = x.co_oficina),
   'COMPENSA'= co_compensa,
   'BCO'     = co_banco,
   'NOMBRE'  = (select substring(ba_descripcion,1,40) from cob_remesas..re_banco where ba_banco = x.co_banco and ba_estado = 'V'),
   'CUENTA'  = (select pcc_cuenta from cob_sbancarios..sb_ctas_comercl where pcc_nemonico = x.co_refer ),
   'NEMONICO'= co_refer
   from  re_compensa_ofi x
   where co_oficina > @i_oficina
   
   set rowcount 0
end

if @i_operacion = 'I'
begin
   if (isnull(@i_oficina, 0) = 0 or @i_compensa is null )
   begin
       /* Faltan datos obligatorios*/
       exec cobis..sp_cerror
       @t_from    = @w_sp_name,
       @i_num     = 351002
       return 351002
   end
   
   if @i_compensa = 'N' and (isnull(@i_banco, 0) = 0 or @i_cuenta is null)
   begin
       /* Faltan datos obligatorios*/
       exec cobis..sp_cerror
       @t_from    = @w_sp_name,
       @i_num     = 351002
       return 351002
   end

   if exists (select 1 from re_compensa_ofi
              where co_oficina = @i_oficina)
   begin
       /* Registro ya existe*/
       exec cobis..sp_cerror
       @t_from    = @w_sp_name,
       @i_num     = 351047
       return 351047
   end
   insert into re_compensa_ofi (
   co_oficina, co_compensa, co_banco, co_refer)
   values (
   @i_oficina, @i_compensa, @i_banco, @i_cuenta)
   
   if @@error <> 0
   begin
       /* Error en insercion de registro*/
       exec cobis..sp_cerror
       @t_from    = @w_sp_name,
       @i_num     = 353014
       return 353014
   end
end

if @i_operacion = 'U'
begin
   if (isnull(@i_oficina, 0) = 0 or @i_compensa is null)
   begin
       /* Faltan datos obligatorios*/
       exec cobis..sp_cerror
       @t_from    = @w_sp_name,
       @i_num     = 351002
       return 351002
   end
   
   if @i_compensa = 'N' and (isnull(@i_banco, 0) = 0 or @i_cuenta is null)
   begin
       /* Faltan datos obligatorios*/
       exec cobis..sp_cerror
       @t_from    = @w_sp_name,
       @i_num     = 351002
       return 351002
   end
   

   update re_compensa_ofi set
   co_compensa = @i_compensa, 
   co_banco    = @i_banco, 
   co_refer    = @i_cuenta
   where co_oficina = @i_oficina
   
   if @@error <> 0 or @@rowcount <> 1
   begin
       /* Error en insercion de registro*/
       exec cobis..sp_cerror
       @t_from    = @w_sp_name,
       @i_num     = 355020
       return 355020
   end
end

if @i_operacion = 'D'
begin
   if isnull(@i_oficina, 0) = 0
   begin
       /* Faltan datos obligatorios*/
       exec cobis..sp_cerror
       @t_from    = @w_sp_name,
       @i_num     = 351002
       return 351002
   end

   delete re_compensa_ofi
   where co_oficina = @i_oficina
   
   if @@error <> 0
   begin
       /* Error en insercion de registro*/
       exec cobis..sp_cerror
       @t_from    = @w_sp_name,
       @i_num     = 357006
       return 357006
   end
end
--Inserta transaccion de servicio
if @i_operacion <> 'S'
begin
   insert into cob_cuentas..ts_cta_cons_bco (
   secuencial,  tipo_tran,   oficina,   usuario,       terminal,
   origen,      nodo,        fecha,     tipo,          banco,
   referencia,  operacion)                                         
   values (                                            
   @s_ssn,      @t_trn,      @s_ofi,    @s_user,       @s_term,
   'U',         @s_lsrv,     @s_date,   @i_compensa,   @i_banco,
   @i_cuenta,   @i_operacion)
   
   if @@error <> 0
   begin
       /* ERROR EN INSERCION DE TRANSACCION DE SERVICIO */
       exec cobis..sp_cerror
       @t_from    = @w_sp_name,
       @i_num     = 352010
       return 352010
   end
end
return 0


GO


