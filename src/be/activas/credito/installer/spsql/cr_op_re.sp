/***********************************************************************/
/*   Archivo:                   cr_op_re.sp                            */
/*   Stored procedure:          sp_op_renovar                          */
/*   Base de Datos:             cob_credito                            */
/*   Producto:                  Credito                                */
/*   Disenado por:              Myriam Davila                          */
/*   Fecha de Documentacion:    14/Ago/95                              */
/***********************************************************************/
/*                              IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de     */
/*   "MACOSA",representantes exclusivos para el Ecuador de la          */
/*   AT&T                                                              */
/*   Su uso no autorizado queda expresamente prohibido asi como        */
/*   cualquier autorizacion o agregado hecho por alguno de sus         */
/*   usuario sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante                */
/***********************************************************************/
/*                                 PROPOSITO                           */
/*   Este stored procedure permite realizar operaciones DML            */
/*   Search y Query en la tabla cr_op_renovar                          */
/*                                                                     */
/***********************************************************************/
/*                             MODIFICACIONES                          */
/*   FECHA           AUTOR              RAZON                          */
/*   14/Ago/95   Ivonne Ordonez     Emision Inicial                    */
/*   26/Feb/98   Myriam Davila      Nueva opcion de buscar             */
/*   04/Feb/99   S. Hernandez       Busqueda de operacion              */
/*                                  a renovar                          */
/*   14/Sep/99   Ramiro Buitron     Personalizacion                    */
/*                                  Corfinsura                         */
/*   22/May/07   Elcira Pelaez      NR-537-498                         */  
/*   13/Jul/07   Elcira Pelaez      Def 8482 BAC                       */
/*   09/04/2013  A. Munoz           Req. 0353 Alianzas.                */
/***********************************************************************/

use cob_credito
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

if exists (select 1 from sysobjects where name = 'sp_op_renovar')
    drop proc sp_op_renovar
go
create proc sp_op_renovar
   @s_ssn               int      = null,
   @s_user              login    = null,
   @s_sesn              int      = null,
   @s_term              descripcion = null,
   @s_date              datetime = null,
   @s_srv               varchar(30) = null,
   @s_lsrv              varchar(30) = null,
   @s_rol               smallint = null,
   @s_ofi               smallint  = null,
   @s_org_err           char(1) = null,
   @s_error             int = null,
   @s_sev               tinyint = null,
   @s_msg               descripcion = null,
   @s_org               char(1) = null,
   @t_rty               char(1)  = null,
   @t_trn               smallint = null,
   @t_debug             char(1)  = 'N',
   @t_file              varchar(14) = null,
   @t_from              varchar(30) = null,
   @i_operacion         char(1)  = null,
   @i_modo              tinyint = null,
   @i_tramite           int  = null,
   @i_num_operacion     cuenta  = null,
   @i_producto          catalogo  = null,
   @i_abono             money  = null,
   @i_moneda_abono      tinyint  = null,
   @i_monto_original    money = null,
   @i_saldo_original    money = null,
   @i_fecha_concesion   datetime = null,
   @i_toperacion        catalogo = null,
   @i_moneda_original   tinyint  = null,
   @i_aplicar           char(1)  = 'S',  --RBU
   @i_capitaliza        char(1)  = 'N',   --RBU
   @i_saldo_renovar     money    = 0,
   /* campos cca 353 alianzas bancamia --AAMG*/
   @i_crea_ext          char(1)       = null,
   @i_tipo_tramite      char(1)      = null,     -- Req. 436 Normalizacion
   @i_cliente           int          = null,     -- Req. 436 Normalizacion
   @i_numero_op_banco   cuenta       = null,     -- Req. 436 Normalizacion
   @i_grupo             catalogo     = null,     -- Req. 436 Normalizacion
   @i_cuota_prorrogar   int          = null,     -- Req. 436 Normalizacion
   @i_fecha_prorrogar   datetime     = null,     -- Req. 436 Normalizacion
   @o_msg_msv           varchar(255)  = null out
as
declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_tramite            int,
   @w_num_operacion      cuenta,
   @w_producto           catalogo,
   @w_abono              money,
   @w_moneda_abono       tinyint,
   @w_desc_moneda        descripcion,
   @w_monto_original     money,
   @w_saldo_original     money,
   @w_fecha_concesion    datetime,
   @w_toperacion         catalogo,
   @w_moneda_original    tinyint,
   @w_desc_moneda_orig   descripcion,
   @w_monto_inicial      money,
   @w_moneda_inicial     money,
   @w_tramite_ant        int,
   @w_def_moneda         tinyint,
   @w_aplicar            char(1),  --RBU
   @w_capitaliza         char(1),  --RBU   
   @w_nm_tramite         int,      --Req 436 Normalizacion
   @w_nm_cliente         int,      --Req 436 Normalizacion
   @w_nm_operacion       cuenta,   --Req 436 Normalizacion
   @w_nm_tipo_norm       catalogo, --Req 436 Normalizacion
   @w_nm_cuota           int,      --Req 436 Normalizacion
   @w_nm_fecha           datetime  --Req 436 Normalizacion
   
select @w_today = @s_date
select @w_sp_name = 'sp_op_renovar'

--- Verificar si la operacion ya fue asignada a otra renovacion 
if @i_operacion = 'C'
begin
   if exists (select 1
              from   cr_op_renovar, 
                     cr_tramite,
                     cob_cartera..ca_operacion
              where  or_num_operacion = @i_num_operacion
              and    or_tramite       = tr_tramite
              and    tr_tramite       = op_tramite
              and    tr_tipo          in ("R","E")
              and    tr_estado        not in ('Z','X','R','S')
              and    op_estado         in (99,0))
         
   begin
      if @i_crea_ext is null
      begin
         --- Ya existe un tramite con esa operacion 
         exec cobis..sp_cerror
              @t_from  = @w_sp_name,
              @i_num   = 2101097
         return 1 
      end
      else
      begin
         select @o_msg_msv = 'Operacion: ' + @i_num_operacion + ' Asociada a otra renovacion, ' + @w_sp_name
         select @w_return  = 2101097
         return @w_return
      end
   end
end

if @i_operacion = 'K'
begin
   BEGIN TRAN
   
   delete cr_rub_renovar
   from   cr_op_renovar
   where  or_login = @s_user
   and    or_tramite < 0
   and    rr_tramite_re = or_tramite
   
   if @@error <> 0
   begin
      ROLLBACK
      
      if @i_crea_ext is null
      begin
         print 'Error limpiando area de trabajo (det)'
         return 1
      end
      else
      begin
         select @o_msg_msv = 'Error limpiando area de trabajo cr_rub_renovar 1, ' + @w_sp_name
         select @w_return  = 607100
         return @w_return
      end
   end
   
   delete cr_op_renovar
   where  or_login = @s_user
   and    or_tramite < 0
   
   if @@error <> 0
   begin
      ROLLBACK
      
      if @i_crea_ext is null
      begin
         print 'Error limpiando area de trabajo (det)'
         return 1
      end
      else
      begin
         select @o_msg_msv = 'Error limpiando area de trabajo cr_op_renovar 2, ' + @w_sp_name
         select @w_return  = 607100
         return @w_return
      end
   end
   
   --Req 436 Normalizacion
   if @i_tipo_tramite = 'M'
   begin
      delete cob_credito..cr_normalizacion
      where nm_tramite < 0
      and   nm_login = @s_user
      
      if @@error <> 0
      begin
         ROLLBACK
      
         if @i_crea_ext is null
         begin
            print 'Error limpiando area de trabajo (det)'
            return 1
         end
         else
         begin
            select @o_msg_msv = 'Error limpiando area de trabajo cr_normalizacion, ' + @w_sp_name
            select @w_return  = 607100
            return @w_return
         end
      end
   end
   
   COMMIT
end

if @i_operacion = 'U' -- ACTUALIZAR TRAMITE REAL
begin
   BEGIN TRAN
   
   if @i_tramite is null
   begin
      if @i_crea_ext is null
      begin
         print 'cr_op_re.sp Error llego vacio el NRo. de tramite nuevo REVISARRRR'
         return 1
      end
      else
      begin
         select @o_msg_msv = 'Error llego vacio el NRo. de tramite nuevo, ' + @w_sp_name
         select @w_return  = 710391
         return @w_return
      end
   end
   
   update cr_rub_renovar
   set    rr_tramite_re = @i_tramite
   from   cr_op_renovar
   where  or_login = @s_user
   and    or_tramite < 0
   and    rr_tramite_re = or_tramite
   
   if @@error <> 0
   begin
      ROLLBACK
      
      if @i_crea_ext is null
      begin
         print 'Error actualizando tramite real (det)'
         return 1
      end
      else
      begin
         select @o_msg_msv = 'Error actualizando tramite real, Tramite: ' + @i_tramite + ', ' + @w_sp_name
         select @w_return  = 355519
         return @w_return
      end
   end
   
   update cr_op_renovar
   set    or_tramite = @i_tramite
   where  or_login = @s_user
   and    or_tramite < 0
   
   if @@error <> 0
   begin
      ROLLBACK
      
      if @i_crea_ext is null
      begin
         print 'Error actualizando tramite real (det)'
         return 1
      end
      else
      begin
         select @o_msg_msv = 'Error actualizando tramite real, Tramite: ' + @i_tramite + ', ' + @w_sp_name
         select @w_return  = 355519
         return @w_return
      end
   end
   
   --Req 436 Normalizacion
   if @i_tipo_tramite = 'M'
   begin
      update cob_credito..cr_normalizacion
      set nm_tramite = @i_tramite,
          nm_cuota   = @i_cuota_prorrogar,
          nm_fecha   = @i_fecha_prorrogar      
      where nm_tramite < 0
      and   nm_login = @s_user
      
      if @@error <> 0
      begin
         ROLLBACK
      
         if @i_crea_ext is null
         begin
            print 'Error actualizando tramite de normalizacion real (det)'
            return 1
         end
         else
         begin
            select @o_msg_msv = 'Error actualizando tramite de normalizacion real, Tramite: ' + @i_tramite + ', ' + @w_sp_name
            select @w_return  = 355519
            return @w_return
         end
      end
   end
   
   COMMIT
   
   return 0
end

if @i_tramite is null
begin
   select @i_tramite = -op_tramite
   from   cob_cartera..ca_operacion
   where  op_banco = @i_num_operacion
end

-- CHEQUEO DE EXISTENCIAS
if @i_operacion <> 'S' 
begin
   select    @w_tramite = or_tramite,
          @w_num_operacion = or_num_operacion,
          @w_producto = or_producto,
          @w_monto_original = or_monto_original,
          @w_saldo_original = or_saldo_original,
          @w_fecha_concesion = or_fecha_concesion,
          @w_moneda_original = or_moneda_original,
          @w_desc_moneda_orig = b.mo_descripcion,
          @w_toperacion = or_toperacion,
          @w_aplicar    = or_aplicar,     --RBU
          @w_capitaliza = or_capitaliza   --RBU
   from   cob_credito..cr_op_renovar
                    left outer join cobis..cl_moneda b on
                           or_moneda_original = b.mo_moneda                         
                     where or_tramite = @i_tramite
                       and or_num_operacion = @i_num_operacion
                       and or_producto      = @i_producto
   
   if @@rowcount > 0
      select @w_existe = 1
   else
      select @w_existe = 0
end

--- VALIDACION DE CAMPOS NULOS 

if @i_operacion = 'I' or @i_operacion = 'U'
begin
   if @i_tramite is NULL 
   or @i_num_operacion is NULL
   or @i_producto is NULL 
   begin
      if @i_crea_ext is null
      begin
         --- Campos NOT NULL con valores nulos 
         PRINT '@i_tramite %1! @i_num_operacion %2! @i_producto %3!' + cast (@i_tramite as varchar) + cast (@i_num_operacion as varchar )+ cast (@i_producto as varchar)
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file, 
              @t_from  = @w_sp_name,
              @i_num   = 2101001
         return 1 
      end
      else
      begin
         select @o_msg_msv = 'Campos Not NULL con valores nulos, ' + @w_sp_name
         select @w_return  = 2101001
         return @w_return
      end
   end
end

---Insercion del registro 
if @i_operacion = 'I'
begin
   
   -- Seleccion de codigo de moneda local
   SELECT @w_def_moneda = pa_tinyint  
   FROM   cobis..cl_parametro  
   WHERE  pa_nemonico = 'MLOCR'   
   
   if @@rowcount = 0
   begin
      if @i_crea_ext is null
      begin
         -- REGISTRO NO EXISTE
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file, 
              @t_from  = @w_sp_name,
              @i_num   = 2101005
         return 2101005
      end
      else
      begin
         select @o_msg_msv = 'REGISTRO NO EXISTE, ' + @w_sp_name
         select @w_return  = 2101005
         return @w_return
      end
   end
   
   BEGIN TRAN
   
   if @i_tramite is not null
   begin
      delete cr_op_renovar
      where  or_num_operacion = @i_num_operacion
      and    or_tramite       = @i_tramite
   end
   else
   begin
      delete cr_op_renovar
      where  or_num_operacion = @i_num_operacion
      and    or_login         = @s_user
   end 
   
   select @i_saldo_renovar = isnull(@i_saldo_renovar, 0)
   
   insert into cr_op_renovar
         (or_tramite,         or_num_operacion,    or_producto,
          or_abono,           or_moneda_abono,     or_monto_original,
          or_saldo_original,  or_fecha_concesion,  or_toperacion,
          or_moneda_original, or_monto_inicial,    or_moneda_inicial,
          or_aplicar,         or_capitaliza,       or_login,
          or_fecha_ingreso,   or_finalizo_renovacion)
   values(@i_tramite,         @i_num_operacion,    @i_producto,
          @i_abono,           @i_moneda_abono,     @i_monto_original,
          @i_saldo_original,  @i_fecha_concesion,  @i_toperacion,
          @i_moneda_original, @i_saldo_renovar,    @w_moneda_inicial,
          @i_aplicar,         @i_capitaliza,       @s_user,
          getdate(),          'N')
   
   if @@error <> 0 
   begin
      if @i_crea_ext is null
      begin
         -- ERROR EN INSERCION DE REGISTRO
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file, 
              @t_from  = @w_sp_name,
              @i_num   = 2103001
         return 2103001
      end
      else
      begin
         select @o_msg_msv = 'Error: Insertando registro en cr_op_renovar, Tramite: ' + @i_tramite + ', ' + @w_sp_name
         select @w_return  = 2103001
         return @w_return
      end
   end
   
   -- TRANSACCION DE SERVICIO

   if exists (select 1 from cob_credito..cr_tran_servicio 
              where ts_secuencial     = @s_ssn 
              and ts_tipo_transaccion = @t_trn
              and ts_clase            = 'N')
   begin
      delete cob_credito..cr_tran_servicio 
      where ts_secuencial     = @s_ssn 
      and ts_tipo_transaccion = @t_trn
      and ts_clase            = 'N'
   end
   
   insert into ts_op_renovar
   values (@s_ssn,            @t_trn,              'N',
           @s_date,           @s_user,             @s_term,
           @s_ofi,            'cr_op_renovar',     @s_lsrv,
           @s_srv,            @i_tramite,          @i_num_operacion,
           @i_producto,       @i_abono,            @i_moneda_abono,
           @i_monto_original, @i_saldo_original,   @i_fecha_concesion,
           @i_toperacion,     @i_moneda_original,  @i_aplicar,       --RBU
           @i_capitaliza)    --RBU
   
   if @@error <> 0 
   begin
      if @i_crea_ext is null
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file, 
              @t_from  = @w_sp_name,
              @i_num   = 2103003
         return 1 
      end
      else
      begin
         select @o_msg_msv = 'Error: Insertando transaccion de servicio, Tramite: ' + @i_tramite + ', ' + @w_sp_name
         select @w_return  = 2103003
         return @w_return
      end
   end
   
   --Req 436 Normalizacion
   if @i_tipo_tramite = 'M'
   begin
      if @i_tramite is not null
      begin
         delete cob_credito..cr_normalizacion
         where  nm_operacion = @i_num_operacion
         and    nm_tramite   = @i_tramite
      end
      else
      begin
         delete cob_credito..cr_normalizacion
         where  nm_operacion = @i_num_operacion
         and    nm_login     = @s_user
      end 
      
      insert into cob_credito..cr_normalizacion (nm_tramite, nm_cliente, nm_operacion, nm_tipo_norm, nm_cuota, nm_fecha, nm_login)
      values (@i_tramite, @i_cliente, @i_numero_op_banco, @i_grupo, @i_cuota_prorrogar, @i_fecha_prorrogar, @s_user)
      
      if @@error <> 0 
      begin
      if @i_crea_ext is null
         begin
            -- ERROR EN INSERCION DE REGISTRO
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file, 
                 @t_from  = @w_sp_name,
                 @i_num   = 2103003
            return 2103003
         end
         else
         begin
            select @o_msg_msv = 'ERROR AL CREAR EL REGISTRO EN LA NORMALIZACION, Tramite: ' + @i_tramite + ', ' + @w_sp_name
            select @w_return  = 2103003
            return @w_return
         end
      end

      /* transaccion servicio cr_normalizacion */

      if exists (select 1 from cob_credito..cr_tran_servicio 
                 where ts_secuencial     = @s_ssn 
                 and ts_tipo_transaccion = @t_trn
                 and ts_clase            = 'N')
      begin
         delete cob_credito..cr_tran_servicio 
         where ts_secuencial     = @s_ssn 
         and ts_tipo_transaccion = @t_trn
         and ts_clase            = 'N'
      end
           
      insert into cob_credito..ts_normalizacion (transaccion, secuencial_tran, clase,
                                    usuario,     terminal,        fecha,
                                    tramite,     cliente,         operacion,
                                    tipo_norm,   cuota_prorroga,  fecha_proroga)
      values (@t_trn,     @s_ssn,             'N',
              @s_user,    @s_term,            GETDATE(),
              @i_tramite, @i_cliente,         @i_numero_op_banco,
              @i_grupo,   @i_cuota_prorrogar, @i_fecha_prorrogar)
      
      if @@error <> 0 
      begin                  
      if @i_crea_ext is null
         begin
            -- ERROR EN INSERCION DE REGISTRO
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file, 
                 @t_from  = @w_sp_name,
                 @i_num   = 2103003
            return 2103003
         end
         else
         begin
            select @o_msg_msv = 'ERROR AL CREAR EL REGISTRO EN LA VISTA NORMALIZACION, Tramite: ' + @i_tramite + ', ' + @w_sp_name
            select @w_return  = 2103003
            return @w_return
         end
      end
   end   
   COMMIT TRAN 
end


if @i_operacion = 'D'
begin

   BEGIN TRAN
   
   delete cob_credito..cr_op_renovar
   where  or_tramite       = @i_tramite
   and    or_num_operacion = @i_num_operacion
   --and    or_login         = @s_user
   
   if @@error <> 0
   begin
      if @i_crea_ext is null
      begin
         /*Error en eliminacion de registro */
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file, 
              @t_from  = @w_sp_name,
              @i_num   = 2107001
         return 1 
      end
      else
      begin
         select @o_msg_msv = 'Error: Eliminando Registro en cr_op_renovar, Tramite: ' + @i_tramite + ', ' + @w_sp_name
         select @w_return  = 2107001
         return @w_return
      end
   end
   
   if @@rowcount > 0
   begin
      -- TRANSACCION DE SERVICIO
      insert into ts_op_renovar
      values(@s_ssn, @t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,'cr_op_renovar',@s_lsrv,@s_srv,
            @w_tramite,
            @w_num_operacion,
            @w_producto,
            @w_abono,
            @w_moneda_abono,
            @w_monto_original,
            @w_saldo_original,
            @w_fecha_concesion,
            @w_toperacion,
            @w_moneda_original,
            @w_aplicar,          --RBU
            @w_capitaliza)       --RBU
      
      if @@error <> 0 
      begin
         if @i_crea_ext is null
         begin
            -- ERROR EN INSERCION DE TRANSACCION DE SERVICIO
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file, 
                 @t_from  = @w_sp_name,
                 @i_num   = 2103003
            return 1 
         end
         else
         begin
            select @o_msg_msv = 'Error: Insertando transaccion de servicio cr_op_renovar, Tramite: ' + @w_tramite + ', ' + @w_sp_name
            select @w_return  = 2103003
            return @w_return
         end
      end
   end
   
   delete cr_rub_renovar
   where  rr_tramite_re = @i_tramite
   
   --Req 436 Normalizacion
   if @i_tipo_tramite = 'M'
   begin
   
      /*GUARDA LOS DATOS DE LA OPERACION A ELIMINAR*/
      select
      @w_nm_tramite   = nm_tramite,
      @w_nm_cliente   = nm_cliente,
      @w_nm_operacion = nm_operacion,
      @w_nm_tipo_norm = nm_tipo_norm,
      @w_nm_cuota     = nm_cuota,
      @w_nm_fecha     = nm_fecha
      from cob_credito..cr_normalizacion 
      where nm_tramite   = @i_tramite
      and   nm_operacion = @i_num_operacion
   
      delete cob_credito..cr_normalizacion
      where nm_tramite   = @i_tramite
      and   nm_operacion = @i_num_operacion
      --and   nm_login     = @s_user
      
      if @@error <> 0
      begin
         if @i_crea_ext is null
         begin
            /*Error en eliminacion de registro */
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file, 
                 @t_from  = @w_sp_name,
                 @i_num   = 2107001
            return 1 
         end
         else
         begin
            select @o_msg_msv = 'Error: Eliminando Registro en cr_normalizacion, Tramite: ' + @i_tramite + ', ' + @w_sp_name
            select @w_return  = 2107001
            return @w_return
         end
      end

      /* transaccion servicio cr_normalizacion */
      
      insert into ts_normalizacion (transaccion, secuencial_tran, clase,
                                    usuario,     terminal,        fecha,
                                    tramite,     cliente,         operacion,
                                    tipo_norm,   cuota_prorroga,  fecha_proroga)
      values (@t_trn,          @s_ssn,        'B',
              @s_user,         @s_term,       GETDATE(),
              @w_nm_tramite,   @w_nm_cliente, @w_nm_operacion,
              @w_nm_tipo_norm, @w_nm_cuota,   @w_nm_fecha)

      /* Si no se puede insertar error */
      if @@error <> 0
      begin          
	      /* Error en creacion de transaccion de servicio de parametros de normalizacion*/	      
         print 'ERROR ELIMINANDO TRANSACCION DE SERVICIO ts_normalizacion...'
         return 1	      	       
      end            
   end
   
   COMMIT TRAN
end

--- Search 


if @i_operacion = 'S'
begin
   if @i_crea_ext is null
   begin
      if @i_modo = 1
         -- para renovacion en cartera
         SELECT 
         "Operacion" = or_num_operacion,
         "Cancelar" = or_aplicar,        --RBU
         "Otros Rubros" = or_capitaliza  --RBU
         FROM cr_op_renovar
         WHERE (or_tramite = @i_tramite)
      else
         -- busqueda normal
         SELECT 
         "Tramite" = or_tramite, 
         "Operacion" = or_num_operacion,
         "Linea Credito" = or_toperacion,
         "Monto" = or_monto_original,
         "Saldo" = isnull(or_saldo_original,0) - isnull(or_abono,0),
         "Moneda" = convert(char(3),or_moneda_original)+" ("+b.mo_descripcion+")",
         "Fecha Concesion" = convert(char(10),or_fecha_concesion,103),
         "Producto" = or_producto,
         "Cancelar" = or_aplicar,        --RBU
         "Otros Rubros" = or_capitaliza  --RBU
         FROM cr_op_renovar
         left outer join cobis..cl_moneda b on 
         or_moneda_original = b.mo_moneda
         WHERE or_tramite = @i_tramite
   end
end


/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'
begin
    if (@w_existe = 1 and @i_crea_ext is null)
         select 
              @w_tramite,
              @w_num_operacion,
              @w_producto,
              @w_monto_original,
              @w_saldo_original,
              convert(char(10),@w_fecha_concesion,103),
              @w_toperacion,
              @w_moneda_original,
              @w_desc_moneda_orig,
              @w_aplicar,     --RBU
              @w_capitaliza   --RBU
    else
    begin
       if @i_crea_ext is null
       begin
          /* Registro No existe */
          exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file, 
               @t_from  = @w_sp_name,
               @i_num   = 2101005
          return 1 
       end
       else
       begin
          select @o_msg_msv = 'Error: No existe Registro, Tramite: ' + @w_tramite + ', ' + @w_sp_name
          select @w_return  = 2101005
          return @w_return
       end
        
    end
end
return 0
go