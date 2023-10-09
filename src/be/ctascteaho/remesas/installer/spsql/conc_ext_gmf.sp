/****************************************************************************/
/*     Archivo:     conc_ext_gmf.sp                                         */
/*     Stored procedure: sp_conc_ext_gmf                                    */
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
           where  name = 'sp_conc_ext_gmf')
  drop proc sp_conc_ext_gmf
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

CREATE proc sp_conc_ext_gmf(
@s_ssn           int         = null,
@s_srv           varchar(30) = null,
@s_user          varchar(30) = null,
@s_sesn          int         = null,
@s_term          varchar(10) = null,
@s_date          datetime    = null,
@s_ofi           smallint    = null,        /* Localidad origen transaccion */
@s_rol           smallint    = null,
@p_lssn          int         = null,
@t_corr          char(1)     = 'N',
@t_ssn_corr      int         = null,
@p_rssn_corr     int         = null,
@t_debug         char(1)     = 'N',
@t_file          varchar(14) = null,
@t_from          varchar(32) = null,
@t_rty           char(1)     = 'N',
@s_org           char(1)     = null,
@t_trn           int,
@i_operacion     char(1),
@i_modo          tinyint     = null,
@i_concepto      smallint    = null,
@i_descripc      varchar(65)= null,
@i_tope          char(1)     = null,
@i_vlr_tope      money       = null,
@i_tasa          float       = null,       
@i_producto      tinyint     = null,
@i_tipo_per      char(1)     = null,
@i_titular       char(1)     = null,
@i_otra_exen     char(1)     = null,
@i_desc_nemo     char(5)     = null,
@i_otro_conc     smallint    = null
)
as
declare
@w_sp_name  varchar(30),       /*    @w :  De trabajo */
@w_return   int,               /*    Retorno de ejecucion de procedimientos  */
@w_cedula   char(30),
@w_concepto smallint,
@w_nombre   varchar(65),
@w_error    int

/* Verificacion de la transaccion */
if (@t_trn = 4108 and @i_operacion <> 'C')
or (@t_trn = 4102 and @i_operacion <> 'I')
or (@t_trn = 4103 and @i_operacion <> 'U')
or (@t_trn = 4104 and @i_operacion <> 'D')
begin
   select @w_error = 201048
   goto ERROR
end

/* Valida el producto para la oficina */
if isnull(@s_ofi,0) <> 0
begin
   exec @w_return = cobis..sp_val_prodofi
   @i_modulo   = 4,
   @i_oficina  = @s_ofi
   if @w_return <> 0
      return @w_return
end


/* OPERACION DE CONSULTA */

if (@t_trn = 4108 and @i_operacion = 'C')
begin
   if @i_modo = 0
   begin
      set rowcount 20
      select
      'CPTO.'         = ce_concepto, 
      'DESCRIPCION'   = ce_descripc, 
      'TOPE   '       = ce_tope,     
      'VR.TOPE'       = ce_vlr_tope, 
      'TASA   '       = ce_tasa,     
      'PRODUCTO'      = ce_producto, 
      'PERSONA'       = ce_tipo_per, 
      'TITULAR'       = ce_titular,
      'OTRA EXENTA'   = ce_otra_exen,
      'NEMONICO'      = ce_nemonico,
      'OTRO CONCEP'   = ce_otro_conc
      from  re_concep_exen_gmf  
      order by ce_concepto

      if @@rowcount = 0
      begin
         /* No existen registros */
         select @w_error = 352082
         goto ERROR
      end
   end  --fin modo 0

   if @i_modo = 1
   begin
      set rowcount 20
      select
      'CPTO.'         = ce_concepto, 
      'DESCRIPCION'   = ce_descripc, 
      'TOPE   '       = ce_tope,     
      'VR.TOPE'       = ce_vlr_tope, 
      'TASA   '       = ce_tasa,     
      'PRODUCTO'      = ce_producto, 
      'PERSONA'       = ce_tipo_per, 
      'TITULAR'       = ce_titular,
      'OTRA EXENTA'   = ce_otra_exen,
      'NEMONICO'      = ce_nemonico,
      'OTRO CONCEP'   = ce_otro_conc
      from  re_concep_exen_gmf  
      where ce_concepto > @i_concepto
      order by ce_concepto
   end --fin modo 1
   set rowcount 0
   return 0
end /* Transaccion de consulta */

/* OPERACION DE INGRESO-ACTUALIZACION*/
begin tran

if (@t_trn = 4102 and @i_operacion = 'I')
begin
   select @w_concepto = isnull(max(ce_concepto),0) + 1
   from   re_concep_exen_gmf
   
   if @w_concepto is null
      select @w_concepto = 1

   /* insertar nuevo registro */
   insert into re_concep_exen_gmf (
   ce_concepto,        ce_descripc,        ce_tope,
   ce_vlr_tope ,       ce_tasa,            ce_producto,
   ce_tipo_per,        ce_titular,         ce_otra_exen,
   ce_nemonico,        ce_otro_conc)
   values (
   @w_concepto,        @i_descripc,        @i_tope,
   @i_vlr_tope ,       @i_tasa,            @i_producto,
   @i_tipo_per,        @i_titular,         @i_otra_exen,
   @i_desc_nemo,       @i_otro_conc)

   if @@error <> 0
   begin
      /* Error insertando registro*/
      select @w_error = 352083
      goto ERROR
   end /* Transaccion de  insercion*/
end

/* OPERACION DE MODIFICACION DE ESTADO*/
if (@t_trn = 4103 and @i_operacion = 'U')
begin
   if (select count(1)
       from   re_concep_exen_gmf
       where  ce_concepto = @i_concepto) = 0
   begin
      /* No existe registro*/
      select @w_error = 352082
      goto ERROR
   end

   /* actualizando registro */
   update re_concep_exen_gmf set
   ce_descripc       = @i_descripc, 
   ce_tope           = @i_tope, 
   ce_vlr_tope       = @i_vlr_tope, 
   ce_tasa           = @i_tasa, 
   ce_producto       = @i_producto, 
   ce_tipo_per       = @i_tipo_per, 
   ce_titular        = @i_titular, 
   ce_otra_exen      = @i_otra_exen, 
   ce_nemonico       = @i_desc_nemo,
   ce_otro_conc      = @i_otro_conc
   where ce_concepto = @i_concepto

   if @@error <> 0
   begin
      /* Error actualizacion transaccion*/
      select @w_error = 352084
      goto ERROR
   end
end   /* Transaccion de actualizacion*/

/* OPERACION DE ELIMINACION DE ESTADO*/
if (@t_trn = 4104 and @i_operacion = 'D')
begin
   if (select count(1)
       from   re_concep_exen_gmf
       where  ce_concepto = @i_concepto) = 0
   begin
      /* No existe registro*/
      select @w_error = 352082
      goto ERROR
   end

   /* Eliminando el registro */
   delete re_concep_exen_gmf
   where  ce_concepto = @i_concepto
   
   if @@error <> 0
   begin
      /* Error actualizacion transaccion*/
      select @w_error = 352085
      goto ERROR
   end
end   /* Transaccion de actualizacion*/

insert into cob_remesas..pe_tran_servicio
(ts_secuencial,     ts_tipo_transaccion,   ts_oficina, 
 ts_usuario,        ts_terminal,           ts_fecha_cambio,   
 ts_cuenta,         ts_tipo,               ts_minimo,         
 ts_val_medio,      ts_producto,           ts_tipo_variacion,           
 ts_rol,            ts_operacion,          ts_rubro,
 ts_hora)
values 
(@s_ssn,            @t_trn,                @s_ofi,
 @s_user,           @s_term,               @s_date,
 @i_descripc,       @i_tope,               @i_vlr_tope,
 @i_tasa,           @i_producto,           @i_tipo_per,
 @i_titular,        @i_operacion,          @i_desc_nemo,
 getdate())

if @@error <> 0
begin
   /* Error actualizacion transaccion*/
   select @w_error = 352085
   goto ERROR
end
commit tran
return 0

ERROR:
   exec cobis..sp_cerror
   @t_debug     = @t_debug,
   @t_file      = @t_file,
   @t_from      = @w_sp_name,
   @i_num       = @w_error
   return  @w_error


go


