/************************************************************************/
/*   Stored procedure:     sp_mayter_tmp                                */
/*   Base de datos:        cob_conta                                    */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                            PROPOSITO                                 */
/************************************************************************/
 
use cob_conta
go
 
if exists (select 1 from sysobjects where name = 'sp_mayter_tmp')
   drop proc sp_mayter_tmp
go
 
create proc sp_mayter_tmp (
    @i_param1         varchar(1)  = null,
    @i_param2         varchar(10) = null,
    @i_param3         varchar(3)  = 0,    
    @i_param4         varchar(1)  = 'N'
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
    @w_corte_fp       smallint, 
    @i_empresa 	      tinyint,
    @i_fecha_tran     datetime,
    @i_opcion	      tinyint,		
    @i_debug          char(1)

select @i_empresa    = convert(tinyint, @i_param1)
select @i_fecha_tran = convert(datetime, @i_param2)
select @i_opcion     = convert (tinyint, @i_param3)
select @i_debug      = convert(char(1), @i_param4)

drop table cob_conta_tercero..ct_asiento_may

create table cob_conta_tercero..ct_asiento_may
(
   sa_empresa       tinyint,
   sa_cuenta        cuenta_contable,
   sa_comprobante   int,
   sa_ente          int, 
   sa_fecha_tran    datetime, 
   sa_mayorizado    char(1), 
   sa_producto      smallint, 
   sa_asiento       int, 
   sa_oficina_dest  smallint, 
   sa_area_dest     smallint,
   sa_debito        money,
   sa_credito       money,
   sa_debito_me     money,
   sa_credito_me    money
)

select @w_periodo_finmes = 0
select @w_corte_finmes = 0    

select @w_sp_name = 'sp_maysiter',
       @w_COMMIT = 5

if @i_opcion = 0 -- GENERA TABLA TEMPORAL
begin

   truncate table cb_tmp_may_ter
   
   insert into cob_conta_tercero..ct_asiento_may
   select 
   sa_empresa, 
   sa_cuenta,
   sa_comprobante,
   sa_ente, 
   sa_fecha_tran, 
   sa_mayorizado, 
   sa_producto, 
   sa_asiento, 
   sa_oficina_dest, 
   sa_area_dest,
   sa_debito,
   sa_credito,
   sa_debito_me,
   sa_credito_me
   from cob_conta_tercero..ct_sasiento (nolock)
   Where sa_ente > 0
   and   sa_ente is not null
   and   sa_cuenta in (select cp_cuenta from cob_conta..cb_cuenta_proceso
                       where cp_proceso in (6003,6095))
   and   sa_oficina_dest > 0
   and   sa_fecha_tran = @i_fecha_tran
   and   sa_mayorizado = 'N'
   
   truncate table cb_tmp_may_ter

   insert into cb_tmp_may_ter
   select 
   sa_empresa,	  
   sa_cuenta, 
   sa_fecha_tran,   
   sa_oficina_dest, 
   sa_area_dest,      
   sum(isnull(sa_debito, 0)), 
   sum(isnull(sa_credito,0)),	
   sum(isnull(sa_debito_me, 0)), 
   sum(isnull(sa_credito_me,0)),	
   sa_ente
   from cob_conta_tercero..ct_scomprobante (nolock),
        cob_conta_tercero..ct_asiento_may (nolock)
   Where sc_empresa       = 1
   and   (sc_automatico   <> 6078 or sc_automatico is null)
   and   sc_mayorizado    = 'N'
   and   sc_estado        = 'P'
   and   sa_empresa       = sc_empresa
   and   sa_fecha_tran    = sc_fecha_tran
   and   sa_comprobante   = sc_comprobante
   and   sa_fecha_tran    = sc_fecha_tran
   and   sa_producto      = sc_producto
   and   sa_comprobante   > 0
   and   sa_fecha_tran    = @i_fecha_tran
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

   create nonclustered index idx_asmay on cob_conta_tercero..ct_asiento_may (sa_comprobante, sa_fecha_tran, sa_producto, sa_asiento)   
   
-- PROCESA

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
    
        while 1 = 1
        begin

            update cob_conta_tercero..ct_saldo_tercero
            set st_mov_debito = st_mov_debito  + co_debito,
                st_mov_credito = st_mov_credito + co_credito,
                st_mov_debito_me = st_mov_debito_me  + co_debito_me,
                st_mov_credito_me = st_mov_credito_me + co_credito_me
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
            set st_saldo = st_mov_debito - st_mov_credito,
                st_saldo_me = st_mov_debito_me - st_mov_credito_me
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
            
            select @w_corte_max = max(co_corte)
            from cob_conta..cb_corte
            where co_empresa = @i_empresa
            and   co_periodo = @w_periodo_finmes
            and   co_corte >= 0

            if @w_corte_max = @w_corte_finmes
            begin
                select @w_corte_fp = @w_corte_max + 1
    
                update cob_conta_tercero..ct_saldo_tercero
                set st_mov_debito = st_mov_debito  + co_debito,
                    st_mov_credito = st_mov_credito + co_credito,
                    st_mov_debito_me = st_mov_debito_me  + co_debito_me,
                    st_mov_credito_me = st_mov_credito_me + co_credito_me
                from cob_conta..cb_tmp_may_ter,
                     cob_conta_tercero..ct_saldo_tercero
                where st_corte   = @w_corte_fp
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
                set st_saldo = st_mov_debito - st_mov_credito,
                    st_saldo_me = st_mov_debito_me - st_mov_credito_me
                from cob_conta..cb_tmp_may_ter,
                     cob_conta_tercero..ct_saldo_tercero
                where st_corte   = @w_corte_fp
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
    
        while 1 = 1
        begin
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
          group by co_oficina_dest, co_area_dest, co_ente

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
    
            if @w_corte_max = @w_corte_finmes
            begin
                select @w_corte_fp = @w_corte_max + 1
   
                insert into cob_conta_tercero..ct_saldo_tercero
                select
                   @i_empresa,
                   @w_periodo_finmes,
                   @w_corte_fp,
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
                group by co_oficina_dest, co_area_dest, co_ente
  
                if @@error <> 0
                begin
                    rollback tran
                    GOTO SIGUIENTE
                end
    
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
            print @w_fecha
    
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
        and   (sc_automatico   <> 6078 or sc_automatico is null)
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
        print 'Error Fecha: , Cuenta: '+ cast(@w_fecha as varchar)+ @w_cuenta
        print 'Error Corte: '+ cast(@w_corte_finmes as varchar)
        print 'Error Corte_fp: '+ cast(@w_corte_fp as varchar)
        return 1
end

return 0

ERROR_1:
    print 'Error en insercion en tabla temporal'
    return 1

go
 
