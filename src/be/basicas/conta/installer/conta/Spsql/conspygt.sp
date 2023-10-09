/************************************************************************/
/*	Archivo: 		conspygt.sp                             */
/*	Stored procedure: 	sp_consulta_pyg_terceros                */
/*	Base de datos:  	cob_conta                               */
/*	Producto:               Contabilidad                            */
/*	Disenado por:           Olga Rios                               */
/*	Fecha de escritura:     Nov-11-2005                             */
/************************************************************************/
/*				IMPORTANTE                              */
/*	Este programa es parte de los paquetes bancarios propiedad de   */
/*	"MACOSA", representantes exclusivos para el Ecuador de la "NCR  */
/*	CORPORATION".                                                   */
/*	Su uso no autorizado queda expresamente prohibido asi como      */
/*	cualquier alteracion o agregado hecho por alguno de sus         */
/*	usuarios sin el debido consentimiento por escrito de la         */
/*	Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*				PROPOSITO                               */
/*	Consulta de Saldos PYG desde Front-end del modulo Contabilidad. */
/************************************************************************/
/*				MODIFICACIONES                          */
/*	FECHA		AUTOR			RAZON                   */
/*	11/Nov/05	Olga Rios		Emision Inicial         */
/*	28/Mar/06	Mauricio Rincon		Consulta Movimiento PYG */
/*	                                        por Ente y Cuenta       */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_consulta_pyg_terceros')
   drop proc sp_consulta_pyg_terceros
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_consulta_pyg_terceros (
@s_ssn            int         = null,
@s_date           datetime    = null,
@s_user           login       = null,
@s_term           descripcion = null,
@s_corr           char(1)     = null,
@s_ssn_corr       int         = null,
@s_ofi            smallint    = null,
@t_rty            char(1)     = null,
@t_trn            int         = null,
@t_debug          char(1)     = 'N',
@t_file           varchar(14) = null,
@t_from           varchar(30) = null,
@i_modo           int,
@i_operacion      char(1)     = null,
@i_empresa 	  tinyint,
@i_oficina        smallint = null,
@i_area           smallint,
@i_ente           int     = null,
@i_tpodcto        varchar(30) = null,
@i_identif        varchar(30) = null,
@i_fecha          datetime,        -- fecha fin de mes
@i_nivelof        tinyint = null,  -- nivel de oficina
@i_cuenta         cuenta  = null,
@i_cuenta_ini     cuenta  = null,
@i_cuenta_fin     cuenta  = null,
@i_llave          varchar(32) = null
)
as 
begin

declare  @w_corte   int,
         @w_periodo int,
         @w_mes     int,
         @w_nombre_tabla_saldos  varchar(50), 
       	 @w_cadena1              varchar(255),
         @w_cadena2              varchar(255),
         @w_cadena3              varchar(255),
         @w_cadena4              varchar(255),
         @w_cadena5              varchar(255),
         @w_cont                 int,
         @w_error                int,
         @w_spid                 int,
         @w_count                int,
         @w_organiz              tinyint,
	 @w_sp_name              varchar(32),  /* Nombre Programa Store Procedure */
	 @w_flag                 char(2)       /* Indica que no hay mas registros */
	 
   select @w_sp_name = 'sp_consulta_pyg_terceros'   
   select @w_spid = @@spid
   select @w_flag = '00'

---/*  Modo de debug  */
   if @t_debug = 'S'
   begin
      exec cobis..sp_begin_debug @t_file = @t_file
      select '/**  Stored Procedure  **/ ' = @w_sp_name,
	     s_ssn                         = @s_ssn,
	     s_user                        = @s_user,
	     s_term                        = @s_term,   
	     s_date                        = @s_date,   
	     t_debug                       = @t_debug,  
	     t_file                        = @t_file,
	     t_from                        = @t_from,
	     t_trn                         = @t_trn,
	     i_operacion		   = @i_operacion,
	     i_modo                        = @i_modo,
    	     i_empresa		           = @i_empresa,
	     i_identif		           = @i_identif,
	     i_ente   		           = @i_ente,
	     i_oficina                     = @i_oficina,
             i_area                        = @i_area,
             i_fecha                       = @i_fecha,
             i_cuenta                      = @i_cuenta,
             i_cuenta_ini                  = @i_cuenta_ini,
             i_llave                       = @i_llave
	exec cobis..sp_end_debug
   end

---/****************************************/
---/* Validacion de Codigos de Transaccion */
---/****************************************/
   if (@t_trn <> 6050 and @i_operacion = 'S') /* Consulta Saldos de PYG */
   begin              
   /* tipo de transaccion no corresponde */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file, 
      @t_from  = @w_sp_name,
      @i_num   = 601077
      return 1 
   end

---/**************************/
---/* Consulta de Saldos PYG */
---/**************************/
   if @i_operacion = 'S'
   begin
      delete cb_saldo_tercero_rep 
       where st_spid = @w_spid
   
   -- selecciona corte fin de mes
      
      select @w_periodo = datepart (yy,@i_fecha)
      select @w_mes     = datepart(mm, @i_fecha) 
      select @w_nombre_tabla_saldos = 'sit_saldo_tercero_' + convert(varchar,@w_periodo)
      select @w_corte = max(co_corte)
        from cob_conta..cb_corte
       where co_empresa  = @i_empresa
         and co_periodo  = @w_periodo
         and co_corte >= 0
         and datepart(mm,co_fecha_fin) = @w_mes
       group by co_periodo
   
    -- print ' verifica la existencia de la tabla sit_saldo_tercero %1!' + @w_nombre_tabla_saldos
   
      select @w_cont = count(0) from cob_sit..sysobjects where name = @w_nombre_tabla_saldos
   
      if @w_cont = 0  -- tabla no existe
      begin
        print 'Tabla no existe cob_sit..%1!' +  @w_nombre_tabla_saldos
        return 1
      end
      
     -- inserta datos en la tabla de trabajo
     
      select @w_cadena1 = 'insert into cb_saldo_tercero_rep (st_spid, st_empresa, st_periodo, st_producto,' +
                          'st_corte, st_cuenta, st_oficina, st_area, st_ente, st_saldo, st_saldo_me,'
      select @w_cadena2 = 'st_mov_debito, st_mov_credito, st_mov_debito_me, st_mov_credito_me, st_num_operaciones,' +
                          'st_saldo_neto_mes, st_saldo_neto_mes_me) select '
      select @w_cadena3 = convert(varchar, @w_spid) + ',' + 'st_empresa, st_periodo, st_producto,' +
                          'st_corte, st_cuenta, st_oficina, st_area, st_ente, st_saldo, st_saldo_me,'
      select @w_cadena4 = 'st_mov_debito, st_mov_credito, st_mov_debito_me, st_mov_credito_me, st_num_operaciones,' +
                          'st_saldo_neto_mes, st_saldo_neto_mes_me  from cob_sit..' + @w_nombre_tabla_saldos +
                          ' where st_periodo = ' + convert(varchar, @w_periodo) +
                          ' and st_corte = ' + convert(varchar, @w_corte)
      select @w_cadena5 = ' and st_ente = '  + convert(varchar, @i_ente)
                          
   /*
      print '@w_cadena1 %1!'+ @w_cadena1
      print '@w_cadena2 %1!'+ @w_cadena2
      print '@w_cadena3 %1!'+ @w_cadena3
      print '@w_cadena4 %1!'+ @w_cadena4
   */
      exec (@w_cadena1 + @w_cadena2 + @w_cadena3 + @w_cadena4 + @w_cadena5)
      
      select @w_error = @@error, @w_count = @@rowcount
      if  @w_error != 0
      begin
         print 'Error  %1!, al crear la tabla de trabajo'+ @w_error
         return 1
      end        
      
      if @w_count = 0
      begin
         if @i_modo = 0
         begin
            print 'No existen Saldos PYG para esta OFICINA,AREA,ENTE,CUENTA y FECHA'
            return 1
         end  
      end      
      
      if @i_modo = 0
      begin
         select @w_organiz = of_organizacion
       	   from cob_conta..cb_oficina
          where of_oficina = @i_oficina
   /*
         print 'MODO  EJEC %1!'+@i_modo
         print 'NIVEL OFIC %1!'+@w_organiz
         print 'FECHA      %1!'+@i_fecha
         print 'OFICINA    %1!'+@i_oficina
         print 'AREA       %1!'+@i_area
         print 'ENTE 	%1!'+@i_ente
         print ''
         print 'SPID 	%1!'+@w_spid
         print 'PERIODO    %1!'+@w_periodo
         print 'CORTE      %1!'+@w_corte
         print 'CUENTA PYG %1!'+@i_cuenta
         print 'CUENTA_INI %1!'+@i_cuenta_ini
   */	
         set rowcount 20
   	       
         select "PERIODO" = st_periodo,
                "CORTE" = st_corte,
                "ENTE" = en_ente,
                "TPO DCTO" = en_tipo_ced,
                "NRO DCTO" = en_ente,
                "CUENTA" = st_cuenta,
                "PROD" = st_producto,
                "OFIC DEST" = st_oficina,
                "AREA DEST" = st_area,
                "SALDO INIC" = st_saldo - st_mov_debito + st_mov_credito,
                "DEBITO" = st_mov_debito,
                "CREDITO" = st_mov_credito,
                "SALDO FINAL" = st_saldo,
                "SALDO INICIAL ME" = st_saldo_me - st_mov_debito_me + st_mov_credito_me,
                "DEBITO ME" = st_mov_debito_me,
                "CREDITO ME" = st_mov_credito_me,
                "SALDO FINAL ME" = st_saldo_me,
                "LLAVE" = right("000000000000000"+convert(varchar,st_cuenta),15) +
                	  right("00000"+convert(varchar,st_producto),5) +
                	  right("00000"+convert(varchar,st_oficina),5)  +
                	  right("00000"+convert(varchar,st_area),5)
           from cb_saldo_tercero_rep a,
     	        cob_conta..cb_cuenta, 
     	        cob_conta..cb_oficina, 
     	        cob_conta..cb_jerarquia,
     	        cobis..cl_ente
          where st_spid = @w_spid
            and cu_empresa = @i_empresa
            and cu_cuenta = st_cuenta
            and je_empresa = @i_empresa  -- NO SE CONSIDERAN MAS CONDICIONES PARA ESTA TABLA
            and je_oficina > 0
            and je_oficina_padre = of_oficina
            and je_nivel > 0
            and of_empresa = @i_empresa
            and of_organizacion = @w_organiz
            and st_periodo = @w_periodo
            and st_corte   = @w_corte
            and st_oficina = je_oficina
            and st_area > 0
            and (st_cuenta between @i_cuenta_ini  and  @i_cuenta_ini  or @i_cuenta_ini is null)
            and st_empresa = @i_empresa
            and st_empresa = je_empresa
            and (of_oficina = @i_oficina or @i_oficina is null)
            and en_ente = st_ente
            and (en_ced_ruc = @i_identif or @i_identif is null)
      	 order by st_periodo,st_corte,st_cuenta,st_producto,st_oficina,st_area
      	 
         set rowcount 0

      end --  modo 0
       
      if @i_modo = 2
      begin
         select @w_organiz = of_organizacion
           from cob_conta..cb_oficina
      	  where of_oficina = @i_oficina
   /*     
         print 'MODO  EJEC %1!'+@i_modo
         print 'NIVEL OFIC %1!'+@w_organiz
         print 'FECHA      %1!'+@i_fecha
         print 'OFICINA    %1!'+@i_oficina
         print 'AREA       %1!'+@i_area
         print 'ENTE 	  %1!'+@i_ente
         print ''
         print 'SPID 	  %1!'+@w_spid
         print 'PERIODO    %1!'+@w_periodo
         print 'CORTE      %1!'+@w_corte
         print 'CUENTA PYG %1!'+@i_cuenta
         print 'CUENTA_INI %1!'+@i_cuenta_ini
   	 print 'LLAVE SGTE %1!'+@i_llave
   */     
   	 set rowcount 20
          
         select "PERIODO" = st_periodo,
                "CORTE" = st_corte,
                "ENTE" = en_ente,
                "TPO DCTO" = en_tipo_ced,
                "NRO DCTO" = en_ente,
                "CUENTA" = st_cuenta,
                "PROD" = st_producto,
                "OFIC DEST" = st_oficina,
                "AREA DEST" = st_area,
                "SALDO INIC" = st_saldo - st_mov_debito + st_mov_credito,
                "DEBITO" = st_mov_debito,
                "CREDITO" = st_mov_credito,
                "SALDO FINAL" = st_saldo,
                "SALDO INICIAL ME" = st_saldo_me - st_mov_debito_me + st_mov_credito_me,
                "DEBITO ME" = st_mov_debito_me,
                "CREDITO ME" = st_mov_credito_me,
                "SALDO FINAL ME" = st_saldo_me,
                "LLAVE" = right("000000000000000"+convert(varchar,st_cuenta),15) +
                 	  right("00000"+convert(varchar,st_producto),5) +
                 	  right("00000"+convert(varchar,st_oficina),5)  +
                          right("00000"+convert(varchar,st_area),5)
           from cb_saldo_tercero_rep a,
     	        cob_conta..cb_cuenta, 
     	        cob_conta..cb_oficina, 
     	        cob_conta..cb_jerarquia,
     	        cobis..cl_ente
      	  where st_spid = @w_spid
            and cu_empresa = @i_empresa
            and cu_cuenta = st_cuenta
            and je_empresa = @i_empresa  -- NO SE CONSIDERAN MAS CONDICIONES PARA ESTA TABLA
            and je_oficina > 0
            and je_oficina_padre = of_oficina
            and je_nivel > 0
            and of_empresa = @i_empresa
            and of_organizacion = @w_organiz
            and st_periodo = @w_periodo
            and st_corte   = @w_corte
            and st_oficina = je_oficina
            and st_empresa = @i_empresa
            and st_empresa = je_empresa
            and en_ente    = st_ente
            and (st_ente    = @i_ente or @i_ente is null)
            and (of_oficina = @i_oficina or @i_oficina is null)
            and (right("000000000000000"+convert(varchar,st_cuenta),15) + 
                 right("00000"+convert(varchar,st_producto),5) +
                 right("00000"+convert(varchar,st_oficina),5)  +
                 right("00000"+convert(varchar,st_area),5)) > @i_llave
      	 order by st_periodo,st_corte,st_cuenta,st_producto,st_oficina,st_area

   	 if @@rowcount = 0
         begin
            if @@error = 0
            begin
   	       print 'No existen mas registros de Saldos PYG para este ENTE'
   	       select @w_flag = '10'
               select @w_flag
            end
         end

         set rowcount 0

      end --  modo 2

      delete cb_saldo_tercero_rep
       where st_spid = @w_spid

   end
end
return 0
go
