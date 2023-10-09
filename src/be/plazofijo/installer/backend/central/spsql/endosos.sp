/************************************************************************/
/*  Archivo               : inendosos.sp                                */
/*  Stored procedure      : sp_endosos                                  */
/*  Base de datos         : cobis                                       */
/*  Producto              : Plazo Fijo                                  */
/*  Disenado por          : Luis Angel Gaitan                           */
/*  Fecha de documentacion: 19-Mar-98                                   */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*                          PROPOSITO                                   */
/*  Este programa mueve la informacion de las tablas temporales         */
/*  de operaciones de plazo fijo nuevas a las tablas definitivas        */
/*  realizando la funcion completa de endoso del titulo                 */
/*  insertando en la tabla pf_endosos la historia del titulo endoso     */
/*                          MODIFICACIONES                              */
/*  21-Ago-01  Memito Saborfo     Se agregan campo usuario a tabla      */
/*                                pf_mov_monet .                        */
/*  10-08-2016 N. Silva           Corecciones e indentacion             */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where  name = 'sp_endosos')
   drop proc sp_endosos
go

create proc sp_endosos (
       @s_ssn                           int             = NULL,
       @s_user                          login           = NULL,
       @s_term                          varchar(30)     = NULL,
       @s_date                          datetime        = NULL,
       @s_sesn                          int             = NULL,
       @s_srv                           varchar(30)     = NULL,
       @s_lsrv                          varchar(30)     = NULL,
       @s_ofi                           smallint        = NULL,
       @s_rol                           smallint        = NULL,
       @t_trn                           smallint        = NULL,
       @t_debug                         char(1)         = 'N',
       @i_cuenta                        cuenta,
       @i_operacion                     char(1),
       @i_retieneimp                    char(1)         = 'N',
       @i_empresa                       tinyint         = 1)
with encryption
as
declare @w_sp_name                      varchar(32),
        @w_return                       int,
        @w_ced_ruc                      numero,
        @w_comentario                   varchar(32),
        @w_operacionpf                  int,
        @w_toperacion                   catalogo,
        @w_num_oficial                  int,
        @w_money                        money,
        @w_total_monet                  money,
        @w_clase                        char(1),
        @w_telefono                     char(12),
        @w_sec                          int,
        @w_siguiente                    int,
        @w_titular_endoso               int,
        @w_num_dias                     smallint,
        @w_nombre                       varchar(100),

/* VARIABLES NECESARIAS PARA PF_OPERACION Y PF_OPERACION_TMP */
        @w_num_banco                    cuenta,
        @w_p_ente                       int,
        @w_oficina                      smallint,
        @w_numdoc                       smallint,
        @w_monto                        money,
        @w_historia                     smallint,
        @w_p_fecha_crea                 datetime,
        @o_siguiente                    int,

/* VARIABLES NECESARIAS PARA PF_BENEFICIARIO PF_BENEFICIARIO_TMP */
        @w_bt_ente                      int,
        @w_bt_rol                       catalogo,
        @w_bt_fecha_crea                datetime,
        @w_bt_fecha_mod                 datetime,
        @w_bt_condicion                 char(1),
        @w_moneda                       tinyint,
/* Variables para condicion_tmp  */
        @w_co_condicion                 smallint,
        @w_co_comentario                varchar(60),
        @w_co_fecha_crea                datetime,
        @w_co_fecha_mod                 datetime,
/*  Variables para det_condicion_tmp   */
        @w_dt_condicion                 smallint,
        @w_dt_ente                      int,
        @w_dt_fecha_crea                datetime,
        @w_dt_fecha_mod                 datetime,
        @w_ente1                        int,  --perfil endoso 06-30-2000
        @w_ente2                        int,  --perfil endoso 06-30-2000
        @w_mov_sgte                     smallint, --perfil endoso 06-30-2000
        @w_interes                      money,
        @w_numdeci                      tinyint,
        @w_mon_sgte                     int,
        @w_valor                        money,
        @w_valor_ext                    money,
        @w_valor_mn                     money,
        @w_valor_me                     money,
        @w_perfil                       varchar(10),
        @w_codval                       varchar(20),
        @w_tipo_deposito                tinyint,
        @w_tot_valor_mn                 money,
        @w_tot_valor_me                 money,
        @w_debcred                      char(1),
        @w_tplazo                       catalogo,
        @w_area                         int,
        @w_cotizacion                   money,
        @w_error                        int,
        @w_mm_valor                     money,
        @w_mm_valor_ext                 money,
        @w_descripcion                  descripcion,
        @w_comprobante                  int,
        @w_contador                     smallint,
        @w_usadeci                      char(1),
        @w_subsec                       smallint,
        @w_moneda_base                  tinyint,
        @w_msg                          descripcion,
        @w_valor_cap                    money,
        @w_valor_int                    money,
        @w_embargo                      money,
        @w_bt_tipo                      char(1),
        @v_historia                     int


select @w_sp_name = 'sp_endosos'

select @w_moneda_base = em_moneda_base
from   cob_conta..cb_empresa
where  em_empresa = @i_empresa
if @@rowcount = 0
begin
   exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 601018
   return  1
end

/** LECTURA OFICIAL */
select @w_num_oficial = fu_funcionario 
  from cobis..cl_funcionario
 where fu_login = @s_user

/**  LECTURA DE DATOS DE LA OPERACION DE PLAZO FIJO  **/
select @w_num_banco         = op_num_banco,
       @w_operacionpf       = op_operacion,
       @w_historia          = op_historia,
       @w_p_ente            = op_ente,
       @w_monto             = op_monto,
       --Contab emndoso 06-30-2000
       @w_interes           = op_total_int_ganados - op_total_int_pagados,
       @w_mov_sgte          = op_mon_sgte,
       @w_toperacion        = op_toperacion,
       --Contab emndoso 06-30-2000
       @w_moneda            = op_moneda,
       @w_num_dias          = op_num_dias,
       @w_embargo           = isnull(op_monto_blq, 0) + isnull(op_monto_blqlegal, 0) + isnull(op_monto_pgdo, 0) + isnull(op_monto_int_blqlegal, 0)
from   pf_operacion
where  op_num_banco = @i_cuenta

if @@rowcount = 0
begin
   exec cobis..sp_cerror 
   @t_from   = @w_sp_name, @i_num   = 141004
   return 1
end

Select @w_p_fecha_crea = convert(varchar(130),getdate() ,100)

/* Encuentra parametro de decimales */ --contab endoso 06-30-2000
select @w_usadeci = mo_decimales
from   cobis..cl_moneda
where  mo_moneda = @w_moneda

if @w_usadeci = 'S'
begin
   select @w_numdeci = isnull (pa_tinyint,0)
   from   cobis..cl_parametro
   where  pa_nemonico = 'DCI'
   and    pa_producto = 'PFI'
end
else
   select @w_numdeci = 0    --contab endoso 06-30-2000

if @w_embargo > 0 
begin
   exec cobis..sp_cerror 
        @t_from  = @w_sp_name, 
        @i_num   = 141200
   return 1
end

/**  INSERCION HISTORICO **/
begin tran
insert pf_historia (hi_operacion  , hi_secuencial, hi_fecha,
                    hi_trn_code   , hi_valor     , hi_funcionario,
                    hi_oficina    , hi_fecha_crea, hi_fecha_mod)
            values (@w_operacionpf, @w_historia  , @s_date,
                    @t_trn        , @w_monto     , @s_user, 
                    @s_ofi        , @s_date      , @s_date)

if @@error <> 0
begin
   exec cobis..sp_cerror 
      @t_from = @w_sp_name,   
      @i_num  = 143006
   select @w_return = 1
   rollback
   goto borra
end

/** fin insercion historico en pf_historia**/
select @v_historia = @w_historia
select @w_historia = @w_historia +1

/*seleccionamos de la cl_det_producto el numero de producto para cancelarlo*/
update cobis..cl_det_producto
   set dp_estado_ser = 'E' 
 where dp_cuenta     = @w_num_banco

----------------------------------------------------- 
-- Generacion para secuencial de detalle de producto
----------------------------------------------------- 
exec cobis..sp_cseqnos 
     @t_from      = @w_sp_name,
     @i_tabla     = 'cl_det_producto',
     @o_siguiente = @w_siguiente        out

-- Creacion registro detalle de producto
insert into cobis..cl_det_producto 
            (dp_det_producto, dp_filial    , dp_oficina,
             dp_producto    , dp_tipo      , dp_moneda,
             dp_fecha       , dp_comentario, dp_monto,
             dp_tiempo      , dp_cuenta    , dp_estado_ser,
             dp_autorizante , dp_oficial_cta)
     values (@w_siguiente   , 1            , @s_ofi,
             14             , 'R'          , @w_moneda,
             @s_date        , 'ENDOSO'     , @w_monto,
             @w_num_dias    , @w_num_banco , 'V',
             @w_num_oficial , @w_num_oficial)

select @w_return = 0
select @w_co_condicion = 0
select @w_bt_ente=0

while 1 = 1
begin
   set rowcount 1
   select @w_bt_ente        = be_ente,
          @w_ente1          = be_ente,   --perfil endoso 06-30-2000
          @w_bt_rol         = be_rol,
          @w_bt_fecha_crea  = be_fecha_crea,
          @w_bt_fecha_mod   = be_fecha_mod
   from   pf_beneficiario
   where  be_ente        > @w_bt_ente
   and    be_operacion   = @w_operacionpf
   order by be_ente
   
   if @@rowcount = 0
      break

   if not exists(select 1 from pf_endoso_prop where en_operacion = @w_operacionpf and en_ente = @w_bt_ente  and en_fecha_crea = @w_p_fecha_crea)
   begin
      insert into pf_endoso_prop
             (en_operacion  , en_ente   , en_rol   , en_fecha_crea,
              en_historia)
      values (@w_operacionpf, @w_bt_ente, @w_bt_rol, @w_p_fecha_crea,
              @v_historia)
      
      if @@error <> 0
      begin
          exec cobis..sp_cerror 
               @t_from = @w_sp_name,
               @i_num  = 143045             /*numero de transaccion*/
          select @w_return = 1
          goto borra
      end
   end

   set rowcount 1
   select @w_co_condicion   = dc_condicion
   from   pf_det_condicion
   where  dc_operacion   = @w_operacionpf
   and    dc_ente        = @w_bt_ente
   order by dc_condicion

   if @@rowcount > 0
   begin   
      if not exists(select 1 from pf_endoso_cond where ec_operacion = @w_operacionpf and ec_ente = @w_bt_ente  and ec_fecha_crea = @w_p_fecha_crea)
      begin
         /*INSERT DEL REG EN  pf_endoso PARA EL CONTROL DE LOS ENDOSOS*/
         insert into pf_endoso_cond
                (ec_operacion  , ec_ente   , ec_fecha_crea  , ec_condicion)
         values (@w_operacionpf, @w_bt_ente, @w_p_fecha_crea, @w_co_condicion)
         
         if @@error <> 0
         begin
            exec cobis..sp_cerror 
                 @t_from = @w_sp_name,
                 @i_num  = 143045 /*numero de transaccion*/
            select @w_return = 1
            goto borra
         end
      end
   end
end /** WHILE  1 */

set rowcount 0

delete pf_beneficiario
where  be_operacion = @w_operacionpf
if @@error <> 0
begin
   select @w_return=1
   goto borra
end

-- borrar las condiciones anteriores
delete from   pf_condicion
where  cd_operacion = @w_operacionpf

--borrar el detalle condiciones anteriores
delete from   pf_det_condicion
where  dc_operacion  = @w_operacionpf


/** INSERCION DE BENEFICIARIOS **/
select @w_bt_ente = 0
while 1 = 1
begin
   set rowcount 1
   
   select @w_bt_ente        = bt_ente,
          @w_ente2          = bt_ente,  --perfil endoso 06-30-2000
          @w_bt_rol         = bt_rol,
          @w_bt_fecha_crea  = bt_fecha_crea,
          @w_bt_fecha_mod   = bt_fecha_mod,
          @w_bt_condicion   = bt_condicion,
          @w_bt_tipo        = bt_tipo
   from   pf_beneficiario_tmp
   where  bt_usuario     = @s_user
   and    bt_sesion      = @s_sesn
   and    bt_ente        > @w_bt_ente
   and    bt_operacion   = @w_operacionpf
   order by bt_ente
   
   if @@rowcount = 0
      break

   set rowcount 0

   /**  INSERCION DEFINITIVA DE BENEFICIARIOS DE ESE PLAZO FIJO  **/
   exec @w_sec = sp_gen_sec
   exec @w_return = sp_beneficiario
        @s_ssn         = @w_sec,
        @s_user        = @s_user,
        @s_term        = @s_term,
        @s_date        = @s_date,
        @s_srv         = @s_srv,
        @s_lsrv        = @s_lsrv,
        @s_ofi         = @s_ofi,
        @s_rol         = @s_rol,
        @t_trn         = 14109,
        @i_operacion   = 'I',
        @i_cuenta      = @w_num_banco,
        @i_ente        = @w_bt_ente,
        @i_rol         = @w_bt_rol,
        @i_condicion   = @w_bt_condicion
   
   if @w_return <> 0
   begin
      select @w_return = 1
      goto borra
   end

   /**  BUSQUEDA DE NUMERO DE CEDULA DEL BENEFICIARIO  **/ 
   select @w_ced_ruc = en_ced_ruc
   from   cobis..cl_ente
   where  en_ente = @w_bt_ente
   
   /**  CREACION DE REGISTRO DE CLIENTES  **/
   if @w_bt_tipo = 'T' begin
      insert cobis..cl_cliente
             (cl_cliente,  cl_det_producto, cl_rol,
              cl_ced_ruc,  cl_fecha)
      values (@w_bt_ente,  @w_siguiente   , @w_bt_rol,
              @w_ced_ruc,  @w_p_fecha_crea)
   
      if @@error <> 0
      begin
         exec cobis..sp_cerror 
              @t_from   = @w_sp_name, 
              @i_num    = 703028
              
         select @w_return = 1
         goto borra
      end
   end
end /** WHILE  1 */

set rowcount 0

/*   Insercion a tablas definitivas de condicion y detalle   */
select @w_co_condicion = 0
while 4 = 4
begin
   set rowcount 1
   
   select @w_co_condicion   = ct_condicion,
          @w_co_comentario  = ct_comentario,
          @w_co_fecha_crea  = ct_fecha_crea,
          @w_co_fecha_mod   = ct_fecha_mod
   from   pf_condicion_tmp
   where  ct_usuario     = @s_user
   and    ct_sesion      = @s_sesn
   and    ct_condicion   > @w_co_condicion
   and    ct_operacion   = @w_operacionpf
   order by ct_condicion
   
   if @@rowcount = 0
      break
   set rowcount 0
   
   insert pf_condicion (cd_operacion   , cd_condicion  , cd_comentario,
                        cd_fecha_crea  , cd_fecha_mod  , cd_estado_xren,
                        cd_estado)
                values (@w_operacionpf ,@w_co_condicion, @w_co_comentario,
                        @w_p_fecha_crea,@w_p_fecha_crea, 'N',
                        'I')       /*@w_estado_xren=N*/
   
   if @@error <> 0
   begin
      exec cobis..sp_cerror 
           @t_from = @w_sp_name,   
           @i_num  = 143016
      select @w_return = 1
      goto borra
   end

   insert into ts_condicion 
          (secuencial      , tipo_transaccion, clase,
           fecha           , usuario         , terminal,
           srv             , lsrv            , operacion,
           condicion       , comentario      , fecha_crea,
           fecha_mod)
   values (@s_ssn          , @t_trn          , 'N', 
           @w_p_fecha_crea , @s_user         , @s_term,
           @s_srv          , @s_lsrv         , @w_operacionpf,
           @w_co_condicion , @w_co_comentario, @w_p_fecha_crea,
           @w_p_fecha_crea)
   
   if @@error <> 0
   begin
      exec cobis..sp_cerror 
           @t_from = @w_sp_name,
           @i_num  = 143005
      select @w_return = 1
      goto borra
   end

   select @w_dt_ente = 0
   while 5=5
   begin
      set rowcount 1
      select @w_dt_ente       = dt_ente,
             @w_dt_fecha_crea = dt_fecha_crea,
             @w_dt_fecha_mod  = dt_fecha_mod
      from   pf_det_condicion_tmp
      where  dt_usuario       = @s_user
      and    dt_sesion        = @s_sesn
      and    dt_operacion     = @w_operacionpf
      and    dt_ente          > @w_dt_ente
      and    dt_condicion     = @w_co_condicion
      order by dt_ente
      
      if @@rowcount = 0
         break

      set rowcount 0
      insert pf_det_condicion
            (dc_operacion    , dc_condicion   , dc_ente,
             dc_fecha_crea   , dc_fecha_mod   , dc_estado_xren,
             dc_estado)      
      values (@w_operacionpf , @w_co_condicion, @w_dt_ente,
              @w_p_fecha_crea, @w_p_fecha_crea, 'N',
              'I')           /*@w_estado_xren=N*/
      
      if @@error <> 0
      begin
         exec cobis..sp_cerror 
              @t_from = @w_sp_name,
              @i_num  = 143017
         select @w_return = 1
         goto borra
      end

      insert into ts_det_condicion 
             (secuencial    , tipo_transaccion, clase     , fecha,
              usuario       , terminal        , srv       , lsrv,
              operacion     , condicion       , ente      , fecha_crea,
              fecha_mod)                                  
      values (@s_ssn        , @t_trn          , 'N'       , @w_p_fecha_crea,
              @s_user       , @s_term         , @s_srv    , @s_lsrv,
              @w_operacionpf, @w_co_condicion , @w_dt_ente, @w_p_fecha_crea,
              @w_p_fecha_crea)
      
      if @@error <> 0
      begin
         exec cobis..sp_cerror 
              @t_from = @w_sp_name,
              @i_num  = 143005
         select @w_return = 1
         goto borra
      end
   end  /* while 5 */
end  /* While 4  */

/* seleccion de el nombre del cliente**/
select @w_bt_ente        = bt_ente
from   pf_beneficiario_tmp
where  bt_usuario     = @s_user
and    bt_rol         = 'T'

select @w_nombre = p_p_apellido +' '+ p_s_apellido+' '+ cobis..cl_ente.en_nombre
from   cobis..cl_ente 
where  cobis..cl_ente.en_ente = @w_bt_ente


/*  actualiza det pago */
update pf_det_pago
   set dp_ente         = @w_bt_ente
 where dp_operacion    = @w_operacionpf
   and dp_estado     = 'I'
   and dp_forma_pago not in ('AHO', 'CTE','CHG')

if @@error <> 0
begin
   exec cobis..sp_cerror 
   @t_from = @w_sp_name, 
   @i_num  = 143005
   return 1
end


/* ACTUALIZACION DE LA PF_OPERACION*/
update pf_operacion
   set op_historia    = @w_historia,
       op_retienimp   = @i_retieneimp,
       op_descripcion = @w_nombre
where  op_num_banco = @w_num_banco
and    op_ente      = @w_bt_ente
if @@error <> 0
begin
   exec cobis..sp_cerror 
   @t_from = @w_sp_name,  
   @i_num  = 143005
   return 1
end
/*insertar en pf_endosos*/

insert ts_operacion 
       (secuencial     , tipo_transaccion, clase,
        usuario        , terminal        , srv,
        lsrv           , fecha           , num_banco,
        operacion      , ente            , toperacion,
        producto       , oficina         , historia,
        estado         , oficial         , descripcion,
        fecha_mod      , retienimp)
values (@s_ssn         , @t_trn          , 'N',
        @s_user        , @s_term         , @s_srv,
        @s_lsrv        , @w_p_fecha_crea , @w_num_banco,
        @w_operacionpf , @w_bt_ente      , convert(varchar,@w_operacionpf),
        14             , @s_ofi          , @w_historia,
        'ACT'          , @s_user         , 'ENDOSO' ,
        @w_p_fecha_crea, @i_retieneimp)
if @@error <> 0
begin
   exec cobis..sp_cerror 
        @t_from = @w_sp_name,
        @i_num  = 143005
   select @w_return = 1
   goto borra
end

---------------------------
-- Contabilidad de ENDODOS
---------------------------
--Obtiene cotizacion

if @w_moneda <> @w_moneda_base
begin
   set rowcount 1
   
   select @w_cotizacion  = ct_valor
     from cob_conta..cb_cotizacion
     where --ct_empresa = @i_empresa and
       ct_moneda  = @w_moneda
       and ct_fecha   = (select max(ct_fecha)
                         from cob_conta..cb_cotizacion
                         where --ct_empresa = @i_empresa and
                           ct_moneda  = @w_moneda
                           and ct_fecha  <= @s_date)
   set rowcount 0
end
else
   select @w_cotizacion = 1

select @w_cotizacion = isnull(@w_cotizacion, 1)
--Inserta movimiento monetario para contabilizar

if @w_moneda <> @w_moneda_base 
   select  @w_valor = round((@w_monto * @w_cotizacion),@w_numdeci),
   @w_valor_ext = @w_monto
else
   select  @w_valor = @w_monto,
   @w_valor_ext = 0

-- Obtener CAPITAL
insert pf_mov_monet (mm_operacion,           mm_secuencia,           mm_secuencial,
                     mm_sub_secuencia,       mm_producto,            mm_cuenta,
                     mm_tran,                mm_valor,               mm_tipo,
                     mm_beneficiario,        mm_impuesto,            mm_moneda,
                     mm_valor_ext,           mm_fecha_crea,          mm_fecha_mod,
                     mm_estado,              mm_fecha_aplicacion,    mm_impuesto_capital_me, 
                     mm_user,                mm_oficina,             mm_tipo_cliente)
             values (@w_operacionpf,         @w_mov_sgte,            0,
                     1,                      'CEND',                 null ,
                     14149,                  @w_valor,               'B',
                     @w_p_ente,              0,                      @w_moneda,
                     @w_valor_ext,           @s_date,                @s_date,
                     null,                   null,                   0, 
                     @s_user,                @s_ofi,                 'M')

if @@error <> 0
begin
   exec cobis..sp_cerror 
        @t_from = @w_sp_name,  
        @i_num = 143021
   select @w_return = 1
   goto borra
end

exec  @w_return=sp_aplica_mov
      @s_ssn            = @s_ssn,
      @s_user           = @s_user,
      @s_ofi            = @s_ofi,
      @s_date           = @s_date,
      @s_srv            = @s_srv,
      @s_term           = @s_term,
      @t_trn            = 14149,
      @i_operacionpf    = @w_operacionpf,
      @i_fecha_proceso  = @s_date ,
      @i_secuencia      = @w_mov_sgte ,
      @i_tipo           = 'N',
      @i_sub_secuencia  = 1,
      @i_en_linea       = 'S'

if @w_return <> 0
begin
   rollback tran
   return @w_return
end

-- Obtener valor de INTERES
if @w_moneda <> @w_moneda_base
   select @w_valor     = round((@w_interes * @w_cotizacion),@w_numdeci),
          @w_valor_ext = @w_interes
else
   select @w_valor     = @w_interes,
          @w_valor_ext = 0
          
-- Inserta movimiento monetario
insert pf_mov_monet (mm_operacion,             mm_secuencia,         mm_secuencial,
                     mm_sub_secuencia,         mm_producto,          mm_cuenta,           
                     mm_tran,                  mm_valor,             mm_tipo,
                     mm_beneficiario,          mm_impuesto,          mm_moneda,           
                     mm_valor_ext,             mm_fecha_crea,        mm_fecha_mod,
                     mm_estado,                mm_fecha_aplicacion,  mm_impuesto_capital_me, 
                     mm_user,                  mm_usuario,           mm_oficina,
                     mm_tipo_cliente)
             values (@w_operacionpf,           @w_mov_sgte,          0,
                     2,                        'IEND',               null ,
                     14149,                    @w_valor,             'B',
                     @w_bt_ente,               0,                    @w_moneda,
                     @w_valor_ext,             @s_date,              @s_date,
                     null,                     null,                 0, 
                     @s_user,                  @s_user,              @s_ofi,
                     'M')

if @@error <> 0
begin
   exec cobis..sp_cerror 
        @t_from = @w_sp_name,   
        @i_num  = 143021
   select @w_return = 1
   goto borra
end

exec @w_return = sp_aplica_mov
     @s_ssn            = @s_ssn,
     @s_user           = @s_user,
     @s_ofi            = @s_ofi,
     @s_date           = @s_date,
     @s_srv            = @s_srv,
     @s_term           = @s_term,
     @t_trn            = 14149,
     @i_operacionpf    = @w_operacionpf,
     @i_fecha_proceso  = @s_date ,
     @i_secuencia      = @w_mov_sgte ,
     @i_tipo           = 'N',
     @i_sub_secuencia  = 2,
     @i_en_linea       = 'S'

   if @w_return <> 0
   begin
      rollback tran
      return @w_return
   end


/* MVG 19/09/2009 CONTABILIZAR USANDO SP_APLICA_CONTA */
if @w_moneda <> @w_moneda_base
   select  @w_valor_cap = round((@w_monto * @w_cotizacion),@w_numdeci)
else
   select  @w_valor_cap = @w_monto

if @w_moneda <> @w_moneda_base
   select  @w_valor_int = round((@w_interes * @w_cotizacion),@w_numdeci)
else
   select  @w_valor_int = @w_interes

exec @w_error = sp_aplica_conta
     @s_user          = @s_user,
     @s_ofi           = @s_ofi,
     @s_date          = @s_date,
     @s_term          = @s_term,
     @i_fecha         = @s_date,
     @i_tran          = @t_trn,
     @i_operacionpf   = @w_operacionpf,
     @i_afectacion    = 'N',
     @i_valor         = @w_valor_int,
     @i_monto         = @w_valor_cap,
     @i_ente          = @w_p_ente,
     @i_ente_endoso   = @w_bt_ente,
     @o_msg           = @w_msg         out,
     @o_comprobante   = @w_comprobante out

if @w_error <> 0 begin
   if @@trancount > 0 rollback tran
   exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = @w_error
   return  @w_error
   goto borra
end


-- Actualiza secuencial de movimientos monetarios
update pf_operacion
   set op_mon_sgte  = op_mon_sgte + 1
 where op_operacion = @w_operacionpf
 
if @@rowcount <> 1
begin
   print 'ERR en endoso al actualizar pf_operacion!!'
   rollback  tran
   select @w_return = 1
   goto borra
end

------------------------------
-- Contabilizacion de ENDOSOS
------------------------------
NOCONT:  --Contab. Terceros
   commit tran
   goto borra
   
-- Elimina temporales
borra:
  set rowcount 0
  delete pf_beneficiario_tmp  where bt_usuario = @s_user and bt_sesion = @s_sesn
  delete pf_det_cheque_tmp    where ct_usuario = @s_user and ct_sesion = @s_sesn
  delete pf_condicion_tmp     where ct_usuario = @s_user and ct_sesion = @s_sesn
  delete pf_det_condicion_tmp where dt_usuario = @s_user and dt_sesion = @s_sesn
  rollback tran
  return @w_return

go
