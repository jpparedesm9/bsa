/************************************************************************/
/*  Archivo:                inicorte.sp                                 */
/*  Stored procedure:       sp_inicorte                                 */
/*  Base de datos:          cob_conta                                   */
/*  Producto:               contabilidad                                */
/*  Disenado por:                                                       */
/*  Fecha de escritura:     30-julio-1993                               */
/************************************************************************/
/*                            IMPORTANTE                                */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de la           */
/*  "NCR CORPORATION".                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*                             PROPOSITO                                */
/*  Este programa procesa las transacciones de:                         */
/*     Inicio de corte                                                  */
/*                          MODIFICACIONES                              */
/*  FECHA       AUTOR                   RAZON                           */
/*  30/Jul/1993 G Jaramillo             Emision Inicial                 */
/*  21/Jun/1994 G Jaramillo             Eliminacion de secciones        */
/*  21/Ene/1998 M.Victoria Garay        Saldos Terceros historicos      */
/*  18/Feb/1998 M.Victoria Garay        MVG Considere Festivos          */
/*  27/Sep/2017 J.Salazar               CGS-S115715                     */
/************************************************************************/

use cob_conta
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

if exists(select * from sysobjects where name = 'sp_inicorte')
   drop proc sp_inicorte
go

create proc sp_inicorte  (
    @s_ssn          int          = null,
    @s_date         datetime     = null,
    @s_user         login        = null,
    @s_term         descripcion  = null,
    @s_corr         char(1)      = null,
    @s_ssn_corr     int          = null,
    @s_ofi          smallint     = null,
    @t_rty          char(1)      = null,
    @t_trn          smallint     = null,
    @t_debug        char(1)      = 'N',
    @t_file         varchar(14)  = null,
    @t_from         varchar(30)  = null,
    @i_operacion    char(1)      = null,
    @i_empresa      tinyint      = null
)
as

declare @corte_actual   int,
        @corte_nuevo    int,
        @periodo_actu   int,
        @periodo_nuevo  int,
        @corte_mes      int,
        @periodo_mes    int,
        @flag1          tinyint,
        @w_fecha        datetime,
        @w_sp_name      varchar(32),
        @w_mes          tinyint,
        @w_fin_mes      char(1),
        @w_tipo         char(10),
        @w_dia          tinyint,
        @w_ano          smallint,
        @w_fecha_aux    datetime,
        @w_maxcorte     int,
        @w_corte_max    int,
        @w_corte_fp     int

select @w_sp_name = 'sp_inicorte', @w_fin_mes = 'N'


if (@t_trn <> 6282 and @i_operacion = 'U') 
begin
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 601077
    return 1
end


select @flag1 = 0
while @flag1 = 0
begin
   begin tran
   select
   @corte_actual = co_corte,
   @periodo_actu = co_periodo,
   @w_tipo       = pe_tipo_periodo,
   @w_dia        = datepart(dd,co_fecha_ini),
   @w_mes        = datepart(mm,co_fecha_ini),
   @w_ano        = datepart(yy,co_fecha_ini)
   from cob_conta..cb_corte,cob_conta..cb_periodo
   where    co_empresa = @i_empresa and
            co_periodo = pe_periodo and
            co_corte   >= 0 and
            co_estado  = 'A' and
            pe_empresa = @i_empresa
   
   
   if (@w_dia = 31 and (@w_mes = 1 or @w_mes = 3 or @w_mes = 5 or
       @w_mes = 7 or @w_mes = 8 or @w_mes = 10 or @w_mes = 12))
      select @w_fin_mes = 'S'
   else
   begin
        if (@w_dia = 30 and (@w_mes = 4 or @w_mes = 6 or @w_mes = 9 or
            @w_mes = 11))
          select @w_fin_mes = 'S'
        else
        begin
           if @w_mes = 2
           begin 
              if (@w_ano % 4 = 0) and (@w_dia = 29)
                 select @w_fin_mes = 'S'
              if (@w_ano % 4 <> 0) and (@w_dia = 28)
                 select @w_fin_mes = 'S'
           end
        end
   end
   
   if exists (select 1 from cob_conta..cb_corte
              where co_empresa = @i_empresa and
              co_periodo = @periodo_actu and
              co_corte   = (@corte_actual + 1))
   begin
      select @corte_nuevo = @corte_actual + 1
      select @periodo_nuevo = @periodo_actu
   end
   else
   begin
      select @corte_nuevo = 1
      select @periodo_nuevo = @periodo_actu + 1
   end
   
   update cob_conta..cb_corte set co_estado = 'C'
   where co_empresa = @i_empresa
   and co_periodo = @periodo_actu
   and co_corte   = @corte_actual
   
   if @@error <> 0
   begin    /* 'Error en la actualizacion de Corte' */
      rollback tran
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 605040
      return 605040
   end
   
   update  cob_conta..cb_corte
   set     co_estado  = 'A'
   where   co_empresa = @i_empresa
   and     co_periodo = @periodo_nuevo
   and     co_corte   = @corte_nuevo
   
   if @@error <> 0
   begin    /* 'Error en la actualizacion de Corte' */
      rollback tran
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 605040
      return 605040
   end
   
   insert cob_conta_his..cb_hist_saldo
   select  * from cob_conta..cb_saldo
   where sa_empresa = @i_empresa 
   and   sa_periodo = @periodo_actu
   and   sa_corte   = @corte_actual
   and   sa_oficina >= 0
   and   sa_area    >= 0
   
   if @@error <> 0
   begin    /* 'Error en insercion de registro' */
      rollback tran
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 603059
      return 603059
   end
   
   /* Inicio - Fin de Periodo */
   
   select @w_corte_max = max(co_corte)
   from cob_conta..cb_corte
   where co_empresa = @i_empresa
   and   co_periodo = @periodo_actu
   and   co_corte >= 0
   
   if @w_corte_max = @corte_actual
   begin
      select @w_corte_fp = @w_corte_max + 1
      
      insert cob_conta_his..cb_hist_saldo
      select sa_empresa,sa_cuenta,sa_oficina,sa_area,@w_corte_fp,
      sa_periodo,sa_saldo,sa_saldo_me,sa_debito,sa_credito,
      sa_debito_me,sa_credito_me
      from cob_conta..cb_saldo 
      where sa_empresa = @i_empresa
      and   sa_periodo = @periodo_actu
      and   sa_corte   = @corte_actual
      and   sa_oficina >= 0
      and   sa_area    >= 0
   
      if @@error <> 0
      begin /* 'Error en insercion de registro' */
         rollback tran
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 603059
         return 603059
      end
   end
   /* Fin - Fin de Periodo */
   
   update cb_saldo  set sa_periodo = @periodo_nuevo, sa_corte = @corte_nuevo
   where sa_empresa = @i_empresa
   
   if @@error <> 0
   begin    /* 'Error en actualizacion de Registro' */
      rollback tran
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 601162
      return 601162
   end
   
   if @w_tipo = 'D'
   begin
      if    @w_fin_mes = 'S'
      begin
         select @w_fecha_aux = co_fecha_ini
         from   cob_conta..cb_corte 
         where  co_empresa = @i_empresa
         and    co_periodo = @periodo_nuevo
         and    co_corte   = @corte_nuevo
         
         select @w_maxcorte = max(co_corte)
         from  cb_corte,cb_periodo
         where co_empresa = @i_empresa
         and   co_periodo = pe_periodo
         and   co_corte   >= 0
         and   pe_empresa = co_empresa
         and   @w_fecha_aux between pe_fecha_inicio and pe_fecha_fin
         and   datepart(mm,co_fecha_fin) = datepart(mm,@w_fecha_aux)
         
         insert cob_conta_tercero..ct_saldo_tercero
         select  
         st_empresa,@periodo_nuevo,@w_maxcorte,st_cuenta,st_oficina,
         st_area,st_ente,st_saldo,st_saldo_me,st_mov_debito,
         st_mov_credito,st_mov_debito_me,st_mov_credito_me
         from    cob_conta_tercero..ct_saldo_tercero
         where   st_empresa = @i_empresa
         and     st_periodo = @periodo_actu
         and     st_corte   = @corte_actual
         and     st_saldo  <> 0
   
         if @@error <> 0
         begin  /* 'Error en insercion de registro' */
            rollback tran
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 603059
            return 603059
         end
   
   
         /* Inicio - Fin de Periodo */
         select @w_corte_max = max(co_corte)
         from cob_conta..cb_corte
         where co_empresa = @i_empresa
         and   co_periodo = @periodo_actu
         and   co_corte   >= 0
         
         if @w_corte_max = @w_maxcorte
         begin
            select @w_corte_fp = @w_corte_max + 1
         
            insert cob_conta_tercero..ct_saldo_tercero
            select  
            st_empresa,@periodo_nuevo,@w_corte_fp,st_cuenta,st_oficina,
            st_area,st_ente,st_saldo,st_saldo_me,st_mov_debito,
            st_mov_credito,st_mov_debito_me,st_mov_credito_me
            from    cob_conta_tercero..ct_saldo_tercero
            where   st_empresa = @i_empresa 
            and     st_periodo = @periodo_actu
            and     st_corte   = @corte_actual
            and     st_saldo <> 0
            
            if @@error <> 0
            begin   /* 'Error en insercion de registro' */
               rollback tran
               exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 603059
               return 603059
            end
         end
         /* Fin - Fin de Periodo */
         
         select @w_fin_mes = 'N'
      end
   
      select @w_fecha = co_fecha_ini
      from cob_conta..cb_corte
      where co_empresa = @i_empresa
      and   co_periodo >= 0
      and   co_corte   >= 0
      and   co_estado  = 'A'
   
      if exists (select 1 from cobis..cl_dias_feriados
                 where df_fecha = @w_fecha
                 and  df_ciudad in
                 (select pa_smallint from cobis..cl_parametro
                  where pa_producto = 'ADM'
                  and   pa_nemonico = 'CFN')) and datepart(dd, @w_fecha) <> 1
         select @flag1 = 0
            else
         select @flag1 = 1
   end
   commit tran      
end

return 0
go
