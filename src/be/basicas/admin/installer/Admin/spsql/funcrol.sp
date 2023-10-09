/************************************************************************/
/*	Archivo:		funcrol.sp				*/
/*	Stored procedure:	sp_funcionalidad_rol			*/
/*	Base de datos:		cobis					*/
/*	Producto: 		ADMIN-Seguridades			*/
/*	Disenado por:  		Alexis Rodriguez Morales		*/
/*	Fecha de escritura: 	13-FEB-2001				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA". 							*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa maneja la asociación entre roles y grupos de 	*/
/*	funcionalidades en el nuevo esquema de seguridades para 	*/
/*	COBIS WEB							*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_funcionalidad_rol')
   drop proc sp_funcionalidad_rol
go

create proc sp_funcionalidad_rol (
 @s_ssn   int   = NULL,
 @s_user   login   = NULL,
 @s_sesn   int   = NULL,
 @s_term   varchar(30)  = NULL,
 @s_date   datetime  = NULL,
 @s_srv   varchar(30)  = NULL,
 @s_lsrv   varchar(30)  = NULL, 
 @s_rol   smallint  = NULL,
 @s_ofi   smallint  = NULL,
 @s_org_err  char(1)  = NULL,
 @s_error  int   = NULL,
 @s_sev   tinyint  = NULL,
 @s_msg   descripcion  = NULL,
 @s_org   char(1)  = NULL,
 @t_debug  char(1)  = 'N',
 @t_file   varchar(14)  = null,
 @t_from   varchar(32)  = null,
 @t_trn   smallint  = NULL,
 @i_operacion  varchar(1),
 @i_tipo   varchar(1) = NULL,
 @i_modo   smallint  = 0,
 @i_rol   tinyint  = NULL,
 @i_func   char(12) = NULL,
 @i_valor  catalogo = '%'
)
as
declare
 @w_today  datetime,
 @w_return  int,
 @w_sp_name  varchar(32)
select  @w_today = @s_date,
 @w_sp_name = 'sp_funcionalidad_rol'
/******** INSERCION *******/
if @i_operacion = 'I'
begin
 /****** CONTROL TRANSACCION ******/
 if @t_trn = 15280
 begin
  /***** CONTROL NULOS ********/
  if (
     @i_func is null or
     @i_rol is null
     )
  Begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num  = 151001
   return 1
  end
  /******** CONTROL DE EXISTENCIA DEL ROL  *******/
  if not exists ( select *
    from ad_rol
    where ro_rol=@i_rol)
  Begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num  = 151026 
   return 1
  End
  
  /******** CONTROL DE EXISTENCIA DE LA FUNCIONALIDAD *******/
  if not exists ( select *
    from aw_funcionalidad
    where fn_func = @i_func)
  Begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num  = 151131
   return 1
  End
  /******* INSERCION ********/
  insert into aw_func_rol(
  fr_rol,  fr_func)
  values (
  @i_rol,  @i_func)
 
  /******** ERROR INSERCION *********/
  if @@error<>0 
  Begin
   exec cobis..sp_cerror
       @t_debug = @t_debug,
       @t_file  = @t_file,
       @t_from  = @w_sp_name,
       @i_num  = 153064
  
   return 1
  End
   return 0
 end
 else
 /******* TRANSACCION INCORRECTA **********/
 begin 
  exec cobis..sp_cerror
     @t_debug = @t_debug,
     @t_file  = @t_file,
     @t_from  = @w_sp_name,
     @i_num  = 141018
  return 1
 end  
end   
/******* FIN INSERCION *********/
/********* BORRADO ********/
if @i_operacion = 'D'
begin
 /******** CONTROL DE TRANSACCION ********/
 if @t_trn = 15281
 begin
 
  /****** CONTROL DE EXISTENCIA DE ASOCIACION DE FUNC A ROL *******/
  if not exists ( select *
    from aw_func_rol
    where fr_rol=@i_rol
    and fr_func=@i_func)
  Begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num  = 151148
   return 1
    end
  /***** BORRADO *******/
  delete aw_func_rol
  where fr_rol=@i_rol
  and fr_func=@i_func
  
  /******** ERROR BORRADO ********/
     if @@error != 0
     begin
   exec cobis..sp_cerror
       @t_debug = @t_debug,
       @t_file  = @t_file,
       @t_from  = @w_sp_name,
       @i_num  = 157089
   return 1
     end
  return 0
 end
 else 
 /******* ERROR TRANSACCION *********/
 begin
  exec cobis..sp_cerror
     @t_debug = @t_debug,
     @t_file  = @t_file,
     @t_from  = @w_sp_name,
     @i_num  = 141018
  return 1
 end
end  
/********* FIN BORRAR *********/
/********* SEARCH ***********/
if @i_operacion = 'S'
begin
 /*********** CONTROL TRANSACCION **************/
 If @t_trn = 15282
 begin
  /*** BUSQUEDA DE FUNCIONALIDADES DISPONIBLES PARA UN ROL  ****/
  if @i_tipo='1'
  begin
        if @i_modo = 0
        begin
 
    /***** CONTROL NULOS ********/
    if (
        @i_rol is null
           )
    Begin
     exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num  = 151001
 
     return 1
    end
 
 
         set rowcount 20
 
    /***** SEARCH *****/
 
    select 'Funcionalidad'= fn_func
    from aw_funcionalidad
    where fn_func like @i_valor
    and fn_func not in (
       select fr_func
       from aw_func_rol
       where fr_rol=@i_rol
          )
    order by fn_func
 
          set rowcount 0
          return 0
        end
        /*** Fin Modo 0 ***/
       if @i_modo = 1
       begin
 
    /***** CONTROL NULOS ********/
    if (
        @i_func is null or
        @i_rol is null
           )
    Begin
     exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num  = 151001
 
     return 1
    end
 
         set rowcount 20
 
    /***** SEARCH *****/
 
    select 'Funcionalidad'= fn_func
    from aw_funcionalidad
    where fn_func like @i_valor
    and fn_func > @i_func
    and fn_func not in (
       select fr_func
       from aw_func_rol
       where fr_rol=@i_rol
          )
    order by fn_func
 
    set rowcount 0
    return 0
        end
   /*** Fin Modo 1 ***/
  
  end
  /*** Fin Tipo 1 ***/
  /*** BUSQUEDA DE FUNCIONALIDADES ASIGNADAS A UN ROL ****/
  if @i_tipo='2'
  begin
        if @i_modo = 0
        begin
 
    /***** CONTROL NULOS ********/
    if (
        @i_rol is null
           )
    Begin
     exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num  = 151001
 
     return 1
    end
 
 
         set rowcount 20
 
    /***** SEARCH *****/
 
    select 'Funcionalidad'=fr_func
    from aw_func_rol
    where  fr_rol=@i_rol
    order by fr_func
 
          set rowcount 0
          return 0
        end
        /*** Fin Modo 0 ***/
       if @i_modo = 1
       begin
 
    /***** CONTROL NULOS ********/
    if (
        @i_func is null or
        @i_rol is null
           )
    Begin
     exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num  = 151001
 
     return 1
    end
 
         set rowcount 20
 
    /***** SEARCH *****/
 
    select 'Funcionalidad'=fr_func
    from aw_func_rol
    where  fr_rol=@i_rol
    and fr_func > @i_func
    order by fr_func
 
    set rowcount 0
    return 0
        end
   /*** Fin Modo 1 ***/
  
  end
  
  /*** Fin Tipo 2 ***/  
  /*** BUSQUEDA DE FUNCIONALIDADES Y PADRES ASIGNADAS A UN ROL ****/
  if @i_tipo='3'
  begin
        if @i_modo = 0
        begin
 
    /***** CONTROL NULOS ********/
    if (
        @i_rol is null
           )
    Begin
     exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num  = 151001
 
     return 1
    end
 
 
         set rowcount 20
 
    /***** SEARCH *****/
 
    select 'Funcionalidad' = fr_func,
           'Padre' = fn_padre,
           'Nemonico' = fn_nemonico,
           'Visible' = fn_visible      /*DCU*/
    from aw_func_rol, aw_funcionalidad
    where  fr_rol=@i_rol
           and fr_func=fn_func
    order by fr_func 
          set rowcount 0
          return 0
        end
        /*** Fin Modo 0 ***/
       if @i_modo = 1
       begin
 
    /***** CONTROL NULOS ********/
    if (
        @i_func is null or
        @i_rol is null
           )
    Begin
     exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num  = 151001
 
     return 1
    end
 
         set rowcount 20
 
    /***** SEARCH *****/
 
    select 'Funcionalidad' = fr_func,
           'Padre' = fn_padre,
           'Nemonico' = fn_nemonico,
           'Visible' = fn_visible  /*DCU*/
    from aw_func_rol, aw_funcionalidad
    where  fr_rol=@i_rol
     and fr_func=fn_func
     and fr_func > @i_func
    order by fr_func 
    set rowcount 0
    return 0
        end
   /*** Fin Modo 1 ***/
  
  end
  
  /*** Fin Tipo 2 ***/  
 end
 else
 /***** TRANSACCION INCORRECTA **********/
 begin
  exec cobis..sp_cerror
      @t_debug  = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num  = 141018
   return 1
 end
end
/********* FIN SEARCH *********/
go