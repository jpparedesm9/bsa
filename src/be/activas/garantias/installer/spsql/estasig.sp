/************************************************************************/
/*      Archivo:                estasig.sp                              */
/*      Stored procedure:       sp_asignar_estados                      */
/*      Base de datos:          cob_custodia                            */
/*      Producto:               garantias                               */
/*      Disenado por:           Patricia Garzon                         */
/*      Fecha de escritura:     22/jun/2000                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa permite ingresar, eliminar y modificar los        */
/*      camabios de estados permitidos para una garantia.               */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR                     RAZON                 */
/*  22/jun/2000   Patricia Garzon            Emision Inicial            */
/************************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_asignar_estados')
    drop proc sp_asignar_estados
go
create proc sp_asignar_estados (
   @s_ssn                int      = null,
   @s_sesn               int      = null,
   @s_rol                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion  = null,
   @s_srv                varchar(30)  = null,
   @s_lsrv               varchar(30)  = null,
   @s_ofi                smallint     = null,
   @t_file               varchar(14)  = null,
   @t_debug              char(1)      = 'N',
   @t_trn                smallint     = null,
   @t_from               varchar(30)  = null,
   @i_operacion          char(1)      = null,
   @i_estado_ini         char(1)      = null,
   @i_estado_fin         char(1)      = null,
   @i_contabiliza        char(1)      = null,
   @i_tran               catalogo     = null,
   @i_estado             char(1)      = null,
   @i_formato_fecha      int          = null,  --PGA 16/06/2000
   @i_tipo               char(1)      = null   -- JAR REQ 266
)
as

declare
   @w_today              datetime,     
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error              int,
   @w_estado_ini         char(1),
   @w_estado_fin         char(1),
   @w_contabiliza        char(1),
   @w_tran               catalogo,
   @w_descripcion1       descripcion,
   @w_descripcion2       descripcion,
   @w_secservicio        int,
   @w_tipo               char(1)     -- JAR REQ 266

select @w_sp_name = 'sp_asignar_estados'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19896 and @i_operacion = 'I') or
   (@t_trn <> 19897 and @i_operacion = 'U') or
   (@t_trn <> 19898 and @i_operacion = 'D') or
   (@t_trn <> 19899 and @i_operacion = 'S') or
   (@t_trn <> 19900 and @i_operacion = 'Q') or
   (@t_trn <> 19900 and @i_operacion = 'A') or 
   (@t_trn <> 19900 and @i_operacion = 'Z')

begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_from  = @w_sp_name,
  
   @i_num   = 1901006
    return 1901006  -- JAR REQ 266 
end


select @w_secservicio = @@spid


/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S'
begin
   select @w_estado_ini             = ce_estado_ini,
          @w_estado_fin             = ce_estado_fin,
          @w_contabiliza            = ce_contabiliza,
          @w_tran                   = ce_tran,
          @w_descripcion1           = a.eg_descripcion,
          @w_descripcion2           = b.eg_descripcion,
          @w_tipo                   = ce_tipo  -- JAR REQ 266
   from  cob_custodia..cu_cambios_estado,
         cob_custodia..cu_estados_garantia a,
         cob_custodia..cu_estados_garantia b
   where ce_estado_ini = @i_estado_ini
   and   ce_estado_fin = @i_estado_fin
   and   a.eg_estado = ce_estado_ini
   and   b.eg_estado = ce_estado_fin 


/*    select
        @w_estado_ini             = ce_estado_ini,
        @w_estado_fin             = ce_estado_fin,
        @w_contabiliza            = ce_contabiliza,
        @w_tran                   = ce_tran
    from cob_custodia..cu_cambios_estado
    where ce_estado_ini = @i_estado_ini
      and ce_estado_fin = @i_estado_fin */

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
   /* Registro ya existe */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901002
      return 1901002  -- JAR REQ 266 
   end

   begin tran 
      insert into cu_cambios_estado ( ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo)  -- JAR REQ 266
      values ( @i_estado_ini, @i_estado_fin, @i_contabiliza, @i_tran, @i_tipo)   -- JAR REQ 266
      if @@error <> 0 
      begin
       /* Error en insercion de registro */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1903001
         return 1903001  -- JAR REQ 266
      end

  /* Transaccion de Servicio */
         /***************************/

         insert into ts_cambios_estado values 
         (@w_secservicio,@t_trn,'N',
         @s_date,@s_user,@s_term,
         @s_ofi,'cu_cambios_estado', @i_estado_ini,
         @i_estado_fin, @i_contabiliza, @i_tran)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1903003  -- JAR REQ 266
         end
   commit tran 
   return 0
end


/* Actualizacion del registro */
/******************************/

if @i_operacion = 'U'
begin
    if @w_existe = 0
    begin
    /* Registro a actualizar no existe */
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1905002
        return 1905002  -- JAR REQ 266
    end

    if @i_tran is null
    begin
    /* Registro a actualizar no existe */
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1901001
        return 1901001  -- JAR REQ 266
    end


    begin tran
         update cob_custodia..cu_cambios_estado 
         set 
           ce_tran = @i_tran,    
           ce_contabiliza  = @i_contabiliza,
           ce_tipo         = @i_tipo    -- JAR REQ 266
         where ce_estado_ini = @i_estado_ini
           and ce_estado_fin = @i_estado_fin

         if @@error <> 0 
         begin
         /* Error en actualizacion de registro */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1905001
             return 1905001  -- JAR REQ 266
         end


         /* Transaccion de Servicio */
         /***************************/

         insert into ts_cambios_estado values 
         (@w_secservicio,@t_trn,'P',
          @s_date,@s_user,@s_term,
          @s_ofi,'cu_cambios_estado', @w_estado_ini,
         @w_estado_fin, @w_contabiliza, @w_tran)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1903003  -- JAR REQ 266
         end

            

         /* Transaccion de Servicio */
         /***************************/

         insert into ts_cambios_estado values
         (@w_secservicio,@t_trn,'A',
          @s_date,@s_user,@s_term,
          @s_ofi,'cu_cambios_estado', @i_estado_ini,
         @i_estado_fin, @i_contabiliza, @i_tran)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1903003  -- JAR REQ 266
         end

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
        @t_from  = @w_sp_name,
        @i_num   = 1907002
        return 1907002  -- JAR REQ 266
    end
    else
    begin tran
         delete cob_custodia..cu_cambios_estado 
         where ce_estado_ini = @i_estado_ini
           and ce_estado_fin = @i_estado_fin             

         if @@error <> 0
         begin
         /*Error en eliminacion de registro */
             exec cobis..sp_cerror
             @t_from= @w_sp_name,
             @i_num   = 1907001
             return 1907001  -- JAR REQ 266
         end
         
         
         /* Transaccion de Servicio */
         /***************************/

         insert into ts_cambios_estado values 
         (@w_secservicio,@t_trn,'B',
          @s_date,@s_user,@s_term,
          @s_ofi,'cu_cambios_estado', @w_estado_ini,
         @w_estado_fin, @w_contabiliza, @w_tran)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1903003  -- JAR REQ 266
         end
         
    commit tran
    return 0
end



/*Retorno al Frontend*/
/*********************/

if @i_operacion = 'S' 
begin set rowcount 20
    select 
        'ESTADO INICIAL' = ce_estado_ini, 
        'ESTADO FINAL'   = ce_estado_fin,
        'CONTABILIZA'    = ce_contabiliza,
        'TRANSACCION'    = ce_tran,
        'TIPO'           = ce_tipo   -- JAR REQ 266
    from cob_custodia..cu_cambios_estado  
         if @@rowcount = 0
         begin
            select @w_error  = 1901003
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = @w_error
            return @w_error  -- JAR REQ 266
         end 
     return 0
end 

/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'
begin
    if @w_existe = 1
    begin 
         select 
              @w_estado_ini,
              @w_estado_fin,
              @w_contabiliza,
              @w_tran,
              @w_descripcion1,
              @w_descripcion2,
              @w_tipo        -- JAR REQ 266     
    end 
    else
    begin
    /*Registro no existe */
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1901005
        return 1901005  -- JAR REQ 266 
    end
    return 0
end

if @i_operacion = 'A' 
begin 
    set rowcount 20
    select 
        "ESTADO"      = eg_estado, 
        "DESCRIPCION" = eg_descripcion
    from cob_custodia..cu_estados_garantia
         if @@rowcount = 0
         begin
            select @w_error  = 1901003
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = @w_error
            return @w_error  -- JAR REQ 266
         end 
     return 0
end 

if @i_operacion = 'Z' 
begin 
    select "DESCRIPCION" = eg_descripcion
    from cob_custodia..cu_estados_garantia
    where eg_estado = @i_estado

         if @@rowcount = 0
         begin
            select @w_error  = 1901003
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = @w_error
            return @w_error -- JAR REQ 266
         end 
     return 0
end 


go