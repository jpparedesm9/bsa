/******************************************************************/
/* Archivo:             perfil.sp                                 */
/* Stored procedure:    sp_perfil                                 */
/* Base de datos:       cob_conta                                 */
/* Producto:            contabilidad                              */
/* Disenado por:        Narcisa Maldonado                         */
/* Fecha de escritura:  26-Julio-1995                             */
/******************************************************************/
/*                            IMPORTANTE                          */
/* Este programa es parte de los paquetes bancarios propiedad de  */
/* "MACOSA", representantes exclusivos para el Ecuador de la      */
/* "NCR CORPORATION".                                             */
/* Su uso no autorizado queda expresamente prohibido asi como     */
/* cualquier alteracion o agregado hecho por alguno de sus        */
/* usuarios sin el debido consentimiento por escrito de la        */
/* Presidencia Ejecutiva de MACOSA o su representante.            */
/******************************************************************/
/*                            PROPOSITO                           */
/* Este programa procesa las transacciones de:                    */
/*    Mantenimiento al catalogo de Estados de cuenta              */
/******************************************************************/
/*                         MODIFICACIONES                         */
/* FECHA          AUTOR          RAZON                            */
/* 27/Julio/1995  N Maldonado    Emision Inicial                  */
/* 12/Julio/1996  L. Tandazo     Modificacion                     */
/* 23/Julio/1996  S. de la Cruz  Correspondencia mensajes error   */
/* 21/oct/2005    Olga Rios      Modificacion fecha tran servicio */
/* 25/Oct/2006    CPA            Insercion detalle tran servicio  */
/******************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_perfil')
    drop proc sp_perfil
go
create proc sp_perfil(
   @s_ssn            int         = null,
   @s_date           datetime    = null,
   @s_user           login       = null,
   @s_term           descripcion = null,
   @s_corr           char(1)     = null,
   @s_ssn_corr       int         = null,
   @s_ofi            smallint    = null,
   @t_rty            char(1)     = null,
   @t_trn            smallint    = null,
   @t_debug          char(1)     = 'N',
   @t_file           varchar(14) = null,
   @t_from           varchar(30) = null,
   @i_operacion      char(1)     = null,
   @i_modo           smallint    = null,
   @i_empresa        tinyint     = null,
   @i_producto       tinyint     = null,
   @i_producto1      tinyint     = null,
   @i_perfil         varchar(20) = null,
   @i_perfil1        varchar(20) = null,
   @i_asiento        smallint    = null
)as
declare
   @w_today          datetime,     /* fecha del dia */ 
   @w_return         int,          /* valor que retorna */
   @w_sp_name        varchar(32),  /* nombre stored proc*/
   @w_existe         tinyint,      /* existe el registro*/
   @w_empresa        tinyint,
   @w_producto       tinyint,
   @w_perfil         varchar(20),
   @w_descripcion    descripcion

select @w_today = getdate()
select @w_sp_name = 'sp_perfil'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 6903 and @i_operacion = 'I') 
or (@t_trn <> 6904 and @i_operacion = 'U') 
or (@t_trn <> 6905 and @i_operacion = 'D') 
or (@t_trn <> 6906 and @i_operacion = 'Q') 
or (@t_trn <> 6907 and @i_operacion = 'S') 
or (@t_trn <> 6908 and @i_operacion = 'V') 
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 601077
    return 1 
end
/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
   select @w_empresa     = pe_empresa,
          @w_producto    = pe_producto,
          @w_perfil      = pe_perfil,
          @w_descripcion = pe_descripcion
   from  cob_conta..cb_perfil
   where pe_empresa  = @i_empresa 
   and   pe_producto = @i_producto 
   and   pe_perfil   = @i_perfil

   if @@rowcount > 0
      select @w_existe = 1
   else
      select @w_existe = 0
end


/* Insercion del registro */
/**************************/
if @i_operacion = 'I' 
begin
   if @w_existe = 1
   begin
      /* Error Registro ya existe */
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 601155
      return 1 
   end
   if not exists (select *
                  from   cobis..cl_producto, cb_producto
                  where  pr_empresa  = @i_empresa
                  and    pr_producto = @i_producto
                  and    pr_producto = pd_producto)
   begin
      /* Error Registro ya existe */
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 601155
      return 1 
   end

   begin tran
      insert into cb_perfil(
         pe_empresa, pe_producto, pe_perfil, pe_descripcion)
      select tp_empresa, tp_producto, tp_perfil, tp_descripcion
      from   cob_conta..cb_tperfil
      where  tp_empresa  = @i_empresa
      and    tp_producto = @i_producto 
      and    tp_perfil   = @i_perfil

      if @@error <> 0 
      begin
         /* Error en insercion de registro */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 603059

         delete cb_tperfil
         where tp_empresa  = @i_empresa 
         and   tp_producto = @i_producto 
         and   tp_perfil   = @i_perfil

         delete cb_tdet_perfil
         where td_empresa  = @i_empresa
         and   td_producto = @i_producto
         and   td_perfil   = @i_perfil
             
         return 1 
      end

      /* Transaccion de Servicio */
      /***************************/
      insert into ts_perfil(
         secuencial, tipo_transaccion, clase,       fecha,
         usuario,    terminal,         oficina,     empresa,
         producto,   perfil,           descripcion)
      select @s_ssn,      @t_trn,    'N',           getdate(),
             @s_user,     @s_term,   @s_ofi,        tp_empresa,
             tp_producto, tp_perfil, tp_descripcion
      from  cb_tperfil
      where tp_empresa  = @i_empresa
      and   tp_producto = @i_producto
      and   tp_perfil   = @i_perfil

      if @@error <> 0 
      begin
         /* Error en insercion de transaccion de servicio */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 603032
         return 1 
      end
      
      insert into cb_det_perfil(
         dp_empresa,   dp_producto,    dp_perfil,    dp_asiento,
         dp_area,      dp_cuenta,      dp_debcred,   dp_codval,
         dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
      select td_empresa,   td_producto,    td_perfil,    td_asiento,
             td_area,      td_cuenta,      td_debcred,   td_codval,
             td_tipo_tran, td_origen_dest, td_constante, td_fuente
      from cob_conta..cb_tdet_perfil
      where td_empresa  = @i_empresa 
      and   td_producto = @i_producto
      and   td_perfil   = @i_perfil
      
      if @@error <> 0 
      begin
         /* Error en insercion de registro */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 603059

        delete cb_tperfil
        where tp_empresa  = @i_empresa 
        and   tp_producto = @i_producto 
        and   tp_perfil   = @i_perfil
        
        delete cb_tdet_perfil
        where td_empresa  = @i_empresa
        and   td_producto = @i_producto 
        and   td_perfil   = @i_perfil
        
        return 1 
      end
      
      --CPA Detalle Transaccion Servicio
      insert into cb_ts_perfil(
         tp_secuencial, tp_ttran,       tp_clase,       tp_fecha,
         tp_usuario,    tp_terminal,    tp_oficina,     tp_empresa,
         tp_producto,   tp_perfil,      tp_descripcion, tp_asiento,
         tp_cuenta,     tp_area,        tp_debcred,     tp_codval,
         tp_tipo_tran,  tp_origen_dest, tp_constante,   tp_fuente)
      select @s_ssn,       @t_trn,         'N',            getdate(),
             @s_user,      @s_term,        @s_ofi,         tp_empresa,
             tp_producto,  tp_perfil,      tp_descripcion, td_asiento,
             td_cuenta,    td_area,        td_debcred,     td_codval,
             td_tipo_tran, td_origen_dest, td_constante,   td_fuente
      from  cb_tperfil, cb_tdet_perfil
      where tp_empresa  = td_empresa
      and   td_empresa  = @i_empresa
      and   tp_producto = td_producto
      and   td_producto = @i_producto
      and   tp_perfil   = td_perfil
      and   td_perfil   = @i_perfil
      
      if @@error <> 0 
      begin
         /* Error en insercion de transaccion de servicio */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 603032
         return 1 
      end
      
      delete cb_tperfil
      where tp_empresa  = @i_empresa 
      and   tp_producto = @i_producto 
      and   tp_perfil   = @i_perfil

      delete cb_tdet_perfil
      where td_empresa  = @i_empresa 
      and   td_producto = @i_producto
      and   td_perfil   = @i_perfil
   
   commit tran 
   return 0
end

/* Actualizacion del registro */
/******************************/
if @i_operacion = 'U' 
begin
   if @w_existe = 0
   begin
      /* Error Registro No Existe*/
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 601159
      return 1 
   end

   begin tran
      --CPA Detalle Transaccion Servicio
      insert into cb_ts_perfil(
         tp_secuencial, tp_ttran,       tp_clase,       tp_fecha,
         tp_usuario,    tp_terminal,    tp_oficina,     tp_empresa,
         tp_producto,   tp_perfil,      tp_descripcion, tp_asiento,
         tp_cuenta,     tp_area,        tp_debcred,     tp_codval,
         tp_tipo_tran,  tp_origen_dest, tp_constante,   tp_fuente)
      select @s_ssn,       @t_trn,         'P',            getdate(),
             @s_user,      @s_term,        @s_ofi,         pe_empresa,
             pe_producto,  pe_perfil,      pe_descripcion, dp_asiento,
             dp_cuenta,    dp_area,        dp_debcred,     dp_codval,
             dp_tipo_tran, dp_origen_dest, dp_constante,   dp_fuente
      from  cb_perfil, cb_det_perfil
      where pe_empresa  = dp_empresa
      and   dp_empresa  = @i_empresa
      and   pe_producto = dp_producto
      and   dp_producto = @i_producto
      and   pe_perfil   = dp_perfil
      and   dp_perfil   = @i_perfil
      
      if @@error <> 0 
      begin
         /* Error en insercion de transaccion de servicio */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 603032
         return 1 
      end
      
      delete cb_perfil
      where pe_empresa  = @i_empresa 
      and   pe_producto = @i_producto 
      and   pe_perfil   = @i_perfil
      
      delete cb_det_perfil
      where dp_empresa  = @i_empresa 
      and   dp_producto = @i_producto 
      and   dp_perfil   = @i_perfil
      
      insert into cb_perfil(
         pe_empresa, pe_producto, pe_perfil, pe_descripcion)
      select tp_empresa, tp_producto, tp_perfil, tp_descripcion
      from   cob_conta..cb_tperfil
      where  tp_empresa  = @i_empresa 
      and    tp_producto = @i_producto
      and    tp_perfil   = @i_perfil

      if @@error <> 0 
      begin
         /* Error en insercion de registro */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 603059

         delete cb_tperfil
         where tp_empresa  = @i_empresa 
         and   tp_producto = @i_producto 
         and   tp_perfil   = @i_perfil

         delete cb_tdet_perfil
         where td_empresa  = @i_empresa 
         and   td_producto = @i_producto 
         and   td_perfil   = @i_perfil
             
         return 1 
      end

      /* Transaccion de Servicio */
      /***************************/
      insert into ts_perfil
      values(@s_ssn,      @t_trn,    'P',            getdate(),
             @s_user,     @s_term,   @s_ofi,         @w_empresa,
             @w_producto, @w_perfil, @w_descripcion)

      if @@error <> 0 
      begin
         /* Error en insercion de transaccion de servicio */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 603032
         return 1 
      end

      insert into ts_perfil (
         secuencial, tipo_transaccion, clase,   fecha,
         usuario,    terminal,         oficina, empresa, 
         producto,   perfil,           descripcion)
      select @s_ssn,      @t_trn,    'A',           getdate(),
             @s_user,     @s_term,   @s_ofi,        tp_empresa,
             tp_producto, tp_perfil, tp_descripcion
      from   cb_tperfil
      where  tp_empresa  = @i_empresa
      and    tp_producto = @i_producto
      and    tp_perfil   = @i_perfil

      if @@error <> 0 
      begin
         /* Error en insercion de transaccion de servicio */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 603032
         return 1 
      end
      
      insert into cb_det_perfil (
         dp_empresa,   dp_producto,    dp_perfil,    dp_asiento, 
         dp_area,      dp_cuenta,      dp_debcred,   dp_codval,
         dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente )
      select td_empresa,   td_producto,    td_perfil,    td_asiento,
             td_area,      td_cuenta,      td_debcred,   td_codval,
             td_tipo_tran, td_origen_dest, td_constante, td_fuente
      from   cob_conta..cb_tdet_perfil
      where  td_empresa  = @i_empresa
      and    td_producto = @i_producto
      and    td_perfil   = @i_perfil
      
      if @@error <> 0 
      begin
         /* Error en insercion de registro */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 603059
            
         delete cb_tperfil
         where tp_empresa  = @i_empresa 
         and   tp_producto = @i_producto
         and   tp_perfil   = @i_perfil

         delete cb_tdet_perfil
         where td_empresa  = @i_empresa 
         and   td_producto = @i_producto 
         and   td_perfil   = @i_perfil
      
         return 1 
      end
      
      --CPA Detalle Transaccion Servicio
      insert into cb_ts_perfil(
         tp_secuencial, tp_ttran,       tp_clase,       tp_fecha,
         tp_usuario,    tp_terminal,    tp_oficina,     tp_empresa,
         tp_producto,   tp_perfil,      tp_descripcion, tp_asiento,
         tp_cuenta,     tp_area,        tp_debcred,     tp_codval,
         tp_tipo_tran,  tp_origen_dest, tp_constante,   tp_fuente)
      select @s_ssn,       @t_trn,         'A',            getdate(),
             @s_user,      @s_term,        @s_ofi,         tp_empresa,
             tp_producto,  tp_perfil,      tp_descripcion, td_asiento,
             td_cuenta,    td_area,        td_debcred,     td_codval,
             td_tipo_tran, td_origen_dest, td_constante,   td_fuente
      from  cb_tperfil, cb_tdet_perfil
      where tp_empresa  = td_empresa
      and   td_empresa  = @i_empresa
      and   tp_producto = td_producto
      and   td_producto = @i_producto
      and   tp_perfil   = td_perfil
      and   td_perfil   = @i_perfil

      if @@error <> 0 
      begin
         /* Error en insercion de transaccion de servicio */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 603032
         return 1 
      end
         
      delete cb_tperfil
      where tp_empresa  = @i_empresa
      and   tp_producto = @i_producto 
      and   tp_perfil   = @i_perfil

      delete cb_tdet_perfil
      where td_empresa  = @i_empresa
      and   td_producto = @i_producto
      and   td_perfil   = @i_perfil
   commit tran 
   return 0
end

/* Eliminacion de registros */
/****************************/
if @i_operacion = 'D'
begin
   if @w_existe = 0
   begin
      /* Registro a eliminar no existe */
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 601164
      return 1 
   end
   
   begin tran
      --CPA Detalle Transaccion Servicio
      insert into cb_ts_perfil(
         tp_secuencial, tp_ttran,       tp_clase,       tp_fecha,
         tp_usuario,    tp_terminal,    tp_oficina,     tp_empresa,
         tp_producto,   tp_perfil,      tp_descripcion, tp_asiento,
         tp_cuenta,     tp_area,        tp_debcred,     tp_codval,
         tp_tipo_tran,  tp_origen_dest, tp_constante,   tp_fuente)
      select @s_ssn,       @t_trn,         'B',            getdate(),
             @s_user,      @s_term,        @s_ofi,         pe_empresa,
             pe_producto,  pe_perfil,      pe_descripcion, dp_asiento,
             dp_cuenta,    dp_area,        dp_debcred,     dp_codval,
             dp_tipo_tran, dp_origen_dest, dp_constante,   dp_fuente
      from  cb_perfil, cb_det_perfil
      where pe_empresa  = dp_empresa
      and   dp_empresa  = @i_empresa
      and   pe_producto = dp_producto
      and   dp_producto = @i_producto
      and   pe_perfil   = dp_perfil
      and   dp_perfil   = @i_perfil
      
      if @@error <> 0 
      begin
         /* Error en insercion de transaccion de servicio */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 603032
         return 1 
      end
      
      delete cb_perfil
      where pe_empresa  = @i_empresa 
      and   pe_producto = @i_producto 
      and   pe_perfil   = @i_perfil

      delete cb_det_perfil
      where dp_empresa  = @i_empresa 
      and   dp_producto = @i_producto 
      and   dp_perfil   = @i_perfil

      if @@error <> 0
      begin
         /*Error en eliminacion de registro */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 607130
         return 1 
      end

      /* Transaccion de Servicio */
      /***************************/

      insert into ts_perfil
      values (@s_ssn,      @t_trn,    'B',            getdate(),
              @s_user,     @s_term,   @s_ofi,         @w_empresa,
              @w_producto, @w_perfil, @w_descripcion)

      if @@error <> 0 
      begin
         /* Error en insercion de transaccion de servicio */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 603032
         return 1 
      end
   commit tran
   return 0
end

/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'
begin
   if not exists (select *
                  from   cobis..cl_producto, cb_producto
                  where  pr_empresa  = @i_empresa
                  and    pr_producto = @i_producto
                  and    pr_producto = pd_producto)
   begin
      /* Error Registro ya existe */
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 101032
      return 1 
   end
   
   set rowcount 20
   if @i_modo = 0
   begin
      if @w_existe = 1
      begin
         select @w_producto, @w_perfil, @w_descripcion
         select 'Asto.'      = dp_asiento,
                'Area'       = dp_area,
                'Codigo'     = dp_cuenta, 
                'Cod. Valor' = dp_codval, 
                'D/C'        = dp_debcred, 
                'Constant.'  = dp_constante,
                'Orig/Dest'  = dp_origen_dest,
                'Fuente'     = dp_fuente,
                'Tip.Tran'   = dp_tipo_tran
         from  cob_conta..cb_det_perfil
         where dp_empresa  = @i_empresa
         and   dp_producto = @i_producto
         and   dp_perfil   = @i_perfil
         order by dp_asiento
         if @@rowcount = 0
         begin
            /*Registro no existe */
            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file, 
               @t_from  = @w_sp_name,
               @i_num   = 601153
            return 1 
         end
      end
      else
      begin
         /*Registro no existe */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 601153
         return 1 
      end
   end
   else
   begin
      select dp_asiento,
             dp_area,
             dp_cuenta, 
             dp_codval, 
             dp_debcred, 
             dp_constante,
             dp_origen_dest,
             dp_fuente,
             dp_tipo_tran
      from   cob_conta..cb_det_perfil
      where  dp_empresa  = @i_empresa
      and    dp_producto = @i_producto
      and    dp_perfil   = @i_perfil
      and    dp_asiento  > @i_asiento
      order by dp_asiento

      if @@rowcount = 0 
      begin
         /*No existen mas registros*/
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 601150
         return 1 
      end
   end
   return 0 
end

/* Consulta opcion SEARCH*/
/*************************/

if @i_operacion = 'S'
begin
   set rowcount 20
   if @i_modo = 0
   begin
      select 'Producto'    = pe_producto,
             'Codigo'      = pe_perfil,
             'Descripcion' = pe_descripcion
      from   cob_conta..cb_perfil
      where  pe_empresa   = @i_empresa 
      and    (pe_producto = @i_producto or @i_producto is NULL) 
      and    (pe_perfil like @i_perfil)
      
      if @@rowcount = 0
      begin
         /* No existen registros */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 601153
         return 1 
      end
   end
   if @i_modo = 2
   begin
      select 'Producto'    = pe_producto,
             'Codigo'      = pe_perfil,
             'Descripcion' = pe_descripcion
      from  cob_conta..cb_perfil
      where pe_empresa  = @i_empresa 
      and   pe_producto = @i_producto
      and   pe_perfil   > @i_perfil1
      
      if @@rowcount  = 0
      begin
         /* No existen registros */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 601153
         return 1 
      end
   end
   if @i_modo = 1
   begin
      select 'Producto'    = pe_producto,
             'Codigo'      = pe_perfil,
             'Descripcion' = pe_descripcion
      from   cob_conta..cb_perfil
      where  pe_empresa   = @i_empresa 
      and    pe_perfil like @i_perfil
      and    (pe_producto  = @i_producto  or  @i_producto is NULL) 
      and    ((pe_producto = @i_producto1 and pe_perfil   > @i_perfil1) 
              or pe_producto > @i_producto1)
      if @@rowcount = 0
      begin
         /* No existen registros */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 601153
         return 1 
      end
   end
   return 0
end
go
