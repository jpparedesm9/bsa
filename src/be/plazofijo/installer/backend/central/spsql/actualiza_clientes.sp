/************************************************************************/
/*      Archivo:                actcltes.sp                             */
/*      Stored procedure:       sp_actualiza_clientes                   */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Memito Saborio                          */
/*      Fecha de documentacion: 24/Ago/2001                             */
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
/*      Este procedimiento almacenado realiza la actualizacion de datos */
/*      de clientes en Plazo Fijo cuando se han modificado.             */
/*                                                                      */
/*                                                                      */
/************************************************************************/
/*         fecha         AUTOR                 RAZON                    */
/*      13/08/2009       JBQ                   Adaptacion MSSQLServer   */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_actualiza_clientes')
   drop proc sp_actualiza_clientes 
go

create proc sp_actualiza_clientes (
@s_ssn                  int         = null,
@s_user                 login       = null,
@s_sesn                 int         = null,
@s_term                 varchar(30) = null,
@s_date                 datetime    = null,
@s_srv                  varchar(30) = null,
@s_lsrv                 varchar(30) = null,
@s_ofi                  smallint    = null,
@s_rol                  smallint    = NULL,
@t_debug                char(1)     = 'N',
@t_file                 varchar(10) = null,
@t_from                 varchar(32) = null,
@t_trn                  smallint,
@i_fecha                datetime,
@i_en_linea             char(1)     = 'S'
)
with encryption
as
declare         
@w_sp_name              varchar(32),
@w_secuencial           int,
@w_operacionpf          int,
@w_int_pagados          money,
@w_total_int_pagados    money,
@w_historia             smallint,
@w_anulaciones          tinyint,
@w_mantiene_stock       char(1),
@w_monto                money,
@w_estado               catalogo,
@w_toperacion           catalogo,
@w_fecha_mod            datetime,
@w_op_ente              int,
@w_op_descripcion       varchar(255),
@w_op_descripcion2      varchar(255),
@w_ced_ruc2             numero,
@w_ced_ruc              numero,
@w_op_num_banco         cuenta,
@v_fecha_mod            datetime,
@w_em_p_apellido        varchar(16), 
@w_em_s_apellido        varchar(16), 
@w_em_nombres           varchar(35)

/* Comentado no existe la tabla tm_ente en GLOBAL

create table #$$(
        em_ente              int, 
        em_fecha_mod         datetime, 
        em_cedula            varchar(13)      null, 
        em_p_apellido        varchar(16)      null, 
        em_s_apellido        varchar(16)      null, 
        em_nombres           varchar(64)      null
        )
    
select @w_sp_name = 'sp_actualiza_clientes',
       @w_secuencial = @s_ssn

if @t_trn <> 14201 
begin
  exec cobis..sp_cerror
    @t_debug      = @t_debug,
    @t_file       = @t_file,
    @t_from       = @w_sp_name,
    @i_num        = 141112
  /*  'Error en codigo de transaccion' */
  return 1
end

if @s_ssn is null
begin
  exec @w_secuencial=sp_gen_sec 
  select @s_ssn = @w_secuencial
end 



/**********************************************
*** COMIENZA LA TRANSACCION CON LA REPARA-  ***
*** CION DE LOS DATOS CORRESPONDIENTES.     ***
**********************************************/
/****** Se llenan las tablas temporales con los datos a revisar ********/
insert #$$
select em_ente, em_fecha_mod, em_cedula, em_p_apellido, em_s_apellido, em_nombres
from cobis..tm_ente
where em_clase = 'A'
  and convert(varchar, em_fecha_mod,101) = @i_fecha

begin tran

/** Verifica el numero de cedula del cliente **/
while (1 = 1) 
begin
  set rowcount 1
  select @w_op_ente = em_ente, @v_fecha_mod = em_fecha_mod, 
    @w_ced_ruc2 = em_cedula, @w_em_p_apellido = em_p_apellido, 
    @w_em_s_apellido = em_s_apellido, @w_em_nombres = em_nombres
  from #$$
  order by em_ente, em_fecha_mod        
  if @@rowcount <= 0 
  begin
    set rowcount 0
    break
  end
  set rowcount 0 
        
  declare cursor_operacion cursor
  for select op_operacion, op_toperacion, op_fecha_mod, op_ced_ruc, 
             op_num_banco, op_descripcion
      from pf_operacion
      where op_ente = @w_op_ente
      and op_estado in ('VEN','ACT')
  for update
  
  open cursor_operacion
  
  while (1 = 1) 
  begin
  
    fetch cursor_operacion into @w_operacionpf, @w_toperacion, @w_fecha_mod, @w_ced_ruc, 
        @w_op_num_banco, @w_op_descripcion
        
    if @@fetch_status = -1
       break
      
    if @@fetch_status = -2
    begin
      close cursor_operacion
      deallocate cursor_operacion
      raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
      return 0
    end
      

    if @w_ced_ruc2 is not null 
    begin       
      if (@w_em_p_apellido is not null or @w_em_s_apellido is not null or 
          @w_em_nombres is not null) 
      begin
      
        /**** Se obtiene de la tabla ente el nombre o descripcion real del cliente ****/
        --if @i_en_linea = 'S' 
                select @w_op_descripcion2 = rtrim(a.en_nombre) + ' ' + rtrim(a.p_p_apellido) + ' ' + rtrim(a.p_s_apellido)
                from cobis..cl_ente a
                where a.en_ente = @w_op_ente
                        --else      
        --      select @w_op_descripcion2 = rtrim(a.en_nombre) + ' ' + rtrim(a.p_p_apellido) + ' ' + rtrim(a.p_s_apellido)
        --      from cobis..cl_ente_batch a
        --      where a.en_ente = @w_op_ente

        /**** Cambia en la tabla de operaciones el número de cedula ****/
        update pf_operacion 
        set op_ced_ruc = @w_ced_ruc2,
            op_descripcion = @w_op_descripcion2
        where current of cursor_operacion

        /**  INSERCION TRANSACCION DE SERVICIO PREVIO  **/
        insert ts_operacion (secuencial, tipo_transaccion, clase,
          usuario, terminal, srv, lsrv, fecha, num_banco, 
          operacion, fecha_mod, ced_ruc, descripcion)
        values (@s_ssn, @t_trn,'P',
          @s_user, @s_term, @s_srv, @s_lsrv, @s_date, @w_op_num_banco,
          @w_operacionpf, @v_fecha_mod, @w_ced_ruc, @w_op_descripcion)

        if @@error <> 0 
        begin
          exec cobis..sp_cerror 
            @t_debug=@t_debug,@t_file=@t_file,
            @t_from=@w_sp_name,   @i_num = 143005
          return 1
        end

        /**  INSERCION TRANSACCION DE SERVICIO ACTUALIZADO  **/
        insert ts_operacion (secuencial, tipo_transaccion, clase,
          usuario, terminal, srv, lsrv, fecha, num_banco, 
          operacion, fecha_mod, ced_ruc, descripcion)
        values (@s_ssn, @t_trn,'A',
          @s_user, @s_term, @s_srv, @s_lsrv, @s_date, @w_op_num_banco,
          @w_operacionpf, @s_date, @w_ced_ruc2, @w_op_descripcion2) 

        if @@error <> 0 
        begin
          exec cobis..sp_cerror 
             @t_debug=@t_debug,@t_file=@t_file,
             @t_from=@w_sp_name,   @i_num = 143005
          return 1
        end
      end /* is nombre no es null */
      else 
      begin /* Si nombre es null */
        /**** Cambia en la tabla de operaciones el numero de cedula ****/
        update pf_operacion 
        set op_ced_ruc = @w_ced_ruc2
        where current of cursor_operacion

        /**  INSERCION TRANSACCION DE SERVICIO PREVIO  **/
        insert ts_operacion (secuencial, tipo_transaccion, clase,
          usuario, terminal, srv, lsrv, fecha, num_banco, 
          operacion, fecha_mod, ced_ruc)
        values (@s_ssn, @t_trn,'P',
          @s_user, @s_term, @s_srv, @s_lsrv, @s_date, @w_op_num_banco,
          @w_operacionpf, @v_fecha_mod, @w_ced_ruc)
 
        if @@error <> 0 
        begin
          exec cobis..sp_cerror 
            @t_debug=@t_debug,@t_file=@t_file,
            @t_from=@w_sp_name,   @i_num = 143005
          return 1
        end

        /**  INSERCION TRANSACCION DE SERVICIO ACTUALIZADO  **/
        insert ts_operacion (secuencial, tipo_transaccion, clase,
          usuario, terminal, srv, lsrv, fecha, num_banco, 
          operacion, fecha_mod, ced_ruc)
        values (@s_ssn, @t_trn,'A',
          @s_user, @s_term, @s_srv, @s_lsrv, @s_date, @w_op_num_banco,
          @w_operacionpf, @s_date, @w_ced_ruc2) 

        if @@error <> 0 
        begin
          exec cobis..sp_cerror 
             @t_debug=@t_debug,@t_file=@t_file,
             @t_from=@w_sp_name,   @i_num = 143005
          return 1
        end
      end /* if */
    end
    else 
    begin /* Si la cedula es null */
      if (@w_em_p_apellido is not null or @w_em_s_apellido is not null or 
          @w_em_nombres is not null) 
      begin
              /**** Se obtiene de la tabla ente el nombre o descripcion real del cliente ****/
              --if @i_en_linea = 'S'
                select @w_op_descripcion2 = rtrim(a.en_nombre) + ' ' + rtrim(a.p_p_apellido) + ' ' + rtrim(a.p_s_apellido)
                from cobis..cl_ente a
                where a.en_ente = @w_op_ente
        --else
            --  select @w_op_descripcion2 = rtrim(a.en_nombre) + ' ' + rtrim(a.p_p_apellido) + ' ' + rtrim(a.p_s_apellido)
          --    from cobis..cl_ente_batch a
        --      where a.en_ente = @w_op_ente
        
              /**** Cambia en la tabla de operaciones el numero de cedula ****/
            update pf_operacion 
          set op_descripcion = @w_op_descripcion2
        where current of cursor_operacion

        /**  INSERCION TRANSACCION DE SERVICIO PREVIO  **/
        insert ts_operacion (secuencial, tipo_transaccion, clase,
                        usuario, terminal, srv, lsrv, fecha, num_banco, 
                        operacion, fecha_mod, descripcion)
        values (@s_ssn, @t_trn,'P',
                        @s_user, @s_term, @s_srv, @s_lsrv, @s_date, @w_op_num_banco,
                        @w_operacionpf, @v_fecha_mod, @w_op_descripcion)
 
        if @@error <> 0 
        begin
                exec cobis..sp_cerror 
                @t_debug=@t_debug,@t_file=@t_file,
                @t_from=@w_sp_name,   @i_num = 143005
                return 1
        end

              /**  INSERCION TRANSACCION DE SERVICIO ACTUALIZADO  **/
            insert ts_operacion (secuencial, tipo_transaccion, clase,
            usuario, terminal, srv, lsrv, fecha, num_banco, 
          operacion, fecha_mod, descripcion)
              values (@s_ssn, @t_trn,'A',
              @s_user, @s_term, @s_srv, @s_lsrv, @s_date, @w_op_num_banco,
            @w_operacionpf, @s_date, @w_op_descripcion2) 
        if @@error <> 0 
        begin
                exec cobis..sp_cerror 
                 @t_debug=@t_debug,@t_file=@t_file,
                   @t_from=@w_sp_name,   @i_num = 143005
              return 1
          end
        end /* If nombre no es null */
    end  /* Fin si cédula es null */
  end /* while del cursor de operaciones */
  
  close cursor_operacion
  deallocate cursor_operacion 

  delete #$$
  where em_ente = @w_op_ente
    and em_fecha_mod = @v_fecha_mod
end /*While de la tabla #$ */

/**************** fin de la transaccion *****************/

Comentado no existe la tabla tm_ente en GLOBAL */


commit tran  
return 0
go  