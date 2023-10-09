/************************************************************************/
/*	Archivo: 		indcom.sp  				*/
/*	Stored procedure: 	sp_indcom				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Maria Victoria Garay 			*/
/*	Fecha de escritura:     17-Marzo-1998 				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	   Mantenimiento de la tabla cb_indcom				*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_indcom')
    drop proc sp_indcom

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_indcom (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_corr               char(1)  = null,
   @s_ssn_corr           int      = null,
   @s_ofi                smallint  = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_ofic_destino       smallint = null,    
   @i_modo		 tinyint = 0,
   @i_empresa            tinyint = null,   
   @i_tarindcom          float  = null,  
   @i_taravtab           float  = null,  
   @i_ciudad		 int = null
) 
as

declare
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,        /* existe el registro*/
   @w_empresa      	 tinyint,   
   @w_ciudad		 int,
   @w_ciudad_admin       int,
   @w_flag               char(2),    /* Indica que no hay mas registros */ 
   @w_oficina_admin      smallint,
   @w_tarindcom          float,
   @w_tartab             float

select @w_sp_name = 'sp_indcom'
select @w_flag = '00'  

/*  Modo de debug  */
if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select  '/**  Stored Procedure  **/ ' = @w_sp_name,
		s_ssn                      = @s_ssn,
		s_user                     = @s_user,
		s_term                     = @s_term,   
		s_date                     = @s_date,   
		t_debug                    = @t_debug,  
		t_file                     = @t_file,
		t_from                     = @t_from,
		t_trn                      = @t_trn,
		i_modo                     = @i_modo,
		i_operacion		   = @i_operacion,
                i_empresa  		   = @i_empresa,
		i_ciudad		   = @i_ciudad

	exec cobis..sp_end_debug
end

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 6015 and @i_operacion = 'I') or /* Insercion */
   (@t_trn <> 6040 and @i_operacion = 'U') or /* Update */
   (@t_trn <> 6044 and @i_operacion = 'D') or /* Eliminacion */
   (@t_trn <> 6045 and @i_operacion = 'A') or /* Search */
   (@t_trn <> 6046 and @i_operacion = 'Q') or /* busca uno */
   (@t_trn <> 6047 and @i_operacion = 'V')  /* trae la ciudad */

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
if @i_operacion <> 'A' and @i_operacion <> 'V'
begin
    select @w_empresa = in_empresa,   
	   @w_ciudad = in_municipio,
           @w_tarindcom = in_tar_indcom,
           @w_tartab = in_tar_avtab 
    from cob_conta..cb_indcom
    where in_empresa = @i_empresa and 
          in_municipio = @i_ciudad  

    if @@rowcount = 0
            select @w_existe = 0
    else
            select @w_existe = 1
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U' or @i_operacion = 'D'
begin
    if 
         @i_empresa is NULL or    
         @i_ciudad  is NULL 
    begin 
    /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 601001
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
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 601160
        return 1 
    end

    begin tran
         insert into cb_indcom(
    	      in_empresa,    
	      in_municipio,
	      in_tar_indcom,
              in_tar_avtab   )   
         values (
              @i_empresa,   
	      @i_ciudad,
              @i_tarindcom,
              @i_taravtab)    

         if @@error <> 0 
         begin
         /* Error en insercion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 601161
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
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 605082

        return 1 
    end

    begin tran
         update cob_conta..cb_indcom
	    set in_empresa = @i_empresa,   
		in_municipio = @i_ciudad ,
                in_tar_indcom = @i_tarindcom, 
                in_tar_avtab = @i_taravtab    
         where  in_empresa = @i_empresa and  
                in_municipio = @i_ciudad 

         if @@error <> 0 
         begin
         /* Error en actualizacion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 605081
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
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 605082
        return 1 
    end

    begin tran
         delete cob_conta..cb_indcom
    where in_empresa = @i_empresa and   
          in_municipio = @i_ciudad 
                            
         if @@error <> 0
         begin
         /*Error en eliminacion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 607022
             return 1 
         end

    commit tran
    return 0
end

/* Consulta opcion ALL */
/***********************/

if @i_operacion = 'A'
begin
        set rowcount 20

	if @i_modo = 0
	begin
	     select 
		    'CIUDAD'		= in_municipio,
		    'DESCRIPCION CIUDAD' = substring(ci_descripcion,1,20),
                    'DEPARTAMENTO' = substring(pv_descripcion,1,20),
                    'TARIFA_IND_COM'    = in_tar_indcom, 
                    'TARIFA_AVI_TAB'    = in_tar_avtab 
	     from cob_conta..cb_indcom,  cobis..cl_ciudad, cobis..cl_provincia
	     where in_municipio = ci_ciudad  and
                   in_empresa = @i_empresa and
                   pv_provincia = ci_provincia
	     order by in_municipio

	     if @@rowcount = 0
    	     begin
               if @@error <> 0
               begin
                 /*No existen registros */
                 exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file, 
                 @t_from  = @w_sp_name,
                 @i_num   = 601159
                 return 1 
               end
               set rowcount 0
             end
             set rowcount 0
             return 0
	end
	if @i_modo = 1
	begin
            select  
                    'CIUDAD'            = in_municipio, 
		    'DESCRIPCION CIUDAD'   = substring(ci_descripcion,1,20),
                    'DEPARTAMENTO' = substring(pv_descripcion,1,20),
                    'TARIFA IND_COM'    = in_tar_indcom,
                    'TARIFA AVI_TAB'    = in_tar_avtab
             from cob_conta..cb_indcom, cobis..cl_ciudad, cobis..cl_provincia
             where in_municipio = ci_ciudad  and
                   in_empresa = @i_empresa and 
                   ((in_municipio = @i_ciudad)
                   or (in_municipio > @i_ciudad )) and
                   pv_provincia = ci_provincia
	     order by in_municipio 

	     if @@rowcount = 0
    	     begin
               if @@error <> 0
               begin
                 /*No existen registros */
                 exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file, 
                 @t_from  = @w_sp_name,
                 @i_num   = 601159
                 return 1 
               end
               select @w_flag = '10'
               select @w_flag 
               set rowcount 0
             end
             set rowcount 0
             return 0
	end
	
	return 0
end   


/* Busca una tarifa  de industria y comercio */
if @i_operacion = 'Q'
begin

	 if @w_existe = 1    
         begin                  
          select   @w_empresa,
                   @w_ciudad,
                   @w_tarindcom,
                   @w_tartab   
         end   
         else
         begin
             if @@rowcount = 0
    	     begin
               if @@error <> 0
               begin
                 /*No existen registros */
                 exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file, 
                 @t_from  = @w_sp_name,
                 @i_num   = 601159
                 return 1 
               end
             end
         end
   return 0
end


/* operacion para traer la ciudad */

if @i_operacion = 'V'
begin
         /* encuentra la oficina admin de la oficina destino */

	     select @w_oficina_admin = re_ofadmin
             from cb_relofi
             where
                re_ofconta = @i_ofic_destino

	     if @@rowcount = 0
    	     begin
              /*No existen registros */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file, 
                @t_from  = @w_sp_name,
                @i_num   =  607132
                return 1
             end

         /* averigua la ciudad de la oficina admin  */

	     select @w_ciudad_admin = of_ciudad
             from cobis..cl_oficina
             where
                of_oficina = @w_oficina_admin

	     if @@rowcount = 0
    	     begin
              /*No existen registros */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file, 
                @t_from  = @w_sp_name,
                @i_num   = 601159
                return 1
             end
             select @w_ciudad_admin
        return 0
end
go
