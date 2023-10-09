/************************************************************************/
/*	Archivo: 		banco.sp  				*/
/*	Stored procedure: 	sp_banco				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     22-Enero-1995 				*/
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
/*	   Mantenimiento al catalogo de Bancos                          */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	22/Ene/1995	G Jaramillo     Emision Inicial			*/
/*	04-Mar-1999	Juan C. G¢mez	Nuevo par metro y cambio de 	*/
/*					nombre en un par metro JCG10	*/	
/*	07/Mar/1999	Juan C. G¢mez   Cambio en el query JCG20	*/	
/*	26/Abr/1999	Juan C. G¢mez	Se llama a error JCG30		*/
/*	06/Abr/2006	Nidia  Nieto	NR 477 BAC       		*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_banco')
    drop proc sp_banco
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_banco (
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
   @i_modo               smallint = null,
   @i_empresa            tinyint  = null,
   @i_ctacte             varchar( 20)  = null,	--JCG10
   @i_nombre             descripcion  = null,
   @i_cuenta             cuenta  = null,
   @i_cuenta1		 cuenta = null,
   @i_banco		 varchar(3),
   @i_ope_ent	         char(4) = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,        /* existe el registro*/
   @w_empresa            tinyint,
   @w_ctacte             varchar( 20),
   @w_nombre             descripcion,
   @w_cuenta             cuenta,
   @w_moneda		 descripcion,
   @w_banco		 varchar(3),	--JCG10
   @w_ope_ent            char (4)

select @w_today = getdate()
select @w_sp_name = 'sp_banco'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 6741 and @i_operacion = 'I') or
  (@t_trn <> 6742 and @i_operacion = 'U') or
  (@t_trn <> 6743 and @i_operacion = 'D') or
  (@t_trn <> 6744 and @i_operacion = 'V') or
  (@t_trn <> 6746 and @i_operacion = 'Q') or
  (@t_trn <> 6747 and @i_operacion = 'A') or
  (@t_trn <> 6745 and @i_operacion = 'S') or
  (@t_trn <> 6748 and @i_operacion = 'C') or
  (@t_trn <> 6749 and @i_operacion = 'O')

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
    select @w_empresa = ba_empresa,
           @w_ctacte  = ba_ctacte,
           @w_nombre  = ba_nombre,
           @w_cuenta  = ba_cuenta,
	   @w_banco   = ba_banco,	--JCG10
	   @w_ope_ent = ba_operacion
      from cob_conta..cb_banco
     where ba_empresa   = @i_empresa 
       and ba_banco like  @i_banco
       and ba_ctacte    = @i_ctacte 
       and (ba_operacion = @i_ope_ent or @i_ope_ent is null)
    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
    if 
         @i_empresa is NULL or 
         @i_ctacte  is NULL or 
         @i_nombre  is NULL or 
         @i_cuenta  is NULL or
	 @i_banco   is NULL or	--JCG10
	 @i_ope_ent is NULL
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

    select @w_empresa = ba_empresa,
           @w_ctacte  = ba_ctacte,
           @w_nombre  = ba_nombre,
           @w_cuenta  = ba_cuenta,
	   @w_banco   = ba_banco,	--JCG10
	   @w_ope_ent = ba_operacion
      from cob_conta..cb_banco
     where ba_empresa   = @i_empresa 
       and ba_cuenta    = @i_cuenta
       and ba_operacion = @i_ope_ent

    if @@rowcount > 0
    begin
    /* Cuenta contable y operacion ya existen */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 603071
        return 1 
    end
    
    begin tran
         insert into cb_banco(ba_empresa, ba_ctacte, ba_nombre, ba_cuenta, ba_banco, ba_operacion)		--JCG10
              values (@i_empresa, @i_ctacte, @i_nombre, @i_cuenta, @i_banco, @i_ope_ent)		--JCG10

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

         /* Transaccion de Servicio */
         /***************************/

         insert into ts_banco
              values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,@i_empresa,@i_ctacte,@i_nombre,@i_cuenta,@i_ope_ent)

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
         update cob_conta..cb_banco
            set ba_nombre  = @i_nombre,
                ba_cuenta  = @i_cuenta
          where ba_empresa = @i_empresa 
            and ba_banco   = @i_banco
            and ba_ctacte  = @i_ctacte 
            and ba_operacion = @i_ope_ent

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

         /* Transaccion de Servicio */
         /***************************/

         insert into ts_banco
              values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,@w_empresa,@w_ctacte,@w_nombre,@w_cuenta,@w_ope_ent)

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

            
         /* Transaccion de Servicio */
         /***************************/

         insert into ts_banco
              values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,@i_empresa,@i_ctacte,@i_nombre,@i_cuenta, @i_ope_ent)

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
        @i_num   = 607021
        return 1 
    end

/***** Integridad Referencial *****/
/*****                        *****/

--    if exists (select * from cb_estcta
    if exists (select * from cob_conta_tercero..ct_estcta    
	               where es_empresa = @i_empresa 
	                 and es_banco   = @i_ctacte)
    begin
    /* Registro a eliminar esta relacionado con otra tabla */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 607023
        return 1 
    end


    begin tran
         delete cob_conta..cb_banco
          where ba_empresa   = @i_empresa 
            and ba_banco     = @i_banco	
            and ba_ctacte    = @i_ctacte 
            and ba_operacion = @i_ope_ent
            
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

         /* Transaccion de Servicio */
         /***************************/

         insert into ts_banco
              values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,@w_empresa,@w_ctacte,@w_nombre,@w_cuenta,@w_ope_ent)

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
    if @w_existe = 1
    begin
	 select @w_moneda = mo_descripcion 
	   from cobis..cl_moneda
	  where mo_moneda = (select cu_moneda 
	                       from cob_conta..cb_cuenta
			      where cu_empresa = @i_empresa 
			        and cu_cuenta = @w_cuenta) 

         select @w_empresa, @w_ctacte, @w_nombre, @w_cuenta, @w_moneda
    end
    else begin
    /*Registro no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 601159
        return 1 
    end
end

/* Consulta opcion ALL */
/***********************/

if @i_operacion = 'A'
begin
	if @i_modo = 0
	begin
	     select 'Banco'  = ba_ctacte,
		    'Nombre' = ba_nombre
	       from cob_conta..cb_banco
	      where ba_empresa = @i_empresa 

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
	end
	else begin
	     select 'Banco'  = ba_ctacte,
		    'Nombre' = ba_nombre
	      from cob_conta..cb_banco
	     where ba_empresa = @i_empresa 
	       and ba_ctacte > @i_ctacte

	     if @@rowcount = 0
    	     begin
            /*No existen mas registros */
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


/* Consulta opcion SEARCH */
/**************************/

if @i_operacion = 'S'
begin
	set rowcount 20
	if @i_modo = 0
	begin
	     select 'Banco'          = ba_banco,			--JCG10
		    'Cta. Corriente' = ba_ctacte,	--JCG10
		    'Nombre'         = substring(ba_nombre,1,40),
		    'Cuenta Contable'= ba_cuenta,
		    'Operacion'      = ba_operacion
	       from cob_conta..cb_banco
	      where ba_empresa = @i_empresa 
	        and ba_nombre like @i_nombre 
	        and ba_cuenta like @i_cuenta 
	        and ba_banco  like @i_banco
	    
	        
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
	else begin
	     select 'Banco'          = ba_banco,			--JCG10
		    'Cta. Corriente' = ba_ctacte,	--JCG10
		    'Nombre'         = substring(ba_nombre,1,40),
		    'Cuenta Contable'= ba_cuenta,
		    'Operacion'      = ba_operacion
	       from cob_conta..cb_banco
	      where ba_empresa = @i_empresa 
	        and ba_nombre like @i_nombre 
	        and ba_cuenta like @i_cuenta 
	        and ba_banco > @i_banco 
	
		   --'ba_ctacte > @i_ctacte		--JCG10	

	     if @@rowcount = 0
    	     begin
            /*No existen mas registros */
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

/* Consulta opcion C Consulta de las cuentas contables asociadas a bancos*/
/**************************/

if @i_operacion = 'C'
begin
	set rowcount 20
	if @i_modo = 0
	begin
	     select ba_cuenta
	       from cob_conta..cb_banco
	      where ba_empresa = @i_empresa 
	      order by ba_cuenta

	     if @@rowcount = 0
    	     begin
              return 1 
             end
	end
	else begin
	     select ba_cuenta
	       from cob_conta..cb_banco
	      where ba_empresa = @i_empresa 
	        and ba_cuenta >  @i_cuenta1
	      order by ba_cuenta

	     if @@rowcount = 0
    	     begin
              return 1 
             end
        end
	return 0
end   

if @i_operacion = 'O'
begin
	     select 'Nombre'     = substring(ba_nombre,1,40)
	       from cob_conta..cb_banco
	      where ba_empresa   = @i_empresa 
	        and ba_banco  like @i_banco 
	        and ba_ctacte    = @i_ctacte
	    --  and ba_operacion = @i_ope_ent

	     select 'Cuenta Contable' = substring(ba_cuenta,1,40)
	       from cob_conta..cb_banco
	      where ba_empresa   = @i_empresa 
	        and ba_banco  like @i_banco 
	        and ba_ctacte    = @i_ctacte
	      --and ba_operacion = @i_ope_ent

		--JCG30
		if @@rowcount = 0
    	     	begin
            		/*No existen registros */
              		exec cobis..sp_cerror
		        @t_debug = @t_debug,
              		@t_file  = @t_file, 
              		@t_from  = @w_sp_name,
              		@i_num   = 601028
              		return 1 
             	end
end
go
