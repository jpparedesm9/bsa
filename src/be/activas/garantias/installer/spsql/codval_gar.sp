use cob_custodia
go
if exists (select 1 from sysobjects where name = 'sp_codval_gar')
drop proc sp_codval_gar
go
create proc sp_codval_gar (
   @s_ssn                int		= null,
   @s_date               datetime	= null,
   @s_user               login		= null,
   @s_term               descripcion	= null,
   @s_ofi                smallint  	= null,
   @t_trn                smallint 	= null,
   @t_debug              char(1)  	= 'N',
   @t_file               varchar(14) 	= null,
   @i_operacion          char(1)  	= null,
   @i_modo               smallint 	= null,
   @i_tipo               varchar(64) = null,
   @i_codval             int = null,
   @i_descripcion        varchar(160)  = null,
   @i_estado             char(1) = null


)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_descripcion        varchar(160),
   @w_estado             char(1)


select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_codval_gar'


/***********************************************************/
/* Codigos de Transacciones                                */
if (@t_trn <> 19133 and @i_operacion = 'I') or
   (@t_trn <> 19134 and @i_operacion = 'U') or
   (@t_trn <> 19135 and @i_operacion = 'D') or
   (@t_trn <> 19136 and @i_operacion = 'S') or
   (@t_trn <> 19136 and @i_operacion = 'Q') 
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,

    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' 
begin
    select 
         @w_descripcion   	= cv_descripcion  ,
         @w_estado         = cv_estado
    from cob_custodia..cu_codigo_valor
    where cv_tipo = @i_tipo
      and cv_codval = @i_codval
      and cv_estado = @i_estado


    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0
end


/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
    if @i_tipo is NULL 
    begin
    /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1901001
        return 1 
    end

    if @i_codval is NULL
       begin
       /* No existe codigo Superior */
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file, 
          @t_from  = @w_sp_name,
          @i_num   = 1901001
          return 1 
       end    
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
        return 1 
    end


    begin tran  
       insert into cu_codigo_valor (
       cv_tipo,         cv_codval,     cv_descripcion, cv_estado)		
       values (
       @i_tipo,         @i_codval,    @i_descripcion,  @i_estado)



         if @@error <> 0 
         begin
         /* Error en insercion de registro */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1903001
             return 1 
         end



         /* Transaccion de Servicio */
         /***************************/
         insert into ts_codigo_valor values (
         @s_ssn, @t_trn, 'N',
         @s_date, @s_user, @s_term,
         @s_ofi,'cu_codigo_valor', @i_tipo,
         @i_codval, @i_descripcion, @i_estado)


         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1 
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

        return 1 
    end

    begin tran


         update cob_custodia..cu_codigo_valor  set 
         cv_descripcion   	= @i_descripcion
         where  cv_tipo = @i_tipo
           and  cv_codval 	= @i_codval
           and  cv_estado = @i_estado


         if @@error <> 0 
         begin
         /* Error en actualizacion de registro */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1905001
             return 1 
         end



         /* Transaccion de Servicio */
         /***************************/

         insert into ts_codigo_valor values (
         @s_ssn, @t_trn, 'P',
         @s_date, @s_user, @s_term,
         @s_ofi,'cu_codigo_valor', @i_tipo,
         @i_codval, @w_descripcion, @w_estado)    

         
         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1 
         end

            

         /* Transaccion de Servicio */

         insert into ts_codigo_valor values (
         @s_ssn, @t_trn, 'A',
         @s_date, @s_user, @s_term,
         @s_ofi,'cu_codigo_valor', @i_tipo,
         @i_codval, @i_descripcion, @i_estado)


         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1 
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
        return 1 
    end


    begin tran
       delete cob_custodia..cu_codigo_valor 
       where  cv_tipo   = @i_tipo
         and  cv_codval = @i_codval
         and  cv_estado = @i_estado
       if @@error <> 0 
	     begin
          /* Error en insercion de registro */
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1907001
          return 1 
        end


         /* Transaccion de Servicio */
         /***************************/
         insert into ts_codigo_valor values (
         @s_ssn, @t_trn, 'B',
         @s_date, @s_user, @s_term,
         @s_ofi,'cu_codigo_valor', @i_tipo,
         @i_codval, @w_descripcion, @w_estado)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1 
         end
    commit tran
    return 0
end


/* Consulta opcion QUERY */
/*************************/
if @i_operacion = 'Q'
begin

   if @w_existe = 1
   begin    
        
      select
      @w_descripcion,
      @w_estado
      return 0
   end    
   else
      return 1 
end


 /* Todos los datos de la tabla */
if @i_operacion = 'S'
begin
   set rowcount 20
   if @i_modo = 0 
   begin
      select 
      "CODIGO VALOR" = cv_codval,     
      "DESCRIPCION" = cv_descripcion,
      "ESTADO" = cv_estado, 
      "TIPO" = cv_tipo
      from cu_codigo_valor   
      order by cv_tipo + convert(varchar(10),cv_codval) 
      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1901003
         return 1 
      end    
   end
   else 
   begin
      select
      "CODIGO VALOR" = cv_codval,     
      "DESCRIPCION" = cv_descripcion,
      "ESTADO" = cv_estado, 
      "TIPO" = cv_tipo
      from cu_codigo_valor  
      where (cv_tipo + convert(varchar(10),cv_codval) ) > (@i_tipo + convert(varchar(10),@i_codval) )
      order by cv_tipo + convert(varchar(10),cv_codval) 
      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1901004
         return 1 
      end
   end
end

                                                                                                                        
                                                                                                                                                               
                                                                                                                                                                                                                              
go
