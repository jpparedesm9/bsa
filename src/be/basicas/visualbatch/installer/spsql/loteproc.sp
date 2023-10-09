/************************************************************************/
/* Archivo:                loteproc.sp                                  */
/* Stored procedure:       sp_lote_proceso                              */
/* Base de datos:          cobis                                        */
/* Producto:               cobis                                        */
/* Disenado por:                                                        */
/* Fecha de escritura:     10-Abril-2002                                */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    'MACOSA', representantes exclusivos para el Ecuador de la         */
/*    'NCR CORPORATION'.                                                */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de MACOSA o su representante.               */
/************************************************************************/
/*                          PROPOSITO                                   */
/*    Este programa permite controlar la insercion de un lote           */
/*    y sus respectivos procesos, deshaciendo las acciones si           */
/*    se da algun error                                                 */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    10-Abr-2002    G. Landzuri     Emision Inicial                    */
/*    14-Sep-2004    J. Umana        se incluye col. deshabilitado      */
/*                                   (ba_sarta_batch)                   */
/*    06-Ago-2008    S. Soto         Incluir transaccionalidad          */   
/*    27-Abr-2009    F. Lopez        COrreccion Consulta Enlaces (H)    */   
/*    21-Ene-2011    S. Soto         Se colocan codigos de error validos*/   
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_lote_proceso')
   drop proc sp_lote_proceso  

go

create proc sp_lote_proceso   (
   @s_ssn        int = null,
   @s_date       datetime = null,
   @s_user       login = null,
   @s_term       descripcion = null,
   @s_corr       char(1) = null,
   @s_ssn_corr       int = null,
   @s_ofi        smallint = null,
   @t_rty            char(1) = null,
   @t_trn        smallint = 802,
   @t_debug   char(1) = 'N',
   @t_file       varchar(14) = null,
   @t_from       varchar(30) = null,
   @i_operacion     char(1),
   @i_sarta   int = null,
   @i_nombre     descripcion = null,
   @i_descripcion    varchar(255) = null,
   @i_fecha_creacion datetime = null,
   @i_creador    descripcion = null,
   @i_producto   tinyint = null,
   @i_dependencia   smallint = null,
   @i_autorizacion     char(1) = null,
   @i_batch   int = null,
   @i_secuencial     smallint = null,
   @i_repeticion     char(1) = null,
   @i_critico        char(1) = 'N',
   @i_left           int = null,        
   @i_top            int = null,
   @i_lote_inicio    int = null,
   @i_habilitado     char(1) = 'S',
   @i_batch_inicio   int = null,
   @i_secuencial_inicio smallint = null, 
   @i_batch_fin      int = null,
   @i_secuencial_fin smallint = null,
   @i_tipo_enlace    char(1) = null,
   @i_puntos         varchar(50) = null,
   @i_entre_lotes    char(1) = 'N',
   @i_actualiza      char(1) = N,
   @i_modo           smallint = NULL 

)
as 
declare
   @w_today          datetime,      /* fecha del dia */
   @w_return         int,           /* valor que retorna */
   @w_sp_name        varchar(32),   /* descripcion del stored procedure*/
   @w_existe         int,           /* codigo existe = 1 no existe = 0 */
   @w_sarta          int,
   @w_error_sarta    char(1),
   @w_error_batch    char(1),
   @w_error_enlace   char(1),
   @w_error_param    char(1),
   @w_pa_tparametro  smallint, 
   @w_pa_tnombre     varchar(64), 
   @w_pa_ttipo       char(1),  
   @w_pa_tvalor      varchar(64),
   @w_lsarta         int,
   @w_lbatch         int,
   @w_ldependencia   smallint
   
   
select @w_today = getdate()
select @w_sp_name = 'sp_lote_proceso'


if @i_fecha_creacion is null
   select @i_fecha_creacion = getdate()

if (@t_trn <> 8083 and @i_operacion = 'S') or
   (@t_trn <> 8083 and @i_operacion = 'B') or
   (@t_trn <> 8083 and @i_operacion = 'P') or
   (@t_trn <> 8083 and @i_operacion = 'E') or
   (@t_trn <> 8083 and @i_operacion = 'U') or
   (@t_trn <> 8083 and @i_operacion = 'I') or
   (@t_trn <> 8083 and @i_operacion = 'H') or
   (@t_trn <> 8100 and @i_operacion = 'D')

begin
   /* Tipo de transaccion no corresponde */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 801077
   return 1
end

/*Tablas temporales insercion
Tabla              Operacion
-------            ---------- 
ba_tsarta            S
ba_tsarta_batch      B
ba_tparametro        P
ba_tenlace           E 

Tablas definitivas   I
Busqueda enlaces     H
Eliminacion lote     D
*/


/*** Insercion en tablas temporales ***/
/*Insercion ba_tsarta*/
if @i_operacion = 'S'
begin
   delete ba_tsarta where sa_tsarta = @i_sarta
   delete ba_tsarta_batch where sb_tsarta = @i_sarta
   delete ba_tenlace where en_tsarta = @i_sarta
   delete ba_tparametro where pa_tsarta = @i_sarta

   insert into ba_tsarta 
   values (@i_sarta, @i_nombre, @i_descripcion,
           @i_fecha_creacion, @i_creador,
           @i_producto, @i_dependencia, @i_autorizacion)

   if @@error <> 0
   begin
      /* 'Error en Insercion en la tabla temporal de batch       ' */
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 803006
      goto ERROR_BATCH
   end
   return 0
end

/*Insercion ba_tsarta_batch*/
if @i_operacion = 'B'
begin
   insert into ba_tsarta_batch 
          (sb_tsarta, sb_tbatch, sb_tsecuencial, sb_tdependencia, sb_trepeticion,
           sb_tcritico, sb_tleft, sb_ttop, sb_tlote_inicio, sb_thabilitado)
   values (@i_sarta, @i_batch, @i_secuencial, @i_dependencia, @i_repeticion, 
           @i_critico, @i_left, @i_top, @i_lote_inicio, @i_habilitado)
   if @@error <> 0 
   begin
   /* 'Error en Insercion en la tabla temporal de sarta_batch       ' */
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 803007
      goto ERROR_BATCH    
   end
   return 0
end

/*Insercion ba_tenlace*/
if @i_operacion = 'E'
begin
   insert into ba_tenlace values (@i_sarta, @i_batch_inicio, @i_secuencial_inicio, 
      @i_batch_fin, @i_secuencial_fin, @i_tipo_enlace, @i_puntos, @i_entre_lotes)
   if @@error <> 0 
      begin
      /* 'Error en Insercion en la tabla temporal de enlace    ' */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 803008
      goto ERROR_BATCH    
   end
   return 0
end

/*Insercion ba_tparametro*/
if @i_operacion = 'P'
begin
   /* Creacion automatica de parametros default para la sarta batch */
   if @i_actualiza = 'N'
   begin 
      declare cursor_parametros cursor for
       select  pa_parametro,
               pa_nombre,
               pa_tipo,
               pa_valor  
         from  ba_parametro
        where  pa_sarta = 0
          and  pa_batch = @i_batch
          and  pa_ejecucion  = 0
   end
   
   if @i_actualiza = 'S'
   begin 
    if exists (select 1 from ba_parametro where  pa_sarta = @i_sarta and  pa_batch = @i_batch and  pa_ejecucion = @i_secuencial)
     begin
      declare cursor_parametros cursor for
       select  pa_parametro,
               pa_nombre,
               pa_tipo,
               pa_valor  
         from  ba_parametro
        where  pa_sarta = @i_sarta
          and  pa_batch = @i_batch
          and  pa_ejecucion = @i_secuencial
     end
    else
     begin
      declare cursor_parametros cursor for
       select  pa_parametro,
               pa_nombre,
               pa_tipo,
               pa_valor  
         from  ba_parametro
        where  pa_sarta = 0
          and  pa_batch = @i_batch      
     end      
   end
   
   open cursor_parametros
   
   fetch cursor_parametros 
   into  @w_pa_tparametro,
         @w_pa_tnombre,
         @w_pa_ttipo,
         @w_pa_tvalor 
   
   while (@@fetch_status = 0)
   begin
      insert into ba_tparametro values ( 
         @i_sarta,
         @i_batch, 
         @i_secuencial, 
         @w_pa_tparametro,
         @w_pa_tnombre,
         @w_pa_ttipo,
         @w_pa_tvalor)
   
      if @@error <> 0 
      begin
         /* 'Error en Insercion en la tabla de parametros      ' */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file   = @t_file,
            @t_from   = @w_sp_name,
            @i_num    = 803009
         goto ERROR_BATCH
      end
   
      fetch cursor_parametros 
       into @w_pa_tparametro,
            @w_pa_tnombre,
            @w_pa_ttipo,
            @w_pa_tvalor 
      
   end  --end de while
   
   close cursor_parametros
   deallocate  cursor_parametros
   return 0
end

/***Insercion tablas definitivas***/
if @i_operacion = 'I'
begin
BEGIN TRAN

   /* Actualizacion de enlaces en las Temporales */
   declare links cursor for
      select en_tsarta,
             en_tbatch_fin,
             en_tsecuencial_inicio
        from cobis..ba_tenlace     
       where en_tsarta = @i_sarta
         and en_ttipo_enlace = 'D'
      order by en_tsecuencial_inicio
   for read only
   
   open links
   
   fetch links
   into  @w_lsarta,  
         @w_lbatch,
         @w_ldependencia
          
   while @@fetch_status = 0
   begin
      update cobis..ba_tsarta_batch
         set sb_tdependencia = @w_ldependencia
       where sb_tsarta = @w_lsarta
         and sb_tbatch = @w_lbatch
         and sb_tsecuencial > @w_ldependencia
         
      if @@error <> 0
      begin
         /* 'Error en actualizacion en la tabla temporal de sarta batch       ' */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 803002
         goto ERROR_BATCH
      end

      fetch links
      into  @w_lsarta,  
            @w_lbatch,
            @w_ldependencia     
   end
   
   close links
   deallocate  links


   if @i_actualiza = 'S'
   begin
      delete ba_enlace where en_sarta = @i_sarta
      delete ba_parametro where pa_sarta = @i_sarta
      delete ba_sarta_batch where sb_sarta = @i_sarta
      delete ba_sarta where sa_sarta = @i_sarta

      if @@rowcount = 0
      begin
         /* No se pudo borrar los campos */
         exec cobis..sp_cerror   
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 801031
         ROLLBACK TRAN
         goto ERROR_BATCH    
      end
   end
   
   /*Insercion del registro de la sarta*/
   select @w_sarta = sa_sarta
     from cobis..ba_sarta,cobis..cl_producto
    where sa_sarta = @i_sarta 
      and sa_producto = pd_producto
      
   if @@rowcount = 0
      select @w_existe = 0
   else
      select @w_existe = 1

   if @w_existe = 1 
   begin
      /* 'Codigo de sarta ya existe '*/
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 801005
      ROLLBACK TRAN
      goto ERROR_BATCH    
   end
        
   insert into cobis..ba_sarta
   select   sa_tsarta,
            sa_tnombre,
            sa_tdescripcion,
            sa_tfecha_creacion,
            sa_tcreador,
            sa_tproducto,   
            sa_tdependencia,  
            sa_tautorizacion
     from ba_tsarta
    where sa_tsarta = @i_sarta
 
   if @@error <> 0 
   begin
      /* 'Error en Insercion Final de la sarta       ' */
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 803010
      ROLLBACK TRAN
      goto ERROR_BATCH    
   end

   /**Insercion de registros en la sarta_batch **/
   insert into cobis..ba_sarta_batch
   select   sb_tsarta,
            sb_tbatch, 
            sb_tsecuencial,
            sb_tdependencia,
            sb_trepeticion,  
            sb_tcritico,
            sb_tleft,
            sb_ttop,
            sb_tlote_inicio,
            sb_thabilitado
     from ba_tsarta_batch
    where sb_tsarta = @i_sarta
    
   -- print '%1!', @@error
   
   if @@error <> 0 
   begin
      select @w_error_batch = 'S'
      /* 'Error en Insercion Final de la sarta_batch  ' */
      exec cobis..sp_cerror
         @t_debug  = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 803011       
      ROLLBACK TRAN
      goto ERROR_BATCH    
   end

/*Insercion de los parametros*/

   insert into cobis..ba_parametro
   select   pa_tsarta,
            pa_tbatch,
            pa_tejecucion,
            pa_tparametro,
            pa_tnombre,
            pa_ttipo,
            pa_tvalor
     from   ba_tparametro
    where   pa_tsarta = @i_sarta
   
      
   if @@error <> 0 
   begin
      select @w_error_param = 'S'
      /* 'Error en Insercion final de parametros ' */
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 803013
      ROLLBACK TRAN
      goto ERROR_BATCH    
   end

/**Insercion de los registros de enlaces **/

   insert into cobis..ba_enlace
   select   en_tsarta,
            en_tbatch_inicio,
            en_tsecuencial_inicio,
            en_tbatch_fin, 
            en_tsecuencial_fin,
            en_ttipo_enlace,
            en_tpuntos,
            en_tentre_lotes    
     from   ba_tenlace
    where   en_tsarta = @i_sarta

    
   if @@error <> 0 
   begin
      select @w_error_enlace = 'S'
      /* 'Error en Insercion final de enlaces ' */
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 803012
      ROLLBACK TRAN
      goto ERROR_BATCH    
   end


   if @w_error_batch = 'S' or @w_error_sarta = 'S' or @w_error_enlace = 'S' or @w_error_param = 'S'
   begin
      ROLLBACK TRAN
      goto ERROR_BATCH    
   end
   else
   begin
      COMMIT TRAN
      delete ba_tsarta 
      delete ba_tsarta_batch 
      delete ba_tenlace
      delete ba_tparametro
   end
return 0
end

/***Busqueda de enlaces***/
if @i_operacion = 'H'
begin
   set rowcount 20
   if @i_modo = 1   --Consulta los primeros 20 enlaces 
      begin
        select en_batch_inicio, 
               en_secuencial_inicio, 
               en_batch_fin,
               en_secuencial_fin, 
               en_tipo_enlace, 
               en_puntos, 
               sb_lote_inicio, 
               en_entre_lotes
         from cobis..ba_enlace, cobis..ba_sarta_batch 
        where en_sarta = sb_sarta
              and en_batch_inicio = sb_batch  
              and en_secuencial_inicio = sb_secuencial 
              and en_sarta = @i_sarta
        order by en_secuencial_inicio, en_secuencial_fin 

/*
        if @@rowcount = 0
           begin
              /* No existen enlaces asociados a esta sarta */
              exec cobis..sp_cerror   
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 808010
              return 1
           end
*/
         set rowcount 0
         return 0
      end

   if @i_modo = 2   --Consulta los siguientes 20 enlaces 
      begin
        select en_batch_inicio, 
               en_secuencial_inicio, 
               en_batch_fin,
               en_secuencial_fin, 
               en_tipo_enlace, 
               en_puntos, 
               sb_lote_inicio, 
               en_entre_lotes
         from cobis..ba_enlace, cobis..ba_sarta_batch 
        where en_sarta = sb_sarta
          and en_batch_inicio = sb_batch  
          and en_secuencial_inicio = sb_secuencial 
          and en_sarta = @i_sarta
          and ((    en_secuencial_inicio >= @i_secuencial_inicio
                    and en_secuencial_fin    >= @i_secuencial_fin)
                 or en_secuencial_inicio >= @i_secuencial_inicio + 1 )              
        order by en_secuencial_inicio, en_secuencial_fin 

/*
       if @@rowcount = 0
           begin
              /* No existen enlaces asociados a esta sarta */
              exec cobis..sp_cerror   
                   @t_debug = @t_debug,
                   @t_file  = @t_file,
                   @t_from  = @w_sp_name,
                   @i_num   = 808010
              return 1
           end
*/
       set rowcount 0
       return 0
      end
end

if @i_operacion = 'M'  --para maximizar
begin
set rowcount 20

      if @i_modo = 1   --Consulta los primeros 20 enlaces 
         begin
            select en_batch_inicio, en_secuencial_inicio, 
                  en_batch_fin, en_secuencial_fin, 
                  en_tipo_enlace, en_puntos, sb_lote_inicio, en_entre_lotes
        from cobis..ba_enlace, cobis..ba_sarta_batch 
       where en_sarta = sb_sarta
              and en_batch_inicio = sb_batch  
              and en_secuencial_inicio = sb_secuencial 
              and en_sarta = @i_sarta
              and sb_lote_inicio = @i_lote_inicio
            order by en_secuencial_inicio, en_secuencial_fin 

      if @@rowcount = 0
         begin
      /* No existen enlaces asociados a esta sarta */
      exec cobis..sp_cerror   
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 808010
      return 1
         end
            set rowcount 0
       return 0
         end

      if @i_modo = 2   --Consulta los siguientes 20 enlaces 
         begin
            select en_batch_inicio, en_secuencial_inicio, 
                  en_batch_fin, en_secuencial_fin, 
                  en_tipo_enlace, en_puntos, sb_lote_inicio, en_entre_lotes
        from cobis..ba_enlace, cobis..ba_sarta_batch 
       where en_sarta = sb_sarta
              and en_batch_inicio = sb_batch  
              and en_secuencial_inicio = sb_secuencial 
              and en_sarta = @i_sarta
              and en_secuencial_inicio >= @i_secuencial_inicio
              and sb_lote_inicio = @i_lote_inicio
            order by en_secuencial_inicio, en_secuencial_fin 

      if @@rowcount = 0
           begin
      /* No existen enlaces asociados a esta sarta */
      exec cobis..sp_cerror   
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 808010
      return 1
           end
            set rowcount 0
       return 0
         end

end



if @i_operacion = 'D'
begin

BEGIN TRAN

   delete ba_sarta where sa_sarta = @i_sarta
   if @@error <> 0 
   begin
   /* 'Error en Insercion en la tabla temporal de batch       ' */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 803001
                
         return 1
   end

   delete ba_sarta_batch where sb_sarta = @i_sarta
   if @@error <> 0 
   begin
   /* 'Error en Insercion en la tabla temporal de batch       ' */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 803001
                ROLLBACK TRAN                
         return 1
   end
   delete ba_parametro where pa_sarta = @i_sarta
   if @@error <> 0 
   begin
   /* 'Error en Insercion en la tabla temporal de batch       ' */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 803001
                ROLLBACK TRAN                
         return 1
   end
   delete ba_enlace where en_sarta = @i_sarta
   if @@error <> 0 
   begin
   /* 'Error en Insercion en la tabla temporal de batch       ' */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 803001
                ROLLBACK TRAN
         return 1
   end

    COMMIT TRAN
         

return 0
end

/*Errores al ingreso del modulo batch*/
ERROR_BATCH:
   delete ba_tsarta where sa_tsarta = @i_sarta
   delete ba_tsarta_batch where sb_tsarta = @i_sarta
   delete ba_tenlace where en_tsarta = @i_sarta
   delete ba_tparametro where pa_tsarta = @i_sarta
     return 1

go                                                                              