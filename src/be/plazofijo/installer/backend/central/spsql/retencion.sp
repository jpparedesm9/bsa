/************************************************************************/
/*      Archivo:                retencion.sp                            */
/*      Stored procedure:       sp_retencion                            */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Miryam Davila                           */
/*      Fecha de documentacion: 24/Oct/94                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de INSERT, DELETE,      */
/*      SEARCH y QUERY de la tabla de retenciones 'pf_retencion'.       */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      03-Nov-94  Ricardo Valencia   Creacion                          */
/*      05-Sep-95  Carolina Alvarado  XXXXXXX                           */
/*                                                                      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_retencion')
   drop proc sp_retencion
go

create proc sp_retencion (
   @s_ssn                 int         = NULL,
   @s_sesn                int         = NULL,
   @s_user                login       = NULL,
   @s_term                varchar(30) = NULL,
   @s_date                datetime    = NULL,
   @s_srv                 varchar(30) = NULL,
   @s_lsrv                varchar(30) = NULL,
   @s_ofi                 smallint    = NULL,
   @s_rol                 smallint    = NULL,
   @t_debug               char(1)     = 'N',
   @t_file                varchar(10) = NULL,
   @t_from                varchar(32) = NULL,
   @t_trn                 smallint    = NULL,
   @i_operacion           char(1),
   @i_cuenta              cuenta,
   @i_motivo              catalogo    = NULL,
   @i_secuencial          tinyint     = NULL,
   @i_valor               money       = NULL,
   @i_suspendida          char(1)     = 'N',
   @i_observacion         descripcion = NULL,
   @i_formato_fecha       int         = 0,    -- GESCY2K B285
   @i_tipo                char(1)     = 'A',  -- GES 07/05/01 CUZ-020-080 
   @i_cuenta_referencia   cuenta      = NULL, --GAR 02-mar-2005 DP00063
   @i_prod_cobis          catalogo    = NULL, --GAR 02-mar-2005 DP00063
   @i_funcionario         login       = NULL,  --KTA GB-GAPDP00130
   @i_batch               varchar(2)  = 'N'
)   
with encryption
as
declare @w_sp_name             varchar(32),
        @w_operacionpf         int,
        @w_secuencial          tinyint,
        @w_valor               money,
        @w_fecha_crea          datetime,
        @w_fecha_mod           datetime,
        @w_suspendida          char(1),
        @w_monto_disponible    money,
        @w_monto_blq           money,
        @w_monto               money,
        @w_moneda              smallint,
        @w_estado              catalogo,
        @w_motivo              catalogo,
        @w_historia            smallint,
        @w_numdeci             tinyint,
        @w_usadeci             char(1),
        @w_funcionario         login,
        @w_cupon               tinyint,  -- GES 07/09/01 CUZ-020-087
        @w_return              int,      -- GES 07/09/01 CUZ-020-087
        @o_operacionpf         int,
        @o_secuencial          tinyint,
        @o_valor               money,
        @o_fecha_crea          datetime,
        @o_fecha_mod           datetime,
        @o_suspendida          char(1),
        @o_motivo              varchar(40),
        @o_int_retencion       float,
        @w_cuenta_referencia   cuenta,  --GAR 02-mar-2005 DP00063
        @w_prod_cobis	       catalogo,--GAR 02-mar-2005 DP00063
        @w_usuario             login,    --KTA GB-GAPDP00130
        @o_codigo              varchar(30)

select @w_sp_name = 'sp_retencion'


/**  VERIFICAR CODIGO DE TRANSACCION PARA INSERT  **/
if ( @i_operacion <> 'I' or  @t_trn <> 14108) and
   ( @i_operacion <> 'Q' or  @t_trn <> 14408) and
   ( @i_operacion <> 'D' or  @t_trn <> 14308) and
   ( @i_operacion <> 'S' or  @t_trn <> 14508)
   begin
      /**  ERROR : CODIGO DE TRANSACCION PARA INSERT NO VALIDO  **/
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141040
      return 1
   end

/**  VERIFICAR LA EXISTENCIA DEL PLAZO FIJO Y CONVERSION DEL NUMERO  **/
/**  DE CUENTA AL NUMERO DE OPERACION                                **/
select @w_operacionpf = op_operacion,
       @w_moneda      = op_moneda,
       @w_monto_disponible = op_monto + op_monto_blq + op_monto_pgdo,
       @w_historia    = op_historia,    -- GES 07/06/01 CUZ-020-083
       @w_estado      = op_estado --GAR GB-DP00022
  from pf_operacion
 where op_num_banco = @i_cuenta 

if @@rowcount =0
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141051
   return 1
end

/* Encuentra parametro de decimales */
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

/**  INSERCION DE RETENCIONES  **/
if @i_operacion = 'I'
begin
   if @w_estado <> 'ACT' and @w_estado <> 'VEN' and @w_estado <> 'REN' and @w_estado <> 'CAN'and @w_estado <> 'ING'
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141181
         select @w_return = 141181
         goto borra
   end

   if @i_batch = 'N' 
      begin tran
      /* GES 07/05/01 CUZ-020-081 Retencion de cupones */

      /**  GENERACION DE UN NUEVO NUMERO SECUENCIAL PARA LA RETENCION  **/
      select @w_secuencial = isnull ( max ( rt_secuencial ),0 ) + 1
      from   pf_retencion
      where  rt_operacion  = @w_operacionpf

      /**  BUSQUEDA DE FUNCIONARIO  **/
      select @w_funcionario = fu_login
      from   cobis..cl_funcionario
      where  fu_login = @s_user
     
      /**  VERIFICAR SI ENCONTRO AL FUNCIONARIO  **/
      if @@rowcount <> 1
      begin
         /**  ERROR : NO EXISTE FUNCIONARIO  **/
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141058
         select @w_return = 141058
         goto borra
      end
        

      if @i_tipo = 'C' or @i_tipo = 'A'        
      begin
         select @w_cupon = 0
         while 1 = 1
         begin
            --print 'Entra al lazo'
            set rowcount 1
            select @w_valor  = et_valor,
                   @w_motivo = et_motivo,
                   @w_cupon  = et_cupon
              from pf_retencion_tmp
             where et_usuario   = @s_user
               and et_sesion    = @s_sesn
               and et_operacion = @w_operacionpf
               and et_cupon > @w_cupon 
            if @@rowcount = 0
               break
        
            if not exists (select *
            from pf_cuotas
            where cu_operacion = @w_operacionpf
            and cu_cuota = @w_cupon)
            begin
               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 141161
               select @w_return = 141161
               goto borra
            end

            update pf_cuotas
            set cu_retenido = 'S'
            where cu_operacion = @w_operacionpf
            and cu_cuota = @w_cupon
            if @@error <> 0
            begin
               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 145043
               select @w_return = 145043
               goto borra        
            end
            insert into ts_cuotas (secuencial, tipo_transaccion, clase, fecha,
            usuario, terminal, srv, lsrv,
            operacion, cuota, retenido) values
            (@s_ssn,  14146, 'A', @s_date, @s_user, @s_term, @s_srv, @s_lsrv,
            @w_operacionpf, @w_cupon, 'S')
            if @@error <> 0
            begin
               exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file = @t_file,
               @t_from = @w_sp_name,
               @i_num = 143005
               rollback tran
               return 1
            end                        

            insert pf_retencion 
                (rt_operacion,     rt_secuencial, rt_valor,
                 rt_int_retencion, rt_suspendida, rt_fecha_crea,
                 rt_fecha_mod ,rt_motivo, rt_cupon,
		 rt_cuenta, rt_producto, --GAR 02-mar-2005 DP00063
                 rt_observacion, rt_funcionario) --KTA GB-GAPDP00012, GB-GAPDP00130
            values (@w_operacionpf,   @w_secuencial, @w_valor,
                 0, @i_suspendida, @s_date,
                 @s_date ,@i_motivo, @w_cupon, 
		 @i_cuenta_referencia, @i_prod_cobis, --GAR 02-mar-2005 DP00063
                 @i_observacion, @i_funcionario) --KTA GB-GAPDP00012, GB-GAPDP00130
    
            if @@error <> 0
            begin
               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 143013
               select @w_return = 143013 
               goto borra
            end

            insert ts_retencion 
            (secuencial,    tipo_transaccion, clase,
            usuario,       terminal,         srv,
            lsrv,          fecha,            operacion,
            rt_secuencial, valor,            int_retencion,
            suspendida,    fecha_crea,       fecha_mod,
	    motivo, cupon, 
	    cuenta, producto, --GAR 02-mar-2005 DP00063
            observacion, funcionario) --KTA GB-GAPDP00012, GB-GAPDP00130
            values (@s_ssn,        @t_trn,           'N',
            @s_user,       @s_term,          @s_srv,
            @s_lsrv,       @s_date,          @w_operacionpf,
            @w_secuencial, @w_valor,         0,
            @i_suspendida, @s_date,          @s_date ,
	    @i_motivo, @w_cupon, 
	    @i_cuenta_referencia, @i_prod_cobis, --GAR 02-mar-2005 DP00063
            @i_observacion, @i_funcionario) --KTA GB-GAPDP00012, GB-GAPDP00130
            if @@error <> 0
            begin
               /**  ERROR : NO PUDO INSERTAR TRANSACCION DE SERVICIO  **/
               exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 143005
               select @w_return = 143005
               goto borra
            end
            
            
            insert pf_historia 
                (hi_operacion,   hi_secuencial,    hi_fecha,
                 hi_trn_code,    hi_valor,         hi_funcionario,
                 hi_oficina,     hi_observacion,   hi_fecha_crea,
                 hi_fecha_mod,   hi_cupon) 
            values (@w_operacionpf, @w_historia ,  @s_date,
                 @t_trn,         @w_valor,         @w_funcionario,
                 @s_ofi,         @i_observacion,   @s_date,
                 @s_date,        @w_cupon)
            if @@error <> 0
            begin
               exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 143006
               select @w_return = 143006
               goto borra
            end
            select @w_historia = @w_historia + 1,
                   @w_secuencial = @w_secuencial + 1
         end 
         set rowcount 0
      end
       
                   
      if @i_tipo = 'D' or @i_tipo = 'A'        -- GES 07/05/01 CUZ-020-081
      begin

         /**  COMPARAR SI EL NUEVO BLOQUEO DE MONTO NO SOBREPASA EL MONTO  **/
         /**  DEL PLAZO FIJO                                               **/
         if @i_valor > @w_monto_disponible
            begin
               /**  ERROR : NUEVO BLOQUEO DE MONTO SOBREPASA MONTO  **/
               /**  DISPONIBLE DEL PLAZO FIJO                       **/
               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 141069
               select @w_return = 141069 
               goto borra
            end

   
         /**  INSERCION DE RETENCION  **/
         insert pf_retencion 
                (rt_operacion,     rt_secuencial, rt_valor,
                 rt_int_retencion, rt_suspendida, rt_fecha_crea,
                 rt_fecha_mod ,rt_motivo,
		 rt_cuenta, rt_producto, --GAR 02-mar-2005 DP00063
                 rt_observacion, rt_funcionario)  --KTA GB-GAPDP00012, GB-GAPDP00130
         values (@w_operacionpf,   @w_secuencial, @i_valor,
                 0,                @i_suspendida, @s_date,
                 @s_date ,@i_motivo,
    		 @i_cuenta_referencia, @i_prod_cobis, --GAR 02-mar-2005 DP00063
                 @i_observacion, @i_funcionario)   --KTA GB-GAPDP00012, GB-GAPDP00130
         /**  VERIFICAR SI SE INSERTO CORRECTAMENTE  **/
         if @@error <> 0
            begin
               /**  ERROR EN INSERCION DE RETENCION  ***/
               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 143013
               select @w_return = 143013
               goto borra
            end
      
         /**  INSERCION DE TRANSACCION DE SERVICIO  **/
         insert ts_retencion 
                (secuencial,    tipo_transaccion, clase,
                 usuario,       terminal,         srv,
                 lsrv,          fecha,            operacion,
                 rt_secuencial, valor,            int_retencion,
                 suspendida,    fecha_crea,       fecha_mod,
		 motivo, 
		 cuenta, producto, --GAR 02-mar-2005 DP00063
                 observacion, funcionario)   --KTA GB-GAPDP00012, GB-GAPDP00130
         values (@s_ssn,        @t_trn,           'N',
                 @s_user,       @s_term,          @s_srv,
                 @s_lsrv,       @s_date,          @w_operacionpf,
                 @w_secuencial, @i_valor,         0,
                 @i_suspendida, @s_date,          @s_date ,
		 @i_motivo,
    		 @i_cuenta_referencia, @i_prod_cobis,--GAR 02-mar-2005 DP00063
                 @i_observacion, @i_funcionario)   --KTA GB-GAPDP00012, GB-GAPDP00130
         /**  VERIFICAR SI SE INSERTO CORRECTAMENTE  **/
         if @@error <> 0
            begin
               /**  ERROR : NO PUDO INSERTAR TRANSACCION DE SERVICIO  **/
               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 143005
               select @w_return = 143005
               goto borra
            end             
              
         /**  ACTUALIZAR LA TABLA DE OPERACIONES  **/
         update pf_operacion
         set    op_monto_blq = isnull ( op_monto_blq, 0 ) + round(@i_valor, @w_numdeci),
		op_retenido = 'S'
         where  op_operacion = @w_operacionpf   
    
         if @@error <> 0
            begin
               /**  ERROR : NO PUDO ACTUALIZAR CONTADOR DE RETENCIONES EN   **/
               /**          TABLA DE OPERACIONES                            **/
                exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 145001
               select @w_return = 145001
               goto borra
            end



         /**  INSERCION DEL REGISTRO EN HISTORIA  **/
         insert pf_historia 
                (hi_operacion,   hi_secuencial,    hi_fecha,
                 hi_trn_code,    hi_valor,         hi_funcionario,
                 hi_oficina,     hi_observacion,   hi_fecha_crea,
                 hi_fecha_mod) 
         values (@w_operacionpf, @w_historia ,     @s_date,
                 @t_trn,         @i_valor,         @w_funcionario,
                 @s_ofi,         @i_observacion,   @s_date,
                 @s_date)
    
         /**  VERIFICAR SI SE INSERTO CORRECTAMENTE  **/
         if @@error <> 0
         begin
            /**  ERROR : NO PUDO INSERTAR EN HISTORIAL  **/
            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 143006
            select @w_return = 143006
            goto borra
         end

         select @w_historia = @w_historia + 1
      /**  RETORNO DE NUEVO SECUENCIAL  **/
         select @w_secuencial

      end


      /* GES 07/05/01 CUZ-020-082 Se actualilza una sola vez op_historia
         despues de registrar retencion de deposito y cupones */
      update pf_operacion
      set op_historia = @w_historia 
      where op_operacion = @w_operacionpf
      if @@error <> 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,      
         @t_from  = @w_sp_name,
         @i_num   = 145001
         select @w_return = 145001
         goto borra
      end
       

      if @i_batch = 'N' 
         commit tran
         
      select @w_return = 0
      goto borra 
   end

/**  ELIMINACION DE RETENCIONES  **/
If @i_operacion = 'D'
begin
   /**  BUSQUEDA DE FUNCIONARIO  **/

   select @w_funcionario = fu_login
   from   cobis..cl_funcionario
   where  fu_login = @s_user
   /**  VERIFICAR SI ENCONTRO AL FUNCIONARIO  **/
   if @@rowcount <> 1
   begin
     /**  ERROR : NO EXISTE FUNCIONARIO  **/
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141058
      select @w_return = 141058
      goto borra
   end

   if @i_batch = 'N' 
      begin tran 
      
      
      if @i_tipo = 'C' or @i_tipo = 'A'        
      begin
         select @w_cupon = 0
         while 1 = 1
         begin
            --print 'Entra al lazo'
            set rowcount 1
            select @w_valor = et_valor,
            @w_motivo = et_motivo,
            @w_cupon = et_cupon
            from pf_retencion_tmp
            where et_usuario = @s_user
            and et_sesion = @s_sesn
            and et_operacion = @w_operacionpf
            and et_cupon > @w_cupon 
            if @@rowcount = 0
               break
        
            if not exists (select *
            from pf_cuotas
            where cu_operacion = @w_operacionpf
            and cu_cuota = @w_cupon)
            begin
               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 141161
               select @w_return = 141161
               goto borra
            end

            update pf_cuotas
            set cu_retenido = 'N'
            where cu_operacion = @w_operacionpf
            and cu_cuota = @w_cupon
            if @@error <> 0
            begin
               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 145043
               select @w_return = 145043
               goto borra        
            end
            insert into ts_cuotas (secuencial, tipo_transaccion, clase, fecha,
            usuario, terminal, srv, lsrv,
            operacion, cuota, retenido) values 
            (@s_ssn,  14146, 'A', @s_date, @s_user, @s_term, @s_srv, @s_lsrv,
            @w_operacionpf, @w_cupon, 'N')
            if @@error <> 0
            begin
               exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file = @t_file,
               @t_from = @w_sp_name,
               @i_num = 143005
               rollback tran
               return 1
            end                        

         /**  VERIFICAR EXISTENCIA DE LA RETENCION Y CARGA DE VALORES PARA  **/
         /**  TRANSACCION DE SERVICIO                                       **/
            select @w_valor      = rt_valor,
            @w_suspendida = rt_suspendida,
            @w_motivo     = rt_motivo,
            @w_fecha_crea = rt_fecha_crea,
	    @w_cuenta_referencia = rt_cuenta,--GAR 02-mar-2005 DP00063
	    @w_prod_cobis = rt_producto, --GAR 02-mar-2005 DP00063
	    @w_usuario    = rt_funcionario --KTA GB-GAPDP00130       
            from   pf_retencion
            where  rt_operacion  = @w_operacionpf
            and    rt_cupon = @w_cupon
 
            /**  VERIFICAR SI SE ENCONTRO RETENCION  **/
            if @@rowcount = 0   
            begin
            /**  ERROR : RETENCION NO EXISTE  **/
               exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 141064
               select @w_return = 141064
               goto borra
            end
      
            /**  ELIMINAR LA RETENCION  **/
            delete from pf_retencion
            where  rt_operacion  = @w_operacionpf
            --and    rt_secuencial = @i_secuencial
            and    rt_cupon = @w_cupon
   
            /**  VERIFICAR SI SE ELIMINO CORRECTAMENTE  **/
            if @@error <> 0
            begin
               /**  ERROR : NO PUDO ELIMINAR LA RETENCION  **/
               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 147013
               select @w_return = 147013
               goto borra
            end

            insert ts_retencion 
            (secuencial,    tipo_transaccion, clase,
            usuario,       terminal,         srv,
            lsrv,          fecha,            operacion,
            rt_secuencial, valor,            int_retencion,
            suspendida,    fecha_crea,       fecha_mod,
	    motivo, cupon,
	    cuenta, producto, funcionario,
	    observacion) --GAR 02-mar-2005 DP00063, KTA GB-GAPDP00130
            values (@s_ssn,        @t_trn,           'N',
            @s_user,       @s_term,          @s_srv,
            @s_lsrv,       @s_date,          @w_operacionpf,
            @w_secuencial, @w_valor,         0,
            @i_suspendida, @s_date,          @s_date ,
	    @i_motivo, @w_cupon,
	    @w_cuenta_referencia, @w_prod_cobis, @w_usuario,
	    @i_observacion)--GAR 02-mar-2005 DP00063, KTA GB-GAPDP00130
            if @@error <> 0
            begin
               /**  ERROR : NO PUDO INSERTAR TRANSACCION DE SERVICIO  **/
               exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 143005
               select @w_return = 143005
               goto borra
            end
            insert pf_historia 
                (hi_operacion,   hi_secuencial,    hi_fecha,
                 hi_trn_code,    hi_valor,         hi_funcionario,
                 hi_oficina,     hi_observacion,   hi_fecha_crea,
                 hi_fecha_mod,   hi_cupon) 
            values (@w_operacionpf, @w_historia ,  @s_date,
                 @t_trn,         @w_valor,         @w_funcionario,
                 @s_ofi,         @i_observacion,   @s_date,
                 @s_date,        @w_cupon)
            if @@error <> 0
            begin
               exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 143006
               select @w_return = 143006
               goto borra
            end
            select @w_historia = @w_historia + 1
         end 
         set rowcount 0
      end
       
      if @i_tipo = 'D' or @i_tipo = 'A'  
      begin
         /**  VERIFICAR EXISTENCIA DE LA RETENCION Y CARGA DE VALORES PARA  **/
         /**  TRANSACCION DE SERVICIO                                       **/
         select @w_valor      = rt_valor,
                @w_suspendida = rt_suspendida,
                @w_motivo     = rt_motivo,
                @w_fecha_crea = rt_fecha_crea,
	        @w_cuenta_referencia = rt_cuenta,--GAR 02-mar-2005 DP00063
		@w_prod_cobis = rt_producto,     --GAR 02-mar-2005 DP00063
                @w_usuario    = rt_funcionario   --KTA GB-GAPDP00130       
         from   pf_retencion
         where  rt_operacion  = @w_operacionpf
         and    rt_secuencial = @i_secuencial 
         if @@rowcount = 0   
         begin
            /**  ERROR : RETENCION NO EXISTE  **/
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 141064
            select @w_return = 141064
            goto borra
         end
      
         /**  ELIMINAR LA RETENCION  **/
         delete from pf_retencion
         where  rt_operacion  = @w_operacionpf
         and    rt_secuencial = @i_secuencial  
         if @@error <> 0
         begin
            /**  ERROR : NO PUDO ELIMINAR LA RETENCION  **/
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 147013
            select @w_return = 147013
            goto borra
         end
                     
         /**  INSERCION DE TRANSACCION DE SERVICIO  **/
         insert ts_retencion 
                (secuencial,    tipo_transaccion, clase,
                 usuario,       terminal,         srv,
                 lsrv,          fecha,            operacion,
                 rt_secuencial, valor,            int_retencion,
                 suspendida,    fecha_crea,       fecha_mod ,
		 motivo,
		 cuenta, producto, funcionario) --GAR 02-mar-2005 DP00063, KTA GB-GAPDP00130
         values (@s_ssn,        @t_trn,           'N',
                 @s_user,       @s_term,          @s_srv,
                 @s_lsrv,       @s_date,          @w_operacionpf,
                 @i_secuencial, @i_valor,         0,
                 @i_suspendida, @w_fecha_crea,    @s_date ,
		 @w_motivo,
		 @w_cuenta_referencia, @w_prod_cobis, @w_usuario) --GAR 02-mar-2005 DP00063, KTA GB-GAPDP00130

         /**  VERIFICAR SI SE INSERTO CORRECTAMENTE  **/
         if @@error <> 0
         begin
            /**  ERROR : NO PUDO INSERTAR TRANSACCION DE SERVICIO  **/
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 143005
            select @w_return = 143005
           goto borra
         end
           
         /**  LEER Y CALCULAR LOS VALORES DE MONTO DE ESE PLAZO FIJO  **/
         select @w_monto     = op_monto,
                @w_monto_blq = op_monto_blq - @i_valor
         from   pf_operacion
         where  op_operacion = @w_operacionpf

         /**  COMPARAR SI ESE PLAZO FIJO NO POSEE MAS MONTO RETENIDO  **/
            /**  ACTUALIZAR LA TABLA DE OPERACIONES  **/
         update pf_operacion
         set    op_monto_blq = isnull(op_monto_blq,0)- round(@i_valor, @w_numdeci)
         where  op_operacion = @w_operacionpf                
         if @@error <> 0
         begin         
               exec cobis..sp_cerror
                     @t_debug = @t_debug,
                     @t_file  = @t_file,
                     @t_from  = @w_sp_name,
                     @i_num   = 145001
               select @w_return = 145001
               goto borra
         end

         if @w_monto_blq <= 0 
         begin
            /**  ACTUALIZAR LA TABLA DE OPERACIONES  **/
            if not exists(select 1 from pf_retencion where rt_operacion  = @w_operacionpf)
            begin
	            update pf_operacion
        	    set    op_monto_blq = 0,
		           op_retenido = 'N'
	            where  op_operacion = @w_operacionpf          
        	    if @@error <> 0
	            begin
        	       exec cobis..sp_cerror
	               @t_debug = @t_debug,
	               @t_file  = @t_file,
	               @t_from  = @w_sp_name,
	               @i_num   = 145001
	               select @w_return = 145001
        	       goto borra
	            end
            end
         end
               
        
         /**  INSERCION DEL REGISTRO DE HISTORIA  **/
         insert pf_historia 
                (hi_operacion,   hi_secuencial,    hi_fecha,
                 hi_trn_code,    hi_valor,         hi_funcionario,
                 hi_oficina,     hi_observacion,   hi_fecha_crea,
                 hi_fecha_mod) 
         values (@w_operacionpf, @w_historia ,  @s_date,
                 @t_trn,         @i_valor,         @w_funcionario,
                 @s_ofi,         @i_observacion,   @s_date,
                 @s_date)
    
         /**  VERIFICAR SI SE INSERTO CORRECTAMENTE  **/
         if @@error <> 0
         begin
            /**  ERROR : NO PUDO INSERTAR EN HISTORIAL  **/
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 143006
            select @w_return = 143006
            goto borra
         end
         select @w_historia = @w_historia + 1
      end

      /* GES 07/05/01 CUZ-020-082 Se actualilza una sola vez op_historia
         despues de registrar retencion de deposito y cupones */
      update pf_operacion
      set op_historia = @w_historia + 1
      where op_operacion = @w_operacionpf
      if @@error <> 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,      
         @t_from  = @w_sp_name,
         @i_num   = 145001
         select @w_return = 145001
         goto borra
      end 

      if @i_batch = 'N' 
         commit tran

      select @w_return = 0
      goto borra 
   end         

/**  CONSULTA (QUERY) DE UN RETENCION  **/
If @i_operacion = 'Q'
   begin
      /**  VERIFICAR EXISTENCIA DE LA RETENCION  **/
      select @o_operacionpf     = rt_operacion,
             @o_secuencial      = rt_secuencial,
             @o_valor           = rt_valor,
             @o_int_retencion   = rt_int_retencion,
             @o_suspendida      = rt_suspendida,
             @o_motivo          = valor,
             @o_fecha_crea      = rt_fecha_crea,
             @o_fecha_mod       = rt_fecha_mod,
             @o_codigo          = b.codigo
      from   pf_retencion,cobis..cl_catalogo b,cobis..cl_tabla a
      where  rt_operacion       = @w_operacionpf
      and    rt_secuencial      = @i_secuencial
      and    a.tabla     = 'pf_motivo_ret'
      and    a.codigo    = b.tabla
      and    b.codigo = rt_motivo
 
      /**  VERIFICAR SI SE ENCONTRO RETENCION  **/
      if @@rowcount = 0   
         begin
            /**  ERROR : RETENCION NO EXISTE  **/
            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 141064
            return 
         end
      
      select @o_operacionpf,       
             @o_secuencial,              
             @o_valor,        
             @o_int_retencion,        
             @o_suspendida,
	     @o_motivo,
             convert(char(10),@o_fecha_crea,@i_formato_fecha),
             convert(char(10),@o_fecha_mod,@i_formato_fecha),
             @o_codigo
             /* GESCY2K B286 */

      return 0
   end

If @i_operacion = 'S'
begin
   if @i_tipo = 'A'  -- GES 07/09/01 CUZ-020-089 Condicion todas las retenciones
   begin
      /**  VERIFICAR EXISTENCIA DE LA RETENCION  **/
      select 'No'		      = rt_secuencial,
	     'Monto'                  = rt_valor,
             'Motivo'                 = a.valor,
             'Fecha de Ingreso'      = convert(char(10),rt_fecha_crea,
             @i_formato_fecha),   /* GESCY2K B287 */
             'Intereses en Retencion' = rt_int_retencion,
             'Suspendida'             = rt_suspendida,
             'Operacion'              = rt_operacion
      from  pf_retencion, cobis..cl_catalogo a, cobis..cl_tabla b
      where rt_operacion = @w_operacionpf
        and b.tabla = 'pf_motivo_ret'
	and b.codigo = a.tabla
	and a.codigo = rt_motivo
      return 0   
   end
   if @i_tipo = 'D' -- GES 07/09/01 CUZ-020-089 Condicion solo DEPOSITOS
   begin
      /**  VERIFICAR EXISTENCIA DE LA RETENCION  **/
      select 'No'		      = rt_secuencial,
	     'Monto'                  = rt_valor,
             'Motivo'                 = a.valor,
             'Fecha de Ingreso'       = convert(char(10),rt_fecha_crea, @i_formato_fecha),   /* GESCY2K B287 */
             'Intereses en Retencion' = rt_int_retencion,
             'Suspendida'             = rt_suspendida,
             'Operacion'              = rt_operacion,
	     'Nro. Obligaci¢n'        = rt_cuenta, --GAR 02-mar-2005 DP00063
             'Producto'               = c.valor,   --KTA GB-GAPDP00012 
             'Observaci¢n'            = rt_observacion  --KTA GB-GAPDP00012 
        from pf_retencion, 
             cobis..cl_catalogo a, 
             cobis..cl_tabla b, 
             cobis..cl_catalogo c,
             cobis..cl_tabla d 
       where rt_operacion = @w_operacionpf
         and b.tabla      = 'pf_motivo_ret'
	 and b.codigo     = a.tabla
         and a.codigo     = rt_motivo
         and rt_cupon     IS   NULL
         and d.tabla      = 'pf_producto_custodia'
	 and d.codigo     = c.tabla
         and c.codigo     = rt_producto
      return 0   
   end
end


borra:
  set rowcount 0
  delete pf_retencion_tmp where
         et_usuario = @s_user and et_sesion = @s_sesn
return @w_return
go    


