/************************************************************************/
/* Archivo:                corrida.sp                                   */
/* Stored procedure:       sp_corrida                                   */
/* Base de datos:          cobis                                        */
/* Producto:               batch                                        */
/* Disenado por:                                                        */
/* Fecha de escritura:     30-Octubre-2002                              */
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
/*    Implementa las operaciones para el control de cambios de es-      */
/*    tado del registro de control de corridas para el manejo de        */
/*    concurrencia en la ejecucion de sartas                            */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    30-Oct-2002    D. Ayala        Emision Inicial                    */
/************************************************************************/

use cobis 
go

if exists (select * from sysobjects where name = 'sp_corrida')
   drop proc sp_corrida

go
create proc sp_corrida    (
   @s_ssn         int = null,
   @s_date        datetime = null,
   @s_user        login = null,
   @s_term        descripcion = null,
   @s_corr        char(1) = null,
   @s_ssn_corr    int = null,
   @s_ofi         smallint = null,
   @t_rty         char(1) = null,
   @t_trn         smallint = 601,
   @t_debug       char(1) = 'N',
   @t_file        varchar(14) = null,
   @t_from        varchar(30) = null,
   @i_operacion   char(1),
   @i_ssn         int = null,
   @i_corrida     smallint = null,
   @i_estado      char(1) = null,
   @i_sarta       int, 
   @i_fecha_proceso  datetime = null,
   @i_finalizar      char(1) = 'N',
   @i_dstserver      varchar(64) = '',
   @i_shell        varchar(100) = '',
   @i_modo        tinyint = 0,
   @i_secuencial  smallint = null,
   @i_intento     smallint = null
)
as 

-- ' ==================
--' SE REALIZA LA SIGUIENTE ASIGNACION MIENTRAS NO SE VALIDA EL CORRECTO
--' FUNCIONAMIENTO DEL CONTROL DE CONCURRECIA EN LA EJECUCION DE LOTES
            
return 0

-- '===================

declare
   @w_sp_name        varchar(30),
   @w_today       datetime,
   @w_fecha_proceso             datetime, 
   @w_estado         char(1),
   @w_corrida        smallint,
   @w_vlpid       int,
   @w_pid_t       varchar(255),
   @w_programa_t     varchar(255),
   @w_pid         varchar(255),
   @w_programa       varchar(255),
   @w_len_pid_tot       int,
   @w_len_prog_tot      int,
   @w_len_pid        int,
   @w_len_prog       int,
   @w_srvname        varchar(30),
   @w_comando        varchar(255),
   @w_comando1       varchar(255),
   @w_hora_ini       datetime,
   @w_corrida_t         smallint,
   @w_estado_t       char(1), 
   @w_ssn_t       int,
   @w_inicio         char(1),
   @w_login_t        login,
   @w_vl_estado         char(1)

select   @w_sp_name  = 'sp_corrida',
   @w_today    = getdate(),
   @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso


if (@t_trn <> 8103 and @i_operacion = 'I') or  --Inserta corrida
   (@t_trn <> 8103 and @t_trn <> 8104 and @i_operacion = 'E') or  --Eliminacion de registro
   (@t_trn <> 8103 and @i_operacion = 'A') or  --G -> E
   (@t_trn <> 8104 and @i_operacion = 'B') or  --E -> P
   (@t_trn <> 8105 and @i_operacion = 'C') or  --E -> F
   (@t_trn <> 8105 and @i_operacion = 'D') or  --E -> R
   (@t_trn <> 8103 and @i_operacion = 'J') or  --P -> Z
   (@t_trn <> 8103 and @i_operacion = 'F') or  --P -> R
   (@t_trn <> 8103 and @t_trn <> 8104 and @i_operacion = 'G') or  --R -> P
   (@t_trn <> 8103 and @i_operacion = 'H') or  --R -> E
   (@t_trn <> 8103 and @i_operacion = 'K') or  --F -> E
   (@t_trn <> 8103 and @t_trn <> 8104 and @i_operacion = 'L') or  --F -> E
   (@t_trn <> 8104 and @i_operacion = 'Q')     --Consulta de registro de corrida
   begin
     /* 'Tipo de transaccion no corresponde' */
     exec cobis..sp_cerror
          @t_debug = @t_debug,
     @t_file  = @t_file,
     @t_from  = @w_sp_name,
     @i_num   = 601077
     return 1
   end

-- VALIDACION DE ULTIMA CORRIDA
-- Todos los controles deben realizarse sobre la £ltima corrida
-- Cuando se recibe el parametro @i_corrida, este debe ser igual
-- al de la consulta siguiente
select @w_corrida    = null
select @w_corrida   = max(co_corrida_id)
  from ba_corrida
 where co_sarta     = @i_sarta
   and co_fecha_proceso = @i_fecha_proceso

if (@i_corrida is not null) and (@i_corrida <> @w_corrida) and (@i_operacion <> 'A')
begin
   /* 'Error, la ultima corrida no corresponde a la consultada' */ 
     exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 808049
     return 1
end
  
/* Insercion de registro a ba_corrida, (x) -> G */
if @i_operacion = 'I'   
begin
   select @w_estado = null
   -- CONTROLES
   select @w_estado = co_estado
     from ba_corrida
    where co_sarta     = @i_sarta
      and co_fecha_proceso = @i_fecha_proceso

   -- Si no existe registro o el estado es Z
   -- crear nuevo registro de corrida
   if @w_estado is null or @w_estado = 'Z'
   begin
      INSERT INTO ba_corrida (co_corrida_id, co_sarta, co_estado, co_fecha_proceso, co_ssn, co_login )
                      values (0, @i_sarta, 'G', @i_fecha_proceso, @s_ssn, @s_user )
      if @@error <> 0
      begin
         /* 'Error en creacion de corrida' */
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 808025
         rollback
         return 1
      end   
      -- RETORNO AL FEnd EL ssn DE LA CORRIDA ACTIVA
      select @s_ssn
      return 0
   end
   else
   begin 
      /* 'No es posible graficar este lote pues esta activo' */
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 808026
         return 1
   end   
end

/* Eliminacion del registro a ba_corrida, G -> (x) */
if @i_operacion = 'E'   
begin
   select @w_estado   = null
   -- CONTROLES
   select @w_estado   = co_estado,
          @w_corrida  = co_corrida_id
     from ba_corrida
    where co_corrida_id   = 0
      and co_sarta     = @i_sarta
      and co_fecha_proceso = @i_fecha_proceso

   -- Si corrida esta graficada (G) y con corrida 0 
   -- se libera la sarta
   if @w_estado = 'G' and @w_corrida = 0
   begin
      delete ba_corrida
       where co_corrida_id   = 0
         and co_sarta     = @i_sarta
         and co_fecha_proceso = @i_fecha_proceso

      if @@error <> 0
      begin
         /* 'Error en liberacion del lote' */
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 808027
        rollback
        return 1
      end
      return 0
   end
   else
   begin
      /* 'No es posible liberar este lote pues esta activo. Refrescar la consulta administrativa' */
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 808028
           return 1      
   end   
end

/* Cambio de estado a ejecucion ba_corrida, G -> E */
if @i_operacion = 'A'
begin
   select @w_estado   = null
   -- CONTROLES
   select @w_estado   = co_estado,
          @w_corrida  = co_corrida_id
     from ba_corrida
    where co_corrida_id   = 0
      and co_sarta    = @i_sarta
      and co_estado   = 'G'
      and co_fecha_proceso = @i_fecha_proceso
      and co_ssn      = @i_ssn

   -- Si corrida esta graficada (G) y con corrida 0 
   -- se inicia la ejecucion
   if @w_estado = 'G' and @w_corrida = 0
   begin
      update ba_corrida
         set co_corrida_id  = @i_corrida,
             co_estado   = 'E'
       where co_corrida_id   = 0
         and co_sarta     = @i_sarta
         and co_estado    = 'G'
         and co_fecha_proceso = @i_fecha_proceso
         and co_ssn       = @i_ssn

      if @@error <> 0
      begin
         /* 'Error en cambio de estado a Ejecucion' */
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 808029
         rollback
         return 1
      end
      return 0
   end
   else
   begin
      /* 'No existen condiciones para iniciar la Ejecucion, posiblemente el lote esta activo en otra estacion' */
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 808030
           return 1
   end
end

/* Cambio de estado a Pendiente (para cargar) ba_corrida, E -> P */
if @i_operacion = 'B'
begin
   select @w_estado   = null
   -- CONTROLES
   select @w_estado   = co_estado
    from ba_corrida
   where co_corrida_id   = @w_corrida
     and co_sarta     = @i_sarta
     and co_estado    = 'E'
     and co_fecha_proceso = @i_fecha_proceso

   -- Si corrida en ejecucion, es la maxima para sarta
   -- y fecha de proceso, validar si existen procesos en ejecuion
   if @w_estado = 'E'
   begin
      if @i_modo = 0
      begin
         -- VLPID (Validacion de log sin fecha de terminacion y
         -- procesos del Sistema Operativo Acitvos
         -- Si VLPID = Verdadero, no es posible actualizar el estado
         -- de la corrida a Pendiente (para cargar)
         select @w_pid      = null,
                @w_programa = null,
                @w_inicio   = 'N'

         delete ba_vlpid
          where vl_corrida   = @w_corrida
            and vl_sarta     = @i_sarta
            and vl_fecha_proceso = @i_fecha_proceso

         DECLARE cur_log CURSOR FOR
          select LTRIM(RTRIM(STR(sb_id_proceso))),
                 LTRIM(RTRIM(ba_arch_fuente))
            from ba_log, ba_sarta_batch_log, ba_batch
           where lo_corrida   = @w_corrida
             and lo_sarta  = @i_sarta
             and lo_fecha_proceso = @i_fecha_proceso
             and lo_fecha_terminacion is null
             and sb_corrida   = @w_corrida
             and sb_sarta  = @i_sarta
             and lo_corrida   = sb_corrida
             and lo_sarta  = sb_sarta
             and lo_batch  = sb_batch
             and lo_secuencial   = sb_secuencial
             and ba_batch  = sb_batch
 
            OPEN cur_log
           FETCH cur_log INTO
                 @w_pid_t,
                 @w_programa_t
          select @w_len_pid_tot = 0,
                 @w_len_prog_tot = 0

--         select @w_srvname = RTRIM(LTRIM(srvname))
--           from master..sysservers
--          where srvclass = 0
   
         select substring(srvname, charindex ('\', srvname) + 1, datalength(srvname)) 
           from master..sysservers
          where srvid = 0

         if @@rowcount = 0
            begin
               /* No se ha encontrado el servidor de la base de datos */
               exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 808006
                return 1
         end

         select @w_comando = RTRIM(LTRIM(@i_dstserver)) + '...rp_exec "' + RTRIM(LTRIM(@i_shell)) + '", '
         select @w_comando = @w_comando + '"' + RTRIM(LTRIM(@i_dstserver)) + '", '  -- param1
         select @w_comando = @w_comando + '"' + RTRIM(LTRIM(CONVERT(varchar(20), @i_sarta))) + '", '  -- param2
         select @w_comando = @w_comando + '"' + RTRIM(LTRIM(CONVERT(varchar(20), @w_corrida))) + '", '   -- param3
         select @w_comando = @w_comando + '"' + RTRIM(LTRIM(CONVERT(varchar(10), @i_fecha_proceso, 101))) + '", ' -- param4

         WHILE @@fetch_status != -1
            begin
               if (@@fetch_status = -2)
               begin
                  /* Error en recuperacion de datos del cursor */
                  exec cobis..sp_cerror
                       @t_debug = @t_debug,
                       @t_file  = @t_file,
                       @t_from  = @w_sp_name,
                       @i_num   = 2101015
        
                  CLOSE cur_log
                  deallocate  cur_log
                  return 1
               end

            select @w_len_pid = DATALENGTH(@w_pid_t),
                   @w_len_prog = DATALENGTH(@w_programa_t)
         
            if (@w_len_pid + @w_len_pid_tot) > 165 or (@w_len_prog + @w_len_prog_tot) > 165
            begin
               -- DISPARAR rp_exec
               select @w_comando1 = @w_comando + '"' + RTRIM(LTRIM(@w_pid)) + '", '    -- param5
               select @w_comando1 = @w_comando + '"' + RTRIM(LTRIM(@w_programa)) + '"'    -- param6

               exec (@w_comando1)
             select @w_pid = '',
                    @w_programa = '',
                    @w_len_pid_tot = 0,
                    @w_len_prog_tot = 0,
                    @w_inicio = 'S'
            end
            select @w_pid      = @w_pid + ' ' + @w_pid_t,    
                   @w_programa    = @w_programa + ' ' + @w_programa_t,
                   @w_len_pid_tot    = @w_len_pid + @w_len_pid_tot,
                   @w_len_prog_tot = @w_len_prog + @w_len_prog_tot
         
               FETCH cur_log INTO
                     @w_pid_t,
                     @w_programa_t
         end   /* FIN while */
         CLOSE cur_log
         deallocate  cur_log
   
         select @w_vlpid = -1

         -- SE ESTA EVALUANDO EN UNIX LA ACTIVIDAD DE LOS PROCESOS
         -- ANALIZAR LA TABLA ba_vlpid. LAZO INFINITO
         if @w_inicio = 'S'
         begin
            while 1=1
            begin
               select @w_hora_ini = getdate()
               select @w_vl_estado = vl_estado               
                 from ba_vlpid
                where vl_corrida = @w_corrida
                  and vl_sarta   = @i_sarta
                  and vl_fecha_proceso = @i_fecha_proceso

               if @w_vl_estado = 'E' or @w_vl_estado = 'D' 
                  select @w_vlpid = 1
               
               if @w_vl_estado = 'X' 
                  select @w_vlpid = 0
               
               if datediff (ss, @w_hora_ini, getdate()) > 50
                  select @w_vlpid = 1

               if @w_vlpid in (0, 1)
                  BREAK       
            end      
         end
         else
         begin
            select @w_vlpid = 0
         end
         -- Si no existen procesos ejecutandose en el Sis Oper liberar
         -- la corrida a Pendiente (para cargar)
         if @w_vlpid <> 0
         begin
            /* 'No es posible liberar la corrida para esta sarta, 
               no existe una corrida en Ejecucion para esta fecha de proceso' */
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 808033
            return 1
         end
      end
      if @i_modo = 1
      begin
         update ba_corrida
            set co_estado  = 'P',
                co_ssn      = null,
                co_login   = null
          where co_corrida_id   = @w_corrida
            and co_sarta     = @i_sarta
            and co_estado    = 'E'
            and co_fecha_proceso = @i_fecha_proceso

         if @@error <> 0
         begin
            /* 'Error en cambio de estado a Pendiete para cargar' */
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 808031
            rollback
            return 1
         end
         return 0
      end
   end
   else
   begin
      /* 'No existen condiciones para iniciar la Ejecucion, posiblemente el lote esta activo en otra estacion' */
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 808030
     return 1
   end
end

/* Cambio de estado a Finalizado ba_corrida, E -> F */
if @i_operacion = 'C'
begin
   select   @w_estado   = null
   -- CONTROLES
   select   @w_estado   = co_estado
   from  ba_corrida
   where    co_corrida_id   = @i_corrida
   and   co_sarta     = @i_sarta
   and   co_estado    = 'E'
   and   co_fecha_proceso = @i_fecha_proceso
   and   co_ssn       = @i_ssn

   -- Si corrida en ejecucion, para sarta
   -- y fecha de proceso: acutalizar estado a Finalizado
   if @w_estado = 'E'
   begin
      update ba_corrida
         set co_estado   = 'F'
       where co_corrida_id   = @i_corrida
         and co_sarta     = @i_sarta
         and co_estado    = 'E'
         and co_fecha_proceso = @i_fecha_proceso
         and co_ssn       = @i_ssn

      if @@error <> 0
      begin
         /* 'Error en cambio de estado a Finalizado' */
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 808034
         rollback
         return 1
      end
      return 0
   end
   else
   begin
      /* 'No existen condiciones para Finalizar la corrida, posiblemente el lote esta activo en otra estacion' */
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 808035
      return 1
   end
end

/* Cambio de estado a PG, Pendiente Graficado, ba_corrida, E -> R */
if @i_operacion = 'D'
begin
   select @w_estado   = null
   -- CONTROLES
   select @w_estado   = co_estado
    from ba_corrida
   where co_corrida_id   = @i_corrida
     and co_sarta     = @i_sarta
     and co_estado    = 'E'
     and co_fecha_proceso = @i_fecha_proceso
     and co_ssn       = @i_ssn

   -- Si corrida en ejecucion, para sarta
   -- y fecha de proceso: acutalizar estado a R (Pendiente Graficado)
   if @w_estado = 'E'
   begin
      update ba_corrida
         set co_estado   = 'R'
       where co_corrida_id   = @i_corrida
        and co_sarta     = @i_sarta
        and co_estado    = 'E'
        and co_fecha_proceso = @i_fecha_proceso
        and co_ssn       = @i_ssn
      if @@error <> 0
                begin
                        /* 'Error en cambio de estado a Pendiente Graficado' */
                        exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 808036
         rollback
                        return 1
      end
      return 0
   end
   else
   begin
      /* 'No existen condiciones para cambio de estado a 
         Pendiente Graficado, posiblemente el lote 
         esta activo en otra estacion' */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 808037

                return 1
   end
end

/* Cambio de estado a Finalizado, ba_corrida, P -> Z */
/* Sub operacion 1: Consultar si existe una corrida en estado "P" */
/* Sub operacion 2: Cambiar de estado a  "Z" */
if @i_operacion = 'J'
begin
   select   @w_estado   = null

   -- CONTROLES
   select   @w_estado   = co_estado
   from  ba_corrida
   where    co_corrida_id   = @w_corrida
   and   co_sarta     = @i_sarta
   and   co_estado    = 'P'
   and   co_fecha_proceso = @i_fecha_proceso

   -- Existe corrida pendiente para graficar, fecha de proceso y sarta
   if @w_estado = 'P'      
   begin
      -- SUB OPERACION 1:
      if @i_finalizar = 'N'
      begin
         -- CARGAR NUEVA CORRIDA (NO)
         select 'N'
      end
      -- SUB OPERACION 2:
      else     
      begin
         BEGIN TRAN

         -- CAMBIO DE ESTADO A Finalizado
         update   ba_corrida
         set   co_estado   = 'Z'
         where    co_corrida_id   = @w_corrida
         and   co_sarta     = @i_sarta
         and   co_estado    = 'P'
         and   co_fecha_proceso = @i_fecha_proceso
   
         if @@error <> 0
                  begin
                           /* 'Error en cambio de estado a Finalizado' */
                           exec cobis..sp_cerror
                         @t_debug = @t_debug,
                          @t_file  = @t_file,
                           @t_from  = @w_sp_name,
                           @i_num   = 808038
            rollback
                          return 1
         end

         -- CREAR CORRIDA NUEVA PARA GRAFICAR EN FEnd
         INSERT INTO ba_corrida (
            co_corrida_id,
            co_sarta,
            co_estado,
            co_fecha_proceso,
            co_ssn,
            co_login )
         values ( 
            0,
            @i_sarta,
            'G',
            @i_fecha_proceso,
            @s_ssn,
            @s_user )
         
         if @@error <> 0
                  begin
                           /* 'Error en creacion de corrida' */
                           exec cobis..sp_cerror
                         @t_debug = @t_debug,
                          @t_file  = @t_file,
                           @t_from  = @w_sp_name,
                    @i_num   = 808025
            rollback
                           return 1
                 end   
      
         -- RETORNO AL FEnd EL ssn DE LA CORRIDA ACTIVA
         select @s_ssn

         COMMIT TRAN
         return 0
      end
   end
   else
   begin
      if @i_finalizar = 'N' 
      begin
         -- CARGAR NUEVA CORRIDA (SI)
         select 'S'
         return 0
      end

/* ====================================================================
      /* 'No existen condiciones para cambio de estado a 
         Finalizado, posiblemente el lote 
         esta activo en otra estacion' */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 808039

                return 1
 ==================================================================== */
   end
end


/* Cambio de estado a R (Pendiente Graficado), ba_corrida, P -> R  */
/* a */
/* Cambio de estado a F (Finalizado Graficado), ba_corrida, Z -> F */
if @i_operacion = 'F'
begin
   select   @w_estado   = null

   -- CONTROLES
   select   @w_estado   = co_estado
   from  ba_corrida
   where    co_corrida_id   = @i_corrida
   and   co_sarta     = @i_sarta
   and   co_estado    in ('P', 'Z')
   and   co_fecha_proceso = @i_fecha_proceso

   if @w_estado is null
   begin
      /* 'No existen condiciones para cargar esta corrida, 
         posiblemente el lote esta activo en otra estacion' */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 808041

                return 1
   end

   -- Existe corrida pendiente para graficar, fecha de proceso y sarta
   if @w_estado = 'P'      
   begin
      -- CAMBIO DE ESTADO A Finalizado
      update   ba_corrida
      set   co_estado   = 'R',
         co_ssn      = @s_ssn,
         co_login = @s_user
      where    co_corrida_id   = @i_corrida
      and   co_sarta     = @i_sarta
      and   co_estado    = 'P'
      and   co_fecha_proceso = @i_fecha_proceso    

      if @@error <> 0
                  begin
                        /* 'Error en cambio de estado a Pendiente Graficado' */
                        exec cobis..sp_cerror
                         @t_debug = @t_debug,
                          @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                    @i_num   = 808040
         rollback
                        return 1
                 end   
      
      -- RETORNO AL FEnd EL ssn DE LA CORRIDA ACTIVA
      select @s_ssn
      return 0
   end

   -- Existe corrida pendiente para graficar, fecha de proceso y sarta
   if @w_estado = 'Z'
   begin
      -- CAMBIO DE ESTADO A Finalizado
      update   ba_corrida
      set   co_estado   = 'F',
         co_ssn      = @s_ssn,
         co_login = @s_user
      where    co_corrida_id   = @i_corrida
      and   co_sarta     = @i_sarta
      and   co_estado    = 'Z'
      and   co_fecha_proceso = @i_fecha_proceso    

      if @@error <> 0
                  begin
                        /* 'Error en cambio de estado a Finalizado Graficado' */
                        exec cobis..sp_cerror
                         @t_debug = @t_debug,
                          @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                    @i_num   = 808045
         rollback
                        return 1
                 end   
      
      -- RETORNO AL FEnd EL ssn DE LA CORRIDA ACTIVA
      select @s_ssn
      return 0
   end
end

/* Cambio de estado a P (Pendiente para Graficar), ba_corrida, R -> P */
/* Se libera la corrida para graficarse (cargarse) */
if @i_operacion = 'G'
begin
   select   @w_estado   = null

   -- CONTROLES
   select   @w_estado   = co_estado
   from  ba_corrida
   where    co_corrida_id   = @i_corrida
   and   co_sarta     = @i_sarta
   and   co_estado    = 'R' 
   and   co_fecha_proceso = @i_fecha_proceso

   -- Existe corrida Pendiente Graficar, fecha de proceso y sarta
   if @w_estado = 'R'     
   begin
      -- CAMBIO DE ESTADO A Finalizado
      update   ba_corrida
      set   co_estado   = 'P',
         co_ssn      = null,
         co_login = null
      where    co_corrida_id   = @i_corrida
      and   co_sarta     = @i_sarta
      and   co_estado    = 'R'
      and   co_fecha_proceso = @i_fecha_proceso    

      if @@error <> 0
                  begin
                        /* 'Error en cambio de estado a Pendiente (para graficar)' */
                        exec cobis..sp_cerror
                         @t_debug = @t_debug,
                          @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                    @i_num   = 808042
         rollback
                        return 1
                 end   
      
      return 0
   end
   else
   begin
      /* 'No existen condiciones para cambio de estado a 
         Pendiente (para graficar), posiblemente el lote 
         esta activo en otra estacion' */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 808043

                return 1
   end
end

/* Cambio de estado a E, ba_corrida, R -> E */
if @i_operacion = 'H'
begin
   select   @w_estado   = null

   -- CONTROLES
   select   @w_estado   = co_estado
   from  ba_corrida
   where    co_corrida_id   = @i_corrida
   and   co_sarta     = @i_sarta
   and   co_estado    = 'R'
   and   co_fecha_proceso = @i_fecha_proceso
   and   co_ssn       = @i_ssn

   -- Si corrida esta cargada (R) y con corrida 
   -- se re-inicia la ejecucion
   if @w_estado = 'R' and @w_corrida = @i_corrida
   begin
      update   ba_corrida
      set   co_estado   = 'E'
      where co_corrida_id   = @i_corrida
      and   co_sarta     = @i_sarta
      and   co_estado    = 'R'
      and   co_fecha_proceso = @i_fecha_proceso
      and   co_ssn       = @i_ssn

      if @@error <> 0
                begin
                        /* 'Error en cambio de estado a Ejecucion' */
                        exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 808029
         rollback
                        return 1
      end
      return 0
   end
   else
   begin
      /* 'No existen condiciones para re-iniciar la Ejecucion, 
         posiblemente el lote esta activo en otra estacion' */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 808044

                return 1
   end
end

/* Cambio de estado a E, ba_corrida, F -> E */
/* Se ejecuta un programa re-procesable de una sarta con
   corrida Finalizada */
if @i_operacion = 'K'
begin
   select   @w_estado   = null

   -- CONTROLES
   select   @w_estado   = co_estado
   from  ba_corrida
   where    co_corrida_id   = @i_corrida
   and   co_sarta     = @i_sarta
   and   co_estado    = 'F'
   and   co_fecha_proceso = @i_fecha_proceso
   and   co_ssn       = @i_ssn

   -- Si corrida esta Finalizada (R) y con corrida 
   -- se ejecucion un programa reprocesable ya finalizado 
   if @w_estado = 'F' and @w_corrida = @i_corrida
   begin
      update   ba_corrida
      set   co_estado   = 'E'
      where co_corrida_id   = @i_corrida
      and   co_sarta     = @i_sarta
      and   co_estado    = 'F'
      and   co_fecha_proceso = @i_fecha_proceso
      and   co_ssn       = @i_ssn

      if @@error <> 0
                begin
                        /* 'Error en cambio de estado a Ejecucion' */
                        exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 808029
         rollback
                        return 1
      end
      return 0
   end
   else
   begin
      /* 'No existen condiciones para re-iniciar la Ejecucion, 
         posiblemente el lote esta activo en otra estacion' */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 808044

                return 1
   end
end


/* Cambio de estado a Z (Pendiente para Graficar), ba_corrida, F -> Z */
/* Se libera la corrida para graficarse (cargarse) */
if @i_operacion = 'L'
begin
   select   @w_estado   = null

   -- CONTROLES
   select   @w_estado   = co_estado
   from  ba_corrida
   where    co_corrida_id   = @i_corrida
   and   co_sarta     = @i_sarta
   and   co_estado    = 'F'
   and   co_fecha_proceso = @i_fecha_proceso

   -- Existe corrida Finalizado Graficado, fecha de proceso y sarta
   if @w_estado = 'F'
   begin
      -- CAMBIO DE ESTADO A Finalizado Cerrado
      update   ba_corrida
      set   co_estado   = 'Z',
         co_ssn      = null,
         co_login = null
      where    co_corrida_id   = @i_corrida
      and   co_sarta     = @i_sarta
      and   co_estado    = 'F'
      and   co_fecha_proceso = @i_fecha_proceso    

      if @@error <> 0
                  begin
                        /* 'Error en cambio de estado a Finalizado Cerrado' */
                        exec cobis..sp_cerror
                         @t_debug = @t_debug,
                          @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                    @i_num   = 808047
         rollback
                        return 1
                 end   
      
      return 0
   end
   else
   begin
      /* 'No existen condiciones para cambio de estado a 
         (Z) Finalizado Cerrado, posiblemente el 
         lote esta activo en otra estacion' */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 808048

                return 1
   end
end

/* Consulta de los datos de la ultima corrida para una sarta y fecha de proceso */
if @i_operacion = 'Q'
begin
   if @i_modo = 0
   begin

      select   @w_corrida_t   = null,
         @w_estado_t = null,
         @w_ssn_t = null

      select   @w_corrida_t   = co_corrida_id,     
         @w_estado_t = co_estado,
         @w_ssn_t = co_ssn,
         @w_login_t  = co_login
      from  ba_corrida
      where co_corrida_id   = 0
      and   co_sarta  = @i_sarta
      and   co_fecha_proceso = @i_fecha_proceso


      if @w_corrida is null and @w_corrida_t is null
      begin
         /* 'No existe una corrida para esta sarta y fecha de proceso' */
                   exec cobis..sp_cerror
                 @t_debug = @t_debug,
                  @t_file  = @t_file,
                   @t_from  = @w_sp_name,
                 @i_num   = 808046

                   return 1
      end
   
      if @w_corrida_t = 0
      begin
         select   @w_corrida_t,
            @w_estado_t,
            (select valor 
               from  cl_tabla A,
                  cl_catalogo B
               where A.tabla = 'ba_est_corrida'
               and   B.tabla = A.codigo
               and   B.codigo = @w_estado_t),
            @w_ssn_t,
            fu_nombre
         from  cl_funcionario
         where fu_login = @w_login_t
         return 0
      end

      select   co_corrida_id,    
         X.co_estado,
         (select valor 
            from  cl_tabla A,
               cl_catalogo B
            where A.tabla = 'ba_est_corrida'
            and   B.tabla = A.codigo
            and   B.codigo = X.co_estado),
         co_ssn,
         fu_nombre
      from  ba_corrida X right outer join 
            cl_funcionario on (fu_login = co_login)
      where co_corrida_id   = @w_corrida
      and   co_sarta  = @i_sarta
      and   co_fecha_proceso = @i_fecha_proceso

      set rowcount 5
      SELECT   'SECUENCIAL'   = sb_secuencial,
         'INTENTO'   = lo_intento,
         'BATCH'     = sb_batch,
         'NOMBRE' = ba_nombre,
         'HABILITADO'   = sb_habilitado,        
         'TIPO BATCH'   = ba_tipo_batch,
         'IMPRIME'   = sb_imprimir,
         'PATH FUENTE'  = ba_path_fuente,
         'ARCHIVO FUENTE'= CONVERT(varchar(64), ba_arch_fuente),
         'SRV DESTINO'  = ba_serv_destino,
         'OPERADOR'  = CONVERT(varchar(20), lo_operador),
         'REPROCESO' = ba_reproceso,
         'PID'    = sb_id_proceso,
         'FECHA INICIO' = convert(char(26), lo_fecha_inicio, 109),
         'FECHA FIN' = convert(char(26), lo_fecha_terminacion, 109),
         'ESTADO' = lo_estatus,
         'RAZON'     = lo_razon
      FROM  ba_sarta_batch_log,
         ba_batch,
         ba_log
      WHERE sb_corrida  = @w_corrida
      and   sb_sarta = @i_sarta
      and   sb_batch = ba_batch
      and   lo_sarta = @i_sarta
      and   lo_sarta = sb_sarta
      and   lo_batch = sb_batch
      and   lo_secuencial  = sb_secuencial
      and   lo_batch = ba_batch
      and   lo_fecha_proceso = @i_fecha_proceso
      and   lo_corrida  = @w_corrida
      order by
         sb_secuencial,
         lo_intento
      set rowcount 0
   end   
   if @i_modo = 1
   begin
      set rowcount 5
      SELECT   'SECUENCIAL'   = sb_secuencial,
         'INTENTO'   = lo_intento,
         'BATCH'     = sb_batch,
         'NOMBRE' = ba_nombre,
         'HABILITADO'   = sb_habilitado,        
         'TIPO BATCH'   = ba_tipo_batch,
         'IMPRIME'   = sb_imprimir,
         'PATH FUENTE'  = ba_path_fuente,
         'SRV.DESTINO'  = ba_serv_destino,
         'ARCHIVO FUENTE'= CONVERT(varchar(64), ba_arch_fuente),
         'OPERADOR'  = CONVERT(varchar(20), lo_operador),
         'REPROCESO' = ba_reproceso,
         'PID'    = sb_id_proceso,
         'FECHA INICIO' = convert(char(26), lo_fecha_inicio, 109),
         'FECHA FIN' = convert(char(26), lo_fecha_terminacion, 109),
         'ESTADO' = lo_estatus,
         'RAZON'     = lo_razon        
      FROM  ba_sarta_batch_log,
         ba_batch,
         ba_log
      WHERE sb_corrida  = @w_corrida
      and   sb_sarta = @i_sarta
      and   sb_batch = ba_batch
      and   lo_sarta = @i_sarta
      and   lo_sarta = sb_sarta
      and   lo_batch = sb_batch
      and   lo_secuencial  = sb_secuencial
      and   lo_batch = ba_batch
      and   lo_fecha_proceso = @i_fecha_proceso
      and   lo_corrida  = @w_corrida
      and   ((sb_secuencial   > @i_secuencial) OR
          (sb_secuencial   >= @i_secuencial AND
           lo_intento > @i_intento))
      order by
         sb_secuencial,
         lo_intento

      set rowcount 0

   end
   return 0
end
go

/* fin */




