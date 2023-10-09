/************************************************************************/
/*  Archivo:            cu_cporest.sp                                    */ 
/*  Stored procedure:   sp_porcentaje_estrato                            */
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
/*Este es un procedimiento que permite almacenar la parametrización del */
/*porcentaje a aplicar para la valoración de la garantía de acuerdo a la*/
/*ciudad y estrato de la garantía.                                      */ 
/* **********************************************************************/
/*                       MODIFICACIONES                                 */
/* FECHA       AUTOR     RAZON                                          */
/* 18/jul/2005 A.Tovar   Emsion Inicial                                 */                                                         
/************************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_porcentaje_estrato')
   drop proc sp_porcentaje_estrato
go

create proc sp_porcentaje_estrato(
	@t_debug         char(1)        = 'N',
	@t_file          varchar(10) 	= null,
    @i_ciudad        catalogo       = null, 
    @i_porcentaje    float       = null,
    @t_trn           smallint       = null,
    @i_operacion     char(1)        = null,
    @i_estrato       catalogo       = null,
    @i_modo          int = null



)

as 
declare  /* Declaracion de Variables */
         @w_sp_name                     varchar(32),
         @w_return                      int,
         @w_ciudad                      catalogo,
         @w_existe                      tinyint ,
         @w_porcentaje                  float,
         @w_error                       int,
         @w_estrato                     catalogo,
	 @w_desc_ciudad   		descripcion
         
         
/* DATOS GENERALES */
select @w_sp_name = 'sp_porcentaje_estrato'
 
       
 
/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19974 and @i_operacion = 'I') or
   (@t_trn <> 19975 and @i_operacion = 'U') or
   (@t_trn <> 19976 and @i_operacion = 'E') or --Reasignacion
   (@t_trn <> 19977 and @i_operacion = 'S') --emg feb-25-02 Reasignacion de Cobranzas

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
    @w_ciudad       =  cp_ciudad,
    @w_estrato      =  cp_estrato,
    @w_porcentaje   =  cp_porcentaje
    from cob_custodia..cu_ciu_porcest
    where cp_ciudad = @i_ciudad
    and cp_estrato = @i_estrato	
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

    insert into cob_custodia..cu_ciu_porcest(
    cp_ciudad,cp_estrato,cp_porcentaje)
     values (@i_ciudad, @i_estrato,@i_porcentaje)

     
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
         update cob_custodia..cu_ciu_porcest
         set cp_porcentaje = @i_porcentaje
         where cp_ciudad = @i_ciudad
	 and cp_estrato = @i_estrato
	
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
         delete cob_custodia..cu_ciu_porcest
         where  cp_ciudad = @i_ciudad
     	 and    cp_estrato = @i_estrato
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
   	"CODIGO CIUDAD"   = cp_ciudad, 
        "DESCRIPCION CIUDAD" = (select c.valor from cobis..cl_catalogo c,cobis..cl_tabla t
				    where c.codigo = X.cp_ciudad
    				    and t.codigo = c.tabla
    				    and t.tabla  = "cl_ciudad"),
	"ESTRATO"  = cp_estrato,
	"DESCRIPCION ESTRATO" = (select c.valor from cobis..cl_catalogo c,cobis..cl_tabla t
				    where c.codigo = X.cp_estrato
    				    and t.codigo = c.tabla
    				    and t.tabla  = "cl_estrato"),-- "cu_estrato_ciudad"),	
	"PORCENTAJE" = cp_porcentaje 
       from cob_custodia..cu_ciu_porcest X       
       order by cp_ciudad, cp_estrato
 
     end

  if @i_modo = 1
   begin
      select 
   	"CODIGO CIUDAD"   = cp_ciudad, 
        "DESCRIPCION CIUDAD" = (select c.valor from cobis..cl_catalogo c,cobis..cl_tabla t
				    where c.codigo = X.cp_ciudad
    				    and t.codigo = c.tabla
    				    and t.tabla  = "cl_ciudad"),
	"ESTRATO"  = cp_estrato,
	"DESCRIPCION ESTRATO" = (select c.valor from cobis..cl_catalogo c,cobis..cl_tabla t
				    where c.codigo = X.cp_estrato
    				    and t.codigo = c.tabla
    				    and t.tabla  = "cl_estrato"),--"cu_estrato_ciudad"),	
	"PORCENTAJE" = cp_porcentaje 
       from cob_custodia..cu_ciu_porcest X    
       where (cp_ciudad = @i_ciudad and cp_estrato > @i_estrato) or (cp_ciudad> @i_ciudad)
       order by cp_ciudad, cp_estrato
 
     end

     return 0
end 

go
