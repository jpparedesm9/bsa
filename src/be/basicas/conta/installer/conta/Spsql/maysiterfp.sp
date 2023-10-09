/************************************************************************/
/*	Archivo: 		maysiterfp.sp			        */
/*	Stored procedure: 	sp_maysiterfp				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     					*/
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
/*	   Mayorizacion de Terceros de fin de periodo                   */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_maysiterfp')
	drop proc sp_maysiterfp  
go

create proc sp_maysiterfp (
	@s_ssn		      int = null,
	@s_date		      datetime = null,
	@s_user		      login = null,
	@s_term		      descripcion = null,
	@s_corr		      char(1) = null,
	@s_ssn_corr	      int = null,
    @s_ofi		      tinyint = null,
	@t_rty		      char(1) = null,
    @t_trn		      smallint = null,
	@t_debug	      char(1) = 'N',
	@t_file		      varchar(14) = null,
	@t_from		      varchar(30) = null,
	@i_empresa 	      tinyint = null,
    @i_fecha_tran 	  datetime = null,
	@i_nro_procesos	  int = null,		-- Particiones
    @i_opcion	      tinyint = 1,		-- 0 Genera Rangos, 1 Ejecuta proceso
	@i_proceso	      int = null,
	@i_debug          char(1) = 'N'
)                        
as

declare @w_return     int,
    @w_sp_name        varchar(32), 
    @w_cuenta 	      cuenta,
    @w_oficina 	      smallint,
    @w_area		      smallint,
    @w_fecha_tran 	  datetime,
    @w_credito 	      money,
    @w_debito  	      money,
    @w_credito_me 	  money,
    @w_debito_me	  money,
    @w_valor          money,
    @w_valor_me       money,
    @w_ente           int,
    @w_fecha_min	  datetime,
	-- PARALELISMO
    @w_comp_ini       numeric(10, 0),
    @w_comp_fin       numeric(10, 0),
    @w_comp_int_ini   int,
    @w_comp_int_fin   int,
    @w_total_comp     int,
    @w_contador       int,
    @w_proceso        int,
    @w_msg_error      varchar(150),
    @w_sqlstatus      int,
    @w_COMMIT	      int,
    @w_quiebre	      bit,
    @w_registros	  int,
    @w_maximo    	  int,
    @w_max_ant	      int,
    @_contador	      int,
    @w_filas		  int,
    @w_error		  int,
    @w_secuencial     int,
    @w_fecha          datetime,
    @w_periodo_finmes smallint,
    @w_corte_finmes   smallint,
    @w_fecha_aux      datetime,
    @w_corte_max      smallint,
    @w_fecha_aux1     datetime,
    @w_corte          smallint,
    @w_corte_fp       smallint    


select @w_periodo_finmes = 0
select @w_corte_finmes = 0    

select @w_sp_name = 'sp_maysiterfp',
       @w_COMMIT = 5


select @w_fecha_min = min(co_fecha_fin)
from cob_conta..cb_corte
where co_empresa = @i_empresa
and   co_fecha_ini <= @i_fecha_tran
and   co_estado in ('A','V')
if @@rowcount = 0
begin	/* 'PERIODO O CORTE NO VIGENTE O CERRADO' */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 603023
   return 1
end

-- GENERA PARTICIONES
if @i_opcion = 0
begin

   truncate table cb_tmp_may_ter

   delete cb_procesos_paralelo
   where pp_programa = 'sp_maysiterfp'
   if @@error <> 0
   begin
      select @w_msg_error = 'Error en inicializacion de tabla de procesos paralelos'
      goto ERROR_1
   end

   select * 
   into  #tmp_asientos_ter
   from  cob_conta_tercero..ct_sasiento
   where sa_fecha_tran between @w_fecha_min and @i_fecha_tran
   and   sa_mayorizado = 'N'
   and   sa_ente > 0
   and   sa_ente is not null

   select @w_filas = @@rowcount,
          @w_error = @@error


   if @w_filas = 0
      return 0

   if @w_error <> 0
   begin
      select @w_msg_error = 'Error en generacion de tabla de trabajo para comprobantes por mayorizar'
      goto ERROR_1
   end	        


   insert into cb_tmp_may_ter
   select    
   sa_empresa,	
   1,
   1,
   sa_cuenta, 
   sa_fecha_tran,	
   sa_oficina_dest, 
   sa_area_dest,      
   sum(isnull(sa_debito, 0)), 
   sum(isnull(sa_credito,0)),	
   sum(isnull(sa_debito_me, 0)), 
   sum(isnull(sa_credito_me,0)),	
   sa_ente,
   0,
   0,
   0,
   0
   from cob_conta_tercero..ct_scomprobante,
        #tmp_asientos_ter        
   Where sc_empresa       = @i_empresa
   and   sc_automatico   = 6078
   and   sc_mayorizado    = 'N'
   and   sc_estado        = 'P'
   and   sa_empresa       = sc_empresa
   and   sa_fecha_tran    = sc_fecha_tran
   and   sa_comprobante   = sc_comprobante
   and   sa_fecha_tran    = sc_fecha_tran
   and   sa_producto      = sc_producto
   group by sa_empresa, sa_cuenta, sa_fecha_tran, 
            sa_oficina_dest, sa_area_dest, sa_ente
   order by sa_empresa, sa_cuenta, sa_fecha_tran, 
            sa_oficina_dest, sa_area_dest, sa_ente            

   select @w_filas = @@rowcount,
          @w_error = @@error

   if @w_filas = 0
      return 0

   if @w_error <> 0
   begin
      select @w_msg_error = 'Error en generacion de tabla de trabajo para comprobantes por mayorizar'
      goto ERROR_1
   end	        

   
end  -- GENERA PARTICIONES


-- PROCESA
if @i_opcion = 1
begin

    select 
    distinct co_cuenta, co_fecha_tran 
    into #cta_fecha
    from cob_conta..cb_tmp_may_ter
    order by co_cuenta, co_fecha_tran 

    while 1 = 1
    begin
    
        set rowcount 1
    
        select 
        @w_cuenta = co_cuenta, 
        @w_fecha  = co_fecha_tran 
        from #cta_fecha
        order by co_cuenta, co_fecha_tran 
    
        if @@rowcount = 0
        begin
            set rowcount 0
            break
        end
    
        delete #cta_fecha
        where co_cuenta = @w_cuenta 
        and   co_fecha_tran = @w_fecha
    
        begin tran
    
        set rowcount 0
    
        select @w_periodo_finmes  = co_periodo,
               @w_corte_finmes    = max(co_corte)
        from   cb_corte, cb_periodo
        where  co_empresa  = @i_empresa
        and    co_periodo  = pe_periodo
        and    co_corte >= 0
        and    pe_empresa  = co_empresa
        and    pe_periodo >= 0
        and    @w_fecha between pe_fecha_inicio and pe_fecha_fin
        and    datepart(mm,co_fecha_fin) = datepart(mm,@w_fecha)
        group  by co_periodo
    
        select @w_fecha_aux = co_fecha_ini
        from   cb_corte
        where  co_empresa = @i_empresa
        and    co_periodo = @w_periodo_finmes
        and    co_corte   = @w_corte_finmes

        select @w_corte_finmes = max(co_corte)+ 1
        from cob_conta..cb_corte
        where co_empresa = @i_empresa
        and   co_periodo = @w_periodo_finmes
        and   co_corte >= 0
    
        while 1 = 1
        begin

            update cob_conta_tercero..ct_saldo_tercero
            set st_mov_debito = st_mov_debito  + co_debito,
                st_mov_credito = st_mov_credito + co_credito
            from cob_conta..cb_tmp_may_ter,
                 cob_conta_tercero..ct_saldo_tercero
            where st_corte   = @w_corte_finmes
            and   st_periodo = @w_periodo_finmes
            and   st_cuenta  = @w_cuenta
            and   st_cuenta  = co_cuenta
            and   st_oficina = co_oficina_dest
            and   st_area    = co_area_dest
            and   st_ente    = co_ente
            and   st_empresa = co_empresa
            and   co_fecha_tran = @w_fecha
    
            if @@error <> 0
            begin
                rollback tran
                GOTO SIGUIENTE
            end
    
            update cob_conta_tercero..ct_saldo_tercero
            set st_saldo = st_mov_debito - st_mov_credito
            from cob_conta..cb_tmp_may_ter,
                 cob_conta_tercero..ct_saldo_tercero
            where st_corte   = @w_corte_finmes
            and   st_periodo = @w_periodo_finmes
            and   st_cuenta  = @w_cuenta
            and   st_cuenta  = co_cuenta
            and   st_oficina = co_oficina_dest
            and   st_area    = co_area_dest
            and   st_ente    = co_ente
            and   st_empresa = co_empresa
            and   co_fecha_tran = @w_fecha
    
            if @@error <> 0
            begin
                rollback tran
                GOTO SIGUIENTE
            end
            
            select @w_fecha_aux  = dateadd(dd,1,@w_fecha_aux)
            select @w_fecha_aux1 = @w_fecha_aux
    
            select @w_periodo_finmes  = co_periodo,
                   @w_corte_finmes    = max(co_corte)
            from cb_corte, cb_periodo
            where  co_empresa   = @i_empresa
            and    co_periodo   = pe_periodo
            and    co_corte >= 0
            and    pe_empresa   = co_empresa
            and    @w_fecha_aux between pe_fecha_inicio and pe_fecha_fin
            and    datepart(mm,co_fecha_fin) = datepart(mm,@w_fecha_aux)
            group by co_periodo
    
            select @w_fecha_aux = co_fecha_ini
            from   cb_corte
            where  co_empresa   = @i_empresa
            and    co_periodo   = @w_periodo_finmes
            and    co_corte     = @w_corte_finmes
    
            if exists (select 1 from cb_corte
                       where co_empresa = @i_empresa
                       and   co_periodo >= 0
                       and   co_corte >= 0
                       and   co_fecha_ini between @w_fecha_aux1 and @w_fecha_aux
                       and   (co_estado  = 'V' or co_estado  = 'A' or co_estado  = 'C' ))
            begin
                select @w_corte = @w_corte_finmes
            end
            else
            begin
                set rowcount 0
                break
            end
        end
    
        /*** INSERTA FALTANTES ***/
        set rowcount 0
    
        select @w_periodo_finmes  = co_periodo,
               @w_corte_finmes    = max(co_corte)
        from   cb_corte, cb_periodo
        where  co_empresa  = @i_empresa
        and    co_periodo  = pe_periodo
        and    co_corte >= 0
        and    pe_empresa  = co_empresa
        and    pe_periodo >= 0
        and    @w_fecha between pe_fecha_inicio and pe_fecha_fin
        and    datepart(mm,co_fecha_fin) = datepart(mm,@w_fecha)
        group  by co_periodo
    
        select @w_fecha_aux = co_fecha_ini
        from   cb_corte
        where  co_empresa = @i_empresa
        and    co_periodo = @w_periodo_finmes
        and    co_corte   = @w_corte_finmes
    
        delete cob_conta..cb_tmp_may_ter
        from cob_conta..cb_tmp_may_ter,
             cob_conta_tercero..ct_saldo_tercero
        where st_corte   = @w_corte_finmes
        and   st_periodo = @w_periodo_finmes
        and   st_cuenta  = @w_cuenta
        and   st_cuenta  = co_cuenta
        and   st_oficina = co_oficina_dest
        and   st_area    = co_area_dest
        and   st_ente    = co_ente
        and   st_empresa = co_empresa
        and   co_fecha_tran = @w_fecha
    
        if @@error <> 0
        begin
            rollback tran
            GOTO SIGUIENTE
        end

        select @w_corte_finmes = max(co_corte)+ 1
        from cob_conta..cb_corte
        where co_empresa = @i_empresa
        and   co_periodo = @w_periodo_finmes
        and   co_corte >= 0
    
        while 1 = 1
        begin
        
            insert into cob_conta_tercero..ct_saldo_tercero
            select
                 @i_empresa,
                 @w_periodo_finmes,
                 @w_corte_finmes,
                 @w_cuenta,
                 co_oficina_dest,
                 co_area_dest,
                 co_ente,
                 sum(co_debito-co_credito),
                 sum(co_debito_me-co_credito_me),
                 sum(co_debito),
                 sum(co_credito),
                 sum(co_debito_me),
                 sum(co_credito_me)
            from cob_conta..cb_tmp_may_ter
            where co_fecha_tran = @w_fecha
            and   co_cuenta     = @w_cuenta
            group by co_cuenta, co_oficina_dest, co_area_dest, co_ente

            if @@error <> 0
            begin
                rollback tran
                GOTO SIGUIENTE
            end
            
            select @w_corte_max = max(co_corte)
            from cob_conta..cb_corte
            where co_empresa = @i_empresa
            and   co_periodo = @w_periodo_finmes
            and   co_corte >= 0
    
            if @@error <> 0
            begin
rollback tran
            end
    
            select @w_fecha_aux  = dateadd(dd,1,@w_fecha_aux)
            select @w_fecha_aux1 = @w_fecha_aux
    
            select @w_periodo_finmes  = co_periodo,
                   @w_corte_finmes    = max(co_corte)
            from   cb_corte, cb_periodo
            where  co_empresa   = @i_empresa
            and    co_periodo   = pe_periodo
            and    co_corte >= 0
            and    pe_empresa   = co_empresa
            and    @w_fecha_aux between pe_fecha_inicio and pe_fecha_fin
            and    datepart(mm,co_fecha_fin) = datepart(mm,@w_fecha_aux)
            group by co_periodo
    
            print '#cta_fecha'
    
            select @w_fecha_aux = co_fecha_ini
            from   cb_corte
            where  co_empresa   = @i_empresa
            and    co_periodo   = @w_periodo_finmes
            and    co_corte     = @w_corte_finmes
    
            if exists (select 1 from cb_corte
                       where co_empresa = @i_empresa
                       and   co_periodo >= 0
                       and   co_corte >= 0
                       and   co_fecha_ini between @w_fecha_aux1 and @w_fecha_aux
                       and   (co_estado  = 'V' or co_estado  = 'A' or co_estado  = 'C' ))
            begin
                select @w_corte = @w_corte_finmes
            end
            else
            begin
                set rowcount 0
                break
            end
        end
    
        set rowcount 0
        
        update cob_conta_tercero..ct_sasiento
        set sa_mayorizado = 'S'
        from cob_conta_tercero..ct_sasiento,
             cob_conta_tercero..ct_scomprobante
        Where sa_empresa      = @i_empresa
        and   sa_cuenta       = @w_cuenta
        and   sa_fecha_tran   = @w_fecha
        and   sa_oficina_dest > 0
        and   sa_area_dest    > 0
        and   sa_ente	  > 0
        and   sa_mayorizado   = 'N'
        and   sc_fecha_tran   = sa_fecha_tran
        and   sc_producto     = sa_producto
        and   sc_comprobante  = sa_comprobante
        and   sc_empresa      = sa_empresa
        and   sc_estado       = 'P'
        and   sc_automatico  = 6078
        and   sc_producto    >= 1
        and   sc_comprobante >= 0
        and   sc_empresa      = @i_empresa
    
        if @@error <> 0
        begin
            rollback tran
            GOTO SIGUIENTE
        end
    
        commit tran
    
    end

    truncate table cb_tmp_may_ter
    
    return 0

    SIGUIENTE:
        print 'Error Fecha: , Cuenta: '+ cast(@w_fecha_tran as varchar)+ @w_cuenta
        return 1
end

return 0

ERROR_1:
    print 'Error en insercion en tabla temporal'
    return 1


go