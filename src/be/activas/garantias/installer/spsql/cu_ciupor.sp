/************************************************************************/
/*  Archivo:            cu_ciupor.sp                                    */ 
/*  Stored procedure:   sp_ciudad_porcentaje                            */
/*  Base de datos:      COB_CUSTODIA                                    */
/*  Producto:           GARANTIAS                                       */
/*  Disenado por:       Silvia Portilla                             	*/
/*  Fecha de escritura: Julio 7 de 2005                                 */
/************************************************************************/
/*                        IMPORTANTE                                    */
/* Este programa es parte de los paquetes bancarios propiedad de        */
/* "MACOSA", representantes exclusivos para el Ecuador de la            */
/* "NCR CORPORATION".                                                   */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier */
/* alteracion o agregado hecho por alguno de sus usuarios sin el debido */
/* consentimiento por escrito de la Presidencia Ejecutiva de "MACOSA"   */
/* o su representante.                                                  */
/************************************************************************/
/*                         PROPOSITO                                    */
/*Este es un procedimiento que permite almacenar la parametrizaci¢n del */
/*porcentaje a aplicar para la valoraci¢n de la garant¡a de acuerdo a la*/
/*ciudad de la garant¡a.                                                */ 
/* **********************************************************************/
/*                       MODIFICACIONES                                 */
/* FECHA       AUTOR     RAZON                                          */
/* 18/jul/2005 A.Tovar   Emsion Inicial                                 */                                                         
/************************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_ciudad_porcentaje')
   drop proc sp_ciudad_porcentaje
go

create proc sp_ciudad_porcentaje(
	@t_debug         char(1)        = 'N',
	@t_file          varchar(10) 	= null,
    @i_ciudad        catalogo       = null, 
    @i_porcentaje    float          = null,
    @t_trn           smallint       = null,
    @i_operacion     char(1)        = null,
    @i_modo         int = null
)

as 
declare  /* Declaracion de Variables */
         @w_sp_name                     varchar(32),
         @w_return                      int,
         @w_ciudad                      catalogo,
         @w_existe                      tinyint ,
         @w_porcentaje                  float,
         @w_error                       int,
	 @w_desc_ciudad			descripcion   
         
/* DATOS GENERALES */
select @w_sp_name = 'sp_ciudad_porcentaje'
 
       
 

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19970 and @i_operacion = 'I') or
   (@t_trn <> 19971 and @i_operacion = 'U') or
   (@t_trn <> 19972 and @i_operacion = 'E') or --Reasignacion
   (@t_trn <> 19973 and @i_operacion = 'S') --emg feb-25-02 Reasignacion de Cobranzas
BEGIN
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
END


/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S'
begin
    select 
   	@w_ciudad             = cp_ciudad, 
	@w_porcentaje 	      = cp_porcentaje 
    from cob_custodia..cu_ciudad_porcentaje
    where cp_ciudad = @i_ciudad
    --and  cp_porcentaje = @i_porcentaje	


    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0
end

    
/*  INSERCION */    
/**************/

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

    insert into cob_custodia..cu_ciudad_porcentaje(
    cp_ciudad,cp_porcentaje)
     values (@i_ciudad, @i_porcentaje)
     
      if @@error <> 0 
      begin
       /* Error en insercion de registro */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1903001
         return 1 
      end
      
  
      
  commit tran
  return 0
end     


/*ACTUALIZACION*/
/***************/
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
         update cob_custodia..cu_ciudad_porcentaje
         set cp_porcentaje = @i_porcentaje
         where cp_ciudad = @i_ciudad
	   
	     if @@error <> 0 
         begin
         /* Error en actualizacion de registro */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1905001
             return 1 
         end
    commit tran

    return 0
end      


/* Eliminacion de registros */
/****************************/

if @i_operacion = 'E'
begin
    if @w_existe = 0
    begin
    /* Registro a eliminar no existe */
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1907002
        return 1 
    end
    else
    begin tran
         delete cob_custodia..cu_ciudad_porcentaje
         where  cp_ciudad = @i_ciudad
     	 and    cp_porcentaje = @i_porcentaje
   	   
       
         if @@error <> 0
         begin
         /*Error en eliminacion de registro */
             exec cobis..sp_cerror
             @t_from= @w_sp_name,
             @i_num   = 1907001
             return 1 
         end
    commit tran
    return 0
end


/*RETORNAR LOS DATOS DE LA PARAMETRIZACION AL FRONTEND */
/*******************************************************/

if @i_operacion = 'S' 
  begin 
    
   set rowcount 20

   if @i_modo = 0
   begin
     select 
   	"CODIGO CIUDAD" = cp_ciudad, 
   	"DESCRIPCION CIUDAD" = c.valor,
	"PORCENTAJE" = cp_porcentaje 
     from cob_custodia..cu_ciudad_porcentaje,cobis..cl_catalogo c,cobis..cl_tabla t
     where c.codigo = cp_ciudad
     and t.codigo = c.tabla
     and t.tabla  = "cl_ciudad"
     order by cp_ciudad
   end

   if @i_modo = 1
   begin
     select 
   	"CODIGO CIUDAD" = cp_ciudad, 
   	"DESCRIPCION CIUDAD" = c.valor,
	"PORCENTAJE" = cp_porcentaje 
     from cob_custodia..cu_ciudad_porcentaje,cobis..cl_catalogo c,cobis..cl_tabla t
     where c.codigo = cp_ciudad
     and t.codigo = c.tabla
     and t.tabla  = "cl_ciudad"
     and cp_ciudad  > @i_ciudad
     order by cp_ciudad
   end

 
   set rowcount 0
         
  
end 

return 0
go

