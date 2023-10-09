/************************************************************************/
/* Archivo:                impresor.sp                                  */
/* Stored procedure:       sp_impresora                                 */
/* Base de datos:          cobis                                        */
/* Producto:               batch                                        */
/* Disenado por:                                                        */
/* Fecha de escritura:     10-Octubre-2003                              */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    "MACOSA", representantes exclusivos para el Ecuador de la         */
/*    "NCR CORPORATION".                                                */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de MACOSA o su representante.               */
/************************************************************************/
/*                          PROPOSITO                                   */
/*    Este programa procesa las transacciones de: Mantenimiento         */
/*    de impresoras Unix                                                */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    10-Oct-2003    D. Ayala        Emision inicial                    */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_impresora')
   drop proc sp_impresora  

go
create proc sp_impresora  (
   @s_ssn         int = null,
   @s_date        datetime = null,
   @s_user        login = null,
   @s_term        descripcion = null,
   @s_corr        char(1) = null,
   @s_ssn_corr    int = null,
        @s_ofi       smallint = null,
   @t_rty         char(1) = null,
        @t_trn       smallint = 601,
   @t_debug    char(1) = 'N',
   @t_file        varchar(14) = null,
   @t_from        varchar(30) = null,
   @i_operacion      char(1),
   @i_ubicacion      descripcion = null,
   @i_comando     descripcion = null,
   @i_nombre      descripcion = null,
   @i_dstserver      varchar(64) = '',
   @i_archivo     varchar(255) = null,
   @i_secuencial     int = null,
   @i_shell    varchar(255) = null

)
as 
declare
   @w_today    datetime,   /* fecha del dia */
   @w_return   int,     /* valor que retorna */
   @w_sp_name  varchar(32),   /* nombre del stored procedure*/
   @w_siguiente   tinyint,
   @w_sarta        int,
   @w_batch    int,
   @w_ejecucion      smallint,
   @w_parametro   smallint,
   @w_tipo        char(1) ,
   @w_valor varchar(255) ,   --SSO 12/06/2002 Upgrade Batch
   @w_aux1     descripcion ,
   @w_aux2     descripcion ,
   @w_count int,

   @w_existe   int,     /* codigo existe = 1 
                  no existe = 0 */
   @w_secuencial  int,
   @w_ubicacion   descripcion,
   @w_comando  varchar(255),
   @w_nombre   descripcion

select @w_today = getdate()
select @w_sp_name = 'sp_impresora'


/************************************************/
/*  Tipo de Transaccion          */


if (@t_trn <> 8106 and @i_operacion = 'I') or   -- INGESA
   (@t_trn <> 8108 and @i_operacion = 'U') or   -- MODIFICA
   (@t_trn <> 8107 and @i_operacion = 'D') or   -- ELIMINA
   (@t_trn <> 8110 and @i_operacion = 'S') or   -- BUSCA IMPRESORAS
   (@t_trn <> 8109 and @i_operacion = 'E')   -- EJECUTA IMPRESION
begin
   /* 'Tipo de transaccion no corresponde' */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file   = @t_file,
   @t_from   = @w_sp_name,
   @i_num    = 601077
   return 1
end
/************************************************/


/* Chequeo de Existencias */
/**************************/


if @i_operacion <> 'S' 
begin
   select  @w_secuencial   = im_secuencial,
      @w_ubicacion   = im_ubicacion,
      @w_comando  = im_comando,
      @w_nombre   = im_nombre
   from cobis..ba_impresora
   where im_secuencial = @i_secuencial

   if @@rowcount > 0
      select @w_existe = 1 
   else
      select @w_existe = 0

end


/* Insercion de parametro */
/*************************/

if @i_operacion = 'I'
begin

   /* Insercion del registro */
   /**************************/

   begin tran
      -- GENERAR SECUENCIAL
      SELECT @w_secuencial = isnull(im_secuencial, 0)
      from  cobis..ba_impresora
      
      select @w_secuencial = isnull(@w_secuencial, 0) +1

      insert into cobis..ba_impresora  (
      im_secuencial,
      im_ubicacion,
      im_comando,
      im_nombre)
      values (
      @w_secuencial,
      @i_ubicacion,
      @i_comando,
      @i_nombre
      )
      if @@error <> 0 
      begin
         /* 'Error en insercion de impresora' */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 808054
         return 1
      end

   commit tran
      select @w_secuencial
   return 0
end

/* Actualizacion de parametro  (Update) */
/***************************************/

if @i_operacion = 'U'
begin
   if @w_existe = 0 
   begin
      /* 'Secuencial de impresora NO existe'*/
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 808055
      return 1
   end

   /*  Actualizacion del registro  */
   /********************************/

   begin tran
      update cobis..ba_impresora
      set   im_ubicacion   = @i_ubicacion,
         im_comando  = @i_comando,
         im_nombre   = @i_nombre
      where    im_secuencial = @i_secuencial

      if @@error <> 0
      begin
         /* 'Error en Actualizacion de impresora'*/ 
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 808056
         return 1
      end

   commit tran
   return 0
end

/* Eliminacion de parametro  (Delete) */
/***************************************/

if @i_operacion = 'D'
begin
   if @w_existe = 0 
   begin
      /* 'Secuencial de impresora NO existe' */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 808050
      return 1
   end


   /*  Eliminacion del registro  */
   /********************************/

   begin tran
      delete cobis..ba_impresora
      where im_secuencial = @i_secuencial

      if @@error <> 0
      begin
         /* 'Error en Eliminacion de impresora' */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 808057
         return 1
      end
         commit tran
    return 0
end

/**** Search ****/
/****************/

if @i_operacion = 'S'
begin
   set rowcount 15
   select @i_secuencial = isnull(@i_secuencial, 0)

   select   'Secuencial'   = im_secuencial,
      'Ubicacion'    = im_ubicacion,
      'Comando'   = im_comando,
      'Nombre' = im_nombre
   from  cobis..ba_impresora
   where   im_secuencial > @i_secuencial

   set rowcount 0
   return 0
   
end

if @i_operacion = 'E'
begin

   if isnull(@i_comando, '') = ''
      select @i_comando = 'lp'
   else
      select @i_comando = ltrim(rtrim(@i_comando))

   select @w_comando = @i_dstserver + '...rp_exec "' 
   select @w_comando = @w_comando + rtrim(ltrim(@i_shell)) + '", ' 
   select @w_comando = @w_comando + @i_comando + '", "' 
   select @w_comando = @w_comando + rtrim(ltrim(@i_nombre)) + '", ' 
   select @w_comando = @w_comando + rtrim(ltrim(@i_archivo))+ '"'

   exec (@w_comando)
   return 0

end

go

