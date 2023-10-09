/************************************************************************/
/*	Archivo:			depar2.sp										*/
/*	Stored procedure:	sp_cons_departamento							*/
/*	Base de datos:		cobis											*/
/*	Producto: 			Clientes										*/
/*	Disenado por:  		Mauricio Bayas/Sandra Ortiz						*/
/*	Fecha de escritura: 12-Nov-1992										*/
/************************************************************************/
/*								IMPORTANTE								*/
/*	Este programa es parte de los paquetes bancarios propiedad de		*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 			*/
/*	"NCR CORPORATION".													*/
/*	Su uso no autorizado queda expresamente prohibido asi como			*/
/*	cualquier alteracion o agregado hecho por alguno de sus				*/
/*	usuarios sin el debido consentimiento por escrito de la 			*/
/*	Presidencia Ejecutiva de MACOSA o su representante.					*/
/*									PROPOSITO							*/
/*	Este programa procesa las transacciones del stored procedure		*/
/*	Busqueda de telefono												*/
/*								MODIFICACIONES							*/
/************************************************************************/
/*	FECHA		AUTOR		RAZON										*/
/*	12/Nov/92	L. Carvajal	Emision Inicial								*/
/*	13/Ene/93	L. Carvajal	Tabla de errores, variables	de debug		*/
/*  11/Ene/94   F.Espinosa  Retorno del codigo de Depart.   			*/
/*  17/Ene/94   F.Espinosa  Operacion "H", Tipo "E" : Retorna la 		*/
/*                          descripcion del depart. tomando como    	*/
/*                          parametro adicional	la filial	            */
/*	19/Ene/94	F.Espinosa	Operacion "S" con modos (2,3) para retornar */
/*							los departamentos de una oficina.			*/
/*	25/Abr/94	F.Espinosa	Parametro tipo "S" Transacciones de Servicio*/
/*	18/May/94	F.Espinosa	Division del Stored Procedure en dos partes	*/
/*	01/Feb/13	P.Montenegro Consulta de Departamento INC-REDMINE-17559 */
/*	21/Feb/14	J.Tagle     Nuevos Modos de Búsqueda 4,5 y 6 REQ24098   */
/*  11-04-2016  BBO          Migracion Sybase-Sqlserver FAL             */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_cons_departamento')
   drop proc sp_cons_departamento
go

create proc sp_cons_departamento 
(
	@s_ssn				int 		= NULL,
	@s_user				login 		= NULL,
	@s_sesn				int 		= NULL,
	@s_term				varchar(32) = NULL,
	@s_date				datetime 	= NULL,
	@s_srv				varchar(30) = NULL,
	@s_lsrv				varchar(30) = NULL, 
	@s_rol				smallint 	= NULL,
	@s_ofi				smallint 	= NULL,
	@s_org_err			char(1) 	= NULL,
	@s_error			int 		= NULL,
	@s_sev				tinyint 	= NULL,
	@s_msg				descripcion = NULL,
	@s_org				char(1)		= NULL,
	@t_show_version     bit         = 0,
	@t_debug			char(1) 	= 'N',
	@t_file				varchar(14) = null,
	@t_from				varchar(32) = null,
	@t_trn				smallint 	= NULL,
	@i_operacion        char(1),
	@i_modo		   		tinyint 	= null,
	@i_tipo		    	char(1) 	= null,
	@i_departamento	    smallint 	= null,
	@i_filial	    	tinyint 	= null,
	@i_oficina	    	smallint 	= null,
	@i_descripcion	    descripcion = null,
	@i_o_departamento   smallint 	= null,
	@i_o_oficina    	smallint 	= null,
	@o_siguiente	   	int 		= null out
)
as
declare
       @w_sp_name	       		varchar(32),
       @w_today                	datetime,
       @w_var                  	int,
       @w_aux		       		tinyint,	
       @w_codigo               	int,
       @w_departamento         	smallint,
       @w_filial               	tinyint,
       @w_oficina	       		smallint,
       @w_descripcion          	descripcion,
       @w_o_departamento       	smallint,
       @w_o_oficina       		smallint,
       @w_nivel                	tinyint,
       @v_departamento         	smallint,
       @v_filial               	tinyint,
       @v_oficina	       		smallint,
       @v_descripcion          	descripcion,
       @v_o_departamento       	smallint,
       @v_o_oficina       		smallint,
       @v_nivel                	tinyint,
       @o_departamento         	smallint,
       @o_filial               	tinyint,
       @o_finombre             	descripcion,
       @o_oficina	       		smallint,
       @o_lonombre             	descripcion,
       @o_descripcion          	descripcion,
       @o_o_departamento       	smallint,
       @o_o_oficina       		smallint,
       @o_o_denombre            descripcion,
       @o_o_ofinombre           descripcion,
       @o_nivel                	tinyint

select @w_today = @s_date

if @t_show_version = 1
begin
    print 'Stored procedure sp_cons_departamento, Version 4.0.0.1'
    return 0
end

select @w_sp_name = 'sp_cons_departamento'


/* ** search ** */
if @i_operacion = 'S'
begin
	if @t_trn = 1591
	begin
		set rowcount 20
		if @i_modo = 0
		begin
			select  'Filial' = x.de_filial,
					'Oficina' = x.de_oficina,
					'Cod.Depmto.' = x.de_departamento,
					'Nombre Depmto.' = substring(x.de_descripcion, 1, 25),
					'Nombre Depmto.Sup.'= substring(isnull(y.de_descripcion, ' '), 1, 25),
					'Nombre Ofic.Sup.'= substring(isnull(of_nombre,' '),1,25)
               from cl_departamento x                                                               --inicio mig syb-sql 18042016
                    left outer join cl_departamento y on x.de_o_departamento = y.de_departamento
                                                     and x.de_o_oficina = y.de_oficina
                    left outer join cl_oficina on x.de_o_oficina = of_oficina
              order by x.de_filial, x.de_oficina, x.de_departamento                                 --fin mig syb-sql 18042016
              
			/******** MIGRACION SYB-SQL
            from   cl_departamento x, cl_departamento y, cl_oficina 
			where  x.de_o_departamento *= y.de_departamento
			and  x.de_o_oficina *= y.de_oficina
			and  x.de_o_oficina *= of_oficina
			order  by x.de_filial, x.de_oficina, x.de_departamento
            **********/
			
			set rowcount 0
		end

		if @i_modo = 1
		begin
			select  'Filial' = x.de_filial,
					'Oficina' = x.de_oficina,
					'Cod.Depmto.' =  x.de_departamento,
					'Nombre Depmto.' = substring(x.de_descripcion, 1, 25),
					'Nombre Depmto.Sup.'= substring(isnull(y.de_descripcion, ' '), 1, 25),
					'Nombre Ofic.Sup.'= substring(isnull(of_nombre,' '),1,25)
               from cl_departamento x                                                               --inicio mig syb-sql 18042016
                    left outer join cl_departamento y on x.de_o_departamento = y.de_departamento
                                                     and x.de_o_oficina = y.de_oficina
                    left outer join cl_oficina on x.de_o_oficina = of_oficina
              where ((x.de_filial > @i_filial ) 
                 or (x.de_filial = @i_filial and x.de_oficina > @i_oficina) 
                 or (x.de_filial = @i_filial and x.de_oficina = @i_oficina and x.de_departamento > @i_departamento))
              order by x.de_filial, x.de_oficina, x.de_departamento                                 --fin mig syb-sql 18042016
                    
            /******** MIGRACION SYB-SQL        
			from  cl_departamento x, cl_departamento y, cl_oficina
			where  ((x.de_filial > @i_filial ) or 
			(x.de_filial = @i_filial and x.de_oficina > @i_oficina) or
			(x.de_filial = @i_filial and x.de_oficina = @i_oficina and 
			x.de_departamento > @i_departamento))
			and  x.de_o_departamento *= y.de_departamento
			and  x.de_o_oficina *= y.de_oficina
			and  x.de_o_oficina *= of_oficina
			order by x.de_filial, x.de_oficina, x.de_departamento
            *********/

			/* ARO: 2 de Junio del 2000: Corrección Siguientes */        
			if @@rowcount=0
			Begin
				exec sp_cerror
					@t_debug	= @t_debug,
					@t_file		= @t_file,
					@t_from		= @w_sp_name,
					@i_num	       	= 151121
					set rowcount 0
				return 1
			End
			/* Fin ARO */
			
			set rowcount 0
		end

		if @i_modo = 2
		begin
			select  'Filial' = x.de_filial,
					'Oficina' = x.de_oficina,
					'Cod.Depmto.' = x.de_departamento,
					'Nombre Depmto.' = substring(x.de_descripcion, 1, 25),
					'Nombre Depmto.Sup.'= substring(isnull(y.de_descripcion, ' '), 1, 25),
					'Nombre Ofic.Sup.'= substring(isnull(of_nombre,' '),1,25)
               from cl_departamento x                                                               --inicio mig syb-sql 18042016
                    left outer join cl_departamento y on x.de_o_departamento = y.de_departamento
                                                     and x.de_o_oficina = y.de_oficina
                    left outer join cl_oficina on x.de_o_oficina = of_oficina
              where x.de_oficina = @i_oficina
              order by x.de_filial, x.de_oficina, x.de_departamento                                 --fin mig syb-sql 18042016
              
            /******* MIGRACION SYB-SQL        
			from   cl_departamento x, cl_departamento y, cl_oficina 
			where  x.de_o_departamento *= y.de_departamento
			and  x.de_o_oficina *= y.de_oficina
			and  x.de_o_oficina *= of_oficina
			and  x.de_oficina = @i_oficina
			order  by x.de_filial, x.de_oficina, x.de_departamento
            ********/
			
			set rowcount 0
		end
    
		if @i_modo = 3
		begin
			select  'Filial' = x.de_filial,
					'Oficina' = x.de_oficina,
					'Cod.Depmto.' = x.de_departamento,
					'Nombre Depmto.' = substring(x.de_descripcion, 1, 25),
					'Nombre Depmto.Sup.'= substring(isnull(y.de_descripcion, ' '), 1, 25),
					'Nombre Ofic.Sup.'= substring(isnull(of_nombre,' '),1,25)
               from cl_departamento x                                                               --inicio mig syb-sql 18042016
                    left outer join cl_departamento y on x.de_o_departamento = y.de_departamento
                                                     and x.de_o_oficina = y.de_oficina
                    left outer join cl_oficina on x.de_o_oficina = of_oficina
              where x.de_oficina = @i_oficina
                and ((x.de_filial > @i_filial ) 
                 or (x.de_filial = @i_filial and x.de_oficina > @i_oficina) 
                 or (x.de_filial = @i_filial and x.de_oficina = @i_oficina and x.de_departamento > @i_departamento))
              order by x.de_filial, x.de_oficina, x.de_departamento                                 --fin mig syb-sql 18042016
                    
			/****** MIGRACION SYB-SQL
            from  cl_departamento x, cl_departamento y, cl_oficina
			where  ((x.de_filial > @i_filial ) or 
			(x.de_filial = @i_filial and x.de_oficina > @i_oficina) or
			(x.de_filial = @i_filial and x.de_oficina = @i_oficina and 
			x.de_departamento > @i_departamento))
			and  x.de_o_departamento *= y.de_departamento
			and  x.de_o_oficina *= y.de_oficina
			and  x.de_o_oficina *= of_oficina
			and  x.de_oficina = @i_oficina
			order by x.de_filial, x.de_oficina, x.de_departamento
            *******/
			
			set rowcount 0
		end
		
		if @i_modo = 4  /* OFICINA */
		begin
			select  'Filial' = a.de_filial,
					'Oficina' = a.de_oficina,
					'Cod.Depmto.' = a.de_departamento,
					'Nombre Depmto.' = substring(a.de_descripcion, 1, 25),
					'Nombre Depmto.Sup.'= substring(isnull(b.de_descripcion, ' '), 1, 25),
					'Nombre Ofic.Sup.'= substring(isnull(of_nombre,' '),1,25)
			from cl_departamento a    
			left join cl_departamento b 
				on ( a.de_o_departamento=b.de_departamento and a.de_oficina = b.de_oficina and a.de_filial = b.de_filial)
			left join cl_oficina c 
				on ( a.de_o_oficina = c.of_oficina and a.de_filial = c.of_filial)
			where a.de_oficina = @i_oficina
			and a.de_filial >= @i_filial
			and a.de_departamento > @i_departamento
			order by a.de_filial, a.de_oficina, a.de_departamento
			set rowcount 0
		end
		
		if @i_modo = 5  /* DPTO */
		begin
			select  'Filial' = a.de_filial,
					'Oficina' = a.de_oficina,
					'Cod.Depmto.' = a.de_departamento,
					'Nombre Depmto.' = substring(a.de_descripcion, 1, 25),
					'Nombre Depmto.Sup.'= substring(isnull(b.de_descripcion, ' '), 1, 25),
					'Nombre Ofic.Sup.'= substring(isnull(of_nombre,' '),1,25)
			from cl_departamento a    
			left join cl_departamento b 
				on ( a.de_o_departamento=b.de_departamento and a.de_oficina = b.de_oficina and a.de_filial = b.de_filial)
			left join cl_oficina c 
				on ( a.de_o_oficina = c.of_oficina and a.de_filial = c.of_filial)
			where a.de_departamento = @i_departamento
			and a.de_filial >= @i_filial
			and a.de_oficina > @i_oficina
			order by a.de_filial, a.de_oficina, a.de_departamento
			set rowcount 0
		end		
		
		if @i_modo = 6  /* NOM DPTO */
		begin
			select  'Filial' = a.de_filial,
					'Oficina' = a.de_oficina,
					'Cod.Depmto.' = a.de_departamento,
					'Nombre Depmto.' = substring(a.de_descripcion, 1, 25),
					'Nombre Depmto.Sup.'= substring(isnull(b.de_descripcion, ' '), 1, 25),
					'Nombre Ofic.Sup.'= substring(isnull(of_nombre,' '),1,25)
			from cl_departamento a    
			left join cl_departamento b 
				on ( a.de_o_departamento=b.de_departamento and a.de_oficina = b.de_oficina and a.de_filial = b.de_filial)
			left join cl_oficina c 
				on ( a.de_o_oficina = c.of_oficina and a.de_filial = c.of_filial)
			where a.de_descripcion like UPPER ('%'+@i_descripcion+'%')
			and a.de_oficina > @i_oficina
			and a.de_filial >= @i_filial
			and a.de_departamento >= @i_departamento
			
			
			order by a.de_filial, a.de_oficina, a.de_departamento
			set rowcount 0
		end	
		
		return 0
	end
	else
	begin
		exec sp_cerror
			@t_debug	 = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 151051
			/*  'No corresponde codigo de transaccion' */
		return 1
	end
end


/* ** query ** */
if @i_operacion = 'Q'
begin
	if @t_trn = 1592
	begin
		/*B-24/jun/1999 Al consultar la descripcion de un departamento superior devolv¡a el £ltimo registro encontrado*/
		
		select  @w_departamento = de_o_departamento,
				@w_oficina = de_o_oficina
			from cl_departamento
			where de_departamento = @i_departamento
			and de_oficina = @i_oficina

		select @o_o_denombre = de_descripcion
			from   cl_departamento
			where  de_departamento = @w_departamento
			and de_oficina = @w_oficina

		select @o_o_ofinombre = of_nombre
			from   cl_oficina
			where  of_oficina = (select de_o_oficina
									from cl_departamento
									where de_departamento = @i_departamento
									and de_oficina = @i_oficina)
									
		select @o_departamento 	= de_departamento,
			   @o_filial 		= de_filial,
			   @o_finombre 		= fi_nombre,
			   @o_oficina 		= de_oficina,
			   @o_lonombre 		= of_nombre,
			   @o_descripcion 	= de_descripcion,
			   @o_o_departamento = de_o_departamento,
			   @o_o_oficina 	= de_o_oficina
			from cl_departamento, cl_filial, cl_oficina
			where de_departamento = @i_departamento
			and de_oficina = @i_oficina
			and fi_filial = de_filial
			and of_oficina = de_oficina

		if @@rowcount = 0
		begin
			exec sp_cerror
				@t_debug	= @t_debug,
				@t_file		= @t_file,
				@t_from		= @w_sp_name,
				@i_num		= 101010
				/* 'No existe departamento'*/
			return 1
		end

		select 	@o_departamento, @o_filial, @o_finombre, @o_oficina,
				@o_lonombre, @o_descripcion, @o_o_departamento,
				@o_o_denombre, @o_o_oficina, @o_o_ofinombre
				
		return 0
	end
	else
	begin
		exec sp_cerror
		   @t_debug	 = @t_debug,
		   @t_file	 = @t_file,
		   @t_from	 = @w_sp_name,
		   @i_num	 = 151051
		   /*  'No corresponde codigo de transaccion' */
		return 1
	end
end


/* ** help ** */
if @i_operacion = 'H'
begin
	if @t_trn = 1593
	begin
		if @i_tipo = 'A'
		begin
			set rowcount 20
			
			if @i_modo = 0
			begin
				select	"Cod." = de_departamento, 
						"Nombre" = substring(de_descripcion,1,30)
					from cl_departamento
					where  de_oficina = @i_oficina
					order   by de_departamento
				
				if @@rowcount = 0
				begin
					exec sp_cerror
						@t_debug	= @t_debug,
						@t_file		= @t_file,
						@t_from		= @w_sp_name,
						@i_num		= 101010
						/*'Departamento no existe'*/

						set rowcount 0
					return 1
				end
			end
		
			if @i_modo = 1
			begin
				select  "Cod." = de_departamento, 
						"Nombre" = substring(de_descripcion,1,30)
					from cl_departamento
					where de_oficina = @i_oficina
					and de_departamento > @i_departamento		   
					order  by de_departamento
					
				if @@rowcount = 0
				begin
					exec sp_cerror
						@t_debug 	= @t_debug,
						@t_file 	= @t_file,
						@t_from		= @w_sp_name,
						@i_num		= 101010
						/* Departamento no existe */
						set rowcount 0
					return 1
				end
			end
			set rowcount 0
		end

		 if @i_tipo = 'V'
		 begin
			select  de_descripcion
				from  cl_departamento 
				where  de_departamento = @i_departamento
				and  de_oficina = @i_oficina

			if @@rowcount = 0
			begin
				exec cobis..sp_cerror
					@t_debug	= @t_debug,
					@t_file		= @t_file,
					@t_from		= @w_sp_name,
					@i_num		= 101010
					/*'Departamento no existe'*/
				return 1
			end
		end

		if @i_tipo = 'U'
		begin
			select  "Filial" = fi_abreviatura,
					"Oficina" = substring(of_nombre, 1, 20), 
					"Cod." = de_departamento, 
					"Departamento" = de_descripcion
			from cl_departamento, cl_filial, cl_oficina
			where de_filial = fi_filial
			and de_oficina = of_oficina
			and de_departamento = @i_departamento
			and de_oficina = @i_oficina
			order  by de_filial, de_oficina, de_departamento
		
			if @@rowcount = 0
			begin
				exec sp_cerror
					@t_debug 	= @t_debug,
					@t_file 	= @t_file,
					@t_from		= @w_sp_name,
					@i_num		= 101010
					/* Departamento no existe */
					set rowcount 0
				return 1
			end
		end


		if @i_tipo = "E"
		begin
			select de_descripcion
				from cl_departamento
				where de_departamento = @i_departamento
				and de_oficina = @i_oficina
				and de_filial = @i_filial

			if @@rowcount = 0
			begin
				exec cobis..sp_cerror
					@t_debug	= @t_debug,
					@t_file		= @t_file,
					@t_from		= @w_sp_name,
					@i_num		= 101010
					/*'Departamento no existe'*/
				return 1
			end
		end
					
		if @i_tipo = 'X'
		begin
			set rowcount 20
			
			if @i_modo = 0
			begin
				select	"Cod.Dep." 		= de_departamento, 
						"Nombre Dep." 	= substring(de_descripcion,1,30), 
						"Cod. Ofic." 	= of_oficina, 
						"Nombre Ofic." 	= substring(of_nombre,1,30)
				from cobis..cl_departamento a, cobis..cl_oficina b
				where de_oficina = of_oficina
				and of_filial = @i_filial
				order by de_departamento
				
				if @@rowcount = 0
				begin
					exec sp_cerror
						@t_debug	= @t_debug,
						@t_file		= @t_file,
						@t_from		= @w_sp_name,
						@i_num		= 101010
						/*'Departamento no existe'*/

						set rowcount 0
					return 1
				end
			end
		
			if @i_modo = 1
			begin
				select	"Cod.Dep." 		= de_departamento, 
						"Nombre Dep." 	= substring(de_descripcion,1,30), 
						"Cod. Ofic." 	= of_oficina, 
						"Nombre Ofic." 	= substring(of_nombre,1,30)
					from cobis..cl_departamento a, cobis..cl_oficina b
					where de_oficina = of_oficina
					and of_filial = @i_filial
					and de_departamento > @i_departamento
					order by de_departamento
					
				if @@rowcount = 0
				begin
					exec sp_cerror
						@t_debug 	= @t_debug,
						@t_file 	= @t_file,
						@t_from		= @w_sp_name,
						@i_num		= 101010
						/* Departamento no existe */
						set rowcount 0
					return 1
				end
			end
			set rowcount 0
		end
		
		if @i_tipo = "F"
		begin
			select	"Cod.Dep." 		= de_departamento, 
					"Nombre Dep." 	= substring(de_descripcion,1,30), 
					"Cod. Ofic." 	= of_oficina, 
					"Nombre Ofic." 	= substring(of_nombre,1,30)
				from cobis..cl_departamento a, cobis..cl_oficina b
				where de_oficina = of_oficina
				and of_filial = @i_filial
				and de_departamento = @i_departamento				
							
			if @@rowcount = 0
			begin
				exec cobis..sp_cerror
					@t_debug	= @t_debug,
					@t_file		= @t_file,
					@t_from		= @w_sp_name,
					@i_num		= 101010
					/*'Departamento no existe'*/
				return 1
			end
		end
		
		return 0
	end
	else
	begin
		exec sp_cerror
			@t_debug	 = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 151051
			/*  'No corresponde codigo de transaccion' */
		return 1
	end
end
go

