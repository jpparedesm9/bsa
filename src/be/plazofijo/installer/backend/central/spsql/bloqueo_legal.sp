/************************************************************************/
/*      Archivo:                bloqueolegal.sp                         */
/*      Stored procedure:       sp_bloqueo_legal                        */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Ximena Cartagena                        */
/*      Fecha de documentacion: 07/Mar/05                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa procesa el mantenimiento de los bloqueos legales  */
/*      realizados sobre las operaciones de plazo fijo                  */
/*      Insercion de pf_bloqueo_legal                                   */
/*      Consulta de bloqueos                                            */
/*      Levantamiento de bloqueos                                       */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR                RAZON                           */
/*      07-Mar-05  Gabriela Arboleda    Emision Inicial DP0065 GB       */
/*      2005/10/18 Carlos Cruz D.       Se consulta el oficial principal*/
/*                                      del DPF                         */
/*      2005/11/17 Luis Im              Se añade total int. embdo       */
/*      03-Ago-06  Ricardo Ramos        Anadir campo de fideicomiso     */
/*      13/08/2009 JuanB Quinche        Adaptacion MSSQLServer          */
/*      09/08/2016 Nidia Silva          Se agrega operacion A           */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_bloqueo_legal')
   drop proc sp_bloqueo_legal
go
create proc sp_bloqueo_legal (
@s_ssn                        int        = null,
@s_user                       login      = null,
@s_term                       varchar(30)    = null,
@s_date                       datetime   = null,
@s_sesn                       int        = NULL,
@s_srv                        varchar(30)    = null,
@s_lsrv                       varchar(30)    = null,
@s_ofi                        smallint   = null,
@s_rol                        smallint   = NULL,
@t_debug                      char(1)    = 'N',
@t_file                       varchar(10)    = null,
@t_from                       varchar(32)    = null,
@t_trn                        smallint   = null,
@i_operacion                  char(1),
@i_op_num_banco               cuenta     = NULL,
@i_bl_operacion               int        = NULL,
@i_bl_valor_embgdo_juzgado    money      = NULL,
@i_bl_valor_embgdo_banco      money      = NULL,
@i_bl_valor_int_embgdo_banco  money      = NULL,
@i_bl_tipo_bloq_legal         catalogo   = NULL,
@i_bl_fecha_oficio            datetime   = NULL,
@i_bl_num_oficio              varchar(30)    = NULL,
@i_bl_autoridad               varchar(64)    = NULL,
@i_bl_usuario                 login      = NULL,
@i_bl_observacion             varchar(64)    = null,
@i_bl_motivo_blqlegal         catalogo   = NULL,
@i_modifico_fp                tinyint    = 0,
@i_bl_secuencial              tinyint    = NULL,
@i_canal                      char(1)        = NULL,
@i_formato_fecha              int        = 0,
@i_ente                       int        = null
)
with encryption
as
declare         
   @w_sp_name                    varchar(32),
   @w_bl_secuencial              tinyint,
   @w_moneda                     tinyint,
   @w_monto_disponible           money,
   @w_monto_int_disponible       money,
   @w_op_monto_int_blqlegal      money,
   @w_historia                   smallint,
   @w_numdeci                    tinyint,
   @w_usadeci                    char(1),
   @w_funcionario                login,   
   @w_op_ente                    int,
   @w_op_descripcion             descripcion,
   @w_op_oficial                 login,
   @w_op_oficial_nombre          descripcion,
   @w_op_estado                  catalogo, --GAR para validar el estado
   @w_op_monto                   money,
   @w_op_oficial_principal       login,     --ccr se consulta el oficial principal
   @w_op_fideicomiso             varchar(15),
   -----------------------------------------------
   -- Variables para la forma de pago temporal
   -----------------------------------------------
   @w_pt_beneficiario            int,
   @w_sec1                       smallint,
   @w_pt_tipo                    catalogo,
   @w_pt_forma_pago              catalogo,
   @w_pt_cuenta                  cuenta,   
   @w_pt_monto                   money,
   @w_pt_porcentaje              float,
   @w_pt_fecha_crea              datetime, 
   @w_pt_fecha_mod               datetime,
   @w_pt_moneda_pago             smallint,
   @w_pt_descripcion             descripcion,
   @w_pt_oficina                 int,
   @w_pt_tipo_cliente            char(1),
   @w_pt_tipo_cuenta_ach         char(1),
   @w_pt_banco_ach               descripcion,
   @w_pt_cod_banco_ach           smallint,      --LIM 21/NOV/2005
   -----------------------------------------
   -- Variables para datos de bloqueo
   -----------------------------------------
   @w_bl_valor_embgdo_juzgado    money,
   @w_bl_valor_embgdo_banco      money,
   @w_bl_valor_int_embgdo_banco      money,
   @w_bl_tipo_bloq_legal         catalogo,
   @w_bl_fecha_oficio            datetime,
   @w_bl_num_oficio              varchar(20),
   @w_bl_autoridad               varchar(64),
   @w_bl_usuario                 login,
   @w_bl_fecha_crea              datetime,
   @w_bl_observacion             varchar(64),
   @w_bl_motivo_blqlegal         catalogo,

   @w_op_monto_blqlegal          money,
   @w_op_bloqueo_legal           char(1),
   @w_tot_int_embdo              money,          --LIM 17/NOV/2005
   @w_fecha_bloqueo              datetime,       --LIM 17/NOV/2005
   @w_tran_activa                char(1)         -- GAL 24/AGO/2009 - RVVUNICA

-------------------------------
-- Inicializaci¢n
-------------------------------
select 
   @w_sp_name     = 'sp_bloqueo_legal',
   @w_tran_activa = 'N'                          -- GAL 24/AGO/2009 - RVVUNICA
--------------------------------------
-- Verificaci¢n de Transacciones
--------------------------------------
if   (@t_trn <> 14157 or @i_operacion <> 'I') and
     (@t_trn <> 14539 or @i_operacion <> 'S') and
     (@t_trn <> 14344 or @i_operacion <> 'D') and 
	 (@t_trn <> 14539 or @i_operacion <> 'A')
begin
   exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 141112
          return 141112 
end


if @t_debug = 'S' print 'ENTRA A boqueo_legal @s_ofi' + cast (@s_ofi as varchar)

--------------------------------------
-- Para que WorkFlow env¡e la cuenta
--------------------------------------
if @i_op_num_banco is NOT NULL 
begin
   select @i_bl_operacion = op_operacion
   from   pf_operacion
   where  op_num_banco = @i_op_num_banco 

   if @i_operacion = 'D' and @i_canal = 'W'
   begin
      select @i_bl_secuencial = bl_secuencial
        from pf_bloqueo_legal
       where  bl_operacion  = @i_bl_operacion
         and  bl_num_oficio = @i_bl_num_oficio --CVA Oct-27-05
   end 
end

--------------------------------------
-- Valores de la operaci¢n
--------------------------------------
select @w_moneda            = op_moneda,
       @w_monto_disponible  = op_monto_pg_int - (isnull(op_monto_blq,0) + isnull(op_monto_pgdo,0) + isnull(op_monto_blqlegal,0)),
       @w_monto_int_disponible   = isnull(op_total_int_estimado,0) - isnull((select isnull(sum((isnull(bl_valor_int_embgdo_banco,0) - isnull(bl_valor_int_embgdo_aplicado,0)) ),0) from cob_pfijo..pf_bloqueo_legal where bl_operacion = pf.op_operacion and bl_estado = 'I'),0) - isnull(op_total_int_pagados,0),
       @w_historia          = op_historia,
       @w_op_monto_blqlegal = isnull(op_monto_blqlegal,0),
       @w_op_oficial        = op_oficial,
       @w_op_ente           = op_ente,
       @w_op_descripcion    = op_descripcion,
       @w_op_estado         = op_estado, --GAR GB-DP00022
       @w_op_monto          = op_monto_pg_int,
       @w_op_oficial_principal  = op_oficial_principal,
       @w_op_fideicomiso     = op_fideicomiso,
       @w_op_monto_int_blqlegal = isnull(op_monto_int_blqlegal,0)
from   pf_operacion pf
where  op_operacion = @i_bl_operacion
if @@rowcount =0
begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141051
   return 141051    
end
--------------------------------------
-- Parametro de decimales
--------------------------------------
select @w_usadeci = mo_decimales
from cobis..cl_moneda
where mo_moneda = @w_moneda

if @w_usadeci = 'S'
begin
        select @w_numdeci = isnull (pa_tinyint,0)
        from cobis..cl_parametro
        where pa_nemonico = 'DCI'
          and pa_producto = 'PFI'
end
else
        select @w_numdeci = 0

-------------------------------------
-- Obtiene el funcionario
-------------------------------------
If @i_operacion = 'I' or @i_operacion = 'D'
begin
   select @w_funcionario = fu_login
   from   cobis..cl_funcionario
   where  fu_login = @s_user
   if @@rowcount <> 1
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141058
      return 141058 
   end
end
-------------------------------
-------------------------------
--INSERCION
-------------------------------
-------------------------------
If @i_operacion = 'I'
begin
   -----------------------------------------
   -- Verifica que no tenga fideicomiso relacionada
   -----------------------------------------
   if @w_op_fideicomiso is not null
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141219
         return 141219
   end   
   -----------------------------------------
   -- Verifica el estado de la operacion GAR GB-DP00022
   -----------------------------------------
   if @w_op_estado <> 'VEN' and @w_op_estado <> 'ACT'
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141181
         return 141181  
   end
   -------------------------------------
   -- Obtiene el secuencial
   -------------------------------------
   select @w_bl_secuencial = isnull ( max ( bl_secuencial ),0 ) + 1
   from   pf_bloqueo_legal
   where  bl_operacion  = @i_bl_operacion
   ------------------------------------------------
   -- Valida que el monto a bloquear no sobrepase
   -- El monto disponible
   ------------------------------------------------
   if @i_bl_valor_embgdo_banco > @w_monto_disponible
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141069
         return 141069  
   end

   -- Valida que el monto de interés a bloquear no sobrepase
   -- El monto de interés disponible
   ------------------------------------------------
   if @i_bl_valor_int_embgdo_banco > @w_monto_int_disponible
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141069
         return 141069
   end


   BEGIN TRAN
   
   select @w_tran_activa = 'S'                 -- GAL 24/AGO/2009 - RVVUNICA

if @t_debug = 'S' print 'INSETANDO boqueo_legal @s_ofi' + cast (@s_ofi as varchar)

   -------------------------------------
   -- Inserta el bloqueo
   -------------------------------------
   insert into pf_bloqueo_legal (bl_operacion,
                                 bl_secuencial,
                                 bl_valor_embgdo_juzgado,
                                 bl_valor_embgdo_banco,
                                 bl_tipo_bloq_legal,
                                 bl_fecha_oficio,
                                 bl_num_oficio,
                                 bl_autoridad,
                                 bl_usuario,
                                 bl_fecha_crea,
                                 bl_fecha_mod,
                                 bl_observacion,
                                 bl_motivo_blqlegal,
                                 bl_valor_int_embgdo_banco,
                                 bl_estado,
                                 bl_oficina,
                                 bl_ente)
   values(                       @i_bl_operacion,
                                 @w_bl_secuencial,
                                 @i_bl_valor_embgdo_juzgado,
                                 @i_bl_valor_embgdo_banco,
                                 @i_bl_tipo_bloq_legal,
                                 @i_bl_fecha_oficio,
                                 @i_bl_num_oficio,
                                 @i_bl_autoridad,
                                 @i_bl_usuario,
                                 @s_date,
                                 @s_date,
                                 @i_bl_observacion,
                                 @i_bl_motivo_blqlegal,
		    		 @i_bl_valor_int_embgdo_banco ,
                                 @i_operacion,
                                 @s_ofi,
                                 @i_ente)
   if @@error <> 0
   begin
      exec cobis..sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 143055

      return 143055 
   end
   -------------------------------------
   -- Inserta la transaccion de servicio
   -------------------------------------
   insert ts_bloqueo_legal
   (secuencial,           tipo_transaccion,           clase,
   usuario,               terminal,                   srv,
   lsrv,                  fecha,                      operacion,
   bl_secuencial,         valor_juzgado,              valor_banco,
   tipo,                  fecha_oficio,               num_oficio,
   autoridad,             bl_usuario,                 fecha_crea,
   fecha_mod,             observacion,                motivo,
   valor_int_banco,       oficina,                    ente) 
   values 
   (@s_ssn,               @t_trn,                      'N',
   @s_user,               @s_term,                     @s_srv,
   @s_lsrv,               @s_date,                     @i_bl_operacion,
   @w_bl_secuencial,      @i_bl_valor_embgdo_juzgado,  @i_bl_valor_embgdo_banco,
   @i_bl_tipo_bloq_legal, @i_bl_fecha_oficio,          @i_bl_num_oficio,
   @i_bl_autoridad,       @i_bl_usuario,               @s_date,
   @s_date,               @i_bl_observacion,           @i_bl_motivo_blqlegal,
   @i_bl_valor_int_embgdo_banco,@s_ofi,                @i_ente) 
   if @@error <> 0
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 143005

      return 143005 
   end
   -------------------------------------
   -- Inserta Historia
   -------------------------------------
   insert pf_historia 
   (hi_operacion,    hi_secuencial,              hi_fecha,
   hi_trn_code,      hi_valor,                   hi_funcionario,
   hi_oficina,       hi_observacion,             hi_fecha_crea,
   hi_fecha_mod,     hi_cupon) 
   values 
   (@i_bl_operacion, @w_historia,                @s_date,
    @t_trn,          isnull(@i_bl_valor_embgdo_banco,0) + isnull(@i_bl_valor_int_embgdo_banco,0) ,   @w_funcionario,
    @s_ofi,          @i_bl_observacion,          @s_date,
    @s_date,         0)
   if @@error <> 0
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 143006

      return 143006 
   end
   ----------------------------------------------------
   -- Actualiza la operaci¢n bloqueada legalmente
   ----------------------------------------------------
   update pf_operacion 
   set op_bloqueo_legal = 'S',
       op_monto_blqlegal = isnull(op_monto_blqlegal, 0) + round(@i_bl_valor_embgdo_banco, @w_numdeci),
       op_monto_int_blqlegal = isnull(op_monto_int_blqlegal, 0) + round(@i_bl_valor_int_embgdo_banco, @w_numdeci),
       op_historia = @w_historia + 1
   where op_operacion = @i_bl_operacion
   if @@error <> 0
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 145001

      return 145001 
   end
end
--------------------
--------------------
-- LEVANTAMIENTO
--------------------
--------------------
If @i_operacion = 'D'
begin

   -------------------------------------
   -- Busca el registro de bloqueo legal
   -------------------------------------
   select @w_bl_secuencial           =bl_secuencial,
          @w_bl_valor_embgdo_juzgado =bl_valor_embgdo_juzgado,
          @w_bl_valor_embgdo_banco   =bl_valor_embgdo_banco,
          @w_bl_valor_int_embgdo_banco   =bl_valor_int_embgdo_banco,
          @w_bl_tipo_bloq_legal      =bl_tipo_bloq_legal,
          @w_bl_fecha_oficio         =bl_fecha_oficio,
          @w_bl_num_oficio           =bl_num_oficio,
          @w_bl_autoridad            =bl_autoridad,
          @w_bl_usuario              =bl_usuario,
          @w_bl_fecha_crea           =bl_fecha_crea,
          @w_bl_motivo_blqlegal      =bl_motivo_blqlegal
   from   pf_bloqueo_legal
   where  bl_operacion = @i_bl_operacion
     and  bl_secuencial = @i_bl_secuencial
   if @@rowcount = 0   
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141176
      return 141176 
   end
   
   BEGIN TRAN
   
   select @w_tran_activa = 'S'                   -- GAL 24/AGO/2009 - RVVUNICA
   -------------------------------------
   -- Elimina el bloqueo Legal
   -------------------------------------
   update pf_bloqueo_legal
   set	  bl_estado   	= @i_operacion
   where  bl_operacion 	= @i_bl_operacion
   and    bl_secuencial = @i_bl_secuencial

   if @@error <> 0
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 149092
      return 149092 
   end
   -------------------------------------
   -- Inserta la transaccion de servicio
   -------------------------------------
   insert ts_bloqueo_legal
   (secuencial,           tipo_transaccion,           clase,
   usuario,               terminal,                   srv,
   lsrv,                  fecha,                      operacion,
   bl_secuencial,         valor_juzgado,              valor_banco,
   tipo,                  fecha_oficio,               num_oficio,
   autoridad,             bl_usuario,                 fecha_crea,
   fecha_mod,             observacion,                motivo,
   valor_int_banco,	  oficina) 
   values 
   (@s_ssn,               @t_trn,                      'B',
   @s_user,               @s_term,                     @s_srv,
   @s_lsrv,               @s_date,                     @i_bl_operacion,
   @i_bl_secuencial,      @w_bl_valor_embgdo_juzgado,  @w_bl_valor_embgdo_banco,
   @w_bl_tipo_bloq_legal, @w_bl_fecha_oficio,          @w_bl_num_oficio,
   @w_bl_autoridad,       @w_bl_usuario,               @s_date,
   @s_date,               @i_bl_observacion,           @w_bl_motivo_blqlegal,
   @w_bl_valor_int_embgdo_banco, @s_ofi   ) 
   if @@error <> 0
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 143005
      return 143005 
   end
   -------------------------------------
   -- Inserta Historia
   -------------------------------------
   insert pf_historia 
   (hi_operacion,    hi_secuencial,              hi_fecha,
   hi_trn_code,      hi_valor,                   hi_funcionario,
   hi_oficina,       hi_observacion,             hi_fecha_crea,
   hi_fecha_mod,     hi_cupon) 
   values 
   (@i_bl_operacion, @w_historia,                @s_date,
    @t_trn,           isnull(@w_bl_valor_embgdo_banco,0) + isnull(@w_bl_valor_int_embgdo_banco,0),   @w_funcionario,
    @s_ofi,          @i_bl_observacion,          @s_date,
    @s_date,         0)
   if @@error <> 0
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 143006
      return 143006 
   end
   ----------------------------------------------------
   -- Levanta el bloqueo de la operaci¢n 
   ----------------------------------------------------
   select @w_op_monto_blqlegal =  @w_op_monto_blqlegal - round(@w_bl_valor_embgdo_banco, @w_numdeci)
   select @w_op_monto_int_blqlegal =  @w_op_monto_int_blqlegal - round(@w_bl_valor_int_embgdo_banco, @w_numdeci)

   if @w_op_monto_blqlegal = 0  and @w_op_monto_int_blqlegal = 0
      select @w_op_bloqueo_legal  = 'N'
   else
      select @w_op_bloqueo_legal  = 'S'


   select @w_monto_disponible = @w_monto_disponible + @w_op_monto_blqlegal 
   select @w_monto_int_disponible = @w_monto_int_disponible + @w_op_monto_int_blqlegal 

   update pf_operacion 
   set op_bloqueo_legal = @w_op_bloqueo_legal,
       op_monto_blqlegal = @w_op_monto_blqlegal,
       op_monto_int_blqlegal = @w_op_monto_int_blqlegal,
       op_historia = @w_historia + 1
   where op_operacion = @i_bl_operacion
   if @@error <> 0
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 145001
--    ROLLBACK TRAN
      return 145001 
   end

end   

if @i_operacion = 'A'
begin
     select @w_op_oficial_nombre = fu_nombre
     from cobis..cl_funcionario
     where fu_login = @w_op_oficial_principal --ccr se consulta el oficial principal   
 
 
     select 'SECUENCIAL'              = bl_secuencial,
            'NUM. CLIENTE'            = @w_op_ente,
            'TITULAR PRINCIPAL'       = @w_op_descripcion,
            'OFICIAL DEPOSITO'        = @w_op_oficial_nombre,
            'SALDO CAPITAL'           = @w_op_monto,
            'MONTO SOLICITADO'        = bl_valor_embgdo_juzgado,
            'MONTO BLOQUEADO'         = bl_valor_embgdo_banco,
            'MONTO PENDIENTE'         = bl_valor_embgdo_juzgado - bl_valor_embgdo_banco,
            'TIPO BLOQUEO'            = bl_tipo_bloq_legal,
            'ORDENANTE'               = bl_autoridad,
            'FECHA REGISTRO'          = convert(varchar(10),bl_fecha_oficio,@i_formato_fecha),
            'DOCUMENTO'               = bl_num_oficio,
            'INTERES BLOQUEADO'       = isnull(@w_tot_int_embdo,0),                          
            'USUARIO'                 = (select fu_nombre from cobis..cl_funcionario where fu_login = a.bl_usuario),
            'FECHA BLOQUEO'           = convert(varchar(10),bl_fecha_crea, @i_formato_fecha),
            'OBSERVACION'             = bl_observacion        
     from pf_bloqueo_legal a
     where bl_operacion = @i_bl_operacion
     order by bl_secuencial
 
     return 0
end
----------------------------------------------------
----------------------------------------------------
-- CONSULTA LOS BLOQUEOS LEGALES
----------------------------------------------------
----------------------------------------------------
if @i_operacion = 'S'
begin
   select @w_op_oficial_nombre = fu_nombre
   from   cobis..cl_funcionario
   where  fu_login = @w_op_oficial_principal --ccr se consulta el oficial principal
   
    select @w_fecha_bloqueo =  bl_fecha_crea
    from pf_bloqueo_legal
    where bl_operacion = @i_bl_operacion
    
    /*LIM 17/NOV/2005*/     
    select @w_tot_int_embdo = sum(mm_valor) from pf_mov_monet
     where mm_operacion = @i_bl_operacion
       and mm_producto = 'JUDIC'
       and mm_tran in (14912,14905)
       and mm_fecha_aplicacion > = @w_fecha_bloqueo
     
    if (isnull(@w_tot_int_embdo,0) = 0)
    begin
        select @w_tot_int_embdo = sum(dp_monto)
        from pf_det_pago
        where dp_operacion =  @i_bl_operacion
          and dp_forma_pago = 'JUDIC'
          and dp_estado = 'I'
          and dp_estado_xren = 'N'
    end 

if @t_debug = 'S' print ' i_bl_operacion ' + cast (@i_bl_operacion as varchar)    
    
   /*LIM Hasta aqui*/
   select 'SECUENCIAL'                            = bl_secuencial,
          'NUM. CLIENTE'                          = @w_op_ente,
          'TITULAR PRINCIPAL'                     = @w_op_descripcion,
          'OFICIAL DEPOSITO'                      = @w_op_oficial_nombre,
          'SALDO CAPITAL'                         = @w_op_monto,
          'MONTO DEL SECUESTRO/EMBARGO'           = bl_valor_embgdo_juzgado,
          'MONTO SECUESTRADO/EMBARGADO'           = bl_valor_embgdo_banco,
          'MONTO INTERES SECUESTRADO/EMBARGADO'   = bl_valor_int_embgdo_banco,
          'MONTO PNDTE. SECUESTRO/EMBARGO'        = bl_valor_embgdo_juzgado - bl_valor_embgdo_banco - bl_valor_int_embgdo_banco,
          'TIPO BLOQUEO'                          = bl_tipo_bloq_legal,
          'AUTORIDAD ORDENANTE'                   = bl_autoridad,
          'FECHA OFICIO'                          = convert(varchar(10),bl_fecha_oficio, @i_formato_fecha),
          'NUMERO DE OFICIO'                      = bl_num_oficio,
          --'MONTO TOTAL SECUES./EMB.'              = @w_op_monto_blqlegal,
          'INTERES TOTAL EMB.'                    = isnull(bl_valor_int_embgdo_banco,0),     --LIM 17/NOV/2005
          'LOGIN USUARIO'                         = UT.fu_nombre,
          'MOTIVO'                                = a.valor,       --KTA GB-GAPDP00012
          'FECHA BLOQUEO LEGAL'                   = convert(varchar(10),bl_fecha_crea, @i_formato_fecha), --KTA GB-GAPDP00012
          'OBSERVACION'                           = bl_observacion, --KTA GB-GAPDP00012
          'SALDO DISPONIBLE'                      = @w_monto_disponible,
          'ENTE'                                  = bl_ente,
          'DESC. ENTE'                            = (select (select case when en_subtipo = 'C' then en_nomlar else en_nombre + p_p_apellido + p_s_apellido  end)    from cobis..cl_ente where en_ente = B.bl_ente)

   from   pf_bloqueo_legal B,
          cobis..cl_funcionario UT,
          cobis..cl_catalogo a, 
          cobis..cl_tabla b
   where  bl_operacion = @i_bl_operacion
     and  UT.fu_login  = bl_usuario
     and  b.tabla      = 'pf_motivo_blq_legal'
     and  b.codigo     = a.tabla
     and  a.codigo     = bl_motivo_blqlegal
end


   if @w_tran_activa = 'S'       -- GAL 24/AGO/2009 - RVVUNICA
      COMMIT TRAN
      
   return 0
go
