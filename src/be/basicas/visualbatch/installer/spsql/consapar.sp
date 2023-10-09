/************************************************************************/
/* Archivo:                consapar.sp                                  */
/* Stored procedure:       sp_cons_ap_parametros                        */
/* Base de datos:          cobis                                        */
/* Producto:               cobis                                        */
/* Disenado por:           John Jairo Parra Perez                       */
/* Fecha de escritura:     25-enero-2004                                */
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
/*    Este programa permite enviar al Front-End de Visual Batch         */
/*    los parametros de c/u de los procesos asociados a un lote         */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    25-Ene-2005    J. Parra        Emision Inicial                    */
/*    05-Sep-2011    S. Soto         Homologacion, cambios por VU-print */
/************************************************************************/

use cobis
go

if exists (select 1 from sysobjects
            where name = 'ba_cons_param')
   drop table ba_cons_param
go

create table cobis..ba_cons_param
   (
      cp_secuencial  int NULL,
      cp_columna_1   varchar(70),
      cp_columna_2   varchar(70),
      cp_columna_3   varchar(70),
      cp_columna_4   varchar(30),
      cp_sec         int,
      cp_seccorrido  int NULL
   )
go

if exists (select 1 from sysobjects
            where name = 'sp_cons_ap_parametros')
         drop proc sp_cons_ap_parametros
go

create proc sp_cons_ap_parametros
(
   @s_ssn            int = null,
   @s_date           datetime = null,
   @s_user           login = null,
   @s_term           descripcion = null,
   @s_corr           char(1) = null,
   @s_ssn_corr       int = null,
   @s_ofi            smallint = null,
   @t_rty            char(1) = null,
   @t_trn            smallint,
   @t_debug          char(1) = 'N',
   @t_file           varchar(14) = null,
   @t_from           varchar(30) = null,
   @t_show_version   bit = 0, 
   @i_filial         smallint = 0,
   @i_operacion      char(1),
   @i_modo           tinyint,
   @i_sarta          int,
   @i_nom_sarta      descripcion = '',
   @i_secuencial     int = 0
)
as 
declare
   @w_filial         varchar(70),
   @w_oficina        varchar(70),
   @w_fecha_sistema  varchar(30),
   @w_hora_sistema   varchar(30),
   @w_sarta          descripcion,
   @w_batch          int,
   @w_nom_batch      descripcion,
   @w_parametro      varchar(70),
   @w_valor          descripcion,
   @w_aprobado       char(3),
   @w_salida_batch   varchar(70),
   @w_secuencial     int,
   @w_sp_name        descripcion,
   @w_aux            int,
   @w_sec            int,
   @w_num            int,
   @w_secint         int,
   @w_batch_ant      int

select @w_sp_name = 'sp_cons_ap_parametros'

---- VERSIONAMIENTO DEL PROGRAMA ----
if @t_show_version = 1
begin
    print 'Stored procedure sp_cons_ap_parametros, Version 4.0.0.0'
    return 0
end

if @t_trn <> 8113
begin 
   /* La transaccion no corresponde */
   exec cobis..sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 801077
   return 1
end


if @i_operacion = 'C'
begin
   truncate table cobis..ba_cons_param
   select @w_secuencial = 0  
   
   -- Lectura de la cabecera del informe --
   select 
      'APROBACION DE PARAMETROS',
      'COBIS - Visual Batch',
      fi_nombre,
      convert(varchar(4), of_oficina) + ' - ' + of_nombre,
      convert(varchar(7), @i_sarta) + ' - ' + @i_nom_sarta,
      convert(varchar(15), getdate(), 103),
      convert(varchar(15), getdate(), 108)
    from cobis..cl_filial, cobis..cl_oficina 
    where fi_filial = @i_filial
      and of_oficina = @s_ofi 

end

-- Lectura de los parametros por proceso --
if @i_operacion = 'D'
begin
 
truncate table cobis..ba_cons_param
   select @w_secuencial = 0,
          @w_num = 0,
          @w_batch_ant = 0 	

   create table #secuenciales
             (
			 proceso        int, 
			 secuencial		int
			 )
   
   declare cons_param cursor 
   for select sb_batch, ba_nombre, sb_secuencial
         from cobis..ba_sarta_batch, cobis..ba_batch 
        where sb_sarta = @i_sarta
          and ba_batch = sb_batch
   order by sb_batch
   for read only
   
   open cons_param
   
   fetch cons_param
   into
      @w_batch,
      @w_nom_batch,
	  @w_sec
   if @@fetch_status = -2
   begin
      close  cons_param               --Cierra Cursor
      deallocate  cons_param    --Elimina Cursor
      exec cobis..sp_cerror
         @t_debug  = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 808071
      return 1
   end
          
   if @@fetch_status = -1
   begin
      close  cons_param               --Cierra Cursor
      deallocate  cons_param    --Elimina Cursor
      return 1
   end
  
   while @@fetch_status = 0
   begin
      
      -- Insertando nombre del proceso
      select @w_secuencial = @w_secuencial + 1
      select @w_salida_batch = convert(varchar(10), @w_batch) + ' - ' + @w_nom_batch
      insert into cobis..ba_cons_param (cp_secuencial, cp_columna_1, cp_columna_2, cp_columna_3, cp_columna_4, cp_sec, cp_seccorrido)
         values (@w_secuencial, @w_salida_batch, '', '', '', @w_sec, NULL)
      if @@error != 0
      begin
         exec cobis..sp_cerror
            @t_debug  = @t_debug,
            @t_file   = @t_file,
            @t_from   = @w_sp_name,
            @i_num    = 808070
         return 1
      end

	  -- Obtener Secuenciales 
	  
      if @w_batch_ant <> @w_batch  
	 begin 
	      select @w_num = 0  
             insert into #secuenciales
             select pa_batch,  pa_ejecucion
               from cobis..ba_parametro
              where pa_sarta = @i_sarta
                and pa_batch = @w_batch
           group by pa_batch,  pa_ejecucion
         end
         
	 if exists (select 1 
	            from #secuenciales
				where proceso = @w_batch)
	 begin
	       set rowcount 1 
	       select @w_secint = secuencial
		   from #secuenciales
		   where secuencial > @w_num
		   and proceso = @w_batch
		   order by secuencial
		   
		   set rowcount 0 
		   
		   select @w_num = @w_secint 
	  end
	  else 
	       select @w_secint = null
      begin tran
         declare param cursor for
            select   convert(varchar(4), pa_parametro) + ' - ' + pa_nombre,
                     pa_valor
              from cobis..ba_parametro
             where pa_sarta = @i_sarta
               and pa_batch = @w_batch
               and pa_ejecucion = @w_secint
              order by pa_parametro
         for read only
         
         open param
         fetch param into
            @w_parametro,
            @w_valor
         
         --if @@fetch_status = -2
         --begin
         --   close  param               --Cierra Cursor
         --   deallocate  param    --Elimina Cursor
         --end
         --       
         --if @@fetch_status = -1
         --begin
         --   close  param               --Cierra Cursor
         --   deallocate  param    --Elimina Cursor
         --   -- return 1
         --end
                  
         while @@fetch_status = 0
         begin
            select @w_secuencial = @w_secuencial + 1
            -- Insertando parametros y sus valores  
            insert into cobis..ba_cons_param (cp_secuencial, cp_columna_1, cp_columna_2, cp_columna_3, cp_columna_4, cp_sec, cp_seccorrido)
               values (@w_secuencial, '', @w_parametro, @w_valor, '|__|', @w_sec, NULL)
            if @@error != 0
            begin
               exec cobis..sp_cerror
                  @t_debug  = @t_debug,
                  @t_file   = @t_file,
                  @t_from   = @w_sp_name,
                  @i_num    = 808070
               rollback tran
            end
      
            fetch param into     -- siguiente registro
               @w_parametro,
               @w_valor 
         end
         
         close param 
         deallocate  param
      commit tran
   
     select @w_batch_ant = @w_batch
      fetch cons_param
      into
         @w_batch,
         @w_nom_batch,
         @w_sec
   end
   
      close cons_param    
      deallocate  cons_param

  create table #ba_cons_param
      (
      cp_secuencial  int NULL,
      cp_columna_1   varchar(70),
      cp_columna_2   varchar(70),
      cp_columna_3   varchar(70),
      cp_columna_4   varchar(30),
      cp_sec         int,
      cp_seccorrido  numeric identity not null
      )
 
   insert into #ba_cons_param
   select cp_secuencial, cp_columna_1, cp_columna_2, cp_columna_3, cp_columna_4, cp_sec
     from cobis..ba_cons_param
    order by cp_sec, cp_secuencial
	  
   truncate table cobis..ba_cons_param
	  
   insert into cobis..ba_cons_param
   select * from #ba_cons_param
end   -- @i_operacion = 'D'

if @i_operacion = 'S'
begin 
   set rowcount 20

   if @i_modo = 0
   begin
      select 
         'PROCESO' = cp_columna_1,
         'PARAMETRO' = cp_columna_2,
         'VALOR' = cp_columna_3,
         'APROBADO [s/n]' = cp_columna_4,
	 'SECUENCIAL' = cp_secuencial
        from cobis..ba_cons_param
      order by cp_sec, cp_secuencial
      
      if @@rowcount = 0
      begin 
         exec cobis..sp_cerror
            @t_debug  = @t_debug,
            @t_file   = @t_file,
            @t_from   = @w_sp_name,
            @i_num    = 808072
         return 1
      end
      
   end   -- @i_modo = 0
      
   if @i_modo = 1
   begin
      select 
         'PROCESO' = cp_columna_1,
         'PARAMETRO' = cp_columna_2,
         'VALOR' = cp_columna_3,
         'APROBADO [s/n]' = cp_columna_4,
         'SECUENCIAL' = cp_secuencial
     from cobis..ba_cons_param
     where  cp_seccorrido > @i_secuencial
	 order by cp_sec, cp_secuencial
      
      if @@rowcount = 0
      begin 
         exec cobis..sp_cerror
            @t_debug  = @t_debug,
            @t_file   = @t_file,
            @t_from   = @w_sp_name,
            @i_num    = 808072
         return 1
      end
      
   end   -- @i_modo = 1
end   -- @i_operacion = 'S'       

return 0
go
