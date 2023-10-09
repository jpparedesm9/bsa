/*instan.sp*/
/************************************************************************/
/*      Archivo:                instan.sp                               */
/*      Stored procedure:       sp_instancia                            */
/*      Base de datos:          cobis                                   */
/*      Producto:               Clientes                                */
/*      Disenado por:           Sandra Ortiz                            */
/*      Fecha de escritura:     31-Ago-1993                             */
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
/*      Este stored procedure procesa:                                  */
/*      insercion en cl_instancia                                       */
/*      borrado en cl_instancia                                         */
/*      query de instancia en funcion de su codigo unico                */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    25/07/2017       Paúl Ortiz     Generar Error de Conyuge          */
/*    10/10/2017       Paúl Ortiz     Eliminacion solo para grupos      */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_instancia')
        drop proc sp_instancia
go
create proc sp_instancia(
   @s_ssn          int         = null,
   @s_user         login       = null,
   @s_term         varchar(32) = null,
   @s_date         datetime    = null,
   @s_srv          varchar(30) = null,
   @s_lsrv         varchar(30) = null,
   @s_rol          smallint    = NULL,
   @s_ofi          smallint    = NULL,
   @s_org_err      char(1)     = NULL,
   @s_error        int         = NULL,
   @s_sev          tinyint     = NULL,
   @s_msg          descripcion = NULL,
   @s_org          char(1)     = NULL,
   @t_trn          smallint    = NULL,
   @t_debug        char (1)    = 'N',
   @t_file         varchar(14) = null,
   @t_from         varchar(30) = null,
   @t_show_version       bit    = 0,
   @i_operacion    char(1),            -- Opcion con que se ejecuta el programa
   @i_relacion     int         = null, -- Codigo de la relacion que es instancia
   @i_derecha      int         = null, -- Codigo del cliente que va a la derecha de la relacion
   @i_izquierda    int         = null, -- Codigo del cliente que va a la izquierda de la relacion
   @i_lado         char (1)    = null, -- Mensaje de la relacion que es aplicado
   @i_secuencial   int         = null
)
as
declare         
@w_sp_name      varchar (30),
@w_null         int,
@w_fecha_ini    datetime,
@w_ente_i       int,
@w_ente_d       int,
@w_relacion_ca  int, --Relacion de tipo Conyuge
@w_estado_civil_i  varchar(10),
@w_estado_civil_d  varchar(10),
@w_grupo        int,
@w_relacion_pa  int, --Relacion de tipo Padre
@w_relacion_hi  int, --Relacion de tipo Hijo
@w_error        int

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_instancia'


-------------------------------- VERSIONAMIENTO DE SP --------------------------------
if @t_show_version = 1
begin
    print 'Stored procedure sp_instancia, Version 4.0.0.5'
    return 0
end
--------------------------------------------------------------------------------------

select @w_relacion_ca = (select pa_tinyint from cobis..cl_parametro 
                  where pa_nemonico = 'CONY' and pa_producto='CLI')

select @w_relacion_pa = (select pa_tinyint from cobis..cl_parametro 
                  where pa_nemonico = 'PAD' and pa_producto='CLI')

select @w_relacion_hi = (select pa_tinyint from cobis..cl_parametro 
                  where pa_nemonico = 'HIJ' and pa_producto='CLI')

/*  Insert  */
if @i_operacion ='I' 
begin
if @t_trn = 1367 
begin
       /* Verificar que existan los entes relacionados */
        select  @w_null = NULL
          from  cl_ente
         where  en_ente in (@i_derecha, @i_izquierda)
        if @@rowcount <> 2
        begin
                /*  No existe ente  */
                exec cobis..sp_cerror
                        @t_debug= @t_debug,
                        @t_file = @t_file,
                        @t_from = @w_sp_name,
                        @i_num  = 101042
                return 1
        end

       /* Verificar que exista la relacion generica */
   if @i_relacion < 2 and @i_relacion > 6 /* SCA */ 
   begin
        select  @w_null = NULL
          from  cl_relacion
         where  re_relacion = @i_relacion 
        if @@rowcount <> 1 
        begin
                /*  No existe ente  */
                exec cobis..sp_cerror
                        @t_debug= @t_debug,
                        @t_file = @t_file,
                        @t_from = @w_sp_name,
                        @i_num  = 101083
                return 1
        end
   end
        /* Verificar que no exista instancias duplicadas */
        select  @w_null = NULL
          from  cl_instancia
         where  in_ente_i = @i_izquierda
           and  in_ente_d = @i_derecha
           and  in_relacion = @i_relacion 
        if @@rowcount = 1
        begin
                /*  Relacion entre entes ya existe  */
                exec cobis..sp_cerror
                        @t_debug= @t_debug,
                        @t_file = @t_file,
                        @t_from = @w_sp_name,
                        @i_num  = 101099
                return 1
        end
		
		SELECT @w_estado_civil_i = p_estado_civil FROM cobis..cl_ente WHERE en_ente = @i_izquierda
		SELECT @w_estado_civil_d = p_estado_civil FROM cobis..cl_ente WHERE en_ente = @i_derecha
		
		if (@i_relacion = @w_relacion_ca) /* Es CONYUGE */
		begin
			
			if ((@w_estado_civil_i <> 'CA') and (@w_estado_civil_i <> 'UN'))
			begin
				exec cobis..sp_cerror
                        @t_debug= @t_debug,
                        @t_file = @t_file,
                        @t_from = @w_sp_name,
                        @i_num  = 103155
                return 103155
			end
		end
		
		
		/* Verifica que el conyuge tenga estado civil casado*/
		PRINT 'RELACION '+ convert(VARCHAR(100),@i_relacion)
		if (@i_relacion = @w_relacion_ca)
		begin
			if (@w_estado_civil_i <> @w_estado_civil_d)
			begin
				/*  Por favor regularice el estado civil del Conyuge  */
                exec cobis..sp_cerror
                        @t_debug= @t_debug,
                        @t_file = @t_file,
                        @t_from = @w_sp_name,
                        @i_num  = 103146
                return 1
			end
		end
		
        /*  Insercion  */
        begin tran
                insert into cl_instancia 
				(in_relacion, in_ente_i, in_ente_d, 
                in_lado, in_fecha)
                values   (@i_relacion, 
                @i_izquierda, @i_derecha, 
                @i_lado, @s_date/*getdate()*/)
				
                if @@error <> 0
                begin
                   /*  Error en creacion de instancia de relacion  */
                   exec cobis..sp_cerror
                   @t_debug= @t_debug,
                   @t_file = @t_file,
                   @t_from = @w_sp_name,
                   @i_num  = 103061
                   
                   rollback tran
                   
                   return 1
                end
                /*  Insercion de la relacion reciproca  */

				/* Cambio de relacion HIJO a PADRE */
				if(@i_relacion = @w_relacion_hi) -- HIJO 
                begin
                	select @i_relacion = @w_relacion_pa
                end
                else if (@i_relacion = @w_relacion_pa) -- PADRE 
                begin
                	select @i_relacion = @w_relacion_hi
                end

                if @i_lado = 'I'
                        select @i_lado = 'D'
                else
                        select @i_lado = 'I'

                insert into cl_instancia 
				(in_relacion, in_ente_d, in_ente_i, 
                in_lado, in_fecha)
                values   
				(@i_relacion, 
                @i_izquierda, @i_derecha, 
                @i_lado, @s_date/*getdate()*/)
				
                if @@error <> 0
                begin
                   /*  Error en creacion de instancia de relacion  */
                   exec cobis..sp_cerror
                   @t_debug= @t_debug,
                   @t_file = @t_file,
                   @t_from = @w_sp_name,
                   @i_num  = 103061
				   
				   rollback tran
				   
                   return 1
                end
				
				--SRO. Volver a validar Sección de Dirección sin importar orden de ingreso de datos cónyuge para que se pueda activar el cliente
				if (@i_relacion = @w_relacion_ca) begin
				
				   exec @w_error = cobis..sp_seccion_validar
		           @i_ente			= @i_izquierda,
		           @i_operacion   	= 'V',
		           @i_seccion 		= '2', --2 es Dirección, 
		           @i_completado 	= 'S'
				   
				   if @w_error <> 0 begin
				      exec sp_cerror
                      @t_debug      = @t_debug,
                      @t_file       = @t_file,
                      @t_from       = @w_sp_name,
                      @i_num        = @w_error
					  
					  rollback tran
					  
					  return @w_error
				  end
			    end

        commit tran
        return 0

end
else
begin
        exec sp_cerror
           @t_debug      = @t_debug,
           @t_file       = @t_file,
           @t_from       = @w_sp_name,
           @i_num        = 151051
           /*  'No corresponde codigo de transaccion' */
        return 1
end

end

/*  Delete  */
if @i_operacion = 'D'
begin
if @t_trn = 1368
begin

        select  @w_fecha_ini = in_fecha
          from  cl_instancia
         where  
         --in_relacion  = @i_relacion
           --and  
           in_ente_i    = @i_izquierda
           and  in_ente_d    = @i_derecha
        if @@rowcount <> 1
        begin           
               /* exec cobis..sp_cerror
                        @t_debug= @t_debug,
                        @t_file = @t_file,
                        @t_from = @w_sp_name,
                        @i_num  = 101098*/
                    RETURN 0    
                --return 101098
        end
        begin tran

                if not exists (select 1 from cl_instancia, cl_at_instancia
                                 where  
                                 --in_relacion  = @i_relacion
                                   --and 
                                    in_ente_i    = @i_izquierda
                                   and  in_ente_d    = @i_derecha
                                   and  ai_relacion  = in_relacion
                                   and  ai_ente_i    = in_ente_i
                                   and  ai_ente_d    = in_ente_d
                                   and  ai_secuencial <> @i_secuencial)
                begin
                        delete  cl_instancia
                         where  
                         --in_relacion  = @i_relacion
                           --and 
                            in_ente_i    = @i_izquierda
                           and  in_ente_d    = @i_derecha
                        if @@error <> 0
                        begin           
                          exec cobis..sp_cerror 
                          @t_debug= @t_debug,
                          @t_file = @t_file,
                          @t_from = @w_sp_name,
                          @i_num  = 107054  
                          return 107054  
                        end

                        insert into cl_his_relacion (hr_secuencial,hr_relacion, hr_ente_i, hr_ente_d, 
                                                     hr_fecha_ini, hr_fecha_fin)
                                        values      (@s_ssn, @i_relacion, @i_izquierda, @i_derecha,
                                                     @w_fecha_ini, @s_date)
                        if @@error <> 0
                        begin                   
                                exec cobis..sp_cerror
                                        @t_debug= @t_debug,
                                        @t_file = @t_file,
                                        @t_from = @w_sp_name,
                                        @i_num  = 103062
                                return 103062
                        end
                        delete  cl_instancia
                         where  in_ente_i = @i_derecha
                           and  in_ente_d = @i_izquierda
                           --and  in_relacion = @i_relacion  
                       if @@error <> 0
                       begin
                          exec cobis..sp_cerror 
                          @t_debug= @t_debug,
                          @t_file = @t_file,
                          @t_from = @w_sp_name,
                          @i_num  = 107054  
                          return 107054  
                        end

                        if @@error = 0
                        begin
                                insert into cl_his_relacion (hr_secuencial, hr_relacion, 
                                                     hr_ente_i, hr_ente_d,
                                                     hr_fecha_ini, hr_fecha_fin)
                                        values      (@s_ssn, @i_relacion, 
                                                     @i_derecha, @i_izquierda,
                                                     @w_fecha_ini, @s_date)
                                if @@error <> 0
                                begin
                                        exec cobis..sp_cerror
                                                @t_debug= @t_debug,
                                                @t_file = @t_file,
                                                @t_from = @w_sp_name,
                                                @i_num  = 103061
                                        return 103061
                                end
                        end

                end /*if not exists */
                else
                begin /* Si existe */
                      delete  cl_instancia
                       where  
                       --in_relacion  = @i_relacion
                        --and 
                         in_ente_i    = @i_izquierda
                        and  in_ente_d    = @i_derecha
                      if @@error <> 0
                      begin           
                          exec cobis..sp_cerror 
                          @t_debug= @t_debug,
                          @t_file = @t_file,
                          @t_from = @w_sp_name,
                          @i_num  = 107054  
                          return 107054  
                      end

                      insert into cl_his_relacion (hr_secuencial,hr_relacion, hr_ente_i, hr_ente_d, 
                                                   hr_fecha_ini, hr_fecha_fin)
                                      values      (@s_ssn, @i_relacion, @i_izquierda, @i_derecha,
                                                   @w_fecha_ini, @s_date)
                      if @@error <> 0
                      begin                   
                         exec cobis..sp_cerror
                            @t_debug= @t_debug,
                            @t_file = @t_file,
                            @t_from = @w_sp_name,
                            @i_num  = 103062
                         return 103062
                      end
                      delete  cl_instancia
                       where  in_ente_i = @i_derecha
                        and  in_ente_d = @i_izquierda
                        --and  in_relacion = @i_relacion  
                      if @@error <> 0
                      begin
                         exec cobis..sp_cerror 
                          @t_debug= @t_debug,
                          @t_file = @t_file,
                          @t_from = @w_sp_name,
                          @i_num  = 107054  
                          return 107054  
                      end

                      if @@error = 0
                      begin
                             insert into cl_his_relacion (hr_secuencial, hr_relacion, 
                                                  hr_ente_i, hr_ente_d,
                                                  hr_fecha_ini, hr_fecha_fin)
                                     values      (@s_ssn, @i_relacion, 
                                                  @i_derecha, @i_izquierda,
                                                  @w_fecha_ini, @s_date)
                            if @@error <> 0
                            begin
                               exec cobis..sp_cerror
                                  @t_debug= @t_debug,
                                  @t_file = @t_file,
                                  @t_from = @w_sp_name,
                                  @i_num  = 103061
                               return 103061
                            end
                      end

               /* borrar atributos asociados */
                if @i_secuencial is null
                begin
                       Delete cl_at_instancia
                        where 
                        --ai_relacion = @i_relacion
                          --and 
                          ai_ente_i   = @i_izquierda
                          and ai_ente_d   = @i_derecha 
                      if @@error <> 0
                      begin
                         exec cobis..sp_cerror 
                            @t_debug= @t_debug,
                            @t_file = @t_file,
                            @t_from = @w_sp_name,
                            @i_num  = 107056  
                         return 107056  
                      end
                end
                else
                begin
                       Delete cl_at_instancia
                        where 
                        --ai_relacion = @i_relacion
                          --and 
                          ai_ente_i   = @i_izquierda
                          and ai_ente_d   = @i_derecha 
                          and ai_secuencial = @i_secuencial
                      if @@error <> 0
                      begin
                         exec cobis..sp_cerror 
                            @t_debug= @t_debug,
                            @t_file = @t_file,
                            @t_from = @w_sp_name,
                            @i_num  = 107056  
                         return 107056  
                      end

                end

               /* borrar atributos asociados (Reciproco) */
                if @i_secuencial is null
                begin
                       Delete cl_at_instancia
                        where 
                        --ai_relacion = @i_relacion
                          --and 
                          ai_ente_i   = @i_derecha
                          and ai_ente_d   = @i_izquierda 
                      if @@error <> 0
                      begin
                         exec cobis..sp_cerror 
                            @t_debug= @t_debug,
                            @t_file = @t_file,
                            @t_from = @w_sp_name,
                            @i_num  = 107056  
                         return 1
                      end
                end
                else
                begin
                       Delete cl_at_instancia
                        where 
                        --ai_relacion = @i_relacion
                          --and 
                          ai_ente_i   = @i_derecha
                          and ai_ente_d   = @i_izquierda 
                          and ai_secuencial = @i_secuencial
                      if @@error <> 0
                      begin
                         exec cobis..sp_cerror 
                            @t_debug= @t_debug,
                            @t_file = @t_file,
                            @t_from = @w_sp_name,
                            @i_num  = 107056  
                         return 1
                      end

                end
             end /* Fin Si existe */

        commit tran
        return 0

end
else
begin
        exec sp_cerror
           @t_debug      = @t_debug,
           @t_file       = @t_file,
           @t_from       = @w_sp_name,
           @i_num        = 151051

        return 1
end

end


--Eliminar todas las relaciones

if @i_operacion = 'A'
begin
if @t_trn = 1368
BEGIN
		PRINT 'Entra Operacion A'
        select  @w_fecha_ini = in_fecha
          from  cl_instancia
         where  in_ente_i    = @i_izquierda

        if @@rowcount < 1
        begin           
               /* exec cobis..sp_cerror
                        @t_debug= @t_debug,
                        @t_file = @t_file,
                        @t_from = @w_sp_name,
                        @i_num  = 101098*/
                    RETURN 0    
                --return 101098
        end
        begin tran

                if not exists (select 1 from cl_instancia, cl_at_instancia
                                 where  in_ente_i    = @i_izquierda
                                   and  ai_relacion  = in_relacion
                                   and  ai_ente_i    = in_ente_i
                                   and  ai_ente_d    = in_ente_d
                                   and  ai_secuencial <> @i_secuencial)
                begin
                    	/* Extraigo grupo para eliminacion */
                        select @w_grupo = cg_grupo from cobis..cl_cliente_grupo where cg_ente = @i_izquierda and cg_estado <> 'C'
                    	
                        delete  cl_instancia
                        where  in_ente_i    = @i_izquierda
                        AND    in_ente_d in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_grupo)
                    
                    
                        if @@error <> 0
                        begin           
                          exec cobis..sp_cerror 
                          @t_debug= @t_debug,
                          @t_file = @t_file,
                          @t_from = @w_sp_name,
                          @i_num  = 107054  
                          return 107054  
                        end

                        /* Historico de Relaciones 
                        insert into cl_his_relacion (hr_secuencial,hr_relacion, hr_ente_i, hr_ente_d, 
                                                     hr_fecha_ini, hr_fecha_fin)
                                        values      (@s_ssn, @i_relacion, @i_izquierda, @i_derecha,
                                                     @w_fecha_ini, @s_date)
                        if @@error <> 0
                        begin                   
                                exec cobis..sp_cerror
                                        @t_debug= @t_debug,
                                        @t_file = @t_file,
                                        @t_from = @w_sp_name,
                                        @i_num  = 103062
                                return 103062
                        end*/
                        
                        delete  cl_instancia
                         where  in_ente_d = @i_izquierda
                         and    in_ente_i in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_grupo)
 
                       if @@error <> 0
                       begin
                          exec cobis..sp_cerror 
                          @t_debug= @t_debug,
                          @t_file = @t_file,
                          @t_from = @w_sp_name,
                          @i_num  = 107054  
                          return 107054  
                        end

                        /* Historico de Relaciones
                        if @@error = 0
                        begin
                                insert into cl_his_relacion (hr_secuencial, hr_relacion, 
                                                     hr_ente_i, hr_ente_d,
                                                     hr_fecha_ini, hr_fecha_fin)
                                        values      (@s_ssn, @i_relacion, 
                                                     @i_derecha, @i_izquierda,
                                                     @w_fecha_ini, @s_date)
                                if @@error <> 0
                                begin
                                        exec cobis..sp_cerror
                                                @t_debug= @t_debug,
                                                @t_file = @t_file,
                                                @t_from = @w_sp_name,
                                                @i_num  = 103061
                                        return 103061
                                end
                        end*/

                end /*if not exists */
                else
                begin /* Si existe */
                PRINT 'Entra Si existe '
                      delete  cl_instancia
                       where in_ente_i    = @i_izquierda

                      if @@error <> 0
                      begin           
                          exec cobis..sp_cerror 
                          @t_debug= @t_debug,
                          @t_file = @t_file,
                          @t_from = @w_sp_name,
                          @i_num  = 107054  
                          return 107054  
                      end

                      /* Historico de Relaciones
                      insert into cl_his_relacion (hr_secuencial,hr_relacion, hr_ente_i, hr_ente_d, 
                                           hr_fecha_ini, hr_fecha_fin)
                                      values      (@s_ssn, @i_relacion, @i_izquierda, @i_derecha,
                                                   @w_fecha_ini, @s_date)
                      if @@error <> 0
                      begin                   
                         exec cobis..sp_cerror
                            @t_debug= @t_debug,
                            @t_file = @t_file,
                            @t_from = @w_sp_name,
                            @i_num  = 103062
                         return 103062
                      end*/
                      
                      delete  cl_instancia
                       where  in_ente_d = @i_izquierda

                      if @@error <> 0
                      begin
                         exec cobis..sp_cerror 
                          @t_debug= @t_debug,
                          @t_file = @t_file,
                          @t_from = @w_sp_name,
                          @i_num  = 107054  
                          return 107054  
                      end

                      /* Historico de Relaciones
                      if @@error = 0
                      begin
                             insert into cl_his_relacion (hr_secuencial, hr_relacion, 
                                                  hr_ente_i, hr_ente_d,
                                                  hr_fecha_ini, hr_fecha_fin)
                                     values      (@s_ssn, @i_relacion, 
                                                  @i_derecha, @i_izquierda,
                                                  @w_fecha_ini, @s_date)
                            if @@error <> 0
                            begin
                               exec cobis..sp_cerror
                                  @t_debug= @t_debug,
                                  @t_file = @t_file,
                                  @t_from = @w_sp_name,
                                  @i_num  = 103061
                               return 103061
                            end
                      end*/

               /* borrar atributos asociados */
                if @i_secuencial is null
                begin
                       Delete cl_at_instancia
                        where ai_ente_i   = @i_izquierda

                      if @@error <> 0
                      begin
                         exec cobis..sp_cerror 
                            @t_debug= @t_debug,
                            @t_file = @t_file,
                            @t_from = @w_sp_name,
                            @i_num  = 107056  
                         return 107056  
                      end
                end
                else
                begin
                       Delete cl_at_instancia
                        where ai_ente_i   = @i_izquierda
                          and ai_secuencial = @i_secuencial
                      if @@error <> 0
                      begin
                         exec cobis..sp_cerror 
                            @t_debug= @t_debug,
                            @t_file = @t_file,
                            @t_from = @w_sp_name,
                            @i_num  = 107056  
                         return 107056  
                      end

                end

               /* borrar atributos asociados (Reciproco) */
                if @i_secuencial is null
                begin
                       Delete cl_at_instancia
                        where ai_ente_d   = @i_izquierda
                        
                      if @@error <> 0
                      begin
                         exec cobis..sp_cerror 
                            @t_debug= @t_debug,
                            @t_file = @t_file,
                            @t_from = @w_sp_name,
                            @i_num  = 107056  
                         return 1
                      end
                end
                else
                begin
                       Delete cl_at_instancia
                        where ai_ente_d   = @i_izquierda 
                          and ai_secuencial = @i_secuencial
                      if @@error <> 0
                      begin
                         exec cobis..sp_cerror 
                            @t_debug= @t_debug,
                            @t_file = @t_file,
                            @t_from = @w_sp_name,
                            @i_num  = 107056  
                         return 1
                      end

                end
             end /* Fin Si existe */

        commit tran
        return 0

end
else
begin
        exec sp_cerror
           @t_debug      = @t_debug,
           @t_file       = @t_file,
           @t_from       = @w_sp_name,
           @i_num        = 151051

        return 1
end

end




/*  Query  */
if @i_operacion = 'Q'
begin

if @t_trn = 1186
begin

        select  in_relacion,
                re_izquierda, 
                re_derecha,
                in_ente_i,
                x.en_nombre + ' ' + x.p_p_apellido,
                in_ente_d,
                y.en_nombre + ' ' + y.p_p_apellido,
                in_lado
          from  cl_instancia, 
                cl_relacion,
                cl_ente x,
                cl_ente y
         where  in_relacion = @i_relacion
           and  in_ente_i   = @i_izquierda
           and  in_ente_d   = @i_derecha
           and  re_relacion = in_relacion
           and  x.en_ente   = in_ente_i
           and  y.en_ente   = in_ente_d

       if @@rowcount <> 1
       begin
         /*  No existe instancia de relacion  */
         exec cobis..sp_cerror
                 @t_debug= @t_debug,
                 @t_file = @t_file,
                 @t_from = @w_sp_name,
                 @i_num  = 101098
         return 1
       end

      return 0

end
else
begin
        exec sp_cerror
           @t_debug      = @t_debug,
           @t_file       = @t_file,
           @t_from       = @w_sp_name,
           @i_num        = 151051
           /*  'No corresponde codigo de transaccion' */
        return 1
end

end
go

